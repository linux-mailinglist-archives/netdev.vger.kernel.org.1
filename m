Return-Path: <netdev+bounces-177932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CFA7326C
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4EB7A7465
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432C2147E4;
	Thu, 27 Mar 2025 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5o3Trzf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247620E6FF
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079489; cv=none; b=oRkIdrVI0ArKpDWYzyQx1lqGvgxaynf9Dqr9FF52W+BC8G3lgqzat0J/mS9pPF5mb7PYqnR4urMgmCCHkFOnLWDr25nirDOXo2zcB7PpICNditSe6okxeT6anWkkiMjLAL9La6yiMhWBKlk0WHtM3Pr8K7ZQGgSwBJx9dlhrx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079489; c=relaxed/simple;
	bh=i5JQm9DqrSRQ96Mfvrlb1RwHHX8YBXcxQ9y8zq+dgJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSV+o3u6CwVgRlfQgfwKlRjNzKEwAE3XJ95+qfEJB6YjRSTV/HLum5Ubf7W1heMx9zFRB20uy5an1WwE8IM6TBKtwj1q8RLv5ofgcetosOHYT0W/zefrWbdukCtFY1W7/8sxVAeNkfh4SNM199NAxcxRZ/z1Cs6ZRqJHJryJpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5o3Trzf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743079486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kfyheL9jEG9357hLbmic+IF7J8U9ykncYZ9iUVWBbFY=;
	b=Q5o3TrzfzgzscKq3hcqaB2MuUEMtIkT5EiT7ycJQs2Es6TJKOJ4vmg6ulW0p1Rv+j6LqMS
	BD5+NRZEig+FXZVKYJOLyqBf487bhCiDdP5wu2VDDRarMY21LJEKs0HUEjd7i1rH74NwBw
	ORF+2yZYiqFC9xqvFPx+fv4nKMTbOAg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-yH2ioMkvNSuXH8jnNgX8YA-1; Thu, 27 Mar 2025 08:44:45 -0400
X-MC-Unique: yH2ioMkvNSuXH8jnNgX8YA-1
X-Mimecast-MFC-AGG-ID: yH2ioMkvNSuXH8jnNgX8YA_1743079484
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3914608e90eso753542f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 05:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743079484; x=1743684284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfyheL9jEG9357hLbmic+IF7J8U9ykncYZ9iUVWBbFY=;
        b=wL4AsMBj3Imsu3Fz3FtEkFo9CX7+Q7LcIrqIOapmHPlf5w8Llgx7cf8tA7cMV99ili
         2BWSZ/JzHSNZK/5/Li0QtZa0XN0d18mAyy2ApV6cTqv+wmlU1eLypev4aqAdwOVTppDz
         h3tvwzFhgrt6YpmqfijX5f0r6bbIoxGcXH7pK3rEdsbUgd3dn8VFiOMCFvm+iHP+604f
         SQm+ArriMEdiqLUH55rOnNJ1d3me+ByZyLv3AOW0BL/Zs1AoU3a85Pe+AxPAuOOjWHWa
         1Btr1bf6+8fJHjvWvx4VEV5GZvLqhKAsU9D2saSMON2SsjsPvqTVhlofau2EytJhy7Hc
         WCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoupWtZhAkVNIY/vWzSSPd+JvhiMJSNT4repsC/enYw5GRE5j5eCqKSrosUob+qN3Ev+8avG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXD0BAvEFA6Ie8pxXN8a+OnmwZF1ItG2nQnpdyPZzoZLbhGAjn
	HVPZCsYiZWXAcOd8WGD2ys/df3eK+ZlJWYjMkX43946LHiBGmQ0iJIqsPQD8D2GLt9fKK6Uztz+
	iETDpquWwJnvfVEsD3h8wY92r8QRPSVfMbifGzTUE+Zvn4lUXsNOoaA==
X-Gm-Gg: ASbGncvVboXssvzjaKXQmKj2842KCh+Q+WrZ+H2sFKTBR8SbT6+2jdq4sy0s7lux4fd
	7bCiL55WZjFEvipNvV8GAVPee5iYW9wtv5mZXL2sGUlYWz/XttLUlfHKdNYw9k5x4iwIE2u+RmH
	tRhN7rOQ9MpONImSNo5hCR94JG/KBJPk2Kw5nZKBX4SSRIwM0OxPUnjqdmcj4R5tV01Gzr9TmXS
	e8M5WE5LXOyYTht8llENX4O5fJBvk7Tfg3GVKuJym655Zx0pBVKq/w+xg6HOuCeGcHiHlPrW0uq
	EeBspfiJS/7E3pI4GFAmEg91IOj/IKSmY12T0kU14EukhnSrOQQthGcGldDkmWRFbA==
X-Received: by 2002:a5d:6c6c:0:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-39ad17845f7mr3077937f8f.37.1743079483832;
        Thu, 27 Mar 2025 05:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlm4s0EdoS5CN0bcv1wS4l/Yn0TLs2QyE9bGxPtaa+Rs3z5qIUN6VRMhNwAZdWNibUqtu8qg==
X-Received: by 2002:a5d:6c6c:0:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-39ad17845f7mr3077908f8f.37.1743079483197;
        Thu, 27 Mar 2025 05:44:43 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f76sm19986612f8f.37.2025.03.27.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:44:42 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com
Cc: Mike Christie <michael.christie@oracle.com>,
	netdev@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost_task: fix vhost_task_create() documentation
Date: Thu, 27 Mar 2025 13:44:35 +0100
Message-ID: <20250327124435.142831-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Commit cb380909ae3b ("vhost: return task creation error instead of NULL")
changed the return value of vhost_task_create(), but did not update the
documentation.

Reflect the change in the documentation: on an error, vhost_task_create()
returns an ERR_PTR() and no longer NULL.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 kernel/vhost_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 2ef2e1b80091..2f844c279a3e 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
  * @arg: data to be passed to fn and handled_kill
  * @name: the thread's name
  *
- * This returns a specialized task for use by the vhost layer or NULL on
+ * This returns a specialized task for use by the vhost layer or ERR_PTR() on
  * failure. The returned task is inactive, and the caller must fire it up
  * through vhost_task_start().
  */
-- 
2.49.0


