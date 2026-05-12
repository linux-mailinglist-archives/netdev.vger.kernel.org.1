Return-Path: <netdev+bounces-286983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBBsBO3YAmpXyAEAu9opvQ
	(envelope-from <netdev+bounces-286983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:38:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C15851BFDC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33EEF30580AA
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9BD36F8EC;
	Tue, 12 May 2026 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b="Z3BDvpbU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E5346E7F
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571172; cv=none; b=WF8QFb/IOIP1Jn4FxhBesrN7I2KFPeEEAiS/eMW64PrhGeQ6CPwvVLTYlsSYKV/NDe+8/4UUiN9O6+WOE+oidYJeXxYJhHfVZSbgg41jZfON0+gKK56jb74/ttBanxTA/+XLQaMDNCfw7rBhqYtTmQAm64EK9HXe4Ob/fRPkBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571172; c=relaxed/simple;
	bh=xju/IWG8saxtdwnV7MWJwem0CiywKew1SHzwHJn1LZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IEHOve4lD5v1Y4RKyGCaojt+unK6shQjiE/7IXgmuyeCIDIU1uMNzpk9RzfQNHR/UH/3xT73kH1966XUxj7LSm4O0rmCV7uPg2uoVRYOFdW89eStKqr6fEXnMAKReGEGjdM+UKWhjv2I56cfZ0O20DJC4eOkQ3GESwkfza2+3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com; spf=pass smtp.mailfrom=extrahop.com; dkim=pass (2048-bit key) header.d=extrahop.com header.i=@extrahop.com header.b=Z3BDvpbU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=extrahop.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=extrahop.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83537a80ab6so3246170b3a.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=extrahop.com; s=google; t=1778571171; x=1779175971; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0n1iBZT8JujYJeJFoTeIQmglBGjLLG46vH8a4p8cJ/A=;
        b=Z3BDvpbUl3Mo6hxA2t9IH/cjReJ64P+SyfKaYHV7zGksb1PTVb7xMIqGsp3zGU9pkR
         YnpcGeocah6w7f/x9tHtvHq2eLrJCTIb7vsrXdAlTSgXrCjn8UBxUWSxINQUH8rPy5hJ
         8U7IQAZS5yJMcGmm3k46WgQfd5OVK7uvYojm3LrSeI/feI0yb4TPGETdhD4sXuxb7Mco
         Pg7tqVpCOnzj0Yy1Pjfklh2kLT/vK3gz3Zij7rcRz3ODcEGdxv5EMskkHPTwQ4JxwV6u
         urQB7bKWwOERVsSxM02XfJL0a6cYl9BBXgd4jVzBLdXd9T+YBXmO7WLTTXe0XloTn758
         I9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571171; x=1779175971;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n1iBZT8JujYJeJFoTeIQmglBGjLLG46vH8a4p8cJ/A=;
        b=bwcqIHMOQeazVlGk+FMDvAlcM2jFB5jxXoLYooU+F530LL4t8viq50553YWixJeAo8
         47oTWSbTWy++CvuojqjCsixvdeVkNiFzpSymE/QkiB//17VQMmewxBqWzyiU8F8CSbcS
         ongdLDHKyBhNVn4dyP5+a3VHoZ4MLTo1Lm81QPUsXl6682BDAYzk0AjmNMObYQ1C4Z2Q
         vE7zPZUp65ePlsdEplB6gXhyNgPz9UWY1kLiQs2yG3Rl4Orib860qk9XZ2PXVJuY5zOB
         APfw2HgDM9BBu/AEjiWGM+HSmK8G9LEMS49zI7i9OxUGsUWBwn+OHtQwCO9116i7Qk3I
         0K0A==
X-Forwarded-Encrypted: i=1; AFNElJ/JP3R8QJllGZDxbdoHFe9/I9KlnTqeo0Z3iQSWHVCLgHFohHSPLN/ANhKpjzahvsEOB7diQ9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrcizjSV84Oh2D5uRRUK30eZqH25gBRMS+3OGLSD344J5E9PL
	GNcjHU9w1U3y5XXYXVDT+ajIJ4AXOwOt2QqaEbitFc3cV0JoyJ+xrPrNNKGHFRwk5nu8+RTZCRx
	/1LXvcjqTOQcEJDRJgwPyeYhl/uuQWXF5B7NX9OlpID03F9ez/ngXHgk6lx2lOWDoSAglOyONvt
	M8QTjo0YOkaOlC1f1YYtbmW2sk9To3RDQc+Iry4OcnQN04yoQ=
X-Gm-Gg: Acq92OHUZPmLhMyKethissqsPuvU1T6XCu+ECycpVAQvne9Nd9VQMFBegqJCppNPBrO
	z8gxQ9CAOwRgUnQpM8NrOYCSaid2yHywEOaR9r990YbhUsjhNN8DgY9oSfvP6HOaQp0ynNC3iIF
	/MuKuNmfDYofclYDGguq/gigy0+hiJU/rk14prLSeYM3TyJDPsQjRMEX2MJMTX2KeHqE8FwXT3K
	5Fs3sEVtdrNoA/cQHEZcGvwg5cE/qMKyXsRg754LfZTpvgkF2uchMLi5Z9b3tjfXwK327bHM6xR
	8lVzo8gEepby02irh1g1WJbrfpKZFTL7ZL80FWu2HDqtfZNHsBfHuREU1d/Y0ym7ICgPJPDMpmc
	SZJLkilqVrri1OEw86Q7fTq7iCOV9BRlCq5TDwC5CuYyE9S2SjonSyH3DbWxz5Zhd6JYGH5KoQs
	NrPyy6E2foghLHHbMTOQ==
X-Received: by 2002:a05:6a00:4b12:b0:824:374a:1407 with SMTP id d2e1a72fcca58-83e3994878bmr12823372b3a.16.1778571170412;
        Tue, 12 May 2026 00:32:50 -0700 (PDT)
Received: from [127.0.1.1] ([208.79.144.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839681a9e33sm24788894b3a.50.2026.05.12.00.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:32:49 -0700 (PDT)
From: Will Mortensen <will@extrahop.com>
Date: Tue, 12 May 2026 00:32:38 -0700
Subject: [PATCH v2] net/mlx5: don't printk garbage when transceiver
 overheats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-b4-mlx5-sensor-fix-v2-1-531fee4fd7fd@extrahop.com>
X-B4-Tracking: v=1; b=H4sIAJXXAmoC/x2MQQqAMAzAviI9W5h1E/Er4mFqpwWdsoII4t8dH
 hNIHlBOwgpd8UDiS1SOmIHKAqbVx4VR5sxAhhrjTIujxX27HSpHPRIGudHYeraeKDS2ghyeibP
 +p/3wvh+3REjmZAAAAA==
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Shahar Shitrit <shshitrit@nvidia.com>, 
 Carolina Jubran <cjubran@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Will Mortensen <will@extrahop.com>, Jeremy Royal <jeremyr@extrahop.com>
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 5C15851BFDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[extrahop.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[extrahop.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286983-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[extrahop.com:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@extrahop.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,extrahop.com:email,extrahop.com:mid,extrahop.com:dkim]
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
module sensor (sensor index 64 or 65 if we're on a 2-port NIC). So when
the warning event concerned a module, hwmon_get_sensor_name() took the
64th or 65th element of the likely 2-element temp_channel_desc array and
thus returned a pointer to some other kernel memory past the end of it,
which was printed to dmesg up to the first NUL byte.

A further difficulty is that, at least in testing on our CX-8 C8240 with
firmware 40.47.1088, the warning event can have bits set for other
modules, e.g. if this PCI physical function is associated with
port/module 0, we might expect bit 64 to be set, but bit 65 (for port/
module 1) can also be set.

Fix this by clarifying that the argument to hwmon_get_sensor_name() is
the raw sensor index, and correctly converting it to the hwmon channel
index. Return NULL if the sensor index doesn't correspond to a hwmon
channel (e.g. because it's for the other port's module).

Fixes: 46fd50cfcc12 ("net/mlx5: Add sensor name to temperature event message")
Signed-off-by: Will Mortensen <will@extrahop.com>
Reviewed-by: Jeremy Royal <jeremyr@extrahop.com>
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
base-commit: 70390501d1944d4e5b8f7352be180fceb3a44132
change-id: 20260508-b4-mlx5-sensor-fix-043d4a22f641

Best regards,
-- 
Will Mortensen <will@extrahop.com>


