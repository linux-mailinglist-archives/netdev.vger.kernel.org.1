Return-Path: <netdev+bounces-233625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B726DC16714
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A5634E8B39
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410E34EEE2;
	Tue, 28 Oct 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrK9+tTZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5257634DCD6
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761675616; cv=none; b=Cf4t4L7Mf7hdG+oixdmc7GWz3VR6BaQHRFJ34RuCya4oJgNctaK9U6k06djLESb+EFr3gVW8zBAS2G6dQicSXA2QpLY1pR9PTksDbG/+M6DDoX1/okI2DghmG/LaCYrQl7O6lokJpOQUHuebMCKWoABiazB/3Y7ikq5yqsuCAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761675616; c=relaxed/simple;
	bh=fVD8zVGoOJR8NtTaumfAAfOnBXb59cGQbZXEVlQfwd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfs20Vt9sxiNZCvObRndVMGN0dmcZrJzySUG9xZmMMouKt67UfITaegawTs9C7SqJOFQjd8fsk2Vnty/AI7Ioctl7aqr3l9atOd72byENECFqDkCCltulV+07bQo2Vm04Hqy9TPlHrAz1fcHyV113OfoGTdRgabk0PJaDMVd+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrK9+tTZ; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e3a7a67a4so6816320d50.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761675613; x=1762280413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+rUkvl/D9zKzyhn+VEYSVN5inKSvpG15TNg9Q9Niq8=;
        b=NrK9+tTZmtBoFdCEqOScvruet8btNL0A/WQIwbU3hkehG1AbI08JEmxsP5BfqQOX7a
         tXoYBGb0LQx2FYPOAEkfXMCw0mOebE8IrIlVM7cf8AQXDZ9bhMA9rV0iKd4UeAYyQ4aP
         H//SXIbO7HrnmBmMDGIzb/taC/32jDu1fenhChBvVpZ8orobcwRbSl+hrcD/PIxNeIsR
         S/qoVdm2HBpdwhNPNkpa+4f9JlhxenUdpY+Xn6uSZ6ntM+1byLwMShcG7SVBPQX+8mX3
         PPGEWCPJjNK7UOPWV45JBcqRK39tqroXcFYlOt47J/+TQmcUfQp5ZA49fh8g4GLIpNfZ
         FsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761675613; x=1762280413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+rUkvl/D9zKzyhn+VEYSVN5inKSvpG15TNg9Q9Niq8=;
        b=psQz8UzVJ6n1r52ro7uuhQ98qZiFa6WW7EJD6o2s6vsTNuFH/OYira/0R96lUSr8Yy
         Eap/w6+Kfx0hucKzQfDiCKBMHaF2VxUkjsnfDzJ1BFqWnc8p82m/EU7h3VKOaNO9UBht
         m7HlgO/bI8H+p5+muXfD2oa4xY22qmIBYaxb0hKJfnTEpc59zlBJJaWwYj3T+GdPOKZu
         GU8l8TEF7hDbNFqtprvn5bwGpOeE47CZe5bjMegf2aZ0UjjuJiZZJHDiygGyZ1liNTLS
         VrdZBmE+KtbvLfdRsHyUao9GkROxJiyXZ7oyiLYphFQBT0iEgDRIkY0IqN2sp4m5f/i7
         YOqg==
X-Forwarded-Encrypted: i=1; AJvYcCWN3JGYyQ7UQ/RrY7N1TSWVoJ4PcQ1o7iwYvXtKRpgGlp8m3bSuIo+zQWFWLJHtK9W3l/v3c80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpIPeJhGiFKSAS50S2DJJB+tlANGArAW1NQ12lUbJs8YMymc1
	cf82mNrrbseNK4e8qCLXT8cv9NqoVmtaZAujDYRdTdDQky7lmEyrPcr4
X-Gm-Gg: ASbGncux3Q8Sl5hocLFr7M2eTSlbHueBGpGwMGlz0XJQMeCdQPRYKpjd1JbPXL77okX
	BNUCYag7Ky4yOi+1D4Evs+sttzmmeXSy11Isft6NnP0xuy+HPfOFxIJOh/2NgAffg+xFxIY79Kj
	8MJ98FSfWIYWT2yfO+BmJAMC2eG+Ln0q3h239Wc0rW6Wd2EFe8OihpJzbiYU+8L45BZcZWosBU4
	MCiddCfmZjqRK+xjQUWI48pFr/24/GIcZebbuE3juQPQQXNUTFtZaCT9AfpSaN+g7dme0GX89TG
	tMzigSwUBD6B7KPs0MjiCrunRQrajQxbk8YUVYpbi6MCDGT3BW8hP7amemwkKxvyMZrJCoOwmFz
	v7Ig+SNboMAuQ5J8rgiUPT8WtLG6y/GRdUn1ZvoUaKDfEhmS5nOsNVTGani7J6ItHb4tOHcJ/A9
	NQnrFHCSb2qyqOsqtPiBKx7Xqe5DH4GG6clEGd
X-Google-Smtp-Source: AGHT+IECradbC/V5zPn66y4q4ZGUhUmHrlC+iHH0inghtcGySqIEBdHH/OeoOeHNcRqi2EB+aeyQgA==
X-Received: by 2002:a05:690c:25c3:b0:783:7081:c48a with SMTP id 00721157ae682-78628e7d68emr2711617b3.26.1761675613298;
        Tue, 28 Oct 2025 11:20:13 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed14081dsm29213987b3.6.2025.10.28.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:20:12 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:20:11 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 03/12] selftests/vsock: reuse logic for
 vsock_test through wrapper functions
Message-ID: <aQEJW9hGIPbWsRhM@devvm11784.nha0.facebook.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
 <20251022-vsock-selftests-fixes-and-improvements-v1-3-edeb179d6463@meta.com>
 <aP-kmqhvo4AFv1qm@horms.kernel.org>
 <aP+zgF7zF9T3ovuS@devvm11784.nha0.facebook.com>
 <aP/DQLcX9uaY6kXN@devvm11784.nha0.facebook.com>
 <20251027162244.0101a099@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027162244.0101a099@kernel.org>

On Mon, Oct 27, 2025 at 04:22:44PM -0700, Jakub Kicinski wrote:
> On Mon, 27 Oct 2025 12:08:48 -0700 Bobby Eshleman wrote:
> > > > shellcheck has some (new) things to say about this patch too.
> > > > Could you take a look over them?
> > 
> > It looks like the errors are SC2317 and SC2119, but are false-positives.
> > Invoking a program as a variable (e.g., "${VSOCK_TEST}") is tripping
> > SC2317 (command unreachable), and SC2119 is due to log_{guest,host}()
> > being passed zero arguments (logging its stdin instead).
> > 
> > I also see that SC2317 has many other false positives elsewhere in the
> > file (80+), reporting even lines like `rm "${QEMU_PIDFILE}"` as
> > unreachable. I wonder if we should add a patch to this series to disable
> > this check at the file-level?
> 
> Yes, FWIW, don't hesitate to disable things at the file level.
> We should probably revisit which of the checks need to be disabled
> globally. But file level is also useful for manual testing.

Got it, will do!

Thanks,
Bobby

