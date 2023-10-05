Return-Path: <netdev+bounces-38332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AB17BA6FA
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D8D5FB20985
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66990374C1;
	Thu,  5 Oct 2023 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRHuwt1W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAA34CFD
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F46C433C8;
	Thu,  5 Oct 2023 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696524262;
	bh=mK/SNXCOe8N+XAarC6tZtnfOgjStW1fvXDMBaMxfJQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZRHuwt1WdMrORRlFmhmDt9j/0/po7jJOFwurVcNILq3hUsOLteIjKuR2a9nw4usuT
	 qD8H4/cUTBU1arQNV1qp6FXe1wHkZQ1+NPfCmLT+s3OlQBJoTa4WTVRBNkf8vesknV
	 2WZtCCkaG3o6+f8hWEzgnurvUK+XN9WQgiiJCq6QMj3iraTR/AWEbrYjklsk8u/PU0
	 B+WZ56dolOKWlFOpDBH9VQZPqWcClCJOHvsjxOD1k+UKwzKbJ6eOrBp1gKWuWVXejk
	 rIfZtUzv6j7qn8sxctnHkpnsOyjX0MxAIOrnsnwvKu3LZGgsW5hsKz1U3nudoXllRu
	 0QvoHmm43+7AQ==
Date: Thu, 5 Oct 2023 09:44:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Sili Luo <rootlab@huawei.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/7] can: j1939: Fix UAF in j1939_sk_match_filter
 during setsockopt(SO_J1939_FILTER)
Message-ID: <20231005094421.09a6a58f@kernel.org>
In-Reply-To: <20231005094639.387019-2-mkl@pengutronix.de>
References: <20231005094639.387019-1-mkl@pengutronix.de>
	<20231005094639.387019-2-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Oct 2023 11:46:33 +0200 Marc Kleine-Budde wrote:
> Lock jsk->sk to prevent UAF when setsockopt(..., SO_J1939_FILTER, ...)
> modifies jsk->filters while receiving packets.

Doesn't it potentially introduce sleep in atomic?

j1939_sk_recv_match()
  spin_lock_bh(&priv->j1939_socks_lock);
  j1939_sk_recv_match_one()
    j1939_sk_match_filter()
      lock_sock()
        sleep

