Return-Path: <netdev+bounces-91620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310A18B3363
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F591F230CE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FB913CF8D;
	Fri, 26 Apr 2024 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reLWl8wF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0713C9CD
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121756; cv=none; b=euPq14nrr0Ktyux8QJBqjdbGnxgmXc2DNKTGOoQhPskqrvX2hDcf24HpWKVo2qOcUzF3eYGY2DMaw84LUcenydx2yS9iNJEw8E2IFpN+YCrBJSjdNFJlNmZ8rmIJhNuKFHR02Di82iAgdi49u+FJbLEi6wXUyfcIczStIQAKi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121756; c=relaxed/simple;
	bh=4dCOVkO6+jaZbxpgg0GQvgunFe90UaVu5W4VrEP3Jx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4ZlpeeIaCvXE4NVHTl/eNnQKZ5e/PBVJTn2elUiLt2YhGXUR4OUUNY49Ff2aVKHwRS4FUeVIhsCTVPn1j7M5+3iDD8ng5tQivQEeKUgajabsN3jvpkS5C1jnLkWGGaM8CWbJXlN+oaNsmB+Ly3RbeTby2bfKaXpQrCbUwg/RCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reLWl8wF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9973a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 01:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714121752; x=1714726552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc+ioe2m0sqBtoVQtiXkBUwqMXmEVFtjvfR7brjhWPc=;
        b=reLWl8wFsimmKcL33xUvB+fXA+4UPNotH8gAJq01TJ7OTkKICq4o5fZaRwhBZA67XM
         vuohr8/XtS5oOgJTSRGOyiRXbt2Eou3nfNRB6Bu9/GNECBWsC/AYrWdV4+Ylp4JDJGap
         Um0LbyWA3aGNPbBI4aMBFUuYX20okyWmDZvp1DfwQFUCWo+II+jJLMmkgn/NR1Wt9Ee8
         TRJg2TAKLVff5Z2CKGE0Qvenz9HzIJfmzUWCgs0gcAMGrZmnTDNVYv+lpTGqP+QXMmi4
         qkonNyQhZt6mMMZ0SRL894OkYinSGZMsueTF7ypHZIwXhIXrCSSJoo/d5aYp2riGxQlh
         LHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714121752; x=1714726552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc+ioe2m0sqBtoVQtiXkBUwqMXmEVFtjvfR7brjhWPc=;
        b=P26MwS+U5Sq32/N4Ld9EK3K9owEtBpZGP45Wuc5dmyLhe1LP8BrTN0LzkwKMzyP/rU
         Lc6+4mR7sqgV1nfx+EomGfAw1AbB82IdaDOnAw7uplQRY4pdDOvSHjeMYW4iJstZH8b8
         3aLPoUi3FcOgr5YNNsadUEyppC8ZEGCYzysudrzRBlgTL0zRbgklg5iannJCK2oFxnlK
         pTFZDkf9NLeHj0QROhD0k23cNo+hEcwYiEP9jXFAvW4gbIgCnZlbUe5tkZnnO63n7GbT
         xH+oiJYfixa+Re+LFF8Gt3RZqmOnt1hB9nTJrk5e7bI6SL4j+xY0UpRbSODdwlZkjiM6
         0RLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXVeC89n4BTB/BTEe2hzS6HtMJ3p/UPHDhse8nsBS+gd1byRrfYz6II2BOHtK+uEwEAkWHS7wsxUT50xm0V6phKQMaq+qJ
X-Gm-Message-State: AOJu0YwSGkG5a+P8wC+agOAChU/2LtTOJLJcQw6RR+BlFxbhq2LRwNAt
	aFTTVGrgJn6YGHnD1klT5H19VbXaE5bHOh7q9qB59ncM9IneWlhwcpmfpB8QaQ6g417hGWHkUoe
	JbrvcAyq8JSkxRWzF0C3sAFoATria8Z43Ydj/
X-Google-Smtp-Source: AGHT+IFmzULTn8UHhnGqRagdDTcH6E0Xj8BhOyQhGLFU8Vp2OPedyL0TLIRL/NA2YMPcOS2A9aGSuI8smzxx5TTeA/4=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr55281edd.2.1714121751704; Fri, 26 Apr
 2024 01:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426164730214uXfxoyj3x703nsAdqnGSr@zte.com.cn>
In-Reply-To: <20240426164730214uXfxoyj3x703nsAdqnGSr@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 10:55:40 +0200
Message-ID: <CANn89iKNtKmN5im8K4dSZGqAV8=e3bZbZ5AhxbcNbjFxk5V1Jw@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/ipv4: add tracepoint for icmp_send
To: xu.xin16@zte.com.cn
Cc: horms@kernel.org, davem@davemloft.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, dsahern@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	yang.yang29@zte.com.cn, he.peilin@zte.com.cn, liu.chun2@zte.com.cn, 
	jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn, kerneljasonxing@gmail.com, 
	fan.yu9@zte.com.cn, qiu.yutan@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:47=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: Peilin He <he.peilin@zte.com.cn>
>
> Introduce a tracepoint for icmp_send, which can help users to get more
> detail information conveniently when icmp abnormal events happen.
>
> 1. Giving an usecase example:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> When an application experiences packet loss due to an unreachable UDP
> destination port, the kernel will send an exception message through the
> icmp_send function. By adding a trace point for icmp_send, developers or
> system administrators can obtain detailed information about the UDP
> packet loss, including the type, code, source address, destination addres=
s,
> source port, and destination port. This facilitates the trouble-shooting
> of UDP packet loss issues especially for those network-service
> applications.
>
> 2. Operation Instructions:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> Switch to the tracing directory.
>         cd /sys/kernel/tracing
> Filter for destination port unreachable.
>         echo "type=3D=3D3 && code=3D=3D3" > events/icmp/icmp_send/filter
> Enable trace event.
>         echo 1 > events/icmp/icmp_send/enable
>
> 3. Result View:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  udp_client_erro-11370   [002] ...s.12   124.728002:
>  icmp_send: icmp_send: type=3D3, code=3D3.
>  From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=3D23
>  skbaddr=3D00000000589b167a
>
> Change log:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> v6->v7:
> Some fixes according to
> https://lore.kernel.org/all/20240425081210.720a4cd9@kernel.org/
> 1. Fix patch format issues.
>
> v5->v6:
> Some fixes according to
> https://lore.kernel.org/all/20240413161319.GA853376@kernel.org/
> 1.Resubmit patches based on the latest net-next code.
>
> v4->v5:
> Some fixes according to
> https://lore.kernel.org/all/CAL+tcoDeXXh+zcRk4PHnUk8ELnx=3DCE2pc
> Cqs7sFm0y9aK-Eehg@mail.gmail.com/
> 1.Adjust the position of trace_icmp_send() to before icmp_push_reply().
>
> v3->v4:
> Some fixes according to
> https://lore.kernel.org/all/CANn89i+EFEr7VHXNdOi59Ba_R1nFKSBJz
> BzkJFVgCTdXBx=3DYBg@mail.gmail.com/
> 1.Add legality check for UDP header in SKB.
> 2.Target this patch for net-next.
>
> v2->v3:
> Some fixes according to
> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
> 1. Change the tracking directory to/sys/kernel/tracking.
> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
>
> v1->v2:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3DsZtRnKRu_tnUwqHu
> FQTJvJsv-nz1xPDw@mail.gmail.com/
> 1. adjust the trace_icmp_send() to more protocols than UDP.
> 2. move the calling of trace_icmp_send after sanity checks
> in __icmp_send().
>
> Signed-off-by: Peilin He <he.peilin@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> ---
>  include/trace/events/icmp.h | 68 +++++++++++++++++++++++++++++++++++++
>  net/ipv4/icmp.c             |  4 +++
>  2 files changed, 72 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
>
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000000..cff33aaee44e
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM icmp
> +
> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ICMP_H
> +
> +#include <linux/icmp.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(icmp_send,
> +
> +               TP_PROTO(const struct sk_buff *skb, int type, int code),
> +
> +               TP_ARGS(skb, type, code),
> +
> +               TP_STRUCT__entry(
> +                       __field(const void *, skbaddr)
> +                       __field(int, type)
> +                       __field(int, code)
> +                       __array(__u8, saddr, 4)
> +                       __array(__u8, daddr, 4)
> +                       __field(__u16, sport)
> +                       __field(__u16, dport)
> +                       __field(unsigned short, ulen)
> +               ),
> +
> +               TP_fast_assign(
> +                       struct iphdr *iph =3D ip_hdr(skb);
> +                       int proto_4 =3D iph->protocol;
> +                       __be32 *p32;
> +
> +                       __entry->skbaddr =3D skb;
> +                       __entry->type =3D type;
> +                       __entry->code =3D code;
> +
> +                       struct udphdr *uh =3D udp_hdr(skb);

Please move this line up., perhaps after the "struct iphdr *iph =3D
ip_hdr(skb);" one

We group all variable definitions together, we do not mix code and variable=
s.



> +
> +                       if (proto_4 !=3D IPPROTO_UDP || (u8 *)uh < skb->h=
ead ||
> +                               (u8 *)uh + sizeof(struct udphdr)
> +                               > skb_tail_pointer(skb)) {
> +                               __entry->sport =3D 0;
> +                               __entry->dport =3D 0;
> +                               __entry->ulen =3D 0;
> +                       } else {
> +                               __entry->sport =3D ntohs(uh->source);
> +                               __entry->dport =3D ntohs(uh->dest);
> +                               __entry->ulen =3D ntohs(uh->len);
> +                       }
> +

