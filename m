Return-Path: <netdev+bounces-107177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018891A36B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD87CB20A5C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2AA13C3D2;
	Thu, 27 Jun 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd7GDr1k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664B26AF5
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482683; cv=none; b=BhsPflnXyC/mypxxo2Jo+V9IuvDgG5V7+3nBdpugs/KS9XBgDsG5AkRL9fTBPE1ekRqnVGHmeAHIKoBgNtgBxishCV6oZ9eHQHHZME1x17aiY/JvLATF3rWsWihj2E5SrRro0DTIqxli8M3YWWLxzxwxRDVxFgeP6i6XXActPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482683; c=relaxed/simple;
	bh=v1XAYXn8q5+/auqCG0BitnC8tRhmnfV1tniduR6RVZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oy+jczseEqPCsib8n0wlUpxxJUNnClCm/veN5z04NQ72FsqQ9i7Zy4bu6rcZUd6wSOMMTU3sP56YxYIbGtvv4mQzXN9+ySrH2JtUklBRt1FU0Jlrru3OF66NFZbfu67ajb4ezjEAlkHTTcR1don2UYncprJ8uW5XQqsPiPeVpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd7GDr1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719482680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nC4ctBhWh5w5BUg76ztwvDcYL5zponElEPyTknD9Z6c=;
	b=Wd7GDr1kYMuFWK3oOyuLj+KOWv9L/don7aI4ndn6IvRLIOoyf6q+8XPoyf8OOjyjo5iZQy
	TGxphd7/e2wOTMqFMOSpk8xWlHR1OC7AdScMUrGv/TrQsZn5Yo8NFnFoOx6TS1EpuzCOgg
	wAGs2m9Pcfu+3EhqZBAFcO2tEnrFtt4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-S9fWjToQOGySZU5vwmoVfQ-1; Thu, 27 Jun 2024 06:04:37 -0400
X-MC-Unique: S9fWjToQOGySZU5vwmoVfQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36499139786so958247f8f.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719482676; x=1720087476;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nC4ctBhWh5w5BUg76ztwvDcYL5zponElEPyTknD9Z6c=;
        b=ZNrdzNU5W+VF1AaoUjws08nP+UZToHjAkPInBD+SuOKC3onebrEP3kF5hEQsvVtFzi
         fJJe1/i6yFEz7bBetStb416iQjq6+vwj27kK6qBgXb7XhWLwkL33vxAdv92yJAb+KbuW
         mLWTjCqEIAX/WAcMkcwCi0dfGiHFXuP88QL5rP+jRBXxUvhbgcVhL5g1p6PqKOMS81Ht
         EXXDS8+YjJEhSmIwTEnowxtuV780NOuz7/p3FslrT27VVucfTJh9tdMVJizbOB5FNdCD
         srRSt0u0oSE3Iy0VpimX/3HRayA7lhBf4037KaGsiIxlV3JkbgGECYhGVhST28nXAX38
         JMVA==
X-Forwarded-Encrypted: i=1; AJvYcCWuB1zwlBMNrTEGakOUfCjJtb8avOwXwbGMrprK/k5m9QTvKolKRlLyIPPsVzRleLPpbIQ7NfKIJ4oS+5MCtC7N+C+1f0JH
X-Gm-Message-State: AOJu0Yy/VazoMhGfoimOPzj6du8lINSbFzCKW2yi0R3IncQd/Vi/eANM
	UFORBYom9kZLuPatiIp+lHhrvwuJprEFE4wpXQitNAfbix/xqgLcEW7OpBThodbJJUlVJ/da+9E
	5FUfL3r/dclw3JHgqUd0E7mt9vMZjzJJiZ8mse6U/G7ym3M8T55jXmA==
X-Received: by 2002:a05:600c:5107:b0:424:7876:b6ca with SMTP id 5b1f17b1804b1-42487ea6784mr114311165e9.1.1719482676616;
        Thu, 27 Jun 2024 03:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZCBasb4PQtNCqxzH0iQ2lYKPOdoyI1jV4TJMs6efDLG2K7PZ7MfwaMljUwP+WrDFoj5X9w==
X-Received: by 2002:a05:600c:5107:b0:424:7876:b6ca with SMTP id 5b1f17b1804b1-42487ea6784mr114311065e9.1.1719482676192;
        Thu, 27 Jun 2024 03:04:36 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:2716:2d10:663:1c83:b66f:72fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564bc60f9sm18801375e9.46.2024.06.27.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:04:35 -0700 (PDT)
Message-ID: <660ade774ad3093b476182f160ac06b93d6d00e3.camel@redhat.com>
Subject: Re: [PATCH v1 net 03/11] af_unix: Stop recv(MSG_PEEK) at consumed
 OOB skb.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Rao.Shoaib@oracle.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org
Date: Thu, 27 Jun 2024 12:04:32 +0200
In-Reply-To: <20240626214700.5631-1-kuniyu@amazon.com>
References: <703aee1612d356af99969a4acd577e93a2942410.camel@redhat.com>
	 <20240626214700.5631-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 14:47 -0700, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Wed, 26 Jun 2024 23:10:40 +0200
> > On Wed, 2024-06-26 at 18:56 +0200, Paolo Abeni wrote:
> > > On Mon, 2024-06-24 at 18:36 -0700, Kuniyuki Iwashima wrote:
> > > > After consuming OOB data, recv() reading the preceding data must br=
eak at
> > > > the OOB skb regardless of MSG_PEEK.
> > > >=20
> > > > Currently, MSG_PEEK does not stop recv() for AF_UNIX, and the behav=
iour is
> > > > not compliant with TCP.
> > >=20
> > > I'm unsure we can change the MSG_PEEK behavior at this point: existin=
g
> > > application(s?) could relay on that, regardless of how inconsistent
> > > such behavior is.
> > >=20
> > > I think we need at least an explicit ack from Rao, as the main known
> > > user.
> >=20
> > I see Rao stated that the unix OoB implementation was designed to mimic
> > the tcp one:
> >=20
> > https://lore.kernel.org/netdev/c5f6abbe-de43-48b8-856a-36ded227e94f@ora=
cle.com/
> >=20
> > so the series should be ok.
> >=20
> > Still given the size of the changes and the behavior change I'm
> > wondering if the series should target net-next instead.
> > That would offer some time cushion to deal with eventual regression.
> > WDYT?
>=20
> The actual change is 37 LoC=C2=A0

... excluding the other ~1200 LoC ;)

> and we recently have this kind of changes
> (30 LoC in total) in net.git.  The last two were merged in April and
> we have no user report so far.
>=20
>   a6736a0addd6 af_unix: Read with MSG_PEEK loops if the first unread byte=
 is OOB
>   22dd70eb2c3d af_unix: Don't peek OOB data without MSG_OOB.
>   283454c8a123 af_unix: Call manage_oob() for every skb in unix_stream_re=
ad_generic().

The last commit mentioned above actually sparked a bit of post merge
discussion, which is IMHO sub-optimal.

On the flip side, I think all the changes in this series make sense,
and the self-tests refactor and extension is largish, but very nice.

TL;DR: I'm going to apply this now.

Thanks,

Paolo


