Return-Path: <netdev+bounces-225727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7391CB979C8
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 23:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CB9165651
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7E2BEFFB;
	Tue, 23 Sep 2025 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATrY/tpm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A678F58
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664081; cv=none; b=T0OL0erL/98aJPHSKEthdjehnjKuQ/1no2e+AbD8sRIeGe2IGgAs8u3ENZbgFrA4yf/fC/BkCdoJ4wMHvWikHa96L4i+fFOc3bX2HSZ6ASp3/azEInnaNXJotW49uIkX11mSeM4kYY4nZ8a9I1QLQo7FHTbmb+ha2byj9hQkNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664081; c=relaxed/simple;
	bh=ueTXvYOaTGFnlsHbGUKhUluBx5Uj1EtJeF74+R0Vgys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ls6H74a2S2iQu4SPNR+1KynobQcZLOm+4LU7bilS9kRTd0/qyWXiUYi2qrENHQqsL+rdAFTcysbGfoSiOXtYWoBcl39idBXz+DHhh/b8tc1IxQQHXJaOO5guntr2SjhP/Y9ehhwo1Ebdgw8bUJa45YTWidstleh86bcUiGRLvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATrY/tpm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758664078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gE1p9jvRg0lKTpk9XpwlgaFgqtSuJtcDtsDSqLMg4mo=;
	b=ATrY/tpm6rFJ55hsbZsuP7MWrDIKs6uzwmNjzAh41YItDjwItOTTNx8zqbF5iNtUN1fqnd
	5doIpvG/U+jFBheT3VkG9jLOtASL5fx6GDuufMLzQ7SCqk2wi4JbKto/RJKJcBkggNOkgK
	wzZYTvxQG3iCfqkF3O3H5bXAkiw+cWA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-2IUh-SRzOPScFx7JKyq4Wg-1; Tue, 23 Sep 2025 17:47:57 -0400
X-MC-Unique: 2IUh-SRzOPScFx7JKyq4Wg-1
X-Mimecast-MFC-AGG-ID: 2IUh-SRzOPScFx7JKyq4Wg_1758664076
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e1e147cc0so18449825e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758664076; x=1759268876;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gE1p9jvRg0lKTpk9XpwlgaFgqtSuJtcDtsDSqLMg4mo=;
        b=Bjzk09wDm0ISp00D/54jt0WK7om1fudUdZw0siQ/ZrT3nJURadjBe1uL3tFbRxg8Iu
         pF8ThQ/AJKjngyrVzvujtvDDoCkn3WmzFdG5sWxfHc1I3xMQ213KSbN8UBFO8ZuLGuzX
         5NUpklXk0QSAlY07CEoKeOBuoQ1PcC0gBM1Z/QioQcggOrAlDnE96BnOFY/UX76Emmhs
         DcsN8b7KNom5l7M3bES6fyRoV+20MAFWODXIymicTSVdOpLfxO6ZNhq2sia4963Bpum+
         aJ0BfzQjZcYryllHPqKBFOTWYNfVX443QApkmkCFQ3eXyZm2YqsrNP3Uc1Cr5l4oSZ3S
         VTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtihfBx196B6F3UEI5+ibEBCfWr/Vt3xGCnODbssm6WgxxX6nCUSXXsKAI9GJ0uCDgv6BPTQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqYPx6bjKLsgx2guhwkYN9NbjWqPMHlQpUCxQnvlZHIxK7PYp
	LoCcskN+uvUrwUTABTWD91jRsU9E0TCDykUWWyqrb2ru5cUXsnj2Jxk5BMwBUTU9yR/+LRrzSUm
	dazpTKvh1d/ShNQmGjM+pv1N95+8HdAtum8kHp34ErfrnrTs+H4NeJ4ajNA==
X-Gm-Gg: ASbGncslrPohiO0P2R3DlMq4Ba+2JGHeFBpvLlr6LGC1aS9EVGjH0FCiNsd76mYujP5
	AjtgScBlenHQTZcNt+l8l7Ctnj8apMst6XWsxCtKO3EKB/NVWoSaYayraTEwJEHpq+yZB/crZI5
	V1HftQImuUd/5efemyxxzf5Fy4mPvBWA0iqlaNspsRL8Em43EG6karAL4p7wX29QnAQfJe5QXJd
	xiY12td4fcIKiA+E6SBZTQxp3/KfZC3zZjnjvLyM2zJVPJHPQEUoy5z9IPTnSFoEmapWXkO3tKm
	OSqAHFlM+MxqnEGKfEnuKi0UiSYDdZkOyAk=
X-Received: by 2002:a05:6000:1885:b0:3cd:ef83:a9a1 with SMTP id ffacd0b85a97d-405c6751cabmr3721721f8f.20.1758664075767;
        Tue, 23 Sep 2025 14:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETV4Q7KUf/fsmOmIwTE27eO2P2KhRHj2pOb3/FmZCSUNeq3z+t0xn78V0pxCEhXhxYrElaFg==
X-Received: by 2002:a05:6000:1885:b0:3cd:ef83:a9a1 with SMTP id ffacd0b85a97d-405c6751cabmr3721711f8f.20.1758664075279;
        Tue, 23 Sep 2025 14:47:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f61703b206sm15270816f8f.6.2025.09.23.14.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:47:54 -0700 (PDT)
Date: Tue, 23 Sep 2025 17:47:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] vhost: vringh: Fix copy_to_iter return value check
Message-ID: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
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


Lightly tested. zhang jiao could you pls also test, either ack or
fold into your patch?

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


