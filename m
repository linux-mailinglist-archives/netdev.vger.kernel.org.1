Return-Path: <netdev+bounces-262454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLyKGwaspGm4ogUAu9opvQ
	(envelope-from <netdev+bounces-262454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 22:13:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0721D19A4
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 22:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ECE6300C58C
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 21:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2632D0F5;
	Sun,  1 Mar 2026 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8VPpHI3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6A2E541E
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772399618; cv=none; b=RuFWgICYFClOoBC1KF1cKrytPPibh2Jypc74zadnZPus9/hcD9AwHrB5mI6WSRKxKywL+S6iWF3QI0KviLyKT8IyDzTcc6rAcvdVrsgox1wACvYEWGBmHPGmJ3kDWbM1XAf6shWnieAEzh2LMkak8Vj43A5FzYSRH0PoyX2FLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772399618; c=relaxed/simple;
	bh=d6vpvIbFHmtPkznkoRJUlAcOXTeWOdbOr6uMhzugHnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F4k/JXwbz3vZt7dPG11PvQP/uTbdIUQ716XQpmrPwevc9w+J6J6NuJR4sv1ubqbd6bZdrlgFwjzbWQ+PYQE86lfKg9Z5OPEXGSsH3y6WuXAbg6LFlKTYf1lTQfB7wyU6G42yelcoFlK8j7uFmfkJnT6nxlA3NAuUShf9S/Ui7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8VPpHI3; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56a94923c0aso1171548e0c.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 13:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772399616; x=1773004416; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GaySphsSCD71Pos5FTcKgvo6+hBvgKWDH14YaoSDHAc=;
        b=a8VPpHI3h8OUrpEfsU9cg+byPq6dT/3Z0BBqRGC56fh3XQEZ/JqlDi2zfRDT6DM2/D
         sV276THtIVeksi/n+s3J59O5IPi+hkCxMK/JV1cUilM24l+dG7rLOu4mz43OF0Eh6RQV
         bMyzDGOnGF4YJHedaHQVGqY07aDNVRUpZgrX3+ppVcXWnLomKNCunv0IqgCMHh/JRjSW
         XhFaGT29Xm7ag1BUOP1KbmnvS43LdxomDeIhVJy8VTPr6Nr3kX3gX1ik/BYR0DlBKz6d
         t9EJ1ZgqaqlFUD0FOqx2kaPd2fKKQRWI4CKLJF1fLvzQdO4F05JRSVaAH+Ykmdic2Ssy
         5vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772399616; x=1773004416;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaySphsSCD71Pos5FTcKgvo6+hBvgKWDH14YaoSDHAc=;
        b=KWPtdF3OzHT8SM1VA3UJ+2/oiOSa9y8C7QTSsgKUtGUNsqHBaXa4j1GOWcHM3WGb0O
         gV2zOx5Tbc3k5Lx09jWX0CURERUss0lUpp9/59DuhD5Vg+galfpMzEE7ykZH1L1Ll2Gm
         i+70ug1bOkt5BZlkaHrv+CRxJpa2mFBA0kCKaOGduzuB++734GEm1+0OSYrMpaluiwza
         TgawM7/C+o5IMqjc9x9KK5xReWauq+PaAuW3/pdqrLKQI2J63h9/8+6g3obHQZq9Lgfb
         a7Hhf/z3RCc+lB28ra1BFZ3YHu3QiV8hvPMpzW+ihWwooM2CleM+89CQkSM6RFT/8l4y
         aY6Q==
X-Gm-Message-State: AOJu0Yx7W6GJIwWVe3eXA1mh8qLa54EJ3gQqL8wWmFRWly8SWnSSUP7S
	9soayg4+TDRTj6nFYuawGV7en8KAQzOjxXJRKxfihoaFbO/kdtWs7jWh
X-Gm-Gg: ATEYQzx5QyCbjH4SelJtQ5gl+03mUtonFRxvqZqSi0n9Wbt02epOGK5O5tUJCwn1j2v
	YKy508mnz+2j4WnN1qGHjOS9AEFU7JGbOkhCA0vPIpXyIcd/MlyHcAQRGb5rzf7hz9QEBATflvm
	knZHq9a2/DCOmoCkCDXlYga7BwExsbDqtPKW783BdDwDcnjnFnfbE8gohMa6lBZvYQMi+6L4wg8
	hSFGtltfzSdp98lzlOuHQR662+syambwg0fjJ8vrapnGISwX78dMP+AW21u7s+x2ON+iyMCPRly
	GQivAXthrI346WGi3yfWhWaAqVxRsxQ4owratY8iodThkxf9b6nE5ngcUElLNHBfPY2CxMufU/E
	B+qRrEozr+suDKoPq5pEZjNTxZIC3uqETmU7XEiax+P1/OMooH3KN0VBecOqg7FF18YEKEzKvs0
	UDPpCHH2vd1K+xonRpVc4mLlHUQCgo9jc1IV6OreQ=
X-Received: by 2002:a05:6102:3ed6:b0:5fd:fa29:ae15 with SMTP id ada2fe7eead31-5ff3233258bmr3413895137.9.1772399616366;
        Sun, 01 Mar 2026 13:13:36 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.98])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ff1e3e6013sm11768271137.0.2026.03.01.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 13:13:34 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 01 Mar 2026 18:13:14 -0300
Subject: [PATCH net-next] net: dsa: realtek: rtl8365mb: fix
 rtl8365mb_phy_ocp_write return value
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-realtek_namiltd_fix1-v1-1-43a6bb707f9c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOqrpGkC/x2MUQqDMBAFryL73cAmFbFepRQJ5qmLdi1JKIJ4d
 4OfMzBzUEIUJOqqgyL+kmTTAvZR0TB7nWAkFCbHruEnWxPh14ylV/+VNYd+lN0awNX8am3dcKC
 S/iKKv7dvUmSj2DN9zvMCOtLtHHAAAAA=
X-Change-ID: 20260301-realtek_namiltd_fix1-ee240981460d
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262454-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD0721D19A4
X-Rspamd-Action: no action

From: Mieczyslaw Nalewaj <namiltd@yahoo.com>

Function rtl8365mb_phy_ocp_write() always returns 0, even when an error
occurs during register access. This patch fixes the return value to
propagate the actual error code from regmap operations.

Link: https://lore.kernel.org/netdev/a2dfde3c-d46f-434b-9d16-1e251e449068@yahoo.com/
Fixes: 2796728460b8 ("net: dsa: realtek: rtl8365mb: serialize indirect PHY register access")
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index c575e164368c..f938a3f701cc 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -769,7 +769,7 @@ static int rtl8365mb_phy_ocp_write(struct realtek_priv *priv, int phy,
 out:
 	rtl83xx_unlock(priv);
 
-	return 0;
+	return ret;
 }
 
 static int rtl8365mb_phy_read(struct realtek_priv *priv, int phy, int regnum)

---
base-commit: 01857fc712f6469cab9cc578120cdc80f1c2a634
change-id: 20260301-realtek_namiltd_fix1-ee240981460d

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


