Return-Path: <netdev+bounces-80973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F09578855FE
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FF5B2176B
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 08:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0D1D6A8;
	Thu, 21 Mar 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMN+2a6v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A601D6AA
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010821; cv=none; b=uJ1SIrv9Fq7VCOQrcAI2plSdh74uStrsD9qea5meU7jEqfU3Ke3cY3kFoi4l/UnQ2N2dAc0LRNGrHzJto+Bl74k8tZYKZVHy1ox8ib4LfS+oAV4XX0R31OFMepJRq1LjdAcYE/skBmLOwgNqVouYEuuk7/UpjRFEeFMb7pZQLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010821; c=relaxed/simple;
	bh=+Rmkc1IORQccIOlPY3ZhEo5XU8iz3NH59BUtX8LN5q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spuSYT8w5RFxwcW1h6uLav8PdOIcNQI6Lr+4EUC+ehUj9VLZ1rVOewR6iTYoLKSbC0XBieYbuDNahMADNu5Vp0Zp99MGIQTdbi34hfqxMuaEZK41AzXi7TzJMAZe2L7Fhfx2bppxh2MQrK/42mu1Rkqzqbg9OS/GTEeoyLINxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMN+2a6v; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56b9dac4e6cso6194a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711010817; x=1711615617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B724oPchdBWjT5XXJ1vQrCAJneU+efmilm3tnFDFnE0=;
        b=bMN+2a6vb0hl4f1ZEQvzzbtV+Ss5S9tCwcy3y7OlyH0hX0MkIdX/TQUf2wZgq0rPbv
         iUNAyca+LR5jNxFrHaQyt/pAmTuum9BbM7oYQyjw5+kSZKR+C+pQJ6uLMFvYZ2TIhkQT
         Q6h1ZNHKx0BkoAVncfiHt4SQJboh8uZNS0V2Wxoxw7TF6Se6BUcP/CP/pYJlSSHnXzBg
         hXh39w5JLWRgU0RsQceiKRsjeQ6ItNCulG4liM84n3Z3lpH6OuRPrcFb3+0fGmLFL31k
         sh4LdDjlqBl2tAO9o+oEtKqGhbj9ZjU/7ifKTsmvpEBAC0RCBo6O9xssctqf9MK2O6cm
         0Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711010817; x=1711615617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B724oPchdBWjT5XXJ1vQrCAJneU+efmilm3tnFDFnE0=;
        b=VUz0ttQu2crm5cQRsg0jjsxXVAXznZ+kChFga7IrlyTHSp8ufmz7dQbSxH3jJYyOm7
         ztUchxb+ROjOqd286OAhk5MCUXTDHfPk4tv2WsIwmca5ri4J6hYY7iaqQA0mRp4eswSd
         aLvOmHDxc2ZJoWpnXjuDl7xcrRMDVjYnFM5nEy8uFB5hdTUv5GqzDbLY4tmU0/tgfnh6
         6qyi4q2j2usAbOtNoN4h8J+zCU0OuwFMTlrUTn6SaEOVl2uaUdQjFNIjJvLA4nMDkF4+
         CR4Xe+PqPszlGpjGoZiNpN+Fco7xz2k+hCNHMqry1TADaOJ7DyfeaBbQY+gPVY2lhIuE
         WSwg==
X-Forwarded-Encrypted: i=1; AJvYcCUT3NZGTAtlnAStbxWVIJn6qxfxW4ewLRFJWF5W+1KkICfZ77YJlSRC7QM9lGyWAe9Yhio8yBoGURq6HmvPp9u3amiPgUiW
X-Gm-Message-State: AOJu0YyJ+f00Ak8nRd00ICzytNBzGuIrjsw+G7rHjaK6FYFPQXrF1ti1
	qPdodcy68PlEHBVsf3GBid9ZMnJ9Wvy0574nISBLpx8HGmcUpRlNBbHSy0HhAp9GQlkETxulX6i
	NXZfcx8wEfC8rI5y08l48v94Lch3ap6Vdr1k3
X-Google-Smtp-Source: AGHT+IEbRYrlpXkhd0lnpQqEYVrVNOIkzB/SF1w9et9ulzmJB8NM+mOEIHjg6+KJO7hb2vlQkp+BB59h+btB03Ozg70=
X-Received: by 2002:a05:6402:202e:b0:56a:9184:9ab with SMTP id
 ay14-20020a056402202e00b0056a918409abmr92421edb.7.1711010817369; Thu, 21 Mar
 2024 01:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403211109183894466@zte.com.cn>
In-Reply-To: <202403211109183894466@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Mar 2024 09:46:46 +0100
Message-ID: <CANn89i+EFEr7VHXNdOi59Ba_R1nFKSBJzBzkJFVgCTdXBx=YBg@mail.gmail.com>
Subject: Re: [PATCH v3 resend] net/ipv4: add tracepoint for icmp_send
To: xu.xin16@zte.com.cn
Cc: davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	yang.yang29@zte.com.cn, he.peilin@zte.com.cn, liu.chun2@zte.com.cn, 
	jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:09=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> From: he peilin <he.peilin@zte.com.cn>
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
> Changelog
> ---------
> v2->v3:
> Some fixes according to
> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
> 1. Change the tracking directory to/sys/kernel/tracking.
> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
>
> v1->v2:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=3DsZtRnKRu_tnUwqHuFQTJvJsv=
-nz1xPDw@mail.gmail.com/
> 1. adjust the trace_icmp_send() to more protocols than UDP.
> 2. move the calling of trace_icmp_send after sanity checks
> in __icmp_send().
>
> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> ---
>  include/trace/events/icmp.h | 64 +++++++++++++++++++++++++++++++++++++
>  net/ipv4/icmp.c             |  4 +++
>  2 files changed, 68 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
>
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000000..2098d4b1b12e
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,64 @@
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
> +                       if (proto_4 =3D=3D IPPROTO_UDP) {
> +                               struct udphdr *uh =3D udp_hdr(skb);
> +                               __entry->sport =3D ntohs(uh->source);
> +                               __entry->dport =3D ntohs(uh->dest);
> +                               __entry->ulen =3D ntohs(uh->len);

This is completely bogus.

Adding tracepoints is ok if there are no side effects like bugs :/

At this point there is no guarantee the UDP header is complete/present
in skb->head

Look at the existing checks between lines 619 and 623

Then audit all icmp_send() callers, and ask yourself if UDP packets
can not be malicious (like with a truncated UDP header)

