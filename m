Return-Path: <netdev+bounces-277709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCQqIeNx2mln2ggAu9opvQ
	(envelope-from <netdev+bounces-277709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 18:08:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C93E0BF4
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 18:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 658ED301CDB2
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D883A6B66;
	Sat, 11 Apr 2026 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGk70xXO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A221CC71
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775923680; cv=none; b=TF80VaPvVRbVn3qKlbeDKv+2Swme65ZOx/fg6f/se4iPe/qOzwPxqSKRANTAcLOunqrLwfgRl4b56hNjTKl0JkPRjoEeeJIiTdt5UCUcrRp0N7pT0olT8+Dc3jEY2fG8KBt4JcDNqKnLvsGopl4eB5I3NEMvPgO6bY4pB9QC7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775923680; c=relaxed/simple;
	bh=IoRvBl5NbwVmePrT/sLsz6MCHOaWq/wLqfn9iURD72A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFc3WzBPkgZ1NOkFYp2ksJDPCtVV2UUMhjjeIHfh7/orFck2dF52c5cHydrrvcDlhchdin5tQHcPhhk/tl8WSQaVcujElUWgG07sVHDPM043O50O+5411GOnY6tQlb8clR83Z0RGTX3MnorpOG62G7cRKzjHghl0oJTS3cEmo6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGk70xXO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so40234705e9.0
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 09:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775923676; x=1776528476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4ngqPMcB97z9LiWUOSiTShgxTHtSI2/jBhJeR2rFVk=;
        b=QGk70xXOueS0TRYHlkyxWAaOKtJM5KTjB6nXIuJYBcfw3YPA1F3QZ5V5MvET0MTLf3
         rrUv4TwARnASrleKSUfFJpN2ZDVQHssqeL0TZCsA9fgd9ZrestbFC8Exsy3X4F/sg3lN
         4+req7peOggnNrYuTvz9SE2nEBpMx9bGkl+OjfP77eLOj8T1KlTzRnbRFzi0wnxn7gCD
         RZZhhIWQmsY/4U0bD9CYc5W+C9Xc8ftK2kGE4S+NRLcVzZ9DpVWgXxFNJ5ogUYnY/eX4
         MxK1H66XChb6r0wc6McTR8Jc3+ug8TfMTkUJBXnDrZ1iq2nw2P1zfMi594iDCSSdBLXk
         PUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775923676; x=1776528476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4ngqPMcB97z9LiWUOSiTShgxTHtSI2/jBhJeR2rFVk=;
        b=XR0OGqnCi67tfH/CA6uQiBxSlUnnTHv6w1oiGdK1nPsHjU4NO8frBun53Rwjo2MXNw
         zH/IlNVFUhZ28UEtWc8p7t5jQndGh7OnC2ehlqeWMK3wOhRXfCEZ7doM9I2YLL+3dsDM
         TbcvAMDlupcmFKqxqgfh5ummrol60pZZD09f15lcMwUcBQMIZNUL2QWYtlQjaQKyylPM
         +QXvIRMX0hNhg4yCOm9xXbEZngCeldc0RkuUL60IegDP3s1lVz/ji+i/d/ZWHvryyuvi
         oQ4eTrd473wy+bxzfT2DCi0P4gYHeL4WtqsauOwzMJxTKdWDiSHSdSqIHXfd+ccxCZUM
         XeCA==
X-Forwarded-Encrypted: i=1; AJvYcCWUQXXAoGMcc5BR0diSEQZzvPcU9A5KcxxoohBbHmDIFJy0XU1lnrDCxamMihqKYAw753Nje9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDZ5n3Q4uYpl8YLT1+RO4/bm1OkoHf1Du4cR1PDaoBtMJSTZq
	y8RVD5iteKZ0w8ODx4ua6X47Zcp4F7KCmG9U/p3VFCR1cisQ8W9wBDnH
X-Gm-Gg: AeBDietgcMOb6tPuC5Q1g5zWlRmJDvv7Ja3sh51+ffyfkbRhq1+QmovffC+5zwwmPs5
	XbZAAxiRwOoNskIgbFdZecGR+ezppE8aznb9O7Kb+jz1XSGcuX8VPHjN7MfLaI52JMTkyiHuioU
	lSvur+dFjxDj8J+W5YjYc6+2HWo0giiJ7CnEd+rrHP+RVjGY0rVSpqdBeqJazTUJq+5s+gMyndM
	A6QgaMdK9maQ6WD1BF70fEvnsU2uQsqngAocaTkr/wOvg5D7N5yGDy94JQ7a5S40YGANY9qXaTr
	URcnYmQNx0bcG/b3LXEy/fpZwSsOYq0jxeiDOJYfavo7qizbyEAQXfptux4SuOBmTSZ3ejuqW5w
	CDcN45YQA41Xmupo2X7z53VWocQykOmMisQePw1UAJ8qvdUDPVaHQue7d5fD0uJXijaeJYeLzBQ
	mNqtNEsYnv3W00YA0WI0zFLNRurx+5+/avU2HmLunBzg==
X-Received: by 2002:a05:600c:5308:b0:488:8d44:bf98 with SMTP id 5b1f17b1804b1-488d67f088amr97620445e9.7.1775923676105;
        Sat, 11 Apr 2026 09:07:56 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:1ef3:1f1e:3a7e:32e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f1f9sm199900805e9.1.2026.04.11.09.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 09:07:55 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next] r8169: Drop redundant phy_init_hw() call in rtl8169_up()
Date: Sat, 11 Apr 2026 17:07:50 +0100
Message-ID: <20260411160753.201182-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277709-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,glider.be,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: E79C93E0BF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

phy_resume() called immediately after already invokes phy_init_hw()
internally as part of the resume sequence. Remove the explicit
phy_init_hw() call in rtl8169_up() as it is redundant.

No functional change intended.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch depend upon [1]
[1] https://lore.kernel.org/all/20260411142956.88343-1-biju.das.jz@bp.renesas.com/
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..cb22105f323f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5032,7 +5032,6 @@ static void rtl8169_up(struct rtl8169_private *tp)
 		rtl8168_driver_start(tp);
 
 	pci_set_master(tp->pci_dev);
-	phy_init_hw(tp->phydev);
 	phy_resume(tp->phydev);
 	rtl8169_init_phy(tp);
 	napi_enable(&tp->napi);
-- 
2.43.0


