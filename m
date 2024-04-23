Return-Path: <netdev+bounces-90484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA68AE3D4
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B942862F3
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC3E824B1;
	Tue, 23 Apr 2024 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MV2wbpvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D664823D9
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871541; cv=none; b=XY8XypMZCMETMnMPW3y9ezo6nYMisChb28Nx5Wr/gzWqEVP3YHtIYHMnUIlE7GptCSexFsWfg8iq/erejecPl85O7U/LpKKhghVly17IomTcBzlOHakcMj1IcD7aBf3J5VjPLRMzDLOAV1Dh0UJ0DqxD02JBgMu96TS2LKh2pBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871541; c=relaxed/simple;
	bh=VAcdGIy7Oln1UHMYMDobj5Cf8rk5YQOWthSHpT7ajDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSCVsItQtfssK4VTJC/C8p++UJ2WduEDq3AUKFkjq4sJj+582EWINFW86nkltRZ/7c1NyBwVauhcg/xz0TdqP6O/0TA7tyFVWf+/YKqvJKDjkEk2x4ZfDtHXuDExMNZ+PJbd9dCHrD/7zQesopittkZ/y8upuE2aYb/XhWJdO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MV2wbpvW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41aa45251eeso8453765e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713871536; x=1714476336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ts58eJPkRZYjhq39UoouhPsCYC7AlO1jJHeikqMxks=;
        b=MV2wbpvW2dPhPjoNnxGpYxytIWuQDN+YdtMJuQ7OaD/V0HmN2G+AvyAzcZnt80pOwT
         4HTgDhcA0W/lM+LCm/2RwD1SvRuCxUNzmriysHxJSKXxRNimgyQsZ7mXZ91tPJdZ4dnq
         LJFs8B6X2I8VOjeNzXiQPb2bOMGguWPAJ/yJn5+WI5iHKaxCFCcHxI6MscCoaWsdg903
         1lkH9V7qLYG9NuCXGMIWtvLeLY5v1x9Jh4paCp7ooFrLAitR9f/XcYI70oOkXWCgKiPY
         wGmXCWO8sfDxLoumUGaVptBaepkrTrsiRAfG3QTyOHa/YxTf4W7s8MKBOhGdQCqRrLR7
         KAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871536; x=1714476336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ts58eJPkRZYjhq39UoouhPsCYC7AlO1jJHeikqMxks=;
        b=P03MjYgV8CfhR5+HJzWtgRPvROXi0yZharhCZq1onmKzzyYEqCzUJ1ei+T6bpEoeG4
         70B60u4wqBGETxV7715b6ZUzAtkBx43KzJ/q+OOvhMnGkpdpxAEIiq2ZO8RzHeeJtzex
         5os+BHMLvYkTOMx0vztItrgm4zhGkLBKFEaY055UqEXE0nn/ryTRcHtnmMx+mBh+oru4
         MxDzuXVO8WFTvLi8axYDuB5DSZU/1peDHkD4HLVLzHl8PbvJy4EtUi4/UOe5uF9X+cjT
         BbVdUI835YMpHeszs0CKGDpN2clXwwNAxILuKVm4bBk1XNwixwwyJYBnJlyaDMFXYQWy
         OWnw==
X-Gm-Message-State: AOJu0Ywg2DdJTDEFqa3fmFAQeUcBDaVesc/5WZcuSGctl5yLH7730XDl
	60vnd34vZLntUQYiEkbL+pSYiZhhop7RYpUvUmlwve89hFpTDdR8V+p/Dpt5UVM=
X-Google-Smtp-Source: AGHT+IHQ1tYaLYnkO0fKXpSIZbIQT7LVBosA4FsZ2oaaHc91RjU3SM1QOSDmXbn3CNE0uLouTvVptg==
X-Received: by 2002:a05:600c:3153:b0:41a:7c99:cb40 with SMTP id h19-20020a05600c315300b0041a7c99cb40mr3056734wmo.15.1713871536488;
        Tue, 23 Apr 2024 04:25:36 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b00417e8be070csm19980017wms.9.2024.04.23.04.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:25:35 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:25:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] igb: cope with large MAX_SKB_FRAGS.
Message-ID: <ZiearYVLLy22H2eG@nanopsycho>
References: <20240423102446.901450-1-vinschen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423102446.901450-1-vinschen@redhat.com>

Tue, Apr 23, 2024 at 12:24:46PM CEST, vinschen@redhat.com wrote:
>From: Paolo Abeni <pabeni@redhat.com>
>
>Sabrina reports that the igb driver does not cope well with large
>MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
>corruption on TX.
>
>The root cause of the issue is that the driver does not take into
>account properly the (possibly large) shared info size when selecting
>the ring layout, and will try to fit two packets inside the same 4K
>page even when the 1st fraglist will trump over the 2nd head.
>
>Address the issue forcing the driver to fit a single packet per page,
>leaving there enough room to store the (currently) largest possible
>skb_shared_info.
>
>Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")
>Reported-by: Jan Tluka <jtluka@redhat.com>
>Reported-by: Jirka Hladky <jhladky@redhat.com>
>Reported-by: Sabrina Dubroca <sd@queasysnail.net>
>Tested-by: Sabrina Dubroca <sd@queasysnail.net>
>Tested-by: Corinna Vinschen <vinschen@redhat.com>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Next time, please indicate target tree (net) in [patch] brackets.


>---
> drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>index a3f100769e39..22fb2c322bca 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
> 
> #if (PAGE_SIZE < 8192)
> 	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
>+	    SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
> 	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
> 		set_ring_uses_large_buffer(rx_ring);
> #endif
>-- 
>2.44.0
>
>

