Return-Path: <netdev+bounces-233853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 489F5C190FE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B26A9355190
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19A03328F7;
	Wed, 29 Oct 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwexq6nr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63314322C60
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726401; cv=none; b=Y2v/UDDLgy/Sunm3tRpUYWQQIHxMv5WvTCglVcUhAe83lXVJqVBbwc3/S/j5tKl4oAlZBdowWCO9xqPDju8lPwwQI5O7mhx+Ya+hlDcfQEiNgij14KKFYbImQNUlqbjO+hYlGjrXvuRI054yffXZ2fANJgGKZTdXX9LD0+lyUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726401; c=relaxed/simple;
	bh=iwYylQ8AuV4Dwv48M1+UsyJjpTEomPIpnnYBgnEaLEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaWgtVB7r5gIe3QTpq/N3YowkWWuX8BpYvsASq/Sm79EN6bZePMWt2F2tV731UP6IuCKWl8lZPMKhsYyCeoBLYAMuDVaSEf3O2a7PRft2sVEKN7Iquxw7ieNsnqHXjgQBPOeErlsqLberD+RrgE4i+5R5T6zQwRKhEc7QKGZd6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mwexq6nr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so710837b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726400; x=1762331200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWLMkuBEjPNHOX1jtcXuUOzSLXt4OK/n+U6maOQyI/U=;
        b=Mwexq6nroam4j/AVv6x33k7EOtq66tL0llBbYjbSzj9/bzhqsQYkd04oIHfA1+Iy1/
         NlF5BbLHsnW4arOqX4gxBiOCOKyWZQqdENvVm1TVqRSlz36LLF+C9s0zQpsiy3iDN5r4
         pifDlX0dTpu2R361MvoHjgfAG/opHZ7qC1389R+hMcNuGc6/gHzBJ0xvtI2vpKC2yc9o
         H19nvoAl+VG4QZotasOMDHI2+WK2oNHF/aT7/AEFrLfsvoqJ8wAQQJWBm7xmmiKhYHre
         hfGJBkfKjh/9uidZqb6teA0c7+Ggh7IC+egdor2qdANxPpZxicHJAnIVfEexkyNFFcR6
         8FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726400; x=1762331200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWLMkuBEjPNHOX1jtcXuUOzSLXt4OK/n+U6maOQyI/U=;
        b=qOoiNYy1MAhWfn5FIWjoF0fMoAEMAgg70hZ5ihJJ5t3G0bsc11HvqsR8m6S4dNFEEx
         Ik6goPNJ4X25k/Z/weuJk9Qz9QAvYXmWylJQkI8MGUMlNSojdbkuXXGa6GV4fB3zHR15
         SwfktLsd0nkoAFPOgdrf+cCRNaMIie5RCqnWno1uIH4GXis17f/opafT7A8qRyUfwvd/
         5/4+Dh/sP65QjCaWuV/CS3ccqq+1jShp9NwDOub3uLnd1VadR04Ld5rqKGcqLIDt8jsB
         46NXmHRp4P7gd1bJbccP4QOZFuBoiSLdKVYYIkMNhWbsweI0Av1Zn00isGN+JGTbUrSI
         4AXA==
X-Forwarded-Encrypted: i=1; AJvYcCVPVBaL2WwiKprZvUDJvf1axXEjIiYftwjpPgWh06jji9IxXCLU6AOoRrsgWfz/y3KMjq3z8KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2hE65X8MJb4XxIy+ACpJp78asFLHDF6y3QvkiDBbt0csqtfD
	CwxLJCqYfc0xBoyckSd0Pe5Zq/U4qwsFPNYE3E5+kNgo8L+T9sD4ss4u
X-Gm-Gg: ASbGncsqLQozUfalwIxQi0pC4QrQgaBFtwLL7u9G/vbXiELwlpHuYAc6B6w8x0E7N9R
	2IyBuQFjgzVTTZCmpJBsxMxeE/HE8WdtKh5JYTkWZ7hXVUF7Qpb5T6OQdoWz7gfS5+z++FLRP4c
	wrcbAOGteZDmyuiTx3FQ0o7bnCzEjiK7stYOomGm8OOoHRyvHZHuQsMNIohHO4Mz+DCLKL9wtSc
	VvmNHH/hYvohaHI060uyd2aaHBvvyK4AeiGlXfb7o1iFfJ/Ie7o8e2WSmsrCt8zKGNSyHlnfszH
	BpMY+Jg3lqNtr3s+ZBcUn7kya652CAqHHvyr05yrl8rhd/VC8VsiOCF/Lt9nWwmP6XvXTtDMBdw
	2gdqFLXPaBbVwTNTJerxDN50cyTSMuv8CUubnMlhKZEQnKMH8eXPhiD9+jnl0xKWp4ZgLC3bIN+
	t6C4dNAKqBMz1S+hxfyeQXOg==
X-Google-Smtp-Source: AGHT+IFVPQNroTDXnGwGmdI4qVP/vYNEi7i6hJaoqjIk6/GCV39T3NC2T1TRLTj4se14ABHn/IHX7g==
X-Received: by 2002:a05:6a00:130f:b0:77f:43e6:ce65 with SMTP id d2e1a72fcca58-7a442cc2c03mr6582791b3a.0.1761726399703;
        Wed, 29 Oct 2025 01:26:39 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41402e570sm14326342b3a.15.2025.10.29.01.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:26:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BF4CC41FA3A8; Wed, 29 Oct 2025 15:26:19 +0700 (WIB)
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
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next 6/6] MAINTAINERS: Add entry for XFRM documentation
Date: Wed, 29 Oct 2025 15:26:14 +0700
Message-ID: <20251029082615.39518-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029082615.39518-1-bagasdotme@gmail.com>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=bagasdotme@gmail.com; h=from:subject; bh=iwYylQ8AuV4Dwv48M1+UsyJjpTEomPIpnnYBgnEaLEI=; b=kA0DAAoW9rmJSVVRTqMByyZiAGkBzymgretmajEH8Gt4qs6FZhwcqEbXXScnAOlKIf01L2iEJ oh1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmkBzykACgkQ9rmJSVVRTqMvwwD/Z5O5 PPrnPq81NjHLoWYI8Yx0P+6QRHzuZpcnCK+3HJMBAKApdR5dLHiz6ANWO1EodYtf3Z0vGB9tRZn B1HdrDGUN
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

XFRM patches are supposed to be sent to maintainers under "NETWORKING
[IPSEC]" heading, but it doesn't cover XFRM docs yet. Add the entry.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d652f4f27756ef..4f33daad40bed6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18041,6 +18041,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git
+F:	Documentation/networking/xfrm/
 F:	include/net/xfrm.h
 F:	include/uapi/linux/xfrm.h
 F:	net/ipv4/ah4.c
-- 
An old man doll... just what I always wanted! - Clara


