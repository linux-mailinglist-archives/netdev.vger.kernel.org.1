Return-Path: <netdev+bounces-227202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA2BAA0A0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E82A19219A8
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003F730CDB0;
	Mon, 29 Sep 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vPVgo5Fq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162DF30CB30
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164650; cv=none; b=FbVFjjACqxU/VZ+/QvnXy4N4Gnmv25v8RqEd69Luak0QtkE7FplRIa019Z6DNUj6zVy+hyx3YZgaEWDhTouGdmPpBNTZ2iu9XqpEQDVIPZ8KCkmNO2iySmTO7a5SjRfrg1e1fVr3ZBiwgOEA33lnd5mDBYeFhnWsZPiv2X60dxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164650; c=relaxed/simple;
	bh=5Q2xOvfMdTjmz8hxrekbXb5rsF5C4DN8K5+LbrteSr0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=cRWUdBdx+izfErImv2p6ZdTMmO7Ro9qB87oyA/EznBDdGd2E1En7eaihoquTqiyyY3Xy+9X18huqk6ND2vGWVNhENirytuTeTTyxWcMAUB7v2SGKOEXUJEVJ2a1xnnCc0J88ogYt/bSzR30+EObk0He89ViEA5FRVMIOJB7Zt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vPVgo5Fq; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-85cee530df9so534425385a.3
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759164648; x=1759769448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rG394syCGnKx0XDysCoczuuw4zocqTc1DdnqDW+XMzw=;
        b=vPVgo5FqcjQHwT7R7TTREXIAb1fR+AMCH1FqrbXDamsTd3rX1UXnbr625ZrXRqoDJb
         JDi1duIXgDjOzU3kU6avaLlDJf5wTrnPcwUnYp/lUdex8YHA8b1fK8DmVeluiTkbNiJ1
         OBj63Cr7s3UUaL9BkVegRuhpjU2i26TnReGKpxIQLeBdyChkvIWxKKvro5wYbxhIxzbd
         3RvhCPzIPA/OcgKMcIN28WJJ41dqCc/+r+9mCVqFiCIzglX5qE3ev9u4WcU4MPbWrGub
         F+U/DdN3B4hNmogIT5t9f/Y7KKI28OHXWqQKWFZequnwwX8l+URoJ7k8ghXteh2EJCaZ
         aOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759164648; x=1759769448;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rG394syCGnKx0XDysCoczuuw4zocqTc1DdnqDW+XMzw=;
        b=q1dXHHhOsSnEvoE4AK6WYJgNRczO8ZnpdkJFupBHAOBy8vp8znJ1hhsojdafuMV/o4
         CUgFvU4N3wTnQSlAKIe5N4Vpi27/DqWOIGJAvFsiVbi8Moyxs4CxYaIVSwwiKz+0saGh
         dAx+GZjVyVExllLjTe3M7VEzGyeVBAdzMeZP7/07KrXXxWihJOxizZAFlaWuJGM9tDZB
         I3q8RGuzkfOqqZWdty17dALuQyqFMaJpI3UoFMXKvKYS9y1NnuyDC2sGH+snucea7iCV
         cYTfg6leCsisXh55KFz+6ZK9Hot0/JwP450fRXG6ODBlYfHnIK8L/SC6cA+I2hFj6bQO
         8y8A==
X-Gm-Message-State: AOJu0YzyDwqNyPR+iojhwR19ORG/TuHnnecX+ZGKfKxSOGaQVepo/Os+
	1m5WMZ+jG2d4iNZM5J2+VTVcGrCyCertK+V/bjX6S0rYFh4rqhOlDEijyRtqJ17cczux/B9BIHg
	RKvSSaRE=
X-Gm-Gg: ASbGncvvvq+Qncnm8+pRCI5kTwbVQYgTLr2xnwa21VHzzz9tkey8xr1gEyLg6doqna9
	HScoZr+8gFsn+nvi0Sdde1E285trqMGZWWyUqc7vLcB+GyPYEkeA5S2ugOPHm49xJFOZJ0diEkL
	fH5QISY7zqvkrxcg5EQkYQJ8cyDyYL71xYL/MDOLxnnBIuZHIW+XFkCsTI0ie2Hjub8oqUQi+5+
	HQgqAYph4PMnUoY1lZDCIk6PCUnGTq297CjUEhmo2vxW6z4OfzUiCcRCeS2T4LxRmAI1s4kPfhB
	VlMsIyH15C7fYheln70aHnltq0wsPP8vvLnzKUiduv+8hhHDopaHqISCqgQKWUx+IulJdQvsdxj
	MJJjnKpAk0hvnqVZHQ6EYXK/2GCk3X+022UuP9KQyQkbApmzVblYXe3gNazOIAK8DrF6vmDVFIn
	qufa41e4iNNg==
X-Google-Smtp-Source: AGHT+IFtpTTQQS4wIIalrzsOu2PHj7oAyNJ7M+sRO7DWvxFYq3rs6N6gK4hnVQhHjV/RVpQZ9TSUjQ==
X-Received: by 2002:a05:620a:2809:b0:7f9:7000:f7c2 with SMTP id af79cd13be357-85ae94c6a11mr2215347785a.66.1759164647863;
        Mon, 29 Sep 2025 09:50:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db03cb1744sm80358951cf.0.2025.09.29.09.50.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:50:47 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:50:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.17 release
Message-ID: <20250929095042.48200315@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This is the regular release of iproute2 corresponding to the 6.17 kernel.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.17.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Andrea Claudi (1):
      tc: gred: fix debug print

Anton Moryakov (3):
      misc: ss.c: fix logical error in main function
      misc: fix memory leak in ifstat.c
      ip: ipmaddr.c: Fix possible integer underflow in read_igmp()

Ben Hutchings (2):
      color: Assume background is dark if unknown
      color: Do not use dark blue in dark-background palette

Carolina Jubran (2):
      Add support for 'tc-bw' attribute in devlink-rate
      devlink: Update TC bandwidth parsing

Chia-Yu Chang (3):
      Move get_float() from ip/iplink_can.c to lib/utils.c
      Add get_float_min_max() in lib/utils.c
      tc: add dualpi2 scheduler module

David Ahern (8):
      Update kernel headers
      Update kernel headers
      Update kernel headers
      Update kernel headers
      Update kernel headers
      Update kernel headers
      Update email address
      Add tc entry to MAINTAINERS file

Eric Biggers (1):
      man8: ip-sr: Document that passphrase must be high-entropy

Fabian Pfitzner (3):
      bridge: move mcast querier dumping code into a shared function
      bridge: dump mcast querier per vlan
      bridge: refactor bridge mcast querier function

Ido Schimmel (3):
      ip ntable: Add support for "mcast_reprobes" parameter
      ip neigh: Add support for "extern_valid" flag
      bridge: fdb: Add support for FDB activity notification control

Jean Thomas (1):
      ip: filter by group before printing

Joseph Huang (2):
      bridge: mdb: Support offload failed flag
      iplink_bridge: Add mdb_offload_fail_notification

Lieuwe Rooijakkers (1):
      man8: tc: fix incorrect long FORMAT identifier for json

Matthieu Baerts (NGI0) (1):
      mptcp: fix event attributes type

Nicolas Dichtel (1):
      ip: display the 'netns-immutable' property

Petr Machata (5):
      ip: ipstats: Iterate all xstats attributes
      ip: ip_common: Drop ipstats_stat_desc_xstats::inner_max
      lib: bridge: Add a module for bridge-related helpers
      ip: iplink_bridge: Support bridge VLAN stats in `ip stats'
      ip: VXLAN: Add support for IFLA_VXLAN_MC_ROUTE

Stanislav Fomichev (1):
      ip: support setting multiple features

Stephen Hemminger (5):
      uapi: update kernel headers
      rdma: fix minor style issue
      ip: fix minor style issue
      uapi: update to 6.17
      v6.17.0

Vincent Mailhol (1):
      iplink_can: fix coding style for pointer format


