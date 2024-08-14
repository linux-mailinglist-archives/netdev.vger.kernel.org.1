Return-Path: <netdev+bounces-118601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE90F95235D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B861F22327
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC9A1C37A4;
	Wed, 14 Aug 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Hh+zP4tR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AED762D2
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667312; cv=none; b=QaSCzkwpQXzmojxWXwTKM25JeqZUkW42FJGkTAPELUwlcxaSoK8S9HHRFn03MTE+W2TThbYdLT+aICM7hxyotoTcCgEnDMlaTQzAr+rzBbbhRiJP4t3NByP3IpjYDhld/w86ehduQfxvC5TRt2hM5G0ImdepoqOtqz/cexHBwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667312; c=relaxed/simple;
	bh=V2eLhCSbJc7g04YvP2pWldsXxfq4IjYNDo85Hh7uN5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfjMqA3lzenA3nEFF1a+9xU3QJklN69d7RY8BI/RdjA9SJxBgS9eFIrmMDGj2KuRftwlodz0A389Mbg6lldj7P4YHOKywEMi/TZyFSQctNOEdUjz1Z6afL/9RXDH+lcWmgJC4nDx4WTOcieno39M/6d1Y0Ry//9LsTRvUGfaO20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Hh+zP4tR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso414174a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723667309; x=1724272109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2eLhCSbJc7g04YvP2pWldsXxfq4IjYNDo85Hh7uN5w=;
        b=Hh+zP4tRmsQEABD6qnhSB5wrsLpXUtWO/mzWup421iyTelmYKDnrHHNGzXYvF7KUML
         zEXlJBLEJq+w1arHSxqINV4aHqO7VJSrXh5YUsMysEDOjhFnuGNkbiv7qhaQVh14boKJ
         ttBt2Hdh1BrX2I39jXmsab9LvKmajeBN22fJg9azdnodbsWwiSMYGcJBYqc1IHRqv9SI
         BK0vjZspmhkrauGMfu3FFIRg9CTUkEGIF+cAKwQz7bWHUs27KjgaR1f25Sy2gu/dGNRD
         y0yVvGiYcJU7VaiQJRf37aU0M9HDTcTWlp5iRrbdBK+XwSp1ypKRawOfJY1baIFEhWTE
         y1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723667309; x=1724272109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2eLhCSbJc7g04YvP2pWldsXxfq4IjYNDo85Hh7uN5w=;
        b=LlKRehIxl0wOvA7w0n1RPFsT5eGB17BbhWDylrlbVz3SAW6atN9p6AL0PS/MPCJ3Zi
         Hd/lpiZ0l40Bty/EhrqmMTg9LaUvly6MDAFjB60hvXcZzG/QsWA+hnLE4SpSJnOTJFxm
         JqyUnScurg0I+TA/DYU1es80CAD2w8jBX17l8h6VkpVUFuMWgj3Zyh2tyfKZhXoy3fQl
         PW9STIShWM+Alw6U/Kc6BrGOdNtZP/ffYetl7cXX17JKFdrEajZ0xsBU5fPoSJ/BrObV
         TuVmscesukbXQ00g3XfgJzIwgeRkrJ/FuVuepwpmm8UCaA0tOHXnM2zIR4Qn9Z+uSaTo
         Ck3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGigi1EuTtXyfExmW5+KFR9lYJab9lUzDEWEaBg21yrJxzdmFBBQwJRKZ/3XMjK5Scj76KnDad9dC5EFOoRamRUiOlRguL
X-Gm-Message-State: AOJu0YzEGHmg3FqmBzPWwQub94akqI/5QrvAnBgj6hsvKJ3k7LyXRa5G
	UDGSXNqA+3i5GS8aVXemXtV1iWZshergKmXLWKrFBfjQd3El6ZB0IT1moOvwIAY2f5Qa5rZYwQq
	9NoWH40NbN3j89yfsBmUc3tjZgM+OWiLer7Wx
X-Google-Smtp-Source: AGHT+IG8/NTfsCqEDa/Do0Rc2Y75NCIUgkfnsZ/8IKPEjJCazL47G6+ZKNM5HhzRx6bBB7Te3zoGgfPBzXFgl6eBx3E=
X-Received: by 2002:a05:6402:5205:b0:5be:9bc5:f6b3 with SMTP id
 4fb4d7f45d1cf-5bea1c6a749mr2539854a12.2.1723667309281; Wed, 14 Aug 2024
 13:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731172332.683815-1-tom@herbertland.com> <66ab8b9ef3d74_2441da2947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <66ab8b9ef3d74_2441da2947d@willemb.c.googlers.com.notmuch>
From: Tom Herbert <tom@herbertland.com>
Date: Wed, 14 Aug 2024 13:28:18 -0700
Message-ID: <CALx6S37FjSB6h6zLAdV+YF-C5H0O0968Zooo=9cJCm8Z3x0XvQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] flow_dissector: Dissect UDP encapsulation protocols
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 6:20=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Tom Herbert wrote:
> > Add support in flow_dissector for dissecting into UDP
> > encapsulations like VXLAN. __skb_flow_dissect_udp is called for
> > IPPROTO_UDP. The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing
> > of UDP encapsulations. If the flag is set when parsing a UDP packet the=
n
> > a socket lookup is performed. The offset of the base network header,
> > either an IPv4 or IPv6 header, is tracked and passed to
> > __skb_flow_dissect_udp so that it can perform the socket lookup.
> > If a socket is found and it's for a UDP encapsulation (encap_type is
> > set in the UDP socket) then a switch is performed on the encap_type
> > value (cases are UDP_ENCAP_* values)
>
> The main concern with the flow dissector is that its execution depends
> on untrusted packets.
>
> For this reason we added the BPF dissector for new protocols. What is
> the reason to prefer adding more C code?
>
> And somewhat academic, but: would it be different if the BPF would
> ship with the kernel and autoload at boot, just like C modules?

Hi Willem,

I agree with that, and believe the ultimate goal is to replace flow
dissector C code with eBPF which I still intend to work on that, but
right now I'm hoping to get support as part of obsoleting protocol
specific checksum offload on receive. We can use flow dissector to
identify the checksum in a packet marked checksum-unnecessary by a
legacy device for doing conversion to checksum-complete. This handles
the case where the device reports a valid L4 checksum in a UDP
encapsulation and the outer UDP checksum is zero.

>
> A second concern is changing the defaults. I have not looked at this
> closely, but if dissection today stops at the outer UDP header for
> skb_get_hash, then we don't want to accidentally change this behavior.
> Or if not accidental, call it out explicitly.

No defaults are being changed. Flow dissector flag
FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS needs to be set in the call to flow
dissector. In this patch set it's not being used, but as I mentioned
it will be used in subsequent patch sets for obsoleting
CHECKSUM_UNNECESSARY.

For other use cases, the flag can be optionally set. TC-flower for
instance could use this for VXLAN and Geneve parsing.

>
> >
> > Tested: Verified fou, gue, vxlan, and geneve are properly dissected for
> > IPv4 and IPv6 cases. This includes testing ETH_P_TEB case
>
> Manually?

Yes for the time being.

Tom

