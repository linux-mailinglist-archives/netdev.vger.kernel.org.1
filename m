Return-Path: <netdev+bounces-248778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEA6D0E1C2
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 07:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1268030022D0
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 06:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAAB23ED6A;
	Sun, 11 Jan 2026 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLeFzX7s";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g24Dq8GI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053B23A99E
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768113829; cv=none; b=jl0XXi/ylqEdBVmOXn59JuDj3KvASC9eo0gbvL8QTAr+MroK8rMcwuCwYz744dw4X1vw8IBzin5Mt+6COYEZgQvE9aUK8V12+A8OWCHGMQrGkguBP99r3QUPONDp5GDbLfpFFJXRQ9LkdUKsb10d0stuqTljvQtdFpYfq99udr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768113829; c=relaxed/simple;
	bh=JD9UEMV2ESqXFzdZlTaAIe3B3dw0Y3l06h1cl/AHTH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVAnFRbt4UekTP1mYnBtdOBiC4LjwdrkcJ0kx7ouO2RJqIIAL1GJjskkk0HoDlPtDyKyXkIxjaa2I/3H5zIXsF7E/GcUj9kEyXd9mcfjEfax3xWBFFELN7WulfmGgWcl+O2fc2LMek/yRcb/fTecC+d42QaTPOETfp4+QwdZEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLeFzX7s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g24Dq8GI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768113826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6/EDkpRsLZ7JjY4jSYMGAe1PlTU/1r9sRvOnftJVsA=;
	b=dLeFzX7s1KfXCThlMAbJQUdNSrHlutXvcDV8IcYSzIjkRXN2eMq4QmHfZcaqBUrTiuzA7+
	3XJSbe7EeNWAZxzB97ar0b1yUyi3NqNwXkmxudv8BL3CYHxLQ+7vm1IhjG/dbmc100KgV4
	xplCku2K15NeHWRItWUWVoQh7Ra4Hbk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-W0JEm9K9P0mgbvs3cdbTUQ-1; Sun, 11 Jan 2026 01:43:45 -0500
X-MC-Unique: W0JEm9K9P0mgbvs3cdbTUQ-1
X-Mimecast-MFC-AGG-ID: W0JEm9K9P0mgbvs3cdbTUQ_1768113822
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477cf25ceccso49828115e9.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 22:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768113822; x=1768718622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6/EDkpRsLZ7JjY4jSYMGAe1PlTU/1r9sRvOnftJVsA=;
        b=g24Dq8GIUvts4DaC5ph6QFJy/aBstxBJB+Nvd9BT6OY2C5pYYDJ/hNV30FZ9stNLcx
         ATuC8RKgwwQBxiR4f/8wsYWvZ9WE/jR0ksPQ82Qx8p9etROqBDv8IcMUXNkfxirNUMZb
         LIWOSDgMYxgdqZFXlgRzr9qT+Ou/Twwlkz9EtH3Wfutw+Vz+hChXMqayRYtn+h9Eo0eq
         zZBC3I6MPUcg498CxN3EqRysj51y4mE7eboib8NKj2zZelgUwJzl/4YK6EuQkMv2JIoV
         ggfs8jrGy2f3WcIX1i+aMsF87N0iVLhUjfxGqPgsEprXxd80fz5K8jNXnEHGzp2f0s1E
         bGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768113822; x=1768718622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6/EDkpRsLZ7JjY4jSYMGAe1PlTU/1r9sRvOnftJVsA=;
        b=D2cvnvMn6oK7It1AAZrJ1+p2Wppkucqih0z5SZwn4PhAKcixXGwy/LdXRXPx6LAL7H
         eqyMlP2q/B5HDJRdKs+Su7e1t9/SyUbjGFT4rchm5RSmRWENwf3vLCpygp8J7atXxPlZ
         P8t1iHKd4U3dZ5X8SzEIB603JEFRcC3X8RE0JZad9cK0k+ifMCV5zCiWEeLOuyfxDJ1Z
         bqeSft1jUUma/pDCXDtVum4SdYYADROD3CTxq/Iay0faezZBxrNDHYrBl4QFM9ZBEfvO
         GZq4cDwHHFd6EfAEDq2oqpud18UlwNJ6LTUp+OWVTqQxDs3nz5DjGxOznJcR0a3exM4G
         omdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnbyFDp4XNhhntVUVtrms5by55b+4b+lBIYJRzobrM5haLth5IvqI9QkU/Lp6aLyyDQ2TEnP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNeXDlku++N4bkMVZbbrBmNA5i2jT0iNv0XVjQa+AaAPEs3hsj
	F2Ybs/7jRtrGQNAxZ9vNFbfu/eJkVzmLbDOPQJIdwIOPu1JXjUPCql5glW2tQQz570aPV1ToSEP
	vXEadyJXm+H/+8AQXH8AB4JGLVQNHe+1CZbWRAiAa2iQR/ATOWgpljgxUrA==
X-Gm-Gg: AY/fxX4L9UIS6tiGKSLT7yuDIPD2jSlTeBeGN10V3/8nbjfVByzhXnyZofz035jO9Eh
	qqu/lb1uKIuervMie9uemDeip4/gV9PucuG4qyP2IHx0Uxe0wt7YSd3YYGC2RbestMKALv3QNKB
	y4Fl/o7d/956sPV5MmAu3IbYhkz2WpDeRSRBTqsxD1jxxpgdpUp8OVUFOIVDIf+lz6/uNGaiDmt
	QyPXkxiMvUQrkpYEYKAK3ETmN+V/bCtc/vPK94TGbBzKXKEwD5sE2pEV6IH7dr4IgO2YP2mpVB6
	9n8zsriEeSVlENXyu56CQUxNW0zDhrtvmJJDt9/VUQaKWHCndqARxdSwp5YCObPRRY/q/N50PMZ
	LdntaSuNI4gbUJAuuApNH1BIoD7jng1Q=
X-Received: by 2002:a05:600c:190e:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47d84b1faffmr173261245e9.9.1768113822028;
        Sat, 10 Jan 2026 22:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFprQahh0jRaFJb4VDDWHvHnytv+WdXNUVMhHUBmCAuMZpoJ/VdEFWzP+x0Gcih4TrON/Ayw==
X-Received: by 2002:a05:600c:190e:b0:477:9aeb:6a8f with SMTP id 5b1f17b1804b1-47d84b1faffmr173260995e9.9.1768113821580;
        Sat, 10 Jan 2026 22:43:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef885sm284657415e9.9.2026.01.10.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 22:43:41 -0800 (PST)
Date: Sun, 11 Jan 2026 01:43:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
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
Message-ID: <20260111013536-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>

On Tue, Dec 23, 2025 at 04:28:36PM -0800, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add netns logic to vsock core. Additionally, modify transport hook
> prototypes to be used by later transport-specific patches (e.g.,
> *_seqpacket_allow()).
> 
> Namespaces are supported primarily by changing socket lookup functions
> (e.g., vsock_find_connected_socket()) to take into account the socket
> namespace and the namespace mode before considering a candidate socket a
> "match".
> 
> This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> for new namespaces.
> 
> Add netns functionality (initialization, passing to transports, procfs,
> etc...) to the af_vsock socket layer. Later patches that add netns
> support to transports depend on this patch.
> 
> dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> modified to take a vsk in order to perform logic on namespace modes. In
> future patches, the net will also be used for socket
> lookups in these functions.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

...


>  static int __vsock_bind_connectible(struct vsock_sock *vsk,
>  				    struct sockaddr_vm *addr)
>  {
> +	struct net *net = sock_net(sk_vsock(vsk));
>  	static u32 port;
>  	struct sockaddr_vm new_addr;
>


Hmm this static port gives me pause. So some port number info leaks
between namespaces. I am not saying it's a big security issue
and yet ... people expect isolation.


-- 
MST


