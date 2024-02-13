Return-Path: <netdev+bounces-71362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977FF853135
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DBE1C26665
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63984E1D4;
	Tue, 13 Feb 2024 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAHIOQE6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7171524C7
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829380; cv=none; b=UBr/BtzzsP2AJVXYAxbUEMVjrnS9ObRTvUKc7pNRswzdXa66u73k8M9UjudFtoP2croUvQjglDgbtGIt9Ye6jSY3hksDZ60UiHmcjrMAyDh1UQP6ckTi+zsV/V0o+NUC+rVDkxulnVezpCNXRNiZRYWVRk5oAB2yniGUiAIXH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829380; c=relaxed/simple;
	bh=YedzfWSVK+A61oslR7sc8w2btIQtq9qUjBd4eRp96eA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYWnBsCwMiOOW/0fVoWYm1zjpK7KrTdBSu4gh30ThYZ0ZIBCDlyKpufxcxhNHd/UYDK4PcOerNZldVLt2FW9RmyigKLHN6qdljxrnWYBzN85WAGEOIqR223ILjrhK8TqYEb9JlMLmdvm9q95LyrmBOejzbVbgDN37qoY772Ns2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAHIOQE6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707829377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i8kYXyGgch0IGZQHcjtOlDq1UqD7dBghRvSDg1lEfYE=;
	b=BAHIOQE6sMm9y+B5Olvzi9MU87E4bK8PbkoEh8ObumWOSsUJu2xp7YvtvWuOg9SThuXgPK
	Doep/O/paqPRnvdy+VrSXNZlObJe1R9FV+QPEmW9LPXnigJD+SeMMQkFbdjWPDDVtRWhDk
	khG2Tz9BRRfU17DHwX8x1rljWr4ixvg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-aBFJfjOYPlC5H5XCrW-nPA-1; Tue, 13 Feb 2024 08:02:55 -0500
X-MC-Unique: aBFJfjOYPlC5H5XCrW-nPA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7830635331bso184309385a.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829375; x=1708434175;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8kYXyGgch0IGZQHcjtOlDq1UqD7dBghRvSDg1lEfYE=;
        b=n9s4/7arnPsaSJsWqjk5wQR/5B/lkabyf3wp1RLl7A0EgotOVi8kcQofQ0x6+auUlh
         enhZ5Y/OIEGJBe4DcnsBnjQEEpwV/J646vANv4Rue1ys3aIbwW4BGndpZT4PieCui5cU
         92Z+GkZRLO6kJEOZag/334toTagmNe3x0XbRy7lh+HkIp17KhpguUm4GX38xob7Z+ZBw
         rsrzUIDHwNsmfD3SmoBloo5T+jdVW53Us53qqnAAGFrR3Mr5o0TVh2PwQfZ+UoMJEuD3
         s1ZFYvIOpLiP9dRWM6epZUtqDreXy+ySLVTpemEqy1L9ekybQ+vRHaYOccGn3zyTBLWb
         5JvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWChQTsxiroeKlFkBCuwhTaho7gGfgZOr6e0ooFwn8RLQYmuh3PpVhh2u/cgNkkOGMA4XYn1idKUIYON/vFSQkLhHqW3Mxg
X-Gm-Message-State: AOJu0Yw5F3SxEUzw7Qh+HKnVzxyjCl8Y0vIPeylNQYRzK+a1PAVDb59C
	stm9jimoSmAkzcUzlQNDTU80o+6bj3PVnyc8K+v/mcUWcbSg6sedtIsLNk/oZV9nIFtUhJYOPpt
	72HaCMMN4Higkv72bDd6tIpKCI9d5jHqmV67kCggRkYrRkgl/tb2hUss9pG1sgw==
X-Received: by 2002:a05:620a:268f:b0:785:cb89:5d1 with SMTP id c15-20020a05620a268f00b00785cb8905d1mr9639103qkp.4.1707829374967;
        Tue, 13 Feb 2024 05:02:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBAKPCf9DiGWhuoIWAPFKao5Ep6+wVTn0bWYbOXZx8V1cgpxwXkp4BPKp21ZyoRyuCc9W1vA==
X-Received: by 2002:a05:620a:268f:b0:785:cb89:5d1 with SMTP id c15-20020a05620a268f00b00785cb8905d1mr9639078qkp.4.1707829374709;
        Tue, 13 Feb 2024 05:02:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUcZ0XP0UzVGazQY0w7vCABKQdVKEx3huZJsKI17UumKQuLNQniRj3047GkNQUHcSb74nD6ubpf958tonPok/IvqcyRO4ScHBUqvMww/F5yXfCM8wStbi/L+rZY2B3an8DJXVHoLpVfo52jX8W1xqfUi11q7NNiBROfMR+FZhvus/BJMDwEalmaJisjgo+MPqZEgX/XpzaO19FZon6yTorMC1JQlp9QVSr1Q8vfGRawPlguVJSLOAMpegLfJ0zoQ==
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id pj17-20020a05620a1d9100b0078597896394sm2905002qkn.51.2024.02.13.05.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:02:54 -0800 (PST)
Message-ID: <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com,  dgibson@redhat.com, jmaloy@redhat.com,
 netdev@vger.kernel.org, davem@davemloft.net
Date: Tue, 13 Feb 2024 14:02:51 +0100
In-Reply-To: <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
	 <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
	 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 13:24 +0100, Eric Dumazet wrote:
> On Tue, Feb 13, 2024 at 11:49=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
>=20
> > > @@ -2508,7 +2508,10 @@ static int tcp_recvmsg_locked(struct sock *sk,=
 struct msghdr *msg, size_t len,
> > >               WRITE_ONCE(*seq, *seq + used);
> > >               copied +=3D used;
> > >               len -=3D used;
> > > -
> > > +             if (flags & MSG_PEEK)
> > > +                     sk_peek_offset_fwd(sk, used);
> > > +             else
> > > +                     sk_peek_offset_bwd(sk, used);
>=20
> Yet another cache miss in TCP fast path...
>=20
> We need to move sk_peek_off in a better location before we accept this pa=
tch.
>
> I always thought MSK_PEEK was very inefficient, I am surprised we
> allow arbitrary loops in recvmsg().

Let me double check I read the above correctly: are you concerned by
the 'skb_queue_walk(&sk->sk_receive_queue, skb) {' loop that could
touch a lot of skbs/cachelines before reaching the relevant skb?

The end goal here is allowing an user-space application to read=20
incrementally/sequentially the received data while leaving them in
receive buffer.

I don't see a better option than MSG_PEEK, am I missing something?

Thanks,

Paolo


