Return-Path: <netdev+bounces-89656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16E68AB120
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36FD1C21853
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D8A12F386;
	Fri, 19 Apr 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qyfckNDu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B797D07F
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538566; cv=none; b=R+3aW8/0wSWl52/dKH79mgKcZtaPujbjJZlxLkoLalpwN5uDt+bdwGSjQ+OKBab9u+SVLQgQFJBx5V/DfRFbZJmBwQU2POafjydF8h6bHOZ5RJLV2ldn+tEW+BN9EtxV+wB9GKVzNqxuV//CikgsEgTkwFDlVJw004JZAixFJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538566; c=relaxed/simple;
	bh=fZ6egbJ58oe8djg//o9anbSRMQs0/bEKxO15c2sB8x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLcDxpSw/4KYuMWbDPRnSyN0PyR5nS7GMNJu8FfY/QfllBSEN0fFV4GIzRBRd7P/a2z4FBclvOfSOqkszgDP7TeZ0ye24zcHAgjXl6zhPIPqGM9Ypzc6GE43awIGU84lRQi/UbR4SkG3N66+NA6yTUVt9oL+Aza70vv0Au9mNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qyfckNDu; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2213262276.1
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713538563; x=1714143363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ6egbJ58oe8djg//o9anbSRMQs0/bEKxO15c2sB8x0=;
        b=qyfckNDuVEoP+j9ejaxQrjvu1jKvZ/yQ4A4aeqs944o5cWXQy/8Wr3W9P4f7heUUoQ
         7wkQbdwBFe/eoBO8Gr+v55uKmDhKDjv9yLJ89G9FwCWaHgXGTA2alL6VixKhB8FZ5Snu
         tf3WPXjioBS8uq/3nzQZWdeZR+v0nxpBQxMtzCu0UMiWZGHQvrpgXY60PzjazvZCG/NK
         ZzCdsZCXqHuI2aptHWJNz5LtxSbMhvvyeMRnkKPtViiBjXzqEhYPw2LYn9ozjH1IfYRT
         cbuqR+0yTpCRsQT9hNRALTTLtrS686lNTfbl2GeJhWr1UuTv5nS8HAr7Q6RrUPxC+h0H
         crhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538563; x=1714143363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ6egbJ58oe8djg//o9anbSRMQs0/bEKxO15c2sB8x0=;
        b=qBNf0SmOuzx2bKnCsW8Yu35WiQ2/Ucv/YMTFW+TW0yRADwP0SswlXtnkBLJOWx2jOg
         z24M2eS8wGt85Kg9RRrQM1A9HmDLmwrzwuwsgvU8MnVYAx8/fqFP6wmxYq5uRELneS7X
         rW+CNCf35pJ+vPaTvBPYCTAmNF+NU7Hp1PwcGJ9lHucjGDAkP4fCQxFxTRvOxQ3Gaq66
         epcEtHKIZTEdxL05oVunP4GsvRHgGaywt8zCqKDnMRxSU1IoyQyA+Ec/9gdNycSmF2Hk
         3vnQH7vtrGpdr7lbG9A/4N+wAnvhMwFV/urRMSSLo0UyL+w3GIGOAOytnZZ0HYUxElAZ
         2F0g==
X-Forwarded-Encrypted: i=1; AJvYcCVmh7pl2PNTmne45l3DWPBQ9FUUXlFctQS7K3OEkjGCr8Q8DtXEq9lZ0/D1bX+8KT5KQHNXh7IjWQX67G9khfLcTvk9Y5Lp
X-Gm-Message-State: AOJu0Ywj0AnEaTqsqHRXvCZQyoCoXyuA4eKhwIpKiHvhMFHu2+MRMjKA
	oFY/eNGfIG9isRpATG9C3jE36OEPvUCeAE9Cce0L0YGq4SdrB84YvOSgKrTlE9mqZ3XQ1TYthpY
	MabPg40emFHBLj1S5kvXCgagV3UNePqTpcquP
X-Google-Smtp-Source: AGHT+IFcoIFftT/JtZByVpfirvuZuRERqN9daU0k6sXI971BhoczvC675liVI7NXpOWSmTkUGNco15bo2JBX+qBTtbg=
X-Received: by 2002:a25:ac82:0:b0:dc7:48f8:ce2e with SMTP id
 x2-20020a25ac82000000b00dc748f8ce2emr2241753ybi.37.1713538563424; Fri, 19 Apr
 2024 07:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <CAADnVQ+-FBTQE+Mx09PHKStb5X=d1zPt_Q8QYUioUpyKC4TA7A@mail.gmail.com>
 <CAM0EoMknntbtdZY32yjA8pUHMONfZyO8gbxkm31eSKj19NBRhQ@mail.gmail.com>
 <CAADnVQKapK1iUrX+vED4pq4LGa8sM6V0FgYotvHOuuc+0D+K4A@mail.gmail.com>
 <CAM0EoMnHsxKHSqGVLWoYQGDDnY-Ew+hMvnY5_jzwfghRGe2EHA@mail.gmail.com> <CAADnVQLZcdOHKMdrm1vAAJyOAqPmf7vA5ejvYzkMz8GZpcJmcA@mail.gmail.com>
In-Reply-To: <CAADnVQLZcdOHKMdrm1vAAJyOAqPmf7vA5ejvYzkMz8GZpcJmcA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 19 Apr 2024 10:55:52 -0400
Message-ID: <CAM0EoM=i1_1+UyPKRejfdk_OXkSb4fO7sOeN+-DNRwED8NX_SA@mail.gmail.com>
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

On Fri, Apr 19, 2024 at 10:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 19, 2024 at 7:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > You dont get to decide that - I was talking to the networking people.
>
> You think they want net-next PR to get derailed because of this?

Why would it be derailed?

cheers,
jamal

