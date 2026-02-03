Return-Path: <netdev+bounces-256279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEqhH37sgWkFMAMAu9opvQ
	(envelope-from <netdev+bounces-256279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:39:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F21D91C4
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B22306ACED
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B2343203;
	Tue,  3 Feb 2026 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWOjw/RI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A963CB
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122110; cv=none; b=tj/oy6l0qqA/v+czk49VqWJCBXo6pcPDwp2f0H2jqNhs752rjTKSx7X8sg2P5lLTLLlT4kmOcn7pCMoWWUuyPPZXA7m108iCDGYr0R4UW3+VkGIs10HjsjjZq/zH7UubAN61UMI6mWKWUI42sMDh3U0jNa7D6UrRUU0StMap+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122110; c=relaxed/simple;
	bh=XmY0cObD+izZ6Dt7mSBTI7kx5XJ7r42/XOxn/HRfsQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REMz2aq+zC0QWhiZFR2RSyrcLs7TcpMC+/viQfnusn06EFV9+2VzX4tSIrmf33wotFOU9YyJtC72NaW3dMC3HsoB3fsIEUCTavM0OIMbc/qWvQac5qqRf193Irp4Ezo1WpZu4ip2VM/S0L78WZKtdJbifhaoPwa6QSuM2h9mJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWOjw/RI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4807068eacbso46436695e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 04:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770122107; x=1770726907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPrqs1CjhbI5+kaToQ6RF5dGRbNhXSkxmd+EPfDPP5I=;
        b=cWOjw/RIMogr1RhxlmKkwc+oecUl8RsH6r5hRfxGzgZQ97cOY8LLOZo2WcdQwJN6dL
         /ep11gs6Q1lg8MDBdl4j7oNnmbVos4dYqok7/opbLhRz32PdA43wNT+ccLrr1F8rIWGV
         78Dp6KtvgSnvE/2+MAE62WQ4WJjiNPrrXrcQUyN/ciQtO/sDRcXQvVtPYul4RKTuVsV4
         00SVu6Fq/7cakWWXJHE4d2jucC1q+yk8rxXd+l9piYl2jRtL5eMSHIQ0QBPJqOveWevn
         HwYp3pbnrqZbnZiJjXT1/PRyTL6SnbgLfy5bSWLTHNQU6h3Rq/lXgEXoB/hhv9G0nVUX
         izCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122107; x=1770726907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPrqs1CjhbI5+kaToQ6RF5dGRbNhXSkxmd+EPfDPP5I=;
        b=S9FrfncnUjLhQcWLzhVIDcUrq9TaJMvCjTb7Wl9K1eV7pVRDO+Sr91wiJIkv4r0yj1
         ENQ2pzmFc1H41VeiFY0Jf8yQ/ACn+U9Zl3WiQ1rgLW89BDSvgbE6ArO215LGWLipgdT/
         2+u179dS9nQw2Q4n6tpR/4XfKWC+nuo5+InKuSPD3GwWtY9KssviIrdHDfbFNWC1MOio
         T9h7cxxUCzqLbbwA2qPHpbq7SgIrFUyLI/DtyJTU8OkMfIYwpeY5HTeVI0UoP6/95CKO
         EhRCkrV5lK1yk2C7nyFPD+DzQsDab8cnv5ogKgoik9oCW9F0KMIYfdiQUIa/zNJstQxS
         YEoA==
X-Forwarded-Encrypted: i=1; AJvYcCU0TxtF98TFh33eSeasMt+Ej4KTG7kXjiJ4GysGdfFxmXj9MmWEi3+aylviFSNwD5O4Ee+fOLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbjK45VJLZJVVwhsE9AYxI2CipmNcQ0dkORGTm0Sxnrr/PeO3k
	ScQrjaQ334TDp2/6G3MsJk7Xn+1qlosQv9GXdwVAcdC7H/lUISEChVDO
X-Gm-Gg: AZuq6aKY3YZnSKT3us+NkDYGZOz/2raGvsXPIkGRs2oNTmpNWf3sDlOwiNhh9bQ7Yrf
	Q+yAn7vkwrSo4x734ieCK2GwkaP1ObavLQE6wFjAcasPeZRaCiXxUT3Mj/Yuwol/V1w70Md2Sqo
	48FsNJ7M+x+Vb5kgAee9Efhfl/X5BWAq7nbxhL8TDGU2oudBLy2wKqlnjjp3VVPLBhpBKkFcfm3
	qL81d2roGkaeqarpnn9CHKMYCXjm1hE158vW/xgOQMQFq1Q4yMppg3mRXZtZKuAGEVKliZ2EJFe
	CJWynSO/cipjuHUZOKdNWw7iQrTqw7hH/EVhvqh04I9VINu/CBZ1tqSQB19TJOZRv54VvLd0V6p
	UjVDRCI9KNTOFbAjPkm848hzywKqmP0C3OSHzVs5tHPcEh7F292PkrRe64UDbwpC38gM/qwf7xK
	l9CqWZmwVf7NkkJehNHA==
X-Received: by 2002:a05:600c:1f94:b0:480:3338:292d with SMTP id 5b1f17b1804b1-482db492928mr210069475e9.31.1770122106665;
        Tue, 03 Feb 2026 04:35:06 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:9cd9:f748:166d:55fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051379c4sm60618205e9.15.2026.02.03.04.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:35:05 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/2] Enable Renesas RZ/G3L GBETH0
Date: Tue,  3 Feb 2026 12:34:58 +0000
Message-ID: <20260203123503.314755-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256279-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[glider.be,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 14F21D91C4
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

Enable the Gigabit Ethernet Interface (GBETH0) populated on the RZ/G3L
SMARC EVK. The eth1, pincontrol definitions and hotplug support will be
added later.

This patch series depend upon [1]

v1->v2:
 * Separated ethernet dts patches from series [2]
 * Added rmii_{tx,rx) clocks.

[1] https://lore.kernel.org/all/20260203104541.264759-1-biju.das.jz@bp.renesas.com/
[2] https://lore.kernel.org/all/20260128125850.425264-1-biju.das.jz@bp.renesas.com/

Biju Das (2):
  arm64: dts: renesas: r9a08g046: Add GBETH nodes
  arm64: dts: renesas: rzg3l-smarc-som: Enable eth0 (GBETH0) interface

 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 241 ++++++++++++++++++
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     |  35 +++
 2 files changed, 276 insertions(+)

-- 
2.43.0


