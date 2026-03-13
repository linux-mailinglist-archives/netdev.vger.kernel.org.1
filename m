Return-Path: <netdev+bounces-267474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBQJJRwjtGl7hwAAu9opvQ
	(envelope-from <netdev+bounces-267474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:45:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ACD2853FC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E47A30B4D5C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835439FCAD;
	Fri, 13 Mar 2026 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KApzdeHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65239DBDF
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411416; cv=none; b=Rk2hapmxHvTJoqGVGdW3YEwUsWXRB+UilMlnodAw/I3Q9a5zijMlSAf5BLqYe6dOCT0nnCaels1BH7b1BTR8I3tk3itBuj22p9VZE8JZeDvILtyPxm5SOdDNFXtu0tU1fruZkUFUzQo31B9WZsr1H6wWHY3JmYNdSHJoq9oABew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411416; c=relaxed/simple;
	bh=RuN0Ldv/9U7l8QmtqeZ4T/0OtDq1G+qZAGOb5aRaWnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qunvBtdts82V8SZjO7SWN0buJuZPfSBFeSw1oXcgSo/vDCdFYGL4arDXRx5ddVc+5F+/rV4Cjhy58ZjMY1EIwuE1bNWzFRs8iF4LlIDEA43Mpg6BuQRrvc/f8JhUO5iaEBXacTuwj2WqSeT22DwoddtnoweEyiU0ve07hRQGeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KApzdeHq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso19481695e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773411412; x=1774016212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EF3xeTr8UCb4d17q9UmVHZHAuKNnKdi+DQOBeYCIjiY=;
        b=KApzdeHqdGNF1DTHgfL/EuxbW1ybyPXGlmr6sVX94eH8K8FFZLqUPVCCe/hqffTwIs
         VIbbYc1ny11PeHr7sOvzMO7mQiEJnpPReP1wXynXYwUYxjcxt0lsRbWVHiiueDzmTvnk
         QrNky+mhkQ13Exx87KuPgtqGf6O0lXMcW9sB4WbOOWkxK581ybbhNKtpt8S5vEhifSiX
         xaJrC2Z19UecejqQLs06q0eKXgtqtA4m+1JnPqv1v5+YN1tgWZoP7oby1x5mWiBl6Kgp
         ziqqjNzbmz6qD+DW6L7OdGSkJyRnTB3xvqXPvPYZJIlvOuwqglRjKfaaIfHwuOS06qZi
         01aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411412; x=1774016212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF3xeTr8UCb4d17q9UmVHZHAuKNnKdi+DQOBeYCIjiY=;
        b=Hqx76+r8fUrPbfW7kHXq0q/7tJp2sOYu0YYim6F2UsgL6YfVY0WtV67p8S+BcISzMe
         9p8xhdIdKXSV32wxA6RozniMHebH0er4GVKFcjPtnkLKO7H/psE52jIZZtIEVqsUMrbk
         +C68m0udduswbI0xnD05Covcao+cNEZBnF8fhk6UzcC5g247MBIQBLPV3e8+cn/PqzRR
         4FSPjKSz8TltihGSDVV2WzrKBX+YiCpZRMDWyt4RodFhOAWE/watF+O8tOaZh7ppQbqG
         9h0OuA1hhjY2gLtT84O+eA7NsRYvtOCs1L9YMASo6iTj0FEfDy1QQnLcDk6ldssDIS/r
         j1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5OrXiuxlQZguFyi6JJXQ3sLrUfQiqs0DUwBFHrQy8lnISqdHxq08l/iYDX5TgWC57l7re6Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOUtw3dWP+dPG633KZvSHncUGfZBVKhgn/uu1mxmJyJ2FN6oV
	WRJiF8i3It//Okk7ETABnzFVXVyX7Mo+naZCjbslwE0kKzkbxQgPBCVl
X-Gm-Gg: ATEYQzwkhsGp2aiK2nfJ2yKFbw/ewT/KQ87LMzk/MO2yLEOsHxM2rpePOjUmf2N0y9l
	aQnEeACzri1VDC3ykCxBnDq2DoCVEMMKpLKmG1XZ2ZFmyYhQfs9yxF9D6SfAH5DELn1BXNnaXVU
	Z8+xFXtOoj+wjbGDnFDl7aSQGVRZ5l84f+jwAT1Rgxj4GKKWLqx0wEa5+tmsqhBHD6Q2DaI3tRR
	oGiTL/mjuGKESuzTIsldqIDG8QKXWc3ZJ7ot8T0m29BDhl0VaucDc+pZyS8Iu9pn2Ve/OarNI0a
	neJgDEytUCa7cS5/OowPpjGWmjjKAMYJWo3iWU1LneXAinz7QlnwoQbWPrqFysdgzyKctl1U4qo
	Vt1p+a0kKwUgCycNpX2P2B6C94v6gHt4WGGRyb1gjk1FUo+gBP7ZQOsuXxqWP4MrHYtvDB2ZZik
	w5nN/5ay+kmqVM47xhqAalXtk=
X-Received: by 2002:a05:600c:2284:b0:485:3f58:d9f with SMTP id 5b1f17b1804b1-4855670c0a0mr39350665e9.30.1773411412197;
        Fri, 13 Mar 2026 07:16:52 -0700 (PDT)
Received: from fedora-dev ([2a01:5a8:304:153c:d983:1bac:a686:ee59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e67ea40sm164214205e9.7.2026.03.13.07.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:16:51 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	enelsonmoore@gmail.com,
	kees@kernel.org,
	oneukum@suse.com,
	n.zhandarovich@fintech.ru
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbezrukov@marvell.com,
	irusskikh@marvell.com,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>,
	syzbot+48dc1e8dfc92faf1124c@syzkaller.appspotmail.com
Subject: [PATCH net v2] net: usb: aqc111: Do not perform PM inside suspend callback
Date: Fri, 13 Mar 2026 16:16:43 +0200
Message-ID: <20260313141643.1181386-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267474-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,suse.com,fintech.ru];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlatistiv@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,48dc1e8dfc92faf1124c];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: A2ACD2853FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reports "task hung in rpm_resume"

This is caused by aqc111_suspend calling
the PM variant of its write_cmd routine.

The simplified call trace looks like this:

rpm_suspend()
  usb_suspend_both() - here udev->dev.power.runtime_status == RPM_SUSPENDING
    aqc111_suspend() - called for the usb device interface
      aqc111_write32_cmd()
        usb_autopm_get_interface()
          pm_runtime_resume_and_get()
            rpm_resume() - here we call rpm_resume() on our parent
              rpm_resume() - Here we wait for a status change that will never happen.

At this point we block another task which holds
rtnl_lock and locks up the whole networking stack.

Fix this by replacing the write_cmd calls with their _nopm variants

Reported-by: syzbot+48dc1e8dfc92faf1124c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48dc1e8dfc92faf1124c
Fixes: e58ba4544c77 ("net: usb: aqc111: Add support for wake on LAN by MAGIC packet")
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
Changes since v1:
  - Replace calls for all types of PM
  https://lore.kernel.org/all/20260304155734.110734-1-zlatistiv@gmail.com/T/

 drivers/net/usb/aqc111.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index cbffa9ae1bb6..dd53f413c38f 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1395,14 +1395,14 @@ static int aqc111_suspend(struct usb_interface *intf, pm_message_t message)
 		aqc111_write16_cmd_nopm(dev, AQ_ACCESS_MAC,
 					SFR_MEDIUM_STATUS_MODE, 2, &reg16);
 
-		aqc111_write_cmd(dev, AQ_WOL_CFG, 0, 0,
-				 WOL_CFG_SIZE, &wol_cfg);
-		aqc111_write32_cmd(dev, AQ_PHY_OPS, 0, 0,
-				   &aqc111_data->phy_cfg);
+		aqc111_write_cmd_nopm(dev, AQ_WOL_CFG, 0, 0,
+				      WOL_CFG_SIZE, &wol_cfg);
+		aqc111_write32_cmd_nopm(dev, AQ_PHY_OPS, 0, 0,
+					&aqc111_data->phy_cfg);
 	} else {
 		aqc111_data->phy_cfg |= AQ_LOW_POWER;
-		aqc111_write32_cmd(dev, AQ_PHY_OPS, 0, 0,
-				   &aqc111_data->phy_cfg);
+		aqc111_write32_cmd_nopm(dev, AQ_PHY_OPS, 0, 0,
+					&aqc111_data->phy_cfg);
 
 		/* Disable RX path */
 		aqc111_read16_cmd_nopm(dev, AQ_ACCESS_MAC,
-- 
2.53.0


