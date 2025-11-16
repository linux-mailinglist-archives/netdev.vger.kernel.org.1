Return-Path: <netdev+bounces-238921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0187CC61151
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 08:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CB864E43A4
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693412641CA;
	Sun, 16 Nov 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW83ZUhC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="miibqhie"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F0225A35
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763279124; cv=none; b=FY3PduMBDYaoCDDjWNxXeEj0pnCGOmj74rGgH+XWiZXKP2LZzl1GhI8Upv0XKAdqzgeiD1AeAHqBak7F3cYjD0TR0VfyhYWKMvgror/5yvB8YGm/+i527TFpBydqjlA9o08SpkuPYKdB9USdzxqRbHuTcldQarQ3tG43qy/a5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763279124; c=relaxed/simple;
	bh=YVrAdAzCc2XLQIIceUnkGGP63U/MW+iwXEhmvrkh+/0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hw8ps4trbvo+o7jqhk5PrmONeWghdMTDlliIaIySPfPK2UY+dX3PmmNbfp9loWtt8pp+nsvG5ksCekeWgzPFhX0G+EUvovRu1CLreClvNhkAzdO8OlhmJwIMaeyTJVVdnCMglojbvyb6XkQWZ5ufrO2azxRY2u2X4LgSiTDQRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW83ZUhC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=miibqhie; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763279121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6EMg3NX6c6HdI7rjPLbQWwYtnFdehdSrlUN2EHSpFLI=;
	b=NW83ZUhC98ACU+mAkr7+Zc9INZMIpX/m4RD6qEv9HTLdjXGznAX0lmMl66olpTWHnvXekT
	3URgRUr7pWWgPPkRQWDnRtx7/4c0CydBeDz/HrlhTxuMRa84F4loSG64DUlcKgHJVXuGbK
	xBv3ZvFFDJ9sq2r9QcYGSAsUb4ynuPo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-ZRXvcmUUNWOCh-gY4vl5JA-1; Sun, 16 Nov 2025 02:45:20 -0500
X-MC-Unique: ZRXvcmUUNWOCh-gY4vl5JA-1
X-Mimecast-MFC-AGG-ID: ZRXvcmUUNWOCh-gY4vl5JA_1763279119
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563e531cso28142965e9.1
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 23:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763279119; x=1763883919; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6EMg3NX6c6HdI7rjPLbQWwYtnFdehdSrlUN2EHSpFLI=;
        b=miibqhie0W+iBONwaBhJH5UDGwURmLk0wBJQOQNjfgNlPvtDHQeoFIfCIuhzUw0puF
         BVQlz/IX2INIzg80T90fGc5vuWcvFDdo7UtLKpvtCJ1+0tQuG8+s6c/hUz4glmwFFUKk
         WCo0xm4iwJAeHKLxxgUEAvtpPTyQI4MxkTOHgH7WLX3xYPIBUIuLdA5YRuKM2CWnx+Uz
         jKIsTTuxSIWo2QQfs+ToraIsjeq0lFlzDp67t66QummEgv3WzzLHSAnqhmCx0cYbjw/Z
         cvhuECvBRIgT/kFBK9IK4GKxCKFdLWi2+N46DLEW1o+dxAozFaA8eRt50AHNVqwDqc5W
         OUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763279119; x=1763883919;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EMg3NX6c6HdI7rjPLbQWwYtnFdehdSrlUN2EHSpFLI=;
        b=DrxTYSr0is9AgMCqQjrD74FbwkSG8dVb5ye46mBLPXSE6IKlhRuhEICVkLLTZrED4D
         myLrprkIo1KuIBSY24dGzE92iMzj8nbBeQbLihvw0Jf5DwoVmhQSeM0G6RaP/UdS2etK
         5SkEFPOYfaEng7nV/MCKSnFDHgqEeRLqF3tHWzzgMfhksBLmeROkrLUTHMvQgmH9uEZh
         67YEKhGbiyARN0jC7r6+8TEm0f3TWZbel1nNcHuQcMxCalZICoReC1HNSHegGpQTIJZA
         X6fQubQb1hsPXAddEtu+JNzOR3faAcotVLWHzI3sLpVMTFkP29N+BBstvfktamOvxtwr
         zW5w==
X-Forwarded-Encrypted: i=1; AJvYcCVtl/IDKz/2XanycwOZXuN6ShOkQFjelUuvcmnIvkVLZXSfUO78KxEc4GkuF1PNdoGGmm0TgcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZVcZ3LwMqQjBNMbExmccYBixXFYlXCVNhwAsAnI0EtdOCEfe
	Ocy3s18tl/FSL4oe72x7HD020NbAltsmXVDJJMTEYzJHLO8HuE03fHqTi7ddrR9ttnz67reXD5X
	Bkqy4NXeIAKhGcujqV1WPKcA491ev5UxoCUzS9C6D3uXoa904fzIfT6+IVQ==
X-Gm-Gg: ASbGncuoj2CbIajMhjz0JRMi/Slj1ZJ3FFjU7dGQZnkcKuojbdKTxxdDL7v0E96BDbP
	jc6TL5Hej8jJYAAWYoexG9eva0VRDNT4Rb2GctXnTlCf7Jyuuv+fCNwNQW2k+OJryeBfcofLdDU
	AjY/0gAWbAPssUXMME6NSVS8YOVg3SfHh0wZyHvQabr5TFncGjMmuD56HAR03nbARm/EVPNZ9oM
	qnBh7IjfPwEvore3QuS4+LbfDkfq0Jvlq2c35AvZOWC+XEbIv5y+r6zAKGMbPCOKVmKmTJFDd5Y
	4WQwBtj+urCJ2itN06Pepi1eK2XlSvbVUKWGg05a8xiP4xE8q1V2I9r54hOPbOGAsv+Ip4iY/1q
	jTW7veo6RQe6qqpCML9E=
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4778fea8ab2mr86893915e9.33.1763279118949;
        Sat, 15 Nov 2025 23:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm2k2Zhl26gIjz/7McugHmf2Kikp5zoKyp0v+rWLB1S2WlAgfk8AyjDIjgk38rvSQc724vmQ==
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4778fea8ab2mr86893775e9.33.1763279118556;
        Sat, 15 Nov 2025 23:45:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779a684202sm64265025e9.10.2025.11.15.23.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 23:45:18 -0800 (PST)
Date: Sun, 16 Nov 2025 02:45:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 0/2] virtio: feature related cleanups
Message-ID: <cover.1763278904.git.mst@redhat.com>
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

Sorry about sending a bad v3, there was a chunk there
that does not belong at all.
Lightly tested.

Cleanup around handling of feature bits:
- address word/dword/qword confusion
- simplify interfaces so callers do not need to
  remember in which 64 bit chunk each bit belongs

changes from v3:
  drop an out of date unnecessary kdoc parser change

changes from v2:
- drop unnecessary casts
- rework the interface to use array of bits not


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
 12 files changed, 113 insertions(+), 71 deletions(-)

-- 
MST


