Return-Path: <netdev+bounces-89650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40728AB0D0
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6C22839C2
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A212DDAD;
	Fri, 19 Apr 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UH374PhP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5D85938
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537245; cv=none; b=nwEZrf9s1fgASDfAXpFdqOcZk53komP7mxsa/2vjydLhRTget6tz21Qnc965TVuw7PazEjAX2bcQnnvWp6jf0SffGA91DbqXfLL/zsNOTlUUUP1+bDyHEvsDt4oEWWTijckCLGDsMwSCp9dPJTb4eEuNRXEz7/OuYt21F68DRbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537245; c=relaxed/simple;
	bh=LmUPXtdUwl/3j511AFiavWVVy7AWh+sIicD9u2g41GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHIG1vSknjdZcWWndX7zxmPP5EUUOJcUvgnOdO60opgPMmzWTIPfWSDIJntxmWKGikzD74QdWcLL3ZC/GC5XCIS13y13Ka0LuqnXB54v+RJdrlarb1Oo5kDFeDr6Fnx0HiHfVBBE5wRobYQ2SV9++m8OE0C2M9bS8FLzYNnKykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=UH374PhP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ddda842c399so2167075276.3
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713537243; x=1714142043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmUPXtdUwl/3j511AFiavWVVy7AWh+sIicD9u2g41GQ=;
        b=UH374PhPRmR8IuuSpDpoAemGzP5Ax/G9UIatJ7QJdSGWwTMMd9pE7VZ4zouo3sgFE6
         c+BFhl5JdhRy84qF5Tds5Vjax3tb4LNf4P3L6HyjYEDPLM8uxKLsvWz6mu8lSwHFVoH3
         jhVmxjhxpe5TZ0UuUjrIUEh+mHE3Ujh4guoEtcST2azG2oKTt6rma/6UJ97w78p17ZBL
         ghLA7cu1ENqzgZ7xav7RZ1ahTFub+ZhzeqDvZBOIMcCykOy4XEouYoPgxA8ggPTAZjbQ
         FFeovvsrk1nFv+2k8ltkXhApjN5MurdqE1sI8uuICRH5UGQ5foyTUhwvSZldYANAKeDY
         mCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713537243; x=1714142043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmUPXtdUwl/3j511AFiavWVVy7AWh+sIicD9u2g41GQ=;
        b=v+lyvi2AYTWL9O8SBIYzVXX5Ks6Qri2J+FwSGmZV2U738u6B9A8343bI/whXOiSy+1
         FTuKwPqVIQ6gSQG6Nm6YVTccy4PSf+mCZlplPTVpnwmAPQXsGIbpZ9WrpRHH7g94Vkih
         bjcrP5tn5iMOKzwGEW2Y+ctD6/e/L+9NNarzm6C2UimUUaxPxMH1iZVNyYIDiNieR/QU
         xATqqqchrAqTCSiG0QZKdKnFbEKBRdEY3gFR4+4zcOjVu2jWofnHi6RpQdV0skJVCStk
         Gpz5M3uhNSqOLjJwzQ6VX8TsobQt8qOh+DlwKNjHnruq4uM/SpBz4YHr1r1UPsC05sOZ
         ImlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8KuXjJTv+1sW/oeb8+Frnj1bqg1vTDkk+tkgtPgtcSp4Zm/Mx+CNpij6WtR89rvNNA31C2ttzzrcVAKESFJMhKg/quN26
X-Gm-Message-State: AOJu0YzxHyfMUCibJtK4+CXdtZpDawvcuDbHRdr00q5gvV92TPXSAAO+
	dMaOIftGkrbyiAsy4wUJyDP+ANolWXimWsyck/fCu///vVnjVoe7mRmsFbRILjQaQNtayUYSTnl
	hTgHHC9cs0Q5JGzJZm4/os6zRCxeGss9l7Ugyf40vPBdvnnM=
X-Google-Smtp-Source: AGHT+IGLO4IIjo5c0cs/TKCirDE83gmSpTfTMSx5rq04N9cAEXxKp1gQHvguepJOQRKIfPuPp/N+eDSGcmbV25hsulw=
X-Received: by 2002:a25:6b11:0:b0:dcd:128:ff3b with SMTP id
 g17-20020a256b11000000b00dcd0128ff3bmr2433728ybc.38.1713537243402; Fri, 19
 Apr 2024 07:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com> <CAADnVQ+-FBTQE+Mx09PHKStb5X=d1zPt_Q8QYUioUpyKC4TA7A@mail.gmail.com>
In-Reply-To: <CAADnVQ+-FBTQE+Mx09PHKStb5X=d1zPt_Q8QYUioUpyKC4TA7A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 19 Apr 2024 10:33:51 -0400
Message-ID: <CAM0EoMknntbtdZY32yjA8pUHMONfZyO8gbxkm31eSKj19NBRhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	khalidm@nvidia.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	victor@mojatatu.com, Pedro Tammela <pctammela@mojatatu.com>, Vipin.Jain@amd.com, 
	dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com, 
	mattyk@nvidia.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 10:23=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 19, 2024 at 5:08=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > My view is this series should still be applied with the nacks since it
> > sits entirely on its own silo within networking/TC (and has nothing to
> > do with ebpf).
>
> My Nack applies to the whole set. The kernel doesn't need this anti-featu=
re
> for many reasons already explained.

Can you be more explicit? What else would you add to the list i posted abov=
e?

cheers,
jamal

