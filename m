Return-Path: <netdev+bounces-171118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B40A4B9F9
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70E5188D895
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D831F3BB5;
	Mon,  3 Mar 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHKMulb8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9041F3BAF
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991976; cv=none; b=NNjLrC083B4/mWIr3JRCtK0vgbCpKErk8SbSeBrIgs51yKyCrB4n42FEf8aSAz+qtSEOt4TGr0xbTqFtwWQzhD72QcT94lXX+1StTMVDg+qAs41Maaq+mrPnlO9EqWBHAtucA88jQOw8ADmlIkhgUYVBiWhUq3esZvma8cxjXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991976; c=relaxed/simple;
	bh=7BJ75VnqDYEbE9e13G+MCHppvDrRT82moH7VLX3ZmAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YT2nI/fqiXPfVzSEYaDriYPeYMvz6q69O+jZUqS+lzOS6Rvu+5OzMVvQ92rX//QdmyLS72D1dXbq+2NPpnJHYAqzRfBEnyVwCEAKdY5jLOSQnMu47aTFuoiDtB9232mCAZhGzLsNT37ptsokalFkG53UrT25KEEy7HxNWpTtuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHKMulb8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740991973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x5f0Ge/u6HApn0cHLmrjeezLoP0KdtHv+tljpLM2u/w=;
	b=LHKMulb8ZRkrmLqS/nzF41xVyQdCfyYpmDB4eIRz9CbJEpcpSPkr1PoJbaI9W+3NPEbxcH
	4rjwIQRCgpJcaL4S+HyoyeOhvlrIDD4IUSPqdWE8n5/nZtg53UAxPSRs1IZd+gDUhOPBbS
	UAjcviCqTpkkZfpy1TcopL0VJXUGOy8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-Lpd4yDGmMeaovyFBEL2Y7g-1; Mon, 03 Mar 2025 03:52:47 -0500
X-MC-Unique: Lpd4yDGmMeaovyFBEL2Y7g-1
X-Mimecast-MFC-AGG-ID: Lpd4yDGmMeaovyFBEL2Y7g_1740991966
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e4c5225b64so3959746a12.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 00:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991966; x=1741596766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5f0Ge/u6HApn0cHLmrjeezLoP0KdtHv+tljpLM2u/w=;
        b=NKhiQ0IXSmHz0J2vHRmVAY3x/eCldX2yrBLTMKKNKyvD8mPIL42ZcYkpTuMUMh2xB7
         KYMVZPuunGVpBVxrCIZSSZs8LYLFLel/4qb+auU3uuU6PgtynyhEZICqI9C1PI8exyD+
         MnY45aolA3gMtUcCz6eiNnNMxEBFR4xRlG3gb31OvcKvvKP0dKsDVAT8T4+ElM7BF74M
         GcnGseH+C3i57bzoPlD6uEvX6fbqQYUof85K209wR14ecq57pOCjqhy3hBmXSrX/oh8j
         jZxiuwBRI+colkJJYXMDewHRAeDf/QYI33HIrVctKozn9vQkcaYumRHYSjJ+DWkJBe+P
         DUOA==
X-Forwarded-Encrypted: i=1; AJvYcCXTznntCt6mvOOMLhrFzqM0O9/pzfodXvwx4+bfTu8mA3KcOqllEeuquncVLoLRQwGBJBrF7uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8z1zUG0gQoJkZXLddU8c13dWhxDFv4eeyh6DIBJM7jesTOVgb
	XcalKwQ7sRCyAXMA1BAYWUor3zA9XRHg8bmX6KJKKEDDZrwSZs6kIFjKWL3YShmu0/HDuXiht77
	/KkqBpw8w6sETUGxhJjDB8sXqsdLJwVaIFQAGZG3xIaoPLw8NUYkW6w==
X-Gm-Gg: ASbGncv1b4IYdW+Md1OvEkletoBANNljy2t52IhGd56oaV3lxR1/yuJbfRk+4gZdZHn
	Y/a6OLxwW3b5Tp/FOmz2+nrl6HE9zzmMfgs7EyBOKSCLb1sATw7qr2jNSvKuIJbiu0TOk2peuOK
	PbvM51i9LA8ixl+ndbUlNCe32OIGMvVuNG2O0aDbdoRRH2HhTs5v9UW+ET/1Vcjue7sKhQIjzrc
	tBCni3wxkLXrdG3Su58XpIkce47dCZCNFBH6sq0cq1A4yFe0mLzvWjRXmcNoFQCdk7pFImoKYak
	zZPtMiV9os4lSW8c40QdgQkW/iG6QG022Cxotl4HB6ISp52H9WlC1P43hAaS7Q9phJra5SHD
X-Received: by 2002:a05:6402:270d:b0:5de:5263:ae79 with SMTP id 4fb4d7f45d1cf-5e4d6adec08mr13660766a12.12.1740991965899;
        Mon, 03 Mar 2025 00:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo44UCmf/nhSiQ3s6omsM4aVzpmAfPARCDmTuHp0dZeSeSv2Z6WHtZA+hKBPUeIaCokWugDw==
X-Received: by 2002:a05:6402:270d:b0:5de:5263:ae79 with SMTP id 4fb4d7f45d1cf-5e4d6adec08mr13660741a12.12.1740991965384;
        Mon, 03 Mar 2025 00:52:45 -0800 (PST)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb5927sm6466076a12.53.2025.03.03.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:52:43 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost: fix VHOST_*_OWNER documentation
Date: Mon,  3 Mar 2025 09:52:37 +0100
Message-ID: <20250303085237.19990-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.

To avoid confusion, let's use the right names in the documentation.
No change to the API, only the documentation is involved.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/vhost.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..d4b3e2ae1314 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -28,10 +28,10 @@
 
 /* Set current process as the (exclusive) owner of this file descriptor.  This
  * must be called before any other vhost command.  Further calls to
- * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
+ * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
 #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
 /* Give up ownership, and reset the device to default values.
- * Allows subsequent call to VHOST_OWNER_SET to succeed. */
+ * Allows subsequent call to VHOST_SET_OWNER to succeed. */
 #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
 
 /* Set up/modify memory layout */
-- 
2.48.1


