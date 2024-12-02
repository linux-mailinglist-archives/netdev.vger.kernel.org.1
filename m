Return-Path: <netdev+bounces-148228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837049E0E1B
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D10281FB6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E861DEFC1;
	Mon,  2 Dec 2024 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjP0r4KN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E1C3D97A
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176131; cv=none; b=U2YHYjr/Ja8ibn0aht2TiS8PodvC3I4oQdrLdRd0INi17spD2WnPou83B6BGa55voV6tS79gKVTlCrK+L1TKQ/wfuReoQZj4Mz0e31x3qk9cX//l/W2hcvnfgOB6EB22BkDt1X4m1qk8HxjJ1ndWlOfdZfV8H6L6005DFGxMlGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176131; c=relaxed/simple;
	bh=pqzxY3Fiy0Il3ZcDn1bVlNRO9toMiU0vQEfrsOVrnhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UMq7gzsDMxea4d35FD0rApr2Vjc4zH/WfyhGU4pnmHBF1vqaFqV4vcKy1OuthcIUg8+jyD/reQNVb0NJPTDFOUn1IEKai+xqy2rTzuB3YGauen6RM0eXIAHs6LvrHs1373urYp3wiTy1RF07UUNkruMVay6p//Fn8VE4PEE2PEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjP0r4KN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733176128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zHKoQd+8EkiLGBlJ8onKdXukLlB8EPWuW8pKuWyB7Ts=;
	b=RjP0r4KNdbM96cMy8iI76iPTlotLtbuf1lqlGxZNagzWu2YLZ0QsX1vNh64wa8WioKuqZg
	aZcCoTaZKDn4+y6qTvPGFOTmmQC7b1VE2dPZppI4Wwi1+EaDp17N2P2upJWGaWMYLgMdaz
	wXE8/zmfjtF93bcxXK/jknleJ39M9iA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-bWOA2s5cOhG-gFeNDx3cpQ-1; Mon, 02 Dec 2024 16:48:45 -0500
X-MC-Unique: bWOA2s5cOhG-gFeNDx3cpQ-1
X-Mimecast-MFC-AGG-ID: bWOA2s5cOhG-gFeNDx3cpQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d4fa8e19so2511935f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 13:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176124; x=1733780924;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHKoQd+8EkiLGBlJ8onKdXukLlB8EPWuW8pKuWyB7Ts=;
        b=LlSp8/jMTm2XruIQ4ZGVB0hzPQ+NY3xKAWvor8Aq1kGXyuVM/Q1i5J3DjlDQIiPNVi
         /5AtwEfhyKHiK85FtkUIqS0Y+OD9MqkfjkGYRBW2dW4h1go7JhzOifmKavJi/Y2bcrHP
         hURhTehGlJc92A9C4ka6UZ6DKEA0Jvg1TJv8QTDfs92HYyKwbq5JZQU25pTBZyVZtgRI
         7ssK65X4dpmX3mAzExFC5RpvRtV8GU4YpFdoJzxV/jrli16SAdvFdr3kjVwkU1BMxHtK
         wY8l54yF6YtyaJazKOCpMRtcxhl4bYZv3wSCBoU3AduiMnm2Heo/OqlXDBIcVOJkp6MQ
         8f3A==
X-Gm-Message-State: AOJu0YzvUAzYDDhC/Z73nay+72MUO3D4WtkRwSBqZDLOD930L29fTjhN
	9Zj3U4NEj67c933cWF6SshdFXDwO8x7leKU8QhNP7Mk4gBJr72/odLcMvO2tcUtaFrfNOMJbQTh
	HBEf5GXUX+6iAphFyu2cg0ffxt6jW8hdBq6WrCeLMx8nuYNy6hiEZ2w==
X-Gm-Gg: ASbGncuRBmfrkRm9NsFeUHmSZdND6mqhRoX0fUC5AgW0DqQK9MfXfThr2a4/GlVLqz9
	L3vDdv4y3F9JOLc1X+ggxgOyNCVRag9YSlgl6Q++xTA/YngCihvfb/J/TDdQJEO6dNgBxVOgi2c
	tgW/QT+U1Qor/QwAricUVmFHytJK1CDg6xqoVEWGN5rkj+v2mm/Dd6hFY6l5lKj6qKEf30CNWkz
	VH9Uv+tQyMxyqjMxtJhrhokYjeDTQNEmy2LZDdSYF/gHSU09dCLKBoIYVvXgvLox064Y06vHVYj
	f95ru5p2gujZiDMEm3wjHd0KCrizUw==
X-Received: by 2002:a05:6000:471c:b0:385:fc8c:24b6 with SMTP id ffacd0b85a97d-385fd3f188bmr38936f8f.27.1733176124547;
        Mon, 02 Dec 2024 13:48:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1HjDmZHoZ78XqMSlNB1u8eqYWH/ZFxuWRNPvIPjXKAGrLuhcX4ez0kIdIhtT5UfMGEHQfRg==
X-Received: by 2002:a05:6000:471c:b0:385:fc8c:24b6 with SMTP id ffacd0b85a97d-385fd3f188bmr38929f8f.27.1733176124222;
        Mon, 02 Dec 2024 13:48:44 -0800 (PST)
Received: from debian (2a01cb058d23d6001797ea6ce8a6dfab.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1797:ea6c:e8a6:dfab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d04e7380sm1695285e9.0.2024.12.02.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:48:43 -0800 (PST)
Date: Mon, 2 Dec 2024 22:48:41 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 0/4] net: Convert some UDP tunnel drivers to
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <cover.1733175419.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

VXLAN, Geneve and Bareudp use various device counters for managing
RX and TX statistics:

  * VXLAN uses the device core_stats for RX and TX drops, tstats for
    regular RX/TX counters and DEV_STATS_INC() for various types of
    RX/TX errors.

  * Geneve uses tstats for regular RX/TX counters and DEV_STATS_INC()
    for everything else, include RX/TX drops.

  * Bareudp, was recently converted to follow VXLAN behaviour, that is,
    device core_stats for RX and TX drops, tstats for regular RX/TX
    counters and DEV_STATS_INC() for other counter types.

Let's consolidate statistics management around the dstats counters
instead. This avoids using core_stats in VXLAN and Bareudp, as
core_stats is supposed to be used by core networking code only (and not
in drivers).  This also allows Geneve to avoid using atomic increments
when updating RX and TX drop counters, as dstats is per-cpu. Finally,
this also simplifies the code as all three modules now handle stats in
the same way and with only two different sets of counters (the per-cpu
dstats and the atomic DEV_STATS_INC()).

Patch 1 creates dstats helper functions that can be used outside of VRF
(before that, dstats was VRF-specific).
Patches 2 to 4 convert VXLAN, Geneve and Bareudp, one by one.

Guillaume Nault (4):
  vrf: Make pcpu_dstats update functions available to other modules.
  vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.
  geneve: Handle stats using NETDEV_PCPU_STAT_DSTATS.
  bareudp: Handle stats using NETDEV_PCPU_STAT_DSTATS.

 drivers/net/bareudp.c          | 16 ++++++------
 drivers/net/geneve.c           | 12 ++++-----
 drivers/net/vrf.c              | 46 +++++++++-------------------------
 drivers/net/vxlan/vxlan_core.c | 28 ++++++++++-----------
 include/linux/netdevice.h      | 40 +++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 62 deletions(-)

-- 
2.39.2


