Return-Path: <netdev+bounces-165582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECBAA329EC
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BDE166917
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C5211719;
	Wed, 12 Feb 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVt0IQ3F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFE1D5176
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374036; cv=none; b=O3EM7IhDtUj5PsSaEuybgEmy6LYEdA5LQ8LSLguWcdsumR+fasFmqlxo0Cz/Xcj0Cyqp+N6ltIEH0Do8XNl8aCNIaA1/PuRM/kV//niNGzp8lks9cR/TBNr9EFlotfO89rcPs3AERZ7Rh4su6E739dvrgQ1M9hV/823AouC3sfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374036; c=relaxed/simple;
	bh=vT8V7lsGJePHRPxn1DhEuL1JPbBPo0A5217Nn0dXSCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bM6QXVFGvRfOix4yLuHVlFCotrARngB+ScN07cwB5zX9vDGHCtJ0kh3gHtyNX4MwrWiG0akd13ZNY8soF4cIfhAM055gobkGplRAc1UkwRQup5MGU9wenemJkSjdjZUwyFzhw7EnUnDWx6LTBbwABuwb4GQretUS2t98mAIOEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVt0IQ3F; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1293416866b.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739374033; x=1739978833; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+v2zlsZVCTCaFO8Ecu0yqe/8KFXTvc0pR9tUkdrVCUw=;
        b=QVt0IQ3Ft3T0kCZkeUUozt3rj0FoFWoSfRDDmny5D0E7rwGBcb6VeIochAW4QcxtPR
         L1AAAq54QeuB+2Ivwd4/HYiZ6Agv9CsYxwdNptp3t+sZqdqHEKrE2Z/wYc+IOk7Vyc2G
         pAvL8oH5A48OvG6nkOlxjWekw7iT162EuIazbBGk82YiNheSWKMc+YQ0+rRvc01UEDXw
         CLFd5L6Y3uzlcDjKXV7f0rOBJK3Fsdj2kviYSlOAi2MCOFVxgfMBQecIEYlBPeDkC89D
         zK/+brhhq97slXHm5ea+6dH+pKDnpGNLfS02xP4oYyiwPuJKXTe0yhwK1Kcn9lmvRKzR
         PfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374033; x=1739978833;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+v2zlsZVCTCaFO8Ecu0yqe/8KFXTvc0pR9tUkdrVCUw=;
        b=EFutMp4E/9IpjLjke+LeXIVoazeIk+HzYndCeFkdg6mUqDE+SRkaW79q8TRlKvoNeL
         sUsCN0g3ldJnJW5WD0KsuaCjrKcISRb/c0/hWp1GKXmCsu4JYHbMDot4i0VPmIfEZCP8
         OOmjgJfh+cV6ueRYZiuPi0MJIwOayNXh+FPNWkWouF5nfRrcl5nzjQBAD/JjZ1GoJyMo
         s8big8kzmj2xib3UnA+Iv/97YljV97hMbbPBizamba+vvg9OBOirpgDSsm+5h1HX8Q0D
         9OccTrrhGtO8Cehi/4Wd4jMgePgjZ2S13URKs1w/pgHN+Rb5NNR+jMH03VnpAPulD23z
         7/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp15ZS+AWJIgeOP2x5/cERR+aklXT/YK5N2SespWAFeRdW8VOAXFoFvMypNJHRXbUg7grdTRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZfq7cHpkqHKP9kwB7Du81B8TWOV/vwaWnBKrBWaP1RTNn3Jz
	O9eU6vn05+PMTBTJB3hU6HzBKvNfHgegMJh4iJCXA+bhS+XzH3aCPD0PmD3yjvQ=
X-Gm-Gg: ASbGncv6CuTnpPl+z3r7IfFP04vplAxEY0D6/sYzC4eCezKO4ij6QNBBsyLQ8AzZfw2
	96Y2f4JOpcj8ApsGP9Z7h2RiQ2f7gYqcimiVoZnAW6fGsN8fOHrXLNXtPh54hCi7VOgB1zNOe3x
	dhZxaZmF5fnsmXEtr6MWBdK5rZwZ/y5/glyfrj93Y5WeAnae49yzxK1/WrcRC0lgFJOvLejPT3q
	+mFYm176MUIxm3aC7eKIx8P6hC0P/KF9bt9PfPPMOhYQfOnOiV/RW3Nd6ik/ivQtKnAfXJrohej
	uFdKjMkHlvt9ipqqyt5w
X-Google-Smtp-Source: AGHT+IGudd/dN1L+NiUERa8stm+ICSFlfU46rMuNR2Hncaq6Xkixith7aRyVs5EP4RRtpT5jd1UaqA==
X-Received: by 2002:a17:907:7e97:b0:ab7:b826:d84e with SMTP id a640c23a62f3a-ab7f338113dmr293815266b.17.1739374032574;
        Wed, 12 Feb 2025 07:27:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab78e3e212dsm1122175766b.147.2025.02.12.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:27:12 -0800 (PST)
Date: Wed, 12 Feb 2025 18:27:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ice: Fix signedness bug in ice_init_interrupt_scheme()
Message-ID: <14ebc311-6fd6-4b0b-b314-8347c4efd9fc@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If pci_alloc_irq_vectors() can't allocate the minimum number of vectors
then it returns -ENOSPC so there is no need to check for that in the
caller.  In fact, because pf->msix.min is an unsigned int, it means that
any negative error codes are type promoted to high positive values and
treated as success.  So here the "return -ENOMEM;" is unreachable code.
Check for negatives instead.

Fixes: 79d97b8cf9a8 ("ice: remove splitting MSI-X between features")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/ice/ice_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index cbae3d81f0f1..b1fdad154203 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -149,7 +149,7 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 
 	vectors = pci_alloc_irq_vectors(pf->pdev, pf->msix.min, vectors,
 					PCI_IRQ_MSIX);
-	if (vectors < pf->msix.min)
+	if (vectors < 0)
 		return -ENOMEM;
 
 	ice_init_irq_tracker(pf, pf->msix.max, vectors);
-- 
2.47.2


