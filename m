Return-Path: <netdev+bounces-249614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A04CDD1B91B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA3F3019B9D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013B7352C53;
	Tue, 13 Jan 2026 22:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aubHfe76"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587F34FF46
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768342679; cv=none; b=baCAaFVR4trfhdsvcR+IEht6w6OczMDSqqdmHoONpzeKAYdn9ntKTH8wuRmBnQaDaR8oMu2qoq9uwRAuxxbBR/EZXTBOsFCIpzmc2bHOMeQw0ozShtK+rMaaBd7FG9m6fpPhgKy6LBrIJHR17RU3nScFGm5DymkPEX2W4bXmXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768342679; c=relaxed/simple;
	bh=h+UznknjOhsgpxn2WvyaKZdy+E01z3xst2FqiSOZMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/Av46DlNo2klgAsAQSjj8jh4gpk3p2S+RoRE0XS4TSuWNpniBzvpqp3WsevDxfejMGlSMlwLLnAM5RfcgfEF/s6GTJOZKEHjKKpCO0lfWBn8jKeOzt6VEkM22g78Uwc52cmJppgB0PEdT2wZP/aT3dT8ror9YU233+h8TNp2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aubHfe76; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4f822b2df7aso108195591cf.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768342677; x=1768947477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QzIlW73SYpRCgsFT6C0OFykRPA/kKAr4bQkErotYYOY=;
        b=aubHfe76U39NslaZqcLvbXAofKOakyynJkEFjhHYhpkpKeFrwNQ42TJezD32ZjuE4b
         5HkhQjf1M9H+IqaILbFuC0ojvzh/I7mEFemhibbppwYEPZZle+n3dDbgmoXFClzhTTMT
         hDVwP5+LyZPpOSeHh+MdQ0qFHnyt7OyC1Cd+iLw+lOWeDObDYSisMIT2OkXOuPw9jn/A
         BqEBodS7261rQCnFrQCGIizFKvXTn9UNfovxiMx0OGEt9zUKuW/4cthICmXPQLXKbQiN
         iYjo/7t7jGB6BbEUjXWEaBUd9qmFQJBjRKuX39rPy9LJz2+VguD3WN5rpt80DQn89C46
         PU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768342677; x=1768947477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzIlW73SYpRCgsFT6C0OFykRPA/kKAr4bQkErotYYOY=;
        b=q6JCs7ngCuEZlvzYD1kTuTC9jPz8FG4tOLY3LV7knF9wFHqVGet4Ds7O2O77RyrnE1
         cWglweMpL60g6/C0YUTPHq6hjLL/6OBa59gyPzZMvmhFmmDm2/cwOnTKTpDujZIjPy6o
         iWAiCM25Bp5i3MzCMGTD90Pmr+diyRo028nLhAygteQl59/vnlSfR5Hkew298k1WApsK
         Zo9IhdSYaCeCnSASlKKTfRAa6U4rTzA1DMWy3Rkp9ZGBBkhtXlAjmdONb0mZ3nKPc4sZ
         2mQ+rfbHv4KpcIkyu1xmznYfbqiAmajUykDtFoXePQAgyz2s/CAkLUM5rINeNpQnWjfw
         cT6A==
X-Forwarded-Encrypted: i=1; AJvYcCWX/RTLeEjPqNJJkFwJ6Nxka0Xeou+qJc+iVyQj/t0LKkg7rAOg72j1wOtYYRNruMansDgyHWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnvuccDffpCPWQlUlt369tLUCn5yISlgVPSjNtyUbQLZEC8zX
	jS3JuqZmGPJ6lHSu481hxybnrUV5ZNyn+2byqnVCM2snVkRPEhgyLNpK0oMGjw==
X-Gm-Gg: AY/fxX6tojv3MPW2k+dp78XrK++b+sU4HwmlnCGAC6GjdXn7hnKQ4f3QStbnMsjBdEo
	Ke+uuFd8jNWJiY/ClC0p9e0cafhXPWOQlL366DTozBz2LlhY1qXEiGdz8uqlrWJJnXFYuC2Nuf7
	oycxf15mbzsPoVQkmemt+8INPh7dq+IdXWn6AbCOtDgn092eVi2tb+0RLSv5O+EMgKBQlOMjyTO
	QaocgUwwp9Be/Xb8haFxqyPD7Mzuph0UlktNcLyiELo+bK+nM9k8DABAGAdctXfibArnsa8LN1v
	jEDGV8ATM+wfoPoMaE/bVbuVQF8k2AvIoe6r8F87WtXqJ8/laFKUkuGj/uDT5OodomWC728SQFt
	wx06ju0xDecdPV2f11t9jXijkxZdtCHNvinrV3hAZwg81Z1Dy9FI6druqXYiufmzmhsQP4/Sbk6
	moRXY99tMGYc/q1v21IrtVzuEQ8ed9aMkEwBg=
X-Received: by 2002:a05:690c:c85:b0:78f:f3e2:35e0 with SMTP id 00721157ae682-793a1d4bad1mr1649307b3.42.1768336120080;
        Tue, 13 Jan 2026 12:28:40 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm77661627b3.47.2026.01.13.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:28:39 -0800 (PST)
Date: Tue, 13 Jan 2026 12:28:38 -0800
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
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <aWaq9vbBJGqg9+DU@devvm11784.nha0.facebook.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
 <20260113024503-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113024503-mutt-send-email-mst@kernel.org>

On Tue, Jan 13, 2026 at 02:45:32AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 12, 2026 at 07:11:10PM -0800, Bobby Eshleman wrote:
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
> > ---
> > Changes in v14:
> > - include linux/sysctl.h in af_vsock.c
> > - squash patch 'vsock: add per-net vsock NS mode state' into this patch
> >   (prior version can be found here):
> >   https://lore.kernel.org/all/20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com/)
> 
> So, about the static port, are you going to address it in
> the next version then?

Yes, just wanted to get the rebase out to unblock review of the
child_ns_mode changes.

I should have mentioned the static port was a known issue and still
under discussion.

- Bobby

