Return-Path: <netdev+bounces-243284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA6C9C83E
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 19:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC1D84E39A9
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA12D4807;
	Tue,  2 Dec 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRwRv8Kl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73F2D1F40
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698169; cv=none; b=U6Bqc0h+dHQ6g+pYaHD8+jNwdeI3oHNcdHjjd7RdfEM6IBkmhSV4Y2GBCZhIamo+TSIi15XFrA/ByUYo6jce7huQO+Q/kUjB1W6PsfswkE22QHNyoTIBHBk03oUx1wB2bqmkOwYirCc48cT/JvT59JsNWCf+X80hqTnEDahG3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698169; c=relaxed/simple;
	bh=NNJZa3lYs1HsOUBIuFpcTtIqAcyjGiny7NhOTTEAIgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx1kiwMY1u1NiZDWa8JWZsDwZ4Jjd32qVSxCwIR7UM86YXdnTPCQJyeTyO6qrkBDEwDfSlWx8rs8MJ4ZcoSdVUXT42rDWNGpwP56TRsXvpuiPoo8OuhZtA0fRfcURqsiZMANiNiTeh+uy0t5+E7TvaQlRb4JOCFfBTqaq1pMNtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRwRv8Kl; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78a8bed470bso45169227b3.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764698165; x=1765302965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7vZxiysLlSxuLZX46Kvfy9pEAECDucG1jVAjFchGcE=;
        b=XRwRv8KlmaJlBPlhqUFkbjskUF5WrV8FeOEy1IxpCGffkFi/pklXwjpG42fh0KIXqC
         vUspX7/shG/IQ0WVnGi9kBGqcJyyDdtW/GJRr2D0GzlwFJsWr0mlwPZdAohokAFY9odZ
         1dG3q4K2goovUfzhKRBfmze3TLBVDn8Pr02jQJ9tJgqO/ypvbOOzM5kZypfuBUnjsnP5
         KpG/kkus9RoUiYe+Uiu2YdhgVhJbsVmCby4tQ6ZL0W85P5HerTpq0YtRyW039ncxzeo3
         p5BXQUO7CufalHChUP6xQSWKVM3J6A6T36VjdM2MUsIQxGb8aHJ3tSjbBrkjxiVAS5fD
         am+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698165; x=1765302965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7vZxiysLlSxuLZX46Kvfy9pEAECDucG1jVAjFchGcE=;
        b=Jnx+/vQsCT3qF8C2o5eRlKrr9BgfNFuBfQlxzcZSUiFHW1rNE5Qiy3NLgiz01MJS8c
         f1h0qSW//s9KPuw6WkaldMmvrD/ChzNEhkJzJCiMqAytrivqsbQy3IFTMvYNROJVmOjo
         cR+fucpGlbFXP9FuJXMoI/nsAgrsztnfQ+613iKX+1KAPa55e0nr2V1J58vCYWIImDAO
         /reDhfT1I2Xy466KjHOJIn7tJfr83g8/HVR7DozoFxOvRG+lv52Uby9vV/uUgIXh0QCZ
         wKHZ5E0hTCsMrZk480Zodwac6J/AUDrTrs96N/QuvNyXj0r/lkV7jF9ObInl7fuUUOdY
         +ysw==
X-Forwarded-Encrypted: i=1; AJvYcCUDm2oV8wJQuPe+fSYXKA7fkZq21wfACNCSIHRRZQcR/pH/XfQglTPoD5xLNbkGLzh/5LNUxIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qDfIbg6MCjjPllD/og9hIspxNuPJsVDi7z3aNOzkTsfoJNWt
	9AvuafqGQsVnapQ6oqSaE84t2cFxzzW2hj9kuyDMrqpF1tgFHoQH4Ge6
X-Gm-Gg: ASbGncst2VS2oKiH67t9yWGo1lLzf+KtVzQYdqAmIqhaxIR7RLyumB3ZXAH8cSwT8eE
	QmiUVfaAxyBAY+xMTtKNsmxu9KVYhZll4AdAaTgje1coFc4Nwpp2taZWBsA18qXG2YT1MVQLsCi
	wo0Ne6bqzBqgUBLtaHfQjhuFzDmhv+6LOEGk7GcRnUwwRwuC3IFrDvRGMsqJ2j+nVs+l+7sGiQi
	qJx3gclD6UZRZ78NCv7M5ZWKVhlN2UQA1CEqd9STWeYcusncXxEVuApqMYKwMm/MxJ1UQRoEfOi
	2Te42Fe6wPh5t9EAZ97sA5GENfYQaS2TMrvPqJfumkbmZPrHMDD0OPiz+SurHVA/VvZewM/vKOk
	NtoFzpFOz4iiqPzDtV5PTKdIQmRRmGOFzH1sopIKZ2gQec30ehZ8CnkqHS+K+e398zYZR//NRRc
	5IrKZ2rlNaGIZCShE5TH4VR7yEmObZQv8Ympy4tlOOqg+x86Q=
X-Google-Smtp-Source: AGHT+IEnSlAlHDUf120qJOiOHTcx8J+isqzg/5s1dw3tbZ5v6cDlgU/zp4/SXX2g9a81U9jTgGEZ/A==
X-Received: by 2002:a05:690c:3601:b0:78a:6a6b:cced with SMTP id 00721157ae682-78ab6fb335fmr452183477b3.64.1764698164723;
        Tue, 02 Dec 2025 09:56:04 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5a1sm65198027b3.12.2025.12.02.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:56:04 -0800 (PST)
Date: Tue, 2 Dec 2025 09:56:02 -0800
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
Message-ID: <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>

On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> >  		goto out;
> >  	}
> >  
> > +	net = current->nsproxy->net_ns;
> > +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > +
> > +	/* Store the mode of the namespace at the time of creation. If this
> > +	 * namespace later changes from "global" to "local", we want this vsock
> > +	 * to continue operating normally and not suddenly break. For that
> > +	 * reason, we save the mode here and later use it when performing
> > +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > +	 */
> > +	vsock->net_mode = vsock_net_mode(net);
> 
> I'm sorry for the very late feedback. I think that at very least the
> user-space needs a way to query if the given transport is in local or
> global mode, as AFAICS there is no way to tell that when socket creation
> races with mode change.

Are you thinking something along the lines of sockopt?

> 
> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> may cross netns boundaris and connect to 'local' socket in other netns
> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> isolation.

Local mode sockets are unable to communicate with local mode (and global
mode too) sockets that are in other namespaces. The key piece of code
for that is vsock_net_check_mode(), where if either modes is local the
namespaces must be the same.

> 
> Have you considered instead a slightly different model, where the
> local/global model is set in stone at netns creation time - alike what
> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> inter-netns connectivity is explicitly granted by the admin (I guess
> you will need new transport operations for that)?
> 
> /P
> 
> [1] tcp allows using per-netns established socket lookup tables - as
> opposed to the default global lookup table (even if match always takes
> in account the netns obviously). The mentioned sysctl specify such
> configuration for the children namespaces, if any.
> 

I'll save this discussion if the above doesn't resolve your concerns.

Best,
Bobby

