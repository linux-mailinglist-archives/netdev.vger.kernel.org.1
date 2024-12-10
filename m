Return-Path: <netdev+bounces-150569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA089EAAE3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE3918820DC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E598A2309B4;
	Tue, 10 Dec 2024 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJPui7Lx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42BD2309AA
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820183; cv=none; b=U+nR60J0qjbsJjd6bPokYTKNphJ3KBpGNxE+WwELiZxMq9FZpTT5AqBCruq+duCP1HdqwIe8yymeMjFG1ikANEC6KEtV8/uxkt4A+Pp+RTO2G8QSQgh2LX9RpLP82Czhk1Gcb2M5oUhkViTNBMiEE/2EhlVOgIlNGy43xzX7WLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820183; c=relaxed/simple;
	bh=gthI8PZDbtsviiuL24Ic9Kn1i+0akT98OwqMusA9o80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f5PV+0nzdYk/0MSLIM9al+9IIizM2BJ0yMfnDZpi0UytqtKTI86VkvRSMf1nJdN7OAuzY3AOqx0ve0nlqooUIsVIUZIs4tyvnay0q+k+4EC6lUD6ztHoBXrEJ2lAo5FmK04KNuUvCTMaHQw+PAIissLqmrbzW0bL9bXaU2hcLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJPui7Lx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733820180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8pXFWAEjkLhM10kO3M5wqhjCdlxvFoykCNB+vBUV4Q=;
	b=eJPui7LxKqjcYvBS/hBJ+jlA2sdfNwbSwVJRC+Ttso2+wpFPLoXirW9J6bLcoTOoYGn9zq
	QCqZfQA5qhItNFfceWPg51dMobKodSHD7tAkHWXmbmop/DOD+hRT5U5e7GeOLAVNMh1GWi
	6wLfbiv08vfkq8QGaBBbcFWOtdZj2rI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-bi29YppVMQOOxREGVjm93A-1; Tue, 10 Dec 2024 03:42:58 -0500
X-MC-Unique: bi29YppVMQOOxREGVjm93A-1
X-Mimecast-MFC-AGG-ID: bi29YppVMQOOxREGVjm93A
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa61e72d68dso383261566b.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 00:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820177; x=1734424977;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8pXFWAEjkLhM10kO3M5wqhjCdlxvFoykCNB+vBUV4Q=;
        b=JLjECV3sc759jfC+0jft3daTlqDdOKdFFoLhPLwHkncCgc+72fCbkzpOXkv3cQosu2
         ayehPDp85FSAp4EiIoAszrbNyHcOwUe8FqqPbdl5GrttcCbM5+MlOs7Z/TtW09+DPnbe
         rW2RzxBlj9QcAdA4fQetLdcChIXKYUNsdDLiA1hPXWS2FHSs2DwGmoZ1DDRes5oApMso
         N4OpkTd108zVnwQ2abBGcMqQq9fBOA+MxHKArowCLyh/4zc2VZtGsgTyIMTZj20jvzO0
         ZfXSOP8Lr9brPqVHK5XJaIf/Ui9zVabcqZ1au5sOTWxs6QvwltwM6EIzWSmc4fdbBMNk
         gh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDj9rNbDsc3lezwkmnQlJYPp8KQGqTQObTnT5Mh70bFzywH9VqaOvqaq4/dO+uBTst7dhOO+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0sybvl4HSeNHxf8HKOvTXMen6SOmq9MsJTtjfJY+VYEEpS9+
	e0daifoWm8BhSFeR/97hqEL43AXkvEHVT8sir4BLxKMD2tWbJnqEggqYYnyNhoeDk8S0g4IT/0E
	ZIqQdXwDKwDnlxBDqkky636KUNxk5cMuf9DRSQv37nB4iXHkgM5aHoQ==
X-Gm-Gg: ASbGncsMc2e52E2GcbqZJBut5/cl5LfzS3eCc/f0Q4tdn+Mq2b8Y5Ctd+RUFqo5utuR
	jO4po15GznuLDIY+h4BWAC/iX2h7tR+tBAOhJpGttLob6DnXj7qlk0n/8l2nj41i1dWX+S4jN1t
	q0Ps0EtNEeI+nLBF4rOeX6Vc5Gwiv+JQlG8k70aVpCRa+suu6zohKyU7ujLo4LgRfdgaWit2Fhq
	pdkGy6FLhPTW8YUcLjPgj8TwdxZ90qZRyL2bNMRnS34qMDz7Yc=
X-Received: by 2002:a17:906:cd1:b0:aa6:74a9:ce71 with SMTP id a640c23a62f3a-aa69cd708a1mr286591166b.27.1733820177611;
        Tue, 10 Dec 2024 00:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzII+NR1Pxx1i/jdu38fmJ+bPWyh8XhuTrskK85VCnAmf8uLJXoopd9TZcS8ONnFb1+kVLvQ==
X-Received: by 2002:a17:906:cd1:b0:aa6:74a9:ce71 with SMTP id a640c23a62f3a-aa69cd708a1mr286589766b.27.1733820177280;
        Tue, 10 Dec 2024 00:42:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa686bb8cb2sm280815266b.153.2024.12.10.00.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:42:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A516E16BDA11; Tue, 10 Dec 2024 09:42:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Dave Taht <dave.taht@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Jamal Hadi Salim
 <jhs@mojatatu.com>, cake@lists.bufferbloat.net, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>, Cong Wang
 <xiyou.wangcong@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>
Subject: Re: [Cake] [PATCH net-next] net_sched: sch_cake: Add drop reasons
In-Reply-To: <CAA93jw4chUsQ40LQStvJBeOEENydbv58gOWz8y7fFPJkATa9tA@mail.gmail.com>
References: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
 <20241209155157.6a817bc5@kernel.org>
 <CAA93jw4chUsQ40LQStvJBeOEENydbv58gOWz8y7fFPJkATa9tA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Dec 2024 09:42:55 +0100
Message-ID: <87a5d46i9c.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dave Taht <dave.taht@gmail.com> writes:

> On Mon, Dec 9, 2024 at 3:52=E2=80=AFPM Jakub Kicinski via Cake
> <cake@lists.bufferbloat.net> wrote:
>>
>> On Mon, 09 Dec 2024 13:02:18 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrot=
e:
>> > Add three qdisc-specific drop reasons for sch_cake:
>> >
>> >  1) SKB_DROP_REASON_CAKE_CONGESTED
>> >     Whenever a packet is dropped by the CAKE AQM algorithm because
>> >     congestion is detected.
>> >
>> >  2) SKB_DROP_REASON_CAKE_FLOOD
>> >     Whenever a packet is dropped by the flood protection part of the
>> >     CAKE AQM algorithm (BLUE).
>> >
>> >  3) SKB_DROP_REASON_CAKE_OVERLIMIT
>> >     Whenever the total queue limit for a CAKE instance is exceeded and=
 a
>> >     packet is dropped to make room.
>>
>> Eric's patch was adding fairly FQ-specific reasons, other than flood
>> this seems like generic AQM stuff, no? From a very quick look the
>> congestion looks like fairly standard AQM, overlimit is also typical
>> for qdics?
>
> While I initially agreed with making this generic, preserving the qdisc f=
rom
> where the drop came lets you safely inspect the cb block (timestamp, etc),
> format of which varies by qdisc. You also get insight as to which
> qdisc was dropping.
>
> Downside is we'll end up with SKB_DROP_REASON_XXX_OVERLIMIT for
> each of the qdiscs. Etc.

Yeah, I agree that a generic "dropped by AQM" reason will be too generic
without knowing which qdisc dropped it. I guess any calls directly to
kfree_skb_reason() from the qdisc will provide the calling function, but
for qdisc_drop_reason() the drop will be deferred to __dev_queue_xmit(),
so no way of knowing where the drop came from, AFAICT?

-Toke


