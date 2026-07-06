Return-Path: <netdev+bounces-304854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EkXVHt5aS2rCPwEAu9opvQ
	(envelope-from <netdev+bounces-304854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:35:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C649870D9C9
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:35:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=breiti.cc header.s=google header.b=o5eEs3cz;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304854-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304854-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 127C73153DAB
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 06:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10E03DB625;
	Mon,  6 Jul 2026 06:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18413DB961
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 06:20:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318834; cv=none; b=RgU+hnhBz2ykeoXrMrZHsC4vGnKNtg0eNm13uElhCJ19OINfu1bSgxJv9S7Hwx6NjOVR/gDircX/FORAqZRWu4SHzJxMVpy2NhSVNW0AF2ELX7dobmaZrJmBWIfB/YHW+0GHE5tIsIN/h8qlGquxIX1C/iAObx32ccfLtJ7Cz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318834; c=relaxed/simple;
	bh=LWglcUmKJJujYCrUKRMCU+qSUx0o9x0XMXsedC1YP84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozgH3ycYNq9nyOgrrzC1hdI3QtR+sPBYy8EtiV9lcb/Ds3kdmKM0lZqtso8v3EQm9PMaVU+D3RtKabjL2e3dEppzFUR4C6NFUrCJTAfuvCMcDZc7BJ6qigedprYQDqZKQTES8aq9yv6iPQHhjyDcmaqDvw9+HEUdq7yXtafkCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=o5eEs3cz; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-474560436c3so2534312f8f.0
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 23:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783318818; x=1783923618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aKPxjwYIwY+lwdwsN7x/+EZw5Zz00YN/j9XJOtJ8WiY=;
        b=o5eEs3czlsHFUQXS2Hy5BmzJMaiBQmR2A2se8dPsAaxu3ixcOzSBNYNq6GlWiNTf5L
         Khj6MmWVv9q3xjhdLTeOMVvmgfVIdSfRVYlM+WvV7dnWyqFh4Z2vOh08l5+BLSNEaDHh
         B3TjV5UCAck6aowEDwbyIHkqxWIIyr5iWep74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783318818; x=1783923618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aKPxjwYIwY+lwdwsN7x/+EZw5Zz00YN/j9XJOtJ8WiY=;
        b=rJI1qU42E32I9kEovsfzZ0I0s2us3A8SwirtKEB3GXweEo8xy77cg2A3q1s1BjdMg0
         YQExy5GsWB4tAQb5oM+t13+HhcN41MhQjA8kGYrn0fHvqeq9Ucq1IFpv2eYRMgAQ48Fm
         dGhleigHIS8IjVcFPzOz4Wu5p8bqmitGHTILydtL53jxbbXxcuY9zMlB6zgvYpceYVEg
         HvRc+eklYO3pGb5Qt2VZ995NgecN6mqrqwq6E1Pm7fShVlZ2y0aMonWKBj1O8sJFkCLa
         QBL6sdVYSl1KGeRRPG8oAzDPwAnO2l1ef9NKFQvDPrTbouu1OZt1iP691VggqgHcU+p/
         y5QQ==
X-Gm-Message-State: AOJu0Ywk90kyrOLnwfcf9UG2XmlVIzv9qyI8A5SJFe5AjVBsL7XgY+Bd
	MQ3ZTSj8G8hFTwhtbtb2hBJ6LzIVB4V3IYVVaOxNQkUZXK3O8fG5RpiFgey84XkElbi7p6oD/4v
	kWvckgXx+
X-Gm-Gg: AfdE7clv2OKfk34yzKmmyUMv+9IelSS3VB+l5sV2K7DkTokadmr/KqrZJJnyUVfdNjY
	3fjEOBfaUo/VvWsd4RjwJbVjRLHDpT6xe9PARDTVNRiv/kJP22BF8YGnMmYCXes0Sb0WHBJJ+NI
	UEbdDP/vyyVpntAF2kvB7jMulYqQA/Bec4ail0kRvwdUMceJi0rli1MCnuqNcW7kBVqA62y8/zr
	4dumwNthU0iqIMJvkXTQ1ajJK6d8GZAGllUReTyZh89ZDDSTxzIQL4h7Vi9mhTDLsYUU7JocrCK
	nDsSBYicrbqrnt2uipTjuMYia5oBefONBkMoxRSDQCq8CJjo+EXDXgYDhJzCUIiJnCJL9l3TDbg
	htdvbakUdEAw5oYVyZHvecWeq2O3x1Z6t9d/ZcaqRaEhJLrEVhqXkyuLCPBS6i15eBYjSPLvH2t
	zvfuBllpuqNZybF82tYSvtO0+cuG95rPv7ujtZKrpZnEQ6pRSKpQ==
X-Received: by 2002:a5d:5d03:0:b0:476:e67a:dfa7 with SMTP id ffacd0b85a97d-47aaa4222c9mr11073751f8f.7.1783318818209;
        Sun, 05 Jul 2026 23:20:18 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm22194047f8f.9.2026.07.05.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 23:20:17 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Markus Breitenberger <bre@breiti.cc>,
	stable@vger.kernel.org,
	Markus Breitenberger <bre@keba.com>
Subject: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on unchanged mode
Date: Mon,  6 Jul 2026 08:19:54 +0200
Message-ID: <20260706061954.94842-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[breiti.cc:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304854-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:yong.liang.choong@linux.intel.com,m:bre@breiti.cc,m:stable@vger.kernel.org,m:bre@keba.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[bre@breiti.cc,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[breiti.cc];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bre@breiti.cc,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[breiti.cc:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C649870D9C9

From: Markus Breitenberger <bre@keba.com>

intel_mac_finish() is registered as the phylink mac_finish() callback
for the Elkhart Lake SGMII ports. phylink calls mac_finish() at the end
of every major link reconfiguration, including the initial one during
probe, before any interface mode has actually changed.

The callback reprograms the shared ModPHY LCPLL through the PMC IPC and
then power-cycles the SerDes. On Elkhart Lake that ModPHY is also used
by the on-die AHCI SATA PHY. Running the reconfiguration during the
initial boot-time link-up disturbs the shared analog block while it is
still driving SATA, so the SATA link fails to train:

  ata1: SATA link down (SStatus 1 SControl 300)

The disk carrying the root filesystem is never detected and the system
hangs at rootwait. Ethernet itself comes up normally, which makes the
failure look unrelated to the network driver.

Firmware already programs the ModPHY for the configured interface, so
the reconfiguration is redundant unless the interface mode really
changes. Return early when the requested mode equals the current one.
This avoids touching the shared ModPHY (and the SATA PHY) during boot
while preserving runtime SGMII to 2500BASE-X switching, which still
sees a genuine mode change and reconfigures as before.

Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Markus Breitenberger <bre@keba.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index b8d467ba6d72..9a162831ca40 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -536,6 +536,15 @@ static int intel_mac_finish(struct net_device *ndev,
 	int max_regs = 0;
 	int ret = 0;
 
+	/* mac_finish() runs at the end of every major link reconfiguration,
+	 * including the initial one at probe, where the interface mode has
+	 * not actually changed. Reprogramming and power-cycling the SerDes is
+	 * only needed on a real mode change and is otherwise needlessly
+	 * disruptive, so skip it when the mode is unchanged.
+	 */
+	if (priv->plat->phy_interface == interface)
+		return 0;
+
 	ret = intel_tsn_lane_is_available(ndev, intel_priv);
 	if (ret < 0) {
 		netdev_info(priv->dev, "No TSN lane available to set the registers.\n");
-- 
2.55.0


