Return-Path: <netdev+bounces-245939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E1CDB2D8
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 03:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8B5A3007FCA
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEF926560A;
	Wed, 24 Dec 2025 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZaG1xRL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A63C196C7C
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766543338; cv=none; b=RSFk6X/dfO8Z4cmEvnHlQwX8koS0iLup6VcwFS7t3GoIGh5davnwN+r5wbv0ehpGDD+nZPXeqSywy6zQmZns/lmLKjOvXzbFxs4rsqVIUXG20Kfg44Z4qEHmGkK+s88RjPZisd4X08MqVYplweGeL6J2YA96vrb1EP5xKtd6V7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766543338; c=relaxed/simple;
	bh=fag3FxlJG3ZXO56Q4uis4IXo7o2vEhpJMwuQCgBCfc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+q+7b5A1ovCUtY+UmFPF2lo2PlcE3teHUkcIVVx2ztPN8uFMHg5bc6yPo/fWBuM4GFQRJDqKhWWlTri/ASsMZYskK9KzJuVZVqBuS98pz1X+/qFOvvNzmKdYWV1kjKi8t/p7JmxlSGQ5mBnBBenBDhY0dqCgicySZQXRBBA/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZaG1xRL; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ec46e3c65bso4323271fac.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 18:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766543335; x=1767148135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn5gdOJNVLCgqxTAZaOj5KghlS4vIZEHYcNf0bwJm28=;
        b=NZaG1xRL+6s53eWebes0LN/dvvQs/Dim/Rz/IvyvJFBFnwZpGft31wTAR382Ga8moy
         r1zJ3shdesweRG3AXsuNMRTLPH9f9R2+ui7QAzJlQ1jwWKG6pGEyz0cyayRD3tLbotua
         e6SQmxxNCD4Mp4VeQuRi43be4F+HgusNi9ZQFhZTY8pwrSiIMHFyEWLbdVXHLnBC/L8P
         2vTqWv/zrIbH4x6a3ewPyRLOjS+Bn9hW7fhNrigdnqKI7BmJjiRuTLcCZuOmzFFcBxrA
         35udsW5WlWE/q8ZeC+LOwpPJacmrNtxOweGsgxDFheuPC4obbzjVtVmqQZcFJWMl23PK
         js2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766543335; x=1767148135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mn5gdOJNVLCgqxTAZaOj5KghlS4vIZEHYcNf0bwJm28=;
        b=kg8Uk3XCvih9qLoCvyyxmTwBAHHr0IsGj+1Attakh+YQpAxX1LcikGQEfX9vnCuiBd
         yarTbOzFke2Mk5bw2WfWlNT3Q1nT1CK2dA3ynXPDl47e5tYhE5VIZ7bKVsYzoKmLekQQ
         7Y/7yan47tauQ3BhUao1XhgEYPJpE78Y+tL75itZuj6laBTm1G7f48vdOIDjyiAk90Ip
         HN70AQ7NjIkVI5TSxp0NGrz4XN8MPN2xiwJ0B/RwZvSwolpinTalr20zcwsqF1W/r1td
         Rn05fweuWhoHpb9vT32X+Ubxah7SyJRgPJ8+v0A5Raxr+b5+99ztWkiyEuj9+HfzvLnu
         0IMw==
X-Forwarded-Encrypted: i=1; AJvYcCXlbHajnTKqIAvBnNgusFDMns/GdillQpvUSF4/u+fRuSFxaQLZHQ3lgevjD8yhOjJ7NY7B7D8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0V7dSeaafCWcvtW8jyIT73bZ5tWgDs+MiKl7drVRaEjYA2UAv
	iAIqwft3R/77W7J+9tvt4tKzoeZqEIZDT5gWmUDLx3qj6cORW1DSRPJVoNLDkg==
X-Gm-Gg: AY/fxX65t+TN5TnUfdE8/YH+wLO3ccbAf3u1EVyEcMMo1hxddig0YNRDgZI3FTFTBDI
	p6tMtjzV5+SOMP2HZFiO/kTofX40NxFfPlIiDNZY1HIiI1OFseUuTNaMZftrT2OMjVm/oYTkZpU
	Pli0MuWkIqfzaJzhgfI9eMuXUbqjMiaXm/pViBhsxKULgnWhaFzCr2di3sKEHIS14SUH/qLbHrM
	eIFNtuhs4UAIZHPezsuBMPlBKQiZniRz/GnvC4nMoDLM+VeCS99QaNFyOtXWB0FKnCDs3QBgMPn
	5//uzg1pXVd0qm/hgRIlpR1ipXvrV6PrA7FVMrqlTDGRefjCHXVqI9GTxwCY5RMdE00O/s9GLHw
	s7u2t7R3XvAiG4ynWd8hew8fIDioLn7Zz+ERlYo3iiz5s8RBjx2YIP5hPDIQS5jVR+RQOPjgWEf
	XTUo3s2v7R4zij/siaIPG8b52/JwffbPAJq99qhhmPuhhOPoo=
X-Google-Smtp-Source: AGHT+IGl4lY3C5uaIhAdAeU51l9QnKvRP/mJp5bbTNMXCgmCDrIGHmPARt/rlh3H/cQnB4TIEc9mUg==
X-Received: by 2002:a05:690c:d96:b0:78f:aa6d:48cd with SMTP id 00721157ae682-78fb3d52b45mr134838347b3.0.1766536355576;
        Tue, 23 Dec 2025 16:32:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm59887097b3.12.2025.12.23.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:32:35 -0800 (PST)
Date: Tue, 23 Dec 2025 16:32:30 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
 <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>
 <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>

On Mon, Dec 15, 2025 at 05:22:02PM -0800, Bobby Eshleman wrote:
> On Mon, Dec 15, 2025 at 03:11:22PM +0100, Stefano Garzarella wrote:
> > On Fri, Dec 12, 2025 at 07:26:15AM -0800, Bobby Eshleman wrote:
> > > On Tue, Dec 02, 2025 at 02:01:04PM -0800, Bobby Eshleman wrote:
> > > > On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> > > > > On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> > > > > > On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> > > > > >> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > > > > >>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > > > > >>>  		goto out;
> > > > > >>>  	}
> > > > > >>>
> > > > > >>> +	net = current->nsproxy->net_ns;
> > > > > >>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > > > > >>> +
> > > > > >>> +	/* Store the mode of the namespace at the time of creation. If this
> > > > > >>> +	 * namespace later changes from "global" to "local", we want this vsock
> > > > > >>> +	 * to continue operating normally and not suddenly break. For that
> > > > > >>> +	 * reason, we save the mode here and later use it when performing
> > > > > >>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > > > > >>> +	 */
> > > > > >>> +	vsock->net_mode = vsock_net_mode(net);
> > > > > >>
> > > > > >> I'm sorry for the very late feedback. I think that at very least the
> > > > > >> user-space needs a way to query if the given transport is in local or
> > > > > >> global mode, as AFAICS there is no way to tell that when socket creation
> > > > > >> races with mode change.
> > > > > >
> > > > > > Are you thinking something along the lines of sockopt?
> > > > >
> > > > > I'd like to see a way for the user-space to query the socket 'namespace
> > > > > mode'.
> > > > >
> > > > > sockopt could be an option; a possibly better one could be sock_diag. Or
> > > > > you could do both using dumping the info with a shared helper invoked by
> > > > > both code paths, alike what TCP is doing.
> > > > > >> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> > > > > >> may cross netns boundaris and connect to 'local' socket in other netns
> > > > > >> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> > > > > >> isolation.
> > > > > >
> > > > > > Local mode sockets are unable to communicate with local mode (and global
> > > > > > mode too) sockets that are in other namespaces. The key piece of code
> > > > > > for that is vsock_net_check_mode(), where if either modes is local the
> > > > > > namespaces must be the same.
> > > > >
> > > > > Sorry, I likely misread the large comment in patch 2:
> > > > >
> > > > > https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/
> > > > >
> > > > > >> Have you considered instead a slightly different model, where the
> > > > > >> local/global model is set in stone at netns creation time - alike what
> > > > > >> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> > > > > >> inter-netns connectivity is explicitly granted by the admin (I guess
> > > > > >> you will need new transport operations for that)?
> > > > > >>
> > > > > >> /P
> > > > > >>
> > > > > >> [1] tcp allows using per-netns established socket lookup tables - as
> > > > > >> opposed to the default global lookup table (even if match always takes
> > > > > >> in account the netns obviously). The mentioned sysctl specify such
> > > > > >> configuration for the children namespaces, if any.
> > > > > >
> > > > > > I'll save this discussion if the above doesn't resolve your concerns.
> > > > > I still have some concern WRT the dynamic mode change after netns
> > > > > creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> > > > > see now. A tcp_child_ehash_entries-like model will avoid completely the
> > > > > issue, but I understand it would be a significant change over the
> > > > > current status.
> > > > >
> > > > > "Luckily" the merge window is on us and we have some time to discuss. Do
> > > > > you have a specific use-case for the ability to change the netns >
> > > > mode
> > > > > after creation?
> > > > >
> > > > > /P
> > > > 
> > > > I don't think there is a hard requirement that the mode be change-able
> > > > after creation. Though I'd love to avoid such a big change... or at
> > > > least leave unchanged as much of what we've already reviewed as
> > > > possible.
> > > > 
> > > > In the scheme of defining the mode at creation and following the
> > > > tcp_child_ehash_entries-ish model, what I'm imagining is:
> > > > - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> > > > - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
> > > >   number of times
> > > > 
> > > > - when a netns is created, the new netns mode is inherited from
> > > >   child_ns_mode, being assigned using something like:
> > > > 
> > > > 	  net->vsock.ns_mode =
> > > > 		get_net_ns_by_pid(current->pid)->child_ns_mode
> > > > 
> > > > - /proc/sys/net/vsock/ns_mode queries the current mode, returning
> > > >   "local" or "global", returning value of net->vsock.ns_mode
> > > > - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
> > > >   reject writes
> > > > 
> > > > Does that align with what you have in mind?
> > > 
> > > Hey Paolo, I just wanted to sync up on this one. Does the above align
> > > with what you envision?
> > 
> > Hi Bobby, AFAIK Paolo was at LPC, so there could be some delay.
> > 
> > FYI I'll be off from Dec 25 to Jan 6, so if we want to do an RFC in the
> > middle, I'll do my best to take a look before my time off.
> > 
> > Thanks,
> > Stefano

Just sent this out, though I acknowledge its pretty last minute WRT
your time off.

If I don't hear from you before then, have a good holiday!

Best,
Bobby

