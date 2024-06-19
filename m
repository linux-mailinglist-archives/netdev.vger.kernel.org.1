Return-Path: <netdev+bounces-105070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F47290F8DA
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097C21C20E80
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75515B140;
	Wed, 19 Jun 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kanjuCs+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D575B7F476
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718835062; cv=none; b=VpskPtsA0PQztfMLXcQxfTBaszMeB0rniwhh4DrLN1Eoobo1dL20jiHD/Ch2n9szww1Qsa56jcYTCvxTZTtJyf3UXF9J1KyPOUooH+XDxV05Ak24heamehUufupt/RRZo12+orgAYMav7IsRZRmJCmP/CsIGPlG8f8m7/Xcmh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718835062; c=relaxed/simple;
	bh=1O7XBpOcKiVAbzT6N1Mjt8o0tqADZH7Uw8IqvWTvBo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFph64S8ryG56M2MtOYVu8NM/VWrbCf5kTYvR5rTq5OrpbfdiVLkQaJ3LUNsGCcxkyYgFYYtv4rlzmDUd0KNPy3q5fgdU2s3ph4Q9ktLsXz1nAclSfYbyQLEIVC/4guLMxSWKez+9BBy8MdLbmQ9w3S3+IvQSOVvhzFiYJQA//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kanjuCs+; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-37594abcee7so842205ab.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 15:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718835060; x=1719439860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O7XBpOcKiVAbzT6N1Mjt8o0tqADZH7Uw8IqvWTvBo8=;
        b=kanjuCs+y7eNmbyH55EOimXQSKBcrLqrDcxSnPsyQd2J67gXf1xy0VnqDNPEBmWS6B
         2PE6Bom9ft803qXB6cN1O6TeGL9RNnyehyx7V2DbuA5wtVbmOPOhVNU9kt92usCcKES4
         J7c8hyMzOl9pZ74SDt9vzIe0sqfGrkH68TjLB9laLH17gidKwFSXYPyvLe3ftiSzKSBo
         R44fa1MWMIslVoUG8cbJPUOn6cljTZpB+/9oTHXcJyBEpH5K7UlwugmLWZpG23D4ob+6
         KP73Ow7/82ULYavdGF+PHyzBdsflRLHszDGLCMeFECUexkdk0+k2BPq1LKgUxqIK5fSJ
         N5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718835060; x=1719439860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O7XBpOcKiVAbzT6N1Mjt8o0tqADZH7Uw8IqvWTvBo8=;
        b=naiAEvUdpnx62vj3bWO9yz8DYzbrxsWzAY9Y+j6jGCPrAyEBTM/IrNkopv5/M/MmDs
         jme824R+hkMh9HHtODybBlLB7wP8TWYOjxnu+Yw81ZEkwF7PHouXgYu+vxN/TGepsN2g
         O4hCrdRFuQD3Xhz5cCEzxbwRebyEBYraunrwhuyGMOBuussSvhU4pg34TX9gzcqWPARY
         GyOeIDVPGNBnMYAOwkLcuBAvhSLwt2h2ll97rzRQqm2TBJhnqc5tSo8dpvPd2tD0tRk6
         TESuYEecRR8RY4GjLTWAKshjnne/B1b6wz1vaEyt5crNG3C7Z2OKrPRd9nxL/7mTuNUv
         2Zzg==
X-Forwarded-Encrypted: i=1; AJvYcCWavNMx60BygxIa4FEkX8NDd3ck/Kr+qsw3bsa85YOaMOyPqlyYGQwYuogaqpHhWFYIs/1eLc3sKQEdf0QQJT7sYZF39d1A
X-Gm-Message-State: AOJu0YyZAbd+3gDi4PGI4NltnD7daXL40wV8IiClufulNK39F7IL6Dy1
	vb9t4M39m7gdV/hnfek26BGV+2EsS0lhIadtzeJTQgRzdYyBFErfeC3PH73/Cyiz9fFzCkClfz2
	foDVEb3vEJVTTrcNf0FIlwPZKbQQ=
X-Google-Smtp-Source: AGHT+IEpIL58Lg+9MgUDcJV01vsYELCTTBNGIfnVDukRIj3t7Bt4A+DczVtrWHwJHFCPMla2EfSikZaGfWerGhzT7Wc=
X-Received: by 2002:a05:6e02:2165:b0:374:ac3a:e32c with SMTP id
 e9e14a558f8ab-3761d6dcb91mr41115885ab.16.1718835059836; Wed, 19 Jun 2024
 15:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d35d01d9-83de-4862-85a7-574a6c4dc8f5@ovn.org> <e90b291a-0e19-4b80-9738-5b769fcdcdfd@ovn.org>
 <CADvbK_f9=smg+C7M3dWWj9nvv7Z7_jCLn=6m0OLhmF_V0AEFsg@mail.gmail.com>
 <5a9886fd-cdd7-4aa2-880f-5664288d5f25@ovn.org> <619f9212-fa90-44d2-9951-800523413c8d@ovn.org>
 <CADvbK_cFvGT--MVJQ=tGa4bugJ5MeeVbbTqJwNw-Aa0Tf8ppiA@mail.gmail.com>
 <e42d36d5-1395-4276-a3ed-5b914bb9d9d0@ovn.org> <CADvbK_dWpZd6RyqRdiHvWP9SrG1Otfi4h5Ae=yhErLc+DhLkaw@mail.gmail.com>
 <20240619201959.GA1513@breakpoint.cc> <CADvbK_dAB3iHmM=nkbxGJca2c_1J-NK3R4241b3RAvV8Q9Q+QQ@mail.gmail.com>
 <20240619212030.GB1513@breakpoint.cc>
In-Reply-To: <20240619212030.GB1513@breakpoint.cc>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 19 Jun 2024 18:10:48 -0400
Message-ID: <CADvbK_dPyPP3wwjLB4pD2o_AqpXEprkn70M7e=8aVoan+vTDGg@mail.gmail.com>
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

On Wed, Jun 19, 2024 at 5:20=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Xin Long <lucien.xin@gmail.com> wrote:
> > Got it, I will fix this in ovs.
>
> Thanks!
>
> I don't want to throw more work at you, but since you are
> already working on ovs+conntrack:
>
> ovs_ct_init() is bad, as this runs unconditionally.
>
> modprobe openvswitch -> conntrack becomes active in all
> existing and future namespaces.
>
> Conntrack is slow, we should avoid this behaviour.
>
> ovs_ct_limit_init() should be called only when the feature is
> configured (the problematic call is nf_conncount_init, as that
> turns on connection tracking, the kmalloc etc is fine).
understand.

>
> Likewise, nf_connlabels_get() should only be called when
> labels are added/configured, not at the start.
>
> I resolved this for tc in 70f06c115bcc but it seems i never
> got around to fix it for ovs.
I will take a look.

Thanks.

