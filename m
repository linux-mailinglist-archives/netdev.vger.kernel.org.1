Return-Path: <netdev+bounces-238920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA710C61146
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 08:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5490A4E4E30
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC6628727D;
	Sun, 16 Nov 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYkGFxpm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qqh623P/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC1285C9D
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763278596; cv=none; b=pFMe5qXeUCGTD7wwH42KsOO24+tkZCJm70xfFn8NEd5IaXL1fX4b93dPjrzJcr/xMxEPkXIG0tHpUDEvGpnS064lGORJheEuizk6kvg/3Uwz7uAACt+debaV5rSj5KZmnrFIygi3bjNdEC+3MpgVUHIZr6fkhN49kHn73lA/vx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763278596; c=relaxed/simple;
	bh=/wU2PjO/9k2SX10eUAJ2SEQukhtmpyHpHIXxtUzeWto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hqlDd2wyRiHgr8yehg7CXbh9gpbTO8rGu9+C+xAZx5mlRAKVl1N29344/UQzQfAcaharkycNWn/CLov6PSBUFifz36i4JzUICItVwUqrGtiCWBoc6Y6vdB5/k6KfCWC8ipzhSAv3Ji74LBBvQgFPkTCpTsf5Gbf62C/XB23tXGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYkGFxpm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qqh623P/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763278594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=b0yaVDVgrAO7aUVp8P++ObXwpVxREDZ1FEXCsETlzo0=;
	b=XYkGFxpm8t5OxVj0IQ9y80Ztf0FX3WZQF4lEjc7Yg7WM/2/5/fQlih0nzSzT/vL6krXAyL
	QNnP+YHBIQALoMV19L4iHdWPwk6wXo410krwCYRLiBpWLM7IYvHaouTBSWTpmd5Ue0r/tA
	LDJUq6R5Aidg0fMtyy8H9RZR+pqlRII=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-1hBkLA2uOgeUKHhjzucpTg-1; Sun, 16 Nov 2025 02:36:32 -0500
X-MC-Unique: 1hBkLA2uOgeUKHhjzucpTg-1
X-Mimecast-MFC-AGG-ID: 1hBkLA2uOgeUKHhjzucpTg_1763278591
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b3155274eso1267325f8f.0
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 23:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763278591; x=1763883391; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0yaVDVgrAO7aUVp8P++ObXwpVxREDZ1FEXCsETlzo0=;
        b=Qqh623P/iRVGRWu89+BHV5Gz6faoTprK/wvT/Nz1c3adtOwfy445Us+QmfT5/NwgU0
         ATpEEAhUEbfALx6CXvgcsKvgMfrLqvsUN6Wit3XwBCV1qaeLwmYzTVj/9bocsMULpSvd
         Os+a9eNLZVyjkXFUnoG1Ni044Gf2rqNKM0LPHdDimvkbP93pqRXYWwtf4iVq93xiWS2Y
         DJ2m1E7gBptLha2YtuRgWAj+fyqK6w8pqO93nhq0+bRQB9zT+eoYPJtbc7kRhAoxZUKn
         iJH6i/Et+TptzS5Mrdq+IzzhhLCHbpOKbSKaPHzvujzv5YlksTT1Z47qzA5vSDB3fGbx
         Z3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763278591; x=1763883391;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0yaVDVgrAO7aUVp8P++ObXwpVxREDZ1FEXCsETlzo0=;
        b=FCbEp7Wa8cuF4g4Akr8BI7JY3OxQ/xLWSb897ElXPiT24uqIuEMnp5M+F8BwEtlGl7
         3D8cHGXvhbZ/fFbyWeuAeaWlEXP1jjNpu6/YQrSZWVTGfm8BTGBrobitwrG51xFSX/8I
         OIFqHD0AVW2C4NXA0X/kxNEYM5AuCjMPSnkZdSNvJLxp+ShV6NkGcU1ECZLdoNYiWfv+
         vfIr3iazPCWs4xxt+pWwsjevAQs93XrLOYky5jiS94odwysf7qDJiv3fuAg/OaSlD0zH
         WljC5+QnWP3ks7746NZiCwSWC6ernAwsGKqc0wgiiOQfEbvSLvQlHJK8jaOpwFhJ1/eD
         sS+A==
X-Forwarded-Encrypted: i=1; AJvYcCUjQAHlB6XH+drYYfQRZVsFd8mgcc2imWWj26Hx7kY4ju3gAxSC65hYdHrg/lAWzQJQ9GvQ4WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+xklsocP1BFlcevusmVDWZnsGC05kMRLw7wRDclBGnMBlbd2
	Nzq6unaFVkdCgz90hBosfZiRhyQJNz+BYUsq//deQiMZULJpVUn+saUfTGSPoTboa0Nhr47/GfE
	KBBrpvRe7bO7iHU2SWKGK6QCOKrqHGQVr6lCxcj/Pn9bM1fTG9v3sIy3kfg==
X-Gm-Gg: ASbGncvAUkRts8AkvOHj/TH4R63IMqLuZ77YU1op+4Yg1vN8LxOGRw5Gb0qUTek/gXS
	lSj9HtbQQn4xknEyba+ZLKo1UR+xwB3N8an54dFUCsgNOxb2fWCenDwOKoE/nOru6T2dpwxi5bQ
	pFZ4HSCWZFBKN0WRsqTPjg1IsaXTLLp2+V6Op5Cb2cAqQANQ7OKjg8jRJEyEbcUXvXgMOk8bt70
	SI4/nls8a3ICos+AUNPqcrPjpjXRxX6xW3GJemkLImtY2FTFFnLHKOG+pCLC5HmwdL7mftpKfv+
	lG79Up3HHnvDP30ceu57mMdgl/2sgEwd7eIDrbb1SxShNishM/Odt5oK9gk2FL5d8SMeLaQXZ/e
	WBjW2Y6lONZLR/S69au8=
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4778fea8ab2mr86716395e9.33.1763278590854;
        Sat, 15 Nov 2025 23:36:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqZuOeT1wAABazsJ0HksCXcwMYVBBLygHfL8/xmHfq4axK6seTI4Hh3FvYH1PcGLCWD6fslw==
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4778fea8ab2mr86716095e9.33.1763278590441;
        Sat, 15 Nov 2025 23:36:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47796a8a695sm79746965e9.13.2025.11.15.23.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 23:36:30 -0800 (PST)
Date: Sun, 16 Nov 2025 02:36:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 0/2] virtio: feature related cleanups
Message-ID: <cover.1763278093.git.mst@redhat.com>
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

Cleanup around handling of feature bits:
- address word/dword/qword confusion
- simplify interfaces so callers do not need to
  remember in which 64 bit chunk each bit belongs

changes from v2:
- drop unnecessary casts
- rework the interface to use array of bits not
  arrays of qwords

Michael S. Tsirkin (2):
  virtio: clean up features qword/dword terms
  vhost: switch to arrays of feature bits

 drivers/vhost/net.c                    | 44 ++++++++++++++------------
 drivers/vhost/scsi.c                   |  9 ++++--
 drivers/vhost/test.c                   | 10 ++++--
 drivers/vhost/vhost.h                  | 42 +++++++++++++++++++-----
 drivers/vhost/vsock.c                  | 10 +++---
 drivers/virtio/virtio.c                | 12 +++----
 drivers/virtio/virtio_debug.c          | 10 +++---
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++--
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 29 +++++++++--------
 include/linux/virtio_pci_modern.h      |  8 ++---
 scripts/lib/kdoc/kdoc_parser.py        |  2 +-
 13 files changed, 114 insertions(+), 72 deletions(-)

-- 
MST


