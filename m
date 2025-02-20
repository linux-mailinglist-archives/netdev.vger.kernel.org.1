Return-Path: <netdev+bounces-168172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6338AA3DDFD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 16:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8FC161901
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C721D5CFB;
	Thu, 20 Feb 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="DmQXUsci";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZ65He5i"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B111D5CF5
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064284; cv=none; b=SB21mlt6ZpCWfV6eVRY/HNSamxlXW3UgdfbR0JFU7ONTBSd+z5tj2Xq391cMNNxEXAPX5ww8B0mSUWkoX7kG450myPTL66wBQ7Az2stAew5xC+GOtFaKdXIIuYQit0AEjYg54cF94vKVZ7s1boqP3u6hTls//nY2SQCKQkwW6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064284; c=relaxed/simple;
	bh=36DUfAGX4mYkuwLzrJcMvXmcxN7jhGufSNcdNOkcg5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8G12cIAGA+IQGMeQJINBTc8/9pQ5tUJspb4eOP2cqeDpYj8SFQsoGetvAjEUoRrt2vwXJrFdoJ+M/VOLJrqf3fSCiyAyCrI5h0nGhkeFFWHDwFpoCo8+ULFxXZUm2J8iA476P3WUTtEv8nQMNxUJA/FpnrJrT1sTPwhi0wnyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=DmQXUsci; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZ65He5i; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 91D93138099E;
	Thu, 20 Feb 2025 10:11:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 20 Feb 2025 10:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1740064279; x=
	1740150679; bh=HsNJEX6jsVVje8h9BxFjl93Lrp1QuisRWr/I1leT84M=; b=D
	mQXUsciiH5/IgCoMqr3ghZg3mDPbsdDhZ7Xb6uDZsG+quL0iwEKAOC4Lwvo5X7l0
	seuMEnMc6xQckFzW/etkOX0mEK0HvHwZ8banLgdp1wBRMAMhoawtv9eoh9MmjC9Q
	Y+IQarShdEP0AF/w1UOf6rAnd0LAEQVZv6c+8jCO8h8H4CYgUQJfncjRAssOMmOK
	CoPr0qiYLltDg1BEz8whmZh6CSWseXuvCcQXYeNQwivksAzJq/I+8jFNvWeGMDsA
	f4DPnfOvSmILn79zdVQyn3N6joidlDw/yZ1K4Xq8BiJIEYW0+wo7yhLDDSmcJP46
	qyExYACmbvVcHRitgLY8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740064279; x=1740150679; bh=HsNJEX6jsVVje8h9BxFjl93Lrp1QuisRWr/
	I1leT84M=; b=hZ65He5i0iaL+VD2/NCuTi/lU6NFMRQ+2Z1p6U36B5Yo8m64Grc
	lygMLRIXKR7baQaErAC0STokWJ7WritzR+5fOaJt5l+7aq4UjEuPi/P7ieklWYO1
	YV4rNSf61n5DJqyr/frf7KEfhW4BT4sWQIajjWW9sWqK5oplhOoEVOqTaHch/lX+
	vdWz2yCYPYTlIZWquvAuBV3U1Snv+3FhLEdScJA/x3gUkLvHqxYBwxMuYWGFC4To
	aCRPbpAQzJMGECvie03UohshTsxO0uur4tHjHvmcrymlqa1JdJ6fkmZ0fUbwQFgw
	x4SO4p8qAaYG8ZLBg5MPRsvtnFZBb7QW/Zg==
X-ME-Sender: <xms:Fka3Z3a7cSXI4T1sNoQsUksUqnBkYCJLE6jlPUfNmrv_sPG198hrFg>
    <xme:Fka3Z2bxloxGp1P0tQ7ORTlDxxZipqs2Q87sT0prBf3_rdE_u1TnjQ5T8HI5LjLQo
    oNIXP5XGTalr_STbsk>
X-ME-Received: <xmr:Fka3Z5_Ejm6aD_DV9DRV4_Dy03au8liP5tfZ75N-C8rHZBx5hqPGhM48lqou>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnh
    grihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefh
    keegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgs
    pghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgufhesfh
    homhhitghhvghvrdhmvgdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtg
    hpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgs
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehsrggvvggusehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Fka3Z9r958C5_Ua8bN5FFqUesaCpntwkd2IZG7VJErLp3soN5BO6KQ>
    <xmx:Fka3Zyq2FN5kLANV7N2vJAzBmzM991ptsAc7e7owev1OXJDe2wf64A>
    <xmx:Fka3ZzToGQaPNdnqK6NOPTR1u4SJM9qxwlJ52N2WojMYBm_yhvB92g>
    <xmx:Fka3Z6onNHq8AAKPtPW1zdzgjBxseARwcVY6cjaYI5keW3D66NUqrQ>
    <xmx:F0a3ZyKh13QrAYRCGzQ3NIJkw7d_iqXyiFSvtnaOj0NaYrWQuiD_X19P>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 10:11:18 -0500 (EST)
Date: Thu, 20 Feb 2025 16:11:16 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v5 03/12] net: hold netdev instance lock during
 queue operations
Message-ID: <Z7dGFLSom9mnWFdB@hog>
References: <20250219202719.957100-1-sdf@fomichev.me>
 <20250219202719.957100-4-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219202719.957100-4-sdf@fomichev.me>

2025-02-19, 12:27:10 -0800, Stanislav Fomichev wrote:
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 533e659b15b3..cf9bd08d04b2 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1886,7 +1886,7 @@ static void gve_turndown(struct gve_priv *priv)
>  			netif_queue_set_napi(priv->dev, idx,
>  					     NETDEV_QUEUE_TYPE_TX, NULL);
>  
> -		napi_disable(&block->napi);
> +		napi_disable_locked(&block->napi);

I don't think all the codepaths that can lead to gve_turndown have the
required netdev_lock():

gve_resume -> gve_reset_recovery -> gve_turndown
gve_user_reset -> gve_reset -> gve_reset_recovery


(and nit:) There's also a few places in the series (bnxt, ethtool
calling __netdev_update_features) where the lockdep
annotation/_locked() variant gets introduced before the patch adding
the corresponding lock.

-- 
Sabrina

