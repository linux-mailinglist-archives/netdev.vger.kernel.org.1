Return-Path: <netdev+bounces-241100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D5CC7F391
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B173A2692
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECE72E8DEC;
	Mon, 24 Nov 2025 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+r+w/Fg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D432E888A
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970051; cv=none; b=Ks8l/2PKA+wNHIMDNN1TpkV9gWAgUUFORYXVioCdlmsFmy0nXCpcU5HdA6D6yvAOS8sCckEmMO42jaQsvC27VlFlmw2LA0MIKvmqcVoEXfCsRML/lD4/X5KaK1waitlJHX1d+nW3yTYt+f+mEpv2OlsoJxQtHZSrCr0iedWwx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970051; c=relaxed/simple;
	bh=hKAm1QP5iQ7ylT35WgFBWAPfi25FIgtwnqpMskXuvBc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HMrmmUYEx2kIxmEwqoZlbPKUEqwcCY7xPcwT4dfyUqUP6w9aS81dA/QjAgspSek0CLiU/OaT/BJxkmJ4vdeXtLNsJH9rNV66Tn2gSDigBbYuonyjQibU7Pu2e1MyGaV1nkeNBFVENy1i+AfGwL15dE9+shpgDB8MdpQs8oYkywY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+r+w/Fg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so4293981b3a.0
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 23:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763970050; x=1764574850; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3ae9Tov7fRV3Uo1/Dek/6qZPUMAqPH7nxpirY9041o=;
        b=d+r+w/FgMR1uAX2L6ltDFBVKP+B9z82ehM3ttYgd7eNmPMxF73HaV8m1rHySvjBxQ5
         ZUPH/CYCbxMudlQeovqfNAnjppnvAUM5ktRe4mDnGYWk26LN7fYpNAi/8Ja7VfEL+CE7
         m2WlRNjiBwxPAwTGyIrbkMrYUPs1t3WHuJGXSl7JoD6oxxHqZMiJ8c2c+PPYO4ypJkUw
         P/pgWsVifPicWTviHmicSHkvKlrXX2bK/RgkJ5ObpORR1pa2E7czX2CYdx3xffaVNT4q
         RJgVtefe8JOy0yHkrBqV1gVxcUCXoPy1CsC8tXNskrHZN4m8w9TakF/rRJ2ch9cr6s4T
         AAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970050; x=1764574850;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3ae9Tov7fRV3Uo1/Dek/6qZPUMAqPH7nxpirY9041o=;
        b=a6wj2ORwgl+r+e8fWy5BiqZmvgH8Uf2L1tNtEhIfQN3q+CT4pjfQFQWCcx+3o6WzuT
         trFIRCHstakXU/ftIAnIhdhrwbrzttH6EI7DMA2cAsFHFpa+flOtPGf4pRtVv10gIX31
         nS+fBtRT9rO7ub5eV6V27L+M+Kto5tjAPH/qlpIpKspxF6TZ3J7RFVzWjWqifDsWcxN5
         /uEuMD+fb6imi8dnyCyh8X02i2tjf3GjxrOpGyOyXlpifkAlhdvTXJkIBcHXpMMZhHN1
         x4MvpOaDUeFc5IZkRLvJ+Zq2nowH5ytEF1NGaY7ajxB14JVUu483HlYXtkRkXxg7GLmE
         J+vA==
X-Forwarded-Encrypted: i=1; AJvYcCXTVj/jUJffoPt5+tCV6KZh1TnOSEBdyeeeMGKQduCzpHPthhSWbxYFtLf/DInzG7ePFCCSwTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmoSvOmoWmtgXLK0exfLRHwsWvgUdWuK1Jp3rgQTc5hFdeOPU3
	nwGIl2pZJDPvMuGu2DBVW4GZMtTgx5sOPaLAskmIalMy2Rb22GKlluBb
X-Gm-Gg: ASbGncukcJxCgGCMu1mz3e08mrYjUV0z5NHHgT6jTGRal9ShKlPzPAv3oP8z2/tViUX
	38cuGIHnbSw5C336prGatjj9JGxOsnEpXEGstQx63CIffiCuD1KbJe9+y+MmZ5vGeI6Vro3kgN6
	sc7C0rnXV8EaKnBZrl306BIhQGbD825jsYIW6Y+k8JrMMVct+Z2tPQFRgytHujlrO6NdHduMsK7
	nwu7xrUzw2FdNUedQQcRApGFtM0EKOsR0tyQ96gpcn0CkJbk07aSS7ZNOC51FCgQG7lotiUq9Oc
	k2G89TeTr7GVpmpKwCnwZ/N7fI9GMXX2n3q+eUoj+5T3xfLGghZ1AanwnwpjcBb6Hj7LXOhIBlS
	E8WsvOHrrGeo+QR8BD4CWtHgBU5ugwPcWM6JEhR2uCkSWzLFkh9EA8UjsfSWNzkw5e5whGcDRL/
	f3C9RTvR/B
X-Google-Smtp-Source: AGHT+IEeIql7pb0dkGALdREf6Wnlrxqh98FLLAtvq3DFqrdy2TFXbtLBHe88eniPMafYpkrG+cQ8oQ==
X-Received: by 2002:a05:6a20:3ca3:b0:35e:11ff:45c0 with SMTP id adf61e73a8af0-3614ee21050mr12748684637.55.1763970049661;
        Sun, 23 Nov 2025 23:40:49 -0800 (PST)
Received: from aheev.home ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f024b4aesm13410818b3a.33.2025.11.23.23.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:40:49 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Subject: [RFT net-next PATCH RESEND 0/2] ethernet: intel: fix freeing
 uninitialized pointers with __free
Date: Mon, 24 Nov 2025 13:10:40 +0530
Message-Id: <20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-a03fcd1937c0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ally Heev <allyheev@gmail.com>, 
 Simon Horman <horms@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=hKAm1QP5iQ7ylT35WgFBWAPfi25FIgtwnqpMskXuvBc=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJVuH8JZcQ4PdmQktghYcHQyPNXLvWN98Ps9aU7KlLOT
 fn18rNLRykLgxgXg6yYIgujqJSf3iapCXGHk77BzGFlAhnCwMUpABMxmcvwi7niw2P7f86bJDr6
 He3MnC8JqebN+Hf/ZqxH6H/+Ct1ddgz/C1KMz2QfTVkk724QIxtTaCpiteHpnNV715+apK2VJfK
 fFQA=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

We could just fix it by initializing the pointer to NULL, but, as usage of
cleanup attributes is discouraged in net [1], trying to achieve cleanup
using goto

[1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Ally Heev (2):
      ice: remove __free usage in ice_flow
      idpf: remove __free usage in idpf_virtchnl

 drivers/net/ethernet/intel/ice/ice_flow.c       |  6 ++++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 28 +++++++++++++++++--------
 2 files changed, 23 insertions(+), 11 deletions(-)
---
base-commit: 24598358a1b4ca1d596b8e7b34a7bc76f54e630f
change-id: 20251113-aheev-fix-free-uninitialized-ptrs-ethernet-intel-abc0cc9278d8

Best regards,
-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaRn0WAAKCRCWPaLUP9d7
HPCSAP4tu8ld+4Og65tjSYNChRqIR4Gn8C546JFeozyQW6uj3wD/SQEPIidSAYbb
klXrZrKIBOc/avt55S2+krl241aNJA8=
=guHM
-----END PGP SIGNATURE-----
-- 
Ally Heev <allyheev@gmail.com>


