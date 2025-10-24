Return-Path: <netdev+bounces-232647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7487C07A39
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9AE1881E9D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637EE34678A;
	Fri, 24 Oct 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbGEMx/w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6D342C93
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329011; cv=none; b=cewhlJLNt/AhgjfGkwnzcS/Jq0MwBulxi41R4Pz0JfJtEusjVYOjqYl0y/0naLZ6evySGngIqeRRmtx0cpzTMmolPkehJBjd0VCdO6VdD1s4tXufioqoq9QtBo2/KJGQYSKs0gINVL6jU3y88yoe3NKHXP10gCBjn0W3PklLqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329011; c=relaxed/simple;
	bh=M5RVCn9BwgC5fLVWadVrasO8jK1wZc4e0dTMYnPxAxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F7IU1uhoGJUUdKMeC57Di8rGwMz0Dj6TPIEeuiZg2aWr46J5lnQV9GAJM8rX7p7fU8eDt177E2aD36bnANCQJLYArCo0UDdplb+PrzsQ0v93pC1ptuzVOwPfdwaiJZK4aRW7wA1KqznjffQcCYXsv0ngKVcjtGN7EY9dIFx/Fwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbGEMx/w; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78356c816fdso25410497b3.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329008; x=1761933808; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0g533bbt6NpsbcwNT6NMvXPO9X/fhaRkOul4lh2e8Wc=;
        b=dbGEMx/wyoroUdexYBOyVxVeRfQYoCQ8WGO56L6jcLMlVCMQth7OzVJKYMiwfM5wfm
         Eid3yvTtelyz3MxEJfTmABsJb+S5Q6NUWkk4ieQMHkyuR9M6trG1s/pS1MaMwPaW7uhg
         7pwOUXbG3nc+kTOIQcXVqCBFv/aAzmPa4oyr9HtEFodzzduDVI0JWkn6ctVHvJ6EJVoO
         9YexLAmrUa139HPZCu55er5HGry1/nzA/gF/uTsxdSrlKXzpfU5A+Zaj+2TrNZawAOvf
         Vb8pELZxCgtvk5eJKf6ybJD8kHwj5gdci9QQngXpv7frp8UGtknsxZqwmIUfxmbSQ11O
         tvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329008; x=1761933808;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0g533bbt6NpsbcwNT6NMvXPO9X/fhaRkOul4lh2e8Wc=;
        b=WTFWfnoDwRvBUrgBMf6E5mCNtiaQrdZov3AmBAG73gOXdzWqeTyAs8Y95d4d5fJPHX
         oZWQnR0L9rLPjYK9kcZdZG+XGyPXJwOnYF9Oqp0Yh9kSTaycT3r+njGxVr2us0XtpXKj
         tF53/CgDg10MEhu8Zp+hY7bRFAhXQfSFOuSpBozJLpazqfpCPnn61AaG67eZJ7JpJbmh
         cMAU8B1NB+CT7FxClXG2GYFk/I/uQx/R+2I1bQOQ4vvfpUwk89IkUSk+c2XkjOPPcGDu
         zVNUysuIIKTtTX7Pv1boJASKBc40NFy57TEAto40Nj/zy9a0gglR3M8Zi+HB3Wveo5KI
         ZVOw==
X-Gm-Message-State: AOJu0YyQ5ryy4g1XNi0ATPAcr2LDATjOlmiuvCrQlnq5twkU2l68cRIB
	kaypBpXEgnDJFRgzdxgxGpMjQqircRYKWlKdwOPoKhLwill0lqHPhxFM
X-Gm-Gg: ASbGncuRXiHChN8sSU406gYfXWLDlM1JwDxdJ/w7z7vlSTquaCO4rVM88xOUFAC1mB6
	uizvAIDSbj4EettBvmlRZCEKo23aEmfn57VVlalGvSro5k0VE+AbXemREBQ/xFd664RtpCPiWdM
	t4OYyuY1yRrXalmhqckWIISGzTMRZUDJJeBsz5CF8+LxwK8NhRm9P8OWI97aLzjZSfL4ngwQE/J
	hr3dgZirjmMxR+82NaiL3iUzHe1wj1BvmHVAwo3Rsl0Y+B3tRq5z7L7oxJy3F4Rvi9yKHbeNZGI
	DhOt/qXoBYPbHjTtX/+2zwfA6+TRpzJHXfzcOxRD87BMwOfYAq2KkUay897OBPf6FpP2TGfJ0lB
	6txeH8EYTIvrM8FGhF6PprUe8OWSe5M7rhQ/QiTAznL39pmo4jTqKL7mgE7KfwM5y/dFLT3WKYg
	l8h9TKk2nXMFY=
X-Google-Smtp-Source: AGHT+IGW9slpRY/IWqE2w4+xMpgKNg5YuX82XmdT/rmNQejG8ZsGNtQ3sz3PyIPbGqB/NuXoRgNXYw==
X-Received: by 2002:a05:690c:338a:b0:784:8239:95a1 with SMTP id 00721157ae682-7848239a4dfmr199157787b3.41.1761329008294;
        Fri, 24 Oct 2025 11:03:28 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6c6219sm14744247b3.40.2025.10.24.11.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:03:27 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 24 Oct 2025 11:02:56 -0700
Subject: [PATCH net-next] net: netmem: remove NET_IOV_MAX from net_iov_type
 enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-devmem-remove-niov-max-v1-1-ba72c68bc869@meta.com>
X-B4-Tracking: v=1; b=H4sIAE+/+2gC/x3MQQ7CIBBG4as0s3YSwBrUqxgXLfzqLBgMNISk6
 d0lLr/FeztVFEGl+7RTQZMqWQfsaaLwWfQNljhMzriLNW7mdeaIlpC4IOUGVsmN09LZxLP39ur
 DLaw0+m/BS/r//SDFxoq+0fM4fpMs+nh1AAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mina Almasry <almasrymina@google.com>, Byungchul Park <byungchul@sk.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Remove the NET_IOV_MAX workaround from the net_iov_type enum. This entry
was previously added to force the enum size to unsigned long to satisfy
the NET_IOV_ASSERT_OFFSET static assertions.

After commit f3d85c9ee510 ("netmem: introduce struct netmem_desc
mirroring struct page") this approach became unnecessary by placing the
net_iov_type after the netmem_desc. Placing the net_iov_type after
netmem_desc results in the net_iov_type size having no effect on the
position or layout of the fields that mirror the struct page.

The layout before this patch:

struct net_iov {
	union {
		struct netmem_desc desc;                 /*     0    48 */
		struct {
			long unsigned int _flags;        /*     0     8 */
			long unsigned int pp_magic;      /*     8     8 */
			struct page_pool * pp;           /*    16     8 */
			long unsigned int _pp_mapping_pad; /*    24     8 */
			long unsigned int dma_addr;      /*    32     8 */
			atomic_long_t pp_ref_count;      /*    40     8 */
		};                                       /*     0    48 */
	};                                               /*     0    48 */
	struct net_iov_area *      owner;                /*    48     8 */
	enum net_iov_type          type;                 /*    56     8 */

	/* size: 64, cachelines: 1, members: 3 */
};

The layout after this patch:

struct net_iov {
	union {
		struct netmem_desc desc;                 /*     0    48 */
		struct {
			long unsigned int _flags;        /*     0     8 */
			long unsigned int pp_magic;      /*     8     8 */
			struct page_pool * pp;           /*    16     8 */
			long unsigned int _pp_mapping_pad; /*    24     8 */
			long unsigned int dma_addr;      /*    32     8 */
			atomic_long_t pp_ref_count;      /*    40     8 */
		};                                       /*     0    48 */
	};                                               /*     0    48 */
	struct net_iov_area *      owner;                /*    48     8 */
	enum net_iov_type          type;                 /*    56     4 */

	/* size: 64, cachelines: 1, members: 3 */
	/* padding: 4 */
};

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 include/net/netmem.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 651e2c62d1dd..9e10f4ac50c3 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -68,10 +68,6 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
 enum net_iov_type {
 	NET_IOV_DMABUF,
 	NET_IOV_IOURING,
-
-	/* Force size to unsigned long to make the NET_IOV_ASSERTS below pass.
-	 */
-	NET_IOV_MAX = ULONG_MAX
 };
 
 /* A memory descriptor representing abstract networking I/O vectors,

---
base-commit: f0a24b2547cfdd5ec85a131e386a2ce4ff9179cb
change-id: 20251024-b4-devmem-remove-niov-max-0d377187c9cb

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


