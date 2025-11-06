Return-Path: <netdev+bounces-236449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2015C3C71C
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 636F84EDE0D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6E83563D7;
	Thu,  6 Nov 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULQGN5ZK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9+ArDmM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248893559F0
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445931; cv=none; b=kaAQMI1Rg0kDv8SocRK3lJfKWlupgcqAgALS2ySUSztzMJ2DtEFe7AoNe2gTQX45qRs3DXC/lKpz5Edu3hg3OFEP1UgGmWtvxfyVd4MurJzWzRQIMnh3G9A1hoP8SHJNbhYLstWvJ+uGSrU410ofXLQ7dV3gYnSU2bQa1jvjcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445931; c=relaxed/simple;
	bh=P6dqZEO6asp6iI5HNxSfu9qxJ1GAnGbKVOQiwtyp9f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuFh/0bO4M54ZUe6VUyuMG5zdoENiLKUo2sats1TFqSzCLrXYucLl0nWrpIF7grB01XfOAxLguA84cThXy10JdqsdbJSqhYiia1MMWjVVcmHMWs91zEv6i8IzZ9UHSmAJ0W3SLPftFV/eMl3zJazlJZW6cCownStb8PMmxrzTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULQGN5ZK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9+ArDmM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlaSIzfnjC1rglQ5EMwdrXBGdH8/0geumBayPNyr3uQ=;
	b=ULQGN5ZK7Q0rq7y5hBm+9X2LLFYAtdsudmniInQnmroYSFQK1Lr9yb+9ahO9nDxQ8AGcEu
	y/InX4Zc+79yp8coukYokEEZW6JCOABzkVgLn6r7gdBTEvdRRYjqF9UoyDEjMwGc7k46Qg
	uXRr+hRVT2o1SI+hIJWGf/sWsEmDYUU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-c2wrCY5INmyZpeU_rDlcpA-1; Thu, 06 Nov 2025 11:18:44 -0500
X-MC-Unique: c2wrCY5INmyZpeU_rDlcpA-1
X-Mimecast-MFC-AGG-ID: c2wrCY5INmyZpeU_rDlcpA_1762445924
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso9078985e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762445924; x=1763050724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlaSIzfnjC1rglQ5EMwdrXBGdH8/0geumBayPNyr3uQ=;
        b=e9+ArDmM56iC0YD7ylFl0Lj3j1EUmQh662Vb778NkEiWYOkApma8YQSlbgU8Te34PF
         YBzglWUpy5eBNsjCJUIV23esSqLf8cKVXlgXQTgfzZ0yjZpFpAEJ69hkqwoWN9J4Iya8
         b5q5ig9u4sc7JzOZqZjW01BqKDhy2JoFhi760IUcPzf4L2Dgcog+NMp0E2Zakz4v+VAM
         rrV9lxNZX0zWwSWEH9jieAeTsE78JmfOc/3QdKQAR6LgrbbzRT4a7BTN5W/IyRdJAqxy
         ComPIP/4vyjslRPQBlJ9YJcfbOe84VGunimx0ka9tgJkhoEJtbY48QYvSGDm1W4Ke0ra
         4DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445924; x=1763050724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlaSIzfnjC1rglQ5EMwdrXBGdH8/0geumBayPNyr3uQ=;
        b=Wl35AD2bLlkd1KSw1ibjztIkb6tqsl1hWDbjNU8Q9sn+T3OKOSF7LzXNloOBA+3QXw
         VBn0rDjNpi+OJEnGU0o/x2NWuw56GRgA8qDcnWvu6zuifB+5lRjcukeo9SnJwtw/pKEu
         6w6b2liG7DcqQGMxwmlsrXPybd102rzYBzuCqwzIt0DQwz2s/jl79na69HiPaNzJafEG
         gZnR9VLNvCSlr8LNLcNRa2tWRcQl3GPMEz2/LbTh/0ifhLgper3dJ7hqYgp9QW/H7eNu
         Zun+xmiN/AuBr3wvxaH/OP+kOIdlE1K1R55omPBQUnBwzHkoHLHSrJOr7/RM2t67x/1B
         Bc4g==
X-Forwarded-Encrypted: i=1; AJvYcCWnc29dYaN2E4eDOOT9g1kg1PpSMnfDszODac4i4b6i2ow59wJefN/j0w3Ubu4rYsjtiB6r2Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ia7Whw2ZIgvDNhhGosn0eWqH1Io0Clb8HT9Hv9uRsjw8pE9I
	Q3cW45ZaR+At1RzUD6va0kx+cEF35Nynq0ag5t12bjROH/N0NKfeItxu833f+l5sA0f3hy6UKKp
	eMY3zY2CavxvemnuQXXbmkIAn+Fi6xb7OyynNBD8sw1uSKxJpcKiAf0O2eQ==
X-Gm-Gg: ASbGncu5JYUPZNH878F+XjiV5P8lrAQmaLPw0Z8G1MaNUYCA+Nikor79MhkuCV6GhfF
	8D9Hk4c4DeL0LexfIClQAaSv24imdwPKs9WgwSdtoTzPMYHGL75CrkfXuB7zDSF2B5+rNCoFKc2
	PUj3U2IzWZHGPjFPbaOFG7uNgeBgTjw5nnLZxYDw13PIsv/7TVVNyvjWkjEoSETVZOeLHOJ6v/c
	VR4l3lYDLhAYbHXDGDjYnjxT05jB6tzPpEo4XwGXOusv9DxHE/i9zMB9nHPr+PFMVVhjlBWg4pK
	76/H8//EK/b8mwfdDkBU3qKrW0ECBrjfOQeXFbbrwJikXYRMVmpBJBrq0GfVHxGwhh80I5+J1GC
	qcg==
X-Received: by 2002:a05:600c:5251:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-4775cdbd546mr60025795e9.5.1762445923647;
        Thu, 06 Nov 2025 08:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP/WvasiwYTgtNLqdi1/A6yt0PQxbP4Abxbsn2GMIJwekrkfT7LDMidIZ3T6Hr6zobvw5ZaQ==
X-Received: by 2002:a05:600c:5251:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-4775cdbd546mr60024435e9.5.1762445921975;
        Thu, 06 Nov 2025 08:18:41 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477626eb4fdsm55397145e9.17.2025.11.06.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:18:41 -0800 (PST)
Date: Thu, 6 Nov 2025 17:18:36 +0100
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
Subject: Re: [PATCH net-next v8 05/14] vsock/loopback: add netns support
Message-ID: <tuclqrdg5p2uzfvczhcdig7jlifvhqtlafe4xcqy4x4p3vrya6@jq5mujdluze5>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-5-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-5-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:44AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add NS support to vsock loopback. Sockets in a global mode netns
>communicate with each other, regardless of namespace. Sockets in a local
>mode netns may only communicate with other sockets within the same
>namespace.
>
>Use pernet_ops to install a vsock_loopback for every namespace that is
>created (to be used if local mode is enabled).
>
>Retroactively call init/exit on every namespace when the vsock_loopback
>module is loaded in order to initialize the per-ns device.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---

I'm a bit confused, should we move this after the next patch that add 
support of netns in the virtio common module?

Or this is a pre-requisite?

>Changes in v7:
>- drop for_each_net() init/exit, drop net_rwsem, the pernet registration
>  handles this automatically and race-free
>- flush workqueue before destruction, purge pkt list
>- remember net_mode instead of current net mode
>- keep space after INIT_WORK()
>- change vsock_loopback in netns_vsock to ->priv void ptr
>- rename `orig_net_mode` to `net_mode`
>- remove useless comment
>- protect `register_pernet_subsys()` with `net_rwsem`
>- do cleanup before releasing `net_rwsem` when failure happens
>- call `unregister_pernet_subsys()` in `vsock_loopback_exit()`
>- call `vsock_loopback_deinit_vsock()` in `vsock_loopback_exit()`
>
>Changes in v6:
>- init pernet ops for vsock_loopback module
>- vsock_loopback: add space in struct to clarify lock protection
>- do proper cleanup/unregister on vsock_loopback_exit()
>- vsock_loopback: use virtio_vsock_skb_net()
>
>Changes in v5:
>- add callbacks code to avoid reverse dependency
>- add logic for handling vsock_loopback setup for already existing
>  namespaces
>---
> include/net/netns/vsock.h      |  2 +
> net/vmw_vsock/vsock_loopback.c | 85 ++++++++++++++++++++++++++++++++++++------
> 2 files changed, 75 insertions(+), 12 deletions(-)
>
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index c9a438ad52f2..9d0d8e2fbc37 100644
>--- a/include/net/netns/vsock.h
>+++ b/include/net/netns/vsock.h
>@@ -16,5 +16,7 @@ struct netns_vsock {
> 	/* protected by lock */
> 	enum vsock_net_mode mode;
> 	bool mode_locked;
>+
>+	void *priv;
> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index a8f218f0c5a3..474083d4cfcb 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -28,8 +28,16 @@ static u32 vsock_loopback_get_local_cid(void)
>
> static int vsock_loopback_send_pkt(struct sk_buff *skb)
> {
>-	struct vsock_loopback *vsock = &the_vsock_loopback;
>+	struct vsock_loopback *vsock;
> 	int len = skb->len;
>+	struct net *net;
>+
>+	net = virtio_vsock_skb_net(skb);
>+
>+	if (virtio_vsock_skb_net_mode(skb) == VSOCK_NET_MODE_LOCAL)
>+		vsock = (struct vsock_loopback *)net->vsock.priv;

Is there some kind of refcount on the net?
What I mean is, are we sure this pointer is still valid? Could the net 
disappear in the meantime?

The rest LGTM!

Thanks,
Stefano

>+	else
>+		vsock = &the_vsock_loopback;
>
> 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> 	queue_work(vsock->workqueue, &vsock->pkt_work);
>@@ -134,11 +142,8 @@ static void vsock_loopback_work(struct work_struct *work)
> 	}
> }
>
>-static int __init vsock_loopback_init(void)
>+static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
> {
>-	struct vsock_loopback *vsock = &the_vsock_loopback;
>-	int ret;
>-
> 	vsock->workqueue = alloc_workqueue("vsock-loopback", WQ_PERCPU, 0);
> 	if (!vsock->workqueue)
> 		return -ENOMEM;
>@@ -146,15 +151,73 @@ static int __init vsock_loopback_init(void)
> 	skb_queue_head_init(&vsock->pkt_queue);
> 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
>
>+	return 0;
>+}
>+
>+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
>+{
>+	if (vsock->workqueue) {
>+		flush_work(&vsock->pkt_work);
>+		virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
>+		destroy_workqueue(vsock->workqueue);
>+		vsock->workqueue = NULL;
>+	}
>+}
>+
>+static int vsock_loopback_init_net(struct net *net)
>+{
>+	int ret;
>+
>+	net->vsock.priv = kzalloc(sizeof(struct vsock_loopback), GFP_KERNEL);
>+	if (!net->vsock.priv)
>+		return -ENOMEM;
>+
>+	ret = vsock_loopback_init_vsock((struct vsock_loopback *)net->vsock.priv);
>+	if (ret < 0) {
>+		kfree(net->vsock.priv);
>+		net->vsock.priv = NULL;
>+		return ret;
>+	}
>+
>+	return 0;
>+}
>+
>+static void vsock_loopback_exit_net(struct net *net)
>+{
>+	vsock_loopback_deinit_vsock(net->vsock.priv);
>+	kfree(net->vsock.priv);
>+	net->vsock.priv = NULL;
>+}
>+
>+static struct pernet_operations vsock_loopback_net_ops = {
>+	.init = vsock_loopback_init_net,
>+	.exit = vsock_loopback_exit_net,
>+};
>+
>+static int __init vsock_loopback_init(void)
>+{
>+	struct vsock_loopback *vsock = &the_vsock_loopback;
>+	int ret;
>+
>+	ret = vsock_loopback_init_vsock(vsock);
>+	if (ret < 0)
>+		return ret;
>+
>+	ret = register_pernet_subsys(&vsock_loopback_net_ops);
>+	if (ret < 0)
>+		goto out_deinit_vsock;
>+
> 	ret = vsock_core_register(&loopback_transport.transport,
> 				  VSOCK_TRANSPORT_F_LOCAL);
> 	if (ret)
>-		goto out_wq;
>+		goto out_unregister_pernet_subsys;
>
> 	return 0;
>
>-out_wq:
>-	destroy_workqueue(vsock->workqueue);
>+out_unregister_pernet_subsys:
>+	unregister_pernet_subsys(&vsock_loopback_net_ops);
>+out_deinit_vsock:
>+	vsock_loopback_deinit_vsock(vsock);
> 	return ret;
> }
>
>@@ -164,11 +227,9 @@ static void __exit vsock_loopback_exit(void)
>
> 	vsock_core_unregister(&loopback_transport.transport);
>
>-	flush_work(&vsock->pkt_work);
>-
>-	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
>+	unregister_pernet_subsys(&vsock_loopback_net_ops);
>
>-	destroy_workqueue(vsock->workqueue);
>+	vsock_loopback_deinit_vsock(vsock);
> }
>
> module_init(vsock_loopback_init);
>
>-- 
>2.47.3
>


