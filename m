Return-Path: <netdev+bounces-127029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C20973B28
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338A71F257C9
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8846F199FD7;
	Tue, 10 Sep 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsKko05/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F22199945;
	Tue, 10 Sep 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981083; cv=none; b=L1/glvm6BxKxXFih8RvVsEiHWbnhFnzXZEyFbnmtWV2h9uK6pcLvldnioCfJjX6kFvV5yrj3xrBRdDYYWoigkEAE5Ei8vTaO3C66CQRdpKpEHLmVQzx51JhlI6gD2ORvoXZ4Iwd26/7/WBaWwZjhWJEdJU6ugn1HG21NEpf01JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981083; c=relaxed/simple;
	bh=pzfMBiPJzMBq2MspukyE1LiOnDc8PjCOTlEJ0Ij33Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsLiablM7F7yQIj1ArCIOg4QhtVXJFw6j5VVALbAIYaSI88n5PudNaOcIEACQQN9UBsyxfvo1t7fQkDV2ZwM3QmrGjlCXOLYcn7vgfGO8TC7mxku+rw9MJZbHFSLz7cZj9Nvx5sq5608StuTGazApRiY/MlZ1h1+yZ3hOLlnUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsKko05/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5D6C4CEC3;
	Tue, 10 Sep 2024 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725981082;
	bh=pzfMBiPJzMBq2MspukyE1LiOnDc8PjCOTlEJ0Ij33Fg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SsKko05/4S3vs2ft/nVviPDYTjkMaf1uVTpPiKcR8SeYh3pDG+C+FukO8fz2bj+2C
	 zcYUvU8xulNPJC6rAdGc0vYRgB6UVW4NSRX5bVhWtWWiFg0x4uC8p1Kn6H5/70dbew
	 djwMwmU0U393m+ArUE2mtmiitb1mgWZECFHgdD/8x/jXax/H6/8sAP3eaO7GH/hfyU
	 R5JZwI3xSb4IcjeCCMDz54TAYmWr9fJBc1UlU0TQd/OUcGgx8rifiZPuLpVA8liB9Z
	 wdeYg4kixPNouyKt+/q4mKXuC2aHOx+eP+HZW7V8J/fUf32LpPPrU1p6j2n4hbj94s
	 6pC9mQtjTDB7Q==
Date: Tue, 10 Sep 2024 08:11:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next v18 00/14] Replace page_frag with
 page_frag_cache for sk_page_frag()
Message-ID: <20240910081121.219fca92@kernel.org>
In-Reply-To: <20240906073646.2930809-1-linyunsheng@huawei.com>
References: <20240906073646.2930809-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Sep 2024 15:36:32 +0800 Yunsheng Lin wrote:
> V18:
>    1. Fix a typo in test_page_frag.sh pointed out by Alexander.
>    2. Move some inline helper into c file, use ternary operator and
>       move the getting of the size as suggested by Alexander.

Looks like we're still missing Acks / Reviews and there are outstanding
questions. Let's defer applying to the next release cycle (if at all).
Please do not repost this week, we're flooded by patches.
-- 
pw-bot: defer

