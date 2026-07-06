Return-Path: <netdev+bounces-304925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5p40F/t/S2q3SQEAu9opvQ
	(envelope-from <netdev+bounces-304925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:14:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9917270EFB0
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:14:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b="do/cXicR";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304925-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304925-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8114309A888
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F824963DA;
	Mon,  6 Jul 2026 09:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9443859DF
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:29:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330174; cv=none; b=mHS72wPKwnuY8R7LzRp93HlWE0OK6gv9VW7jZU+Z6LlbyMPpzMcnTMZOlHAkzJYhzkRUwl2IBVaiKtFffVINkxU+XQkWmMC8qBPjYQcNQoGKbxhfzhRz0tvFcP0XRaBYGcAg5/6+NvBvQKyd/YR59I5SaDOXYuF11pNoBVY2MQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330174; c=relaxed/simple;
	bh=SUQh+RhOCo4Vqfn+CKs4I5YCblD7K8Pu2ml+xQEek50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uFEOUyIGhQfTryoPMH7P89WI0Z8yRPTKGCJpRPEpzodguZaqSXnm0g7HLvfasMw5ow3T3tAR/q+c2mzlDXCxWQG00K3vkE7nTYI9B0R96PA6C6JbOMJUowlsGFc/UBKBBEt8LOXRewB+TZdgT7j0TS310cre2kY8KXsnp148DAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=do/cXicR; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-474303f3c72so1614707f8f.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783330166; x=1783934966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=73tWBKJ1BJ29OL3zl1UOom/4YBFNm/ybvtvsBtCCP6A=;
        b=do/cXicRVUcxyx9Jq+oXjAWuB+35Cq6sfUeAu2h60e2E71aKjxa/0w/hm6BAbvD+GG
         mM6fXs5uvgBULc98isz/zNrBBUah0FsNVhuYEuWsHiafVS2v+6FT2GG3CtuAJ4k2cC+R
         L6ExSS5IRd4XnOM+xrVAP+Ongb3MXZ/L9XQYra8iBw42RIVXvtU/p9WDGtE9NTtLSKyx
         dJ7ZstvZ0jVBZpFjfpCWyJ1ydKAE6upb+8g/bbhqp3uxNt2ffvFpCZrtpu6lgXHT0JK2
         wAOL2imeiTwt6JFU6IiWka2uwHHStxbHoo6dEzKlM6aukWwaYw5R1xhy1CGxapX1uumD
         bCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330166; x=1783934966;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=73tWBKJ1BJ29OL3zl1UOom/4YBFNm/ybvtvsBtCCP6A=;
        b=lcyn6EqJ4Am+al6Sqm2iawkGjT+BFZcXlyhDdXELIjno7/x6yUvq6XBZtdcLEMWpUk
         uzPU9BfPkrbfjPBOZ9zEQ1m0lZpL5EkyiIDCwpSH+YbOI7+YOTDK4sbwvpce55g92gob
         7Vq/8a55elgMy5UJUlcto+gjLvURBxMgm/9V9vpFc9IzDspchRHxTCkvCPo4W18subaZ
         wfhbjAsdGt2z8OTXKVB+xe+YqJWDMkwoBiYM+MdleM+GzdD2WPR6vDRNw69NK05LMJiK
         mz4TDMkEfwV48GJXw0EXxKTZruXvOCH1JCf1w8SbTMj5hY6+i0EmaKNwv6kPtgmuYZ18
         crLg==
X-Forwarded-Encrypted: i=1; AHgh+Rogbl8UxeWVS0bqonC5UL5IsLCiU9QCyMbTiyPos6ReI8DnaVIo6Ow9JZvlaHwnx5j+GcS9iuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLftr+shF3KCcag6Un7QCCzihbL7c+7Dv+1eSxSZVW1kuPB7F
	q70WJ+mnYICIehXAef+J+aC81jVETk6jXSH+mpw9Pg4d+SRejyBR1uOd/05bu/4wL8wBG1YLUro
	4MRk5
X-Gm-Gg: AfdE7cnzidIp5NY2muyjekzXMmNV8H1lotyzl8LFsWnkVlNrAbnKUSBooIcRQ3N/8t4
	ZRC5tSSe4o7pb1h4oNlXPl69QU4lKU0+IHoaxf7TKkMocKaFry4LZ8rpyRoYfUDZ2bz+oQ5QFQl
	C6A/FPxunyQtE+2+FRtLn0/RG86wBxeS1e/cxd7MhFXmVZcNeDdM84whH0+X6Vbrq9FcwwrZWUW
	kWRBRk+/ZjDweK2CIh/0WT3SI+h/k0KrlMG3RTEWjhSw8aPxHsHONGx3lwsoInTHHoCt66hRdwA
	1ic8eYMg04pEbjTWX3NQQBM6dMjjPrq8u4QC7Iurc5//sWltVmLZw6uQ5uMpnvfKSmRgPJexpfH
	FtokfUYDloDucFeKulDoWrXwWEugeyv3IVgfp3FQkjZ6r5mIAFLrIsaMMUIGjBPBLl2yw+K3Eas
	UH0s42pYObAhhnVCDFBZZOI/6Cn2B1fXi17rLhyPIbGvlc6788nV35zCs59pIEp2gOdPuFix9u5
	n+jtgdKGvPHsCo=
X-Received: by 2002:a05:600d:8444:10b0:493:ba6b:b6e6 with SMTP id 5b1f17b1804b1-493d11f9088mr79453675e9.31.1783330166050;
        Mon, 06 Jul 2026 02:29:26 -0700 (PDT)
Received: from localhost (p200300f65f47db0426af56a07ec3b32d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:26af:56a0:7ec3:b32d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493c637bbcfsm334681445e9.6.2026.07.06.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:29:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 net-next] net: phy: Drop #inclusion of <linux/mod_devicetable.h> from <linux/mdio.h>
Date: Mon,  6 Jul 2026 11:29:19 +0200
Message-ID:  <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SUQh+RhOCo4Vqfn+CKs4I5YCblD7K8Pu2ml+xQEek50=; b=owGbwMvMwMXY3/A7olbonx/jabUkhizv0vz7SxRC24pTRR6f9nN1WVcvvjNMrSJi0U2nBeJ7r Cq0jEQ6GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZjIxr3s/xQMvvA8m3p/nqyT uc7mO7u+vNfP2dT8Ya1sfMPE7Mi4mdtNi/JUXCYdZzvRk65U79i23unii1u/Hr1bp/G0+vbiPk1 LjmfXOON+tjq/Pu5mdaZBjDGx/n9hXGByvs5MhWM83Z81ffqd7H5sVY3859d+r4QjuLxFU235Td uQSw3BQbtPfHv6ROrWNdHZabMzWl5OtxD78MPRPTNZ/OW9C2Ex1yo3esS9K9u3eM+843rBXUfac x4cOTV19Tu2RL5Z0z7Vh9zYWyvhwxoz+ddzb0+NZ1EqM7oYA9lqFq2LbeDmbN1nfJ4h42zc07kB jDzS/94GHxYuEXJndGcvn6/M5v/yil8sB6d9QbajX8kEAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304925-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,baylibre.com:from_mime,baylibre.com:email,baylibre.com:mid,baylibre.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9917270EFB0

<linux/mdio.h> itself doesn't use any of the device id structures. The
files #including <linux/mdio.h> use a variety of them:

	$ git grep -l '<linux/mdio.h>' | xargs grep --color  -E '\<(acpi_device_id|amba_id|ap_device_id|apr_device_id|auxiliary_device_id|bcma_device_id|ccw_device_id|cdx_device_id|coreboot_device_id|css_device_id|dfl_device_id|dmi_(device|system)_id|eisa_device_id|fsl_mc_device_id|hda_device_id|hid_device_id|hv_vmbus_device_id|i2c_device_id|i3c_device_id|ieee1394_device_id|input_device_id|ipack_device_id|isapnp_device_id|ishtp_device_id|mcb_device_id|mdio_device_id|mei_cl_device_id|mhi_device_id|mips_cdmm_device_id|of_device_id|parisc_device_id|pci_device_id|pci_epf_device_id|pcmcia_device_id|platform_device_id|pnp_(card_)?device_id|rio_device_id|rpmsg_device_id|sdio_device_id|sdw_device_id|serio_device_id|slim_device_id|spi_device_id|spmi_device_id|ssam_device_id|ssb_device_id|tb_service_id|tee_client_device_id|typec_device_id|ulpi_device_id|usb_device_id|vchiq_device_id|virtio_device_id|wmi_device_id|x86_(cpu|device)_id|zorro_device_id|cpu_feature)\>'
	...

but none of them relies on <linux/mdio.h>'s #include.

<linux/mod_devicetable.h> is a bad header mixing many different device
id structures and thus is an unfortunate dependency because if e.g.
struct wmi_device_id is modified all users of <linux/mdio.h> need to be
recompiled despite none of them using struct wmi_device_id.

So drop the unused header.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the check that <linux/mod_devicetable.h> wasn't needed by all the users
of <linux/mdio.h> was done on top of v7.2-rc2.

Best regards
Uwe

 include/linux/mdio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index f4f9d9609448..300805e66592 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -8,7 +8,6 @@
 
 #include <uapi/linux/mdio.h>
 #include <linux/bitfield.h>
-#include <linux/mod_devicetable.h>
 
 struct gpio_desc;
 struct mii_bus;

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0.11.g153666a7d9bb


