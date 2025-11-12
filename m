Return-Path: <netdev+bounces-238016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F6C52BD9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED34B3B0AC6
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BD33D6D2;
	Wed, 12 Nov 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="becGPe6f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O85DX5AX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698833D6C3
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957315; cv=none; b=Fy4FXod+wh+7uCtlcfHrPPYkGUBI0FzuswLUrbTuEEOorun+wlnl4gNfKhTXz7DfmXO8Pb8ntBb5L5qC/cxFkMvqZxUEP9tRpLPUj1ytiAj9W7dDUI+Y3B30sHeXtlGSLh+GB6NuX+Bg3O6UoWd8hj3H82C/IUNtHHGGu5S/6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957315; c=relaxed/simple;
	bh=lN4RRdyXEFU2ATERJYxJeFTOwDwQPwcnJw8cv+BPlCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYaz0DnGBd2NZlflmX8ChnfuFJL1bQ3deEFNm8Gf2sMcy930IQEf3NEnIQTdylGA1tt1lmi2rntKOmRfNJZ/QV1lQ3X924+vwS//ZXTVTqEjx9BLrMsDjd7/OSVBzjpvIDOUPR216aVAKEcPxqJohxerBwO3VpiHi/b6kJnci0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=becGPe6f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O85DX5AX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762957312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hcUR1jMc/lixBGzLd81I+JyVT1RQh3JZhqcvVnMuZIg=;
	b=becGPe6f0nyGeXFROQSKipYAKuw3RgRrVuNrMs8MvSUBRIF3Aqkya5HWSdm/iAbNBq+0UU
	XwvHPG7Gr1plDloO4xy+7bDBN8+VRdf2pjnUp0cdJXPHO5H6RyaGZ/i3vX8xXtHDhUJRva
	Q7IEuDek84zCuACNtMFjFjzuM9opPi0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-71fgOplUPSO3M3NGiOokyA-1; Wed, 12 Nov 2025 09:21:51 -0500
X-MC-Unique: 71fgOplUPSO3M3NGiOokyA-1
X-Mimecast-MFC-AGG-ID: 71fgOplUPSO3M3NGiOokyA_1762957310
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edae6297a2so32999651cf.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 06:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762957310; x=1763562110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcUR1jMc/lixBGzLd81I+JyVT1RQh3JZhqcvVnMuZIg=;
        b=O85DX5AXyOl2TXA2LVUpHkws2IFlP5mmi9ghxZEG6gHvzmajUeOqOIvb1aQbwZzmCI
         Op1zHmSOYzMhR5JoSnA8GNAE2WW41OLrUWkkakh4Aeafp9JrYbcS5DgZUoQzcXISEkiW
         ImKfBW+NQz0VWY95tjTnNkv+M8E0PH/viTea4GVBQz0wM4uyfNLCAdGAWCwun1jwqsKi
         59EDoPEwneEwJC/O44tQWeAQV5azqNgmQmIUmIcwxHNsrg17BKmHRM67jj2Pk6rmcDoo
         Ba2SOvKGJrTnL1KMtx6X52WvW9DvpCTEFSXi70KiEqgDoJII/ksUkyfXkJe3p4OfPTmS
         p/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762957310; x=1763562110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcUR1jMc/lixBGzLd81I+JyVT1RQh3JZhqcvVnMuZIg=;
        b=GZngjFiq9xfXkC7Q3DVdP161TndO7c7Q48qkIo0dCVdzP/0QvXW8gvUD6il8UOzXJ4
         JLN2Nw34DI71E/tLUgiousgcCexAAklRRIdpaeecIThiRiamMOdaH1WBU8mavkGYCx05
         sj/TF8NtTJFq7L09p2SvGd28nT6GSO9+XwaS0CnZndx9Xi+qoryT7be0z2aY10hI5odN
         ykVzpDLRGUak1a3qfn25MfMpDiwwwbLogKAa6TDjg2XRwKfazKwqybiJR1YhgcOF7EUM
         l4bnolvbUNt3sQKqo1vwB4P3SpK65ZZOwkWNzfLjRarwrgo9tYoEMBP6PRkf66tWOJQy
         FLjA==
X-Forwarded-Encrypted: i=1; AJvYcCXzr8pgUHKpwuYCrhu0dRDlMHW7C2BKw1KQvb2Kek3FyFwHs53c98rEfCamoMZZH2V+MISQbjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfsqnObq+kGJ3yMAN3Sv1eQpWIhfVgjp55pNbbaHJh7WFQ7o8
	XKgXyba/Ym1fGt5OoQPQACvLDwmOv1Mrx0BEGio7uGg9JVrBM0jtsYs12rrbjgmeasmOQ9NKdRG
	IFK1TUF7bagILAbult9M3D2dwr/Sc1FnfsaYXzMm5y9apwtK9dtfDvitNAQ==
X-Gm-Gg: ASbGncvJLewe97DXFPfFbk1KZxgn1E9CBEsmUfYeyum149Rm79GQgs7V2mEgG8Z9Jao
	cVTi/pJ32tOqnWDEu63pfhX/0k5nTYzCYqr0OV8Ekpevx2YeEezWvCsmOX1+D7JwIfOYFRsqlVz
	NEIcE13dzOaD9IFKnYMouVhKFCkXhCVM7lskqSf7Bx4c/3lO93IIccoihSbJE/z3feiph2+WNgO
	OR+UO7Y66+Lsl+vVP8qYXECcvrRmK+/YGlhffLKRvgje91c44Xf2HwYhRwd9+vA2XII9SlvJwOf
	8limbrD29LCeUp+wNtIBZjayeELBoakBd2dqD8CcBdKWTLLCf3NHpOsxKel6LcB0nniBTlZ7kBa
	HRpMK57KBCSzrz6JPDUmSEVOMYwj0mxUZMdbgXVYFat66XfOwEc8=
X-Received: by 2002:ac8:5845:0:b0:4eb:a3e1:8426 with SMTP id d75a77b69052e-4eddbe14abemr40231061cf.84.1762957310220;
        Wed, 12 Nov 2025 06:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkOKYuFy3HjHtsK18IyyLMWJPS+qaeCfNjTdaJqA21tqIMrUz0QQaXD4DwryQa4PrhG/QPGA==
X-Received: by 2002:ac8:5845:0:b0:4eb:a3e1:8426 with SMTP id d75a77b69052e-4eddbe14abemr40230261cf.84.1762957309611;
        Wed, 12 Nov 2025 06:21:49 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda56133d5sm86249391cf.4.2025.11.12.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:21:49 -0800 (PST)
Date: Wed, 12 Nov 2025 15:21:39 +0100
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
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 08/14] vsock: reject bad VSOCK_NET_MODE_LOCAL
 configuration for G2H
Message-ID: <ureyl5b2tneivmlce4fdtmuoxgayfxwgewoypb6oyxeh7ozt3i@chygpr2uvtcp>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-8-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251111-vsock-vmtest-v9-8-852787a37bed@meta.com>

On Tue, Nov 11, 2025 at 10:54:50PM -0800, Bobby Eshleman wrote:
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
>support local mode because there is no G2H (e.g., virtio-vsock) device
>detected. This enables using the same kernel in the host and in the
>guest, as we do in kselftest.
>
>Systems with only namespace-aware transports (vhost-vsock, loopback) can
>still use both VSOCK_NET_MODE_GLOBAL and VSOCK_NET_MODE_LOCAL modes as
>intended.
>
>The hyperv transport must be treated specially. Other G2H transports can
>can report presence of a device using get_local_cid(). When a device is
>present it returns a valid CID; otherwise, it returns VMADDR_CID_ANY.
>THe hyperv transport's get_local_cid() always returns VMADDR_CID_ANY,
>however, even when a device is present.
>
>For that reason, this patch adds an always_block_local_mode flag to
>struct vsock_transport. When set to true, VSOCK_NET_MODE_LOCAL is
>blocked unconditionally whenever the transport is registered, regardless
>of device presence. When false, LOCAL mode is only blocked when
>get_local_cid() indicates a device is present (!= VMADDR_CID_ANY).
>
>The hyperv transport sets this flag to true to unconditionally block
>local mode. Other G2H transports (virtio-vsock, vmci-vsock) leave it
>false and continue using device detection via get_local_cid() to block
>local mode.
>
>These restrictions can be lifted in a future patch series when G2H
>transports gain namespace support.

IMO this commit should be before supporting namespaces in any device,
so we are sure we don't have commits where this can happen.

>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/net/af_vsock.h           |  8 +++++++
> net/vmw_vsock/af_vsock.c         | 45 +++++++++++++++++++++++++++++++++++++---
> net/vmw_vsock/hyperv_transport.c |  1 +
> 3 files changed, 51 insertions(+), 3 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index cfd121bb5ab7..089c61105dda 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -108,6 +108,14 @@ struct vsock_transport_send_notify_data {
>
> struct vsock_transport {
> 	struct module *module;
>+	/* If true, block VSOCK_NET_MODE_LOCAL unconditionally when this G2H
>+	 * transport is registered. If false, only block LOCAL mode when
>+	 * get_local_cid() indicates a device is present (!= VMADDR_CID_ANY).
>+	 * Hyperv sets this true because it doesn't offer a callback that
>+	 * detects device presence. This only applies to G2H transports; H2G
>+	 * transports are unaffected.
>+	 */
>+	bool always_block_local_mode;
>
> 	/* Initialize/tear-down socket. */
> 	int (*init)(struct vsock_sock *, struct vsock_sock *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index c0b5946bdc95..a2da1810b802 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -91,6 +91,11 @@
>  *   and locked down by a namespace manager. The default is "global". The mode
>  *   is set per-namespace.
>  *
>+ *   Note: LOCAL mode is only supported when using namespace-aware transports
>+ *   (vhost-vsock, loopback). If a guest-to-host transport (virtio-vsock,
>+ *   hyperv-vsock, vmci-vsock) is loaded, attempts to set LOCAL mode will fail
>+ *   with EOPNOTSUPP, as these transports do not support per-namespace 
>isolation.
>+ *
>  *   The modes affect the allocation and accessibility of CIDs as follows:
>  *
>  *   - global - access and allocation are all system-wide
>@@ -2757,12 +2762,30 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
> 		if (*lenp >= sizeof(data))
> 			return -EINVAL;
>
>-		if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data)))
>+		if (!strncmp(data, VSOCK_NET_MODE_STR_GLOBAL, sizeof(data))) {
> 			mode = VSOCK_NET_MODE_GLOBAL;
>-		else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data)))
>+		} else if (!strncmp(data, VSOCK_NET_MODE_STR_LOCAL, sizeof(data))) {
>+			/* LOCAL mode is not supported when G2H transports
>+			 * (virtio-vsock, hyperv, vmci) are active, because
>+			 * these transports don't support namespaces. We must
>+			 * stay in GLOBAL mode to avoid bind/lookup mismatches.
>+			 *
>+			 * Check if G2H transport is present and either:
>+			 * 1. Has always_block_local_mode set (hyperv), OR
>+			 * 2. Has an actual device present (get_local_cid() != VMADDR_CID_ANY)
>+			 */
>+			mutex_lock(&vsock_register_mutex);
>+			if (transport_g2h &&
>+			    (transport_g2h->always_block_local_mode ||
>+			     transport_g2h->get_local_cid() != VMADDR_CID_ANY)) {

This seems almost like a hack. What about adding a new function in the 
transports that tells us whether a device is present or not and 
implement it in all of them?

Or a more specific function to check if the transport can work with 
local mode (e.g.  netns_local_aware() or something like that - I'm not 
great with nameming xD)

>+				mutex_unlock(&vsock_register_mutex);
>+				return -EOPNOTSUPP;
>+			}
>+			mutex_unlock(&vsock_register_mutex);

What happen if the G2H is loaded here, just after we release the mutex?

I suspect there could be a race that we may fix postponing the unlock 
after the vsock_net_write_mode() call.

WDYT?

> 			mode = VSOCK_NET_MODE_LOCAL;
>-		else
>+		} else {
> 			return -EINVAL;
>+		}
>
> 		if (!vsock_net_write_mode(net, mode))
> 			return -EPERM;
>@@ -2909,6 +2932,7 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> {
> 	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
> 	int err = mutex_lock_interruptible(&vsock_register_mutex);
>+	struct net *net;
>
> 	if (err)
> 		return err;
>@@ -2931,6 +2955,21 @@ int vsock_core_register(const struct vsock_transport *t, int features)
> 			err = -EBUSY;
> 			goto err_busy;
> 		}
>+
>+		/* G2H sockets break in LOCAL mode namespaces because G2H transports
>+		 * don't support them yet. Block registering new G2H transports if we
>+		 * already have local mode namespaces on the system.
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
>index 432fcbbd14d4..ed48dd1ff19b 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -835,6 +835,7 @@ int hvs_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
>
> static struct vsock_transport hvs_transport = {
> 	.module                   = THIS_MODULE,
>+	.always_block_local_mode  = true,
>
> 	.get_local_cid            = hvs_get_local_cid,
>
>
>-- 
>2.47.3
>


