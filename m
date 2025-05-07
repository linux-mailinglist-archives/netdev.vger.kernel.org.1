Return-Path: <netdev+bounces-188553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5486AAD5BE
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF18C1635CD
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC871F8BCB;
	Wed,  7 May 2025 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K29WEJ88"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC1182D2;
	Wed,  7 May 2025 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598436; cv=none; b=e9xzx0rE85otothRx3xoPLN9mgNBMDc1d4khwI6C1B6Dj+heC0REMkfB1jCfuWUPLsBkt/S7ZPn/X0JQAhaaHD5+qrdX+8rLFFKBetgiimOgSobGeb2hZIbZTRNJK+PgHb11gLc9e2P6QYyRG3/lZoBgo5z3NuyTqo+HAXBP9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598436; c=relaxed/simple;
	bh=xfAfj1klcleSKHXLxNAOO+8ONspPBsJHamkZ5reirUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2GWjla+0HZqm4BL0HbRJkdL0grFsP1bT80A5Eb9Q8LbbcJEl+ULKLovmHNAO1WImyk4H6y8GrsbdI+olix+T9Nh67PT1hm/cnCE5yco0C+eih9D+IZ2IXGXyrw6m5ZUc787cTlhSXYZTEYFNzx1hBm+32VQnrk23kjW5VJq+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K29WEJ88; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c3407a87aso96699195ad.3;
        Tue, 06 May 2025 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746598435; x=1747203235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rozxfw15XCGd2H6xaiwn51c9kWvMu98WF+4nRevjr28=;
        b=K29WEJ88fMTBk20UdItvrGMigXbDafwjX8jGVTU9sQQiAck0FcE4O7Muofn84BS71i
         3ce6JvkBqIzSdYU8xKiCY3JMYteSm4aHWKZTiNP6v1V2V/l0CMyFgrce4i1jQXPsM7lr
         Q8OxDD+hTHzmTV4hXtlI+i6JTdw+b2tn1yCyA3O79ut5A2ZFvSjTd00oGj9BQoGToy/h
         8rc3jcfVVhR33og6Zowaw9QEs/idnt/2p6HylLt2Z0mU0AdXePXYFN8rcGkbWDS57O+u
         hhHbJ3/MRbWCS5UNtMMoBWbpu1H1hf7CSfRSOAf5g59hh86BLNsV3X22XJwj4kEfQ0mN
         211A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746598435; x=1747203235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rozxfw15XCGd2H6xaiwn51c9kWvMu98WF+4nRevjr28=;
        b=BV8c5M1Mzmi3R+ZVbV882mVu5pwQHIZnqjqaay8FiqaJWg277tsFMKUOs5Bescip9q
         LElHNAQpB4o5E1imoUeYlnEmO1oZQmWsi3DmuS7C/4zMgyzuMJS4PhWFB/8fuSUzKYF0
         zBFXPXrBaMT2ofbthzcTzNrpS+91QN4iCuoMa9M1VfUbRJ8Hcv3LF5Ch5GT0t7XH0wS8
         cxvHW9Lw2Bu3ILrEmvI/yBsPOOFqIRcYICmkpx8uE9Krr/h6fpN8HeKzpp/2/XYPTy4z
         0rnHvr279NDFQt2zE5ALV8nlBKOn448EgiKXzE6zhtyUN/NlEaV7Z3FivtVzdvLbe0hU
         4qiA==
X-Forwarded-Encrypted: i=1; AJvYcCW4B4+De7qbQiPBm3o0xbiSDoIO6py1qYULN1AFc4MOEProXkr1UOXTBnbJ9WvnznRmsABpD6dZFSs=@vger.kernel.org, AJvYcCX6U1urxLvC1DDDdaFHShnyNp4vtn3ESqaww8A/uBh7rHiEB0mTDcRdk1RHFVKIAk55RQGhms/I@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SIjvsBqLx5dk3XgDRoaqyFXurfl0ho9paq5Qnj6TApczPuEq
	1TXX7tCO+EqB8IzeKceQ3uH7bRXuCCgNZNW3WvodVAzWR+8vqFBJ
X-Gm-Gg: ASbGncvTG9bgqEel+GTdmk96Xiyt7qn7ARreNnUQGGtce60ZXZADGZzAJeppxB9bQ4m
	Gvo5clfFeNavsIvfsEdl6xvwN7FdtuxMW2YXDhdjVrHOFUdC8oWMeoOdYQTXh08F5rknB78816H
	tfVKHUZwZiud4hKnWfqmDBqrPUE+Mw9dxo8y+dt8ecDWY/ghDs2cakXA5jCyrujVk/gSyWsa3mQ
	7Jr9DWr5ekwsaZvCNmo40bTijSbuYnd4AODwANcz/2So9mabZyi9rDcprwzeat2lTvAMfHReNtt
	tSvJEZLE1JZ5AVUqMjzWR6USWRHG6ht7i2rCpmin
X-Google-Smtp-Source: AGHT+IHn1JoIwnOddTfG6PRyqZCpjAnehF1wYY+TV7xyiH9zs9UIjbHMUdyCMMVyIeRgK6aA0NFoqA==
X-Received: by 2002:a17:903:478d:b0:223:f7ec:f834 with SMTP id d9443c01a7336-22e5ecc2c09mr32036665ad.31.1746598434443;
        Tue, 06 May 2025 23:13:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522ef9bsm86224765ad.217.2025.05.06.23.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 23:13:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 289E642A3183; Wed, 07 May 2025 13:13:52 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>
Subject: [PATCH 3/3] Documentation: ioctl-number: Correct full path to papr-physical-attestation.h
Date: Wed,  7 May 2025 13:13:03 +0700
Message-ID: <20250507061302.25219-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507061302.25219-2-bagasdotme@gmail.com>
References: <20250507061302.25219-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=bagasdotme@gmail.com; h=from:subject; bh=xfAfj1klcleSKHXLxNAOO+8ONspPBsJHamkZ5reirUg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlSP9hFHpo7Bmol7VRe578uf3OIuf12U978h+pvVje05 O9TWni8o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABMxvcnI8Jb1kPtfpaOCbBst Vhsy8YS0H08O6Y7c6iDOHM+tm9zBzchwboEoa+Qny9+5K9u92ANb0vkrs3s21r3Sa9jFcy6hdgs bAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 03c9d1a5a30d93 ("Documentation: Fix description format for
powerpc RTAS ioctls") fixes Sphinx warning by chopping arch/ path
component of papr-physical-attestation.h to fit existing "Include File"
column. Now that the column has been widened just enough for that
header file, add back its arch/ path component.

Fixes: 03c9d1a5a30d ("Documentation: Fix description format for powerpc RTAS ioctls")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 3864c8416627e0..855139f3bc0e48 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -370,7 +370,7 @@ Code  Seq#    Include File                                             Comments
                                                                        <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  06-07  arch/powerpc/include/uapi/asm/papr-platform-dump.h        powerpc/pseries Platform Dump API
                                                                        <mailto:linuxppc-dev@lists.ozlabs.org>
-0xB2  08     powerpc/include/uapi/asm/papr-physical-attestation.h      powerpc/pseries Physical Attestation API
+0xB2  08     arch/powerpc/include/uapi/asm/papr-physical-attestation.h powerpc/pseries Physical Attestation API
                                                                        <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB3  00     linux/mmc/ioctl.h
 0xB4  00-0F  linux/gpio.h                                              <mailto:linux-gpio@vger.kernel.org>
-- 
An old man doll... just what I always wanted! - Clara


