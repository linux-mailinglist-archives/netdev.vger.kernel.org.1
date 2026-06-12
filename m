Return-Path: <netdev+bounces-298541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oX4NJ4XMK2rmFAQAu9opvQ
	(envelope-from <netdev+bounces-298541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:08:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC41A678122
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kddxlTwz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298541-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298541-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993AA320FFBD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056F0305673;
	Fri, 12 Jun 2026 09:02:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CCC364EB6
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:02:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254958; cv=none; b=U87mel3u+v9EVe4918V+uBmIhyTU/bhM7dR9cMs33eZWyHStvWf1OjFNaNddw354RZnjToQgMp13xy5pq2oqSw939IqW0mASowrVRVVscd8LlMZUMSgnvYbDjU55WhP7HGeYT3CKzYmcObTfRxDqwMENYXkFEym+19baXHrrG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254958; c=relaxed/simple;
	bh=Snih2wzdBaWhmYIg7JrcwcC2g2U04rBEQEUk6Xya7aU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G4wtn2BVSj+EJYsKvqlRbUL6RPfqVHbX6fVs57bl1B7iadC4t9QXnnyTYR/aNxL5rnPA+HWhkJDPDzUPuqUuvXYrStYTQn2r2lL4hNrPp2VEgJCvX1cCA1J1wNRLWrPmrym3wXfHbqtfF/6RBpUm4zc9hSI+sCFFcKd4XQRLGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kddxlTwz; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45efa80e0afso556839f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254953; x=1781859753; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wnl2Do4/fSKXnZL/pTIvY46PJrf1VZEYXTjoB+f/UmM=;
        b=kddxlTwzTveUdqNXKLSjqnXsra8LHAdvgyTSrTpApGaXFA2MLMUGHWcpasT9EXMbzQ
         VEL+aP0ZEV3LxDl0hFQX8mb3MzAf1mO+LNr4shO6dmKPwRjkLrLbDevg2iyj+bvc/FlG
         8nDvn4LQqAhVjGqtldQb07fk24oqPm6O3qFvAbyum/ngpIc1OS6MY/LJYWazG1adDLwF
         OznQfcDz+j9llAUXW9/3PGgfqKOKGmJOnnMIbu4V93IJ/4qNnhVPjW/lJ2rJ5ybqyGKc
         opOyrBUpGHO8c5sqYw3bYelztfk+KttIS9VktDVCxPcmHcD2bcv8AAfXV9vNHVy3S7n0
         aHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254953; x=1781859753;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnl2Do4/fSKXnZL/pTIvY46PJrf1VZEYXTjoB+f/UmM=;
        b=WS3ZMrPfZ3p1mN7ldw4udLBzljM/ZuAFpeqZKWEqXHjxOCrXASX6VzAhAmJ09RSLm0
         2q4QJm44yOJZnXyVrrWbL/2yzHYWX+g+gtwu123XAVirJTAd4KMvJgttOhUdSmUGhXHS
         46tYteqQYRAZ68NhZa37HXWOKdfmO1v4f6Yaashn0ZYePAgRqxpLN4N0tWOmqQ+wa55g
         8L48ciJgjgGG04H7fvsjHcmMNhhrN8f65SQAXmE5RXrKRiJSUPrnXFKZPd8ziPoV7Doi
         p5aB01n/wXwPwPWiJSAZLa+rooyw4HS7bFSFPc41bBLJaz7ULGRU0PCcefU5Y62zA/nF
         sVAA==
X-Gm-Message-State: AOJu0YykoXpydbX5+T0Tf0wwJHyESokhCUUSigRNTS2GWp1gOHKaC7+E
	I4JgrMSsLjxPOkW5294HOlMtTUHiWU/VpT/2zxfiVAZZTCBgHg7KMnRn
X-Gm-Gg: Acq92OGpOPAVFCJgnm5o9j/yPO0s3Stx6pWS+AlBUEpLMAENO40pdYQE4PL4ivXJqwt
	ufOM76H4GKCFpKna3ouqybu+wtwuKlU6HiQ/e+I+tJw0ufnF5LqRCRVNiIyNIsykrInP9SOGxj1
	SbvKFfDTb+j2eXtpWTeJwZRrB6UcyjQ/km/BJGka1sBdIIBlOozKEtgzGMMCC6TcWVmJBmxJwX+
	iOfepHbfapFNZz8lwcaxP+HM1mTbZhYYlDDUzZvKqcKHTS1Gt7VuYwDl0T6J9764avEcCC00N5h
	kb33+Sqa7utkzRlCsujwaftnhUmTa5WVgUlo+O1UWPMwSjpqecQGVc/4T9YvwEQweb+5bd1i4fS
	538Zmi12ZQid0rym9lAb2BbqTbu1WC5P5/XoT9VJxGkD/XWw6qVZYJlQhGBaBGxDwd/1zTZ331P
	ru9C/iy6DzEM/Zq4ME3/vsFv20WRX6uNN26uzmOPcPhg6QLERMmp0DZ4INLmos0bOBfSA78nN7T
	sq3u586dQ==
X-Received: by 2002:a05:6000:2992:10b0:460:42c:1133 with SMTP id ffacd0b85a97d-4606db9fed3mr1796258f8f.14.1781254952975;
        Fri, 12 Jun 2026 02:02:32 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f4f6sm4069951f8f.16.2026.06.12.02.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:02:32 -0700 (PDT)
From: Fidelio Lawson <lawson.fidelio@gmail.com>
X-Google-Original-From: Fidelio Lawson <fidelio.lawson@exotec.com>
Date: Fri, 12 Jun 2026 11:02:08 +0200
Subject: [PATCH] ethtool: add userspace support for KSZ87xx PHY tunables
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-add-ksz87xx-tunables-support-v1-1-0e97a91b78c8@exotec.com>
X-B4-Tracking: v=1; b=H4sIAA/LK2oC/yXMSw7CIBAA0Ks0s3YSILE0XsW44DNV1FDCQENse
 veiLt/mbcCUAzFchg0yrYHDEjvkaQD3MPFOGHw3KKFGMUqFxnt88WfSrWGp0dg3MXJNackFz1o
 7p4VVchLQi5RpDu3XX29/c7VPcuV7wr4f4LgqwYAAAAA=
X-Change-ID: 20260612-add-ksz87xx-tunables-support-577cc70b2180
To: netdev@vger.kernel.org
Cc: marex@nabladev.com, andrew@lunn.ch, kuba@kernel.org, 
 Fidelio Lawson <fidelio.lawson@exotec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781254952; l=12255;
 i=fidelio.lawson@exotec.com; s=20260326; h=from:subject:message-id;
 bh=Snih2wzdBaWhmYIg7JrcwcC2g2U04rBEQEUk6Xya7aU=;
 b=FHuw/8r8yTY44WfL73MiHNVtDZnWrysZYfo5t4jTen0eAveel35+6sKSAY2pxZrdssFUZRn8R
 0IBK1M2DjabACXIZQDdj1KMvaDZeSImCrSKVbNQ44oBs1Ec2j0vZtHc
X-Developer-Key: i=fidelio.lawson@exotec.com; a=ed25519;
 pk=866eH9Bmmpjc+ctgkr5T1uXxBefZzob3tEEuiVWZ6BI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298541-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:marex@nabladev.com,m:andrew@lunn.ch,m:kuba@kernel.org,m:fidelio.lawson@exotec.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC41A678122

Add userspace support for three new KSZ87xx PHY tunables introduced in
the kernel:

  - ETHTOOL_PHY_SHORT_CABLE_PRESET
  - ETHTOOL_PHY_LPF_BW
  - ETHTOOL_PHY_DSP_EQ_INIT_VALUE

Extend --get-phy-tunable and --set-phy-tunable to query/set these
tunables through ETHTOOL_PHY_GTUNABLE/ETHTOOL_PHY_STUNABLE.

Also update:
  - bundled uapi/linux/ethtool.h phy_tunable_id enum
  - CLI help text
  - man page documentation
  - bash completion for get/set phy tunables

This enables full userspace control of KSZ87xx short-cable/low-loss
tuning knobs.

Kernel-side link: https://git.kernel.org/netdev/net-next/c/13655144ddca

Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
---
Add support for the recently introduced KSZ87xx PHY tunables:
- phy-short-cable-preset
- phy-lpf-bandwidth
- phy-dsp-eq-init-value

These tunables allow control of the KSZ87xx PHY equalizer and
low-pass filter settings to handle short or low-loss cables.

The UAPI definitions were introduced in the kernel through:
net: ethtool: add KSZ87xx low-loss cable PHY tunables
---
 ethtool.8.in                  |  36 ++++++++++++
 ethtool.c                     | 126 ++++++++++++++++++++++++++++++++++++++++++
 shell-completion/bash/ethtool |  16 ++++--
 test-cmdline.c                |  25 +++++++++
 uapi/linux/ethtool.h          |   3 +
 5 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 32b971a..09e4671 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -444,12 +444,27 @@ ethtool \- query or control network driver and hardware settings
 .A1 on off
 .BN msecs
 .RB ]
+.RB [
+.B short\-cable\-preset
+.A1 on off
+.RB ]
+.RB [
+.B lpf\-bandwidth
+.BN value
+.RB ]
+.RB [
+.B dsp\-eq\-init\-value
+.BN value
+.RB ]
 .HP
 .B ethtool \-\-get\-phy\-tunable
 .I devname
 .RB [ downshift ]
 .RB [ fast-link-down ]
 .RB [ energy-detect-power-down ]
+.RB [ short-cable-preset ]
+.RB [ lpf-bandwidth ]
+.RB [ dsp-eq-init-value ]
 .HP
 .B ethtool \-\-get\-tunable
 .I devname
@@ -1510,6 +1525,18 @@ lB	l.
 	value (in milliseconds) will be used by the PHY.
 .TE
 .TP
+.A2 short-cable-preset on off
+Specifies whether a PHY short-cable preset should be enabled (if supported).
+On KSZ87xx this is a global switch-wide preset and not a per-port setting.
+.TP
+.BI lpf-bandwidth \ value
+Sets PHY LPF bandwidth register value (if supported).
+On KSZ87xx this is a global switch-wide setting and not a per-port setting.
+.TP
+.BI dsp-eq-init-value \ value
+Sets PHY DSP EQ initial value register value (if supported).
+On KSZ87xx this is a global switch-wide setting and not a per-port setting.
+.TP
 .PD
 .RE
 .TP
@@ -1535,6 +1562,15 @@ Gets the PHY Fast Link Down status / period.
 .TP
 .B energy\-detect\-power\-down
 Gets the current configured setting for Energy Detect Power Down (if supported).
+.TP
+.B short\-cable\-preset
+Gets PHY short-cable preset status (if supported).
+.TP
+.B lpf\-bandwidth
+Gets PHY LPF bandwidth register value (if supported).
+.TP
+.B dsp\-eq\-init\-value
+Gets PHY DSP EQ initial value register value (if supported).
 
 .RE
 .TP
diff --git a/ethtool.c b/ethtool.c
index 2444d85..b7c65c2 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5461,6 +5461,55 @@ static int do_get_phy_tunable(struct cmd_context *ctx)
 			fprintf(stdout,
 				"Energy Detect Power Down: enabled, TX %u msecs\n",
 				cont.msecs);
+	} else if (!strcmp(argp[0], "short-cable-preset")) {
+		struct {
+			struct ethtool_tunable tuna;
+			u8 enabled;
+		} cont;
+
+		cont.tuna.cmd = ETHTOOL_PHY_GTUNABLE;
+		cont.tuna.id = ETHTOOL_PHY_SHORT_CABLE_PRESET;
+		cont.tuna.type_id = ETHTOOL_TUNABLE_U8;
+		cont.tuna.len = 1;
+		if (send_ioctl(ctx, &cont.tuna) < 0) {
+			perror("Cannot Get PHY short-cable preset value");
+			return 87;
+		}
+
+		fprintf(stdout, "Short cable preset: %s\n",
+				cont.enabled ? "enabled" : "disabled");
+	} else if (!strcmp(argp[0], "lpf-bandwidth")) {
+		struct {
+			struct ethtool_tunable tuna;
+			u32 bw;
+		} cont;
+
+		cont.tuna.cmd = ETHTOOL_PHY_GTUNABLE;
+		cont.tuna.id = ETHTOOL_PHY_LPF_BW;
+		cont.tuna.type_id = ETHTOOL_TUNABLE_U32;
+		cont.tuna.len = 4;
+		if (send_ioctl(ctx, &cont.tuna) < 0) {
+			perror("Cannot Get PHY LPF bandwidth value");
+			return 87;
+		}
+
+		fprintf(stdout, "LPF bandwidth: %u\n", cont.bw);
+	} else if (!strcmp(argp[0], "dsp-eq-init-value")) {
+		struct {
+			struct ethtool_tunable tuna;
+			u32 eq;
+		} cont;
+
+		cont.tuna.cmd = ETHTOOL_PHY_GTUNABLE;
+		cont.tuna.id = ETHTOOL_PHY_DSP_EQ_INIT_VALUE;
+		cont.tuna.type_id = ETHTOOL_TUNABLE_U32;
+		cont.tuna.len = 4;
+		if (send_ioctl(ctx, &cont.tuna) < 0) {
+			perror("Cannot Get PHY DSP EQ init value");
+			return 87;
+		}
+
+		fprintf(stdout, "DSP EQ init value: %u\n", cont.eq);
 	} else {
 		exit_bad_args();
 	}
@@ -5625,6 +5674,18 @@ static int parse_named_u16(struct cmd_context *ctx, const char *name, u16 *val)
 	return ret;
 }
 
+static int parse_named_u32(struct cmd_context *ctx, const char *name, u32 *val)
+{
+	unsigned long long val1;
+	int ret;
+
+	ret = parse_named_uint(ctx, name, &val1, 0xffffffffULL);
+	if (ret)
+		*val = val1;
+
+	return ret;
+}
+
 static int do_set_phy_tunable(struct cmd_context *ctx)
 {
 	int err = 0;
@@ -5634,6 +5695,11 @@ static int do_set_phy_tunable(struct cmd_context *ctx)
 	u8 fld_msecs = ETHTOOL_PHY_FAST_LINK_DOWN_ON;
 	u8 edpd_changed = 0, edpd_enable = 0;
 	u16 edpd_tx_interval = ETHTOOL_PHY_EDPD_DFLT_TX_MSECS;
+	u8 scp_changed = 0, scp_enable = 0;
+	u8 lpf_bw_changed = 0;
+	u32 lpf_bw = 0;
+	u8 dsp_eq_init_changed = 0;
+	u32 dsp_eq_init = 0;
 
 	/* Parse arguments */
 	if (parse_named_bool(ctx, "downshift", &ds_enable)) {
@@ -5648,6 +5714,12 @@ static int do_set_phy_tunable(struct cmd_context *ctx)
 		edpd_changed = 1;
 		if (edpd_enable)
 			parse_named_u16(ctx, "msecs", &edpd_tx_interval);
+	} else if (parse_named_bool(ctx, "short-cable-preset", &scp_enable)) {
+		scp_changed = 1;
+	} else if (parse_named_u32(ctx, "lpf-bandwidth", &lpf_bw)) {
+		lpf_bw_changed = 1;
+	} else if (parse_named_u32(ctx, "dsp-eq-init-value", &dsp_eq_init)) {
+		dsp_eq_init_changed = 1;
 	} else {
 		exit_bad_args();
 	}
@@ -5733,6 +5805,54 @@ static int do_set_phy_tunable(struct cmd_context *ctx)
 			perror("Cannot Set PHY Energy Detect Power Down");
 			err = 87;
 		}
+	} else if (scp_changed) {
+		struct {
+			struct ethtool_tunable tuna;
+			u8 enabled;
+		} cont;
+
+		cont.tuna.cmd = ETHTOOL_PHY_STUNABLE;
+		cont.tuna.id = ETHTOOL_PHY_SHORT_CABLE_PRESET;
+		cont.tuna.type_id = ETHTOOL_TUNABLE_U8;
+		cont.tuna.len = 1;
+		cont.enabled = scp_enable;
+		err = send_ioctl(ctx, &cont.tuna);
+		if (err < 0) {
+			perror("Cannot Set PHY short-cable preset value");
+			err = 87;
+		}
+	} else if (lpf_bw_changed) {
+		struct {
+			struct ethtool_tunable tuna;
+			u32 bw;
+		} cont;
+
+		cont.tuna.cmd = ETHTOOL_PHY_STUNABLE;
+		cont.tuna.id = ETHTOOL_PHY_LPF_BW;
+		cont.tuna.type_id = ETHTOOL_TUNABLE_U32;
+		cont.tuna.len = 4;
+		cont.bw = lpf_bw;
+		err = send_ioctl(ctx, &cont.tuna);
+		if (err < 0) {
+			perror("Cannot Set PHY LPF bandwidth value");
+			err = 87;
+		}
+	} else if (dsp_eq_init_changed) {
+		struct {
+			struct ethtool_tunable tuna;
+			u32 eq;
+		} cont;
+
+		cont.tuna.cmd = ETHTOOL_PHY_STUNABLE;
+		cont.tuna.id = ETHTOOL_PHY_DSP_EQ_INIT_VALUE;
+		cont.tuna.type_id = ETHTOOL_TUNABLE_U32;
+		cont.tuna.len = 4;
+		cont.eq = dsp_eq_init;
+		err = send_ioctl(ctx, &cont.tuna);
+		if (err < 0) {
+			perror("Cannot Set PHY DSP EQ init value");
+			err = 87;
+		}
 	}
 
 	return err;
@@ -6195,6 +6315,9 @@ static const struct option args[] = {
 		.xhelp	= "		[ downshift on|off [count N] ]\n"
 			  "		[ fast-link-down on|off [msecs N] ]\n"
 			  "		[ energy-detect-power-down on|off [msecs N] ]\n"
+			  "		[ short-cable-preset on|off ]\n"
+			  "		[ lpf-bandwidth N ]\n"
+			  "		[ dsp-eq-init-value N ]\n"
 	},
 	{
 		.opts	= "--get-phy-tunable",
@@ -6203,6 +6326,9 @@ static const struct option args[] = {
 		.xhelp	= "		[ downshift ]\n"
 			  "		[ fast-link-down ]\n"
 			  "		[ energy-detect-power-down ]\n"
+			  "		[ short-cable-preset ]\n"
+			  "		[ lpf-bandwidth ]\n"
+			  "		[ dsp-eq-init-value ]\n"
 	},
 	{
 		.opts	= "--get-tunable",
diff --git a/shell-completion/bash/ethtool b/shell-completion/bash/ethtool
index 57c39c4..b6a67c4 100644
--- a/shell-completion/bash/ethtool
+++ b/shell-completion/bash/ethtool
@@ -659,7 +659,7 @@ _ethtool_get_dump()
 _ethtool_get_phy_tunable()
 {
 	if [ "$cword" -eq 3 ]; then
-		COMPREPLY=( $( compgen -W downshift -- "$cur" ) )
+		COMPREPLY=( $( compgen -W 'downshift fast-link-down energy-detect-power-down short-cable-preset lpf-bandwidth dsp-eq-init-value' -- "$cur" ) )
 		return
 	fi
 }
@@ -1023,13 +1023,21 @@ _ethtool_set_phy_tunable()
 {
 	case "$cword" in
 		3)
-			COMPREPLY=( $( compgen -W downshift -- "$cur" ) )
+			COMPREPLY=( $( compgen -W 'downshift fast-link-down energy-detect-power-down short-cable-preset lpf-bandwidth dsp-eq-init-value' -- "$cur" ) )
 			return ;;
 		4)
-			COMPREPLY=( $( compgen -W 'on off' -- "$cur" ) )
+			case "${words[3]}" in
+				downshift|fast-link-down|energy-detect-power-down|short-cable-preset)
+					COMPREPLY=( $( compgen -W 'on off' -- "$cur" ) ) ;;
+			esac
 			return ;;
 		5)
-			COMPREPLY=( $( compgen -W count -- "$cur" ) )
+			case "${words[3]}" in
+				downshift)
+					COMPREPLY=( $( compgen -W count -- "$cur" ) ) ;;
+				fast-link-down|energy-detect-power-down)
+					COMPREPLY=( $( compgen -W msecs -- "$cur" ) ) ;;
+			esac
 			return ;;
 	esac
 }
diff --git a/test-cmdline.c b/test-cmdline.c
index c48be87..b9f1a0f 100644
--- a/test-cmdline.c
+++ b/test-cmdline.c
@@ -283,6 +283,31 @@ static struct test_case {
 	{ 0, "--set-eee devname tx-timer 42 advertise 0x4321" },
 	{ 1, "--set-eee devname tx-timer foo" },
 	{ 1, "--set-eee devname advertise foo" },
+	{ 1, "--get-phy-tunable" },
+	{ 1, "--get-phy-tunable devname" },
+	{ 0, "--get-phy-tunable devname downshift" },
+	{ 0, "--get-phy-tunable devname fast-link-down" },
+	{ 0, "--get-phy-tunable devname energy-detect-power-down" },
+	{ 0, "--get-phy-tunable devname short-cable-preset" },
+	{ 0, "--get-phy-tunable devname lpf-bandwidth" },
+	{ 0, "--get-phy-tunable devname dsp-eq-init-value" },
+	{ 1, "--get-phy-tunable devname foo" },
+	{ 1, "--set-phy-tunable" },
+	{ 1, "--set-phy-tunable devname" },
+	{ 1, "--set-phy-tunable devname downshift" },
+	{ 0, "--set-phy-tunable devname downshift on" },
+	{ 0, "--set-phy-tunable devname downshift off" },
+	{ 0, "--set-phy-tunable devname downshift on count 3" },
+	{ 1, "--set-phy-tunable devname short-cable-preset" },
+	{ 0, "--set-phy-tunable devname short-cable-preset on" },
+	{ 0, "--set-phy-tunable devname short-cable-preset off" },
+	{ 1, "--set-phy-tunable devname short-cable-preset foo" },
+	{ 1, "--set-phy-tunable devname lpf-bandwidth" },
+	{ 0, "--set-phy-tunable devname lpf-bandwidth 1024" },
+	{ 1, "--set-phy-tunable devname lpf-bandwidth foo" },
+	{ 1, "--set-phy-tunable devname dsp-eq-init-value" },
+	{ 0, "--set-phy-tunable devname dsp-eq-init-value 65535" },
+	{ 1, "--set-phy-tunable devname dsp-eq-init-value foo" },
 	{ 1, "--set-fec devname" },
 	{ 0, "--set-fec devname encoding auto" },
 	{ 0, "--set-fec devname encoding off" },
diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index a5d7d24..41f557a 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -291,6 +291,9 @@ enum phy_tunable_id {
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
 	ETHTOOL_PHY_EDPD,
+	ETHTOOL_PHY_SHORT_CABLE_PRESET,
+	ETHTOOL_PHY_LPF_BW,
+	ETHTOOL_PHY_DSP_EQ_INIT_VALUE,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c

---
base-commit: 75fd12445ffd6d697d53b7d296e345d524a9bedd
change-id: 20260612-add-ksz87xx-tunables-support-577cc70b2180

Best regards,
--  
Fidelio Lawson <fidelio.lawson@exotec.com>


