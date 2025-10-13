Return-Path: <netdev+bounces-228893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 954A2BD5A1E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81C8F4E4A28
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8311D2D060B;
	Mon, 13 Oct 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esxg7Spj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60872C236F
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378640; cv=none; b=lRBL9okQfdc3hIVeKqe8R7GSnRVeE/WTOh2sL1y2ySHj39KunQMrPmQM55HX+RpfgAgoal42HzGCLefDCrH+qDi/YfB/IKyB8Md90ocH/CHfko+tlc/VoT8Xz0BxSdgpFNfOnc+7kojoQeSdQZ/bptCjyZ7nSjZRgoxdWBVE//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378640; c=relaxed/simple;
	bh=AVLqJpkTzGDkjGjECQ/A30yJVZAKz5boh61V6WVysSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8yYlfp7l01WpBsLiPFf5Wl8wRhAcTB7M3RX3GCLAmpBqwD+ZFsKabhg911+Zu0Nlfax4RpQh7qeRX3hdFYveToFqkcXRlqc0FNYHnYh9SkRCqxTlQotXUDUQvpU6IpMrBGgN9OPTNQ4ROmYuOEKM8+ouUvFk0p5S7X4qqfef40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esxg7Spj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-639df8d869fso8455917a12.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760378637; x=1760983437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8TQr17A0c/w6wJy3cx501tFDHGHIqULQZ0dDCA6SSk=;
        b=Esxg7SpjpsT3T7pL5LB1SCyGlsMQ10hCUoCVISMHtwnIz6axlB3dmK2+2T2QfjGwr+
         4vAQpLCoQYnOKz52E9mN/taioQy6aGjyuxzDtSP50XCEPyP0VUlPNCWrs0i152TgyXnR
         Yh+qD7Im59T4G3VgICavCjWow9yMj8N+sYjhqOcvetIYjMymosAPtogfxcAcEcjZ4Vtm
         2f17yQStnJc+LCpaWBEXVBur8oUwIxBEtD1dI5xCasutMYJ7bNAHLWis3gVG34Ib/Jid
         4I3TsE2Ogz13Bz79cPIgYzaPtG2AP5GbE7N+fnpkji58fGyhGmdv2704hf56O5nsX95Y
         kCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760378637; x=1760983437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8TQr17A0c/w6wJy3cx501tFDHGHIqULQZ0dDCA6SSk=;
        b=MCrw3jy0gHHt8IhXhSkUM4i3bZ9IfzVN9bOp20tTYvWwVN4vEQOaKdwYBMTDDBQkcD
         X2jQBxdFb1MBp55T8MyM+orScCKYLBrCcOD7BpT/cckowYHzgJdCj9JbJPpuARP2LfBs
         p+WXL2r1VUy7Yvz6UBMVV5jhpvdhScymwQijGA13XSankRsy0iHRn1p3hb4W409c/gfw
         wte14GEACt180lG/SN0p7rq5dtL+McCu9rRvs8wkIpTRYPX/DgG9uybM5TIYb9icEXqJ
         86DXyz8YyOyuCSZDWR03ea4m9hwU1xds7UUkwT97Zf2ujIKg5zzEpVG35TBCno5rPZK/
         jR9w==
X-Forwarded-Encrypted: i=1; AJvYcCWNVRaO21ZwDxXdO8+kWwkkgtKtTIK+BDGxyzOH0guzE6+qf00ip593MEDmzSz26On348yRFU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5NgLVwIUoMQvgxvzqm6rKPCLjgrxwKocc/3Hkzna2JtEkH9uj
	uNbV8o8c6uxQt+KGAMiYT07NQ2t3PxDeZuvxljV/P9UvN/uohwBP3gzk
X-Gm-Gg: ASbGncuisHNTYILytTMuTBGXRrZHTDftQy3F/syJStCgGa/jwNqBjcN0pALa20rVftj
	r+Jylr8UrVYF+i/3V/5OSn94teJUu2b/xlYvG85uYqzZIy0awgNp8wQ6wN1BnNFKLNh99HCQu+g
	hiV7hM71Iq1Op0GW4pDSrWMP3SlpHjVvSGyE3IlAwH3waCMFp0aL92TNJXbvAqCyji1F6RnrDPx
	7r1y8I/3PjKI8ALJFMFNe/rZiTL0tTX4SfDSJRuWbiKrL/GH5wTYBeHVGQ2UzFE3sceWTf3tkNm
	/uJ1vWpMPB5m9t1UTlewaQDXE+4swNPvWvQOrNcFABWoDpZgE6PK+U5uyNYdAg3L2a8Vz9U5JDV
	Vu8OflBXhIiPhjejewZNpo48+P3Z3ne3eUkw//PiqQ4IGANJVct6J5J5O/mQsVM2/mJehf9xUce
	ff64oWCJ8e2Y1H3RywbTAfTgIUS/mX4csk
X-Google-Smtp-Source: AGHT+IHMsKfo1mT6BshtnlbtPo0AZCG89p0qjJ6kuBj/4Ek0C04B1AQLcHeTkvE+PiPiUgH5trd9gw==
X-Received: by 2002:a05:6402:254f:b0:62f:c6c8:e6c6 with SMTP id 4fb4d7f45d1cf-639d5c3204dmr21034957a12.23.1760378636901;
        Mon, 13 Oct 2025 11:03:56 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c32249esm9154110a12.41.2025.10.13.11.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:03:56 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net] MAINTAINERS: add myself as maintainer for b53
Date: Mon, 13 Oct 2025 20:03:47 +0200
Message-ID: <20251013180347.133246-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I wrote the original OpenWrt driver that Florian used as the base for
the dsa driver, I might as well take responsibility for it.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a27901781c2..8a213950e37e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4804,6 +4804,7 @@ F:	drivers/net/ethernet/broadcom/b44.*
 
 BROADCOM B53/SF2 ETHERNET SWITCH DRIVER
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
+M:	Jonas Gorski <jonas.gorski@gmail.com>
 L:	netdev@vger.kernel.org
 L:	openwrt-devel@lists.openwrt.org (subscribers-only)
 S:	Supported

base-commit: 0b4b77eff5f8cd9be062783a1c1e198d46d0a753
-- 
2.43.0


