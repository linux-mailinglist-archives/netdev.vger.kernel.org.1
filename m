Return-Path: <netdev+bounces-108440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D66923D3E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C037F282326
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42215D5BE;
	Tue,  2 Jul 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="KIPftBtV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053B15B54E
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922114; cv=none; b=TLqqkp1mOkblIHEt7V33MfjfA5KIg1wKyvrG4x205GDSAzLgUeD5wasNbz867SdeEHThhW5HIdBx6CDVaIXM+3f6fJbhM1XokszevJDuu3wEvSoQhPvgevOfiqvZWmNMcwnTohrnZO6OFlbiafoL3tNxZWpAUAA4AwRJFUu0x9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922114; c=relaxed/simple;
	bh=AV/QCdqqveccrEjG930COx+0FWJe2qq37AE1VjY+c3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CoWz0rH+yeu4vD5V8OVEEpQ9I+5zVFAhakWOLO8yDNfXS9ybV8XF6SxLkDtZnCma3zOMJiYtlCm6Gfd1q2sHYhhydHMyRTJ+HOLn3T9lEl/+PpjFK7i4aF5jAg/0HaLWk566tSegQTAVg9IWvLx0jpX9GT8WLtqk6AM80Fkn+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=KIPftBtV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so4253577e87.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719922109; x=1720526909; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2FVSsT8prLQ7MVGouFoIi4BXqmr6LX7dsLflRdyCT6A=;
        b=KIPftBtVlqN8TuicZXhhCm2z7ZF/Jp6Kvak8qf36RtX183IfdwDJZdrNX8M7Rh8dwu
         KImDOPqHgDVoWj7+zrTHP48wlwoqRz03uM8ZTd4VzuV2b2Wrwjr4+s8Y8UpaNKKpLs/r
         hmxh0FmfHH0yoK5sihKpC105ESngG+vZNP4iXFHsag9Z6Ex7gKnvUdt4tzvbNkfrKzcX
         DtmvIZqWGaYtzN6ZFGPb7vuxt9HGtxYcfQa6ojn4nO/HrECy0WRuaD/s9XsgCpSzUGla
         pflIOEokRo69Ehwqwgw3SL+aiHtQOr79vMPHzc7FJGKJOJ2jG+XZtriihfmFbL8wjCCI
         Cf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922109; x=1720526909;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FVSsT8prLQ7MVGouFoIi4BXqmr6LX7dsLflRdyCT6A=;
        b=uIbBZlE6MpAJC+Vuin/FxYkyLxWjjpKyEfVhBxCUNcd62MKrmQJUPN7PQgI5dgZILx
         +aumI55HcgvwQKassTaZVmFEXYmc6zIh/ofFtFs+e5W5sr7yCwGkyRuniBRvQRsfgtd/
         QNWkPKgwPVLNuZkziSVmGwq8500ZwU+OR6B0jzcYWipZW9GHtn+NXk7jI66iuh4727no
         LNMTAu6wGVYYRap5kwTIkWp4r7I0WYbOWbivGr6x/dG6Z1HFJBqgIQ3BYGKR0/n8rXm6
         joykowNYKm4JrCMcKr6ox2GAjObC1WniIZgRpT+Vf2byVrT7AXk/dfSpZGNJIFuSZlVu
         t9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/0b6HnJmQpYHyiPHwywSWcTNlCploGYFKB8ZGNmyM3f8zBwVteKxo71ssfZz1aLpMa+d6hHvWHiHMZjnWYAd8kgL20kG9
X-Gm-Message-State: AOJu0Yy48ZWjdODwf5OqbuGS2kUCwPlK0JPCuku3JLcYfodUrT9UzFws
	K06Xc9aOnKQP9tMLWvJXufce8bUg0K27191xQqUGWfdO5yR1KW4Ka0AhxD2+96k=
X-Google-Smtp-Source: AGHT+IGtsdUj9+nIPgGr5SjmSPLeNICk1p6RCIZgZ3IAIzh2Nqtag0T9Kf4QiKe57HdtxX82XSHkGg==
X-Received: by 2002:a05:6512:3f5:b0:52e:8018:279b with SMTP id 2adb3069b0e04-52e82747e45mr3482568e87.69.1719922107944;
        Tue, 02 Jul 2024 05:08:27 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1064asm1799414e87.103.2024.07.02.05.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:08:27 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com
Subject: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
Date: Tue,  2 Jul 2024 14:08:01 +0200
Message-Id: <20240702120805.2391594-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series adds support for:

- Enabling MST on a bridge:

      ip link set dev <BR> type bridge mst_enable 1

- (Re)associating VLANs with an MSTI:

      bridge vlan global set dev <BR> vid <X> msti <Y>

- Setting the port state in a given MSTI:

      bridge mst set dev <PORT> msti <Y> state <Z>

- Listing the current port MST states:

      bridge mst show

NOTE: Multiple spanning tree support was added to Linux a couple of
years ago[1], but the corresponding iproute2 patches were never
posted. Mea culpa. Some time ago, this was brought to my attention[2],
which is why you are seeing them now.

[1]: https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/
[2]: https://lore.kernel.org/netdev/Zmsc54cVKF1wpzj7@Laptop-X1/

v2 -> v3:
- Added 2/4 bridge: Remove duplicated textification macros (Nikolay)
- Fold a conditional in to a switch mst.c (Nikolay)
- Give the full command to set a VLAN's MSTI in the man page (Nikolay)
- Use proper type for stp state (Stephen)

v1 -> v2:
- Require exact match for "mst_enabled" bridge option (Liu)

Tobias Waldekranz (4):
  ip: bridge: add support for mst_enabled
  bridge: Remove duplicated textification macros
  bridge: vlan: Add support for setting a VLANs MSTI
  bridge: mst: Add get/set support for MST states

 bridge/Makefile       |   2 +-
 bridge/br_common.h    |   1 +
 bridge/bridge.c       |   3 +-
 bridge/mst.c          | 258 ++++++++++++++++++++++++++++++++++++++++++
 bridge/vlan.c         |  54 +++++----
 bridge/vni.c          |  15 +--
 ip/iplink_bridge.c    |  19 ++++
 man/man8/bridge.8     |  66 ++++++++++-
 man/man8/ip-link.8.in |  14 +++
 9 files changed, 398 insertions(+), 34 deletions(-)
 create mode 100644 bridge/mst.c

-- 
2.34.1


