Return-Path: <netdev+bounces-247909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7717BD007C1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 01:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 766D730222E0
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9D1D86DC;
	Thu,  8 Jan 2026 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh9AaWzp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF51A23B6
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832897; cv=none; b=uXiHh57FM0GKzpbWBEY1e8bVMmkbE9jWeLrZinkfnPW30RD3r0crEf5bOW/WnZQ3d8FEPRpETLdKa8xrgwnD9Vwc+wyiE71UVhwgpsSiMxvLnn3qxJh+M0Y1GGqOr54HR3RbpBJNptl1ga7KJfUnpzY/2DCXyCpgr200ffP32eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832897; c=relaxed/simple;
	bh=9g0zStzKQeS3+N9tmIKzZx3owOLSnCnzmMh7XbFrzQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LltaebGkNIrdQWW4+xfZp8YZ6siST89ze2MqnVHm+FzBj8K+5ILtMr/zXB4o6hj1R7dAEOAy81Y6Tpmyw0eu1HmQ5/Ed07z9Za30by9Prp5vy+z34YQ32GX8WODdtE1htz7CgwKRma4B4rY32ePJBNhLl0QMtq4vK8uNX8SKYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh9AaWzp; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fb6c7874cso31165587b3.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 16:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767832894; x=1768437694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrenqTp8E4tDkOgXs7eMnB0GiU20rX+sxdLI3fByfBk=;
        b=lh9AaWzpXnlVl9nZXhJnRo0Y8K1o7eo2v3zX9HTdB/EjYm4atY/VsyMe8GBBfbdxL1
         MH0hMkuVOfYpgXKVnTBj6/tNewFC5wUaq7Y+9Z7k53yeBjrUkRjtqnV/qY11zl5ug2O7
         wksu4fd3gdNwP2DyBS+s0qtIz23y537d3e48wcy0dIkAHfs1mWrl71c2BdRIOTnhlBM0
         3LUvbvAQeGxsSW5jzPmATnyHTDyZ7308bcJtphsqX/8whzHOmvCwqK5YrxPR0t56ZApx
         TNA2JYT8nFglk8yG3BOIo9fYFE+zk7fZdx1PBltKZpeEN8iCcJbzVO5VNZPmLfds9L97
         uxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767832894; x=1768437694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrenqTp8E4tDkOgXs7eMnB0GiU20rX+sxdLI3fByfBk=;
        b=CSmRjVeiF3af+JG5Pw5ptVkQg4EZsjoD9vwUWBESGmswz9ltmQC5q5YYteCZVSGB2S
         +dd7CHjbhBQ+uiCd582LsTpaXMGKFJDqgTrwJSDaItJpepgAPNk3iQLeacME2zZEhzYK
         rTjqm2z1+fUwiGUttbxF9dQnQD91P7gnsyNZPxaEo8/+YD553Q92Ur7VMzkNifRNQmox
         8ZK8mKwSR1oUwCsTPHIP6Z83csRH+vwI1pKPfOq1rsB47D9ewwzjFSfLI27OCLzKUtug
         ZuJmeUnVI9YU/nt0GLVyp48t0FsyXMNxjQ2ZfJP2NcuGtrEtbQAqg4m89mFXBhp3/9Vc
         YoTA==
X-Forwarded-Encrypted: i=1; AJvYcCUGcb6i9PcH8LhaebLbEvTq4K0qtEjGNODZtq+xvCuUl3gqtMxEtYVV1zUvPlmURci04kdyoWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vsLN7GbGM7LLG02Sxo5fjjWjR8wtppAWDMKpRZuNQ+BmV+ix
	aD+JOueImowmxrERVaZ3YOB6+usLPfNXkJ88kRkgsrav6/nJiHwGX19N
X-Gm-Gg: AY/fxX7mLtARcSj4/Jzy48gdZLgJcw5TyZGpEV32Q8Idjw3nXDNfQHJwNRN+If5WD1K
	NCybv2bqCOwgsuvunG3/fmrLx3Q7FWSftj5pQkLfBiwevH8zvU1YMqmQvye9IqAg1gUmXAqbe2N
	yvfXXHpVD5u++hEZhGA1vGvm6wEYMZzef1JXv1zNY+4t78ncGncWzZsJhNTUFLY7m5T7zWU2NOD
	Sk6wzXIqT2PzUr/Upwm3YCvIqt8n43tTbXiIcfDtwGJwswxKtldj0+6gajssL0Bmt9NOa2asvaD
	unrlC+d2Qy+ugrfJM4VSujHhZWz3MtEWSK7dAzjVM+zwd7SqzlmPh0Juus90vwJ8jPv6Xv7ynoa
	qqWITZzgeHLjX31ggCusFmBD9QX0DDFzMaO8G9cXWl/9F16CFqsOZ6bMS3CEHAtsAC8ILl2eDIF
	HTFD5aCGLVvfEhHTgE92pHM2rY/qsdtpSDZss476cnh2gjog==
X-Google-Smtp-Source: AGHT+IEnrEIlaG9p2xZXsCNaxYstFtQuumuk05m95Q+1JCx1iT0A6+p+K9E6BdjxZvhkaj4OdW4EFA==
X-Received: by 2002:a05:690e:1686:b0:644:60d9:8675 with SMTP id 956f58d0204a3-64716cbfa9fmr3525112d50.90.1767832894483;
        Wed, 07 Jan 2026 16:41:34 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d89d607sm2690822d50.12.2026.01.07.16.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:41:33 -0800 (PST)
Date: Wed, 7 Jan 2026 16:41:32 -0800
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
Message-ID: <aV79PDVBDEqxHlhK@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <99b6f3f7-4130-436a-bfef-3ef35832e02c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b6f3f7-4130-436a-bfef-3ef35832e02c@redhat.com>

On Wed, Jan 07, 2026 at 10:47:56AM +0100, Paolo Abeni wrote:
> Hi,
> 
> On 12/2/25 11:01 PM, Bobby Eshleman wrote:
> > On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> >> I still have some concern WRT the dynamic mode change after netns
> >> creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> >> see now. A tcp_child_ehash_entries-like model will avoid completely the
> >> issue, but I understand it would be a significant change over the
> >> current status.
> >>
> >> "Luckily" the merge window is on us and we have some time to discuss. Do
> >> you have a specific use-case for the ability to change the netns mode
> >> after creation?
> >>
> >> /P
> > 
> > I don't think there is a hard requirement that the mode be change-able
> > after creation. Though I'd love to avoid such a big change... or at
> > least leave unchanged as much of what we've already reviewed as
> > possible.
> > 
> > In the scheme of defining the mode at creation and following the
> > tcp_child_ehash_entries-ish model, what I'm imagining is:
> > - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> > - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
> >   number of times
> > 
> > - when a netns is created, the new netns mode is inherited from
> >   child_ns_mode, being assigned using something like:
> > 
> > 	  net->vsock.ns_mode =
> > 		get_net_ns_by_pid(current->pid)->child_ns_mode
> > 
> > - /proc/sys/net/vsock/ns_mode queries the current mode, returning
> >   "local" or "global", returning value of net->vsock.ns_mode
> > - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
> >   reject writes
> > 
> > Does that align with what you have in mind?
> Sorry for the latency. This fell of my radar while I still processed PW
> before EoY and afterwards I had some break.
> 
> Yes, the above aligns with what I suggested, and I think it should solve
> possible race-related concerns (but I haven't looked at the RFC).
> 
> /P
> 
> 

No worries, understandable! Thanks for the confirmation.

Best,
Bobby

