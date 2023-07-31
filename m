Return-Path: <netdev+bounces-22928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD4776A0C2
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16441C20C8E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BEF1DDC6;
	Mon, 31 Jul 2023 19:03:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C80657
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1120C433C7;
	Mon, 31 Jul 2023 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690830208;
	bh=R0zigmPhGsigjTWmPKthafBHADUHNkDLel4KNYi7aMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZHBqddGTrYKJA4TC/9yeOXoiE0L7sFcEs3enH+JuXeq8SUXFVvs0zAwUJrmFRgl5y
	 v48MaV2JVF3RC07Jln2Fj/oCAJNvJsbi2NstloDneHjjPVUjHS1MFESFsE2rAdFhPb
	 9UNCtYho3pntwgoRtB3qCjAaRoSLkIvXSAv8b5CYSOIozbPbGFII44c2Pyp3tl3gwa
	 8p4qkAkEyrJKnm1TN+U1iwiygmMJWk+U4nc2LICyQ7r83oirWNIChXwa8wWKpPP91s
	 TOWfszb+TjpipTm8sxiRI2zedW56KwJya4WlwYgA22Nbpo7dT0LMIxfWea+4GNiJaY
	 Zvena216695VA==
Date: Mon, 31 Jul 2023 12:03:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 fw@strlen.de, yang.lee@linux.alibaba.com, jgg@ziepe.ca,
 markzhang@nvidia.com, phaddad@nvidia.com, yuancan@huawei.com,
 ohartoov@nvidia.com, chenzhongjin@huawei.com, aharonl@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230731120326.6bdd5bf9@kernel.org>
In-Reply-To: <20230731121247.3972783-1-linma@zju.edu.cn>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 20:12:47 +0800 Lin Ma wrote:
> In short, the very direct idea to fix such lengh-check-forgotten bug is
> add nla_len() checks like
> 
>   if (nla_len(nla) < SOME_LEN)
>     return -EINVAL;
> 
> However, this is tedious and just like Leon said: add another layer of
> cabal knowledge. The better solution should leverage the nla_policy and
> discard nlattr whose length is invalid when doing parsing. That is, we
> should defined a nested_policy for the X above like

Hard no. Putting array index into attr type is an advanced case and the
parsing code has to be able to deal with low level netlink details.
Higher level API should remove the nla_for_each_nested() completely
which is rather hard to achieve here.

Nacked-by: Jakub Kicinski <kuba@kernel.org>

