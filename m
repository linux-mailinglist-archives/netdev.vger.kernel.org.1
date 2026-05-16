Return-Path: <netdev+bounces-288592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CITBIAKCGqPWAMAu9opvQ
	(envelope-from <netdev+bounces-288592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:11:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 730FB55A71C
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0894A301548F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDAB372B52;
	Sat, 16 May 2026 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b="hyJinF8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B6357D15
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778911867; cv=none; b=SkGldZM4qlw3au0v46lEpBsdaVspstCmKe6fLrJxOyj/CvYwBiGwSA6dQ7NoGIYwfc2FzQlpRCBvONmtq91wcz7016M3rxEiYUV1h5ZXrlL/iOht+aj0oHxQt2txedITAPUfe8D4y1KH8Pmk2WymPoVOLOOuPWvyArR1suc9nZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778911867; c=relaxed/simple;
	bh=2Leslt9BvB34QU801/n0+rUCWtgQPEnpWkpjEuM4jNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AxFCudf9m0Wv7BgMvROi3CGu2sfZQPNhbB2r2fRVQ/Lnan7cLIjr4utVlPyMyavSZC/cIWlbFGBN5T4E016viN3SGpUbGzCsOI2qX9IuUGbgqSIC5u5zciK8Mj9ijwH1NnCLvxQAmxf/OAO3sjNVIbx+yG9dToJp2cajHawMHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com; spf=pass smtp.mailfrom=extrahop.com; dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b=hyJinF8c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=extrahop.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba1e9d3687so4086855ad.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=extrahop.com; s=google; t=1778911865; x=1779516665; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJUW1fIrNG8R6/LQd80CdB1tEktS5+sLoCJwrPWafEc=;
        b=hyJinF8caPaeCe/g8PvdHPd/WchKYMUFbngZ6vbKdH62qlZpHiP/44OmYkbhKlJ+3R
         6vW4+OC0utk/pri7sP6o+kN4cKii5clqitLl1+iG3xACJFhyQZp9frMOaTRcxAWhGmAb
         Fz4DVxvVCYnPvyMx2SrLSaM6Pq+2G39XFvoZZXLiBUE8oVWcXHse4ajhxISLbqM6oUaA
         oVblE+8pyNI58/j8hIEBrwaL4eDOuqOdzZQLMpodTEwOn+Sx6UumoSssdEpKAqxDwpzU
         tpit+P4Duyq/+GpPtzoxtVwddS28Nl6JUDceuipIihLzUkYlfLYwG3ia9/BmqUGeEh6x
         zM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778911865; x=1779516665;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJUW1fIrNG8R6/LQd80CdB1tEktS5+sLoCJwrPWafEc=;
        b=hYr/W/VLLeM2Wl6doM96Gl9EehiAL1A/bzonWB0lYTK+ydjJTCFdgPksOnbuH0Zwqd
         I9xMYl5e7MUrfuvBQGKVyvcye2S46VgTM1gyXrExBDCrV8BWDnbdg57nhks9T0/TiTbr
         Fu5VLQp6LNLzAwTKFqgayGyL3GRnf05y8RWkD6lpnlQ1nsmGGqIcKRTUz8h53gZiRHAz
         z713dLXP9ROcKMJVlJk57O4jN/erWN1IpIvnMrN6EdiR3YuH/lUQPAkYJUdnKcVohW61
         fb3wSi+Q4vcg2C2zIYjKgrP7K5n00Df479vBYE5i12i/63iKUhfllRZlhts35sGcw0GP
         Xmxg==
X-Forwarded-Encrypted: i=1; AFNElJ+OlJf9D4dTZUmg04/nwzTWOmtMmGBR/Qrpk54rlNsUCJDk1QEHciuO9YcuHNKypTYb4RfI474=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jSKDfuVYDn2DfeFNCJpvFJn9siVQihN3zsBnKaU5EX4EDNa8
	jz/MVVkb7sYsX2KnrcSNu5mvMDi6WYd2hM5T/z1igALgSgEAZ2gSsgP0UQUcA8e85oHPaOGju4i
	xZvJNceH+T1K1LgK6s39xeo608G3xmSGJtJJjiVmGXWqJSrD4VK+A/PEcYQe0vEs6Kyf9Ta7Xx8
	YKQS0aDLYm9QrKzYziUlckAbYWCudrUdDMgB7lvFWN0zqYYD8=
X-Gm-Gg: Acq92OFTItr75l4NOaXbs80KkE8aCYVBK8hFxORDUbHQrPT1UlNabkETd5BDHfTGIxY
	617+aBQ78n7O/XvWeclwJgta80CSpjM/qEVe3H6wE3We8k8OilNxzoSELNPN31tjDNfTeDQ6ZB9
	YHxkSXvKr+2ZsxitAR2vuTU4Yc9WLxafgHkQRcjiSv1i+rok5b4MjAAYNGDaJtmzCK6NRR2olO/
	B2Hzn2fW6sIgCItpmf88fRQ6Ptdcc/9r+I71HNGtK7avNg1e0O/cSSawiKU6k7QuviJDeRJ2TVX
	j+woAA33SLVA9u9vYUbWJuzcMtju10co3O+73K/kgb7tTk9eqJYQt4XqiJs6c5QCz42muSogURS
	aHxAZxAkNykEO3FT38M/U40rRLwQVHdQODR3zUt3bPu9BdnU6Q9Mg8q/+sc1ZAaEfUVc0x925vJ
	+U+XvGDRWWUgf9vpVEkic+WIKjEO5S
X-Received: by 2002:a17:903:2984:b0:2ba:67f7:9326 with SMTP id d9443c01a7336-2bd7e81a6c0mr79060175ad.9.1778911865304;
        Fri, 15 May 2026 23:11:05 -0700 (PDT)
Received: from [127.0.1.1] ([208.79.144.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d23a41fsm79591625ad.83.2026.05.15.23.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 23:11:04 -0700 (PDT)
From: Will Mortensen <will@extrahop.com>
Date: Fri, 15 May 2026 23:10:36 -0700
Subject: [PATCH net v3] net/mlx5: don't printk garbage when transceiver
 overheats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-b4-mlx5-sensor-fix-v3-1-f537ce191d6c@extrahop.com>
X-B4-Tracking: v=1; b=H4sIAFsKCGoC/22NwQ7CIBBEf6XZs2tgS6vx5H+YHmpZLImFBgipa
 fh3Sb16nDeZNztEDpYj3JodAmcbrXc1tKcGpnl0L0arawYS1ItOXPGpcHlvHUZ20Qc0dkOhWq1
 GItMrCXW4Bq74kD7AcYKhwtnG5MPnOMp0VD+npH/OTCixa6VhVkZfjL7zlsI4+/U8+QWGUsoXH
 MYM77wAAAA=
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Shahar Shitrit <shshitrit@nvidia.com>, 
 Carolina Jubran <cjubran@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>, 
 Jeremy Royal <jeremyr@extrahop.com>, Will Mortensen <will@extrahop.com>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 730FB55A71C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[extrahop.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[extrahop.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[extrahop.com:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@extrahop.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When the mlx5 driver processes a temperature warning event, in events.c
and hwmon.c, temp_warn() calls print_sensor_names_in_bit_set(), which
calls hwmon_get_sensor_name() to get the NUL-terminated name of the
relevant sensor, and then prints it to dmesg. In particular,
print_sensor_names_in_bit_set() passes the bit index ("sensor index")
within the 128-bit vector in the warning event to
hwmon_get_sensor_name(). But hwmon_get_sensor_name() was expecting the
index of the hwmon channel, and the driver registers hwmon channels for
at most only two sensors: the ASIC sensor (sensor index 0) and the
module sensor (sensor index 64 or 65 on a 2-port NIC). So when the
warning event concerned a module, hwmon_get_sensor_name() took the 64th
or 65th element of the likely 2-element temp_channel_desc array and thus
returned a pointer to some other kernel memory past the end of it, which
was printed to dmesg up to the first NUL byte.

A further difficulty is that, at least in testing on our CX-8 C8240 with
firmware 40.47.1088, the warning event can have bits set for other
modules, e.g. if this PCI physical function is associated with
port/module 0, we might expect bit 64 to be set, but bit 65 (for port/
module 1) can also be set unexpectedly.

Fix this by clarifying that the argument to hwmon_get_sensor_name() is
the raw sensor index, and correctly converting it to the hwmon channel
index. Return NULL if the sensor index doesn't correspond to a hwmon
channel (e.g. because it's for the other function/port's module).

Fixes: 46fd50cfcc12 ("net/mlx5: Add sensor name to temperature event message")
Reviewed-by: Jeremy Royal <jeremyr@extrahop.com>
Signed-off-by: Will Mortensen <will@extrahop.com>
---
Changes in v3:
- Fix ordering of Signed-off-by
- Add target tree name
- Add CCs
- Tweak commit message
- Link to v2: https://lore.kernel.org/r/20260512-b4-mlx5-sensor-fix-v2-1-531fee4fd7fd@extrahop.com
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c  | 15 ++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h  |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 4d7f35b96876..9372551c7f90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -165,6 +165,8 @@ static void print_sensor_names_in_bit_set(struct mlx5_core_dev *dev, struct mlx5
 	for_each_set_bit(i, bit_set_ptr, num_bits) {
 		const char *sensor_name = hwmon_get_sensor_name(hwmon, i + bit_set_offset);
 
+		if (!sensor_name)
+			continue;
 		mlx5_core_warn(dev, "Sensor name[%d]: %s\n", i + bit_set_offset, sensor_name);
 	}
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
index afcdebac9c4f..747ff30362f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
@@ -417,7 +417,20 @@ void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev)
 	mdev->hwmon = NULL;
 }
 
-const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int channel)
+const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int sensor_idx)
 {
+	int channel;
+
+	if (sensor_idx >= 64) {
+		if (hwmon->module_scount == 0)
+			return NULL;
+		channel = hwmon->asic_platform_scount;
+		if (sensor_idx != hwmon->temp_channel_desc[channel].sensor_index)
+			return NULL;
+	} else {
+		if (sensor_idx >= hwmon->asic_platform_scount)
+			return NULL;
+		channel = sensor_idx;
+	}
 	return hwmon->temp_channel_desc[channel].sensor_name;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
index f38271c22c10..b2476bf54ce5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
@@ -10,7 +10,7 @@
 
 int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev);
 void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev);
-const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int channel);
+const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int sensor_idx);
 
 #else
 static inline int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev)

---
base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
change-id: 20260508-b4-mlx5-sensor-fix-043d4a22f641

Best regards,
-- 
Will Mortensen <will@extrahop.com>


