Return-Path: <netdev+bounces-244506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE86CB91C5
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 16:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA369300A2AC
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5693161AA;
	Fri, 12 Dec 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnNSwg4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5730FC1D
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553185; cv=none; b=ZxF4Ylkoyj3aPO9sZX4vHqafFgKXHiSiiawlq9lg/Vu6fXAJUx6BJqVn5rAO9wuBALLwVtAIDR8vYm9CetdeZr/oBNtQs2GhtEzzmrU6DzGmWF5OnXyIJtVCa+uOeEVpkfFlihAnYxx6fgIJ25kQpN619qm+/6sU58Iwt9tqAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553185; c=relaxed/simple;
	bh=260eGi6QkxDk8QQfOLsKhm09EI+KZGuf0yseurtGq/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLigXLWZ7pzDttfB2r2UA3TfzGmk8GFUZ96qtBWKLUUvcQ61LirmOXqm/dIiN/dKjldFT0vHBRP6zGpIM+r7HMxoxjlMmyK1V9BrYp2puTE6uc9K43mEpSylh72KEYrpo+49fokAcXJ2OtzfwvUSkHgaXkdcES04FSZpSVZI0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnNSwg4J; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78c2e5745bdso12323997b3.0
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765553182; x=1766157982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IK+CEXtkA15N8VNwOIEfZTiLVNxEPNXHwf9eEh9q2mY=;
        b=FnNSwg4JbGsXkFe2tJ+5wJjgau4I9z1jnEAOZjvIh8PXvGDoAjUCWWLmSpFH/N82gY
         ks3SKSB4ltqh8wZT6J060+2vd396uQqB/mO7viVGUwRYaszMJ3Hs6XWWew9C1RTByoDk
         5gAKq9Hcy3WSv2OAoMdqu5h+mhp/7kKMJ+Ot6eKE20kHrCmNFPOOEaRjLiAjdxc4tCKl
         kfbybaS35zpMVppWtd2/nNOPqkFAWdxc0v6WvqBYIbQnAB8I1wYx4DrxpzSR5mjaBMHE
         sNCze75T+kVtEK1ywH0wbBsBhtSfD4w9BT9W/Jsl9MB7+W8JOgLk8x3JKGd0P7qBom7b
         w//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553182; x=1766157982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IK+CEXtkA15N8VNwOIEfZTiLVNxEPNXHwf9eEh9q2mY=;
        b=fB19XFmdW7ia18H3wWWY2KWlapXdqyM0BuoclKXIycoMLwnKYPZnPlV3bkjrDUTUrQ
         fhci5F+2C9eYF21yqQ7ve4PH5Pggt/W3ljaxuw1KOtuaBtCQeicI5IJ6g22ruNXJu4+P
         DsY9VvS+x5AcrPrv32ju8mJ+ktfrx5SQnrnltj4s6kaRNj7s6ZO0pryaYi6JEC/Q2qee
         Sa2rGK8CHyDsRTQ/CgQAFIHhFVNw94GLfGINz5aay5CastFpxXCcdxRmO0j3LF+wg0b2
         q7UtS7dk4OETK6jqFUf1EhjYb3VbiJ4GHZgBWXqagHl5/whrmPIUYTkxU4W0ziB5cZO+
         0rJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqeK9Wt6RIG+NlCWwQmyONgAOOHVBAAGIEFTeQhG99fGhEtMGjyEAYnJZ9HRA42YuXqUfKYiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5oO1gS6wJ9FH+r+ltlOyJsSCqzD59D8wlFbFm+3/qWzLmfa+
	6S+731iK4BaY8n8s4xP3AoDk5mCWc2OVW15zAS4IKtxXASgpr0s3yNwE
X-Gm-Gg: AY/fxX7YZh3bhg4LK4zuCZw5fuvDdORgyjN2i+lB6707H1aeZEkFaFcsXY1kfKjU/HP
	SrqZGm41HflM31wQZI8jdWYtvVcM7p73C+Or8Wfao/GZu9bLXOo8SO/tURBXz66j1L70YrV+YPb
	+ZlDNXIF0PXdQhAKAo7/iYQiMzVUUG7rnbFRhBGaLxReCPWq7cU6KFs5YT7zV6wKmff14THtA5S
	NjMu6eBTtGarYM/RB/JJXIgp5yWmXjUthbhG3Xx9V/4c1Mp4wnfDinjAJUf0qbwl5NuAqxzgvoc
	j3fE30Ltwm1tg1nGTYeJ4CWksr3wo8N4An+2l6Y9NPFd0oNelDAZAsgRv8V3LsZFFir6F9Ca/Ov
	YBLg9BHCpy9WhxDK4nQg4ErFZYkmDIZG1PwT+MLtNWv9XPNjbT5mhkLTTc1h3MLvzjf3tZBHLa9
	cKp7zbyDV6pQuF3DBvI3IAhQjVVSuFCfb78EAZvk0j0riJClTOTHO7sTKwTru8FsrerRo=
X-Google-Smtp-Source: AGHT+IHPDxMRz+sSHQa8GJSWOVqErHefuxKsetCMbgKHq77F9IKQFOzGirnG2+UwGG15ipBxTc+SEQ==
X-Received: by 2002:a05:690c:7402:b0:789:61ca:88f6 with SMTP id 00721157ae682-78e66cab887mr39877247b3.4.1765553181789;
        Fri, 12 Dec 2025 07:26:21 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477d3a32bsm2613584d50.5.2025.12.12.07.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:26:21 -0800 (PST)
Date: Fri, 12 Dec 2025 07:26:15 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
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
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>

On Tue, Dec 02, 2025 at 02:01:04PM -0800, Bobby Eshleman wrote:
> On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> > On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> > > On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> > >> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > >>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > >>>  		goto out;
> > >>>  	}
> > >>>  
> > >>> +	net = current->nsproxy->net_ns;
> > >>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > >>> +
> > >>> +	/* Store the mode of the namespace at the time of creation. If this
> > >>> +	 * namespace later changes from "global" to "local", we want this vsock
> > >>> +	 * to continue operating normally and not suddenly break. For that
> > >>> +	 * reason, we save the mode here and later use it when performing
> > >>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > >>> +	 */
> > >>> +	vsock->net_mode = vsock_net_mode(net);
> > >>
> > >> I'm sorry for the very late feedback. I think that at very least the
> > >> user-space needs a way to query if the given transport is in local or
> > >> global mode, as AFAICS there is no way to tell that when socket creation
> > >> races with mode change.
> > > 
> > > Are you thinking something along the lines of sockopt?
> > 
> > I'd like to see a way for the user-space to query the socket 'namespace
> > mode'.
> > 
> > sockopt could be an option; a possibly better one could be sock_diag. Or
> > you could do both using dumping the info with a shared helper invoked by
> > both code paths, alike what TCP is doing.
> > >> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> > >> may cross netns boundaris and connect to 'local' socket in other netns
> > >> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> > >> isolation.
> > > 
> > > Local mode sockets are unable to communicate with local mode (and global
> > > mode too) sockets that are in other namespaces. The key piece of code
> > > for that is vsock_net_check_mode(), where if either modes is local the
> > > namespaces must be the same.
> > 
> > Sorry, I likely misread the large comment in patch 2:
> > 
> > https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/
> > 
> > >> Have you considered instead a slightly different model, where the
> > >> local/global model is set in stone at netns creation time - alike what
> > >> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> > >> inter-netns connectivity is explicitly granted by the admin (I guess
> > >> you will need new transport operations for that)?
> > >>
> > >> /P
> > >>
> > >> [1] tcp allows using per-netns established socket lookup tables - as
> > >> opposed to the default global lookup table (even if match always takes
> > >> in account the netns obviously). The mentioned sysctl specify such
> > >> configuration for the children namespaces, if any.
> > > 
> > > I'll save this discussion if the above doesn't resolve your concerns.
> > I still have some concern WRT the dynamic mode change after netns
> > creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> > see now. A tcp_child_ehash_entries-like model will avoid completely the
> > issue, but I understand it would be a significant change over the
> > current status.
> > 
> > "Luckily" the merge window is on us and we have some time to discuss. Do
> > you have a specific use-case for the ability to change the netns mode
> > after creation?
> > 
> > /P
> 
> I don't think there is a hard requirement that the mode be change-able
> after creation. Though I'd love to avoid such a big change... or at
> least leave unchanged as much of what we've already reviewed as
> possible.
> 
> In the scheme of defining the mode at creation and following the
> tcp_child_ehash_entries-ish model, what I'm imagining is:
> - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
>   number of times
> 
> - when a netns is created, the new netns mode is inherited from
>   child_ns_mode, being assigned using something like:
> 
> 	  net->vsock.ns_mode =
> 		get_net_ns_by_pid(current->pid)->child_ns_mode
> 
> - /proc/sys/net/vsock/ns_mode queries the current mode, returning
>   "local" or "global", returning value of net->vsock.ns_mode
> - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
>   reject writes
> 
> Does that align with what you have in mind?

Hey Paolo, I just wanted to sync up on this one. Does the above align
with what you envision?

Best,
Bobby

