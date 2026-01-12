Return-Path: <netdev+bounces-249220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB88BD15D4E
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 00:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76FC3300A1CB
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 23:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A444281370;
	Mon, 12 Jan 2026 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6MGA2bR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB922701CF
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261024; cv=none; b=KB5T5wdoDQpMbnxguXSxIqvx6YNPq5IOoKHaGXEhc7w037JeL9WZmrqvAm/CvoV5fQCNlRG4RViCKS4rA1kMdS6OGIjVNcA/Zg0gPKJQFQyCeMw7k9Zu+ShDiQD5aTbmXYCO15oomloXvBEpsmfZfzijlmo1Oaej4XO9UVP1stA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261024; c=relaxed/simple;
	bh=D/QOV+PvgeGDhnZ/ix6Fp2phNTxa9gFGlVxWZXZmAqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTRnmJXuhooB53n7tO5G+rxbEdRsnXkXHVDalCz1RbotaUTbXYXJhvd53NkVLN/BukOF4QjjtFH4Ygkrc9WrWAoCqYyQKoeY6iK31EhRMKo+Yh4BMP5kmbSC2rSyuf5I0oizqC2z6+R4Dvko6xJPMDGBY3bMoWxS6iDN3b8r3ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6MGA2bR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a35a00502so66006956d6.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768261022; x=1768865822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VrgEBLHMQ7w7z7OSk0+LmFxB5np8c3y6da/CYllo/d4=;
        b=M6MGA2bREGeeO1RJ7xzp5G/oBKW6AcYYN3fXSEBD/CQE0sSpnKBzpXcH4ib9izOFm2
         ZXBtq+J41EC21Aq9mmpwOu6Z5ABFhjxOGyd3kwRRW1tAG88o9RYzx3u4ZEyW1DSDKCZw
         Y0IQLsX4Enpb68GEC60UCk3imXTqBJ6ep7gzNZckKD8gXpcBLcv40gIVqZXVGL9M58Om
         wldaP+XwhFIJX/hepnbwrT3Yjec6GAbEhznWqPp7e8apsC7J6eZg1S+QQJUgySVJzA5O
         TO9pvqDx3VEgmDQzGs+jHdn6F0EfKoxuZDJtEcFJPICv6RiKj8SgmqU/OMwNUNI1zwkB
         o6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768261022; x=1768865822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrgEBLHMQ7w7z7OSk0+LmFxB5np8c3y6da/CYllo/d4=;
        b=MnnVMvJna2OwrMu3elJ4TtyUbbIOKJIicYu5T9/pDSRv4jnNmFxIMzXk+SeVTJXDKf
         1tGQvzhMN9DlpPbDEUuH5cERdWvTjB+cEp/IbZqPBVUylZLpQGfwCwxXqxi13S7c9qnm
         pS+4ho/VABS/9YMCm1CJjUkqhsMuH8Q4GXXzEqxIcbf22iedSCj0rLRj9eFvAXXlQuea
         gExAoIiAAlNzjY5QIN/PWZzyKw4NPEfJxUzwKqqXayXHjoi5B5nsKAKFr8ptSk06MDdf
         rDMQdaUOpwy/ul2BRrims735PwcmCdlnudiNxHuCJr14KpnJuOQAPvetcEEnIDtE/lAe
         /kkg==
X-Forwarded-Encrypted: i=1; AJvYcCUwwqWtXrsWdYJnDFJVgBBuzK0khGrtvSZtP61NRR2IpKxh0y+w5MLHd/UTpfy3j4ZjvcVBZ5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlux+kba406iDdTsQ9IWY1tVx58v/uwjEgkut+jD34Vi4yUvCq
	21uM74PIEqKyLqcDM5wCJ5sGeKBHH5B24OPYXwf82OUyMQFERL8N01NGWXMAfA==
X-Gm-Gg: AY/fxX5JqImCF+ceFeHdun2GxD9HqXvS+1+83kdYZxWraDau+Vj1fOfPB5kb3HQPMyM
	GsF9eiLqHLF7tJPPn6a9GFjbrSFE6QkdZdabPTKUNB4WSF+OqtprVMniKLp2VRpWU42sQ6yfIkh
	f4wVunRXzeoZF5fXKEZSSqtWIHEj9x3KV9uGArulLN8oSE8s/eEgh+/6l1fNj1YLl6qmo4KEUWX
	WW0EPnPiQjT1Cy417FcHX2Dm07hxd3Zt53Uq4inLN5ryK5rBmOHBiAdFdJgbtW+llgKpeUVd2K3
	le2LqSzzBd6IE/i6+e7gbG9w10Eqnn+6VeEgi/i8ndsUWx/M22yZ7ihGfD2KkJ2CbR40TPnFLo9
	wjLMKAR89pMcrwyCLuOy/qkGRoerzOKdfhSmUtu5/2E0s4YHmFJxAx6W/SnrXwioi+XaZMjMjyn
	2pywFAZu1f6VyoQG8F8JUMFIGlR5CL6im0bw==
X-Google-Smtp-Source: AGHT+IEEIChW46EWJZZzmGq0dv1aKbX23y4OJcSbpVgI4A7CpdyG+MDzyxvMqujhAfbDeFoADMp1dQ==
X-Received: by 2002:a53:e303:0:b0:63f:a727:8403 with SMTP id 956f58d0204a3-64716bd78d9mr12404043d50.38.1768254541320;
        Mon, 12 Jan 2026 13:49:01 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d7f7c04sm8530959d50.2.2026.01.12.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:49:00 -0800 (PST)
Date: Mon, 12 Jan 2026 13:48:58 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWVsSq7lORhM+prM@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
 <20260110191107-mutt-send-email-mst@kernel.org>
 <aWUnqbDlBmjfnC_Q@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWUnqbDlBmjfnC_Q@sgarzare-redhat>

On Mon, Jan 12, 2026 at 06:26:18PM +0100, Stefano Garzarella wrote:
> On Sat, Jan 10, 2026 at 07:12:07PM -0500, Michael S. Tsirkin wrote:
> > On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
> > > On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> > > > This series adds namespace support to vhost-vsock and loopback. It does
> > > > not add namespaces to any of the other guest transports (virtio-vsock,
> > > > hyperv, or vmci).
> > > >
> > > > The current revision supports two modes: local and global. Local
> > > > mode is complete isolation of namespaces, while global mode is complete
> > > > sharing between namespaces of CIDs (the original behavior).
> > > >
> > > > The mode is set using the parent namespace's
> > > > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > > > created. The mode of the current namespace can be queried by reading
> > > > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > > > has been created.
> > > >
> > > > Modes are per-netns. This allows a system to configure namespaces
> > > > independently (some may share CIDs, others are completely isolated).
> > > > This also supports future possible mixed use cases, where there may be
> > > > namespaces in global mode spinning up VMs while there are mixed mode
> > > > namespaces that provide services to the VMs, but are not allowed to
> > > > allocate from the global CID pool (this mode is not implemented in this
> > > > series).
> > > 
> > > Stefano, would like me to resend this without the RFC tag, or should I
> > > just leave as is for review? I don't have any planned changes at the
> > > moment.
> > > 
> > > Best,
> > > Bobby
> > 
> > i couldn't apply it on top of net-next so pls do.
> > 
> 
> Yeah, some difficulties to apply also here.
> I tried `base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59` as mentioned
> in the cover, but didn't apply. After several tries I successfully applied
> on top of commit bc69ed975203 ("Merge tag 'for_linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost")
> 
> So, I agree, better to resend and you can remove RFC.
> 
> BTW I'll do my best to start to review tomorrow!
> 
> Thanks,
> Stefano
> 

Sounds good to me. Sorry about that, I must have done something weird
with b4 to pin the base commit because it has been
962ac5ca99a5c3e7469215bf47572440402dfd59 for the last several revisions.

Looks like my local of this is actually based on:

7b8e9264f55a ("Merge tag 'net-6.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

I'll re-apply to head and resend today!

While I'm at it I will try to address Michael's feedback and bump a
version.

Best,
Bobby

