Return-Path: <netdev+bounces-204749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A0DAFBF5E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EFE1896B33
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C551F869E;
	Tue,  8 Jul 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfUt7fhx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57EB1E521A;
	Tue,  8 Jul 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935425; cv=none; b=tIJ7ic35yH5JN6ACGDLgay9/NtGMbpmMid4ffMP8mSCb5oTcbzvTm4MRe8XJ5A6qG+TsidFYKAOzufvG7Xqfx5TZZAWkQq7BOOQPKCZUPrNUUbjQSbcd8u3pBZ08Xene/qD5onhip//mi8xqnN43INQABO7bRQ3pFGS2up/3tt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935425; c=relaxed/simple;
	bh=El8HNLBnBPZTccV52jWXgoNBWzmmb8HHjXi+IlnYSpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJS4ZjkKShX1/nvNM76DzyWwyaWyRntg1S2MtKh/SOpz1C5CwInE7nW9JfIIsu7Gd6aUpALOGV0rlQFO4h96aQFbupenx/VyJg99wr4DpNClKCgf71venYAowZDlrkV07e/pe26sGIk1YOKgQ59kAi1vNqKmXorc/lMeQPzqOkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfUt7fhx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23636167b30so37956535ad.1;
        Mon, 07 Jul 2025 17:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751935423; x=1752540223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouZMOhhlyASDz5O/Y7YPKPFa5Hyx6ZziwKAHXGx5Bxs=;
        b=JfUt7fhxUAFnOAGgko6YBuo68/fdRsVDGlroVmppkHJKVy9WFipPDBXPFFCYWrRWkI
         BxtMSGmS5e241ukZC+zSbMka7TSd+1LPC45zwIEEaBEktcsoy2bUX/o5KERNiP8ZjglN
         Kzo8Wmhw6nVl0XA3Xk29z/NAERqFmELrZXdzZcOMNLHYfvrCPkpktBwqF4zp4MJ9SjVO
         5rmww4IHtcoc+BBhL1C6KYbDWDLdVbm+u/bK/QQHvRmuj0PoBcQCscyITQDRG35wSrUN
         gzVVdnst6q38UTDNRjzqV4y0NrAR0jDrgY3mLTJ+khNLfUztmHEkdO+bz/zU8Wi5eahe
         ptqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751935423; x=1752540223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouZMOhhlyASDz5O/Y7YPKPFa5Hyx6ZziwKAHXGx5Bxs=;
        b=rAEr4zOmypPZT09cNAmImcdk4QM5wYvWbgQkMXLvwFRFwxlxBytppfwmvcxURwVE3L
         H9MhAlK9Z4u9fMDdz1oK65bY1+CExgbSOVfrdGnsx8PFLPLY+1MtPbozyl51LBnr+AsH
         tpRq/hWwcLZ7vF+lSEm2yK1uVNTUTyEtrbPhx30dZzGAchGXJtnKtK9QGIDPK3RDeqby
         xYegPOdaeG7WRL9pYwjk+awb1wxlp2czpc21USlEPDXrnChkKxpdJ20amU1PY77EBEvV
         XyqrpRRd6IPJzhMGZ8XOnT+ydIL957wombtIgzJ6Tw11+5Pvpq/ZLttPxzhgpIykFB+Z
         AVRg==
X-Forwarded-Encrypted: i=1; AJvYcCW37tnLD8iOAqLJwWAkdG1m4BOvHjtnKcypbIj2oZEHhO9uBoGv+Fl4DvaeW0V/rUhKE2IbbNMUCgA=@vger.kernel.org, AJvYcCW5z1NgLI+Gsf+iUCLjFpQonAJuuCvBBv/fA4rzWQmUmcq18Zw3Spcdqu0CkkMH+rkDfgHNJOpO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5IYyQLOYvbZ8x+YD+CXOyTluZkGE8voQsY1Y/5NUFUze192MG
	fkmoXbUh7CwFDKBn1gsshMft2EPIS/A54QjUWaEb6gItsuag1ZF0W/tF
X-Gm-Gg: ASbGncvBb9W08HGpaslaP/9GAbYgmn0JQB8bFXBobifIpjZkysvnrLAz4LJQn9lUHT5
	2OtEQrSfQCkU32wDUZp0NqJju8Jz+d6YLHaNpMMqY0AyJptBnPQXQ4iWlcyeJK/Ef5ymlwX2RNS
	IUbpLlQjEdTzvMvR4R846MYrcFXvNDXfhrAPWQTE0kAbJ7ydcZBD2GBXKmuZKbIRTb7jX3OtXRR
	JoUpmrFdzMnjiJwNHagezNP1KiC8fKesC0Yel9npOQUDJQXNWveKht1wBFjZ7mOvi/nZxxRVEBF
	NVOWbM9duw7O1RTiwzzARyAp8zQx/P+6IQk9enfLwamr8Sj/z1h0E8UjqBlLHQ==
X-Google-Smtp-Source: AGHT+IHk89CExQ3LHPfjBWIFyfa1uHO/tpnz/5cBiYKZ08wHHtegzaba85gjefd9AA6cN8etf16unA==
X-Received: by 2002:a17:902:da8a:b0:235:c9a7:d5f5 with SMTP id d9443c01a7336-23c85de400emr207626165ad.13.1751935423163;
        Mon, 07 Jul 2025 17:43:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e15fsm97155675ad.154.2025.07.07.17.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:43:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 21CF14241829; Tue, 08 Jul 2025 07:43:37 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Haren Myneni <haren@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH RESEND 0/3] ioctl numbers list cleanup for papr-physical-attestation.h
Date: Tue,  8 Jul 2025 07:43:30 +0700
Message-ID: <20250708004334.15861-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=bagasdotme@gmail.com; h=from:subject; bh=El8HNLBnBPZTccV52jWXgoNBWzmmb8HHjXi+IlnYSpQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBk5mZpXV3LJNP6c4P9pl/NXkY5/kwIf3d3G/XHD23sVi TvtL3g97yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEvp5n+Gex6tZ8rzlirrN+ Xj4sELNRc8IyFiG1Cxlrdh3jbp7RZ/WEkWHi9cbFh+w3Mj5eKr8w5YLznD+GhybvcLR77Bi8WYH zHwMPAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Sorry if my original series [1] didn't get reviewed at all (and merged), so I'm
resending it here.

This is the cleanup series following up from 03c9d1a5a30d93 ("Documentation:
Fix description format for powerpc RTAS ioctls"), now based on docs-next tree.
The end result should be the same as my previous fixup patch [2].

Enjoy!

[1]: https://lore.kernel.org/linux-doc/20250507061302.25219-2-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/linuxppc-dev/20250429130524.33587-2-bagasdotme@gmail.com/

Bagas Sanjaya (3):
  Documentation: ioctl-number: Fix linuxppc-dev mailto link
  Documentation: ioctl-number: Extend "Include File" column width
  Documentation: ioctl-number: Correct full path to
    papr-physical-attestation.h

 .../userspace-api/ioctl/ioctl-number.rst      | 516 +++++++++---------
 1 file changed, 258 insertions(+), 258 deletions(-)


base-commit: 38d573a624a54ccde1384ead8af0780fe4005c2b
-- 
An old man doll... just what I always wanted! - Clara


