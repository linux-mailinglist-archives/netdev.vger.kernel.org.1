Return-Path: <netdev+bounces-243326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8602DC9D211
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 23:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F47A3A7393
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C842F8BCA;
	Tue,  2 Dec 2025 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZdwtHGo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC82D063A
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764712869; cv=none; b=FPXs6UbIOnflmvGqZAg6okD8N/EjCdAQd3Ps84CeBbzhMZS5l61K7keKmaQtXfLWpFuzbo1IfqWhvo60t4fpNtKoEG/zOCRxM25trhqHQfGiicxrdjVbZv5FJiFBUOvcd7WChu9dSb6ZjbfsDN4PEHcIfojKcTm2BuNMipACOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764712869; c=relaxed/simple;
	bh=Mqnyzq/dHBpiYdG/Xt/TKvJXJMP8zWCEKc3fUG6Hw0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0hiEtSttwnCMn6rzeEBN06xUE+3a3qEtDPKd8ltNWoN2BQBJEoiPtCa8uh9LSiYvRLfD3qV+y94gDj1mCDVrGB0/9HbIfJnA8lETc1dvHivqr5md0XLxfDeqDxdytQSz+uZ3yAlTszbHAO26XK98VOMH8N7BDLLttYFsrEtlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZdwtHGo; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78ac9f30833so49567237b3.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 14:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764712867; x=1765317667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNqIfgM/6Ycxql9GvTaW4xpHm2HTdtIqMIBvJdvraLU=;
        b=OZdwtHGonB3nfffkr6VAZVqTIoL0VKHhfYC1cJqS0rCeHHRluRmORfZVjQF/E0Bl8B
         juTo9aHbJQD6Z6xYYDtXvIrZ1KnlWq+hwurM/QVZXIwILYNpOJ+RnjyUQPZ9pKT2VG8j
         q3i1E6ktebX+xrSHYTvMS8kiIXOjRBmOfrAsVoyRy4Uoz/Gcf+HV4+pv5WGZb7w/rIZh
         Z7WhLAzWkGHmsY+zruBZ3j23y8vxHGrsKrz5C9z5I5sjtlWzZRXIDXqUKsurQftDMKMo
         wRufIxC/i/+ldxbYSsAv9iyUCNXvLjDXXN12gqkqHSnnA6tbI8z6kFBr8ctD5V7bleYF
         BUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764712867; x=1765317667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNqIfgM/6Ycxql9GvTaW4xpHm2HTdtIqMIBvJdvraLU=;
        b=jzEp6yF+f5R89+eB1kIMJruv12Xjl3zkaQOksPrX6/x3AzFPPuHBLqWW+F+rYBhUjL
         Ylp0qUcFxtjpQtkyFgKm4k4HZok5eqBK23IVG+AFX0T9bBIGikeg0c285DbopdgIMdgY
         axO2tMuyPVQuo0BPoLff1xQOHlCVpE8hXiPTH7s4iS8pfa1Fk01VxL1BWqosM7JiyVuy
         sdXKiJ3UZbHOLTOZ6j/ujAZx8kJfD2H+Hi160QM4U5ioEJpQKbJydoDRpaGnOhrFfKcI
         UCsYZ48RLg1D6p5nOdAoIGX6QBfvprbOe5XYbmEnnQJAs5T59P4p1dHEHImp4Iqo4siF
         en2w==
X-Forwarded-Encrypted: i=1; AJvYcCXkcTkhexANFMWY4imO0sv/auG5C7/7LbbR5If2NBcZkRyYhdsrcNklDUoXxsRbqQ3Ki1zvBso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Oxq1Mn1IPGzXkp+5FjLvgLwyRN/Fidva3ohtSJSR7fIokmeu
	+z9mPA/A4bh3+Zr8yThYuqMa3Pp72yUrdqGBb9hGjWBBO6ALasc7T37G
X-Gm-Gg: ASbGncsmjJf+xcq6ngT9+lml708/LuNIylRyVbrXdaz6t2rkeGSwaLngydKBsyKtByK
	21xPAMmOaQanfqoesfy1WyhqgQC2GeFQYVKEKL0DWYssbXGGUUK/3xERT3WMj7YnixdqSPfiGP9
	NTEM83WwNqljL5Chte7yzJuyR4ADHsHoz/vMq9k6J75LoxLexwjLH3EQBh7SDrTAhe6uvVdGOWQ
	Jj7AlWE0eGHWwUWqDWVea0ggbwr+sIGomBTNTvSM3E10Yvh+Prwl0jo6SiFpZNHFBp8BUIi5Sc6
	hwL6xxD0y7OrG5lw98t0l/bIZu4AHchPRKSc4SyK8ZGW61N7O5WCFRPvtuAdChG23+Krlqs5rRI
	wktlScMIui8yvDQBb66Y9LoaLGszUMeSjGRddJyA5VeCu9+XLD7X/qq3Omg1sspEzdN5xLsPIUg
	oIAinrQ4GXy5BVOHcj73iivwe9ROAzPJ84xjRXnHgXvXBWftk=
X-Google-Smtp-Source: AGHT+IFKkR9nJxuAswYbUkRmscuBgN9zjQIp6HaO2rufMd5Ab/1ylKT04Hn5ts4J77BDYWjQzLjRWg==
X-Received: by 2002:a05:690c:6206:b0:788:e74:b281 with SMTP id 00721157ae682-78c0beafabamr1238977b3.13.1764712866608;
        Tue, 02 Dec 2025 14:01:06 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5a1sm67446487b3.12.2025.12.02.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 14:01:06 -0800 (PST)
Date: Tue, 2 Dec 2025 14:01:04 -0800
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
Message-ID: <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>

On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> > On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> >> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> >>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> >>>  		goto out;
> >>>  	}
> >>>  
> >>> +	net = current->nsproxy->net_ns;
> >>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> >>> +
> >>> +	/* Store the mode of the namespace at the time of creation. If this
> >>> +	 * namespace later changes from "global" to "local", we want this vsock
> >>> +	 * to continue operating normally and not suddenly break. For that
> >>> +	 * reason, we save the mode here and later use it when performing
> >>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> >>> +	 */
> >>> +	vsock->net_mode = vsock_net_mode(net);
> >>
> >> I'm sorry for the very late feedback. I think that at very least the
> >> user-space needs a way to query if the given transport is in local or
> >> global mode, as AFAICS there is no way to tell that when socket creation
> >> races with mode change.
> > 
> > Are you thinking something along the lines of sockopt?
> 
> I'd like to see a way for the user-space to query the socket 'namespace
> mode'.
> 
> sockopt could be an option; a possibly better one could be sock_diag. Or
> you could do both using dumping the info with a shared helper invoked by
> both code paths, alike what TCP is doing.
> >> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> >> may cross netns boundaris and connect to 'local' socket in other netns
> >> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> >> isolation.
> > 
> > Local mode sockets are unable to communicate with local mode (and global
> > mode too) sockets that are in other namespaces. The key piece of code
> > for that is vsock_net_check_mode(), where if either modes is local the
> > namespaces must be the same.
> 
> Sorry, I likely misread the large comment in patch 2:
> 
> https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/
> 
> >> Have you considered instead a slightly different model, where the
> >> local/global model is set in stone at netns creation time - alike what
> >> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> >> inter-netns connectivity is explicitly granted by the admin (I guess
> >> you will need new transport operations for that)?
> >>
> >> /P
> >>
> >> [1] tcp allows using per-netns established socket lookup tables - as
> >> opposed to the default global lookup table (even if match always takes
> >> in account the netns obviously). The mentioned sysctl specify such
> >> configuration for the children namespaces, if any.
> > 
> > I'll save this discussion if the above doesn't resolve your concerns.
> I still have some concern WRT the dynamic mode change after netns
> creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> see now. A tcp_child_ehash_entries-like model will avoid completely the
> issue, but I understand it would be a significant change over the
> current status.
> 
> "Luckily" the merge window is on us and we have some time to discuss. Do
> you have a specific use-case for the ability to change the netns mode
> after creation?
> 
> /P

I don't think there is a hard requirement that the mode be change-able
after creation. Though I'd love to avoid such a big change... or at
least leave unchanged as much of what we've already reviewed as
possible.

In the scheme of defining the mode at creation and following the
tcp_child_ehash_entries-ish model, what I'm imagining is:
- /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
- /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
  number of times

- when a netns is created, the new netns mode is inherited from
  child_ns_mode, being assigned using something like:

	  net->vsock.ns_mode =
		get_net_ns_by_pid(current->pid)->child_ns_mode

- /proc/sys/net/vsock/ns_mode queries the current mode, returning
  "local" or "global", returning value of net->vsock.ns_mode
- /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
  reject writes

Does that align with what you have in mind?

Stefano, what are your thoughts?

Best,
Bobby

