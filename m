Return-Path: <netdev+bounces-63280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F2882C1F0
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA9F1F24E6A
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB666D1C0;
	Fri, 12 Jan 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6NTmIgT"
X-Original-To: netdev@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42564CC7
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E305F5C0240;
	Fri, 12 Jan 2024 09:36:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 12 Jan 2024 09:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705070164; x=1705156564; bh=R1xxj0mBfGtNHnvL8R7Nv32xYsAL
	hrTgguhpSFMWU4w=; b=X6NTmIgTvx4BAEohtbP5sanzsDdIhTEsuT3uRSCmdLU2
	PRc7Jlyll2HLdwchFeJ65E3ZBkCTOBsFFe7BvWOF7QFDs/Vn3pPgDXAcr9YsLZpK
	yHIXy9T4FouHJBcttWDMotGKti7xVKOREye4trIIsiS3JWPjU7SBYOKL+ql/E+1b
	ezhtNZdMp0kaPqLRVwRBxda74oMIHAbpLUiv7s71OKXl+tqqwa+DAigSvdVKyrur
	KcCbT1ZUfsydneDFMLu2B9JNlmODZ5IgDqr4LOmb0W9F5d+CTtOT4Yb2mi8o97XR
	+mAAaE69+55AmQAGy/EYDttNUihVhVgSXMNhJbhxaw==
X-ME-Sender: <xms:VE6hZT-eaD77_Citindsi6wIud3uMuOQ_sij26sqNbK_QY5mcFXJMw>
    <xme:VE6hZfsWwlxA2C6EhPqsWoDACXvnI0EjzV5sICVtoTZk1LImHhcIyvs637OBMCILN
    hrU1p98aJO7KrM>
X-ME-Received: <xmr:VE6hZRCjDbBwHWQbcckTlsuDbfHjG9ec4EBXNmArKuJHFZOMAjXQJqtJ1EXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:VE6hZfc58q2wS8dCfslfrZ1xY24P8TdNMazJwGzTa_4X1G2UxPsQ2Q>
    <xmx:VE6hZYNcLo7Bc6NtIL7YI6jGHg7AVZf-zjqsm9OfUfQmgC8hpF-x9g>
    <xmx:VE6hZRmyhZQO0rAC-IZNeW3nSp4FSZ_sLEkEkNCwKC3zitGWo1HGUQ>
    <xmx:VE6hZZEVQRLy_24W0jgzIeEZEqn7PDgPniELtozunXzYVaQDUjJ0wA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jan 2024 09:36:03 -0500 (EST)
Date: Fri, 12 Jan 2024 16:36:01 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, victor@mojatatu.com,
	pctammela@mojatatu.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com
Subject: Re: [patch net] net: sched: track device in tcf_block_get/put_ext()
 only for clsact binder types
Message-ID: <ZaFOUSyEJ5hYZfzn@shredder>
References: <20240112113930.1647666-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112113930.1647666-1-jiri@resnulli.us>

On Fri, Jan 12, 2024 at 12:39:30PM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Clsact/ingress qdisc is not the only one using shared block,
> red is also using it. The device tracking was originally introduced
> by commit 913b47d3424e ("net/sched: Introduce tc block netdev
> tracking infra") for clsact/ingress only. Commit 94e2557d086a ("net:
> sched: move block device tracking into tcf_block_get/put_ext()")
> mistakenly enabled that for red as well.
> 
> Fix that by adding a check for the binder type being clsact when adding
> device to the block->ports xarray.
> 
> Reported-by: Ido Schimmel <idosch@idosch.org>
> Closes: https://lore.kernel.org/all/ZZ6JE0odnu1lLPtu@shredder/
> Fixes: 94e2557d086a ("net: sched: move block device tracking into tcf_block_get/put_ext()")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Tested-by: Ido Schimmel <idosch@nvidia.com>

