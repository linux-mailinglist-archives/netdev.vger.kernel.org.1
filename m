Return-Path: <netdev+bounces-188555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7783AAD5C8
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41BD1C20C19
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AEC20F081;
	Wed,  7 May 2025 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKImJjQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9E205E3E;
	Wed,  7 May 2025 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598439; cv=none; b=oG8KdT2mxc9WwDxi9mAKiyZqywqU73ZR/mu3N8KUxHschgxd/5MAENWh+zQ72F0tguGhixN38MBHF05Ovz5Mg4rnfeSPeNUERXA9H9aKLkBnggVn+y0TbUUyBGf/Krymh5RLvwgBENXGAmM7Tm4NpbsVyfp8k12G92qdEYI63Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598439; c=relaxed/simple;
	bh=pM9FqZnVNazjsTy87XiYOeCdoktvmor3drEddnsJK5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2b4Gc5NbAXNPBTwxHrno1Am0Wpwhxg2lSLaBfuE8hl1FYeJYix34yL74n8wJ9qik5s4VO4WQtjQ/KhLqhD1oYbo7uDeuwuveevHlJQNNfRVAS7zwRXMmyP6uPm72U8xuItI+HRiMWegyBFf9pZwhfWa47/f/ta2gJ7VYBTNVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKImJjQO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30a509649e3so3818510a91.2;
        Tue, 06 May 2025 23:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746598437; x=1747203237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vm+0Lb5O0nFfHF45Rxd0EU26SBQ9dTBWQWsUCmh1So=;
        b=SKImJjQO21GIU8ypGd2ITxBnd/AhCWzBsw0lXibObiFp+XbBUUqiwlTXHk+8LBxU9s
         NerE7Hw1x3AdfnP1BDkkgSPzXQ50/5foF6jEQ5DTXpE6asW5htjYxc5hXQuE0nkBPEEt
         ubEUjjAtR98bTmDdGECSAs5AFw23xJ4J8xGPXfvZbC+RDUgqd4Zb8pVu3B4f0Mov6hIb
         uYu8oyeY+IrEQKJwhU2X8HhMPpj+ch1x7HCwGkB8mOsdTRE5Cg9EHCOoAFjA4qnjh9Sw
         On8G4Sq7D1W4V8l5wgb4+EaeYZAfxP1wEjulaDBh+DxzFbV/puGb8U/AZpFMjXGfj8hk
         5z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746598437; x=1747203237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vm+0Lb5O0nFfHF45Rxd0EU26SBQ9dTBWQWsUCmh1So=;
        b=jaMvXXtLOSbqxzHfn+gubjlsVlwBy1e4Vgh0OC3mOYuFxI3mJFK6nE4Ex2z5mqQnP9
         FXeJiX4MxXHjgMkAutAxcE1lFiXDIo7UVVt0B63luLFovWi4HI72NwVppXvnIYjTKquO
         YZ2vp8o1K08OZ1oa5LzoDXt5RQyG+vKkdn0WS1Hyj1WehyEQ+h+9dYp0mlSTHJXZTry+
         DqVUmmL6gB0NGjNBU8pzsK1SqEdIoeGeomPuwB1//SQwYJox8nAdU5NbIg+KtTkt+/4w
         AF5dhXnJaHdb/v+rFnxOO/dslsSHhI9lWh8A365AE4eG19yX+fUGwQ7OeLd/l3peGUw1
         hEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyf1j1T5rm4LC2GZrBCdeEoEQojKipXeOaf8zTquwpN3dmPXLEZifwcH2LIwGFIOOQlpnO8lcC@vger.kernel.org, AJvYcCXQJSIbB+czeFbxMsdKzCLISTNGw5Oq2HIv7OhWB8dG2Jp4NSWAFP8Wa08VzpzwBf7i8Fk3wQykSRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MIuro7CSIhhPCb1aM3YKrBythHWB5+ofaz4HYngFkxcIvmE9
	0CbAChosWy3ATcnlOyezfaaLKMm1x5suRhGp9xNEFWgrIdAbzLTy6bmfjw==
X-Gm-Gg: ASbGncspa7LhfWHFL+0JUM5qnKVPbO/uyyNSVpn4LnkcFPUN4d0kbbpYLiEa4vLYfz3
	TO0TrGTs1WwlnTk7ZKVfN/yAwnCHSmMpiQhTYdKVVdUZImclf5teJIg/mnKCoVtdPTaYArT49YC
	Pu9AGVKiFEX+XK88k6WgFcZlNd1PlgmIgQepVFdASf955NH79O0oaPGL3JJdZHLCBiQePoejrtB
	ySzrjISKv6/zF2Sww27yPpX+4O2zQpqVCEIbZvexZrxm5BaCS+FP99E+5Te+pN+1+BG0X8CDUT+
	RoFfN6p67+ojz/dEcJtpSwEFVDrUPjBYizzAlZvo
X-Google-Smtp-Source: AGHT+IHieGl0XKScok6vqvy/w/N8xUPc60HTW65R1OFneHoR2yn38l0NW+LUejGODqY9FuJITKOr0w==
X-Received: by 2002:a17:90b:3908:b0:30a:29be:8fe1 with SMTP id 98e67ed59e1d1-30aac19d3c9mr3558333a91.9.1746598437436;
        Tue, 06 May 2025 23:13:57 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a81015002sm2201345a91.0.2025.05.06.23.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 23:13:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BA9D0427A6BB; Wed, 07 May 2025 13:13:51 +0700 (WIB)
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
Subject: [PATCH 1/3] Documentation: ioctl-number: Fix linuxppc-dev mailto link
Date: Wed,  7 May 2025 13:13:01 +0700
Message-ID: <20250507061302.25219-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507061302.25219-2-bagasdotme@gmail.com>
References: <20250507061302.25219-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982; i=bagasdotme@gmail.com; h=from:subject; bh=pM9FqZnVNazjsTy87XiYOeCdoktvmor3drEddnsJK5s=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlSP9h7RLe7uX/fZnCDQ2nSg0Bj7h3zHv76JK72nWerD 5fQzP49HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI7I+MDPfbnPj21x/65mLM 9Mba81BbyrT9GzyiP3yeUaGjK+8YrcTwh3vhnK+T79epT1h3KLhpVcCVHjGdjP+dHrc/RbEH6F9 tYQUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Spell out full Linux PPC mailing list address like other subsystem
mailing lists listed in the table.

Fixes: 43d869ac25f1 ("powerpc/pseries: Define papr_indices_io_block for papr-indices ioctls")
Fixes: 8aa9efc0be66 ("powerpc/pseries: Add papr-platform-dump character driver for dump retrieval")
Fixes: 86900ab620a4 ("powerpc/pseries: Add a char driver for physical-attestation RTAS")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index fee5c473150177..b613235ca18767 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -363,15 +363,15 @@ Code  Seq#    Include File                                           Comments
 0xB1  00-1F                                                          PPPoX
                                                                      <mailto:mostrows@styx.uwaterloo.ca>
 0xB2  00     arch/powerpc/include/uapi/asm/papr-vpd.h                powerpc/pseries VPD API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  01-02  arch/powerpc/include/uapi/asm/papr-sysparm.h            powerpc/pseries system parameter API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  03-05  arch/powerpc/include/uapi/asm/papr-indices.h            powerpc/pseries indices API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  06-07  arch/powerpc/include/uapi/asm/papr-platform-dump.h      powerpc/pseries Platform Dump API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  08     powerpc/include/uapi/asm/papr-physical-attestation.h    powerpc/pseries Physical Attestation API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB3  00     linux/mmc/ioctl.h
 0xB4  00-0F  linux/gpio.h                                            <mailto:linux-gpio@vger.kernel.org>
 0xB5  00-0F  uapi/linux/rpmsg.h                                      <mailto:linux-remoteproc@vger.kernel.org>
-- 
An old man doll... just what I always wanted! - Clara


