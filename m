Return-Path: <netdev+bounces-234827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C0CC27B21
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 10:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629861A2552C
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE962D660D;
	Sat,  1 Nov 2025 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EthWXMUe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51A22173D
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990488; cv=none; b=NbWIdqwiRo+yoLFm2qWedXPiPs+wcXhNQFs3x1JVgVDX3pZepxWYdP1sZ6MMJ5laSU2nqaZIGjGKtqBkq4PJ3/Lz9A35yl4wPRx5wOdoQuKpzRLniYItj4ZTjisTEOr7kOd/b2D4e9cOvsEU9hXZC4YP2drVBIhdUwOimHsTbbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990488; c=relaxed/simple;
	bh=pOYQYpe/p2QLe1BjNGnDKFKMgBDeR7vUGryegGJSYW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqNk32UF0fQjkkK/JOKejiJNAFJJiCq8inh2cbHyJH6MKEmoKoBYl6qZhFHHfv7DS8H9n3RUZG3FQ9yDyBlKmn4d5Iw3OLO4VZTCWfQ2hzAfaTEyxdxMeu15e0+0rDsZNyEkE0i4JntbY2XPDYuTLJmYD/xC25e20lDkx/FEQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EthWXMUe; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b593def09e3so2240030a12.2
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990486; x=1762595286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itKwJGhZdbxlkpaaw8hh/vRlQCwh4eBKAzIwk/pIlYA=;
        b=EthWXMUeY9lkzfb6iFId1nEUr9wmyk7ZbkLOhThmn4nuEKSHGZjVRH9+4iOuZzEoTa
         DSAZBTzBAdFh2gdzFoD11zyLDsC86DbpSNYnX/mvD9926cLCDYmsbVJLtuVjFKdye8Or
         Cvazgtkl5+SIovxrLStWPxp8gu31hppEjVj8j+UHh9n8qr9mEotsrMBuBw4qhB0n9xPy
         nLgtVdq4y928Bul13GZjJV6Am4pEv2WLg0fpg/03781qeTt/QjJcH5PS+rKCy7B7Uj0I
         Za2RVaX2LRnvQ30pUJnxG16nTC7iYSA/017tgBXAvS+z5wNqlVK2AE3jYmEAzcgsxZmq
         pYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990486; x=1762595286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itKwJGhZdbxlkpaaw8hh/vRlQCwh4eBKAzIwk/pIlYA=;
        b=LdgIe0HD7QSjqXd3ovQm+ylo+UYBe0OxOeQqE4Z7gjA2lmlt+nLD+aYLvdAHJOntKy
         +pIebeMRXEijTuweK/J7LckyWTUl56UsxLTNGQlRLR19iT2+gfSBlETNA3lS9v+YN+4X
         x6nzOz+aRfKOLiAUJrUSCh4Xl04bzKNkfsIUfaF3IzVKI8JwRjngC8LhBv8IYs/trgr/
         OEH20DO6JuKdDcy8c34EcpuR0R/RkSdbbF2Xa/gufQ9bTgNpx897i8wWCeKfmOKMCG3Z
         UNGYKLqtRrmAm3x9Z02VVVG+41ZKZhM3tj34acbAlcLKeSCGsGCUjlnIJbio7vXtwmwo
         Rqhg==
X-Forwarded-Encrypted: i=1; AJvYcCVg/bo2j3K7XSvNN90ehqvpUkhMwxDhGFJGtPF11vVKcQXGNgwFZBgUYZz1z59XIM0SSRWHRK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzenXpkMKAW9KYEyqc818XLLltVIlg5ZHTtHFr2VVsoKSaCM0
	BwxnVblw+PM4Z2L1pXIiak+5mEw0fjNvBsY2I/+K9bQf9GaIJ2b/2GPP+yw/8/ynLo4=
X-Gm-Gg: ASbGncvMCsV92BHEsBlZuNSgwqTdmTiZV1b0vbWLBOA7KoDsIdQDNlNi+vX5IAKFWVY
	v6gLJ6RTBio9NHGaC+lXNg1jayGuP8TD1dE0EUv5i0KUw6Jd6mIUEZN+bQwSBG8loTo3F6pNO87
	NtO+zqotJr2nCZrppXAvsQ/JKmSkHht+K4i75URCW5SRrQsrEfU09EM2i+e6LukDeltWyN4VevA
	/N17NZfjnAwWmGB8EaUmicDBUUQ4Fp+p06/WogN5+QHHaQrLhDzOjanv3uqmQHiq9rhywteZVvg
	Te/WtIHQhFFbNXtofegpEpBJx1iGYJXZqLO+tZkyxSOqntBhcTb+o0sjdKZfsoNyvBz5eGT+zrC
	e93fjI5iHkn/5lc4vJYB1Uk2Lz5K/o2XfihT3VL8SYjEONIB4W0YZi1+0G/QNf6YK5kcdgsJGWl
	Rk
X-Google-Smtp-Source: AGHT+IGmSKAUBfWmJQyRevQMSinNhEHGk8mmuhO/TF63IeIvW13vO2DcRHYCG0bn6xcNqmxzXv7kqg==
X-Received: by 2002:a17:902:e84f:b0:295:507c:4b80 with SMTP id d9443c01a7336-295507c4c3cmr31484355ad.61.1761990485598;
        Sat, 01 Nov 2025 02:48:05 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29554cba950sm21531135ad.97.2025.11.01.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C5F6541FA3A7; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v2 5/8] Documentation: xfrm_sync: Trim excess section heading characters
Date: Sat,  1 Nov 2025 16:47:41 +0700
Message-ID: <20251101094744.46932-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=bagasdotme@gmail.com; h=from:subject; bh=pOYQYpe/p2QLe1BjNGnDKFKMgBDeR7vUGryegGJSYW4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms13KNlx4KFSxULsk3LP3JtY35sWGfXpg2k+SFYP+X2 3yT70V2lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCKibowMZ0r6ZqdFrjr9f4q2 2kWJGVwLvtyy2M357c0KznVcGYJSGxgZbh9tPhniE+L+LnVzSdOyM2f2XuKyycic2vwn+d9mc6M L7AA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The first section "Message Structure" has excess underline, while the
second and third one ("TLVS reflect the different parameters" and
"Default configurations for the parameters") have trailing colon. Trim
them.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sync.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index c811c3edfa571a..de4da4707037ea 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -36,7 +36,7 @@ is not driven by packet arrival.
 - the replay sequence for both inbound and outbound
 
 1) Message Structure
-----------------------
+--------------------
 
 nlmsghdr:aevent_id:optional-TLVs.
 
@@ -83,8 +83,8 @@ when going from kernel to user space)
 A program needs to subscribe to multicast group XFRMNLGRP_AEVENTS
 to get notified of these events.
 
-2) TLVS reflect the different parameters:
------------------------------------------
+2) TLVS reflect the different parameters
+----------------------------------------
 
 a) byte value (XFRMA_LTIME_VAL)
 
@@ -106,8 +106,8 @@ d) expiry timer (XFRMA_ETIMER_THRESH)
    This is a timer value in milliseconds which is used as the nagle
    value to rate limit the events.
 
-3) Default configurations for the parameters:
----------------------------------------------
+3) Default configurations for the parameters
+--------------------------------------------
 
 By default these events should be turned off unless there is
 at least one listener registered to listen to the multicast
-- 
An old man doll... just what I always wanted! - Clara


