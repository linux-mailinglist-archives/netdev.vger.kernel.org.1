Return-Path: <netdev+bounces-247797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA7ECFEBA8
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 16:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D1DE30EFDB9
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315AA3624B2;
	Wed,  7 Jan 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpE5ehR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67636215D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798601; cv=none; b=fw2SKVZ13rZ5ar3CcNhbu1yuLO4iI/nlvnJU8D9n6LSqYdZITQupC+1u6j0V5BZnnn24MdyDChI5S7Q5GBIDjzoQZ76ymx2qLFhgs/vxEj83f/LxM4cJ5qyFLIocOjj1PDgSykdiWLXRw/5c6uPlvHAwP4geZZTk4IyxMHaTJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798601; c=relaxed/simple;
	bh=lYP9pWBjKgKjRO/PBe9DsZJ/kbBLmbapyPBWE4fiIQM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nxKGCvQFe2SAgs7XXQ/DpqaDmdz5PaHny9/JTgfGuqeBIirY/yczVoKLFhDetT1NmRzXDso49VI6d0L1H7ctTTWEH/H9lTnNSTCn7ZG+9X1SDRPnPXUSpCZvOYKTdHEji3NL1OSaPHB9vsVnIPe68eEkRYDGaOWp64oG8EFwsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpE5ehR5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-790b7b3e581so11623307b3.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767798599; x=1768403399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g300JhXwNF6eU1q44sZuHW+zAs/cHhM+cAlOuqW2yJU=;
        b=MpE5ehR5jNpVyRiZ6DzwAwPQkiVMjZ6ppDH/GwX4gYuvPzwJ/gGxtY6yIwVTAGHLK0
         oN3gVLwgD0qhyZDaIrJgPCROoe7TDxw/qbFaWzNatLTexlSc6EtnmecmBKyRdt3RgYJs
         q3XVQ3bdJ3/+lZldpoCsKmrbICU9T7xMceUWc+dNfufOpM7jlHzFB4v+RBwgbVe17jtr
         MytIehsdWIC6JUX86D5AaaOfWl0vLuvcexYgY8ozgWGi1SGmzXHn4+WfRv6NFz3fUd5e
         +/YHD617rvQ3yth+q7kuzKw/ubkn3+Qnii22aNYQ2zkujMov8uYunxCR0b7HcVthNuhb
         itkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798599; x=1768403399;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g300JhXwNF6eU1q44sZuHW+zAs/cHhM+cAlOuqW2yJU=;
        b=VULgC8Jg6kArQtDaXqxGPsO2Mk23A/pH4OX0yIDeXCyCdDwirRokvrOLMoPlBobNaR
         RxXFxZjX6Nm0QHQVHDk50uKE1dELX7NLLAwrHLSdU8bELClXcJdLVGEGrdqpKD5tUFhO
         rxvoKSo58gKkG0zvQpfecTNS5Od0WilBy5WGlAK4F01kGhjU6/xg4JB3VKsZiHE/89Rq
         +fsyFbyo33lockOKpEXuNp3d6IV/py0jnyRb15LYbZcPY/DdJVTGPuMDHfcbT1di1aiQ
         SiljgyxqIdQ3sqDIEA7DTh7994cpMdsuU+4CoMkRBWa2j0AzltEtY2hx47QRlL8pL1B0
         cWCw==
X-Forwarded-Encrypted: i=1; AJvYcCWMn2Kz0ps6Vb15WMazHS9IbOzVf/LoXiW8IpCeSRRQp7jCbd0usZEhzJ1ahqtLd7Bx9vDymbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXb5Y6Why5R8mmQ2XLhr5kGPm6dfVDn0RSoDhrzzYUn4hTW+js
	Om/MGY/G8SQ6nKRYVpYjsgctsPyQi+vf3q23c7g50T3uBD1V5xPJhiwl
X-Gm-Gg: AY/fxX5/jcdrpYbGhvjwK+fENCULlmluxO9qqNQ0LUgh2JRkORA8CIIFa1oWXI6AYKw
	hFi2UmOm1XN+XjsrDBMQdaWlOGDJew+m/BUArUZJIiazoYWU/f5Fvx7iL7zivStk6a3iH8TxIka
	OgE3+4H55pCoMEa9LjcoXAKuGtvN1NVByODpT/Wjrak9ZXJCm9qtLBSM/jDinSwTE3WwXJIEy/x
	wtD5awRgdXXuGOIX2XvCRcN3r/RdnEYMKH6B2XBM4p7gTkqMb4bxv3otInkV5Wk+bTOFB8REiCP
	9GCdhtq8Z7R73C9SAmhBAj87QIgmG+WDaEmf9LJDXuij2hIYFLFz8PTXbC0mdMfiR4QiF5ngS1t
	Azvkmyhsay7nL1HgTKPd6rSgwCUyUMPxHWQ67dFThwTD8IAcI20EI5+eGtCHJrKegKQ2kbaE80R
	YIW5HjGXycWwHwdXOrgjoDuaVycEOAOTNb0v/CzYhVPTHH7BZKX7COha4I7rRXY3Wnc9m4WQ==
X-Google-Smtp-Source: AGHT+IGq8b5RPG6dybV52fvuoZgWw0/+xdPYqRh0ReKPr8wVUOhqY8MAT8YoteZOdcT8AyQ4phmwJQ==
X-Received: by 2002:a05:690c:19:b0:78f:86cd:5626 with SMTP id 00721157ae682-790a96e76f8mr55204137b3.26.1767798598537;
        Wed, 07 Jan 2026 07:09:58 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa58f9f5sm19262057b3.24.2026.01.07.07.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:09:58 -0800 (PST)
Date: Wed, 07 Jan 2026 10:09:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org
Message-ID: <willemdebruijn.kernel.21c4d3b7b8f9d@gmail.com>
In-Reply-To: <CA+KdSGOzzb=vMWh6UG-OFSQgEapS4Ckwf5K8hwYy8hz4N9RVMg@mail.gmail.com>
References: <20260105114732.140719-1-mahdifrmx@gmail.com>
 <20260105175406.3bd4f862@kernel.org>
 <CA+KdSGN4uLo3kp1kN0TPCUt-Ak59k_Hr0w3tNtE106ybUFi2-Q@mail.gmail.com>
 <willemdebruijn.kernel.36ecbd32a1f0d@gmail.com>
 <CA+KdSGOzzb=vMWh6UG-OFSQgEapS4Ckwf5K8hwYy8hz4N9RVMg@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mahdi Faramarzpour wrote:
> On Tue, Jan 6, 2026 at 10:52=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Mahdi Faramarzpour wrote:
> > > On Tue, Jan 6, 2026 at 5:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > > >
> > > > On Mon,  5 Jan 2026 15:17:32 +0330 Mahdi Faramarzpour wrote:
> > > > > This commit adds SNMP drop count increment for the packets in
> > > > > per NUMA queues which were introduced in commit b650bf0977d3
> > > > > ("udp: remove busylock and add per NUMA queues").
> >
> > Can you give some rationale why the existing counters are insufficien=
t
> > and why you chose to change then number of counters you suggest
> > between revisions of your patch?
> >
> The difference between revisions is due to me realizing that the only e=
rror the
> udp_rmem_schedule returns is ENOBUFS, which is mapped to UDP_MIB_MEMERR=
ORS
> (refer to function __udp_queue_rcv_skb), and thus UDP_MIB_RCVBUFERRORS
> need not increase.

I see. Please make such a note in the revision changelog. See also

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#cha=
nges-requested

> > This code adds some cost to the hot path. The blamed commit added
> > drop counters, most likely weighing the value of counters against
> > their cost. I don't immediately see reason to revisit that.
> >
> AFAIU the drop_counter is per socket, while the counters added in this
> patch correspond
> to /proc/net/{snmp,snmp6} pseudofiles. This patch implements the todo
> comment added in
> the blamed commit.

Ah indeed.

The entire logic can be inside the unlikely(to_drop) branch right?
No need to initialize the counters in the hot path, or do the
skb->protocol earlier?

The previous busylock approach could also drop packets at this stage
(goto uncharge_drop), and the skb is also dropped if exceeding rcvbuf.
Neither of those conditions update SNMP stats. I'd like to understand
what makes this case different.

> > > >
> > > > You must not submit more than one version of a patch within a 24h=

> > > > period.
> > > Hi Jakub and sorry for the noise, didn't know that. Is there any wa=
y to check
> > > my patch against all patchwork checks ,specially the AI-reviewer
> > > before submitting it?
> >
> > See https://www.kernel.org/doc/html/latest/process/maintainer-netdev.=
html
> >
> thanks.



