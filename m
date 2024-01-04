Return-Path: <netdev+bounces-61711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED174824B32
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 23:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C579285D5E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 22:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C92CCBC;
	Thu,  4 Jan 2024 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bogkQy36"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0412D022
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 22:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE98C433C8;
	Thu,  4 Jan 2024 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704408642;
	bh=0C6dhE6pZaetUWi3FI43mo44ajzbBNT5NOjxqbpPZGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bogkQy369jWaos11DPwHg3QLo6zUNS6RX7f55Dc0RZ3iTyKXHgS32Rb8TJzcL0J+c
	 Fn34oOExsgROgabQh++2uCcj83EwAjulgs5rvSBlxP/iGbj9S3NGEPBrJ3TH28HCTy
	 CnPooj67l25j+USNR4hSnOpHS6q0sCop/Icd/7HQxcO3DtM4OVeE5Q26QFp5g1A0Be
	 jL3Kd+PPb+wAT40AIrdHS5YvZPy1m1OYaoI6K9lnDv1KfPO+HkQk8UkrpRlmXZ/UhN
	 Ffz4TdQR9dBMqSPgT9e8RNaPtjdGXrLvxuHUTBPQdaeIcU8k1B0UZdoIpjpVljtZSV
	 brHU3DjNRonRA==
Date: Thu, 4 Jan 2024 14:50:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [net-next 10/15] net/mlx5e: Let channels be SD-aware
Message-ID: <20240104145041.67475695@kernel.org>
In-Reply-To: <20231221005721.186607-11-saeed@kernel.org>
References: <20231221005721.186607-1-saeed@kernel.org>
	<20231221005721.186607-11-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 16:57:16 -0800 Saeed Mahameed wrote:
> Example for 2 mdevs and 6 channels:
> +-------+---------+
> | ch ix | mdev ix |
> +-------+---------+
> |   0   |    0    |
> |   1   |    1    |
> |   2   |    0    |
> |   3   |    1    |
> |   4   |    0    |
> |   5   |    1    |
> +-------+---------+

Meaning Rx queue 0 goes to PF 0, Rx queue 1 goes to PF 1, etc.?
Is the user then expected to magic pixie dust the XPS or some such
to get to the right queue?

How is this going to get represented in the recently merged Netlink
queue API?

