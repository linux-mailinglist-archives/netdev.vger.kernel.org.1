Return-Path: <netdev+bounces-109959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55D92A7AA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C1B2818EF
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8A1465BD;
	Mon,  8 Jul 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/8ru47N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B814532B
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457764; cv=none; b=Q5+Byh++uR9jYnk/GOLqQUCaydGZAGWaaKAeELi4mTyjUU55M/yTBeoTySVvQpyiTyLImVc9YeDyuHWCgzbPjsojZ3W5+i22qewbgawIqrvztHxoj78AUAhJK+ypS1BGGC60+r4AYW5xk+w6N5/SgKgUNf7261z3xXIj0DPAUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457764; c=relaxed/simple;
	bh=HAJgF8RuZpQa/5VZMbAsbauoOo8SG0KbciX75Tn4Qr8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RZ86/KL+F5LO6cQ800EXWMVLu23c/8uZ77E8wApbXETTuv6WyM//ndoei0ybOYkq0ztAYtZ+76dvKjJJ6Xe5lkBruC6Xk0qHV+5sd8psoMs6Ug5ZqthC/0fejNOQRetoSj/JnroDqH9T0yuYenW/uaRohhIBTYtV/nKohuTQOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/8ru47N; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-447d6edc6b1so17630471cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 09:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720457762; x=1721062562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K4iI+wSqakoJRcCSsgszXHsX1X5QD7MXxSS0lVd5t0=;
        b=X/8ru47NtZ4gI7a9AO55jvL84ciljCEy17ymxWlI2zJK/vrEMmIQB2X3YAEm9YVrRh
         aElY2tHHq8c61XePHFXQU/iXyObnY6NcF+mKus6UyM4lfNGFpHCPlrlzy0pMvCcdluZx
         c2M2LU5PuSIAzbNv9olFvYBdnkr9Cd37Pga0jzAmjnbmhOMeuKLrbAh9Tl0izVlpuaj/
         FItrJX2cNnlvEpEnTkA66ZWkGMPQNNATyxCDklJzapa5kdz9Qx8A7ZvcRA4Tv0pQotwk
         4wEvOz03S9zYsNukXnJck8ZYxSJaLd45mXxHmls2Q0WQizLISTMThhNV+ncb0UJW7HE/
         tfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720457762; x=1721062562;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4K4iI+wSqakoJRcCSsgszXHsX1X5QD7MXxSS0lVd5t0=;
        b=YeqD9jNh2cCPtwzKPcOfCPGTH8nAK0WIYHLgrrEzRinpNOAm87azDXGOj5a3bVwxkb
         y9N36yEiKU5rq5IIGterjriGF8xTMtPTkxVZWI/F3Fehssko/8mrAEfiM94NftTOnQxd
         ephp4TRqaQlLu2TitiYMP+T0BlwN1sDUKNXAfBecUD4PNJIFRjdyPdewqlZCUdvbfAPs
         iwY3ciWR0C/OTnbNTQ7ZWAYEurcm/VEVskAN6tA/yrCC5Ljo6q032OcDIWP0jodhQfJG
         soQ5m89E3fMXiUwz05e9L/D+XVRcc40SoMk0wkQceGUb9K2Djz0/eg19L14jdC76lwFr
         0Ktw==
X-Forwarded-Encrypted: i=1; AJvYcCWg/WhlUSVI9HavTc6o9H6zzTcv4aqWDV79y2NRx1+DZPPvhC2R+TZfRo+tQq/pjTQtCGd60XVALjgJF5kfftxZH6g9sJE1
X-Gm-Message-State: AOJu0Yz3S14UhRSWIcY8IwTLPiyB9Je3jxtxSHG31qsf/oopeq1Tc6rT
	QHzs+nGRdCSo0hqELG1dVL//b48SU8sOUnqhuilJ6t813YLnyYf8
X-Google-Smtp-Source: AGHT+IELNJislb/nooHjXxWFnMIq4MkbTKdBBJFxSXZvZSnMPdYTmErDxmKtUWFMGs16+fkGo+bL0Q==
X-Received: by 2002:a05:622a:408:b0:447:f866:5335 with SMTP id d75a77b69052e-447faa7e74bmr422341cf.67.1720457761992;
        Mon, 08 Jul 2024 09:56:01 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b2690csm1249061cf.1.2024.07.08.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:56:01 -0700 (PDT)
Date: Mon, 08 Jul 2024 12:56:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 petrm@nvidia.com, 
 przemyslaw.kitszel@intel.com, 
 ecree.xilinx@gmail.com
Message-ID: <668c1a2168f55_1960bd29446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240708091701.4cb6c5c0@kernel.org>
References: <20240705015725.680275-1-kuba@kernel.org>
 <20240705015725.680275-4-kuba@kernel.org>
 <66894e1a6b087_12869e294de@willemb.c.googlers.com.notmuch>
 <20240708091701.4cb6c5c0@kernel.org>
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: rss_ctx: test queue
 changes vs user RSS config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sat, 06 Jul 2024 10:00:58 -0400 Willem de Bruijn wrote:
> > > +    _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
> > > +                                              other_key: (1, 2) })  
> > 
> > How come queues missing from the indir set in non-main context are not
> > empty (but noise)?
> 
> There may be background noise traffic on the main context.
> If we are running iperf to the main context the noise will just add up
> to the iperf traffic and all other queues should be completely idle.
> If we're testing additional context we'll get only iperf traffic on
> the target context, and all non-iperf noise stays on main context
> (hence noise rather than empty)

That makes sense. Should the following be inverted then?

+    if main_ctx:
+        other_key = 'empty'
+        defer(ethtool, f"-X {cfg.ifname} default")
+    else:
+        other_key = 'noise'


