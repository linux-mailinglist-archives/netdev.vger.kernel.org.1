Return-Path: <netdev+bounces-245044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE238CC658D
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 199AA300B2B1
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 07:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111B3335BCF;
	Wed, 17 Dec 2025 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5LVdOZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606E3246F5
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765955665; cv=none; b=Nr2QfA16EVEH34V/0MVzpctEtQatPAFRfsRbG/1dCnO9OR1LQhB7ijffz/cWv3/HKZXFAbiWKU6rqMbq4XEXshTd1jg5F6UHvbH3i7MAEF2xdtEglCOLlnJVmWIMccLJCFpKd6hqfG2rokk7SYcErEL0D43eq3pPZke0XFpfL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765955665; c=relaxed/simple;
	bh=YeAipAA/PUDUO0KEdfhe8lp1vbGWEcaKIBj6VrffAAE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fRfkb6hKTBI5qrT8OZ1zmyy/huuGS2FgvKHj4Amq0qDd7jp4sBLCTXCqva+thGSfl3eeMZcTJP+itAmSjOBMxywSt932B01N3bDMSLFR6mkOnYd15b2Pdbtp2mPdqxARK0On0CpmBZ9qo+2Eg3dCHuhqQvzhofvq+R+mtkQt6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5LVdOZ9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c03ec27c42eso3285786a12.1
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 23:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765955663; x=1766560463; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKlZuBgC9S2s7PItNByUDI+Rt79nIm2uoigIiaPgmyk=;
        b=D5LVdOZ90+xdpHTAyG90Hf+4LtUpZOf0HmQ3uahxmB7ZyY/zlmYY6umIKn+z+NP2YO
         wJjEADlTAzZ5a66Cwhc0CKsotXBOhXXCNKOwXnXs1iqCCYvQfzcIurcwgVnCqgzKPgA4
         QCL+bIngID5dIvfkMrkP1P2qCjzgIun8C8QG/GifaUQB3oki7jnXZ2fZoUiNafSaL2aw
         pk5CvJpBwV6DgslOEDLjAySp0wRRdNW6J/wgzfu0zJo5fEeXIUNARJ+SN5B9m4j+eLYn
         wdXH25bx6m+ODgCuNeGOVwvHFTzG6pntCOGUnyVIn1TssMBWGCR7V8MYwCmfTJFJVEuG
         gWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765955663; x=1766560463;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKlZuBgC9S2s7PItNByUDI+Rt79nIm2uoigIiaPgmyk=;
        b=lofXVAdnWOg8vG/NcDIcmpAszhNQVk82zzMT2jNpct6Kiwz2IRKoejAQz+o43sA1Ce
         38xeKeSMP+1So1R9fotsNkFC8RQFHwhQjb8TeY0sd6tYg98GiNZK/epQqXOAHcxdeOcJ
         FLyoyLTL2C9W2a/D2w8Kn3WHyApZZewj7HBZhEzXicR3ZHJAnp4CAQmSJiHo1G2HZ5sb
         0PNMTBxv4P0fNJoE9fT0FE3dGSAOOo23x1cOQsolTgvRq4uwPkmtXeotCoi4jKnjUYeE
         rmXhzHiXu9/HZ69DQj2QfsomCwSEZX8fX4BvUXz0zsW5HdM6vDLL5JtAq478O9Z4dWbh
         gXbw==
X-Forwarded-Encrypted: i=1; AJvYcCVRMxZq8reQYD37EXYRjK0YiF0bmF1Czh7DNeLejb1pArdwGpoLozR2NAYI58mvNrmnc1v0W34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJNNMllVU+nj4BYW2X3rlc7E9hfQsU7tlXxF/MZJWR7Gx6Hns
	JIL4dhuwgaLOU72fcWPnf+wNFzAfBiCAIDZSXkpPLjTIRtnAFXeu2ukw
X-Gm-Gg: AY/fxX4tfysC7zfvJUHofD9N4MCjouYInsS86+8/fTtyb5y7u1lXOZNuMC2VpHJ4luD
	SnLYbGT3E851jmCpqAJOiQawy7BxioEUyuF0BIEwNyxSoQ7D82FVbYY5y8ngERQu8Y+SgBXlZxx
	aL8vo62gnJjQfOsFvR6iMGA/VqFWAEP/Cj/RN5yFeAgGwMuVrwAC1A7NCFrrn45EUVHKtw8gJZp
	zXPcZ/FLOBduaVlgNrL1P6NUuKpupQ/EFRMyti+i6IcI+UbOwWTKYrf1KJf1JyniwURpLTVP7YO
	BvimMjzarAOti5swIT2EjSR9lv9PcLIZ6wKJI3BpDMw5zSPJ0hmJrqIlApGZdSPhO2Oa6J5uUV3
	0KYxkwPX1TS4z4U3xq5uCAecP4s+YU0GqDeEFmFoErECqqEaHUSN11YwU48j69QNSyNq2DiZkqD
	i4xgAdDFkwnmMf
X-Google-Smtp-Source: AGHT+IHvz6UWFlsi/MRfnNAqk8PSE2gaCl02AlOgoDeskhWpPQsOnkghqEa09HnNIiA4Sgnh9JvlhA==
X-Received: by 2002:a05:7301:18a3:b0:2ae:5b2e:9d45 with SMTP id 5a478bee46e88-2ae5b2ea8d0mr1186384eec.38.1765955662558;
        Tue, 16 Dec 2025 23:14:22 -0800 (PST)
Received: from westworld ([2605:ad80:ffff:50a0:9c60:b5a1:a670:381a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ae4f054648sm2398507eec.22.2025.12.16.23.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 23:14:22 -0800 (PST)
Date: Wed, 17 Dec 2025 00:14:18 -0700
From: Kyle Zeng <zengyhkyle@gmail.com>
To: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH] ptp: prevent info leak to userspace
Message-ID: <aUJYSv6kqb9QauMI@westworld>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Somehow the `memset` is lost after refactor, which leaks a lot of kernel
stack data to userspace directly. This patch clears the reserved data
region to prevent the info leak.

Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
---
 drivers/ptp/ptp_chardev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index c61cf9edac48..06f71011fb04 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -195,6 +195,8 @@ static long ptp_clock_getcaps(struct ptp_clock *ptp, void __user *arg)
 	if (caps.adjust_phase)
 		caps.max_phase_adj = ptp->info->getmaxphase(ptp->info);
 
+	memset(caps.rsv, 0, sizeof(caps.rsv));
+
 	return copy_to_user(arg, &caps, sizeof(caps)) ? -EFAULT : 0;
 }
 
-- 
2.43.0


