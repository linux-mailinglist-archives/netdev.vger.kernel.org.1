Return-Path: <netdev+bounces-248773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 767B4D0DFF4
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 01:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 527F93020395
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 00:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A29E29A2;
	Sun, 11 Jan 2026 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWbu5R2O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mu3W6dAU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE14C9D
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768090337; cv=none; b=Zpbi+1GTaG53nC8S0cEouSdgtYTxmoAXHOLvKtq22LPNtJ6TNcPJql39PRdp64SHoJ1iKvvhrO/CHvMqpqnFdbLnK0A8VhgYQWyw0MFiwceGwyoaqzGT2Yml+2SFoQcR++CMdoZpASU69nqVRclh3OiVLk7PLDogQuOMMJ8tUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768090337; c=relaxed/simple;
	bh=mLWLZ8V/CeaK+tkNrj5VuZDldGSy5v1mTtg2DMNYb/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSmso1/wIJ0uA9nhGSneOQ9PV+DZRyDMkZJZXxlIW2gI77v2ziLdlajLXYtrG1Jin3x7wigaNZ7feVESQ4YKJ3Zp6LDnldTLEstxiZJ+6khU6L9HpoGmlIaoBx3y3N4a5TidiSNEjiEqrKVM3wxfZL4Zlj95ZXr+GcS1N0lm/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWbu5R2O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mu3W6dAU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768090335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
	b=GWbu5R2OkHOW1Q6dRltZRMiANuPvs6IRjCQOxp4RvFkyYGj7UUa6g4XA9G3ls7impXskL1
	T0TPI/6Gn6oDC4+SFNTQeJo0iaskfFol2zJP4lXEa2droYI0NKd9m2xHcvsSYyoX1XA4At
	ZimHuwip6MvoYEBwR2MyNRz8FAIpTgQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-3_LHgSz1PbOTie2hNLT5Fw-1; Sat, 10 Jan 2026 19:12:13 -0500
X-MC-Unique: 3_LHgSz1PbOTie2hNLT5Fw-1
X-Mimecast-MFC-AGG-ID: 3_LHgSz1PbOTie2hNLT5Fw_1768090333
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso62452315e9.2
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 16:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768090332; x=1768695132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
        b=mu3W6dAUGHim0Hn7QT5H2ljZEnUp5X0zmSP/8oJdN38ucQYE9KHA7KLn9IZsUmj3z7
         gyqCy/qwhszVUTW7Ar5bhF5GUU/mQIU6URCfYm57MCuK3g4qAIwZx2LH7vW1alXDYAus
         vmM2ctz7a7wawMY/Pt3dCNnlFrmO9tDda+ibYAl7htBeh050CfYfeP/GuRAdaSQJ5IFp
         XTHc8LSqUJFtbSQrVV5dZNqx/9f+imMwIWsGnMmfrHQ2p383vyXu3VAaOc8JCNXPbr27
         8hzBkjw2+Zi+DZSfrhxlpod48bj7F6l6tH/5y8nw3PHClaFHmp9+3ObJdUpF3TRwEgik
         DmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768090332; x=1768695132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
        b=XNAm58/X05Bjta1m4Y82gTC7N1A5tJ0gmrU7vGhiMFXGFS3BAN6aB0W11gwx2rXrnd
         z7/hQakwU0xxRBT+7DfVu122jnsNq7LwFC00fBGJgBi6h+NhT1LZEwG6pZLoto9r8Dyn
         v9ylW7BIwZzuh3ai4P9gtyfMJRTRdWvSDGvRSBgYUsQBz078eNY0Hc6eEmwtW0Kw8m/M
         MbSJZewyjGULSoCKcClWKJLEkO0Pw0SvRTRXy3PQ7q/TVXHXB5Q7W/9fyMbNR8lCHGBL
         lNui1eTTsVGfgdtEKuKcZA+46s0s+PyqQd9im7z2KshRr0FUGOvMiioXW4gAYPLPFIbi
         +Qsg==
X-Forwarded-Encrypted: i=1; AJvYcCWYcOflENsDqfz4RM2lEZDvktYgJyM5gHhi0tr7tacycw0NoEB7VSYlrCJaebMyrGRy7mfary8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztVCmQ1raU80AzQd0A1HAvZcFi8zaLAxZgewRUJ1ZEFCV0n1BF
	jdgINxekZmlzWhdmAeNQ3UlC5D+f2m7WznoKfDjXDmW/3HW2Z5t9RK8deG6X7k8PYSWcR/iRe4F
	IVEhTvEYcBv+2AEwRKxD526x+YO+esq6Vhx4xIgnRm8kB73NmPcxv1dvaAg==
X-Gm-Gg: AY/fxX4WnT0tsus/Lbr5P0ep1TCOSp0fi18rpM6VEioJ9RCnBRLp24J5vmE2L0WdV2y
	gKGBm7470iR8rsHOzYiftM5Pqxrjye8ta1bxLsdAwJYL+jnkPwTJaowvoub673oC4mVyoLk3am+
	Cm+WuAW0gVeKUqpE4oBfq8ES4shvuRBenecfxihOkTvE0X3hpmV91QznchJ8Mqm5xLo7zuyxVW6
	Utjk1xuBpyJyxzZ3GzPzm9dXGh+FZn+I9ZMSRoNvlM7W8zZwoSATJh+qyAYbUCm6LfebUJ8lWC7
	s4t6gavTxujoeC25IDC0HPGRo9apVi9EEo+CUtV2lRj/ZHoG5QsKClAZ66xBHkZOYlz3fB9MH/3
	4ImKe14x2kBa5NU3LulEeJBC81mIJQxY=
X-Received: by 2002:a05:600c:4fd0:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d84b1f7efmr165064545e9.10.1768090332614;
        Sat, 10 Jan 2026 16:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnuDsqC9m+l3yDfJUMvz3utaUAG5Ge2RfD+SugU7SA1yuuWtgjR7DEiLIEaKlXtpa9H3hyeA==
X-Received: by 2002:a05:600c:4fd0:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d84b1f7efmr165064445e9.10.1768090332218;
        Sat, 10 Jan 2026 16:12:12 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41f5e0sm272650555e9.8.2026.01.10.16.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 16:12:11 -0800 (PST)
Date: Sat, 10 Jan 2026 19:12:07 -0500
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
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <20260110191107-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>

On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
> On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> > This series adds namespace support to vhost-vsock and loopback. It does
> > not add namespaces to any of the other guest transports (virtio-vsock,
> > hyperv, or vmci).
> > 
> > The current revision supports two modes: local and global. Local
> > mode is complete isolation of namespaces, while global mode is complete
> > sharing between namespaces of CIDs (the original behavior).
> > 
> > The mode is set using the parent namespace's
> > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > created. The mode of the current namespace can be queried by reading
> > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > has been created.
> > 
> > Modes are per-netns. This allows a system to configure namespaces
> > independently (some may share CIDs, others are completely isolated).
> > This also supports future possible mixed use cases, where there may be
> > namespaces in global mode spinning up VMs while there are mixed mode
> > namespaces that provide services to the VMs, but are not allowed to
> > allocate from the global CID pool (this mode is not implemented in this
> > series).
> 
> Stefano, would like me to resend this without the RFC tag, or should I
> just leave as is for review? I don't have any planned changes at the
> moment.
> 
> Best,
> Bobby

i couldn't apply it on top of net-next so pls do.


