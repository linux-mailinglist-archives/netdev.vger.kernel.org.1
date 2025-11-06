Return-Path: <netdev+bounces-236453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20669C3C71F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7176D62218B
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C334BA2E;
	Thu,  6 Nov 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfgjPrHU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="isyxLzDQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B45318143
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446111; cv=none; b=Cc3jurmth9vhxuOguMNfS5VUuQwbCR8fRfOVRxpm2AVPvOKHgM3ZMIliW8Wpzj6/L4RkwvWAZ+9Ex/7jgbyxhkXJLqQwYtwSFc/CGylPgyDOxCH7ZuS+AVz5/xheCjRJXC9rJ9Y7hbT7Fg89FWP7Vmof/aoFfTAhn50l980wDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446111; c=relaxed/simple;
	bh=byB0FjmheU8L8LWGRryKTbWj4FBva6lfo5UvPvvL+8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iALnhqkfEgkguaSQdSr6djzTZn6svcKAHbk41Se/PBgvnh5qsBbsUjA1GjbmIDLaT+PjOP6Qgpdr34czQ+saRS8BLW2MLAMZCdrq0R+m8IdPniGSYf4qvkKzzdPwgwBGpfqcMmR4cyxdGsB8Mh8v1enE4q1mLI/HDdf2I09ZHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfgjPrHU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=isyxLzDQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762446108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UiHS7Y1QmsB4ooCc/QO12f/u71QqLJQ+iWQOElP8jPM=;
	b=gfgjPrHUNTAfjJwX/1Dnd/sluFEqXQdGM+AH2A5ZR4wlRSG3Uzqjl7+iR5H/DgqB+j3BiN
	u71vKDHsSXL7kDcsyb8pMlyRLYK89jmjCWwi3UoWFYfA9gqbWL44GM9biRVVLHaQ35i4HT
	ZHZHbRaQMbgd4yHk1wt96d0ZOkVJTuQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-nluWpZfKNd-Cvvqkh-yOhA-1; Thu, 06 Nov 2025 11:21:46 -0500
X-MC-Unique: nluWpZfKNd-Cvvqkh-yOhA-1
X-Mimecast-MFC-AGG-ID: nluWpZfKNd-Cvvqkh-yOhA_1762446105
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429c17b29f3so971252f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762446105; x=1763050905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UiHS7Y1QmsB4ooCc/QO12f/u71QqLJQ+iWQOElP8jPM=;
        b=isyxLzDQtGQZWhVikaCeGrJh5O+onYutKC4n/8eBR0C+FoeTosaCDTZy0BMl7Ih8p3
         A3OpWwUKIV8kWJdtI7V0Evi2MHtKsFBsFsqfbufiCC7uIvxNHGPlIcKQN4xgIzzuoc15
         42dMBfTkEb2cdzC5W8klRLtfFzA4Lq7M33oTMcTz+pIqvNEJUZ+MXoecM8EvsV+M4Yd7
         wz+CiBG8TZkX+GZJTY37tUh3/gW22PRQPd9AJh9ElSzQidizcNn21Q4sr0Tjya7OYGB1
         faqidUClLAUQENHt6yRMB6QQ7QfDqGA73tGHwgqia41fqwhlCPNN9iCqMRrhWHSU8gZA
         Y75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446105; x=1763050905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiHS7Y1QmsB4ooCc/QO12f/u71QqLJQ+iWQOElP8jPM=;
        b=i5xYEeYfoaXqqlti1XJDzzgX6xmk/neh3ZskaUYxJzVOV7oRxQZaq1Ap38dcTyvizS
         6KUW+bxZb2vNg2/gL3NoeX+7BL1mFeS8k0i3NCyIKSz7gcWfBooIjTdodMWo2Yxiy8E+
         DKLAvUfQF1RhfxjeMhLEO8lIDGTuuQFv3FQ6sDsZEE7Plupw1BcbbD3HDagtdM0/u+7E
         33wnjOOjipQp9Z8xPke6LTlYzUKEbtcjYFEZZuWFjOTHcSTAXXNyOCNiHamD4junNNDQ
         Ni/BarV8DFeQFoKBxVSC4KF+s8UzFgrry2j2IYFVw5FF7YcaTiB8wzsKqDdpjivQSBPI
         mGow==
X-Forwarded-Encrypted: i=1; AJvYcCXX+x4ssI62wWT9s50uw/pzEpotHyG1EbqeHUhKrfrJNxBiDGNAcINLlAVE0jb41GivgySa/bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmEUUrpfo2w6/7ln+xRblfnn+huCycTA26VloTlfP2uIVIfe6
	dhP7JNjeC7NAsYejftlEK92/7x1XCOFFgdrFIPungG3Dg4oh1O7kllaNSL+E2INXpt+LBde0ziL
	pbl8kro0I/AjpMzEEim9CLppCEDDekBJA9UFsKU+byCVCAdiyb3ndHOLZjg==
X-Gm-Gg: ASbGnct1ei4Zla0g7iOp0/ojqm/lAjdjo3amtJ/R2COIbj5Hugk+MBy6p7fPQ4aqp/C
	RBONaENDaGgqtkLnEOHRbYyoq0F38ZF6MR+D3vhT4NWeWZXTbpWN2EOUp7HD5jif5wyw3nWgSg6
	CsUlQW6HR68KXvOSU84tlSMq5yqhqyNOTUMKuwJFGLFOBQ86YLbsP21v8XQcYUSrWRjMXQNbvMv
	7vRCCQeVgG+Edwcx21kEoLBXQRV5jcNw7v1pix9SGvtcXxPVv4Mx61rnntN/g5cLdXh9hVT8BOh
	tnW1vG4qxiF8cvsTgwul39pMoKVIubA/HEX0G0eWvKGV+DYAMqKjHtg8UBtGkyCVZaRLAJK4PAK
	ygg==
X-Received: by 2002:a5d:5d09:0:b0:429:d66b:50ae with SMTP id ffacd0b85a97d-429e33130d0mr6897562f8f.57.1762446104490;
        Thu, 06 Nov 2025 08:21:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHxdtHsEl0Bz10J9Od6FlZK0pdWzs5w5DcfrRmgPbyiiJc9s2vF+YRjR0Pvqt6+yGoII9VcQ==
X-Received: by 2002:a5d:5d09:0:b0:429:d66b:50ae with SMTP id ffacd0b85a97d-429e33130d0mr6897515f8f.57.1762446103886;
        Thu, 06 Nov 2025 08:21:43 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4106e0sm6253117f8f.11.2025.11.06.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:21:43 -0800 (PST)
Date: Thu, 6 Nov 2025 17:21:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 07/14] vhost/vsock: add netns support
Message-ID: <juxkmz3vskdopukejobv745j6qqx45hhcdjtjw7gcpgz6fj5ws@ckz7dvyup6mq>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-7-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-7-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:46AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the ability to isolate vhost-vsock flows using namespaces.
>
>The VM, via the vhost_vsock struct, inherits its namespace from the
>process that opens the vhost-vsock device. vhost_vsock lookup functions
>are modified to take into account the mode (e.g., if CIDs are matching
>but modes don't align, then return NULL).
>
>vhost_vsock now acquires a reference to the namespace.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v7:
>- remove the check_global flag of vhost_vsock_get(), that logic was both
>  wrong and not necessary, reuse vsock_net_check_mode() instead
>- remove 'delete me' comment
>Changes in v5:
>- respect pid namespaces when assigning namespace to vhost_vsock
>---
> drivers/vhost/vsock.c | 44 ++++++++++++++++++++++++++++++++++----------
> 1 file changed, 34 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 34adf0cf9124..df6136633cd8 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -46,6 +46,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
> struct vhost_vsock {
> 	struct vhost_dev dev;
> 	struct vhost_virtqueue vqs[2];
>+	struct net *net;
>+	netns_tracker ns_tracker;
>+
>+	/* The ns mode at the time vhost_vsock was created */
>+	enum vsock_net_mode net_mode;
>
> 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
> 	struct hlist_node hash;
>@@ -67,7 +72,8 @@ static u32 vhost_transport_get_local_cid(void)
> /* Callers that dereference the return value must hold vhost_vsock_mutex or the
>  * RCU read lock.
>  */
>-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net,
>+					   enum vsock_net_mode mode)
> {
> 	struct vhost_vsock *vsock;
>
>@@ -78,9 +84,9 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
> 		if (other_cid == 0)
> 			continue;
>
>-		if (other_cid == guest_cid)
>+		if (other_cid == guest_cid &&
>+		    vsock_net_check_mode(net, mode, vsock->net, vsock->net_mode))
> 			return vsock;
>-
> 	}
>
> 	return NULL;
>@@ -271,14 +277,16 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
> static int
> vhost_transport_send_pkt(struct sk_buff *skb)
> {
>+	enum vsock_net_mode mode = virtio_vsock_skb_net_mode(skb);
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct net *net = virtio_vsock_skb_net(skb);
> 	struct vhost_vsock *vsock;
> 	int len = skb->len;
>
> 	rcu_read_lock();
>
> 	/* Find the vhost_vsock according to guest context id  */
>-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
>+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net, mode);
> 	if (!vsock) {
> 		rcu_read_unlock();
> 		kfree_skb(skb);
>@@ -305,7 +313,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> 	rcu_read_lock();
>
> 	/* Find the vhost_vsock according to guest context id  */
>-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
>+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid,
>+				sock_net(sk_vsock(vsk)), vsk->net_mode);
> 	if (!vsock)
> 		goto out;
>
>@@ -327,7 +336,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> }
>
> static struct sk_buff *
>-vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>+vhost_vsock_alloc_skb(struct vhost_vsock *vsock, struct vhost_virtqueue *vq,
> 		      unsigned int out, unsigned int in)
> {
> 	struct virtio_vsock_hdr *hdr;
>@@ -353,6 +362,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 	if (!skb)
> 		return NULL;
>
>+	virtio_vsock_skb_set_net(skb, vsock->net);
>+	virtio_vsock_skb_set_net_mode(skb, vsock->net_mode);
>+
> 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
>
> 	hdr = virtio_vsock_hdr(skb);
>@@ -462,11 +474,12 @@ static struct virtio_transport vhost_transport = {
>
> static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
> {
>+	struct net *net = sock_net(sk_vsock(vsk));
> 	struct vhost_vsock *vsock;
> 	bool seqpacket_allow = false;
>
> 	rcu_read_lock();
>-	vsock = vhost_vsock_get(remote_cid);
>+	vsock = vhost_vsock_get(remote_cid, net, vsk->net_mode);
>
> 	if (vsock)
> 		seqpacket_allow = vsock->seqpacket_allow;
>@@ -520,7 +533,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> 			break;
> 		}
>
>-		skb = vhost_vsock_alloc_skb(vq, out, in);
>+		skb = vhost_vsock_alloc_skb(vsock, vq, out, in);
> 		if (!skb) {
> 			vq_err(vq, "Faulted on pkt\n");
> 			continue;
>@@ -652,8 +665,10 @@ static void vhost_vsock_free(struct vhost_vsock *vsock)
>
> static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> {
>+
> 	struct vhost_virtqueue **vqs;
> 	struct vhost_vsock *vsock;
>+	struct net *net;
> 	int ret;
>
> 	/* This struct is large and allocation could fail, fall back to vmalloc
>@@ -669,6 +684,14 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> 		goto out;
> 	}
>
>+	net = current->nsproxy->net_ns;
>+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
>+
>+	/* Cache the mode of the namespace so that if that netns mode changes,
>+	 * the vhost_vsock will continue to function as expected.
>+	 */

I think we should document this in the commit description and in both we 
should add also the reason. (IIRC, it was to simplify everything and 
prevent a VM from changing modes when running and then tracking all its 
packets)

>+	vsock->net_mode = vsock_net_mode(net);
>+
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>
>@@ -708,7 +731,7 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> 	 */
>
> 	/* If the peer is still valid, no need to reset connection */
>-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
>+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk), vsk->net_mode))
> 		return;
>
> 	/* If the close timeout is pending, let it expire.  This avoids races
>@@ -753,6 +776,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>
> 	vhost_dev_cleanup(&vsock->dev);
>+	put_net_track(vsock->net, &vsock->ns_tracker);

Doing this after virtio_vsock_skb_queue_purge() should ensure that all 
skbs have been drained, so there should be no one flying with this 
netns. Perhaps this clarifies my doubts about the skb net, but should we 
do something similar for loopback as well?

And maybe we should document that also in the virtio_vsock_skb_cb.

The rest LGTM.

Thanks,
Stefano

> 	kfree(vsock->dev.vqs);
> 	vhost_vsock_free(vsock);
> 	return 0;
>@@ -779,7 +803,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>
> 	/* Refuse if CID is already in use */
> 	mutex_lock(&vhost_vsock_mutex);
>-	other = vhost_vsock_get(guest_cid);
>+	other = vhost_vsock_get(guest_cid, vsock->net, vsock->net_mode);
> 	if (other && other != vsock) {
> 		mutex_unlock(&vhost_vsock_mutex);
> 		return -EADDRINUSE;
>
>-- 
>2.47.3
>


