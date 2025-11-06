Return-Path: <netdev+bounces-236127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B061AC38B7B
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4923034F54C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369B1EF36E;
	Thu,  6 Nov 2025 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmORi/cJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713618C02E
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393165; cv=none; b=MxVjaO5flri+T84vhplex74pRM185DSo3ikY9wlJuY6EtuHN1yWfq/DTMpChaCSNHrI1NCQLSHd8hUhVHi2pT5O3NnHm8nUyzjJV2pSeoIxEYuxKPxhUhmxveyiFGKZPQtiMY6ymMAsdf62HdvgTBqb/dob/ngYqgkEovr/CnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393165; c=relaxed/simple;
	bh=ztUcVf/bg1HwbitQCYcdOybuNOqseoe05mo2CMvjTDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBccyZayHjmm4LbKa5UVaFy5KNlXCnc+bWNQLfmXftmY7wVPmYgYpO0hc/2+bcuSYeHOU7p5y4CtFseD+8GZiVI5iblrvF27w652uMdW3osIYdkrDrDvHuOgJAGpNL3KBR/0+1mUAS6IcUOJ/WoiL5seGOb4yVCwRuc3lPMl9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmORi/cJ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso447305a91.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 17:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762393163; x=1762997963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5GAMkSCmKaVDpURduy5IoWVK+170Wtz3e/6DIoHryw=;
        b=CmORi/cJ5gsVCduPHMqdvwGqI8mcr7RMl2XWzEJvSCrPHWYkvhtUEQSCbozU3iRy7e
         0FP9WswKqbPus+hJ2PVYxwZiXOVgt06yDB2I8rYjAFrrUFJBSnnJ6UX97Lbvvnbxivio
         O+/paV1XAYTlcli63KZyaPS/1GvbMlho49vyZHG48tKnoRAA/S/8EWUqL42heFu1dU86
         pwhwK+wN/lMXVjNyzkDRIiy8Pqnd9xIiOjIljM7veuwPQ15LWQ4XjheQoLRoFqWtNRYi
         ihU+rogd1sKgJkoVgm9U5yhY8ZVfTU2sNbezA5pKul+rWJo79uhxtBLt37+25Atjw5ls
         1cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762393163; x=1762997963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5GAMkSCmKaVDpURduy5IoWVK+170Wtz3e/6DIoHryw=;
        b=RBtlUjCmMZIfyunG6VCIhwpZIx0jOSpPublIFVR7BWSmccmoAv0uPdwt2afwlrIoim
         d06fXh4BB1xw0sj6WxeXZhIMFtDZeeCSHwv3Cdzy/G1qp6ZqWkPdnCaBIKqgHLwKYysC
         0irivIpWZZ3NqZjg1NpQ72Ii0bliFhPpl+VMlc80ayo1wiYVQOa/WojdH0B/YQiU1pyF
         CPIdIXWmqwayjB7wR66flXvOxa5etMcKqknfBe2hTiywB8a+lo09dSnsMQ5K09OX3Sbi
         qTflvI9LHmathvrLUTK8vjL3bLsbz4FHI1gyA29wQ8V4PDUCKhCtxXQKFivcNHNuUM9H
         nYYQ==
X-Gm-Message-State: AOJu0Yw7tRn0LUg3CuvC/lT7ak0UQTr+w7Byvx92M0qIrfoCvy6Vc86k
	cinp757wghF9vTKq+ZMGrIYlLVeDuvsEhatDXsItI48X91E3cSnFhCrd
X-Gm-Gg: ASbGncsRgFDe/2R6VToONzDogr58C9WOXSVk95LU525ylz9YdiAQhoCx4LJmnLBEaSf
	Hg+LU2D2T781Jbj8I9Epp7PIzz4O1rqqIGMbHznBm6iSDVNRlcS+TY+nkmKNGKw8cCfdETA7q6n
	9QWRvqzAZYOLOA+qy7lSLkWzM4GdyuFFP4gwG0Yp91roy10hx+sWQQI8PJ06RxT3fisO3lVD4Qt
	R4Q70ti5VJNdKOR5rQ/lQd6A1M9pSwXKAUdVsNzJTWvKWP9kvw7wpfi9eycy6B7j3VVelkjqc7H
	azXaWTc46a6oP/Or36Bz4IHIE9ZBVbXllGBBhaRcQj5BlC3zVueNIWDgC2JsKGq29GTR7Zy86Ll
	T6j6oZTUyrXHWmbgx1bz3izAKX9XHW3SGEKU2ScLq94tM3VqK/pRQ31680AVVs/Z40YkPcw09Bf
	x0Gi09
X-Google-Smtp-Source: AGHT+IHwVe4L0pODASbsQ69/tO4yEnxMk0v8ybw0Av5K2c9H5WZElRkyQs598BGZsAJXKr9fSAqgNg==
X-Received: by 2002:a17:90b:4acf:b0:340:2a3a:71b7 with SMTP id 98e67ed59e1d1-341a6c2fae8mr6518819a91.12.1762393163202;
        Wed, 05 Nov 2025 17:39:23 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe3616fsm632408a12.19.2025.11.05.17.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 17:39:22 -0800 (PST)
Date: Thu, 6 Nov 2025 01:39:14 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv2 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <aQv8Qgv1G9DDk9Th@fedora>
References: <20251105082841.165212-1-liuhangbin@gmail.com>
 <20251105082841.165212-4-liuhangbin@gmail.com>
 <aQuClqhaV-GiBxFZ@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQuClqhaV-GiBxFZ@krikkit>

On Wed, Nov 05, 2025 at 06:00:06PM +0100, Sabrina Dubroca wrote:
> 2025-11-05, 08:28:41 +0000, Hangbin Liu wrote:
> > +setup() {
> > +	if ! modprobe netdevsim &>/dev/null; then
> > +		echo "SKIP: all YNL CLI tests (netdevsim module not available)"
> 
> Can we maybe find a way to try to load the module and still run the
> test if modprobe fails but netdevsim is built-in? I usually do my
> testing in VMs with kernels where everything I need is built in, so I
> don't do "make modules_install" and "modprobe netdevsim" fails even if
> netdevsim is actually available (because it's built in).
> 
> For some modules it may be difficult, for netdevsim we could just run
> modprobe (but ignore its return value) and check if
> /sys/bus/netdevsim/new_device exists to decide if we need to skip the
> tests?

Yes, could be.
> 
> 
> Or do we only expect selftests/those new tests to run with the
> standard net selftests config, and not with custom configs that also
> provide all the required features?

I do not have a preference. I added a config file to the test folder. However,
this config file is just for reference.

Thanks
Hangbin

