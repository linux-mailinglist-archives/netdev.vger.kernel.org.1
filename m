Return-Path: <netdev+bounces-206481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5B9B03440
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63840176FB0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 01:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8541A5B8A;
	Mon, 14 Jul 2025 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgfbiZps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952663CB;
	Mon, 14 Jul 2025 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752458255; cv=none; b=EjOlKb3/CdVcBcAuHJYacV5cdMCP+isEEiaag/Er25hg8SOvtSJJRMzWJbGrciQsuB6J1TOtCSaqdTxssmwDZtmMN750pzZRxh3K5Tc7PImU08QcB2D0K64mDs5qbRt5arGozys6xMU7Nvvma0AWZFB4OSoWzJj3bvID3rnO2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752458255; c=relaxed/simple;
	bh=tXjeutRppXmvBhfxh8YB3OK5XDbxuYC5z68U92vFtas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2IzPXKn1lWt1D9pbkVHx9fSdX5MXG8jgsBL8V6f1ftujQ6ERWsPm4vrvYnsxmEDRrVvoKKMncGCNaa68cCLHUW3XgSzlyUNmRj80iXcow6ugS5nCRrtaQWbBuszp8QCAuK2X8ylXlq8CYUG4C3VTy1Yn396VFe5b7nNDrC6rqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgfbiZps; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so10158632a12.1;
        Sun, 13 Jul 2025 18:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752458252; x=1753063052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSUx2XgUMsGQsj10m/9SoX9P5P+4nF9nfb9/i8DE2zc=;
        b=MgfbiZpsf3yb57MaohNVp0DMTgFNWrcbagmDF8ccuppah+tPU5tKnm6GEOv6FCxIpE
         mI97zcAIQujZ/iHMUnzp1y0r7vS4w7Vt52YP/bE2PhuFKrYWjtpFHKFJHA03fpkQv4mf
         gpK/xvp8khYl8EL4Tqdgk1g8wRUm4EkyczD6gga8/pYt+9WKEMkhODK6TyVIl5sZMIgL
         rOYwWVdnov6uOO1qyBnhPIBgFTZG9Cuw/a2gv4oY8VQD8bHY9kRrbScL+g56RgmJ5pqj
         h4cuNiCKn2RmfwrtgGT+2p9WOXo7ov6jTBvVJhNSDk64fgpEzvmLkSVEJy2vBo68+p/J
         Z1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752458252; x=1753063052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSUx2XgUMsGQsj10m/9SoX9P5P+4nF9nfb9/i8DE2zc=;
        b=ZVqUvppzWwQyTQ/h4eM694smLB3dYx0swbOUzWodk2unK/FcWR2U5nn3ObuKvYmY3D
         MKfGlNWrDVkQ0W5A5lUL7fAKf6SL+luOtkYvqOU+b5mv26f0Yp+F1QR7XUyeSxY8EeJf
         jhyuZK07GrQsjuQocknaXi7frDpNaEGcs8A72hBszVTu+TeMQsYHzTP7/2kRa6y+GmR1
         keu8ClIqtXxpFywZa/Gfbplk/ir3B+G59dXuInCqiMkqgRHfF9chjNwcDbX/yLB1JZCc
         7hUeaMdcIaksmzkuI5+vaRNoP4B0WCdVN2aDU36mp/DHEd3JHjYS+j8mKp2v37Cxz882
         re0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1toqHwFZA8s+lEk4egTme/NXeIr284qGpeFPifI6JKEM9haHdXedXX+dMreGauPsWDfsq3+7sVJ8=@vger.kernel.org, AJvYcCWAzRgELnAHyR50GVZQvq2lzJw9ZRjDmHKgohnqFLLCT32XU7AfmBzVE5oNKk2SbocuY90Ny8Nc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkm0Xr4OU1C6xSdFHW5xiY9JqB47nAEu9U4RsAs1NaufcuzQUp
	qqlRUTrwKipwCwSNytsuo3Wz+UssOLbojakXlaxDh+JzxepnO2zznis/LugqUw==
X-Gm-Gg: ASbGncvTVg2H0+IDpTE5GL8Zuhw6awo/92hA+n3PKZxT2+2rCjcjJ8zoZGeQwp6hULw
	MXZPfPybb3l7saF+FayrVK2MJMaZRL8IAtY4VyRdmQ31QoP+i4RhjTbhrAe7viXGGv0fT3Rdw+l
	99VTiQ3e7coZns0fGkKXqJaRuFJ1wsyktA/Ilwx2LJ8lcb6U0mPhA5yVeeYg9KPlmjax8CEiGSW
	nVUQrNKnrmIaRi6iU8kZYdSwjq4VjC1QnPoU9MllGoHyZW5HkzqKrdFjtQx39ajqawKFxCp5ASx
	0n9FBNd8/nGygBpJFHCyphI520kRh3Tz9KJr7hxHKf/FMDENmgESngtAfpXplbs/B8nf7PHtAKn
	DIy4Uwfw4WqPVUo/TCBSN1w==
X-Google-Smtp-Source: AGHT+IFa6svVjL9+AuRkaH2jgR8aBmJ4UX+oCB50F4KPWSBsF/RKWL0tGAWDm4/rqm8K87yCWsE0Qw==
X-Received: by 2002:a17:907:6d1f:b0:ae6:f7b5:70b4 with SMTP id a640c23a62f3a-ae6f7b570dfmr1450290666b.16.1752458251864;
        Sun, 13 Jul 2025 18:57:31 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dedd3sm734161566b.150.2025.07.13.18.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 18:57:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B2806420A81A; Mon, 14 Jul 2025 08:57:26 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>
Subject: [PATCH v2 3/3] Documentation: ioctl-number: Correct full path to papr-physical-attestation.h
Date: Mon, 14 Jul 2025 08:57:10 +0700
Message-ID: <20250714015711.14525-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714015711.14525-1-bagasdotme@gmail.com>
References: <20250714015711.14525-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=bagasdotme@gmail.com; h=from:subject; bh=tXjeutRppXmvBhfxh8YB3OK5XDbxuYC5z68U92vFtas=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBklSTl6Dp0rCm97Xc+uSnTQllRb980lXb5uonTy+zO3D P8uU93bUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIn0PWb4X8t4eUWfhOdLpiXa 1rFbbz01nnHVffehXxVzg9iEYlOY7jH8lbff8Ye5363l3zzvNRcyOdOsX4S1Tt/zbPbGB4mzepa wsQEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 03c9d1a5a30d93 ("Documentation: Fix description format for
powerpc RTAS ioctls") fixes Sphinx warning by chopping arch/ path
component of papr-physical-attestation.h to fit existing "Include File"
column. Now that the column has been widened just enough for that
header file, add back its arch/ path component.

Fixes: 03c9d1a5a30d ("Documentation: Fix description format for powerpc RTAS ioctls")
Reviewed-by: Haren Myneni <haren@linux.ibm.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index a7f729eb0c3694..24c7f480e31057 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -369,7 +369,7 @@ Code  Seq#    Include File                                             Comments
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


