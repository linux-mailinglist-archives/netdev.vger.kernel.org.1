Return-Path: <netdev+bounces-233848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D524C1919E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB82A1CC3F02
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B44F3218BA;
	Wed, 29 Oct 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hi47WkX7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274A321441
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726392; cv=none; b=afsY27doKE31jxdxeC0CJMzTw5/f3aPSs5xaFPEO+dqR5/SaKRgsI7eGCdDRLfAWmcCdS5uSBHmHGuVMIVSmQmZ+6YBCvI+6qags0T/njRBD0EdHI4is97CpGiQWqUdgkTGZki9QpZs3Nk0JPuWsyeKFp3mER3DC0FtgxtdfI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726392; c=relaxed/simple;
	bh=GSr0LS5xRxsWE7V64rIkueqh60w0KTfl0+hSyY9hdd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5DWl0ir+dZMj5udlXpwaUiSCMfr1A9dTuf7GcxZMvRDAN9bU8q3VsSpJFZBiFqR+vbj7RryuhCeAKWOt+sDTRMqrlGVhlzHSyEQH92XVV9EpbTaEJCZBp98TmcxTsmZBRmMsfvzrfJBwgmOPPkwqIlvSES+HdITZN6+25v8wvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hi47WkX7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b550eff972eso4628209a12.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726390; x=1762331190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJm0KiVPvaLAcS9A4OHuh4FHLPmznInTZwPY/pYOieI=;
        b=hi47WkX7L+4AmaZBemN8wXeCvyQNDxfT9jocZbXUJsrtUGWRy5ElEs5J0MuOUEXjwy
         afyz2Lnxwu2TK8C5zg+wU/FkD63GWslsiROM31bCzFgZU27dOUg/XFRJj/VM05y1m9Ja
         KBTAW4tKcIVAvFvnEqyjcPs2i5Dn+4KsyvNjnBWRKlNLWuZ5JY14ctrpnhoJrQ2b2Qba
         cBiCgXSp0zgNmEug6Aqbs94bJqSbo1rOGohiWI2GPTFhmeFpTZtjocXHxi1ap65z1Y8S
         4nm9yeSs4neoe7uCujJIuVr7LUKXMuHpSw5YbpknqHQZNjj1k71/LXjlTYPLF8b46kKc
         rStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726390; x=1762331190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJm0KiVPvaLAcS9A4OHuh4FHLPmznInTZwPY/pYOieI=;
        b=qWKlgUB6V3VXwUv2IY0ApzobX2r+kXQfFLaQPHx3XUjJPHGigwdfutH0NeiwtAWZP8
         M2q55V3852iG0RhEo3ksSiBdYfQbwS0Pj/zBeajvzo2NM87QSHY+g3i1q/9mg/mA8uJK
         zjolpJiE3deXGH58iIbbdhLf621NhiuR2QnMQgH9H/O6Ke+bZeGkKFJSjg+1qiuKgQgW
         FWVUfCQpy1cVTaTMhv/pxgefL+lhuZSJpWCKVgcAGGVIncS0EK2CHSs+Zt1lCmnmQliZ
         G/MGs7F6YIGtyUWXBELNipXUvWePl4iwxFjjkb3AybBzAnUPw4w1zxyhXPda0ZcCbwBJ
         yIvw==
X-Forwarded-Encrypted: i=1; AJvYcCWX1kgzshzkG4PwS65lmIUeVr5+/AZA6H6af0O5L4q+PMHFZ8Aj43Ka2wyvDkM89/IEud/ywtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5ACuBUM67nOGS/8DPTRNgf6qTw2pJ1xoRvh5LmBW9VCkIa4S
	//3fNWD95E3Z0AcsvIbel3RKpjrdJS6HkMk+cXPfKda6zD3+UD0qFBfC
X-Gm-Gg: ASbGncvkyu9WEA25fValznYDXHWQcJdTy+iPZeZOlV3bm8RiK2w5a5hHdTRcUY5xWWR
	S0smzu0kR09d5ssUJf1urWmgLj8Z5JbSO12SBBVq3kLxDqeZ80r9rr0SqrAGErke5cNO+T9RORY
	+Hk3aiEVDY9XISqryUr6Kn0H87WCGdqCTxKSCGG+U/w+LTtLAPINMwQnWsvzccpDROIHQZaK7Cf
	0hQzcNLtY8/ucErloNwryLIreHs4EY7GnaiDb6cvuKbiCNXyGM7wyR2PDYNr/U7SNkuNcFUNAso
	3mWKQp8qbCXP6UA4+/smxWbNZlWH9dG8IVURoY8GNxB5q846CIFXSIriaWaBUMvillUvjSantk6
	1A7ya8D9jc/J35bSocBmBb3+VdLt2UyVWtXREkDO7QEWrsxuyd/PfJwv67QBuboG+JYxvLTeBGm
	ge
X-Google-Smtp-Source: AGHT+IHA303tZEZ4a/W4KwtMHRrxESLDrc7p5KrCU2dbSpWS63eCceiJLPKnu2iFdf9no/xqvg36SQ==
X-Received: by 2002:a17:902:d58e:b0:294:cc1d:e289 with SMTP id d9443c01a7336-294dee12965mr24835135ad.15.1761726389381;
        Wed, 29 Oct 2025 01:26:29 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c414sm142891175ad.44.2025.10.29.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:26:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8A4B541FA3A2; Wed, 29 Oct 2025 15:26:19 +0700 (WIB)
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
Subject: [PATCH net-next 3/6] Documentation: xfrm_device: Separate hardware offload sublists
Date: Wed, 29 Oct 2025 15:26:11 +0700
Message-ID: <20251029082615.39518-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029082615.39518-1-bagasdotme@gmail.com>
References: <20251029082615.39518-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=bagasdotme@gmail.com; h=from:subject; bh=GSr0LS5xRxsWE7V64rIkueqh60w0KTfl0+hSyY9hdd8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmM5zVaz89epr/u1qt1N/LvrDZK6Nvyx+PCYaOpopcSA k7tZL7xs6OUhUGMi0FWTJFlUiJf0+ldRiIX2tc6wsxhZQIZwsDFKQATmfOV4X9o6L9T+WsqxCS5 3Lzjz7O7fFTy6ehyeaCXeOlEboB0pQnDH87vK1mtH6cw+ckpOG54ZfGY4Zb7TdYgyWoZLb3zPrn /OAE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sublists of hardware offload type lists are rendered in combined
paragraph due to lack of separator from their parent list. Add it.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_device.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 86db3f42552dd0..b0d85a5f57d1d5 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -20,11 +20,15 @@ can radically increase throughput and decrease CPU utilization.  The XFRM
 Device interface allows NIC drivers to offer to the stack access to the
 hardware offload.
 
-Right now, there are two types of hardware offload that kernel supports.
+Right now, there are two types of hardware offload that kernel supports:
+
  * IPsec crypto offload:
+
    * NIC performs encrypt/decrypt
    * Kernel does everything else
+
  * IPsec packet offload:
+
    * NIC performs encrypt/decrypt
    * NIC does encapsulation
    * Kernel and NIC have SA and policy in-sync
-- 
An old man doll... just what I always wanted! - Clara


