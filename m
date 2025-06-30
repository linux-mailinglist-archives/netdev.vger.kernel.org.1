Return-Path: <netdev+bounces-202570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A3AEE4B4
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5613AEB4B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCAF295513;
	Mon, 30 Jun 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSmdwLcj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F231293469
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301197; cv=none; b=CJS6q8xPMUgQYSTbsUQ54AdOn8eayET3nhLji9rai3I9Ni7cZ/erQJ8ih7bTcHamg9uxvYP4uQEYUYfiM397/kYErtnySH2iiwfjGLn1nidUb0UqePGkYcchA9+1r/ijsT9IS/Ft/KH9UuKVaJFz0DNrrdYMyOuSUenrzyzWUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301197; c=relaxed/simple;
	bh=/1mZkg9E1CztpAIZTDXcSM72W7GdGrTSeNoLQv6fDzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKeJ5zbOhA0GElDXDXXIQn1xQGXtEngv4u7oJBJB3YTs6f9qqTxej/cXOUNA2ElQW561FblIc03deD067w/fw/gqAs2efI79eDrUGYkVz8kv7dvv3GI4Gb4T0CGWVfMs15IlnExWh6vbXVPgahR0KYdivlvWL8DRubUdK2rshbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSmdwLcj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751301194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTsSQg95XhUJtNWRtD1zSv7COm3LSbhhvPf6ApdLYIE=;
	b=fSmdwLcj0yJfO93cIIgVYx6paZ05ALpsHnRQj8+27JnyNLQjGAnDR0wa+Wf1euxl+8bw35
	dGuem3+CTTRQyu3jKKRSYcyJnFPiVDxeN9l7ye19IT91vm6QYKEC+3T2E9XB6FzWCAStp3
	63BSwLcrmxceECpnMnn3XtKbQ3me2vM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-9Y_s0ndoNNS1U0i16B_kTQ-1; Mon, 30 Jun 2025 12:33:12 -0400
X-MC-Unique: 9Y_s0ndoNNS1U0i16B_kTQ-1
X-Mimecast-MFC-AGG-ID: 9Y_s0ndoNNS1U0i16B_kTQ_1751301192
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704d22so16660885e9.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301191; x=1751905991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTsSQg95XhUJtNWRtD1zSv7COm3LSbhhvPf6ApdLYIE=;
        b=rxcT8APAKzbvILqNJQLcnATTtwTule/dF4Ru0oKuOWks41nZtEwGT5G592JyiBM06B
         6UBtMYYCa1YLKCxNzNuEZrae5w15wk3fw6cVNYAAw4XvKQjWm+JZp3SLVziEBVLA6isW
         DZHkbeVlrJbRwPQB047uBbmZB3ha7j2stbk9df29JHRCWJgnPsi3R+UfRysqkw9Mq43J
         RlA3dTgqqnZ6UQ1++AD0mQOUCrHzMqOKFUU/NZWD7cz2AkcQxTJZ1UrVCGkkjoN2SoG4
         XB/HJJoXrVi5JoqzbG6LzEAsUSVGcb3a3GQJQIKDi9UJ03i8OqvlNnNBaEGlckf2RU6E
         S94A==
X-Forwarded-Encrypted: i=1; AJvYcCVIITGYDbCrgV38CupLYViZ2NXI1WqFOMkjAByiR5TRLDMEwDo5hOVTD/FkVpovODUPmTouNHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqWxWcXokrbDFEOALMmN6NvuiR+YqUSuRQ2m0w9C827pbOgTdW
	iRBkaoijgcnv6yy8YfGCxRXH9zzmN8g9hZel86w1s3dVkw+3OVti2ALblwdgPxveSeFovRV7fhz
	qMJHR3rrjcPPQzAaCTiDTY3olDALglBPAUziVDNu/em/gOZR3slnMb8bTdwFeCFb1tUomqFvbaH
	kxfp61OHjxznmbJQPjbRslqjB9pTv88qlBgRa7ci59z5O3
X-Gm-Gg: ASbGncsVarQvA0oXFpd/naJz3OnwC6qYTq617mM/IeR25sxoB8mSr9mTLDCI6pZfCaM
	bL+wTmYBmnI7Cl4RTXnVmRb+QKm0zs2P91mvPf2QsPGIGYH9DiEDyPUO+KLmmtecVIHbVrOB9DS
	7w7r19ojQgkUmu76XPwLiTeifzEQQ6a7b+YwZntXQX5YMLwd5p7fkoWycOz1geWV6JUalIKT4uS
	BB7WKIubgY44BJal5L3Vb0xLQZkLX5Ve0V6Mmh+cEUukGcRn5/dWOuhaBIBkje13LNAKHDO8kQJ
	2Q+SSlgjbcvu8gTIShftRSHrc5Lkmbyr6XJ0igKFpUsF0o6m1JwZPg==
X-Received: by 2002:a05:600c:5298:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-4538ee61e72mr107704405e9.20.1751301191487;
        Mon, 30 Jun 2025 09:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfyROXvO4meZTA+eBrF6ZQx2AlPL1v9K81ASsw27IwZVehxZ2JH+GDPwndnAfiwnao4RKYTA==
X-Received: by 2002:a05:600c:5298:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-4538ee61e72mr107704055e9.20.1751301191020;
        Mon, 30 Jun 2025 09:33:11 -0700 (PDT)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a406ab6sm142554375e9.30.2025.06.30.09.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:33:10 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 30 Jun 2025 18:33:03 +0200
Subject: [PATCH net-next v5 1/2] vsock/test: Add macros to identify
 transports
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-test_vsock-v5-1-2492e141e80b@redhat.com>
References: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
In-Reply-To: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Add three new macros: TRANSPORTS_G2H, TRANSPORTS_H2G and
TRANSPORTS_LOCAL.
They can be used to identify the type of the transport(s) loaded when
using the `get_transports()` function.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 tools/testing/vsock/util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 71895192cc02313bf52784e2f77aa3b0c28a0c94..fdd4649fe2d49f57c93c4aa5dfbb37b710c65918 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -33,6 +33,10 @@ static const char * const transport_ksyms[] = {
 static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
 static_assert(BITS_PER_TYPE(int) >= TRANSPORT_NUM);
 
+#define TRANSPORTS_G2H   (TRANSPORT_VIRTIO | TRANSPORT_VMCI | TRANSPORT_HYPERV)
+#define TRANSPORTS_H2G   (TRANSPORT_VHOST | TRANSPORT_VMCI)
+#define TRANSPORTS_LOCAL (TRANSPORT_LOOPBACK)
+
 /* Tests can either run as the client or the server */
 enum test_mode {
 	TEST_MODE_UNSET,

-- 
2.50.0


