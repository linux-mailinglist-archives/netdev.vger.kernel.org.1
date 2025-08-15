Return-Path: <netdev+bounces-214054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB29B27FB8
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F7CF4E206B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23682FD7D7;
	Fri, 15 Aug 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="hluGK8sM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7C28540F
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259692; cv=none; b=eEsIYp5tH9YBnKKfBNb4KWgtPM8BbW5mGlHXsa75NgtruKt0yYoPueEVKkuqOD4lEifcl2e+p+GL/Fc+p15GkVsrhOTtI628YZ51igTyk/hfhGLU+tPHsePsEkYgCWJUr2Jck0Zub/GaGTh8qhmfXWQVF6EwI4ObVXxXM7aMb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259692; c=relaxed/simple;
	bh=kmOx6KNrW9R2ODoH8ZfThQ3AFAnXjdWrstnCoX4e6s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHEePxLyJns1dPE7pptdt4930s0JkY2LHVYY8sARt42p3fgGeKA1inJA1YI9Uk72o7IxPADPmcjOzTp9GpLeYE3Av41QztP/Pwwy/dhras8/vGhaeVyeruAolqpE+/p6z3W5GlfE5guH4IbIUF+wb08n0LOGxMonf5AH0voKlqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=hluGK8sM; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755259686;
	bh=94wBHy/NdizbVtKXVXboJCBrkTObdo7WSc8rNvbMJhI=;
	h=From:Subject:Date:Message-ID;
	b=hluGK8sMterWn9oDaCgfLs2TG1OCmvnzx6MqMttagAhUobj1uhe5L5LtGcE5+2MFI
	 gTGjGmRQEAl9iVvi4I+nZzpJjo4CXSkwq07cqbJ5CXl5kc5s47jocCc7PBF1mNx0sq
	 80UlQZS226YbPeYvFSNX/ygCvCwQhMEMmZTPZTMs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689F231B0000553B; Fri, 15 Aug 2025 20:07:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5596864456636
X-SMAIL-UIID: 3A54955BD27249B2992BABC3730E264C-20250815-200757-1
From: Hillf Danton <hdanton@sina.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers
Date: Fri, 15 Aug 2025 20:07:46 +0800
Message-ID: <20250815120747.4634-1-hdanton@sina.com>
In-Reply-To: <20250815062222-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-10-will@kernel.org> <20250813132554.4508-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 06:22:56 -0400 "Michael S. Tsirkin" wrote:
> On Wed, Aug 13, 2025 at 09:25:53PM +0800, Hillf Danton wrote:
> > On Wed, 13 Aug 2025 04:41:09 -0400 "Michael S. Tsirkin" wrote:
> > > On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> > > > When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> > > > virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> > > > transmit data. Unfortunately, these are always linear allocations and
> > > > can therefore result in significant pressure on kmalloc() considering
> > > > that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> > > > VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> > > > allocation for each packet.
> > > > 
> > > > Rework the vsock SKB allocation so that, for sizes with page order
> > > > greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> > > > instead with the packet header in the SKB and the transmit data in the
> > > > fragments. Note that this affects both the vhost and virtio transports.
> > > > 
> > > > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > 
> > > So this caused a regression, see syzbot report:
> > > 
> > > https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com
> > > 
> > > I'm inclined to revert unless we have a fix quickly.
> > > 
> > Because recomputing skb len survived the syzbot test [1], Will looks innocent.
> > 
> > [1] https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/
> 
> I'm not sure I follow that patch though. Do you mind submitting
> with an explanation in the commit log?
> 
It is a simple debug patch to test if Will's work is good at least in the
syzbot scenario, but stil a couple miles away from a patch with the SOB tag.

