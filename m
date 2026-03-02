Return-Path: <netdev+bounces-262625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDvDIjB5pWlbCAYAu9opvQ
	(envelope-from <netdev+bounces-262625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:49:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0832A1D7D97
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55B02303AF1F
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4285D3630B6;
	Mon,  2 Mar 2026 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNIQp32L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bv0Nj+HK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8FF363099
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452038; cv=none; b=rDFnAILtNX3EJWIRySOMBrSZ+P0/6r3OMieVCPaJGFjLWx+qlKsPpOKju6qjx8AR3bPRZvGXCYOU879QTVOI0dQ//vOUbfSSVvcl0b1+VgXgEUliD6YhcFhkRBH7KdIpuv8hAv+NjU44gKchcpzORIafyB+J2acV07hdTxcej4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452038; c=relaxed/simple;
	bh=jIEye+0df33ikFViPPR9akfXSu+t/01QHhvxzHLng1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIvQQynyQ20nA1H3B48qdp4zfrMQS8/2/EAlTIcG9FmZK2k1TtGLvCfra0nyMhwr+AkkQMRnY1FgUttM4Aw0G4gA6knY92fAgvCscK/uS6nS1FHUjFjJK/qBznned/P8irYaAfpdkaF22UZsC73c6T5x0O77ZdyGDmcKmzkv7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNIQp32L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bv0Nj+HK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772452035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eummRfVqZi/xRPz07HlbI09UFKU1skHozaqbPUYQxGg=;
	b=DNIQp32LXxIEmr+clYpk5bDnnbh+b7n/nYiWZSH7/KmlbTBBr3c0SLfAsTwIuXlUzY3Vga
	Y4rPnaFQdry7mSmxLK0TIzDvl5ISTvTRVfuYMScWxY2+HQCxJ3quGk7BRXUcNCXqcUrRVR
	zact223AptUqET/DutM19AYXRLSf930=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-9Ip5wb0mMyWBFj-JQoOQ6A-1; Mon, 02 Mar 2026 06:47:14 -0500
X-MC-Unique: 9Ip5wb0mMyWBFj-JQoOQ6A-1
X-Mimecast-MFC-AGG-ID: 9Ip5wb0mMyWBFj-JQoOQ6A_1772452033
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48079ae1001so34996165e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 03:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772452033; x=1773056833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eummRfVqZi/xRPz07HlbI09UFKU1skHozaqbPUYQxGg=;
        b=Bv0Nj+HKLu2/J/+yHmia9OHP0Z2J5ktHRWdb+CAsz8ucQQjmL4smCvRyLlTkpsiGiF
         54pXrCYP1HyBBFJ7KWhIr2Y+FT+Ik1QF5g194PQuBOgwykvRyaSSPWdanRNQ4H6ajOJ+
         ILEme+eyBFSBq2rqI1oKkyDSEK3MhC2y9Ggtc68V+XIMW4wC014toVAskbSbe1sh3auq
         Qk0UMLKJ3U6UNPbJc9SOFwFXsprwLRe6lZqt+NLbNViAe9oC0Kc/1EUjhfaP93ElcHVs
         OdBTu9WpTcGjGM01kCM+tQ5He8QpjPL7JEl4YP0WCq7+cea/4qERqSFJx1L6vdmSzYNH
         +5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452033; x=1773056833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eummRfVqZi/xRPz07HlbI09UFKU1skHozaqbPUYQxGg=;
        b=N1JeqAQ5vKHMelS2v2s3emHvwScqIIk/cmmNDk6L0JqT5VurJNfK/rFcgvvDSKTNpg
         sKmDoUQMQdQhhvz6Tcw8RcvUr2Y7GeUNEpgJOrGmd9n0s98VVfrgCx2VFTHuViVYejrz
         rhUv5gjvAvY/YaE3evkY4qrNSe7hB24pxPh1tt2YjM7+YP7ISy+MZg+NteYsmL43SU+e
         12JWp+0ry98Xz7c9ODb7MztBOPzFp2ENN1pso3iUYTR5wpGkIsKYPOTZcnHBvt3QH1Vh
         nbictHiQX2UKsTIO4J8nFyQTFA2y9YyXLWs9RAKjoGi3xY+OHB6m2HkmdGiLq3VASenJ
         E1ug==
X-Forwarded-Encrypted: i=1; AJvYcCWbj7MTWIAzKTcYMomGsat0WioRwRnkTOnaU8b9YljdOmnjINPCBCXY5/r/bJwYIGiELf7GiBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wyY8B7IG5JIV3f8cmdeQ6au06H/kxcWnul5T07aFl9/vg04l
	zfc4SkuY2eTSPYZbnYkyR92rl1vaRl3zummC+IDKvcAK1ngvze8gXJgXAOM/8L/DwStjxkxEI2O
	EIn2HcuuamP+X74rMP7ojz/0SbSgmDa4c7vHqORONYGKGggeOp6uub8E7Eg==
X-Gm-Gg: ATEYQzxf8Ss3C+68DWIIfAw/umTcF7iFDXSEOYt5t/nWXn3AV0B1ieAZ2piHs8wVJoN
	EI3dCJ2i8+B5/BJ/p7a8XTJL6NqqritcOfzT9vOL9Xos1QpwU4WSTQ5P/OubcMr6UaV5vLJQcgz
	sz7h6xgwa7mJA4ZYCMHQ9XRw82NG+RwYpOTxgaL2AceG/tdP45dYSviPetugG6w5m+aho+8pqDY
	FQnRUrWn7OT4wa1EZjYdSebYDDPIkxL6Bx8yej5p7xfPgjLXUFZ0ZaFWuHJWlAd/Y8wIz5spKQr
	AOiRDfj9GUjHN1JZmhPvxddR+GMtmWYpf20Wjp53JurindhcRHdfNA8eU0uXSida5IX8egrhzV1
	YQneR0qnWMqVzdec2vGmbMoiRGOEbKRRjRBat51zGgahHDFjsX50/2xjh9064EiFaKTPUY2s=
X-Received: by 2002:a05:600c:444d:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-483c9c243fbmr221396605e9.35.1772452033091;
        Mon, 02 Mar 2026 03:47:13 -0800 (PST)
X-Received: by 2002:a05:600c:444d:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-483c9c243fbmr221395955e9.35.1772452032571;
        Mon, 02 Mar 2026 03:47:12 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf8b6sm147619295e9.20.2026.03.02.03.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:47:11 -0800 (PST)
Date: Mon, 2 Mar 2026 12:47:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	Jason Wang <jasowang@redhat.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	nh-open-source@amazon.com
Subject: Re: [PATCH] vsock: Enable H2G override
Message-ID: <aaVrsXMmULivV4Se@sgarzare-redhat>
References: <20260302104138.77555-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302104138.77555-1-graf@amazon.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262625-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0832A1D7D97
X-Rspamd-Action: no action


Please target net-next tree for this new feature.

On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
>Vsock maintains a single CID number space which can be used to
>communicate to the host (G2H) or to a child-VM (H2G). The current logic
>trivially assumes that G2H is only relevant for CID <= 2 because these
>target the hypervisor.  However, in environments like Nitro Enclaves, an
>instance that hosts vhost_vsock powered VMs may still want to communicate
>to Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
>
>That means that for CID > 2, we really want an overlay. By default, all
>CIDs are owned by the hypervisor. But if vhost registers a CID, it takes
>precedence.  Implement that logic. Vhost already knows which CIDs it
>supports anyway.
>
>With this logic, I can run a Nitro Enclave as well as a nested VM with
>vhost-vsock support in parallel, with the parent instance able to
>communicate to both simultaneously.

I honestly don't understand why VMADDR_FLAG_TO_HOST (added specifically 
for Nitro IIRC) isn't enough for this scenario and we have to add this 
change.  Can you elaborate a bit more about the relationship between 
this change and VMADDR_FLAG_TO_HOST we added?

>
>Signed-off-by: Alexander Graf <graf@amazon.com>
>---
> drivers/vhost/vsock.c    | 11 +++++++++++
> include/net/af_vsock.h   |  3 +++
> net/vmw_vsock/af_vsock.c |  3 +++
> 3 files changed, 17 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 054f7a718f50..223da817e305 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -91,6 +91,16 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
> 	return NULL;
> }
>
>+static bool vhost_transport_has_cid(u32 cid)
>+{
>+	bool found;
>+
>+	rcu_read_lock();
>+	found = vhost_vsock_get(cid) != NULL;

We recently added namespaces support that changed vhost_vsock_get() 
params. This is also in net tree now and in Linus' tree, so not sure 
where this patch is based, but this needs to be rebased since it is not 
building:

../drivers/vhost/vsock.c: In function ‘vhost_transport_has_cid’:
../drivers/vhost/vsock.c:99:17: error: too few arguments to function ‘vhost_vsock_get’; expected 2, have 1
    99 |         found = vhost_vsock_get(cid) != NULL;
       |                 ^~~~~~~~~~~~~~~
../drivers/vhost/vsock.c:74:28: note: declared here
    74 | static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
       |

>+	rcu_read_unlock();
>+	return found;
>+}
>+
> static void
> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			    struct vhost_virtqueue *vq)
>@@ -424,6 +434,7 @@ static struct virtio_transport vhost_transport = {
> 		.module                   = THIS_MODULE,
>
> 		.get_local_cid            = vhost_transport_get_local_cid,
>+		.has_cid                  = vhost_transport_has_cid,
>
> 		.init                     = virtio_transport_do_socket_init,
> 		.destruct                 = virtio_transport_destruct,
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 533d8e75f7bb..4cdcb72f9765 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -179,6 +179,9 @@ struct vsock_transport {
> 	/* Addressing. */
> 	u32 (*get_local_cid)(void);
>
>+	/* Check if this transport serves a specific remote CID. */
>+	bool (*has_cid)(u32 cid);

What about "has_remote_cid" ?

>+
> 	/* Read a single skb */
> 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2f7d94d682cb..8b34b264b246 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -584,6 +584,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
> 			 (remote_flags & VMADDR_FLAG_TO_HOST))
> 			new_transport = transport_g2h;
>+		else if (transport_h2g->has_cid &&
>+			 !transport_h2g->has_cid(remote_cid))
>+			new_transport = transport_g2h;

We should update the comment on top of this fuction, and maybe also try 
to support the other H2G transport (i.e. VMCI).

@Bryan @Vishnu can the new has_cid()/has_remote_cid() be supported by 
VMCI too?



I have a question: until now, transport assignment was based simply on 
analyzing local socket information (vsk->remote_addr), but now we are 
also adding the status of other components (e.g., VMs that have started 
and registered the CID in vhost-vsock).

Could this produce strange behavior?
For example, two sockets with the same remote_addr communicate with the 
host or with the guest depending on whether or not the VM existed when 
they were created.

Thanks,
Stefano

> 		else
> 			new_transport = transport_h2g;
> 		break;
>-- 
>2.47.1
>
>
>
>
>Amazon Web Services Development Center Germany GmbH
>Tamara-Danz-Str. 13
>10243 Berlin
>Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
>Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
>Sitz: Berlin
>Ust-ID: DE 365 538 597
>
>


