Return-Path: <netdev+bounces-138072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25519ABC15
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 05:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4D31C2114D
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 03:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF8561FE9;
	Wed, 23 Oct 2024 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs6Oiiu1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7E1139E;
	Wed, 23 Oct 2024 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653693; cv=none; b=l0mOmGclbnPN5EdaINw2Eo2BM3eL3DRtaT5vk11F4hud+KHL3jywbKIx8qPjnvSgvsChVDQeD3vRswJue6Kxe5fSh9PIEo94TsgUbEKwIipxqoUMTK79R3QuUnWDkW90Y0A8n6JxKNSsOTwaeX+Pqk/svmzd37CXWZwUg1RYIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653693; c=relaxed/simple;
	bh=nt8rJBEuD0Q9sUA//jJUcUThgf2M4Ags7Y9vCxUhnuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LtTi9Jut89jXigHzPq49WbO/Flq15q6vzGzohi1FSnvfElZKId5TO1IK1AIWJ1OiSG91pjokBiHd0jzA75E4ddSzuU/DBF3K2xMrJogyehpPy/9cMX+gT8xuxffsq5Iwozg0KUc8IviznyoQziG4KLCDzCO2MIIEwmUIKIKT0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs6Oiiu1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20e6981ca77so47715595ad.2;
        Tue, 22 Oct 2024 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729653691; x=1730258491; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29eHXV9bqIXK5xc3pmwxd96Tf3JMnOuCUVgc44dHjjo=;
        b=fs6Oiiu1xs9O2PZ3JCO7H9s5/aLKzp1O1vcp0AUaDmAWjiqteq0zOK0fvxbok2Kbut
         3EptgAtinjWASWbZCTJt6KcSXK3Nka+zsw2WV6kwi2fMIvBzKSoVMGKULtHey4wGANJM
         8hZ10L+a/qMTNP9e+YkmD98iS1mQMPtVIw7zWVl07WKcDd4uvjMqeV0SeEoSJnSMoIJB
         SxlZMVXR7IrD/eYlLjR6u8vpHrwdqyeAI9FnjhwQPQ1mnnx5IdyRvjLwE9DXle0M8huw
         9K9RA1KiO2u3YnBTep+JkcSGAwUlM1UxL68L7EJ/FqQKoEptoLdrXy7o/BTDnhneGYDL
         Yheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729653691; x=1730258491;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29eHXV9bqIXK5xc3pmwxd96Tf3JMnOuCUVgc44dHjjo=;
        b=mDxHcKoIrMr7wht4bjCUEexyJ7xx6OkFJKvZ0JkjetCu5WgYpgTDwLcp1Sh0c+hk7o
         aAo849ZcdIDwlFnhe41TWN7b8jilL4VdEkYkwNjEvjjwxDq9F9faPcK3wRBzKAl89p0z
         avTgo+OCYbiDxKuVnyzUr7nQSw2HKpN9BXOMptJIUrygd3OkZxivPdjXPXGaCy21kbCd
         KXt4mU9zUeMGR4Niw1W7NcwKPKFAMPr61V/6C6LrEwYGeezx+5dL7HTY7amIULs/b0NC
         d7WKwzOMgpRE251Jd9Db2zZBK8XqgJbfdx9U6oA8MjRb8BK1wOUlATN1K9ldpv+sLTGT
         Fu4w==
X-Forwarded-Encrypted: i=1; AJvYcCULUcnARC2kqf4vm4JGr7NQ4mKfosTMaUNbX6sgIJ6PQ1VLuFUQkuBwctOyVKy+7ZglrqrCcEOi6juRHkPVz+Q=@vger.kernel.org, AJvYcCWQMmHNQKaubeQirxDOYpeXLkDK/gky1UJVbLoyZGkNScSIQ/2bHdTIOhtjp4uGcjmQqQVvp1DY@vger.kernel.org, AJvYcCWgARCkjkEiIgMane1cL09Xj3OO1VE3pgQWVHGlDOb6GRv2PVQQGLMJ1qf2vYiPUfw5GLrI+5HOmmqP2OnN@vger.kernel.org
X-Gm-Message-State: AOJu0YxTDHtEhsqs4cczQ7FJsSUZjSdKgLopHdxBybTdCcO/iWpKYgly
	AmxIDFaOndTjUjOCB/WQGzCoQFIAyuxKjMECmB6cOb5P4dz22C+N
X-Google-Smtp-Source: AGHT+IHzluk/mO7QsiX7WblFK/SH2YN/WhRfpbiFtyyiimjV/181mnxEUMWR1GEWvL8QX5ADLxcu+g==
X-Received: by 2002:a17:902:f64c:b0:20b:7a46:1071 with SMTP id d9443c01a7336-20fa9deb645mr19087025ad.4.1729653690929;
        Tue, 22 Oct 2024 20:21:30 -0700 (PDT)
Received: from Fantasy-Ubuntu ([2001:56a:7eb6:f700:b2d3:e25a:778e:1172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f65e1sm48994225ad.285.2024.10.22.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 20:21:30 -0700 (PDT)
Date: Tue, 22 Oct 2024 21:21:28 -0600
From: Johnny Park <pjohnny0508@gmail.com>
To: horms@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] [net-next] igb: Fix spelling in igb_main.c
Message-ID: <ZxhruNNXvQI-xUwE@Fantasy-Ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Simple patch that fix spelling mistakes in igb_main.c

Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
---
Changes in v2:
  - Fix spelling mor -> more
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ef4cb871452..fc587304b3c0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1204,7 +1204,7 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 	/* initialize pointer to rings */
 	ring = q_vector->ring;
 
-	/* intialize ITR */
+	/* initialize ITR */
 	if (rxr_count) {
 		/* rx or rx/tx vector */
 		if (!adapter->rx_itr_setting || adapter->rx_itr_setting > 3)
@@ -3906,7 +3906,7 @@ static void igb_remove(struct pci_dev *pdev)
  *
  *  This function initializes the vf specific data storage and then attempts to
  *  allocate the VFs.  The reason for ordering it this way is because it is much
- *  mor expensive time wise to disable SR-IOV than it is to allocate and free
+ *  more expensive time wise to disable SR-IOV than it is to allocate and free
  *  the memory for the VFs.
  **/
 static void igb_probe_vfs(struct igb_adapter *adapter)
-- 
2.43.0


