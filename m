Return-Path: <netdev+bounces-70703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADDD850146
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77C3B23C60
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4D63C;
	Sat, 10 Feb 2024 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="U0+twy8c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15021364
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525947; cv=none; b=X3ralBiEOZMfJy3lLgHvo5Ofc/xOqKfSFZp7To+TWXxKySidsWffr/QzSIWdzH80PLvm/urfHcYtnR5HRsZi36ewMsBm1wyVa4iff7zUUt/8WNH+Ph2/sdsidc+pLs6RgmSSWI8cTMvnfbR0BjD2rlRff/T/C27EM2fIbUoNHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525947; c=relaxed/simple;
	bh=N0L6bbvU/sQkVR5NzmliaWfVTn9kYLZAd/ju3snS4WY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHQXuu73XowrubDtTY8l4aiVhmDiuhvbK2f8orf1yJ1ZScg41UwM/Qhr+ge+ZFSw8ORtW2ztqdDK6NQfqamJmKQ/laXPjzXKwaaIGnsM2bUE3WS2Raw1PJO2Z4Y4QoxskpJhDtdaSpTbbRGp50xkte2ggyjJdbAhUBpS8QEB9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=U0+twy8c; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7431e702dso14572275ad.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 16:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707525944; x=1708130744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVm3N+REVhY47TinGAjjHKam36Q/EHWemsRE22AiopI=;
        b=U0+twy8crSK9dJ5VQAvfTffEYeg4w14MOWrkDImBbuGF8bOMi1R+I+xAVR4hCGSdJH
         SU65SH+lG5KOsPvnzOStocknezgScCprifkO+ZyMhtrAKPGAyufJIGexa9YtY9b4XTk/
         gCUvuNz7GQuNMbTUeN+EhTVpZkV1jKV1LBF8qbf5UPrWUrCHmfzlbqCeTXkHkd6e27aB
         0Ls30hmn+AU2QefwJAECtWZ6glbVCMXT1UWjdRspyHf0f5Mf4TqdBfZUfs6iT+r8RcoN
         QXlb/gqvJQVg2YUilZGX4uPwqc3V2e633S2+zNGdP5akGdkcO8h8a3QSD+jtg+G51GM+
         7J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707525944; x=1708130744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVm3N+REVhY47TinGAjjHKam36Q/EHWemsRE22AiopI=;
        b=qMO/WfPXVjdpLrVDyUFwWjPFkjJAxFFTj8AFoRwpyYZByikD2AmwFUv1cwghSdzZ94
         fAGFezK89wpZ8HmgDLcddkmB2GdvQIPdHlkA5D1E6K8Lq8kyN6v1+nhLcA5wxdh0GQ8D
         8dW8oMX3CSBPUyplUrRvGKLWubBPjsf/3SyogOvv9ZMmNUZreVzzocKruqFn4BsKDuqZ
         x+ULJwt17MjYUpSyFZxjfxLf4m/kNL7GpGuJdioIgaY563BgiiAC7lczrw2C1nGsqFE+
         aBjvs0Er8gT0/4o8QY4V605iIhv9dqALtQxtnrG3LKsBnwy+XIVrVJiRm3s33mU4X2/7
         PKOA==
X-Gm-Message-State: AOJu0Yy1OMlniSBL8Dza6ATxjMaNDAjBFz01zVxkEY4gT34WL4zG6eKC
	ZKH2XJGPr8s7OY3/lcohjGlLhq73faRS2OS1rwQ4eMDYi5fn+JORUIZpgCPVLbo=
X-Google-Smtp-Source: AGHT+IHRRy+Hxak40FoG4+2KTLlBfYwt4+9rn93idEIbyMX4Pq8yViP4H51/dbG2QX51W1TqturBgw==
X-Received: by 2002:a17:903:246:b0:1d8:e4b8:95d6 with SMTP id j6-20020a170903024600b001d8e4b895d6mr946529plh.27.1707525944303;
        Fri, 09 Feb 2024 16:45:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuE8FIQ6l0Swv72XLaTSInYcmGjfBz5cAV/5qVZ+a+QO4pw/nv28DTfNfyt07ESS3/QePrS9z0j4n3Rgjc+GL1A1YrXXTaWHOi2QK/WJq43eTsFoQWxlcOSpdk
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001d6f29c12f7sm2042949pld.135.2024.02.09.16.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:45:44 -0800 (PST)
Date: Fri, 9 Feb 2024 16:45:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@gmail.com>
Cc: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
 sgallagh@redhat.com
Subject: Re: [PATCH] iproute2: fix build failure on ppc64le
Message-ID: <20240209164542.716b4d7a@hermes.local>
In-Reply-To: <3730d7e4-058f-421f-8ecf-a9475440ef58@gmail.com>
References: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
	<20240209083533.1246ddcc@hermes.local>
	<3730d7e4-058f-421f-8ecf-a9475440ef58@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Feb 2024 15:14:28 -0700
David Ahern <dsahern@gmail.com> wrote:

> On 2/9/24 9:35 AM, Stephen Hemminger wrote:
> > On Fri,  9 Feb 2024 11:24:47 +0100
> > Andrea Claudi <aclaudi@redhat.com> wrote:
> >  =20
> >> ss.c:3244:34: warning: format =E2=80=98%llu=E2=80=99 expects argument =
of type =E2=80=98long long unsigned int=E2=80=99, but argument 2 has type =
=E2=80=98__u64=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99} [-Wformat=
=3D]
> >>  3244 |                 out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
> >>       |                               ~~~^   ~~~~~~~~~~~~~~~~~
> >>       |                                  |    |
> >>       |                                  |    __u64 {aka long unsigned=
 int}
> >>       |                                  long long unsigned int
> >>       |                               %lu
> >>
> >> This happens because __u64 is defined as long unsigned on ppc64le.  As
> >> pointed out by Florian Weimar, we should use -D__SANE_USERSPACE_TYPES__
> >> if we really want to use long long unsigned in iproute2. =20
> >=20
> > Ok, this looks good.
> > Another way to fix would be to use the macros defined in inttypes.h
> >=20
> > 		out(" rcv_nxt:"PRIu64, s->mptcpi_rcv_nxt);
> >  =20
>=20
> since the uapi is __u64, I think this is the better approach.

NVM
Tried it, but __u64 is not the same as uint64_t even on x86.
__u64 is long long unsigned int
uint64_t is long unsigned int


