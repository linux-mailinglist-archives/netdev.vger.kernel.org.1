Return-Path: <netdev+bounces-200206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BA6AE3B9C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAE518891F8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A802472B4;
	Mon, 23 Jun 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToWNNcTB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63023C8AA
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672870; cv=none; b=oE8ldo7Z44ev6DLOP9lW8zE5z5N5s2fyrRV3qWSF1HTdlS4tke38IgBE4pzxlkcqrtbCc9+zfkfBhmRa/nRiKndIgOBsMKAjg8WvvZBy5CN3QxtXq0AzYyVdL/RSTG28jTX8Wy6s+cyUeOKBClHMYMjeaGFCQOzrImznLdSGcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672870; c=relaxed/simple;
	bh=Q5iqcjL9Nx3GILkRpH3081upzUIxlt4JKXojGl4BQ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EMjVW0q609TovzPqDutBWhLJr3RtdcQt8ObDN88CpcVEqbHFhy8pZZtY0WzpGcoQ88m0Koai5F7OwRsFoNQm4CTtITQ/7MCENdQ4rUomFeEjS88Oq4rNwd+WyIT2Hnsv8efEw1BeYhjHaRcsbQpj5pwoAo18GtUqTissXfXpYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToWNNcTB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750672868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cg11dcRkqMpCTj1960kW5hmHn/C5yTPB14wnt8MXdok=;
	b=ToWNNcTBygFMTLsUJn/K/8LP3QSOmLOT7IXtDsRPJTmcKV1w3QbKPkFhafnqAEBjnPa8+O
	EmutstVvtWj6hzOddSnyORropFClrVbrlbNzqrzAwEzImsxTCaWmkGEURyCnO+nRm/bqyq
	HNE8K4d8l1xuFI1xopBtt+c5q77ewfk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-ZQS6pb65Pv2YA64yDzQybg-1; Mon, 23 Jun 2025 06:01:05 -0400
X-MC-Unique: ZQS6pb65Pv2YA64yDzQybg-1
X-Mimecast-MFC-AGG-ID: ZQS6pb65Pv2YA64yDzQybg_1750672865
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a6fb9bbbc9so148369511cf.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 03:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750672865; x=1751277665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg11dcRkqMpCTj1960kW5hmHn/C5yTPB14wnt8MXdok=;
        b=RANOzcfm98+LdikbkndOvewXCzpQV2hLAF4Xo5LS6IQfLSwpohGlxCLzZfwcxumBm1
         bl5oa++hKKeeshcIMBMynOI9WV2tYMqMLPdSE7n3r/vpBc11m+z2hh8swx4RJcFwODGb
         GSOWzyT2cMZrNiFkomw2Z2cXRHnJkBfhZnnjtfwAF/mNRG1ogpz0+9qf29puwNdWRzTu
         tTBdeH+XWOQiw8CNPOuyx6ZPjaIYQbWcsdS1sLn2n/edIYDrKFfUEt7Ao/RfLFUysBRE
         WZz6pQeBxfo1r23kAtLXMG+tqnmpRM1Lju63bGZpLF04CaUHkU8gyo+p200L5vnefYZV
         uTmw==
X-Gm-Message-State: AOJu0YwVGfJse5ulwyq7Azmp0osL92g7j3/5RCXzw4pYuKRKJlygcSuK
	MCJosaf3n/VkWnPWPBnChxJ8dbszvWfqa22d/PohrW7ggln65qP3XlbOLkoohgSUkPYHDD4U6yS
	CZdhRtZo8wJKoeAFmChRgftOkoNB1oUPuY6DQDKY1hjfh8yK2THUMhBVTRjJNN0aad4n3627kOa
	hgZkIp1mWi3N+pICYlySl8PjbhQ28JCSpWThyAxA54pQ==
X-Gm-Gg: ASbGncucv/N+gtF5Cyn+GpxYFHb+KF575T1y7VTqU8CWZJ/AU1QfsA6RVI7ckR9Pthr
	8Z5SVgMEeRWQXMQFFBdBvpER9h1BuX/GXBbSKwI8loDg6hYggPr18QC0QaG4xLtbOQKsJTQjABp
	9hDOfrDJmGqnfqzlfa6ZPVcte8sbO4dPZFCdq3mExCDX04uKIHdg1HtZfL9MzmrijemxB6PMqJD
	fc6ZVKb77tscDw/iPTUaDnuB4EbOG6xkusrul1I5UiRzaUEVWdwBnpkxlOkNkwMU7Oi7jsiyoT9
	/b9LxgHZDvkhfXUMoGGp+jr8bk7u
X-Received: by 2002:ac8:5903:0:b0:4a7:693a:6ae8 with SMTP id d75a77b69052e-4a77a25763fmr190862331cf.52.1750672864646;
        Mon, 23 Jun 2025 03:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXzLpFhw4QDvJz+bsfP+zBCHk665drBIUKJoN12gXU74K8bXpg+kpWK89icqArO8RccMpeNw==
X-Received: by 2002:ac8:5903:0:b0:4a7:693a:6ae8 with SMTP id d75a77b69052e-4a77a25763fmr190861721cf.52.1750672864007;
        Mon, 23 Jun 2025 03:01:04 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.202.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d4e5d5sm36886681cf.7.2025.06.23.03.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 03:01:02 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Andy King <acking@vmware.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Dmitry Torokhov <dtor@vmware.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH net] vsock/uapi: fix linux/vm_sockets.h userspace compilation errors
Date: Mon, 23 Jun 2025 12:00:53 +0200
Message-ID: <20250623100053.40979-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

If a userspace application just include <linux/vm_sockets.h> will fail
to build with the following errors:

    /usr/include/linux/vm_sockets.h:182:39: error: invalid application of ‘sizeof’ to incomplete type ‘struct sockaddr’
      182 |         unsigned char svm_zero[sizeof(struct sockaddr) -
          |                                       ^~~~~~
    /usr/include/linux/vm_sockets.h:183:39: error: ‘sa_family_t’ undeclared here (not in a function)
      183 |                                sizeof(sa_family_t) -
          |

Include <sys/socket.h> for userspace (guarded by ifndef __KERNEL__)
where `struct sockaddr` and `sa_family_t` are defined.
We already do something similar in <linux/mptcp.h> and <linux/if.h>.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/vm_sockets.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index ed07181d4eff..e05280e41522 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -17,6 +17,10 @@
 #ifndef _UAPI_VM_SOCKETS_H
 #define _UAPI_VM_SOCKETS_H
 
+#ifndef __KERNEL__
+#include <sys/socket.h>        /* for struct sockaddr and sa_family_t */
+#endif
+
 #include <linux/socket.h>
 #include <linux/types.h>
 
-- 
2.49.0


