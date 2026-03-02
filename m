Return-Path: <netdev+bounces-262734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOJ1OXO7pWnNFQAAu9opvQ
	(envelope-from <netdev+bounces-262734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:31:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9131DCDE4
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6A6E30A0A4D
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630BB40B6C0;
	Mon,  2 Mar 2026 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2Jkszic";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyweOOID"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A53E557E
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468776; cv=none; b=AimU8gBbaL9RGxU6RiOdhlOHXyGu1IH4PCD43Mrsi2Uka+GQpVbpED6a+M+so9aXnooHcjB8kW2cwsYRW2M8P7ClGtieL7S0O26Y+7vdHBVc3Lj35x2BSINAACnBKcWzIN3LtwyMmybFI+viBO1PLycGgzH4f7vVcrDHY+6IhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468776; c=relaxed/simple;
	bh=VUukFPCECqC7eKh/jyhbn/43A15nBMbp1SbN479gtOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jON81XK7xHVQklQh/Qyi/he243CV/7Lr4G/CciV6rJ4ElzmOhrXPlUDp+TATNA4G6GI+RhhaYvd42jnI7NuP1aqyg6rcJ1ympMWbTG0ZTYi31tduFQsDIy9GS8C55AudPu4LT1nHZePWrMFkh1Ec+cEhV3+P8IjEyYxQOiR/APM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2Jkszic; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyweOOID; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772468774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vg8IbmZ7D530z7Jvag10aXKFjAkHqDPNjDI453xyigM=;
	b=U2JkszicMxbs6uCmyQSXNNA8gdAG9Zzmzq/xleqvFDcS6BSgS8sWyYZBjhYnMLKtSoHIyE
	X6rRF7QdixV8BEh1t4wNmVI0TXh8H5CTTKeM+CQ6TuiEFgHL5+dMKilMdFO3/+/jbGI4BA
	rkonZWVVbcdX7XpCm+I3Tqf8J8LtYXE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-YMH-6s0QNBSDj0ahpa45Tw-1; Mon, 02 Mar 2026 11:26:10 -0500
X-MC-Unique: YMH-6s0QNBSDj0ahpa45Tw-1
X-Mimecast-MFC-AGG-ID: YMH-6s0QNBSDj0ahpa45Tw_1772468770
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48079ae1001so37330065e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772468769; x=1773073569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vg8IbmZ7D530z7Jvag10aXKFjAkHqDPNjDI453xyigM=;
        b=KyweOOIDJQMtP4zF80QPVaprQbCMrUB74X3nHVufXphEo9UJ6PTX3an3+2wB+bFJIY
         IsKh23+0Zigj0VZdRhbllIyhI3sOwPWI9+DQPj8Kuxsyy4v6nTQc8jXA+qT4h5tJ+oWJ
         vTWGFpkxypFOSrRR9TNYvjPWHJuBL1UfbkU1QZYa4S/mW50qNfQIxPB0+byzvgB7BLHt
         EsrlGJLsO3jlJXjnFrNiP2aZ1LW8s3+eMTQhz7//nTsd+sqQcm96XEOay6JI6lYUDd+V
         yNlPPmZ1wRtZHVuH07bZE8kzL2GS5Mytz9LuuDSeC2he1qGrlNHUq0vzAdzD6s2Tbiws
         D4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468769; x=1773073569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg8IbmZ7D530z7Jvag10aXKFjAkHqDPNjDI453xyigM=;
        b=BIs/E4KNBtY6sj+/DjrRVyR9ckissVyWOOz2nJiNZN0vFSjc/M0+Lp9oUmWR9hG9Cr
         Sysp+YtVSYxA+DTy8rBGD6It04zpK85q8ED5ercbK+LfY/cc9+PI7dGGzgm9zUimfgGY
         byGjT+GVRiNI/JXsJOvvotpbDdoGq4kM33wJk0CQVgaeAFSOE8oBSaMaDnHbGseFzdsO
         MiFsALZhSPHWoN6UznVV1OSHOo5z77jfSy85I0bmS8BVrrBlllguda7GAsXbCysuFuyr
         m90vT5bsZyYih+qty0Vq/ltT3NwDsVS/wRHocb24gXcVEfa9M9hRBjKhMi+Wcsouwjtt
         +Slg==
X-Forwarded-Encrypted: i=1; AJvYcCWV+nGoncnNcQthrdjZfN/Vge943EdSl1V5ZqHDNBL7S5S222eJKWxaoNcQ3o54eTgIaTm1BJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsfno7NrDABtBAotDs1D0SdJ93c8Wljdf0jhxukY0gIHk+dUQM
	RM+9sBXgXyq0Ktj/kyvdksE7/KCjL7v/wS1ALrRkJgWCDDMQts2Hjpdnnnr1IaeSsRfJ7iZiiL7
	pua9QWuBSCsUlYgATQ/dHxYTzuOEU1K3rGXb4KyeZai0gqEPkxXbPj3yYMA==
X-Gm-Gg: ATEYQzyhRF89p2QEUhYpDMbxawkmQSkZ5QCz3MWbMvM7OaoDVltdI5lkLRp6v6whLyk
	4YHqrQjJ8e8ootUzaJmef2xvjc3xPA0zgLK0D+29WLf10l7mmkvbrzSdLhcGd9yI/+RzLG7Kp6m
	VKbwbBNsClGrKzEN0fSWg/+kAemqC/HyTya73HBXgt9rZvNy8gEouA/etayxK4vK3Fa59DOo68W
	Ul2Uh7wwuHqB2xsj7vqApxFat42GUEIIqEhpKtvl/x0sQG6gS0DGlNwuwzv9kMK+yzV3pp4HtNF
	kYfRRrx/p4XyTx6dt81wHu7NlzG55L3XimzhG32CPSbjR8DgKrOc66TufYfMLKv2DsjJijME1KH
	OvUy4QqrcEZfaYnfONE+CUh4DBvMASAZzwBWwCNEsxHrpabrvu1uqe6hBMNa5ZSVzlGohRLo=
X-Received: by 2002:a05:600c:6095:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-483c9b7ac8bmr235315845e9.0.1772468769451;
        Mon, 02 Mar 2026 08:26:09 -0800 (PST)
X-Received: by 2002:a05:600c:6095:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-483c9b7ac8bmr235315315e9.0.1772468768929;
        Mon, 02 Mar 2026 08:26:08 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb87030sm134278895e9.10.2026.03.02.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:26:08 -0800 (PST)
Date: Mon, 2 Mar 2026 17:25:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com, 
	Jason Wang <jasowang@redhat.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	nh-open-source@amazon.com
Subject: Re: [PATCH] vsock: Enable H2G override
Message-ID: <aaW2FgoaXIJEymyR@sgarzare-redhat>
References: <20260302104138.77555-1-graf@amazon.com>
 <aaVrsXMmULivV4Se@sgarzare-redhat>
 <aaV80wWlpjEtYCQJ@sgarzare-redhat>
 <17d63837-6028-475a-90df-6966329a0fc2@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17d63837-6028-475a-90df-6966329a0fc2@amazon.com>
X-Rspamd-Queue-Id: 6D9131DCDE4
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
	TAGGED_FROM(0.00)[bounces-262734-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 04:48:33PM +0100, Alexander Graf wrote:
>
>On 02.03.26 13:06, Stefano Garzarella wrote:
>>CCing Bryan, Vishnu, and Broadcom list.
>>
>>On Mon, Mar 02, 2026 at 12:47:05PM +0100, Stefano Garzarella wrote:
>>>
>>>Please target net-next tree for this new feature.
>>>
>>>On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
>>>>Vsock maintains a single CID number space which can be used to
>>>>communicate to the host (G2H) or to a child-VM (H2G). The current logic
>>>>trivially assumes that G2H is only relevant for CID <= 2 because these
>>>>target the hypervisor.  However, in environments like Nitro 
>>>>Enclaves, an
>>>>instance that hosts vhost_vsock powered VMs may still want to 
>>>>communicate
>>>>to Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
>>>>
>>>>That means that for CID > 2, we really want an overlay. By default, all
>>>>CIDs are owned by the hypervisor. But if vhost registers a CID, 
>>>>it takes
>>>>precedence.  Implement that logic. Vhost already knows which CIDs it
>>>>supports anyway.
>>>>
>>>>With this logic, I can run a Nitro Enclave as well as a nested VM with
>>>>vhost-vsock support in parallel, with the parent instance able to
>>>>communicate to both simultaneously.
>>>
>>>I honestly don't understand why VMADDR_FLAG_TO_HOST (added 
>>>specifically for Nitro IIRC) isn't enough for this scenario and we 
>>>have to add this change.  Can you elaborate a bit more about the 
>>>relationship between this change and VMADDR_FLAG_TO_HOST we added?
>
>
>The main problem I have with VMADDR_FLAG_TO_HOST for connect() is that 
>it punts the complexity to the user. Instead of a single CID address 
>space, you now effectively create 2 spaces: One for TO_HOST (needs a 
>flag) and one for TO_GUEST (no flag). But every user space tool needs 
>to learn about this flag. That may work for super special-case 
>applications. But propagating that all the way into socat, iperf, etc 
>etc? It's just creating friction.

Okay, I would like to have this (or part of it) in the commit message to 
better explain why we want this change.

>
>IMHO the most natural experience is to have a single CID space, 
>potentially manually segmented by launching VMs of one kind within a 
>certain range.

I see, but at this point, should the kernel set VMADDR_FLAG_TO_HOST in 
the remote address if that path is taken "automagically" ?

So in that way the user space can have a way to understand if it's 
talking with a nested guest or a sibling guest.


That said, I'm concerned about the scenario where an application does 
not even consider communicating with a sibling VM.

Until now, it knew that by not setting that flag, it could only talk to 
nested VMs, so if there was no VM with that CID, the connection simply 
failed. Whereas from this patch onwards, if the device in the host 
supports sibling VMs and there is a VM with that CID, the application 
finds itself talking to a sibling VM instead of a nested one, without 
having any idea.

Should we make this feature opt-in in some way, such as sockopt or 
sysctl? (I understand that there is the previous problem, but honestly, 
it seems like a significant change to the behavior of AF_VSOCK).

>
>At the end of the day, the host vs guest problem is super similar to a 
>routing table.

Yeah, but the point of AF_VSOCK is precisely to avoid complexities such 
as routing tables as much as possible; otherwise, AF_INET is already 
there and ready to be used. In theory, we only want communication 
between host and guest.

>
>
>>>
>>>>
>>>>Signed-off-by: Alexander Graf <graf@amazon.com>
>>>>---
>>>>drivers/vhost/vsock.c    | 11 +++++++++++
>>>>include/net/af_vsock.h   |  3 +++
>>>>net/vmw_vsock/af_vsock.c |  3 +++
>>>>3 files changed, 17 insertions(+)
>>>>
>>>>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>>>>index 054f7a718f50..223da817e305 100644
>>>>--- a/drivers/vhost/vsock.c
>>>>+++ b/drivers/vhost/vsock.c
>>>>@@ -91,6 +91,16 @@ static struct vhost_vsock 
>>>>*vhost_vsock_get(u32 guest_cid, struct net *net)
>>>>    return NULL;
>>>>}
>>>>
>>>>+static bool vhost_transport_has_cid(u32 cid)
>>>>+{
>>>>+    bool found;
>>>>+
>>>>+    rcu_read_lock();
>>>>+    found = vhost_vsock_get(cid) != NULL;
>>>
>>>We recently added namespaces support that changed 
>>>vhost_vsock_get() params. This is also in net tree now and in 
>>>Linus' tree, so not sure where this patch is based, but this needs 
>>>to be rebased since it is not building:
>>>
>>>../drivers/vhost/vsock.c: In function ‘vhost_transport_has_cid’:
>>>../drivers/vhost/vsock.c:99:17: error: too few arguments to 
>>>function ‘vhost_vsock_get’; expected 2, have 1
>>>  99 |         found = vhost_vsock_get(cid) != NULL;
>>>     |                 ^~~~~~~~~~~~~~~
>>>../drivers/vhost/vsock.c:74:28: note: declared here
>>>  74 | static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, 
>>>struct net *net)
>>>     |
>
>
>D'oh. Sorry, I built this on 6.19 and only realized after the send 
>that namespace support got in. Will fix up for v2.

Thanks.

>
>
>>>
>>>>+    rcu_read_unlock();
>>>>+    return found;
>>>>+}
>>>>+
>>>>static void
>>>>vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>>>>                struct vhost_virtqueue *vq)
>>>>@@ -424,6 +434,7 @@ static struct virtio_transport vhost_transport = {
>>>>        .module                   = THIS_MODULE,
>>>>
>>>>        .get_local_cid            = vhost_transport_get_local_cid,
>>>>+        .has_cid                  = vhost_transport_has_cid,
>>>>
>>>>        .init                     = virtio_transport_do_socket_init,
>>>>        .destruct                 = virtio_transport_destruct,
>>>>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>>>index 533d8e75f7bb..4cdcb72f9765 100644
>>>>--- a/include/net/af_vsock.h
>>>>+++ b/include/net/af_vsock.h
>>>>@@ -179,6 +179,9 @@ struct vsock_transport {
>>>>    /* Addressing. */
>>>>    u32 (*get_local_cid)(void);
>>>>
>>>>+    /* Check if this transport serves a specific remote CID. */
>>>>+    bool (*has_cid)(u32 cid);
>>>
>>>What about "has_remote_cid" ?
>>>
>>>>+
>>>>    /* Read a single skb */
>>>>    int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>>>>
>>>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>index 2f7d94d682cb..8b34b264b246 100644
>>>>--- a/net/vmw_vsock/af_vsock.c
>>>>+++ b/net/vmw_vsock/af_vsock.c
>>>>@@ -584,6 +584,9 @@ int vsock_assign_transport(struct vsock_sock 
>>>>*vsk, struct vsock_sock *psk)
>>>>        else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>>>>             (remote_flags & VMADDR_FLAG_TO_HOST))
>>>>            new_transport = transport_g2h;
>>>>+        else if (transport_h2g->has_cid &&
>>>>+             !transport_h2g->has_cid(remote_cid))
>>>>+            new_transport = transport_g2h;
>>>
>>>We should update the comment on top of this fuction, and maybe 
>>>also try to support the other H2G transport (i.e. VMCI).
>>>
>>>@Bryan @Vishnu can the new has_cid()/has_remote_cid() be supported 
>>>by VMCI too?
>>
>>Oops, I forgot to CC them, now they should be in copy.
>
>
>Ack. I can also take a quick look if it's trivial to add.

Great, thanks for that!

Stefano


