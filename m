Return-Path: <netdev+bounces-249219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9D8D15D2F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 00:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD96C301D607
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 23:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B42BE632;
	Mon, 12 Jan 2026 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLsM2Q0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54193238178
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768260876; cv=none; b=tOTEwb9aETnuj6hWESZDwW/HMT1sd6z8iyYb83TQrzIrpZ5jqVN5jZTwuTb7mFP08xvt81I42raNrjh0o4eW6kcS8u54YPCafCUDXpKfVQk2PRaOVnt74zivZORLZySfmnljx+1Zjs0A7L7YLFmDXXiBFTYVhmtrmnw1j1YNUhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768260876; c=relaxed/simple;
	bh=ciALBiXpEllKNFFriaJFGexCh1jC8WmBZIOo2yR764A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDvZLlAlmu63XOmG3iS/ejo2TDA+5E4k7Hl1jUoFOqOkhI1XmGOrkNeH+XEX0zJdZLFvGiL4E8kzOw8JKTXE2pI0mCOjjcRMbrLNb3Azr1Qso0AUh/zwqXH/3E6RVb9l3iS7NqBVw+Pe8ED4JutPT+0ok3f39A1OeqDx2z7VeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLsM2Q0v; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79275e61c2cso21403077b3.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768260873; x=1768865673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lU3GpweyZ8RZOMAzOI1qx6iERtUR7NcEkRCk8jZG9C4=;
        b=GLsM2Q0vk2Ks1InFDU1aFAEOW3ml3VNM9MPHGwUKpiJk0yG09otzeKJzwx4w/9goq7
         jo3fNI85FbzAVRmFLtt4ki8HFOUAGMRd6iYvuwBhn1lvG8+lq/POhLuzSooUzN/MfvJ6
         pB720rbU4eLMxBKnD33+SKhGK7A7vpVunyg+n05qSwXyww6TX/J9SdAPdfL+MQuVWwqJ
         nIO0QDTvsFr4yI6oJW3exxkP2wPuwefKXH7M0DRY2lJeepeE+Bcc+g/EujrtWyozG0QE
         q/FjwbmotSJZzAsn42J7rQvb1W++aoewfBc3JaOFoyIqgc7nI8PDPCGUGrHEoshcQQH3
         exPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768260873; x=1768865673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU3GpweyZ8RZOMAzOI1qx6iERtUR7NcEkRCk8jZG9C4=;
        b=tnjOlBZwqnbEYVd80Rv1JIh75QVcaiC2tQNaFZYNmn40uMP4BqcgqbMJ97GzZsHxbb
         GABZtOMN8a6U/1E1zt3Bgss0BSf+eNs4m1DrWzzXQZcOf+/dOMHWKJdB447WHkeHwIRu
         SWVHxZTuEs3YjBF9q927/gGKi1cQpTGJ5b9cQgfz66c1xMIC1Irs9RxR0Aie7dHaAN2z
         jWhBrb8SSlX1SijPmPO+bWTjKnbokttXABtarl4EznjgJxV5R3VmzSbEEo7jMAHdi4tG
         l4RxkCmXHlR6Q5MRTVwpju7ieRPoTKB2Um70hPaOL5gz0J+LtGP/+ULwbzkMZ5mu/0No
         ej+w==
X-Forwarded-Encrypted: i=1; AJvYcCVqzaCzr1Ss79V8deea4BjiF2RHnCgiqdGyPe4hafSIhbZ80hBuZocNfO6E2bjzosOU8t4WU7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxays+eEfmvXecktabwALztPB1FZQLKDofTmfnSAQdKXOYKk7Eh
	k1K0Z8l7N0EqrPJYVuXBJ/Lw3lbuRr0uVmb0jpHyJ7BOs4MRZ9lM+/Sz
X-Gm-Gg: AY/fxX7cdSKDh/4JsePQDzaG0fVB9gXRE1zcyYoumgiSQYrRU18CvDLxTrTX9EJe4Wl
	tv6Ol/9KftY+lnGCi3gv7MHk1azd0Cho42wANbTqOZqgzuZJzvwSxJLvP7Tvcu/zGYFkFsZRQQj
	Ih4lUdK3YfRsVweHi9migFawoMKhPBnuv82n19JlPEwhBi+DiQQAs91oijhFqJr6wOiYOAooEaO
	tmxykmWfAufkIl4o/RU+qVsm7KGPPPF08dOQ5mmAUYgDhc44MqjpWI07hA+2SboCWlacsVaxdvi
	38TVPQx/fZIkJ59jBRtw5Bdkvb1G4BdJvqVwHbS5sA8Vt16gsRJQmqmqO7DqNoMRua7xSEOStVx
	wk6P/nDvrKu9E2zhKS+8+cLIMiWl9xT1wFwoacCCCYXQMreGw6j0wr+39P6dIJZ7mImAFi+gd1Q
	/L8mzWFRumQcGfZbDxfTKK2v6/mw7dZFE7tw==
X-Google-Smtp-Source: AGHT+IFhnnLo9DObqpMPdGqLw+yvW/DLOUbdTMJjsPRgCKmDKj2orYWmy7Hu/cmK9w1YD06BNt4rZg==
X-Received: by 2002:a53:c0c9:0:b0:63f:9928:3f85 with SMTP id 956f58d0204a3-64716c61192mr12174478d50.62.1768260873367;
        Mon, 12 Jan 2026 15:34:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80d2c2sm8665513d50.8.2026.01.12.15.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:34:33 -0800 (PST)
Date: Mon, 12 Jan 2026 15:34:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
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
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 02/13] vsock: add netns to vsock core
Message-ID: <aWWFB2K5H5OXGWP8@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>
 <20260111013536-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111013536-mutt-send-email-mst@kernel.org>

On Sun, Jan 11, 2026 at 01:43:37AM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 04:28:36PM -0800, Bobby Eshleman wrote:
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
> > 
> > dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> > modified to take a vsk in order to perform logic on namespace modes. In
> > future patches, the net will also be used for socket
> > lookups in these functions.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> ...
> 
> 
> >  static int __vsock_bind_connectible(struct vsock_sock *vsk,
> >  				    struct sockaddr_vm *addr)
> >  {
> > +	struct net *net = sock_net(sk_vsock(vsk));
> >  	static u32 port;
> >  	struct sockaddr_vm new_addr;
> >
> 
> 
> Hmm this static port gives me pause. So some port number info leaks
> between namespaces. I am not saying it's a big security issue
> and yet ... people expect isolation.

Probably the easiest solution is making it per-ns, my quick rough draft
looks like this:

diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index e2325e2d6ec5..b34d69a22fa8 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -11,6 +11,10 @@ enum vsock_net_mode {
 
 struct netns_vsock {
 	struct ctl_table_header *sysctl_hdr;
+
+	/* protected by the vsock_table_lock in af_vsock.c */
+	u32 port;
+
 	enum vsock_net_mode mode;
 	enum vsock_net_mode child_ns_mode;
 };
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9d614e4a4fa5..cd2a47140134 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -748,11 +748,10 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 				    struct sockaddr_vm *addr)
 {
 	struct net *net = sock_net(sk_vsock(vsk));
-	static u32 port;
 	struct sockaddr_vm new_addr;
 
-	if (!port)
-		port = get_random_u32_above(LAST_RESERVED_PORT);
+	if (!net->vsock.port)
+		net->vsock.port = get_random_u32_above(LAST_RESERVED_PORT);
 
 	vsock_addr_init(&new_addr, addr->svm_cid, addr->svm_port);
 
@@ -761,11 +760,11 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 		unsigned int i;
 
 		for (i = 0; i < MAX_PORT_RETRIES; i++) {
-			if (port == VMADDR_PORT_ANY ||
-			    port <= LAST_RESERVED_PORT)
-				port = LAST_RESERVED_PORT + 1;
+			if (net->vsock.port == VMADDR_PORT_ANY ||
+			    net->vsock.port <= LAST_RESERVED_PORT)
+				net->vsock.port = LAST_RESERVED_PORT + 1;
 
-			new_addr.svm_port = port++;
+			new_addr.svm_port = net->vsock.port++;
 
 			if (!__vsock_find_bound_socket_net(&new_addr, net)) {
 				found = true;



Not as nice, but not necessarily horrid. WDYT?

Best,
Bobby

