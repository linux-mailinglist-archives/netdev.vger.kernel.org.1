Return-Path: <netdev+bounces-252050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EiEMRRAcWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-252050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:07:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7F65DCF1
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBDA980261B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC0394474;
	Wed, 21 Jan 2026 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQeI1TkO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA8338929
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025041; cv=none; b=LEzFdMMifTnms6+PY/oQeu17VUitPz1FieJELLF1WWW7ZHZ3RrhawX3KFhCFFLQcqN7i47gG7Dur8ePh5xoVu7GROYzT7HVdBhiGswj9gXg+d2s0wBIjpeWUMjRs6lCx+AFBtyu2kOoMFE6okiVQemllOYEbprQ0xVdlARrrwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025041; c=relaxed/simple;
	bh=Lu0kHih9UWQeJ+lp2O4spjT0NK81+eYFDqsV1ZmCcuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbTAvYswUa7WBJFJKyXpE9Orpb9Xom6zrlbRQMND6TAF073CePDoPCn8Kd9Rc75JrSHrlo1CRvvoQlyKOLJS7U6XE8DxiYB65dq+rn63Z2EJJRUP/nC46QtDqhYTUzgpMpxiV7iYD4HkQTMustmChHpJkoMTIWlT+rNX6wKC2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQeI1TkO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5013c912f9fso1694521cf.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 11:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769025038; x=1769629838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOPRZD47F8f143cIEqQqsk0mY0SdG+TC6tAqQjFOOoM=;
        b=FQeI1TkOQRxeoxjXaEohPw7B4A++uLWOYj6mmbUTr7cYCHcgpJjZRbsq3f5+fP3Jha
         XvqMzF1CF2giy6n5NspuuY+LiZr8JHqyjizWCadvm+smj2qxedlf5bUbGnqAxbbl57Sr
         fuRl11oCcNsIZN66xbvDMVw+J/bkuDQhONnBhZupk9e6XZMsMM3jMJTwCMqIaO7FfB6g
         X+oQiXXAIfMaXTJm/WfE7vJFFTfeUHWGbIE4sQFArPSjFKZqZrDgpcQRJ6qJzrdX2auT
         nmfYz6bY9YiF6rvdub3RJBD6m0tzWzzLGvHEc0biCAhNh/s2BugubgpkI4X3CM1iNJ8Y
         QggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769025038; x=1769629838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOPRZD47F8f143cIEqQqsk0mY0SdG+TC6tAqQjFOOoM=;
        b=MWJ4UpT4N5c+yi5fxBb9mdyHfarLhI0RZD+UYf6vl872bp8ygiNC0bE+7+FHFnH0ay
         Mvx9XbK++Xlo7zLGN4gfcl3NjVzI6F6fGnDmFO/Msasa6vnOWK+ccQrl7nwDWEGm7Duv
         XlgDCgMg/xA5LSMk81mVuPwP2cG6PjwdfO9/Wfugg4+HDfi3ehWnkXV6epFrunBi7Q5V
         8Y3MXubXJRaIJe7tNG93s6jj5tn248xGlF1bY/lbFFjPbvScsaIheLZzyTIz83TA+neZ
         OPcN+o8Vu3CRaftZ9Fy369PqMLqiI9SCEkAQoeDTLMCYAz3loxjSRK8l56w+fX5XplHx
         C9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTR2rca5bV7CyeE5V+9xGkgQNcoehdTWVzDWtz5wja9RcqJ/aUI/YanGQVOhAA7xk2dv2xrHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNdcKTDeddUnU+yNRds4sAZ1OdNxVBD9R1g5WW3mCZvN7TSkz
	z57bvDvFnXrzB4wDM8r4sPdbCtG58DcRWAdV8DtV5f6LPqato5huDdFVpOgh3Q==
X-Gm-Gg: AZuq6aJeS1aNtjxXzm6hSXwP4ndx5Qz1UWwma0HCIHjmBh3PdXuPLgmRq1G+L6a3QJA
	TRWzHkvi73KmBM4UEvv95I+VrCatvY3yW89FXuBtEJAWwdZ6Pm78tBodknujMZabAMYTBVX6UOn
	y7PL237JrDKvppJjK9m32Y1uLricADn/GetBwjHLjmwFOdnGx5fjLwYgH2s7GCIE8MCd9wkDBgH
	oIa72pMWSD47yEYohmrjD9gwTIZ8VMvJ6nraUed/j03T4SS8TxnYn/MBnC4N6C2vlnBchpoijUP
	9Vs7RiLG1ZQUC+2sbX2+v0o0at3dextDCk/osHTWwPMEgFsxxT3q7Ygkt1ouxcG5iymLJ1gK/mB
	OTI1z4WAZxaK1D/lPocRkm0N9oq99Ymi77n59HnoplL4m47fx+cQUitFVi0lnBmVx53WGHDHHyY
	IdMkGKCcEnWtN7af3A7+2AOJLHW1LHHX0fq8FxA546T/mjlg==
X-Received: by 2002:a05:690c:6089:b0:792:7113:a305 with SMTP id 00721157ae682-793c671a7f3mr146815807b3.29.1769017778141;
        Wed, 21 Jan 2026 09:49:38 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f6f97sm68737717b3.16.2026.01.21.09.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 09:49:37 -0800 (PST)
Date: Wed, 21 Jan 2026 09:49:36 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v15 01/12] vsock: add netns to vsock core
Message-ID: <aXERsFJLz9b9Fzce@devvm11784.nha0.facebook.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
 <20260116-vsock-vmtest-v15-1-bbfd1a668548@meta.com>
 <aXDYfYy3f1NQm5A0@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDYfYy3f1NQm5A0@sgarzare-redhat>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252050-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 6D7F65DCF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 03:48:13PM +0100, Stefano Garzarella wrote:
> On Fri, Jan 16, 2026 at 01:28:41PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add netns logic to vsock core. Additionally, modify transport hook
> > prototypes to be used by later transport-specific patches (e.g.,
> > *_seqpacket_allow()).
> > 
> > Namespaces are supported primarily by changing socket lookup functions
> > (e.g., vsock_find_connected_socket()) to take into account the socket
> > namespace and the namespace mode before considering a candidate socket a
> > "match".
> > 
> > This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> > report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> > for new namespaces.
> > 
> > Add netns functionality (initialization, passing to transports, procfs,
> > etc...) to the af_vsock socket layer. Later patches that add netns
> > support to transports depend on this patch.
> 
> nit: maybe we should mention here why we changed the random port allocation
> 
> (not a big deal, only if you need to resend)
> 
> > 
> > dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> > modified to take a vsk in order to perform logic on namespace modes. In
> > future patches, the net will also be used for socket
> > lookups in these functions.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v15:
> > - make static port in __vsock_bind_connectible per-netns
> > - remove __net_initdata because we want the ops beyond just boot
> > - add vsock_init_ns_mode kernel cmdline parameter to set init ns mode
> > - use if (ret || !write) in __vsock_net_mode_string() (Stefano)
> > - add vsock_net_mode_global() (Stefano)
> > - hide !net == VSOCK_NET_MODE_GLOBAL inside vsock_net_mode() (Stefano)
> > - clarify af_vsock.c comments on ns_mode/child_ns_mode (Stefano)
> > 
> > Changes in v14:
> > - include linux/sysctl.h in af_vsock.c
> > - squash patch 'vsock: add per-net vsock NS mode state' into this patch
> >  (prior version can be found here):
> >  https://lore.kernel.org/all/20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com/)
> > 
> > Changes in v13:
> > - remove net_mode and replace with direct accesses to net->vsock.mode,
> >  since this is now immutable.
> > - update comments about mode behavior and mutability, and sysctl API
> > - only pass NULL for net when wanting global, instead of net_mode ==
> >  VSOCK_NET_MODE_GLOBAL. This reflects the new logic
> >  of vsock_net_check_mode() that only requires net pointers (not
> >  net_mode).
> > - refactor sysctl string code into a re-usable function, because
> >  child_ns_mode and ns_mode both handle the same strings.
> > - remove redundant vsock_net_init(&init_net) call in module init because
> >  pernet registration calls the callback on the init_net too
> > 
> > Changes in v12:
> > - return true in dgram_allow(), stream_allow(), and seqpacket_allow()
> >  only if net_mode == VSOCK_NET_MODE_GLOBAL (Stefano)
> > - document bind(VMADDR_CID_ANY) case in af_vsock.c (Stefano)
> > - change order of stream_allow() call in vmci so we can pass vsk
> >  to it
> > 
> > Changes in v10:
> > - add file-level comment about what happens to sockets/devices
> >  when the namespace mode changes (Stefano)
> > - change the 'if (write)' boolean in vsock_net_mode_string() to
> >  if (!write), this simplifies a later patch which adds "goto"
> >  for mutex unlocking on function exit.
> > 
> > Changes in v9:
> > - remove virtio_vsock_alloc_rx_skb() (Stefano)
> > - remove vsock_global_dummy_net, not needed as net=NULL +
> >  net_mode=VSOCK_NET_MODE_GLOBAL achieves identical result
> > 
> > Changes in v7:
> > - hv_sock: fix hyperv build error
> > - explain why vhost does not use the dummy
> > - explain usage of __vsock_global_dummy_net
> > - explain why VSOCK_NET_MODE_STR_MAX is 8 characters
> > - use switch-case in vsock_net_mode_string()
> > - avoid changing transports as much as possible
> > - add vsock_find_{bound,connected}_socket_net()
> > - rename `vsock_hdr` to `sysctl_hdr`
> > - add virtio_vsock_alloc_linear_skb() wrapper for setting dummy net and
> >  global mode for virtio-vsock, move skb->cb zero-ing into wrapper
> > - explain seqpacket_allow() change
> > - move net setting to __vsock_create() instead of vsock_create() so
> >  that child sockets also have their net assigned upon accept()
> > 
> > Changes in v6:
> > - unregister sysctl ops in vsock_exit()
> > - af_vsock: clarify description of CID behavior
> > - af_vsock: fix buf vs buffer naming, and length checking
> > - af_vsock: fix length checking w/ correct ctl_table->maxlen
> > 
> > Changes in v5:
> > - vsock_global_net() -> vsock_global_dummy_net()
> > - update comments for new uAPI
> > - use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
> > - add prototype changes so patch remains c)mpilable
> > ---
> > Documentation/admin-guide/kernel-parameters.txt |  14 +
> > MAINTAINERS                                     |   1 +
> > drivers/vhost/vsock.c                           |   6 +-
> > include/linux/virtio_vsock.h                    |   4 +-
> > include/net/af_vsock.h                          |  61 ++++-
> > include/net/net_namespace.h                     |   4 +
> > include/net/netns/vsock.h                       |  21 ++
> > net/vmw_vsock/af_vsock.c                        | 328 ++++++++++++++++++++++--
> > net/vmw_vsock/hyperv_transport.c                |   7 +-
> > net/vmw_vsock/virtio_transport.c                |   9 +-
> > net/vmw_vsock/virtio_transport_common.c         |   6 +-
> > net/vmw_vsock/vmci_transport.c                  |  26 +-
> > net/vmw_vsock/vsock_loopback.c                  |   8 +-
> > 13 files changed, 444 insertions(+), 51 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index a8d0afde7f85..b6e3bfe365a1 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -8253,6 +8253,20 @@ Kernel parameters
> > 			            them quite hard to use for exploits but
> > 			            might break your system.
> > 
> > +	vsock_init_ns_mode=
> > +			[KNL,NET] Set the vsock namespace mode for the init
> > +			(root) network namespace.
> > +
> > +			global      [default] The init namespace operates in
> > +			            global mode where CIDs are system-wide and
> > +			            sockets can communicate across global
> > +			            namespaces.
> > +
> > +			local       The init namespace operates in local mode
> > +			            where CIDs are private to the namespace and
> > +			            sockets can only communicate within the same
> > +			            namespace.
> > +
> 
> My comment on v14 was more to start a discussion :-) sorry to not be clear.

No worries, resending with this included started a good discussion so
not for nil.

> 
> I briefly discussed it with Paolo in chat to better understand our policy
> between cmdline parameters and module parameters, and it seems that both are
> discouraged.
> 
> So he asked me if we have a use case for this, and thinking about it, I
> don't have one at the moment. Also, if a user decides to set all netns to
> local, whether init_net is local or global doesn't really matter, right?
> 
> So perhaps before adding this, we should have a real use case.
> Perhaps more than this feature, I would add a way to change the default of
> all netns (including init_net) from global to local. But we can do that
> later, since all netns have a way to understand what mode they are in, so we
> don't break anything and the user has to explicitly change it, knowing that
> they are breaking compatibility with pre-netns support.\
> 
> 
> That said, at this point, maybe we can remove this, documenting that
> init_net is always global, and if we have a use case in the future, we can
> add this (or something else) to set the init_net mode (or change the default
> for all netns).
> 
> Let's wait a bit before next version to wait a comment from Paolo or Jakub
> on this. But I'm almost fine with both ways, so:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> > 	vt.color=	[VT] Default text color.
> > 			Format: 0xYX, X = foreground, Y = background.
> > 			Default: 0x07 = light gray on black.
> 
> [...]
> 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index a3505a4dcee0..3fc8160d51df 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> 
> [...]
> 
> > @@ -235,33 +303,42 @@ static void __vsock_remove_connected(struct
> > vsock_sock *vsk)
> > 	sock_put(&vsk->sk);
> > }
> > 
> 
> In the v14 I suggested to add some documentation on top of the vsock_find*()
> vs vsock_find_*_net() to explain better which one should be used by
> transports.
> 
> Again is not a big deal, we can fix later if you don't need to resend.
> 
> Thanks,
> Stefano

Sorry about that slipping through the cracks, will add to v16.

I'll resend with:

1. revert init ns cmdline
2. update this message about why the port allocation changes
3. fix the vmtest missing ns arg bug that Kuba mentioned
4. update documentation on top of vsock_find* / vsock_find_*_net
5. update documentation on top of af_vsock.c w/ note about init_ns
having its mode fixed to global

Unless any prior feedback slipped, I think this captures everything
pending? 

Best,
Bobby

