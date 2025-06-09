Return-Path: <netdev+bounces-195611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF88AD16C4
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 04:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8BC1880762
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 02:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74CE19E83C;
	Mon,  9 Jun 2025 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWx7O1rV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24DA19ABD8;
	Mon,  9 Jun 2025 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749435233; cv=none; b=oydbNf7s80irWzh9qRL4wXHN3U97GpwUoR0ijBch2dduKt8MhQ/l5DCg4QZgWc5AqJtPpIG31O61aqFYKuUNtV9A3Jzkz43PTdM3lX8j7gY5/GByYwlA0AXko7sl4zRYbPaaC6nYkOa6iKogezduuHFG79EX2m9mErS29dR0kuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749435233; c=relaxed/simple;
	bh=pKI7PDJDDIBqjgERXsXsauxic7BaA/Too5aSv2HsggU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5hnLUhiC3WDVcCFL2GeRWfJ/j0c37RJ6L3GN2n4AoBftsuJ7YihrL2An08evLacsgsKq5/A98pqbSz/3mB6hOaEzYZOTCHkydMHEacn90LCx8q+IkQY/53Lh/N4dk0PcvwUSLk38786exyPSC9ML2enznlSqDqWnCR++94cFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWx7O1rV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so3994843b3a.1;
        Sun, 08 Jun 2025 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749435231; x=1750040031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6z8EhSmpBxYVZeDxPrGmj000mL8LzmqeVT/fjQjyJgw=;
        b=LWx7O1rVrgAh4IwW5NOMn2wKsVDgQ896YZRorl9NRNR/9gNT3iyMTozXjJmGLBtpX2
         yoWjNaOYnKDOBfPqpO/23aHktwIBBteIH2kKhBhgn8/068S4rowNPLEiLZQAHd5B9Wpt
         WMjpFhiyAI9uuPbJXvGo7R1TAQ8hefIQsNx3tC+9j3/FTjQ40hxALvC7I3mwwbdGL8QU
         /DiacyR/hJ5aWXpzEqAY9n4VZ+7buCCthpha96CzRrsK8wupANDudwgnS/SAuKdXRp25
         ezklqNex4h1r0fVJ9/pq6eg8IpGmqRVTKUkQiI//gakiJ+L7OhfQZvi4Vj+oeQP2Om9r
         r/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749435231; x=1750040031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6z8EhSmpBxYVZeDxPrGmj000mL8LzmqeVT/fjQjyJgw=;
        b=biuHFpvXwALKjVOWPoV+y4kM2PE6x4RYTitBCeGxf3cSY+CVsEmVIyfgNhu2YlZQlk
         DgoJZuxm4sz4BdLuUyNUEqfe7x+JLGpXd3RyXML4qbk3GNGPhPgQ5hcAsemLqfbrbW1a
         M5Dw3bXDLYw/CK5xPsc6QQw6Hf8MFFFHKXu+XJor7hE0u47F3PD47IkLRk2oFsT0UR0p
         v7cxtzBe+3g3pBe/GzKDA2fJd4jCh7RDfGtKOgt/53qRGWUvstCPup1MS68Lp/PncGtB
         pZGWo5S7M0yrbPFIy9l5kZDampt/9xPONu86HOV1fgRVCMfnz3PdG24gjxalYzRTyif5
         F6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC+3DKXATpRymTYSYy1HpnrJCuNDXPcBI9eBKcJNVRoLNCbEDKbndEENmjcL/ezEySdRThfumLG+c=@vger.kernel.org, AJvYcCXm/t6tOpblUdisxaPmkSffJ2kYJxDY1sxZoyyFqnG7p2S890VTVrvZa48nf14mos+Mo1FsJBnng2C9t5aG@vger.kernel.org
X-Gm-Message-State: AOJu0YzWVpeZ3UwVSCxofDdeMrx6zhFFh43TEQfDrLUxhJ9yXrC3sYFK
	yznEzvulaNdPJ3W55iNhTkexnNH1AebOpShC95ISZXi+3g6KmZTL5/ts8bZw5Q==
X-Gm-Gg: ASbGnct/Nj9ds06meSB4q15P9QZcavlR9qLxhCXoUQEhvA7emePSRFVdAzSAdKYWMJ/
	mrnzohW94SLGMmDgoD3FwUtU6QQ9KIdo3UfvN1VSWwEWRj4pa4Q+iUwioppI7JbHhZ3oCRjbMTQ
	CdNwoHMMZPPpMOdVqErqQuabcGuVk8+bQe4rgrs+AbGOryjPN18kAmFEnOIN+Z1cHA8AkhdOLDv
	tHVskLsxFa2LNno4CDStnaPPXWXF8g263VfRFh749R0L5xRX2gDT1FBWWTg+L8HABpswTfDBS+A
	ILyqjKo04PEbGXjalm0Dhv2pdhzUiIMf3J1fcCfTZYIU
X-Google-Smtp-Source: AGHT+IGvA/02yp0vD1aNE7i4OxB7xo4YBi2vBKNkuRZdXgojOa+m7Bh5C8nm1uDK7BXrPsafSk+eMA==
X-Received: by 2002:a05:6a20:1584:b0:21f:5674:3dda with SMTP id adf61e73a8af0-21f56744088mr6492468637.34.1749435231088;
        Sun, 08 Jun 2025 19:13:51 -0700 (PDT)
Received: from fedora.. ([2601:646:8081:3770::889])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f899b35sm3687406a12.71.2025.06.08.19.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 19:13:50 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: olteanv@gmail.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Collin Funk <collin.funk1@gmail.com>
Subject: [PATCH] docs: packing: Fix a typo in example code.
Date: Sun,  8 Jun 2025 19:13:30 -0700
Message-ID: <e532b992a79999d3405a363db4b2bd4504fed592.1749434907.git.collin.funk1@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspelling of "typedef".

Signed-off-by: Collin Funk <collin.funk1@gmail.com>
---
 Documentation/core-api/packing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
index 0ce2078c8e13..f68f1e08fef9 100644
--- a/Documentation/core-api/packing.rst
+++ b/Documentation/core-api/packing.rst
@@ -319,7 +319,7 @@ Here is an example of how to use the fields APIs:
 
    #define SIZE 13
 
-   typdef struct __packed { u8 buf[SIZE]; } packed_buf_t;
+   typedef struct __packed { u8 buf[SIZE]; } packed_buf_t;
 
    static const struct packed_field_u8 fields[] = {
            PACKED_FIELD(100, 90, struct data, field1),
-- 
2.49.0


