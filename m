Return-Path: <netdev+bounces-231942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C2CBFECBD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BD1D34467E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DACE279DC2;
	Thu, 23 Oct 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISHve6E3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1126E708
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181238; cv=none; b=qb9yXe2eqiarPTDrC0nP6CKX7sDaSpH+PrU40B2mmLBx/NakdW0cssAydHI5J/j7uPzuTQ9vyv42iYnSg/xzMgzbRgR5roFsD6HEyLkJBZ3sheoOJYS4rXMvIdWTa6roITFgjFDTAXbO7bEkI42p7C7H1jEleY7LVJ1475vjU9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181238; c=relaxed/simple;
	bh=94uzV3VFEsNc5hciZIog7zBBbpwZzL3cEkwJ4Knqo18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afWA1OROBNhFmHDqcLqWY47A94CIonOv8zWdVvCudTdjO8g5fC7UaZB7Ms+rkHfas6KYpyrBwCvq9euuT1XlSmhnWC2j18MjWczxh6wlivTKN5vM9/DSgqq7cFG5dwkjcQsidSTD9/c0P1O+98mhcHYQloYddGMgBFEimUG4+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISHve6E3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33292adb180so223716a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181236; x=1761786036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KyrEoOAeZKPRfbyTnz5cosCWFxdbO0nbS1ytMd/2Og=;
        b=ISHve6E32hhuWJDWyvQvUFboTItF6+IRHd0M1Zi8dO/ngsEfaOqXuN+pIMCJrztSfU
         O+Hmou4a8pmogV8zTi1m5eHhXdWgi+FujR1jeA8iYSHz9+JkejtR4hok5/t4kBgfYXvK
         lAeoot42z63rJCbX1xSjdUkuA5ENWuH7CnZxWaO4+d0coZzbpiHcsMavTpFeKD9ueWqk
         fkz58+mhhWUdhyKZtd8CdqVIC0uVUg8QejlVkbMRTGSZFTPFh51p1OnUzTOcGdpm53Pf
         DMSRPDDX1kg/LnMqpVd4koiTkhUD1vo4OLOJe5vbnMyuqWIRFgN68dYQ4qwUSwx+aeG6
         B4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181236; x=1761786036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KyrEoOAeZKPRfbyTnz5cosCWFxdbO0nbS1ytMd/2Og=;
        b=NV2uWbhqYm5uU3SDM+UBkL0fTDQ1HsiNOejy3JcUkhn4bsm29msMHMw1NiV2Oox1Sm
         +ONfXCojVVRJe/fgOWlYbGSPsNOnQ3XhTVJ/AD3a23YqBGV+y4GlEK+Qq0h9m09knprn
         117cRDmFOIyzqDyp9vfeawOesS1XpyxaAiihmq8N+YsmgxHy1znaBUS7kKTg2f+tUIkM
         HmJCRQvO9DqXKin1HkFhbqG5unuDJhN216vCyEa0uVnKpsXtJ5r/Ay2Y1tJhh7ogcERZ
         /lFX88k8u8y2kZOCjHVgjfjznWFkUQXfKoJ/PN7HgVw3o/ioNQs7tFHpLkFGEDrN+6Uf
         p8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwrqUhiABoOC2dufKy4wORj7PdVU1k/E+70hzTFBvUFszK1/AezlCM06rcS30MdF+g3u409d8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzd1S7jvUOehfs9Z9zFLgCRmAgx6dSYk4nyZjFdUsNAbTpHB0T
	lovnaQPJp3kxyWEOw+HKdRsJcb21m+xqIOHuFKa98vQKbt5piJJa1Wye
X-Gm-Gg: ASbGncvJ9HN4cVIkHN/YeXngJj9Lj9jvaRGF88lztdGnx4rvXGd5SQ1ilg3Ii3FocWR
	bcfUoANjmUV03bzaFsYSAaCZ1FLhxZ9hlr4SlBC6021aBzFccEpTlR+flNz6KCi3Apr+fT7WG+5
	3nLeVhxH9g4heD6354U1lfgbBHSKBusx1dEZCcvrJ8d0LC3+0uwxo3HvcsvW6QDDN4DlnHGhxQU
	g4i7q/w9H6r517iNNJcPu7bYranqp+pZj7OubVuDjg7E1PLvfQ1a2sLuAKUm7ia2n0jpJ80sbtc
	3JDmxBMhdVS9sTaIkiUTA01rL2nxdkMiXNHWiGpOGxsRXNyIYHKmA05Z8i4JKaImI258eTy/lYX
	l+qTGgSB4rzU/J8e/u54rhXYbpr+xzVAYMIz+8A2VZq4XUSANNecvpteGKw+xOxMFY5l5mP9Qgw
	TQbW4fK9Sw0NiBEl1MPw==
X-Google-Smtp-Source: AGHT+IEOXbL7VuQGK4ycx5x+XFWwQbZrBd+2XbxwOLCxBAkNJU5f38Hm416YN0mJLPBe2ibivOPQGg==
X-Received: by 2002:a17:90b:5343:b0:32b:65e6:ec48 with SMTP id 98e67ed59e1d1-33bcf84e1edmr30854960a91.8.1761181235816;
        Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb9027sm360734a12.6.2025.10.22.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:15 -0700
Subject: [PATCH net-next 11/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-11-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index aa7199c94780..038bb5e2b5e2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -152,7 +152,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3


