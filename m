Return-Path: <netdev+bounces-225193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF7B8FE57
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBA718A1164
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00587275B03;
	Mon, 22 Sep 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEnRLZPO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E623D7E0
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535389; cv=none; b=Zb+WzULpKNALRoh6uV7mq7woHRfTcY4dC1enUCdMFBDf+H59HZhAQyFit503xJD4GtSIERsBtmBocazjU+uNvt4eD7stxWDvDpLktZfiUDmqzeJHxjCfEqN/m+T6o9VUaALl/xr8C9+usFB4l3uTTdkbXJRLi9uoexYbYWLO2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535389; c=relaxed/simple;
	bh=1Z/FIrvKbz7+7KzkAOkAw8QtjVUi2Kn58A3/jKJj3TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJi8qRrT60cdBcS2Hy4MWrwQzxCTkHL/LGlJkxVZsPAR5t3anG2xCtfBglHaBM1yULMUb9DKOsP5R/OQEJzk08Wb718l/m/kDTNkKFSKPg+IObd9dwTQ5X/yQbJR4RvPijX7bAVx/dktMtvd3z7kKz5O0s6oFUqkr6Y7/XFTEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEnRLZPO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-268107d8662so44956595ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535388; x=1759140188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gLN+Eh1NQwEjC26VvFwkCS0AGaveETF0mZj2seOGw3U=;
        b=FEnRLZPO3ZttIlJA5PIRijJIUesqOeqtyAcSbd/uRMbgs5VecyOJnreLC/ioKfQyg8
         okfMpOrm7QUmdNHvDpv8G6V9j+k1Tj19NtWBcgEDspapWxUahUthiRpCWukGgNkwo/lU
         jWaKGB74meRoEI7bnHpWpJ3x4ozlONWYbC8vmSQY4bIUlV7MYS48+CghpzLjSaZBIDAS
         xLERbMghCnG2w9QVn2ZelArOV/upBLhBed8XakyMfa05GN4OQMOwCDEJphYqKtMNt2+x
         kVOd8K0w10x/HYTAoyrJ6yajCI0M4XCzSQdh39TIFMoPgl0f1rR2qfIyYJNR+tRAcCo2
         gBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535388; x=1759140188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLN+Eh1NQwEjC26VvFwkCS0AGaveETF0mZj2seOGw3U=;
        b=iinzuB98RF2kn0WkiMFHgFrsqkanE3sj+Ds6RsRXIqCIrNCs+IWcqEaxcSeElw1x2T
         vlJnU1NStkWiIJsdFPAwlKQ581PlXTRQEa+X0NYtUiAd/ZmRRuHJEXs2YsukKl45VIX/
         LOlmt3EydUp35i8de2/B8P1SkKEXBZH2vWscgrP/RtnrD8/1GFZZxMboMKZZIbE3FMFi
         x8oUBPsPI7OAhgIgj44ZsjGKBrBS3XhsG4HLtM2MPZ5fHTJ40TZal/Cj8AYN7905NmaL
         Rp3lH7R7RQYcUnUkmIvguTuX0m77tCXkAYkVMcrI7SJfIZkS2yNL/riXKR2X3dNzeq3k
         5u+A==
X-Forwarded-Encrypted: i=1; AJvYcCUHU7zK/PfrsOxcwo6Og60HURnP5rbWhhuESD4AJPGKt7CXsAqKoWhaH+1e8TCrWfHzmOPbjr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCcrE/Xyb6KLUNXOhnmKH9xDuf5eK6oxxGvcUvAn1rR5T0FkHa
	urXzh8Rw+d4xqc3DtFzeSBl3Vc7oic2s0+e+clJ2QezsfV2aj8CIePEZ
X-Gm-Gg: ASbGnctOOq6ZmwaivW5/B59I3K4rFwflve83weoVBcVFGziKupO0HlowWfk+xkCblYk
	WMJ1FW4ka2BkI/hI5Ko/C6qaiSEIFrjbmqeybpoSSYz27/zUTU11nrLYDTf+5xKeTDrkf2139/s
	FGyxp0WhyMfg435aWP8FZy0yIjJ/JeQaZyFVa0xir/OmWhz8Xxe7UjqRat5h2W4adl8TgnxQdlN
	3OXJZ5JABdhpXSCMfAt+qZwm3ZNOO4j1hlD8HBPhWSrRjkkdrgStelIh2irzOjlJIOoXvJ8fhZz
	cL0TlK6R2S2ORtB9CKl9Gj8wdlAa5ZntVGa8vajQF77PgkhQby2Ncwnm0AVgqhNPRcng+0mby5a
	cfOsRXRcTMhdoW2A2FmloCQ==
X-Google-Smtp-Source: AGHT+IGtm0n1I4e8NG5ZtmJGclD2BCxq19uF73e1qqljRkz9OTvu4KTJehS7N7z6k+2ok3CFb7xF+w==
X-Received: by 2002:a17:903:3d0b:b0:270:ea84:324a with SMTP id d9443c01a7336-270ea843533mr122257575ad.38.1758535387676;
        Mon, 22 Sep 2025 03:03:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2699ae52db1sm116728775ad.43.2025.09.22.03.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:03:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 599B14220596; Mon, 22 Sep 2025 17:03:02 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.og>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux AFS <linux-afs@lists.infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next] Documentation: rxrpc: Demote three sections
Date: Mon, 22 Sep 2025 17:02:53 +0700
Message-ID: <20250922100253.39130-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1523; i=bagasdotme@gmail.com; h=from:subject; bh=1Z/FIrvKbz7+7KzkAOkAw8QtjVUi2Kn58A3/jKJj3TA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkX5XSSnAoPBt0yTZtl8i6/RWrZ///5h41qeM04jjjUG al+/yDRUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgImYMDL8FWDcVHxIw2Ltxley dzby/pHQUZ/xLHbZnOBlRgYKu/TmpjEyLPK+qX45y6dB2Xn9waX3/5i4Wt49pT9fXjR72f6Oc5Y PWAE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Three sections ("Socket Options", "Security", and "Example Client Usage")
use title headings, which increase number of entries in the networking
docs toctree by three, and also make the rest of sections headed under
"Example Client Usage".

Demote these sections back to section headings.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/rxrpc.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index d63e3e27dd06be..8926dab8e2e60d 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -437,8 +437,7 @@ message type supported.  At run time this can be queried by means of the
 RXRPC_SUPPORTED_CMSG socket option (see below).
 
 
-==============
-SOCKET OPTIONS
+Socket Options
 ==============
 
 AF_RXRPC sockets support a few socket options at the SOL_RXRPC level:
@@ -495,8 +494,7 @@ AF_RXRPC sockets support a few socket options at the SOL_RXRPC level:
      the highest control message type supported.
 
 
-========
-SECURITY
+Security
 ========
 
 Currently, only the kerberos 4 equivalent protocol has been implemented
@@ -540,8 +538,7 @@ be found at:
 	http://people.redhat.com/~dhowells/rxrpc/listen.c
 
 
-====================
-EXAMPLE CLIENT USAGE
+Example Client Usage
 ====================
 
 A client would issue an operation by:
-- 
An old man doll... just what I always wanted! - Clara


