Return-Path: <netdev+bounces-239656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA9C6B1FB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 0429D2A13A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C4322DAF;
	Tue, 18 Nov 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRXDrS60";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANdr4X9o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACA3355050
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489443; cv=none; b=R+K/sVcbVT8cjhjrkZPXJruS0nDmnX9CH5/m3peRAIcbHmucfb8QINmqTzdamiKN6N6k/W7JlH5LFctnmQTfWpvSV12ELxZ0oxwrdoQKlG7qqiInyp1wR04Uj3jPWF1ttu775ES7SHUPUUWgW0bJJsG0bCOUFASQz1tuq+Uo7rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489443; c=relaxed/simple;
	bh=I2JJ1tCv8Agm6oYmejeapO9yQ5ZjVer5ugyNFb0NIio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxFQbDpwsYUrEzNHjCRJTZzvMY4x0FKxj57j8PX4lLT8T4e5rT4/PKDVqE+wkZuJLmUPZzADyLW2I8duQQDVbw0spT+SGTw1stX/AZzPSyuCCy/LpCuJwlYTs6SLwwtCGcBiCvZS/jHp5kK2tzGOrEoxWCowvdNeW5QBfB9O3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRXDrS60; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANdr4X9o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b54A6joNdavqdu7nYfZhZqdIA9l92Lpt9UfdeKtQjt8=;
	b=hRXDrS60ENZ/pnNQeF/aEEBg7sy4cBETafWDuVXpQC00Ebx4QsyIaSZ0dsufP98lFTT1OZ
	AQQTSYz/bt17OOXf11PcbJ5EpeI6wHj4DrAGoHY99VNYcJQmNn+SfeGm08WQvVwMzo/Q7e
	VdfSbE1xbtpvB/DvUKejzqVWBAut25E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-mpNjhB7bPT6ABlM8aBARFQ-1; Tue, 18 Nov 2025 13:10:38 -0500
X-MC-Unique: mpNjhB7bPT6ABlM8aBARFQ-1
X-Mimecast-MFC-AGG-ID: mpNjhB7bPT6ABlM8aBARFQ_1763489436
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7336ad128cso775480266b.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489436; x=1764094236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b54A6joNdavqdu7nYfZhZqdIA9l92Lpt9UfdeKtQjt8=;
        b=ANdr4X9oKx1IJQ/IR/03eCCHgaoaZnBKRSKdE48EF9EZY6utlZc+leiP9KwsAXkoBF
         EkQlVO9sK/O/3p3hHgIbzc0PLx2p+tldYC4pAPKpxCty1jJIwXroGJlPB6sN023pfdln
         s8LswatuPIg4jC16OjUKsh7qXS9+ohs/hc39FsI8ip5ecnuGAFAl8FXctYGvwLGZKGaS
         XfWYgwpqv2PjJPJLlntcbHVbdddaDNeFfO9pDdLtsac9dPJRyzImMZE/iq9JtiQy9uKF
         qFFWHArnVDnLi8nfVHyUgF2nzhbB6h7pUwRWpkaLqluJEEdRhN4NzPjNL31P7RPdjWBS
         Y4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489436; x=1764094236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b54A6joNdavqdu7nYfZhZqdIA9l92Lpt9UfdeKtQjt8=;
        b=eiL38vEeAofIcdPTZ9uOT8aUnKBEzCl6nPlwHPQaQkzEU1TUdVAjVOPRT2bhFANw8M
         1gBQu5HoiGkR/tYpWAh67xeKs1HYQYZqqCNs0M5xdQoSJJPCCvpAnLvcmU2MPQg+h/3x
         jDqhKZhTmaQgxWJqYtU/EUAQdbL055fJKhPo81j/FPslGwQBw7B7XaiOYUYxfVY4BNJw
         QTejH4uME/0xpdFhT87P5o8UlqF+5FfraTOutAdnt4mip2RLYjZfuCn/HaICr8vi2d/G
         mRSOSatyJF88iQaOfq+znHEFFUystYV21GQFrbe0A6NWaMoVakRKcqVuwUZhApTS347c
         mCow==
X-Forwarded-Encrypted: i=1; AJvYcCUNlElMKuknvMmm2XhLqsH41CsPKTeFX3jsacBldRdVHrQlmaq5xr2Mf1Rph9kYF+Ypo56W8eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpM+87nSB0CGoSgOoAHSVJYb5eMoYZNsLPGj+Uxd6Tuik1b2cO
	u7rY8qJiAAEZEPI4JaFmUuaTXX/ioyB73sEM4cM1jBgQtoW6kB8cym4/7hZNMUv2KoJ8nrpHvVk
	07G1ZO/9swR9rBVLn4wo+rhG6DZEUxNNXsIIg0PUWVLWKr76iWdbaGkew+A==
X-Gm-Gg: ASbGnctgZSI3vGG8oBR6X2MdzwF61JdXb7E0pKYt+V5DIyn0Fy8wrQ1YC1hvw9lRsqH
	FRRDZoTa5R3qVRl9U5sUj+07eq5KA1rBqD4S96bfUMyo1wOFPZejh3oc1V1h7CXK0oN4qR9SzwC
	opvj71g5c+i6EqokS9/I4dkqcvKab8I4BHUYNmD8tc88vkA4VRdShIZ3oUkw59ewrVOLiZ3GYza
	9J5LC3/fu/7nZj4VUTZSXRltbMXTny9ArYemrJHyaeB2CO5QecQNy0XRgTSbs3ECUIcAJvxXiIA
	0eMUUkNmCgKURmo9QAKcK21N0DlPCdmzOQ+THul8ejTUR9uNQUlPh0Nc0+NoaTty+3JNrv05qvK
	bena502fSLjVDK2Z0JiWvmUOUukdQunG2BZtOan5sGSV4WyVqjSG/iBOwpk4=
X-Received: by 2002:a17:907:25cd:b0:b72:6383:4c57 with SMTP id a640c23a62f3a-b7367b79f4fmr2007938466b.55.1763489435562;
        Tue, 18 Nov 2025 10:10:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHleoKw6aR8fpP9SEzji0mhyusqbHzR6L9dUnAr/MvrkV7jmuKQQd3H8f4997CvU7MIS586og==
X-Received: by 2002:a17:907:25cd:b0:b72:6383:4c57 with SMTP id a640c23a62f3a-b7367b79f4fmr2007933566b.55.1763489435050;
        Tue, 18 Nov 2025 10:10:35 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fb12d55sm1400435566b.33.2025.11.18.10.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:10:34 -0800 (PST)
Date: Tue, 18 Nov 2025 19:10:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 03/11] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <vsyzveqyufaquwx3xgahsh3stb6i5u3xa4kubpvesfzcuj6dry@sn4kx5ctgpbz>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-3-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-3-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:26PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Reject setting VSOCK_NET_MODE_LOCAL with -EOPNOTSUPP if a G2H transport
>is operational. Additionally, reject G2H transport registration if there
>already exists a namespace in local mode.
>
>G2H sockets break in local mode because the G2H transports don't support
>namespacing yet. The current approach is to coerce packets coming out of
>G2H transports into VSOCK_NET_MODE_GLOBAL mode, but it is not possible
>to coerce sockets in the same way because it cannot be deduced which
>transport will be used by the socket. Specifically, when bound to
>VMADDR_CID_ANY in a nested VM (both G2H and H2G available), it is not
>until a packet is received and matched to the bound socket that we
>assign the transport. This presents a chicken-and-egg problem, because
>we need the namespace to lookup the socket and resolve the transport,
>but we need the transport to know how to use the namespace during
>lookup.
>
>For that reason, this patch prevents VSOCK_NET_MODE_LOCAL from being
>used on systems that support G2H, even nested systems that also have H2G
>transports.
>
>Local mode is blocked based on detecting the presence of G2H devices
>(when possible, as hyperv is special). This means that a host kernel
>with G2H support compiled in (or has the module loaded), will still
>support local mode if there is no G2H (e.g., virtio-vsock) device
>detected. This enables using the same kernel in the host and in the
>guest, as we do in kselftest.
>
>Systems with only namespace-aware transports (vhost-vsock, loopback) can
>still use both VSOCK_NET_MODE_GLOBAL and VSOCK_NET_MODE_LOCAL modes as
>intended.
>
>Add supports_local_mode() transport callback to indicate
>transport-specific local mode support.
>
>These restrictions can be lifted in a future patch series when G2H
>transports gain namespace support.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- move this patch before any transports bring online namespacing (Stefano)
>- move vsock_net_mode_string into critical section (Stefano)
>- add ->supports_local_mode() callback to transports (Stefano)
>---
> drivers/vhost/vsock.c            |  6 +++++
> include/net/af_vsock.h           |  5 ++++
> net/vmw_vsock/af_vsock.c         | 50 ++++++++++++++++++++++++++++++++++------
> net/vmw_vsock/hyperv_transport.c |  6 +++++
> net/vmw_vsock/virtio_transport.c | 13 +++++++++++
> net/vmw_vsock/vmci_transport.c   |  7 ++++++
> net/vmw_vsock/vsock_loopback.c   |  6 +++++
> 7 files changed, 86 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 2c937a2df83b..c8319cd1c232 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -64,6 +64,11 @@ static u32 vhost_transport_get_local_cid(void)
> 	return VHOST_VSOCK_DEFAULT_HOST_CID;
> }
>
>+static bool vhost_transport_supports_local_mode(void)
>+{
>+	return true;

Should we enable this later, when we really add support, or it doesn't
affect anything if vhost-vsock is not really supporting it in this PR
(thinking about bisection issues).

>+}
>+
> /* Callers that dereference the return value must hold vhost_vsock_mutex or the
>  * RCU read lock.
>  */
>@@ -412,6 +417,7 @@ static struct virtio_transport vhost_transport = {
> 		.module                   = THIS_MODULE,
>
> 		.get_local_cid            = vhost_transport_get_local_cid,
>+		.supports_local_mode	  = vhost_transport_supports_local_mode,
>
> 		.init                     = virtio_transport_do_socket_init,
> 		.destruct                 = virtio_transport_destruct,
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 59d97a143204..824d89657d41 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -180,6 +180,11 @@ struct vsock_transport {
> 	/* Addressing. */
> 	u32 (*get_local_cid)(void);
>
>+	/* Return true if this transport supports VSOCK_NET_MODE_LOCAL.

nit: Here I would make it clearer that rather than supporting 
MODE_LOCAL, the transport is not compatible with it, etc.
A summary of the excellent description we have in the commit.

>+	 * Otherwise, return false.
>+	 */
>+	bool (*supports_local_mode)(void);
>+
> 	/* Read a single skb */
> 	int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 54373ae101c3..7a235bb94437 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -91,6 +91,12 @@
>  *   and locked down by a namespace manager. The default is "global". The mode
>  *   is set per-namespace.
>  *
>+ *   Note: LOCAL mode is only supported when using namespace-aware transports
>+ *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
>+ *   hyperv-vsock, vmci-vsock) is loaded, attempts to set LOCAL mode will fail
>+ *   with EOPNOTSUPP, as these transports do not support per-namespace
>+ *   isolation.

Okay, maybe this is fine, so if you don't need to resend, feel free to 
ignore the previous comment.

>+ *
>  *   The modes affect the allocation and accessibility of CIDs as follows:
>  *
>  *   - global - access and allocation are all system-wide
>@@ -2765,17 +2771,30 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
> 	if (*lenp >= sizeof(data))
> 		return -EINVAL;
>
>-	if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data)))
>+	ret = 0;

IIUC `ret` should already be 0 at this point, no?

>+	mutex_lock(&vsock_register_mutex);

I honestly don't like to mix the parsing, with this new check, so what
about leaving the parsing as before this patch (also without the mutex),
then just (untested):

	mutex_lock(&vsock_register_mutex);
	if (mode == VSOCK_NET_MODE_LOCAL && transport_g2h &&
	    transport_g2h->supports_local_mode &&
	    !transport_g2h->supports_local_mode()) {
		ret = -EOPNOTSUPP;
		goto out;
	}

	if (!vsock_net_write_mode(net, mode)) {
		ret = -EPERM;
	}
out:
	mutex_unlock(&vsock_register_mutex);
	return ret;
}

>+	if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data))) {
> 		mode = VSOCK_NET_MODE_GLOBAL;
>-	else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
>+	} else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data))) {
>+		if (transport_g2h && transport_g2h->supports_local_mode &&
>+		    !transport_g2h->supports_local_mode()) {
>+			ret = -EOPNOTSUPP;
>+			goto out;
>+		}
> 		mode = VSOCK_NET_MODE_LOCAL;
>-	else
>-		return -EINVAL;
>+	} else {
>+		ret = -EINVAL;
>+		goto out;
>+	}
>
>-	if (!vsock_net_write_mode(net, mode))
>-		return -EPERM;
>+	if (!vsock_net_write_mode(net, mode)) {
>+		ret = -EPERM;
>+		goto out;
>+	}
>
>-	return 0;
>+out:
>+	mutex_unlock(&vsock_register_mutex);
>+	return ret;
> }
>
> static struct ctl_table vsock_table[] = {
>@@ -2916,6 +2935,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> {
> 	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
> 	int err = mutex_lock_interruptible(&vsock_register_mutex);
>+	struct net *net;
>
> 	if (err)
> 		return err;
>@@ -2938,6 +2958,22 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> 			err = -EBUSY;
> 			goto err_busy;
> 		}
>+
>+		/* G2H sockets break in LOCAL mode namespaces because G2H
>+		 * transports don't support them yet. Block registering new G2H
>+		 * transports if we already have local mode namespaces on the
>+		 * system.
>+		 */
>+		rcu_read_lock();
>+		for_each_net_rcu(net) {
>+			if (vsock_net_mode(net) == VSOCK_NET_MODE_LOCAL) {
>+				rcu_read_unlock();
>+				err = -EOPNOTSUPP;
>+				goto err_busy;
>+			}
>+		}
>+		rcu_read_unlock();
>+
> 		t_g2h = t;
> 	}
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 432fcbbd14d4..279f04fcd81a 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -833,10 +833,16 @@ int hvs_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
> 	return -EOPNOTSUPP;
> }
>
>+static bool hvs_supports_local_mode(void)
>+{
>+	return false;
>+}
>+
> static struct vsock_transport hvs_transport = {
> 	.module                   = THIS_MODULE,
>
> 	.get_local_cid            = hvs_get_local_cid,
>+	.supports_local_mode      = hvs_supports_local_mode,
>
> 	.init                     = hvs_sock_init,
> 	.destruct                 = hvs_destruct,
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 5d379ccf3770..e585cb66c6f5 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -94,6 +94,18 @@ static u32 virtio_transport_get_local_cid(void)
> 	return ret;
> }
>
>+static bool virtio_transport_supports_local_mode(void)
>+{
>+	struct virtio_vsock *vsock;
>+
>+	rcu_read_lock();
>+	vsock = rcu_dereference(the_virtio_vsock);
>+	rcu_read_unlock();
>+
>+	/* Local mode is supported only when no G2H device is present. */
>+	return vsock ? false : true;
>+}
>+
> /* Caller need to hold vsock->tx_lock on vq */
> static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
> 				     struct virtio_vsock *vsock, gfp_t gfp)
>@@ -544,6 +556,7 @@ static struct virtio_transport virtio_transport = {
> 		.module                   = THIS_MODULE,
>
> 		.get_local_cid            = virtio_transport_get_local_cid,
>+		.supports_local_mode      = virtio_transport_supports_local_mode,
>
> 		.init                     = virtio_transport_do_socket_init,
> 		.destruct                 = virtio_transport_destruct,
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 7eccd6708d66..da7c52ad7b2a 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -2033,6 +2033,12 @@ static u32 vmci_transport_get_local_cid(void)
> 	return vmci_get_context_id();
> }
>
>+static bool vmci_transport_supports_local_mode(void)
>+{
>+	/* Local mode is supported only when no device is present. */
>+	return vmci_transport_get_local_cid() == VMCI_INVALID_ID;

IIRC vmci can be registered both as H2G and G2H, so should we filter out
the H2G case?

Also, IMO is better to use VMADDR_CID_ANY with get_local_cid().

>+}
>+
> static struct vsock_transport vmci_transport = {
> 	.module = THIS_MODULE,
> 	.init = vmci_transport_socket_init,
>@@ -2062,6 +2068,7 @@ static struct vsock_transport vmci_transport = {
> 	.notify_send_post_enqueue = vmci_transport_notify_send_post_enqueue,
> 	.shutdown = vmci_transport_shutdown,
> 	.get_local_cid = vmci_transport_get_local_cid,
>+	.supports_local_mode = vmci_transport_supports_local_mode,
> };
>
> static bool vmci_check_transport(struct vsock_sock *vsk)
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 8722337a4f80..1e25c1a6b43f 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -26,6 +26,11 @@ static u32 vsock_loopback_get_local_cid(void)
> 	return VMADDR_CID_LOCAL;
> }
>
>+static bool vsock_loopback_supports_local_mode(void)
>+{
>+	return true;
>+}
>+
> static int vsock_loopback_send_pkt(struct sk_buff *skb)
> {
> 	struct vsock_loopback *vsock = &the_vsock_loopback;
>@@ -58,6 +63,7 @@ static struct virtio_transport loopback_transport = {
> 		.module                   = THIS_MODULE,
>
> 		.get_local_cid            = vsock_loopback_get_local_cid,
>+		.supports_local_mode	  = vsock_loopback_supports_local_mode,
>
> 		.init                     = virtio_transport_do_socket_init,
> 		.destruct                 = virtio_transport_destruct,
>
>-- 
>2.47.3
>


