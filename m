Return-Path: <netdev+bounces-105036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B86790F7C3
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FDA2861FE
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B115A48B;
	Wed, 19 Jun 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INl0Ht5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243315ADA8
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830273; cv=none; b=Txz0G6dXCeeOLCjWkp+HADTEKBfrbdhwwCVwPlGZaQr24TfFlmviu0H37mhi6Gsg1vmQo/JQI4NC3d1kA/3Ik8tfzDWwlHC7X9s7kVbKi+/ySgHbhzXQE1fWenvzYUbpFBdzU9vcoxjr1jVwQWLbWnejEAWcIwt7/1HFZAF38fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830273; c=relaxed/simple;
	bh=CkTNArM2eu5QCDeOCESuRcNw6Lgp7+pUkgKL0oGGmkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqPYiyLu7Y4YBuVDcRi28mu62evBcpkoRImiLr9uEaJKnL9uW5LVstX/2DZHvVEVW4CfUtAjVnyxtJz6h2nE1o4b3YR/4T5ZaaAeVSuJRga4RmKnro32Qe2J3+D/t3yJJNyz/q7SQORwnum3oWRuGNgZ6rVZjg11MhXTIBGX4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INl0Ht5Z; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-375af3538f2so605755ab.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718830271; x=1719435071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IxPQ0NjXzrJxWXmh6SJFwjWi8x38WWhNCARli02wkw=;
        b=INl0Ht5Z9EDTbgxk8pvuAtVCGJfkeoaOwglkWB5SSEnBvIAh7f6Cgx5JCeBzX4Jz6A
         Vc3eZ0hd52HWsyQliiu35biWEToV7YUWaDAO924KyreOrWFUTRPb/x64oermmLXOt48f
         C1x2ZNRUmTSymmCvwr3XfUYFlaWr2ze1gwl8cJ7GXZmUs6heDcM+88gr9f1zy9XRZYuZ
         G6fD/T2hmvVku1QHZ6w4u7+IUJfAyJRBfmXpmz/siUrp3XLI+/l9OWBnt6iM+fUpQ51h
         3Gz9/UH84/1KOY2bTKvvmryrCM3SGqHA10xGeS5fbABt2SlITrN5GJcDRlJdS5EZYBKO
         JwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718830271; x=1719435071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IxPQ0NjXzrJxWXmh6SJFwjWi8x38WWhNCARli02wkw=;
        b=kXw/YyMgfbC4i1MrVu6Q4wW4tithUps03iVEty0h0Q0q6AzU9sVoF87qkgJr+FFPuK
         Bz2MTT0d5hLRuK0twVbC6nMPMzGfYun7sJhT56abUDebrdGnQaJtVd7xJWHU+gG+RQbm
         LtlK6E6OB/w5eli1jpVS2uS+QwVKA3a62zTbA84een9isXZo+EOHJPNgFmjuaoVIz+oY
         uPb9F9UlVClm91eKcAxsdP3BR8gY1yS34WRUejX3o8//u6q2zD2xtxepVs5uHC5oHjMr
         gQJz7+ZAK2maAGpZt4DvGiOZj3AGRwiOOZDChfj9fKHjy7qNh3rva289K3F1inXZlVNP
         /quQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZrPDbDmJOuAfgqdti5Uv3gS/uVUij3NTVUeTyB48KD2w+JxOTz+3TFgB5SamrCDx5GYfaWdIskmHYYyCNsA/P6FRgKqm
X-Gm-Message-State: AOJu0YwpOfCnjT5fHKmeO9lXtVB9jD2daBtr7Pn3UUomsIJGjCcq1eUR
	WUVbseEkmm/KEVG6m9sGX+u4X9cug/SFskBneyvTmGdTKNW6emYyUiMYIljCQOiEbR7oEB0VJ86
	E6CQy/5EIp6oCf2nKZ+y/kDwTbBY=
X-Google-Smtp-Source: AGHT+IEVlYvlyTZHHb5+Y2JmSwWcRaJkNL0XaaWyOnfL9ep0tcANzHntIKVKm+5jGLaFyY7nO9Ej4YmWCvw+hrMKAMk=
X-Received: by 2002:a05:6e02:1a0f:b0:36c:4688:85aa with SMTP id
 e9e14a558f8ab-3761d6a122emr44351435ab.10.1718830270776; Wed, 19 Jun 2024
 13:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1689541664.git.lucien.xin@gmail.com> <cf477f4a26579e752465a5951c1d28ba109346e3.1689541664.git.lucien.xin@gmail.com>
 <d35d01d9-83de-4862-85a7-574a6c4dc8f5@ovn.org> <e90b291a-0e19-4b80-9738-5b769fcdcdfd@ovn.org>
 <CADvbK_f9=smg+C7M3dWWj9nvv7Z7_jCLn=6m0OLhmF_V0AEFsg@mail.gmail.com>
 <5a9886fd-cdd7-4aa2-880f-5664288d5f25@ovn.org> <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
 <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
 <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org> <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
 <20240619201959.GA1513@breakpoint.cc>
In-Reply-To: <20240619201959.GA1513@breakpoint.cc>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 19 Jun 2024 16:50:59 -0400
Message-ID: <CADvbK_dAB3iHmM=nkbxGJca2c_1J-NK3R4241b3RAvV8Q9Q+QQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] openvswitch: set IPS_CONFIRMED in tmpl
 status only when commit is set in conntrack
To: Florian Westphal <fw@strlen.de>
Cc: Ilya Maximets <i.maximets@ovn.org>, network dev <netdev@vger.kernel.org>, dev@openvswitch.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Davide Caratti <dcaratti@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, kuba@kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Aaron Conole <aconole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:20=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Xin Long <lucien.xin@gmail.com> wrote:
> > > master connection only if it is not yet confirmed.  Users may commit =
different
> > > labels for the related connection.  This should be more in line with =
the
> > > previous behavior.
> > >
> > > What do you think?
> > >
> > You're right.
> > Also, I noticed the related ct->mark is set to master ct->mark in
> > init_conntrack() as well as secmark when creating the related ct.
> >
> > Hi, Florian,
> >
> > Any reason why the labels are not set to master ct's in there?
>
> The intent was to have lables be set only via ctnetlink (userspace)
> or ruleset.
>
> The original use case was for tagging connections based on
> observed behaviour/properties at a later time, not at start of flow.
Got it, I will fix this in ovs.

Thanks.

