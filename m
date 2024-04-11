Return-Path: <netdev+bounces-87107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA308A1C7F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59A11F23E10
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393BF17AD63;
	Thu, 11 Apr 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PlAenNor"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757E374F7
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852673; cv=none; b=N28dt6esX9G4ZOwCmvBBluldw5jOwELNMqTjI8CFOG+fBjXnSgesQURjTbsGvyj3xL/fZFSMg4M/YluPd5FAXI/UiyMcX1frWipUDdWXCUThC3fepxiyULqv0yizAjWM553gysNPHkAHA/3vQxS3noU6BjY0Yoj35ZmJcJYB0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852673; c=relaxed/simple;
	bh=GmFyxkIi5MV0yBABAIriPfEtB7cqRgs9U5Wg9pNadpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIB6qSoNq6P+xq2UDT0P5P7fTKNYolxQ8vnxoLtezddkdmnPsy4/ArR1S8fqAhwUfJqvfUxBUF7s6MLCvR5apw/hLretZbQTW5kzIl0uvnnIiu0dycUqt1shcd/JV5KdOz5VfYTM7QMywmrf6XmAU6BY4R3g8T/OkQ4qQU7NO+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=PlAenNor; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-617d4797d9bso55303557b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712852670; x=1713457470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phEdRNZ5K3I95qS2yOmEkLElzBH3lKSX7fBRtPvGJbI=;
        b=PlAenNor/7msAKiogA6LktZA7IoKZxDX7j0dX+nPE6PvMnAk/0Z0WrvDifIkGYqFj5
         lti4SlxLP+OU/CL1wpP6kEYgnBcE//508HDMHud5JkOP5f/GXBfsG05H56vcXniFnZix
         NBDEXKq3arlT8+op6j8JBIdy7i8ziZCnRaImrlO826dKMKnWBoj1YH6mg1dePrFb7FT2
         TB3/sRphRc2WZSITEkoy88YJnFaFeVFDSl4rD9mkiN+dbNxj4L+KZJ3X//P45FdmKOnx
         NhIv91OuZ2CJvviipz3rCf0hpdW7edqAdvv6VFkZ7S5BSMVOgZgiWeK0ktkd0tvBCsTN
         /law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852670; x=1713457470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phEdRNZ5K3I95qS2yOmEkLElzBH3lKSX7fBRtPvGJbI=;
        b=LrgtdvMLK9VhSexyNRYbBwqXXS/ShCFF73RF3CIXI90Vbj/DgrJAc1FQ0Vt1LVIDF2
         iFSNdAIIVb87dTee09eUitV5FSnOEyYYEBFpGYDIp9GYu4JDvhEwc+edXIQoVt0y4cYB
         S+aPB/HorOkrXswHacTNy6Mg537ymV59zg2J+f+HgnOy9RnbHQNB7wgDkSCYA0X8GZZY
         nGfitNuP/R+OqwcLBsqsamC79/hrCIQpJYw5OvR2Qprd/UB8E1Ptr4Tw8nZgRRsKNmAU
         PqU191KqAzzq46nrMdbeHLQjzMGv/lsY0l4OBbCFGYFsfiMMGYF9YhmHJSUNJ53TcfDb
         6FSA==
X-Gm-Message-State: AOJu0YyqP0nCbFSVH5izLsiVi/aXENWQRisvZzECMXjTtTBiA7Fi5Aeh
	/zRY4wHvUN9GQngDenSSFrk55l8VBw4M/Zn0wyyiRKohj+2sMNpT6kiV5F1wCbOZzkMzTNKSd2j
	eTnFVUK8qAXqDFNufFb7jEXI55rrqvIXMF/bg
X-Google-Smtp-Source: AGHT+IGAEDWpHn4KFcuOWgDdMfqkVrcmFM4QJ91YmY0zDSiyGyWlNHykCuy767Le/kNMW+HTSvOvCjxjQ3baH6xAu9I=
X-Received: by 2002:a05:6902:1241:b0:dcd:30f9:eb6d with SMTP id
 t1-20020a056902124100b00dcd30f9eb6dmr7015544ybu.57.1712852670573; Thu, 11 Apr
 2024 09:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
In-Reply-To: <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 11 Apr 2024 12:24:19 -0400
Message-ID: <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	Vipin.Jain@amd.com, dan.daly@intel.com, andy.fingerhut@gmail.com, 
	chris.sommers@keysight.com, mattyk@nvidia.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:07=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Wed, 2024-04-10 at 10:01 -0400, Jamal Hadi Salim wrote:
> > The only change that v16 makes is to add a nack to patch 14 on kfuncs
> > from Daniel and John. We strongly disagree with the nack; unfortunately=
 I
> > have to rehash whats already in the cover letter and has been discussed=
 over
> > and over and over again:
>
> I feel bad asking, but I have to, since all options I have here are
> IMHO quite sub-optimal.
>
> How bad would be dropping patch 14 and reworking the rest with
> alternative s/w datapath? (I guess restoring it from oldest revision of
> this series).


We want to keep using ebpf  for the s/w datapath if that is not clear by no=
w.
I do not understand the obstructionism tbh. Are users allowed to use
kfuncs as part of infra or not? My understanding is yes.
This community is getting too political and my worry is that we have
corporatism creeping in like it is in standards bodies.
We started by not using ebpf. The same people who are objecting now
went up in arms and insisted we use ebpf. As a member of this
community, my motivation was to meet them in the middle by
compromising. We invested another year to move to that middle ground.
Now they are insisting we do not use ebpf because they dont like our
design or how we are using ebpf or maybe it's not a use case they have
any need for or some other politics. I lost track of the moving goal
posts. Open source is about solving your itch. This code is entirely
on TC, zero code changed in ebpf core. The new goalpost is based on
emotional outrage over use of functions. The whole thing is getting
extremely toxic.

cheers,
jamal

