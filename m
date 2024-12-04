Return-Path: <netdev+bounces-148959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 742959E3A23
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D13B38E6D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E41B6CF9;
	Wed,  4 Dec 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avHDrWQR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC01B414A
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314282; cv=none; b=p5XME18/9HCtkzylhK8p8wEz3kWxmdbndtQfzZifovknqt2BggqR4ZWWofTRIUD9/xWzEfW7RVehpyMQ/SG8bWuHsEUlzVBj7c5ZgEZahx8UYT1/coh4M2Wz4KIJUeEVWA7QJvTlW/9ufM7CGwXyxdnuet07Hg1TW1+mY1iC9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314282; c=relaxed/simple;
	bh=pi4LbUA8Yj7rm5Yxcx1CWuyWPa9NMb6dlVcOXywAEvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JGsOf7qw+SsJTRDv5IS5Ykl8/AVd5lzu3oGtj9Mq8ypYV+tilqsxM659sfR1YHjFYW9szVTPjGT1n0wyfxtGESwXhWgciSl5DFARc3lUnxLQScznmADc8HAQ7RqEqM6o1324u7LiHrh+sPbaw9tLzRSlWGiP1MD09gmu2Nk94j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avHDrWQR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733314279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EDtv3ZxaLzJgd5usBVvsmlhoqsHgv2XF+0oVELkMWMo=;
	b=avHDrWQR1ulBeDksijxkgixhN/5hwSmzpxebjE/ufVpIBhFjk4Hk6ewUzCsYLssmqRaoj2
	9n50sbvdjM93Hjn8l53A6jYLoByYpe+xGXGdVIivKy9bVr7rfV08yMnOqxzYK0XHoK9HGg
	u+aCRumRvqcFIUYc1tMxNuTCWlNCg7c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ya7yBlhZNPmO0IIVjbDFnQ-1; Wed, 04 Dec 2024 07:11:16 -0500
X-MC-Unique: ya7yBlhZNPmO0IIVjbDFnQ-1
X-Mimecast-MFC-AGG-ID: ya7yBlhZNPmO0IIVjbDFnQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d6ee042eso4137372f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 04:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314275; x=1733919075;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDtv3ZxaLzJgd5usBVvsmlhoqsHgv2XF+0oVELkMWMo=;
        b=aaaQEqyPX99RaKGmkcZeKV3gC1kIR0R3C1zw97BV97gIa6Uks4mk75+Ih5x5iaTNym
         ILhokynOdS0VgPQODAcF35rGrPgnmPv4eN8QPdqQzwGxqHfPCpVsZ/ezeWOtX3Mx4eYm
         wFRmH83wPJXEZsINxqB0H4bEZ8hQnLTtR8k5rrtUjn+2um80y74dD+PiRWiV90DxrWpL
         e7WeE01e0USF8AlOcSDBBNBR02TNZGaohxCSm3NNknUap0KbU68Coz6n7u7Wh5H/O8QK
         2gm4p/xNpdvir5bqS3fab0bUOYZFH3FzA0GLPFXfm4xfQC2LRxh7vBwSAkhZsFkMZetG
         6fUw==
X-Gm-Message-State: AOJu0YzlmnvDhe3IXbm+/pD0nRCy5m3JD8/VDmyVn1+TAIKmuZtn0GX0
	TFfNL0qko+3cTUKirhLKYE2bi5gD5c8lezRuEtFPb5wPJJeNxnBS6R2/eAJmM7G70+sXSGemLyR
	dI6HXIDLcNLQZOfxj0qNEKubocEJtZqmL3OhmiaPUqa7rwJFV2MxcLQ==
X-Gm-Gg: ASbGncvhmI/9awa7/zBxYZ6kvz5lZm0FikXJ86LMSmO0YbQorO6UkpRXfmURmM4BigQ
	XRdBGuBrCGlR7xTT+LkIDfHln4oXxm4wpIpAkfRoTmboKzmeNJm8HNyNXvf1lerEAq4LwqWxyn5
	WN3uAnUxyF24iyf0T6sLcJ1o/F/GXRznA/02qH/QBmkoYep+5nq8XM0vDkBl7CkhUJx1y42DBMD
	BWIG/KHCxZFH/wur4je6GWTfYzd/MfmHFMCcnuHZz6ZfHr1ydSBkAmt8VJNKq0wpvi7UiXlBxjG
	uUMy9nJZeRRIy/U/HLle7XefsSo/Xg==
X-Received: by 2002:a05:6000:23c7:b0:385:fc00:f5da with SMTP id ffacd0b85a97d-385fd3ed7d6mr4055864f8f.27.1733314275641;
        Wed, 04 Dec 2024 04:11:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiXkpMcLdrxL15Yw/BeL5pDryx44FY3Ksb7UUckSRtDIgO9tJ2NHKC29IX26gLNimrVwgpRQ==
X-Received: by 2002:a05:6000:23c7:b0:385:fc00:f5da with SMTP id ffacd0b85a97d-385fd3ed7d6mr4055852f8f.27.1733314275345;
        Wed, 04 Dec 2024 04:11:15 -0800 (PST)
Received: from debian (2a01cb058d23d600b242516949266d33.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b242:5169:4926:6d33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52a57basm22208075e9.34.2024.12.04.04.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:11:14 -0800 (PST)
Date: Wed, 4 Dec 2024 13:11:13 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 0/4] net: Convert some UDP tunnel drivers to
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <cover.1733313925.git.gnault@redhat.com>
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
(until then, dstats was VRF-specific).
Then patches 2 to 4, convert VXLAN, Geneve and Bareudp, one by one.

v2:
  * Copy skb->len before calling is_ip_tx_frame() in vrf_xmit() (Jakub).


Guillaume Nault (4):
  vrf: Make pcpu_dstats update functions available to other modules.
  vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.
  geneve: Handle stats using NETDEV_PCPU_STAT_DSTATS.
  bareudp: Handle stats using NETDEV_PCPU_STAT_DSTATS.

 drivers/net/bareudp.c          | 16 +++++------
 drivers/net/geneve.c           | 12 ++++-----
 drivers/net/vrf.c              | 49 ++++++++++------------------------
 drivers/net/vxlan/vxlan_core.c | 28 +++++++++----------
 include/linux/netdevice.h      | 40 +++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 63 deletions(-)

-- 
2.39.2


