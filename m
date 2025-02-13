Return-Path: <netdev+bounces-165840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C675A337F8
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53171161E27
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 06:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C5BA2D;
	Thu, 13 Feb 2025 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zui295ws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC591FA15E
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428309; cv=none; b=oopZUmWSbkEw7FXmJ6CULB0mp9BPKIFBWjCeqDcYZyUqJ72KjPRGq1O+G5NqyCNVVUV7jD1VW4sh5cE/8ufcLJhCt5fVwjvaFIvc8VPWdN7qjdo/EyE1c29GzTmnVkkDeiRGksKZ+fKnCsRyjCKOJzRc1xcqsYo8imXIRzBYhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428309; c=relaxed/simple;
	bh=TSm+EhFKzQ+nmagJ+NpWIUWkYFzwrLV6u54VSh1bzrE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QAG9wArMgtUF9BUxozQFqnzvq6Z67gNjesw4Ypt9l0zVsnuRvgSkrjrLmnB60nxcqaEztVFXYS1YH9aR6clJ3tpPVE7at+0YN1S6DFh1/oQkWFwZ8sg1nzAm/q611icu+zb0RaQJwBs4Od0hNinWaO8gtxYOw0daOSUY37SJI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zui295ws; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de849a0b6cso859510a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739428305; x=1740033105; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lN2Y2nwgj5zUTnrECdXbocmCWoXI6GrsrPx3j3TC4Yk=;
        b=Zui295ws93WTTPWNXD2buqZj+h98nk+ZKUPjjReH3vwTsDjRZFMZaPwPQvLSajTiAv
         JomKw74jFwMnPz+dAqvKkttjodB+baMP561AxOryUtrehw1zJ5Ob7FWWXjntnpafstFl
         LwUdkCM42isIwRjdXWN4HXNtIFZkkurnx0RDkZCES+iKm91ZigthbRK4EN2v5Axlidv7
         d/onpbbgPaR7JgnRHljLL7ZEPaegRCdEgpdUk2e+9K6cLG1NV50qXh/rLGsmekTlE57s
         Pk8DV2sqWghxRxh+2bB1YgDdM2Sl76O0cdbu6W2vOGJcy6aFhy6xByfnWxmCMp9zOdcM
         xpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739428305; x=1740033105;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN2Y2nwgj5zUTnrECdXbocmCWoXI6GrsrPx3j3TC4Yk=;
        b=m6vE3uYOiIbRhHRkOOVzwraHCAPACri52Cw/O353EHltHccAbOlvZo8mjHHS+hrgPN
         9Do+Crj0UG4mljHFGfpFxqcp2mw2Y73PgbjjI4LLjqFlSEX2EhdgBkTgPfniB5NmFwmR
         wD8/K4N7i4vbchdF2kONVPin4TRNrLgFs8MLikPiUZYDv2KIUq6H6pyp3BsUyaHd7o1p
         0Szfe0zELK7yGVGMVbuiYl0InYFvjYu8pKsqizREpxgTKQypUFvomd+Lg4wlNGv4Sfyy
         Kpw9JVcLgvxGJhJLy6/7vuqaFDCDAEJkyahNcR5Q/kQN6VsGwyGmHgqJ7KLTNCJqDuH0
         H27g==
X-Forwarded-Encrypted: i=1; AJvYcCUhSGkQl73I1gC71CVupBmHtZBm0gXoHZ2IDNTIPa/SmO3mQXu2lCeoCYAfL1179SMOlNVyMHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJZqE0ItVGrgknVnN3+DlmLX40rhBC7EveeUA86sz/X6qHO/S
	/J2U8OCrSGRaJ7iMPhq6qJLmK+qsNQwtBv13YunnU8YuQ/1H8RmqjsMHj410TF0=
X-Gm-Gg: ASbGncuVxfv/XTi6HbYK/lghmptjs9WuYpOz9adRCyTZTByalFSYT+93rq9ibSx+WEu
	YjjvM+O2teSxZkOaMCyFL7IynNIRrW+iokd0utCvFbtflBvAiTo3ZpR+wzXGayQhGK5HRdp91MH
	KH4xwSxQlBZfOHzS6n5aWHUrFGsZ0zzekqtAQiTMCNBovJgWH4ji3Id3fYbPCBYH1il72btrorT
	5kHE7v9lni9jEYy7OHihaCWcXggxrbkcvlJrh+xW2HFmvw4z2jYtW32oIUJ+GF8qmzHwV/Cp8Z8
	3Fz610MvJ1Rk1h/Bub9T
X-Google-Smtp-Source: AGHT+IF4GmQVmoYV3tMifs3xYxMEmFp8h++H06hQyM0sB214aBjWO3g4Ojs0FH/d8ojvyeWMu3n5Fg==
X-Received: by 2002:a05:6402:5d1:b0:5d9:a62:32b with SMTP id 4fb4d7f45d1cf-5dec9d326b0mr1910867a12.7.1739428305096;
        Wed, 12 Feb 2025 22:31:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece2880e1sm596423a12.76.2025.02.12.22.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 22:31:44 -0800 (PST)
Date: Thu, 13 Feb 2025 09:31:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net-next] ice: Fix signedness bug in
 ice_init_interrupt_scheme()
Message-ID: <b16e4f01-4c85-46e2-b602-fce529293559@stanley.mountain>
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
treated as success.  So here, the "return -ENOMEM;" is unreachable code.
Check for negatives instead.

Now that we're only dealing with error codes, it's easier to propagate
the error code from pci_alloc_irq_vectors() instead of hardcoding
-ENOMEM.

Fixes: 79d97b8cf9a8 ("ice: remove splitting MSI-X between features")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Fix my scripts to say [PATCH net-next]
    Propagate the error code.

 drivers/net/ethernet/intel/ice/ice_irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index cbae3d81f0f1..30801fd375f0 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -149,8 +149,8 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 
 	vectors = pci_alloc_irq_vectors(pf->pdev, pf->msix.min, vectors,
 					PCI_IRQ_MSIX);
-	if (vectors < pf->msix.min)
-		return -ENOMEM;
+	if (vectors < 0)
+		return vectors;
 
 	ice_init_irq_tracker(pf, pf->msix.max, vectors);
 
-- 
2.47.2


