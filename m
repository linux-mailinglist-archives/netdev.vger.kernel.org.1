Return-Path: <netdev+bounces-265957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEzeHs/ir2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:22:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD824844A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F09EB3044670
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EE743D4F5;
	Tue, 10 Mar 2026 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQfUidPK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65043CEF0
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134343; cv=none; b=N23+3wWM8rF6gx2eTcPxM8+R+pzMNHIDNAnERI1aG9zCH2C0WTaZBDeeOXfw2XFXlU7LlTAzHpRjFK0kw+4ioYzEKS0NjOSbDWCgyJjFwGKjoxEFkForwIQYeO1bES7WsplT/8x3hbVmjKTXdwctvqODkIVR4rzPdvxJlZ57YwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134343; c=relaxed/simple;
	bh=8aiS45woyLbPObmU1neW/MDCFCbBy8+g/pFz7YT9EuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tv8F89PjE3GsfdVkLiuUPZpCxW9OwVMrXNJPR25OvBEmVBp4kxdnu0joZvK+2GtVDzy6YdCnTSBPY3auYKAUZsgvk/XGmPg3xrNCUXnjzmTJ42ayE3OdEXN+kCgbkBIpPIGq5M1jNsBiczx6v0aY0VGnrenLiMflGfQn1+S9tks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQfUidPK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773134341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iirFqLObvN+6/ZXe/vgKHSudbfwueXERpHlMHRXe7vo=;
	b=TQfUidPKaAHhp5PezcZ93EAkJKk/KFbX0IcjH/kd7/YNRHAtZOhEhMA0qi5BnZxNFywhiH
	R9PsTR+VXtU7eoX9Ol92u9gxP2dV19QLxMHYhmhDRKgCrYg3BmzfJc/mPX1SufxQENcS/7
	ay77TdAfnKiWlIDPiZKNinh9/cWttOQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-ljluigEEMzmIyrWzyiiH2w-1; Tue,
 10 Mar 2026 05:18:58 -0400
X-MC-Unique: ljluigEEMzmIyrWzyiiH2w-1
X-Mimecast-MFC-AGG-ID: ljluigEEMzmIyrWzyiiH2w_1773134336
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8828C1956094;
	Tue, 10 Mar 2026 09:18:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.133])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C2B530001A2;
	Tue, 10 Mar 2026 09:18:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: graf@amazon.com
Cc: vishnu.dasa@broadcom.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	arnd@arndb.de,
	netdev@vger.kernel.org,
	eperezma@redhat.com,
	gregkh@linuxfoundation.org,
	mst@redhat.com,
	jasowang@redhat.com,
	corbet@lwn.net,
	nh-open-source@amazon.com,
	bryan-bt.tan@broadcom.com,
	syzbot@syzkaller.appspotmail.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,v4] vsock: add G2H fallback for CIDs not owned by H2G transport
Date: Tue, 10 Mar 2026 10:18:43 +0100
Message-ID: <20260310091843.101237-1-pabeni@redhat.com>
In-Reply-To: <20260304230027.59857-1-graf@amazon.com>
References: <20260304230027.59857-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: F1AD824844A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265957-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
vsock: add G2H fallback for CIDs not owned by H2G transport

This commit enables G2H transport fallback for CIDs not claimed by the
H2G transport in environments like Nitro Enclaves. It adds a per-netns
sysctl net.vsock.g2h_fallback (default 1) and a has_remote_cid callback
for transports to declare CID ownership.

> The flag was introduced 6 years ago and I am still not aware of any tool

This isn't a bug, but the timing is slightly inaccurate.
VMADDR_FLAG_TO_HOST was introduced in commit caaf95e0f23f on 2020-12-14.
As of March 2026, this is approximately 5 years and 3 months, not 6
years.

> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 533d8e75f7bb..4e40063adab4 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -179,6 +179,15 @@ struct vsock_transport {
>  	/* Addressing. */
>  	u32 (*get_local_cid)(void);
>
> +	/* Check if this transport serves a specific remote CID.
> +	 * For H2G transports: return true if the CID belongs to a registered
> +	 * guest. If not implemented, all CIDs > VMADDR_CID_HOST go to H2G.
> +	 * For G2H transports: return true if the transport can reach arbitrary
> +	 * CIDs via the hypervisor (i.e. supports the fallback overlay). VMCI
> +	 * does not implement this as it only serves CIDs 0 and 2.
> +	 */
> +	bool (*has_remote_cid)(struct vsock_sock *vsk, u32 remote_cid);
> +

The G2H transport description doesn't mention a critical consequence: G2H
transports that do not implement has_remote_cid (like hyperv_transport)
will never receive fallback traffic even with g2h_fallback=1, because the
fallback branch in vsock_assign_transport() requires
transport_g2h->has_remote_cid to be non-NULL. Should the comment clarify
this requirement for G2H transports to participate in fallback?

[ ... ]

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index f0ab2f13e9db..cc4b225250b9 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -545,9 +545,13 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
>   * The vsk->remote_addr is used to decide which transport to use:
>   *  - remote CID == VMADDR_CID_LOCAL or g2h->local_cid or VMADDR_CID_HOST if
>   *    g2h is not loaded, will use local transport;
> - *  - remote CID <= VMADDR_CID_HOST or h2g is not loaded or remote flags field
> - *    includes VMADDR_FLAG_TO_HOST flag value, will use guest->host transport;
> - *  - remote CID > VMADDR_CID_HOST will use host->guest transport;
> + *  - remote CID <= VMADDR_CID_HOST or remote flags field includes
> + *    VMADDR_FLAG_TO_HOST, will use guest->host transport;
> + *  - remote CID > VMADDR_CID_HOST and h2g is loaded and h2g claims that CID,
> + *    will use host->guest transport;
> + *  - h2g not loaded or h2g does not claim that CID and g2h claims the CID via
> + *    has_remote_cid, will use guest->host transport (when g2h_fallback=1)
> + *  - anything else goes to h2g or returns -ENODEV if no h2g is available
>   */
>  int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>  {

The commit message states this patch extends the existing behavior: "When
no H2G transport is loaded, vsock currently routes all CIDs to the G2H
transport...Extend that existing behavior: when an H2G transport is loaded
but does not claim a given CID, the connection falls back to G2H in the
same way."

Does this accurately describe what the patch does?

> @@ -581,11 +585,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>  	case SOCK_SEQPACKET:
>  		if (vsock_use_local_transport(remote_cid))
>  			new_transport = transport_local;
> -		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
> +		else if (remote_cid <= VMADDR_CID_HOST ||
>  			 (remote_flags & VMADDR_FLAG_TO_HOST))
>  			new_transport = transport_g2h;
> -		else
> +		else if (transport_h2g &&
> +			 (!transport_h2g->has_remote_cid ||
> +			  transport_h2g->has_remote_cid(vsk, remote_cid)))
> +			new_transport = transport_h2g;
> +		else if (sock_net(sk)->vsock.g2h_fallback &&
> +			 transport_g2h && transport_g2h->has_remote_cid &&
> +			 transport_g2h->has_remote_cid(vsk, remote_cid)) {
> +			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
> +			new_transport = transport_g2h;
> +		} else {
>  			new_transport = transport_h2g;
> +		}
>  		break;

The old code had `!transport_h2g` in the second else-if condition at line
-583, which routed all CID > VMADDR_CID_HOST traffic to transport_g2h when
no H2G transport was loaded. The new code removes this check.

When transport_h2g is NULL (no H2G transport loaded) and the G2H transport
does not implement has_remote_cid (as is the case for VMCI and Hyper-V
transports), what happens?

The G2H fallback branch at line +596 requires
`transport_g2h->has_remote_cid` to be non-NULL. If it's NULL, the
short-circuit evaluation skips this branch and executes the final else at
line +601, setting `new_transport = transport_h2g` (which is NULL),
ultimately returning -ENODEV.

The commit message explicitly states the intent to preserve the existing
no-H2G fallback behavior. Does this implementation break it for G2H
transports that do not implement the new optional has_remote_cid callback?

This affects VMCI and Hyper-V environments: when no H2G transport is
loaded, CID > 2 connections that previously fell back to G2H now get
ENODEV.

[ ... ]

> @@ -2928,6 +2952,7 @@ static void vsock_net_init(struct net *net)
>  		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
>
>  	net->vsock.child_ns_mode = net->vsock.mode;
> +	net->vsock.g2h_fallback = 1;
>  }

Stefano Garzarella raised a question in v3 about the sysctl inheritance
policy for g2h_fallback: should it inherit from the parent namespace or
always default to 1 in all namespaces?

He cc'd net maintainers (Michael, Paolo, Jakub) for guidance:
https://lore.kernel.org/all/aahRzq5vS76rPI28@sgarzare-redhat/

The current code always defaults to 1 for all namespaces (including child
namespaces), which differs from how ns_mode is handled (which inherits
from parent). Was there a resolution to this question?

[ ... ]

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 77fe5b7b066c..57f2d6ec3ffc 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -547,11 +547,18 @@ bool virtio_transport_stream_allow(struct vsock_sock *vsk, u32 cid, u32 port)
>  static bool virtio_transport_seqpacket_allow(struct vsock_sock *vsk,
>  					     u32 remote_cid);
>
> +static bool virtio_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
> +{
> +	/* The CID could be implemented by the host. Always assume it is. */
> +	return true;
> +}
> +

The comment says "always assume it is" implemented by the host. Is this a
verifiable fact or a design choice?

The guest cannot know what CIDs the host or hypervisor can reach, so this
is a reasonable design choice. However, it also means all unclaimed CIDs
fall back to G2H when virtio is the G2H transport, which could silently
create host vsock traffic for typos or invalid CIDs.


