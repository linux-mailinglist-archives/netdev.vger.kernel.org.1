Return-Path: <netdev+bounces-171744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E5A4E6A1
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E583189B337
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E76255230;
	Tue,  4 Mar 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHKMulb8"
X-Original-To: netdev@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA870255235
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105099; cv=fail; b=hr6rdpLUgE4IeJqzNGdnchIvZSbTYtt8rLzwDC8FW06YhylWFrlFMZBE5we371X9z3ZTkIlG/TM2cfn99YltxNRH5hnF0ego51IFWQ8A+RDRi8K1Ol8DW58v9K5B8jT7WESHQBI2gS81arlvaR4ZNJZMcLd6cpEmgA5aB99Hy6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105099; c=relaxed/simple;
	bh=d/Wengd+90RLXcT4cA229K9g++HytALzqI3EV/VOshI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vF5hUfoIxPOHhzRM72r3HbjwFOhsgKHJ0KHWOBuJq7OS9hOuD/+b4Zpe1SMRQrbhe8c9BmUl0h3yzzRpIJdg6y4j6jpm2PJSZ48v07oc23H/RYEGsD61yyKclxZ9b6G/XN6jtRTsdEqRxcwb9c8jzykYCVbAFPQg1RoiehoENw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHKMulb8 reason="signature verification failed"; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id CBA7740CECA3
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:18:15 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gdy1LDTzG2bm
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 19:11:02 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 35FE342734; Tue,  4 Mar 2025 19:10:59 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHKMulb8
X-Envelope-From: <linux-kernel+bounces-541210-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHKMulb8
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id B9CA941DCC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:56:49 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 97D5D2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:56:49 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47156189143C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7D1F3FE8;
	Mon,  3 Mar 2025 08:52:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0B1F3BAE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991976; cv=none; b=JN6Z2yX8mOjxRGoNTdlyD4tPiX5KBdrUeVPHoTa+9IKyBC1V0UgdjTIG+xaWyta2+6Yi25KINvDfE/p9SNRs64lARSp3HwAN3gghE9dk4FaDbae/KuFrp/gowRGOunPJZD5u8ymMGeNjc9PtWarI3zYq5THx1BMWUsO0ZnN2/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991976; c=relaxed/simple;
	bh=7BJ75VnqDYEbE9e13G+MCHppvDrRT82moH7VLX3ZmAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YT2nI/fqiXPfVzSEYaDriYPeYMvz6q69O+jZUqS+lzOS6Rvu+5OzMVvQ92rX//QdmyLS72D1dXbq+2NPpnJHYAqzRfBEnyVwCEAKdY5jLOSQnMu47aTFuoiDtB9232mCAZhGzLsNT37ptsokalFkG53UrT25KEEy7HxNWpTtuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHKMulb8; arc=none smtp.client-ip=170.10.133.124
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
 us-mta-484-DvNN2j4vMHa1lbb5_XkTcw-1; Mon, 03 Mar 2025 03:52:47 -0500
X-MC-Unique: DvNN2j4vMHa1lbb5_XkTcw-1
X-Mimecast-MFC-AGG-ID: DvNN2j4vMHa1lbb5_XkTcw_1740991966
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e550e71966so610884a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991966; x=1741596766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5f0Ge/u6HApn0cHLmrjeezLoP0KdtHv+tljpLM2u/w=;
        b=GDpECmJyW90+Rxg521NW1XvvTuvbEtKKmFkC6qYtB8WAtZm1iwH/BXO9e3bTeu+dXn
         ABOx7iOdb4xHkFVGD10d+Bjk/tidaNB8P8+Bjdcvv0MbT66MZwyF66NFfLYUEPGrp066
         CI4SXggZF2XJ3svpgwdAQKpxgAwSGVSRC7HN7zpkwEMUP0oMqNQ8LRuy5vD3zoRX2dUT
         D8oxVWIbCN9RIaUalURZThzZeA/F1xa03U+yZgRR8kIU9XN8UMY5NeHqECddTm9UbFTZ
         g2b7Xt3DzPB83eXhYr/iEcM5pAZa494VSckITasCyq18ilL7XnOt2/7Bwh5EYgByQLCU
         wG9g==
X-Gm-Message-State: AOJu0YyefB7GAki0OGNf/6bEbVznF4SokFnMOzrPr91aP36sk1aUYDvK
	PEkktYCFU8gZKjz1AkN+jF7Usu0U03TIkB9N3LKm+6pHdQ5wXci+E1sa32Ws+jWvoclGWySKQ0Q
	UbcgrbY+yg9/n40AbfbjTsTpdOksnqZDrro8ex9t+nV/HMJp582GQ8+NNTWS+Jw==
X-Gm-Gg: ASbGnctMM7vaRDDMYZI9h6u9VTo/jakCj1oJp5bCWaE6q9T76OoYKuTn5lLlc4Oli6J
	adAe7vbb6LzBnRzt7dEIjsq5LtxK7qc8jSulfo7UbJCDwL1AZ7Hpy9lLue1D2SrvFk3QKRYuMah
	lTMCT7wVvLkY3gMfpVa7fVE1FsKGqzlXEiukrFuxYpHjItOSIweTUuOJZNo5nrRigGc28DAezVE
	Iva/+8p3EWB4tCIwzXyDWjsliIlLF+FGsRyHjXJbG7drANjr5ihTrG06EJ+sk7oPY3t2lM+jbAb
	z88RnnnqZlAZAFtqNrspBzNh8p20yUcnisTpUYRZebxm9ZtnfkCOhplxUSukY5QFkkxz0wbp
X-Received: by 2002:a05:6402:270d:b0:5de:5263:ae79 with SMTP id 4fb4d7f45d1cf-5e4d6adec08mr13660773a12.12.1740991965908;
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gdy1LDTzG2bm
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709482.50864@Kzpj/kYnri0ZATMglaRTNQ
X-ITU-MailScanner-SpamCheck: not spam

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
=20
 /* Set current process as the (exclusive) owner of this file descriptor.=
  This
  * must be called before any other vhost command.  Further calls to
- * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
+ * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
 #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
 /* Give up ownership, and reset the device to default values.
- * Allows subsequent call to VHOST_OWNER_SET to succeed. */
+ * Allows subsequent call to VHOST_SET_OWNER to succeed. */
 #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
=20
 /* Set up/modify memory layout */
--=20
2.48.1



