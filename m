Return-Path: <netdev+bounces-102624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE327903FC6
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E421F26A27
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AA523767;
	Tue, 11 Jun 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UJsR2+Ko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E81BF3F
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118650; cv=none; b=lIGFYam4G+CkGb40tGXuWuLtbn60o9zZVUyyMo8HbLgIjcHfUpX/RW+sxx6jy5y5KGftvIdUFp+OW4Zo9eEHYIXGqWTvNcS/3hF6IDSjUEIuBD6ZqoeMGP0+jqNYeTjbIjyzB6YEIH2F7IZpzN0HRL0lh1zOvhbdZV+10Wwfud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118650; c=relaxed/simple;
	bh=vrx3h8GYc6po93l8uT/2iQmtPiUfm5JdgQouJ8pAT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ7Eo48O3iopEa7UWFa8lwO+ymooCbW7cIEFAY292T9A98jBCkRyGTA5rZPXmLhNyGIVnlasQqtTiIoV8S27CskSDw2vY+ZfIBL0wH+w+McN02Bub8ykPQY59yYeukVrQPBVQCU3fJvs62les63Qw274vnLsJOFXbXNwjFBY6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=UJsR2+Ko; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62ce53782f4so15513247b3.0
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1718118647; x=1718723447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzTzC4f5HaADCEetfHfPGdcOia2V9TsSgao4VNBcd3M=;
        b=UJsR2+Koo0JDDxl/01klw0aqodnTPaXapdJzny/9oJAN/2makwClDExcFxhIF1NvqM
         yPoneOxCS25gG74AFX33PkweHRFOfplcrfIVqTBSn+xHNff8lC/sVA1OzlxLSSzOzYZL
         FnVRtitmYTySITSqYqv4FswU9lgH+3NuTKSTvqqVFoRJOf2vKJNLQ0bkq/rBdR0vtATb
         x2t2jIWjCbxY3d4iJWVlJMfmEPfNHIMuwRaYlRKtad4LQULj6OhjGo446sIUxocPjjPp
         jAQMuCT9bH+mzAdbdC0uGNaxby8DdGYGt1FDiebFfC80oeumQBFU4e55IfD6bwH2+GJc
         F/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718118647; x=1718723447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzTzC4f5HaADCEetfHfPGdcOia2V9TsSgao4VNBcd3M=;
        b=tPSv0mQl9S1YGxv27elVPQt67ui4OtHuhEpVV/x8QjH4OfylYrAVE1eTKU4qcJ9p03
         srGn1rY2Xr6NGA5KzqUvwbZDcB1xIrTYRniS9DP3nSDtV8kWhLht8eMBGal0ZuidTXBD
         56hfJAMeqAIhN3dXM3VQXiWEH+WYybMGyFBHw8DcQnGK6SdK2UIMU27a0SLEwbO0k3If
         4IOIQ1qaRVPCGNYDGygtdW1vNEul/Bf3QOU/ybTLEmvmP7THOHWgAXiULct8BTHmjHzH
         Z0+AuQGm7uoW9flpGrb2RAUiTKJeq5DZl5xsTGp+koUeqTy+iR2Hu0FAf/aE/DiepD/r
         Ir7w==
X-Gm-Message-State: AOJu0YyiY6kMPzmOkfXZ+RkkW1eh2Z+9K5bh6bfSTDrA4BUmU9y/VyWE
	Qmm2sA8ID3jQ/X/EDhhyyQlY8H6StADV0xMSPthkM7R4e4hiAtmc/q+nDOgJWc/UMk2bnNP82uy
	Sw5avJ5xHcO3WqfVZ8Rae19YUsfjKCbCkb4oY
X-Google-Smtp-Source: AGHT+IHIisuZw2rSU1hWsa2r0g1Y28TPjVu2YC9yVMCKgH9/0t2H9KD6ayQ5GJh7eYFaiRBQZQl7l8eDd1lk5F5z4l8=
X-Received: by 2002:a81:f00e:0:b0:61f:fa18:ba08 with SMTP id
 00721157ae682-62cd56861b2mr128911927b3.47.1718118647185; Tue, 11 Jun 2024
 08:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <20240611072107.5a4d4594@kernel.org>
In-Reply-To: <20240611072107.5a4d4594@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Jun 2024 11:10:35 -0400
Message-ID: <CAM0EoMkAQH+zNp3mJMfiszmcpwR3NHnEVr8SN_ysZhukc=vt8A@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	Vipin.Jain@amd.com, dan.daly@intel.com, andy.fingerhut@gmail.com, 
	chris.sommers@keysight.com, mattyk@nvidia.com, bpf@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:21=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Since the inevitable LWN article has been written, let me put more
> detail into what I already mentioned here:
>
> https://lore.kernel.org/all/20240301090020.7c9ebc1d@kernel.org/
>
> for the benefit of non-networking people.
>
> On Wed, 10 Apr 2024 10:01:26 -0400 Jamal Hadi Salim wrote:
> > P4TC builds on top of many years of Linux TC experiences of a netlink
> > control path interface coupled with a software datapath with an equival=
ent
> > offloadable hardware datapath.
>
> The point of having SW datapath is to provide a blueprint for the
> behavior. This is completely moot for P4 which comes as a standard.
>
> Besides we already have 5 (or more) flow offloads, we don't need
> a 6th, completely disconnected from the existing ones. Leaving
> users guessing which one to use, and how they interact.
>
> In my opinion, reasonable way to implement programmable parser for

You have mentioned "parser" before - are you referring to the DDP
patches earlier from Intel?
In P4 the parser is just one of the objects.

> Linux is:
>
>  1. User writes their parser in whatever DSL they want
>  2. User compiles the parser in user space
>    2.1 Compiler embeds a representation of the graph in the blob
>  3. User puts the blob in /lib/firmware
>  4. devlink dev $dev reload action parser-fetch $filename
>  5. devlink loads the file, parses it to extract the representation
>     from 2.1, and passes the blob to the driver
>    5.1 driver/fw reinitializes the HW parser
>    5.2 user can inspect the graph by dumping the common representation
>        from 2.1 (via something like devlink dpipe, perhaps)
>  6. The parser tables are annotated with Linux offload targets (routes,
>     classic ntuple, nftables, flower etc.) with some tables being left
>     as "raw"* (* better name would be great)
>  7. ethtool ntuple is extended to support insertion of arbitrary rules
>     into the "raw" tables
>  8. The other tables can only be inserted into using the subsystem they
>     are annotated for
>
> This builds on how some devices _already_ operate. Gives the benefits
> of expressing parser information and ability to insert rules for
> uncommon protocols also for devices which are not programmable.
> And it uses ethtool ntuple, which SW people actually want to use.
>
> Before the tin foil hats gather - we have no use for any of this at
> Meta, I'm not trying to twist the design to fit the use cases of big
> bad hyperscalers.

The scope is much bigger than just parsers though, it is about P4 in
which the parser is but one object.
Limiting what we can do just to fit a narrow definition of "offload"
is not the right direction.
P4 is well understood, hardware exists for P4 and is used to specify
hardware specs and is deployed(See Vipin's comment).


cheers,
jamal

