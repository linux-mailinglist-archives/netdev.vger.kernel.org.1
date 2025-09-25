Return-Path: <netdev+bounces-226183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D09B9D84E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E142A7A6C93
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 06:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7526B2E8DE5;
	Thu, 25 Sep 2025 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUn+rXDW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA7287258
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780258; cv=none; b=FqVARR/+N4Th6MSseeiJPYhYsQEFSPYL3rdTzbEC3typ8Bl2BHM6fulqVAIfz+Gd3rEzft1yKnySy/1p6svqjTpWqb7B3bMmHcRYlqNTkWk5NUlXQSWs+xMNqSJq5UWAMfOsvfWsiz1howk3DydNRUmGxc9EsJHWX063MVvk+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780258; c=relaxed/simple;
	bh=o0VNqoePQ9Fxc7vePL+KVWDFK3PNoSh+8m9moiHOP0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=stOaViXDsGtVBBWFsPC/tVa7B+/O3txK/7UeQPG8vuUtGsKUGtpwy53ImgZYFKZ/uC0k8r2qBRZ3AS8Q5ya71j3aKCMkmHOfFyvxChBzEnIBoXoG5DNx2qgN0wpvBpBpZJ1iJMct8RPopS+V0xo51vWAG73p0hXZuKfDTJMyFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUn+rXDW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758780254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aFGTlM/AfVM6UoD7+6D0K+JKl8i8C5klHuPNmVycESE=;
	b=KUn+rXDWI146AW21Mmas//VI6a9PcOGmNaTNVNhwH7crKupGYiPKiXw1j3Mkq2mEP1/D62
	B/zE9voWAzLLAJT5eamxMFjzFtjUuymUbLzuJqo+yn6f7zncxlaRQUS5CU0dtizl/YiWFU
	qhYDm53DgHcQWIIXdnkbf8DmodYqLZg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-OMC5EfbhMNO42Tf23UxTqQ-1; Thu, 25 Sep 2025 02:04:12 -0400
X-MC-Unique: OMC5EfbhMNO42Tf23UxTqQ-1
X-Mimecast-MFC-AGG-ID: OMC5EfbhMNO42Tf23UxTqQ_1758780251
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so300221f8f.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 23:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780251; x=1759385051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFGTlM/AfVM6UoD7+6D0K+JKl8i8C5klHuPNmVycESE=;
        b=jjUCrYisSerw0lBu4Am5BNA/MYRRg3BdTcQaZpdUXUDJ8/LjdVCaR1tts8kDFMvjDT
         PR+xDRQ29/l2VaSFTmITNtk9VaIWb0Z5L3NTA5ZoZQfgvev0hv8RqfoyEXpgTOh+MSPQ
         gJxGVo7uzSkw+UTcLRvJer4848tl4bF/N0ngs81GiaB+iIXBLljngA3AD8StS1kazR/x
         jA5ZSW+FSKJ3UGBwRBFrDj+iO3pBx+AlQal2gnDY+V1W5Oa8EmqVIkGDMpJihx6Rrzvh
         byIY5eOYpXtY5Nbw7nzSjwQ2i0pJU2saaAM3suD5itZ5RWAdZ/DcRp012x4CyJsoQXA/
         KZpA==
X-Forwarded-Encrypted: i=1; AJvYcCVrt67Q32BmFxgrMsWDxo8/qIk3V7ziqCs4fb/MUDN5zuB/EW9rVD0wFdFFTq8pFgB6uq4Lhms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3T7ic35pYLB7cgsFDU2YsYYORB3J2PtRjQL4QeptWUHMPnmx
	+5BTk85uf0/87p0OpMkJ35orH8FsRabgd+RBw9UTv1MKpNW8XZaOKpueGnR86hW1jI2CYRNHNj9
	jDD6bHLmXVjAlGBG3Xq1S82EXnINg1mHhhfX0ybN4MHR4af5hgCmWxsjuOg==
X-Gm-Gg: ASbGncvUQepQG10CGYdGGPRhnfNDH58DGpynrlGwotQugwUxGKlD9n8fYUUURLsNy8n
	urOll+nlpsvv+ifXYwxs4go1BH12LsQ2C7sOww79XkB4T7+YdAYqoCe7ty71qrDvwkVeei0CjQM
	llP9XIat3Y+bxPmx+16LfXOOQnIQv+7h9ha+X6y/ulQ+0HS/vTPqdHm001pVxHhO4D5Gbf5e8Er
	8aodnWvPBvLM0rNdcVt19LDn84N6LXd+KcvZmpA0DpCosFbszmSsjxMmKOTN/h0428/LLjAgT4R
	ncesZkiYf96NptoFEUkVGsp8d4ms2ZzmQA==
X-Received: by 2002:a05:6000:2912:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-40e49e725f0mr2176050f8f.56.1758780250924;
        Wed, 24 Sep 2025 23:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzXROWH0HheOoR3C9U+J8DhuDXRcMrs5JaiB8XcConfDaf/URbl6oeL/NMdqI1Vf+S1XrqWA==
X-Received: by 2002:a05:6000:2912:b0:3eb:f3de:1a87 with SMTP id ffacd0b85a97d-40e49e725f0mr2176012f8f.56.1758780250483;
        Wed, 24 Sep 2025 23:04:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm1463946f8f.37.2025.09.24.23.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:04:09 -0700 (PDT)
Date: Thu, 25 Sep 2025 02:04:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net] vhost: vringh: Fix copy_to_iter return value check
Message-ID: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758723310.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

The return value of copy_to_iter can't be negative, check whether the
copied length is equal to the requested length instead of checking for
negative values.

Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss.chinamobile.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vringh.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 0c8a17cbb22e..925858cc6096 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1162,6 +1162,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
+		size_t size;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
 				      len - total_translated, &translated,
@@ -1179,9 +1180,9 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 				      translated);
 		}
 
-		ret = copy_to_iter(src, translated, &iter);
-		if (ret < 0)
-			return ret;
+		size = copy_to_iter(src, translated, &iter);
+		if (size != translated)
+			return -EFAULT;
 
 		src += translated;
 		dst += translated;
-- 
MST


