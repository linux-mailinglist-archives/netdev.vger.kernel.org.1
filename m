Return-Path: <netdev+bounces-242507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34182C91177
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 09:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F14E5D49
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D62DF3D9;
	Fri, 28 Nov 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA3yD3H7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE102C0F68
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317201; cv=none; b=TUWsdb7StW3Qrt8LRVd8iBGVcVC4v8qnW46PbStoDxAXnRGJSZwW2y7r7gSKD6ZOBEW3iDGw2LDlcYUNIMFZaYaam0H/BVITFYYuiSaOGEfNzDQt8hD+2a5jATF2/qnZprpUdyQMnnvZGZdSBr9cnQrdOz1DpBQWkcEfg/NqbUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317201; c=relaxed/simple;
	bh=VEDn59HYgwSpM5f6SpHVK4Qn6/wZXasQ2aEaJSrhMnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7NCrSIeVaev4UqficV/4mkiP0x8zdsNp85qmEukfbuh6IdfU4sI9PMASIE4HOY0SzCDhP0RP3kAAr2Lx4XH84V/gxGdG2WavposkWhGi35FLho3Bm1nyB1LxidsXDNzaLEwwI2SihedRySlJo6ogaIyZKO3WYys1VKsR1Tw50A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lA3yD3H7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7373fba6d1so246505466b.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317198; x=1764921998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCdEW5DYSpMlm0kBp+GwmfbQeNzwRoQFikLTDV4j5ys=;
        b=lA3yD3H7ee7FYQ6JtBKZjRz/l8MF5fuktU5hsdU7U1JsHPSrY17qKBHmUyAlCHVaQL
         yhKuGL4ji/jlgmatV/czm6CAoyyNeijl0B6ghzQ/WvmbgwkTlnU42Hwh1/JVz959qhEE
         pUjbyWWkMzO9XWwQlTDSCzwCBHmR4C+JCW0VQUky5qYp4OcqHLa+a0mwfD4QCkKFfeH7
         MYAGUvWen2Ah4v1KFTJR89BOfBFlEGbeMHsyo7ZQl45f3akdMcYFLaUef2MRQkNExNZO
         n4t7iyoZoVW4/ZOAHVFx0j8E+3ELmLidP1+3c92kqmeILdfkH91l7caacwgJccOAeWZU
         Mu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317198; x=1764921998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MCdEW5DYSpMlm0kBp+GwmfbQeNzwRoQFikLTDV4j5ys=;
        b=qcqrV0W1eyG/Ld8O2tskwpB7DzZxAv6D7R1ttj6U5WvhuawzU4uveS4/g44oo1DIOD
         grR4fhvGx8MpdyqN90v6x2Ip7W1E0FfCn1iwSdQwgmBpkHT2UqDL4DtBtmQtTXbPHS6l
         +TzZH0W2n2pOpsiUIkEyAiZq0LJFxi4hZelN/zD7IHUkXeQMqaNeplDmEjwhl4AY+Auk
         x5h0alaAI2ui6baMJzykTx9xsQOQu0m9XbGL2p7+vfXQgWr5qZ2exiMbdEMVgpIzUSAn
         BUzjZHgpHkcYA077Rzavjktm9EhA8/pE5gVioBkRZQuEmw4hEjp6KTS24qOnNjEJF9bC
         AkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/SJHzGxAC7ZSxdWJxzNV6deg7LnXIBrKxtfngPVo4jW1hlPtg+LBHaAHbObsZCONXEwx06pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK729m1A/d1IizABWnsFqL0LC6mMCJI70bGXf1+xWiw78orvSO
	uw7kqLG187qatm1C1qgt6DoFOpFrdaK7BcnTmsJGzc5mNkqiqJ4/rnPC
X-Gm-Gg: ASbGnctM/zbx2vY4DDX1Ig7qkZ079ycQdsNqGaBUAoXAhiWziGhh5CajtzH4orymXvT
	llpXb4N9GO8YfZ3nd40rs+tIKF50tn9uSyq1EuwQ3cBK9DIfRIeIf5WX4tQPdihT9/go94C/lSQ
	VXBomcKodp8Mpssf58J/m+oMhz1K4+kjaNSb/ZoMCn/qA9rqKwg+DEGpG/Qn8ZD5JAEEnnXj816
	KUjMaNFVwMAJ6yrva8KCrypkha8FUrmeiJnJtFy62EzASmQhBuDSGdrRz/JN6sPB7Yv7HsflSgN
	hxLcJVXnJv5ALWHAMbCE90+DzCM8tltFrr3VevEvJIvkd5HFprUxm0cbffYYulBODp8AqF0THQO
	M1VONyFRS7+dPBPQ0gw/4Hoa9dssnBEumrZKiFUXSh79qzl73cRTBS1ql9WLousBrA8TrnKDuKy
	L+yqk4WMrId7/sZIk3rdj7VnFFOe/STXbh4E7V5wFhe7VX/N2Dc8F2/GPZ7ixlfsXkFKA=
X-Google-Smtp-Source: AGHT+IH+UVopUS2x7a795UVxoRCFv7mI1dfXMhCfhcbrk4IUDks2nQnPlAxE/Mp4oB+QM8OFgVwuyw==
X-Received: by 2002:a17:907:72c9:b0:b72:9d0b:def4 with SMTP id a640c23a62f3a-b76716fcbaemr3251164166b.18.1764317198097;
        Fri, 28 Nov 2025 00:06:38 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a7afb4sm374880866b.70.2025.11.28.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:06:37 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/7] net: dsa: b53: fix VLAN_ID_IDX write size for BCM5325/65
Date: Fri, 28 Nov 2025 09:06:19 +0100
Message-ID: <20251128080625.27181-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128080625.27181-1-jonas.gorski@gmail.com>
References: <20251128080625.27181-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since BCM5325 and BCM5365 only support up to 256 VLANs, the VLAN_ID_IDX
register is only 8 bit wide, not 16 bit, so use an appropriate accessor.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
 * added Review tag from Florian
 * added Tested tag from Álvaro
 drivers/net/dsa/b53/b53_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 72c85cd34a4e..7f24d2d8f938 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1966,8 +1966,12 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 
 	/* Perform a read for the given MAC and VID */
 	b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
-	if (!is5325m(dev))
-		b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	if (!is5325m(dev)) {
+		if (is5325(dev) || is5365(dev))
+			b53_write8(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+		else
+			b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	}
 
 	/* Issue a read operation for this MAC */
 	ret = b53_arl_rw_op(dev, 1);
-- 
2.43.0


