Return-Path: <netdev+bounces-231305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ADFBF7339
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553CB18970EF
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B2340282;
	Tue, 21 Oct 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOaH5L36"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1833FE3B
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058620; cv=none; b=MyAvw0UMs43ojllP0H8waXmUnblncZyyaJxXryQxOUHKsDkcncgsPHx16BjZGzMBg9zD1i0QCzUtpdr7GJmnr2+AEQEVv6h+MpkQNuYkdYjRrbx314k5jrUPLJakh5OGCS16/xwo77SyoBvEB9+8Yf55IUaeBHINIrGrb7frTeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058620; c=relaxed/simple;
	bh=lB0O8j3S3miMAone/f+ICAYtXJf1J8inqWCWvoB54Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IxzLhwhgkNdIDq30pcc0pm+ulpUW2R0qI7AgOODG9YJC6BJyu7z+Sbusj3VE5Hy5ALSJ3AMkduNVNCv0oycFNKr1rN7bBn4InyIvFPh+NzkLdNWEE0EPig/+qdl12c+HXNxTCwr9PfUStjJs5JLAndSIgpXahtDUn0Q37ksgAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOaH5L36; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2Ber0DwJnF+w6pf5w+EAkS6wDZY1zESW0Eqmz8tJxow=;
	b=aOaH5L36d22Ik5OkCJ6xlYJrN8igtZbw9XUDEXPPGKlqHYsUZEedM3IsT5hFHziWwQ41CQ
	e2emQ0Lo6p6bzcjWePNActZSDovvbCSsfHZaBISlxEraRR1hvAMN9ujd8LF9wTsmRDcLwN
	OSkbkpA4RJbjoWfP/jzryG0rZW7b7Z8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-r26rW06bNe6MlRb0_yxi9g-1; Tue, 21 Oct 2025 10:56:56 -0400
X-MC-Unique: r26rW06bNe6MlRb0_yxi9g-1
X-Mimecast-MFC-AGG-ID: r26rW06bNe6MlRb0_yxi9g_1761058615
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471148ad64aso23723665e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 07:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058615; x=1761663415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ber0DwJnF+w6pf5w+EAkS6wDZY1zESW0Eqmz8tJxow=;
        b=SgkQ+kfUKfw94E1jFjV1fYpCm9cDt+PnQyenUWcJYd3WqAqnh5rBOUVoM18qb86mJe
         /5u3AdV/wKaifTW6VZnC9+RWUR0yZSZJz/pc6N5UFd6jkcL85/c9w2AjReoqZodrF5+6
         ye85gGGG5K8dCNXyWFMsYTbIxhoiM92VvmYSMT0d1zTnsW+B7w8gmHg5oBc96xBrIk7W
         8kOlr5ePBwHz420YIknqX+MWjHIEXZ6/5km1VrViXVyA5NEH5kRCVyc3Kx9a7k6V4ray
         AkuNoy1W/xMGqRITC3cKVGXCJ9z5wRnhM71agg4uoSbd3p/VQXMfo/QiJMQ4sBWPPLmr
         XwWA==
X-Forwarded-Encrypted: i=1; AJvYcCW3BuTzTWfXOVVIb4/s1FyhCuvBQmAMdZr5ZoQaR8tVRfAihKVIR3RHUGrLRDNhiJDaWlb/0yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDH4cLDjBlerCxJMhkQT/Mh7nHh6vF8JYUrdkuxRcRxcS3IMwH
	TLvg+C7jlcjj4dwZqJ9g07c8bq6I+BBg3rQlC7fsapN8XV8aFuAG52VkBm+p9A1VvtxzBTOL60E
	6kprsOf+WgHyCiB3FI7H2ab3B+12vKy0kRRv7zobdEAx/7min20Vnlt/TWA==
X-Gm-Gg: ASbGncs1wqBLk+woecnuesRLdxb9mHdFca33zZ6GhYDM1Ytp6Ffd8SWAeFSLxjB0qG7
	scvwyNEmzOFAJhxunZe3zSLZEwOjxNX/p4wpNPznu0qCzVbfF5poLyk/ZwZPIiVyYqM9+nPJon+
	a7zJPkUedDz2PyhU0IZFmDSWZhkRpINs2HRvR5uRKJ6RsS0EgJSVePtOWZ57Qt1s7pzWpJs8ouU
	gqpjDgM4rKTSfanA9ikZjWeDsPGTUbojNPmyCV6Jiotzjb4hUcyAnQh+qtKCurQQnccpXpsTnZ9
	mvR+TMRgjacDlZPKXAWQIh2CPT46gl+IDdhmQMu+gjMREOSGnM5HhkZLxwn2ZGFQRTlv
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr124347075e9.5.1761058615406;
        Tue, 21 Oct 2025 07:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFktoT+limgbPVdpx1wPopFmtIPHLY2OPatp+bLIP4HKwWumE1HcGxwTuzl98f6QYo38c2HQ==
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr124346865e9.5.1761058614813;
        Tue, 21 Oct 2025 07:56:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ae5510sm19394145e9.3.2025.10.21.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:56:54 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:56:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: [PATCH v2 0/2] virtio: feature related cleanups
Message-ID: <cover.1761058274.git.mst@redhat.com>
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


A minor cleanup around handling of feature bits: this fixes
up terminology and adds build checks.

Lightly tested.

changes from v1:
	dropped using "word" completely


Michael S. Tsirkin (2):
  virtio: clean up features qword/dword terms
  vhost: use checked versions of VIRTIO_BIT

 drivers/vhost/net.c                    | 16 +++++------
 drivers/virtio/virtio.c                | 12 ++++-----
 drivers/virtio/virtio_debug.c          | 10 +++----
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++---
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 37 ++++++++++++++++----------
 include/linux/virtio_pci_modern.h      |  8 +++---
 scripts/lib/kdoc/kdoc_parser.py        |  2 +-
 9 files changed, 52 insertions(+), 43 deletions(-)

-- 
MST


