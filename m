Return-Path: <netdev+bounces-239839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E13BC6CFCA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BAB5E362F2A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9D31ED60;
	Wed, 19 Nov 2025 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zao0mkQQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRDiWheJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE531B814
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535317; cv=none; b=e2DKCPMPE36/QoBavgTJUBhJIlnVgzdzIOE1DLIIyHKxgu3i14mSU7jCutIVovtUx9ppcoH3ZUEqe6XLuylY8rsOk2K8T7QvdLdHvJrJjTEBTKVwKuk8Q5Ejn9d+xUpUlAKkUfbqQd2xP5J+4/P+znKcTBS9hthjWsJBBOdsfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535317; c=relaxed/simple;
	bh=k1goUGFLRnYWiOHlY1f8YG693FK+4R3wtZttzUxNEyk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XnC3HmrJeYoCoeslnMzLAQlICPvol+BxQsyZHEBW5Wn/B5I0AY+JWPT+N8Eu0i0oZKPXH65X8MO6Dzts0UdpmfJO+y1w/zleLNCS6xR5fQfOKuFhMhAprdykNi/BU1EMtrKOXG6XE+gNSjZH6gP3ulGqEowvxcNdaKUfmPltuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zao0mkQQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRDiWheJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763535314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=AmF8UtmERypN0SmhorEC/T0EDvndPupXo98es8iiJ+s=;
	b=Zao0mkQQfAWTOJ538x3nsI5eMsaKHENJBWWuDaPxhVcoDyTFmSuERVMCFanAIv2Zp2Ex3H
	/FyVLvsKT3WlevvrO1V4r8naz1fhC8hhvkHpifNxRDrALyyWAzLwt1f5H10NS7Qc7j1zHI
	HH+Bx8ZnDI4TGNGgOEtr6uZTWF9iKaI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-KoyJbqViOMOF1EP_7DUaKA-1; Wed, 19 Nov 2025 01:55:13 -0500
X-MC-Unique: KoyJbqViOMOF1EP_7DUaKA-1
X-Mimecast-MFC-AGG-ID: KoyJbqViOMOF1EP_7DUaKA_1763535312
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so4263873f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763535312; x=1764140112; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AmF8UtmERypN0SmhorEC/T0EDvndPupXo98es8iiJ+s=;
        b=FRDiWheJQCUef38VkhETmXbjfVs6kaMTDzj+LtnNZV86QlgmgjfrGYzJK4702zjp+C
         RlQBoRW6OWZzwYvkNBqRbv/0I2lRrLwp0btvacufxc17+5hr1tjtQ/S9RY5U4qjC01xI
         GKTxVb+0FgDVkts/rOXEy8wnWV1u7eFiu2jhWTgilYVBLzhH9InlTwJmFznjliRAJUPY
         dRqySYWjUbVqhVVfQnOTDhdwBklaJtHcmnef3u93ZX4TRTOqY72vRKb8YurEqSqPwVYw
         d/HSyYE3m7VobfTd4Leun19NsWCK5ggi22SSrJwN5Rq5aFUFRkR/8TeDbboZwj8wDjrc
         zajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535312; x=1764140112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmF8UtmERypN0SmhorEC/T0EDvndPupXo98es8iiJ+s=;
        b=FjdDIEIq2M9DF3V9suvQPH4Zi6IBy7lb26s7dNjSvLOzZKeJajyR6aYOH1AOBQjcVG
         k3dLC1ubOVaoF5vVs1pLIeIfyJ0gxjSAezRQXA47qsVjZ1fQt2Cpqi94UZRoYT5JoLaP
         54bGsB136pnPExsI2iEl1IIBVekDz0Dt5vyXJ24xzbsufBL9Ly7VfyMZw+QbpK0sXehg
         qjxsxF64flO671njm/JrP0o4G7167mcmnpit/vu+HGBghzkx/mqyi2wPNjsYvEptZQ9c
         JCcViJGWqnZ6SO2trv5eCoMzM/ayQ+IoBU9FePRr0CdNzfLNFIM5AEGOM4fzWSBpmIT0
         DZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxEoDCT87u0AMRc987kynkJKxbmX3EHHqi4y3clrsgPPSIP8lgR140xzes+sUoPX3f2gvzkMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJu+0xLC21MncngqutYtLR7e5pONBzEpEaHIxQ5wPiDtIzJfni
	GKJS+wNfZ5PiJFXZGg707+y06wHfa9g3RXRAhDMT0WvqBd6HwBNlX6itYAQfsyTtk3EbyU9HgQP
	Diva0pige6XvgPfjR41pH9xTgw9wT/SsWvnSJaCYdDWe624ESxJ2M1Hc5Yg==
X-Gm-Gg: ASbGnctYr+qSZMG7iEwVFWWXt34G+gAnNWJUmAmiW2U8VQT+rA6kjl6Jsd1RGCFnwU+
	mUDa9+0LdRALCbQCluXl7f9K2+QjqZPQ7L+K98zpYH/yjfMP9sx+TNdLIV/YtEXtPkYux5lHonZ
	PP7jMsLy/KxMiv1d/tExJgs+1VRx/a4IS8ZHM2TvgKONXDg63ZoSwlyoso5DA+POD+voaSwWexO
	C0Y4yuJQsWUiu1IaBp1sL/xYubadToxB/KaqF310hiyriQ5x5/tVYn2PGmg+6wlCShKf25kpct8
	V8OAyEBTKrwDPLu9JfJlhdVsRTss/ncnPVgzo5HY34R8HMBtI4QQhMAmPHkMqF6N/rDRICfwudv
	zJ2ptlzbelt+zY8BGn87L/0QxZ5GxBA==
X-Received: by 2002:a5d:64e3:0:b0:429:ccd7:9d94 with SMTP id ffacd0b85a97d-42b593954a1mr18869472f8f.51.1763535311772;
        Tue, 18 Nov 2025 22:55:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfj+W4rZkCy+pTT7CJvO3zJ+eyBS0O5AvHoo22fcnNNP1yE8aTkZfwKuiofxYmEYEMCNpYUQ==
X-Received: by 2002:a5d:64e3:0:b0:429:ccd7:9d94 with SMTP id ffacd0b85a97d-42b593954a1mr18869443f8f.51.1763535311322;
        Tue, 18 Nov 2025 22:55:11 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b617sm35673024f8f.31.2025.11.18.22.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:55:10 -0800 (PST)
Date: Wed, 19 Nov 2025 01:55:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5 0/2] virtio: feature related cleanups
Message-ID: <cover.1763535083.git.mst@redhat.com>
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

changes from v4: address comments by Jason
  move features variable to beginning of block
  unsigned long -> u64 - they are not the same
changes from v3:
  drop an out of date unnecessary kdoc parser change

changes from v2:
- drop unnecessary casts
- rework the interface to use array of bits not


Michael S. Tsirkin (2):
  virtio: clean up features qword/dword terms
  vhost: switch to arrays of feature bits

 drivers/vhost/net.c                    | 39 ++++++++++++------------
 drivers/vhost/scsi.c                   |  9 ++++--
 drivers/vhost/test.c                   | 10 ++++--
 drivers/vhost/vhost.h                  | 42 +++++++++++++++++++++-----
 drivers/vhost/vsock.c                  | 10 +++---
 drivers/virtio/virtio.c                | 12 ++++----
 drivers/virtio/virtio_debug.c          | 10 +++---
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++--
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 29 +++++++++---------
 include/linux/virtio_pci_modern.h      |  8 ++---
 12 files changed, 109 insertions(+), 70 deletions(-)

-- 
MST


