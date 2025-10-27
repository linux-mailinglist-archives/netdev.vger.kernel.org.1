Return-Path: <netdev+bounces-233284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB053C0FD21
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 19:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECEA3AEE20
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D293128CD;
	Mon, 27 Oct 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjRWcGor"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE302D8368
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588073; cv=none; b=Rtav/z+c4GP8RXkf74LogdBo+czsuv19gk3fWIxhj5rCuDjzhYU8BipmtAAghYf3OiVpsMH5nx2aVnUeyG3QKNiYptTfTGG+5JW1qiY0Vo2s6aysmdIuXndFCv13HAKVGpY7fOUyg56OHfk68eIji8DNYqkqxflkaG4koB8E/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588073; c=relaxed/simple;
	bh=dSzQwak3RBPC5y51ILTWEaSZmq/yqlFp0KvonW5s3MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLjrPjfGWz62OmeGzwTOUCL+AuJrQDQAl1mrEI/ckGrkC7XErzC3cEV3J7rVYS/t6P1D7GBv3Y4U7oubyaoac4beSWnNNBlqft4B2xjnzVDvU9kaLxkEXDXDTiMmhx/x6sSBNlSwmkRAL8u0CiMJWUSmwYUv4uMsQ/rWz5cCvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjRWcGor; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-784a5f53e60so59264337b3.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588070; x=1762192870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKDbmV9YEl1euYCGiiSOHAmi228vgH4DcrXIQXAImEM=;
        b=NjRWcGorYJ2t1TNHCJoSB0Z0ydloHtrfZ06gOJt1tG+ON1eWeTZo3TtgHGBK+DwJQa
         XUseEvwA9GsRWU5z/VR78PiXJStbuGjjPDQ+ClGtuCMdkwiGiZq4wH44Dt2dS+52D4E0
         bx141hMG7Qn87LKrn9WOMEI3gis6Zk7TBaBa8oI84quy1T6VEUcz3Q20z7zZjQMq2kZI
         NJC0rrGZ7l5kIGd2bSI9ydoA8Ll0+ZX/eQSJwyBLrKe+gMHlsBE74syQxM8T2EWJ0GQ4
         j6gENU6VPCZkiyHO7TcfziL9n/x1TIaVI1jZi8KvqoQMF1FADchbAssaAXQaxF9UiQDj
         Ko5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588070; x=1762192870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKDbmV9YEl1euYCGiiSOHAmi228vgH4DcrXIQXAImEM=;
        b=GCQv7S/2FUz7evJvYOlbroXGY8XI3UnqyoRKYoNdDtY2BtlQyBBiaAxmIvelwO19nc
         Ww/cWgWBKKMmOBuPEmd2vx9/rRQW0+5MGOsGA6n7xX4HLJt3lmnOPtIrXXeIWbYMScLp
         vxKOdbTNrdLspPIJnyB0oeG9zJ0M1eRMj402qUmu0UpsoooeNaPvxoCXcHvgcYaEBK6I
         Z/s045E1Dl7PzjWKwFw/WBcGS73rD3r4FG5Ya/AVTi4DyMceKlwb0OxiKERgX8+IxE5I
         Dm2mfEYCk4fp0SPvsJ3HQ6iqpg+14JDlHVRIaiIK2b0S8RCbNM1vMCUx6/+SDR+LSLd1
         BjTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG7gNrP0d8uamAO64ynC7FicqPBXJ80C08m22r3wgW/SrwE/MlrG4jdPaSwquaA2FtSGbwqvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwXI4t+BSrhqHu7dJfGm5e8qlTm8aWtwJBi+RUJgRRK+V8Z8sq
	n3sjhYfrIyKMsGcoHwpb9ftrz0LjvQQGIpWgJltCZ7ZcOADT6x5C0cYD
X-Gm-Gg: ASbGnct+TK1yr9NsKD5fynZWXzjiDM10HoAEfSV9QxrvtunsV29LXuC9F0b+5L1xUuA
	2cLcWCTKitrpczvkesiv0TJlKxLusdnnqc3zSkiQveALi358VVdLw1cf9DgHdWwd0nUGM+9oUTf
	pE66F/yQdX9+MFVjjpLEBVJolzw97jf0xWILPux65tB0nzBdO7AbJgZWS/SuHQeYsfquUyfpQRP
	iY8X6md9FjPVSUmu17K6f6qu47hN+swtrVwaQNcv/bOv3GplT9IBqJtG8NGZdnoRkLT9cNTubK5
	mAme8r2+N4MZE9AB5f8D2kUX/IAaJfxHM28UrEBcxJwuPjPLAQ2907oZIpSjvfBviDVqO4fr81j
	9Z20s3sZ54KG5LMeGkluwt7Q4t3r0dmyPtP0pOw4HNSPPQwF1/LQfN1sPynAxZ/z7uHuReUZUjV
	N/Nf/ism+ftSeWTs2lNLw64CEdngAjHzvTn8OuW8Fhk8U57/0=
X-Google-Smtp-Source: AGHT+IFWDCi2g1kdSTmc4R6F+QSoxN+p5e395OCPC0UeHMIqjdYpQhTxQQ2O31gfhQCi3Ezja/+T9A==
X-Received: by 2002:a05:690c:4d4a:b0:76f:8f07:4908 with SMTP id 00721157ae682-78617ea3e56mr6919087b3.27.1761588070172;
        Mon, 27 Oct 2025 11:01:10 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1b24e7sm20674147b3.35.2025.10.27.11.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:01:09 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:01:08 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 04/12] selftests/vsock: avoid multi-VM pidfile
 collisions with QEMU
Message-ID: <aP+zZMtf7FwwmqVF@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-4-edeb179d6463@meta.com>
 <aP-keSURBFPZvNA_@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-keSURBFPZvNA_@horms.kernel.org>

On Mon, Oct 27, 2025 at 04:57:29PM +0000, Simon Horman wrote:
> On Wed, Oct 22, 2025 at 06:00:08PM -0700, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Change QEMU to use generated pidfile names instead of just a single
> > globally-defined pidfile. This allows multiple QEMU instances to
> > co-exist with different pidfiles. This is required for future tests that
> > use multiple VMs to check for CID collissions.
> > 
> > Additionally, this also places the burden of killing the QEMU process
> > and cleaning up the pidfile on the caller of vm_start(). To help with
> > this, a function terminate_pidfiles() is introduced that callers use to
> > perform the cleanup. The terminate_pidfiles() function supports multiple
> > pidfile removals because future patches will need to process two
> > pidfiles at a time.
> 
> It seems that this will no longer cleanup, via a trap, if
> there is an early exit. Is that intentional?
> 

Yes, intentional. We're trusting the vm_start() caller to do any cleanup
now. The assumption being that with no "set -e", vm_start() should be
able to return to the caller.

If that seems too bold, we could add some function like create_pidfile()
that generates the pidfiles and registers them into an array that is
cleaned up via trap.

> This patch also changes the handling of QEMU_OPTS. I think
> that should be mentioned in the commit message too.
> 

Sounds good.

Best,
Bobby

