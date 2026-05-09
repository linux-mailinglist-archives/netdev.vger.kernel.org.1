Return-Path: <netdev+bounces-286221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO5xAkas/2lX9AAAu9opvQ
	(envelope-from <netdev+bounces-286221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 23:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6072950196D
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 23:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F32E7300D87A
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CF3375AC6;
	Sat,  9 May 2026 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW32ZTS/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3A3CCFC9
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778363456; cv=none; b=M/Sqi6KRxkPk2l0pETjzqAu58WiRKTjeKfLTCz62olk5TrY9sEwiDr7bMtAXarWXfUq+j3dl1BTiIHnxw+aoDm4noDFifizLEP91CTmYw0RbwlvS9OEhWG44QU3fQux7q8bKQmr7e1RYON4mq0IYFiQ0CNY5in0vI5bb//VmpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778363456; c=relaxed/simple;
	bh=zZ4zRaKGq3lXVJHzulsLNYmFoDhtm/d3hxn8G7IHlb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmmeODb0KrQnjcxxXR7ePoFOxLNP3qKuUbIWc5wf7NIr3FoO4PzfNy1xsDYw2lkkPH0TtKvM4qMZvy9o+KCCDdLyFpHNUTXEQ0gpK4ciNs1GGMZuRaAtdQqOTj432nbwhU1UQHpVf/6hz8u+OdTtI68/ehDp3IHHz/TAvebsQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW32ZTS/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so27092195e9.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 14:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778363451; x=1778968251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvqluUKCfP5Ei1uU539utS8CTMy0nMi+hBfXFQXhHRY=;
        b=QW32ZTS/DAak+S0VHi54BQZ0fyp71bh2NvPX9fDbN4XLgZMeKd0oJ15sgh4gnKYvA5
         vRbDayEUc2PtHZ1+oOvBJpTIoUQ0/LunOlYKvkO+5qexDjyPWx2e7Y5HmlzVR4r+qkTa
         Bhif+gBjUrUB0nRZtY1rvl2BBztlfsV5Uo4alYftiQqMqUTsqCjEnuX0+dF44y2T968R
         Gq+DWWnT8phNKHoT0+bb07kCsghjI0wipiRgF2LoqQMtYTksfK0fiuMHDWknn/w9Cgh6
         0iySToaUXACAxpFTwHGFIvxfIDDjt6OvB2bp4CpssjcB4xc6pzsHnLJqkPkeum7jtEda
         ES3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778363451; x=1778968251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvqluUKCfP5Ei1uU539utS8CTMy0nMi+hBfXFQXhHRY=;
        b=IZ2S1fOtF3gOxPdT2tcTkBYw7XFnhVEiM7eu5wkMp6/k7WHE4SnF7CLgTiYOBu6jMD
         4O2ZsVYbpgXPOPwlwJ9tzQMbflVHYHdiW01/q4SJNMb8iFN8OUvrCOudSH1hI1NKhbad
         iztIJI+7JApVPud7ZRsl/DajPlAWovnfE30umeL3b8ovAVmHMeD+0jCv7D1GZAVq/sFu
         /ZLVMMr1ICs4hb8JdlTLVFN4Z2sugtLZIOOPr5Me78qsVE4ddaNnJRY3OIV5f+3pVSTa
         2MYgsl29UiSSlSI/mib2NYViBKvV4d3eJHkqKT74HOC1liWAPw68Sw6VTV1a/FAuxe6o
         5Gnw==
X-Forwarded-Encrypted: i=1; AFNElJ/SdjlVnTD8o5vPeXYB3LewsjjYwQ0LTNkE1qM2D/70ruQNQ+gudogj5HeXk7ie9mlGSQ4H5ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3akDT7WFe8PqujQd4Blj3WHZQPNhk8U4ZWwc8drpOtr8U77ot
	H2OxHZUrW+OIjtaFLIzZAlsVGlFnwUKQzv8/JPgf2SpCnf91A2reUGcE
X-Gm-Gg: Acq92OHiw2NbgVjrMuDYNHv3vQHhQhTjEhtl+f1FL02TcxmKvYn2oNyTZB3p7T5rnOJ
	IvlQX3JGXdTOsxuhhIDfmOr9e6S7blyea5RWHt8+p+JIJB/mnHkbp8TJ0kLc3nkcdMGcIlIpW/S
	gS/O4UFB/q1xlPzgMxE5byCtYKAb1MotqCpEVDZF8URT4EyrwEjECAewj0Xcv+hN9bwTVs37Wkz
	ayIcz7GjsWfrlH/4AqYhSe9XPztQXqislbVNLTDHZ0jvKPm1DiE8+n+wp73KPww5lRxki9hien8
	zjPlb8+T8pvh7PVoRK7zz/JnM7oAwD2aJ2UezoGtjFJH+VTuwbaZO/nNGksTtwohmMImgys3zAV
	V6gMwY/N3FVZOD3YeaqqCHfw5qYiAHU6kp/fgXzs3CR3UTEcJEEiaYkW4ln74JvnBaeF5oWp5PG
	wgMqrr5xQYq1Nf6ihFkoMSrfqCVzSULwdb+FG4S/lAPyctiYiqIyfw5pVTbSjj98ysuVDf34dFH
	oVrJOz52n+9qyOUKtTGFQ==
X-Received: by 2002:a05:600c:17d2:b0:485:ae14:8191 with SMTP id 5b1f17b1804b1-48e51e0a8b9mr172833435e9.5.1778363451396;
        Sat, 09 May 2026 14:50:51 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702ec426sm71076565e9.10.2026.05.09.14.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 14:50:51 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net] net: ethtool: phy: avoid NULL deref when PHY driver is unbound
Date: Sat,  9 May 2026 22:50:46 +0100
Message-ID: <20260509215046.107157-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6072950196D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,armlinux.org.uk,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286221-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

phydev->drv can become NULL while the phy_device is still attached to
its net_device, namely after the PHY driver is unbound via sysfs:

	echo <mdio_id> > /sys/bus/mdio_bus/drivers/<phy_drv>/unbind

phy_remove() clears phydev->drv but doesn't call phy_detach(), so the
phy_device stays in the link topology xarray and ethnl_req_get_phydev()
still hands it back. ETHTOOL_MSG_PHY_GET then oopses on:

	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);

drvname is already treated as optional by phy_reply_size(),
phy_fill_reply() and phy_cleanup_data(), so just skip the allocation
when there is no driver bound.

Fixes: 9dd2ad5e92b9 ("net: ethtool: phy: Convert the PHY_GET command to generic phy dump")
Cc: stable@vger.kernel.org # 6.13.x
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/ethtool/phy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index f76d94d848d6..ddc6eab701ed 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -94,10 +94,12 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 	if (!rep_data->name)
 		return -ENOMEM;
 
-	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
-	if (!rep_data->drvname) {
-		ret = -ENOMEM;
-		goto err_free_name;
+	if (phydev->drv) {
+		rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
+		if (!rep_data->drvname) {
+			ret = -ENOMEM;
+			goto err_free_name;
+		}
 	}
 
 	rep_data->upstream_type = pdn->upstream_type;
-- 
2.53.0


