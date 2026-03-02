Return-Path: <netdev+bounces-262638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHQoO3B9pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:07:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 669491D813D
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 13:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B323302D963
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44B3644D1;
	Mon,  2 Mar 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVK1wmv3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrjthJuR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85650363C5A
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453222; cv=none; b=LGPFwDXhpN/9UMVdq2aBPgeQE+NM+Tg0RbiG2yas1JKgcMiKR8ZTQsvRuapPYEbhbp6X6kYRqGdqcWNqKU8N5JjwJrAWTYVUUeA964F7gZS6MCuSEKtv7L0sVdfTYln8nQpboBq/hjSD3NgagMgeEt7lbmVIlA/wfxdYkujVUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453222; c=relaxed/simple;
	bh=hWo99dcPxR938udacUcF8OjqE0Ne+a/dIWKnSWa/bFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRAUUor0cfXgisgvs4WQyDw8LipPc9d3ZQ+KPcHTwCGkYjd8gLPpuZYluHlvLrEGgJadl7IIcsPhC6OwCiFJnvEZfQq8ESv4EHMnaW9X7SQcGxaXTANG2eBaMPfs2LRR9aCiSgIXgzdbzhHUA6EAIRYzjWfdHCPH5DKycMgPT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VVK1wmv3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrjthJuR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772453219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wY6cGgZtSvQ1tBML++SvZaka9Xv+OGOyQzuRqjlOQ6U=;
	b=VVK1wmv3rEF5xO5gSUFsYU2+gmAE0DSEnPYibrgXepYU0STjrBd3uyByvg7g92GBmPWHc0
	rm+G+xV4UnlCw//SE4zL8hFWOpLUN0aWS5Q3ZosDTOfna0pSaHe2thZkVmg/XTz4OIVmKx
	xuanuqfqYPIwRKmEbCgKSuUa5/MFew4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-1iPy_xx1OYuX5j-lLj48uQ-1; Mon, 02 Mar 2026 07:06:58 -0500
X-MC-Unique: 1iPy_xx1OYuX5j-lLj48uQ-1
X-Mimecast-MFC-AGG-ID: 1iPy_xx1OYuX5j-lLj48uQ_1772453217
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837246211bso56993205e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 04:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772453217; x=1773058017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wY6cGgZtSvQ1tBML++SvZaka9Xv+OGOyQzuRqjlOQ6U=;
        b=GrjthJuR0Dt7nQATeVnjWK4ecJDZB6tKfMBreLcb1s3svxzNK8SRLr8ji46/rcCPLr
         1KLEbeS6T8cYMFOlRQb7j0M8FrDQTtCfIaNYFP3/WUeap5CBFsG5bHpfYz+NPSbAdZkC
         hIqHWX2HqQpEqYa9DzEnEu1Of8BIlJTJMVke3QzR+t/2S+jewS80/MkMCOd4ByjneaDV
         IR/hHK7biN023PXXwbuvDxlOifkqofB5aDJnuAab1JGmaIN61yBGk3bNTI49wH1fHCe/
         mxbqxKw8PFsB+db9XfjdivszKFkV675RB0+4CZ8Dwxu2B4ziQ03CeVVezQMXKy65V98c
         z3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772453217; x=1773058017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY6cGgZtSvQ1tBML++SvZaka9Xv+OGOyQzuRqjlOQ6U=;
        b=fY0oSNbnVg7Fs2jZ6DbS6n0uUXFwgYcsdzSHzwcZu+lSUuyWETkPTd/OrrKKZzuy+k
         oNmyz7k+t/y9aawVfrtegVjfSyp7ptQy7WinboX3LPzMBuQw9jCiH6429cJnXTXL/Pu9
         sySFKqJoJr0RzUQhOE6KGbjcWZcs12iFHI8tRN0Wr7UFon7OIPAF+JxQiNIKsNE8tnOB
         kiNXG5Ck3UJXYAiL2rY8Zq3LIOxXxqLKfva5B+2BdOr7iZdEpVbsXXiyBwZXD0ciKEe9
         eN8jbmQ9ba4OH5z0Ogi90/8r/HwNmRhbfi8aFCqvZ8hTo5PRUXxeNaN0LVA9nJXFfNlR
         FIBg==
X-Forwarded-Encrypted: i=1; AJvYcCUuMspwnsVeMMDPWXgRRX/jk07aa9l1h+9RH9t4z7gRwEAKuvAAgsBQIYhN2GpswXrd/8Kmgws=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRgMIKMsrFgc4ke8nqrp2t49onMA7amB8kGTi1vEexVQrsqIo
	+v8rfwLmTjpSZPT/0oCULibV0+V0VKcqkXyhNSzWKbodyy9cPCenUqt0l5kj254igByeSevB31t
	nlfhHH17RDL/UKtoEumpm2uMbbf4OnNUa2C40Q7WWDQlde223D5d49uFeIQ==
X-Gm-Gg: ATEYQzwARi1Ox9sVZPWHq8CR2W2a6b2VOO2tXKnOwjEz6Z6l+8aKA2oZUuLuPWrsw2R
	jw7SKMIqwBslAoQfNlgh2Ix1YvAwCQf0hlj8JDWEyTDceIRXTbXlGDn7YJflBe0LCsLGuh+F50P
	0ZsbXP0WbP8Z3NtjcYzQwmS0hPewI9k4i9KagyZ6Ocf6tMSc729fEu1UHwI/MGKIBd0iobpehvY
	hL9r0Bs5Okbmv5M6qFHcaHiOBSxjX6xqBUeGARyLK3e6QGAUUQhhsEfX/JiHcAQbbnp/pF8MbND
	eA1j7cBzAoJs2kFNGXuxpSTv5Zzpylv2Zv3ITcafMVWIvCyLAGSdXLA8TlpThlwTLcPQ+KVzRtr
	vR9E9XuzGVAvQMAKPn7kfWYazR4GPhlXiO4/uG9FRokX8f32Bl4UAmuXCx7eB3spttzvGUUE=
X-Received: by 2002:a05:600c:5249:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-483c9c29b56mr197779675e9.32.1772453217039;
        Mon, 02 Mar 2026 04:06:57 -0800 (PST)
X-Received: by 2002:a05:600c:5249:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-483c9c29b56mr197778995e9.32.1772453216431;
        Mon, 02 Mar 2026 04:06:56 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb2c5a8sm194215805e9.0.2026.03.02.04.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 04:06:55 -0800 (PST)
Date: Mon, 2 Mar 2026 13:06:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	Jason Wang <jasowang@redhat.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	nh-open-source@amazon.com
Subject: Re: [PATCH] vsock: Enable H2G override
Message-ID: <aaV80wWlpjEtYCQJ@sgarzare-redhat>
References: <20260302104138.77555-1-graf@amazon.com>
 <aaVrsXMmULivV4Se@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaVrsXMmULivV4Se@sgarzare-redhat>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262638-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 669491D813D
X-Rspamd-Action: no action

CCing Bryan, Vishnu, and Broadcom list.

On Mon, Mar 02, 2026 at 12:47:05PM +0100, Stefano Garzarella wrote:
>
>Please target net-next tree for this new feature.
>
>On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
>>Vsock maintains a single CID number space which can be used to
>>communicate to the host (G2H) or to a child-VM (H2G). The current logic
>>trivially assumes that G2H is only relevant for CID <= 2 because these
>>target the hypervisor.  However, in environments like Nitro Enclaves, an
>>instance that hosts vhost_vsock powered VMs may still want to communicate
>>to Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
>>
>>That means that for CID > 2, we really want an overlay. By default, all
>>CIDs are owned by the hypervisor. But if vhost registers a CID, it takes
>>precedence.  Implement that logic. Vhost already knows which CIDs it
>>supports anyway.
>>
>>With this logic, I can run a Nitro Enclave as well as a nested VM with
>>vhost-vsock support in parallel, with the parent instance able to
>>communicate to both simultaneously.
>
>I honestly don't understand why VMADDR_FLAG_TO_HOST (added 
>specifically for Nitro IIRC) isn't enough for this scenario and we 
>have to add this change.  Can you elaborate a bit more about the 
>relationship between this change and VMADDR_FLAG_TO_HOST we added?
>
>>
>>Signed-off-by: Alexander Graf <graf@amazon.com>
>>---
>>drivers/vhost/vsock.c    | 11 +++++++++++
>>include/net/af_vsock.h   |  3 +++
>>net/vmw_vsock/af_vsock.c |  3 +++
>>3 files changed, 17 insertions(+)
>>
>>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>>index 054f7a718f50..223da817e305 100644
>>--- a/drivers/vhost/vsock.c
>>+++ b/drivers/vhost/vsock.c
>>@@ -91,6 +91,16 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>>	return NULL;
>>}
>>
>>+static bool vhost_transport_has_cid(u32 cid)
>>+{
>>+	bool found;
>>+
>>+	rcu_read_lock();
>>+	found = vhost_vsock_get(cid) != NULL;
>
>We recently added namespaces support that changed vhost_vsock_get() 
>params. This is also in net tree now and in Linus' tree, so not sure 
>where this patch is based, but this needs to be rebased since it is 
>not building:
>
>../drivers/vhost/vsock.c: In function ‘vhost_transport_has_cid’:
>../drivers/vhost/vsock.c:99:17: error: too few arguments to function ‘vhost_vsock_get’; expected 2, have 1
>   99 |         found = vhost_vsock_get(cid) != NULL;
>      |                 ^~~~~~~~~~~~~~~
>../drivers/vhost/vsock.c:74:28: note: declared here
>   74 | static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>      |
>
>>+	rcu_read_unlock();
>>+	return found;
>>+}
>>+
>>static void
>>vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>			    struct vhost_virtqueue *vq)
>>@@ -424,6 +434,7 @@ static struct virtio_transport vhost_transport = {
>>		.module                   = THIS_MODULE,
>>
>>		.get_local_cid            = vhost_transport_get_local_cid,
>>+		.has_cid                  = vhost_transport_has_cid,
>>
>>		.init                     = virtio_transport_do_socket_init,
>>		.destruct                 = virtio_transport_destruct,
>>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>index 533d8e75f7bb..4cdcb72f9765 100644
>>--- a/include/net/af_vsock.h
>>+++ b/include/net/af_vsock.h
>>@@ -179,6 +179,9 @@ struct vsock_transport {
>>	/* Addressing. */
>>	u32 (*get_local_cid)(void);
>>
>>+	/* Check if this transport serves a specific remote CID. */
>>+	bool (*has_cid)(u32 cid);
>
>What about "has_remote_cid" ?
>
>>+
>>	/* Read a single skb */
>>	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>>
>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>index 2f7d94d682cb..8b34b264b246 100644
>>--- a/net/vmw_vsock/af_vsock.c
>>+++ b/net/vmw_vsock/af_vsock.c
>>@@ -584,6 +584,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>>			 (remote_flags & VMADDR_FLAG_TO_HOST))
>>			new_transport = transport_g2h;
>>+		else if (transport_h2g->has_cid &&
>>+			 !transport_h2g->has_cid(remote_cid))
>>+			new_transport = transport_g2h;
>
>We should update the comment on top of this fuction, and maybe also 
>try to support the other H2G transport (i.e. VMCI).
>
>@Bryan @Vishnu can the new has_cid()/has_remote_cid() be supported by 
>VMCI too?

Oops, I forgot to CC them, now they should be in copy.

Stefano


>
>
>
>I have a question: until now, transport assignment was based simply on 
>analyzing local socket information (vsk->remote_addr), but now we are 
>also adding the status of other components (e.g., VMs that have 
>started and registered the CID in vhost-vsock).
>
>Could this produce strange behavior?
>For example, two sockets with the same remote_addr communicate with 
>the host or with the guest depending on whether or not the VM existed 
>when they were created.
>
>Thanks,
>Stefano
>
>>		else
>>			new_transport = transport_h2g;
>>		break;
>>-- 
>>2.47.1
>>
>>
>>
>>
>>Amazon Web Services Development Center Germany GmbH
>>Tamara-Danz-Str. 13
>>10243 Berlin
>>Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
>>Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
>>Sitz: Berlin
>>Ust-ID: DE 365 538 597
>>
>>


