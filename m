Return-Path: <netdev+bounces-84183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F78895EA5
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 23:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41821C23B69
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E36D15E5BA;
	Tue,  2 Apr 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlieJNnv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4CC15E5B1
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092909; cv=none; b=LlxmzhGICyBef88xY5ufd4I28VvLDLxQG8h+vB1Q5Wz5aoP1GyJ7eX4FNUPx22+TbIpKWBkY0aWuA58GPmBwNgLahXfxZurDarBvCbYYuj2w/EZA8w5OZAVepefJKoN3nAcKrKlp44M4TpSvTvP2+VO3XE6ErbTv+AhcSjGmDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092909; c=relaxed/simple;
	bh=CeTf1GnLqEGbq7mpbpnjAmCKKQFZ0fqT+cHVafZlASk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jwTK4PU0EpR5GFZEizMQN9YgCS9HZLkkYaFFCBU96HKNyFfJiB1RBS648A2cE+yZGni+8QjE8vzof8wCAx4bOZVLjQRZ4ChmrZkl96heRsW0n5TCGfALFEV4WDDCBDsxBNzD8CX3jGfyCCaGYIoT2+GIv2m7HT8eVJpKqTh2DB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlieJNnv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712092906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=L+alDoiqMN7Nxu8CAo+qwAjzO+OBQsTVsBJwYvjZdYY=;
	b=RlieJNnvIe2TYL+Z4mCYHUBvhV/xpI13OA2nHL7vFr5EJL7Mej3Il8yyEg9qcBlX+U48So
	dY8DB9nmEwexupwUpAPeKPeprkU6Zr1hGkweW5dmi1uYvahalRMNAD2+byu82cSca+EhEJ
	Qc5AkynbOEaF2XHEACBaDv4HRWg1rH8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-4XutR4_VOxKkOEJChBEWHA-1; Tue, 02 Apr 2024 17:21:45 -0400
X-MC-Unique: 4XutR4_VOxKkOEJChBEWHA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34370ba4105so522059f8f.3
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 14:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092904; x=1712697704;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+alDoiqMN7Nxu8CAo+qwAjzO+OBQsTVsBJwYvjZdYY=;
        b=vVBOw+tmLteK6M5MDAJlxfTGLpYvZOZnSBazsjFWmZp61FohaKmlgBxOtqoHn4FzB+
         SvHz4yzhPvKqKAycsGgvYyC8a7N6hc8aKp7DD40nLCQRSmjuPIm9WZg4bNNT2r/waz8W
         DsATzJbIJxJg3PnLoNCEElnrwJY0D/KeCb4JVxd2wzxYlTcxMJCUdZTENU1Tf/VwlN/s
         b4WrzOKqp0X4X48Sm9i1XZ9+bhYl2lOfvMiQGymC91j+cINR41rc/DGl4YGWm2v3oyMx
         tJTEMxH/x4uY8LHx3XVuqckzHDUsdf5Sn8w3tbM98oP6xsA8/XpR/iSZCPacjCP4cV5p
         m7kA==
X-Forwarded-Encrypted: i=1; AJvYcCVxjOYV72HbNgQy6vqKWBRpVP9GfMai1EJjv6Wd9Edgd7zjvX3XZaueKLr7HsYacwrXT0PNp2hZW0L2YjSDHwvvT7EfXREH
X-Gm-Message-State: AOJu0YzVda7zokhg8oxBQ40e2Ubuq9Z+agPMeoeWyuo/ltYVc1mIobTa
	RUe9CYYaxizWf5ZmwDEm4Nkh8yU2xLL1LQt+CB7mmCLHokG9rwFARpAfWapFwmQmXAGWlwK455q
	iJjW3WEUUB2iFS58XLgMNrCqthc28V++6QtaycZMtogerQedDN6ivdQ==
X-Received: by 2002:a5d:598e:0:b0:343:4c43:b38a with SMTP id n14-20020a5d598e000000b003434c43b38amr6924827wri.17.1712092903836;
        Tue, 02 Apr 2024 14:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoLR2TiY4NlePQYEkpCrVsZpefzcsOU3LO3zWyGpNr1faKWUSZIEppdou1j4Es/gmuSNpz7Q==
X-Received: by 2002:a5d:598e:0:b0:343:4c43:b38a with SMTP id n14-20020a5d598e000000b003434c43b38amr6924812wri.17.1712092903398;
        Tue, 02 Apr 2024 14:21:43 -0700 (PDT)
Received: from redhat.com ([2.52.21.244])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709062c4d00b00a4df82aa6a7sm6888784ejh.219.2024.04.02.14.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:21:42 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:21:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] vhost-vdpa: change ioctl # for VDPA_GET_VRING_SIZE
Message-ID: <41c1c5489688abe5bfef9f7cf15584e3fb872ac5.1712092759.git.mst@redhat.com>
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

VDPA_GET_VRING_SIZE by mistake uses the already occupied
ioctl # 0x80 and we never noticed - it happens to work
because the direction and size are different, but confuses
tools such as perf which like to look at just the number,
and breaks the extra robustness of the ioctl numbering macros.

To fix, sort the entries and renumber the ioctl - not too late
since it wasn't in any released kernels yet.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: Namhyung Kim <namhyung@kernel.org>
Fixes: 1496c47065f9 ("vhost-vdpa: uapi to support reporting per vq size")
Cc: "Zhu Lingshan" <lingshan.zhu@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Build tested only - userspace patches using this will have to adjust.
I will merge this in a week or so unless I hear otherwise,
and afterwards perf can update there header.

 include/uapi/linux/vhost.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index bea697390613..b95dd84eef2d 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -179,12 +179,6 @@
 /* Get the config size */
 #define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
 
-/* Get the count of all virtqueues */
-#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
-
-/* Get the number of virtqueue groups. */
-#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
-
 /* Get the number of address spaces. */
 #define VHOST_VDPA_GET_AS_NUM		_IOR(VHOST_VIRTIO, 0x7A, unsigned int)
 
@@ -228,10 +222,17 @@
 #define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
 					      struct vhost_vring_state)
 
+
+/* Get the count of all virtqueues */
+#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
+
+/* Get the number of virtqueue groups. */
+#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
+
 /* Get the queue size of a specific virtqueue.
  * userspace set the vring index in vhost_vring_state.index
  * kernel set the queue size in vhost_vring_state.num
  */
-#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x80,	\
+#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
 #endif
-- 
MST


