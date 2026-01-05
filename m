Return-Path: <netdev+bounces-246923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC21CF26BD
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B504C3068BE4
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF1314B9D;
	Mon,  5 Jan 2026 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGXcGOjm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWZ1fXc2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC617328B6B
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601415; cv=none; b=q6I3ItDIwox0Cn7zJuNEZBGI+kk0qF1iA+hNdShIKszbgB4FgVWiQdEzCj8y53Jk6SURop2aM/6DdWHIAnwgBmpWGjND780hHC1o3M6bqGCYO5GHoWdI4MXc7d3bVv4CHrCU3YF2Yg8JTNjXWamDdJBHrq4ufcYkc9ybzDh/2i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601415; c=relaxed/simple;
	bh=yZFREYe+kB50ig8I4QfoDGYH7fn5mVvqsTw8oxG1/Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0nmFxhPa+2zW7gjlkRudX7T+ezh0Rgk2bbLSOZKj6N4PxxTP51/TbSiQY/UTCGd7XNXJUQwwP+SvXou96NEL/mjVhXkYjCZBw4aK/6kKWPublkjqoHA8VbXMEFvOozw86yJ2ehhTiGwGkd+rL/a769IbYPExpe2+Uu7K06xXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGXcGOjm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWZ1fXc2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFAlf3bglsAJtkYzmv+ft5xqaztKYGlID1/+YOBMr0o=;
	b=ZGXcGOjmLeGWkx/FvHO8OG4Ix2VK+O/U+h6lTSg+bUIDJIqrYivt3bKmKOd78wkGT14jKq
	cJ+MU6jtIuvVOCQJ60me7U3zrveQ8w38odAw7T8//11WcJLnkd+M8QMUN1u2LMug7PmCAL
	2SHcXDsZ+3ve3JPQJLxFe+CgDnoUww4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-aa7Il805PqC3JKsa37Mxnw-1; Mon, 05 Jan 2026 03:23:30 -0500
X-MC-Unique: aa7Il805PqC3JKsa37Mxnw-1
X-Mimecast-MFC-AGG-ID: aa7Il805PqC3JKsa37Mxnw_1767601410
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47918084ac1so120298775e9.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 00:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767601409; x=1768206209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFAlf3bglsAJtkYzmv+ft5xqaztKYGlID1/+YOBMr0o=;
        b=RWZ1fXc20ZkPKj+99fWUwuXo/equGaNjQgbzREfCka0FOX2uIqLLuxl+O9HxLpwj2C
         iZG/W34/ARlm0hd3v9K7r6YnDdrsAN8qcmZQF+V951BjWru74fplmVNXqLEAqwpri6/5
         eIEsQP+XV9aMeQokdFniLjl4ugZGFQzJNHtIeVLtOroKt8HACZ3giLnI6AA3V26BdTwc
         0wEuTJ2ZwZvEblT1B0TAQUiq3V+oe+8PlUYmu92jVdhmn2z7nmZZPQ5C0IDA8vXGYP0y
         RPoKUQFVv/MZFhxuivyuaTJWNJ/Y1C2ie6leuq+9E9ZLMOlzC0G+RyGG2WDSJW41Zryt
         ki8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601409; x=1768206209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFAlf3bglsAJtkYzmv+ft5xqaztKYGlID1/+YOBMr0o=;
        b=XQ2LDukv5Jg8C7RrWeo2l7hSgNcxmx8VocpibzJIy+oBw9DW/s3AGAzDDS3k4QdiA2
         Wb9BaT4jVBFTwStEE+2kqzmrz5VgHPR9lnQgDiUBLOBBorSFNt5f47+yT0pAhIumRxqw
         8mhiucrCB+etuq0p6RcI/KDu5kbPx9K3z20enIhA10g9TW9ha+sLZr5G/rWH/lUNGG/F
         YZBWbMyFH6BRMXjeIIz4GaD56MZeVbawYVfato7E4WiO1VqPS3rhsPUD2Qt9YIeL+eY7
         mG8FOKXtoIj1zyQOh07AIYP9gjDwz9ZMq/5i3GjfEfC1QO7QdaEZRxiK7vRBSxxfMgZg
         Rz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRvL3VI/ru7pt3sUI57Uee9nryBI4asd+k2O8HJJ9MpcbjfCZAVs7ckrLY2P2nZyllg6Kjllw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKyBJJrwrkEr/eKWfL3/9wU6oPgka9nte9vs9BX/ohM/fRDxn
	UVUD2g2xP7t/WjCSZARACwEHgcpMtrudCI8nDkk2VjZqAub6IzAbPgOTLisPMCI9eItTxGX6vdd
	gFmbt1TNqRmQ7OT9r4Cd6gyIWn97nIr6TCMjFppSGWZ+I5S/UeaVhMSokgw==
X-Gm-Gg: AY/fxX6z7CXkl9wXfJC6WOXrp+vENAI3NM47HJWaRp9vNaLyvjqMauYuC9lLt0PwkbI
	AJ20f3u8LjM1+M0bCA2W9VxD/TG5LinBas+4BnrZoYDs0UhhVmzholot49Py0nVyYq8lz0UEgmX
	sI7TUd6V1rsytFbPMhefKqyNEqoyimOE7iTnMWLE+LRJzhbmyfanDBcQmLE5G1Dmicbg/mej0Fu
	AjTzWhz2nLZO/OUFWfEOao34Gr46b+JgTVyxV3yy1A+/lSq9HxxeIjpN9itc5pkJ1ncn8kNXoee
	vHbwfebMoWeL+Wi6jfn5AGE7Y+BO5so0Ar1xrdyOsAW/NqDgAZqdZ2uB9sJNQyxw6qDDcaW8qVT
	K3p52ZzCo5153qYeAmY+/B+lG+8bL9s7cTw==
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47d1958a43fmr573308355e9.19.1767601409526;
        Mon, 05 Jan 2026 00:23:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwNUq77RyeyS0obHX/fGtVMqKrfm8Lk7lx8bL3zrRbRdvbJ0vPOnUhK5sFwtMU1HFVUtXhCA==
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47d1958a43fmr573308005e9.19.1767601409047;
        Mon, 05 Jan 2026 00:23:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d145162sm142697615e9.4.2026.01.05.00.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:28 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 09/15] virtio_input: fix DMA alignment for evts
Message-ID: <cd328233198a76618809bb5cd9a6ddcaa603a8a1.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

On non-cache-coherent platforms, when a structure contains a buffer
used for DMA alongside fields that the CPU writes to, cacheline sharing
can cause data corruption.

The evts array is used for DMA_FROM_DEVICE operations via
virtqueue_add_inbuf(). The adjacent lock and ready fields are written
by the CPU during normal operation. If these share cachelines with evts,
CPU writes can corrupt DMA data.

Add __dma_from_device_group_begin()/end() annotations to ensure evts is
isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index d0728285b6ce..9f13de1f1d77 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -4,6 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
@@ -16,7 +17,9 @@ struct virtio_input {
 	char                       serial[64];
 	char                       phys[64];
 	struct virtqueue           *evt, *sts;
+	__dma_from_device_group_begin();
 	struct virtio_input_event  evts[64];
+	__dma_from_device_group_end();
 	spinlock_t                 lock;
 	bool                       ready;
 };
-- 
MST


