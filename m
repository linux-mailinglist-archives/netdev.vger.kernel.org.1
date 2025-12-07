Return-Path: <netdev+bounces-243942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1946ACAB4B3
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 13:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D557309205A
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A572C031B;
	Sun,  7 Dec 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuWmninz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB92ED84C
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111193; cv=none; b=h6IjIP83E54XIXGTT/Er86TIn/7JCZZ+vknYlEEumb3Oeh7EIKoMSjcsvJ50tal36z3tHx8Exkia4+jZO0ySFSNUiSizuzYI/CEYR/3/0KdG7i4GYhljDYTYoewQWw+q90gBKUTI4kzWZ48d7Vc8qloegp+UncVQmdRWek+pCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111193; c=relaxed/simple;
	bh=X8LerOgNIhp61xDqaOmC/06/ifz39whdlSV6H/A+jyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KyI6sjYL3guE+uayznmR40ApGx6tsKvFQ5xUnGeEkO5rhkhmIhuArJOBXcPwipkKzBzRI5iH8XQX5FDypRrMD5kf1wlDrm3hVa+LBlQil1VkQqOQ8hqHUmCEN/H8ALW7LE/iF/S5giPmSo8SfGFYNkBL/OqbCLuzxxV+UyQJ8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cuWmninz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765111189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=GspPLneNRfjxjLHV+P4c99mYW0S2jOEzAxTTs5yzofc=;
	b=cuWmninzmLG5YrYmI5LT6gnI84te8kZ+UbW5j5ErKP7KtlwV4ItPDnWYee1v++IQApg7hv
	YgChdai7byHjIRc5sEkqjLZrqzG3zmmtZKPacwLmkVMq3jFMPRVKHPjGk0+i/7Ef11gPFW
	kexWvgX/ihKDnWGxtNtxS65PtN+eQ/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-4yRwVArNN0eXDh1QrB5yKA-1; Sun,
 07 Dec 2025 07:39:42 -0500
X-MC-Unique: 4yRwVArNN0eXDh1QrB5yKA-1
X-Mimecast-MFC-AGG-ID: 4yRwVArNN0eXDh1QrB5yKA_1765111179
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74B3E18001C6;
	Sun,  7 Dec 2025 12:39:38 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 48A00180044F;
	Sun,  7 Dec 2025 12:39:27 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Dec 2025 13:39:40 +0100 (CET)
Date: Sun, 7 Dec 2025 13:39:28 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
	=?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/7] drm/amdgpu: don't abuse current->group_leader
Message-ID: <aTV1gPQ84Q9fZ2cy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTV1KYdcDGvjXHos@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Cleanup and preparation to simplify the next changes.

- Use current->tgid instead of current->group_leader->pid

- Use get_task_pid(current, PIDTYPE_TGID) instead of
  get_task_pid(current->group_leader, PIDTYPE_PID)

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b1c24c8fa686..df22b54ba346 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1421,7 +1421,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 			goto create_evict_fence_fail;
 		}
 
-		info->pid = get_task_pid(current->group_leader, PIDTYPE_PID);
+		info->pid = get_task_pid(current, PIDTYPE_TGID);
 		INIT_DELAYED_WORK(&info->restore_userptr_work,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a67285118c37..a0f8ba382b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2554,7 +2554,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 	if (current->group_leader->mm != current->mm)
 		return;
 
-	vm->task_info->tgid = current->group_leader->pid;
+	vm->task_info->tgid = current->tgid;
 	get_task_comm(vm->task_info->process_name, current->group_leader);
 }
 
-- 
2.52.0


