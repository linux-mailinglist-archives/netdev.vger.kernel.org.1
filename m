Return-Path: <netdev+bounces-231476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A88BF970B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6719F4E4A86
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36117A31E;
	Wed, 22 Oct 2025 00:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEYxaRC6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0D7DA66
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092323; cv=none; b=orY8eIA9XG/xV95bC8Xs1rIZjjTlA9MAnm8nqIPbZO5d/bbEtueB9aqTpLi+SDv95hyRxgld9S7UEE8/ecq4YmJbijalI9rRDq/wFh3RnFA35SmHahThGO3+96kNW6GW4GGdjpY+MRxbCwWfXgHgYRBSLDmrQ4ewNrme1nGTT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092323; c=relaxed/simple;
	bh=e7zZqGzrVyuJ5QFyUVE7eGJWKcfl4COyVHk9MxNeNKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppfo/mMTiTznZQZewWViep6jOjvUolBF+bsxZcNbwg/RpRcezztsIiETGY58tozqcc+qEJse7KmFNib+EvwCPjEPkuShAfAh7h6SwLbl4V3MNZmmHCs3VXv7TqPbOBc7dXl2BotAi4/VEGcSs6H3eSjh+mm10dT/04UXVxFEx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEYxaRC6; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-781014f4e12so78705657b3.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761092320; x=1761697120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/VVHhrbKGyn2rHkoA+yo5pqhCOh1qQTtBCOhpEVSIKI=;
        b=LEYxaRC6RrM323rjsaoom5Qmq/bAc2SaTJQX8GJ41fF9wS6dF+ydCMuObV/5vRa9eB
         SYzYEkaIUsxJnYJGDOSck7f5EU9vx9otxlhq1x+6sXovUgcPoHhzkS1/sr+MeTTofOqm
         kaqUIhe3CEayD/uRA/QRjxQKOf5/hfvNSSFokoiA062H/g1f6d4cgxhk8wQ2qHOqAWA1
         eVHfFwRFvzlDceNZFLxCxEXtyF1o/6x4+magzUtAbYoQ1/0Hwm2zFzVNHt/0gaLM4WR/
         +Bg6rdX7+JB7kTTKBRV1FQh/ebFcOfaNMgNs1sN5dVUKU0p7jMbVBrQMcaEqRjUmbe0p
         fT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092320; x=1761697120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VVHhrbKGyn2rHkoA+yo5pqhCOh1qQTtBCOhpEVSIKI=;
        b=QC62lpTpDwvQ+/diZNdiLj+9zHmGbe8IXelEpqsH7XniDEP42lNukmJvjvcsCc1umi
         SqU/YCWzFlBJYMp6qEvGMjDDylBdX20IlaLvhZFXIokgTK3/h9JdtVTKroTIoCiYsg+A
         Lam6GyeLyuK5xSwc6e+mmIyqiYedG4VRMRChAHF/ahSz4iwj+qSM7gugJGv5s0Ld34wV
         goLhYRdlrWabf3mcodWMTTN7ZW/dPK0cMN8mKI5FuMPbVpsNURyRXAEfacezHKDIzpeA
         e16LerA/ki2MgsmVWtjdXtKH67fIfekg1/Sf1GIW5A3lb2ly3PsfiOMsPi5ByKFZ1SiW
         jrjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe5gzYUj2J2xjsHbkEJ5BKkx4WP77CyuflloAWNp9eH3E5157O6FF8wo8K0HWZGrI30VfpfyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPltcGbmTSr5SvPnAwyCLDF6+kx2GuRM0Nv0KQrH35E0AWkCW
	cgR5WSYB3lSzr/b+YvMZNnTtUTPpLHVOiZ98R6DaA0NHrGJAKouSQwUr
X-Gm-Gg: ASbGnctcs2Wu/JAELGnNAeonod3IUGuyHC1XDH8CBgQJ8sMc/XkfJ6iPnNhoeXFjPpe
	TiMafl1HbnQGDBWtXe9HTADyW41+S4wkT9zoOSmkUEYVm4oF3ZXqyBwcL05xn/NxZ2TmH4WhR3Q
	tux3J1ti+YON5YYLxH/nP0HoN1cCd5HW9YrAyTZldhMoNIbDBJ1HwBcPE69iOVPeRyGJNmsH5UJ
	XUArNhn85aT2r4vfr80u7SmQkHsIHkKAapkyctcOXn+3InoAIP7DlFca7o8XXl107zjvBGKS61J
	5MehFNcLeppJfN3wFkX0dB+BwWBiQ2pRQSUNhFEPdZ+VXkn0Ez9pdBNZRrQnPmJvhwQVLpY/ay+
	nZymyd065XNexjIHc1Txcg3einYIbKvPFc1Xt22hNuUXgBD/avii7NSdW1uYgooa0BPhnbjwE1q
	yT+NBEtchPV+j7ePobu2FtPG2i6VlzgSCSPNKflZcmDYfowJc=
X-Google-Smtp-Source: AGHT+IEqYiiuWqadmrSa+ocB1xo5kZsyd7pE12wgODlf319TseLh48deAbNiLMyHfUUvkPdfF1Gc1A==
X-Received: by 2002:a05:690c:45c3:b0:783:7266:58ef with SMTP id 00721157ae682-7837266619dmr152519147b3.5.1761092320133;
        Tue, 21 Oct 2025 17:18:40 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7846a6cc14bsm32765777b3.60.2025.10.21.17.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:18:39 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:18:38 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v7 08/26] selftests/vsock: improve logging in
 vmtest.sh
Message-ID: <aPgi3vSJGGfBovRf@devvm11784.nha0.facebook.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
 <20251021-vsock-vmtest-v7-8-0661b7b6f081@meta.com>
 <20251021170147.7c0d96b2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021170147.7c0d96b2@kernel.org>

On Tue, Oct 21, 2025 at 05:01:47PM -0700, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 16:46:51 -0700 Bobby Eshleman wrote:
> > Improve usability of logging functions. Remove the test name prefix from
> > logging functions so that logging calls can be made deeper into the call
> > stack without passing down the test name or setting some global. Teach
> > log function to accept a LOG_PREFIX variable to avoid unnecessary
> > argument shifting.
> > 
> > Remove log_setup() and instead use log_host(). The host/guest prefixes
> > are useful to show whether a failure happened on the guest or host side,
> > but "setup" doesn't really give additional useful information. Since all
> > log_setup() calls happen on the host, lets just use log_host() instead.
> 
> And this cannot be posted separately / before the rest? I don't think
> this series has to be 26 patches long.
> 
> I'm dropping this from PW, please try to obey the local customs :(

Sorry about that, since these selftest changes were all part of one
messier patch in the previous rev, I wasn't sure if the custom was to
keep them in the original series or break them out into another series.

I'll break them out and resend.

