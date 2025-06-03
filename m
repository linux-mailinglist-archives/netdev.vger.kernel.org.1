Return-Path: <netdev+bounces-194689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD54ACBEC8
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 05:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F423A2F57
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F217C224;
	Tue,  3 Jun 2025 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9kmRvo/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5E4C92
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920760; cv=none; b=EiGnu1Oi7r49KVlzNWEiRD1AuqXhQM1uKFJi5lOhZNUHVTYEYL0oFJJYQfbKD0YKHZK2ZfI4B7+4++Zkr5nrT7pdCNT1Q/9xebaabywl0E2dmz4rePEQLlokjBKZ4j2zgnLM4LLDK2SELOTN/BGusiYME9o/B/LyJdLCPSMS84M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920760; c=relaxed/simple;
	bh=ulahXhuT8yDizo0bw9N/2oF8mAlXjmDARNszSAnWgEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cj+4aI0MxTarepcJqlL8HdVn19eBaPS2zSsl9dGkMe4rHy8vM1+TXO1TZxW1hM3tkyGNt7IC6rDWsjDaq2x8JH10Q0IHG2O+mAy9N4E7Qs1boOtT58CYtC0GhQ1QuJCjwJm7hKzH1Cfo/VvE0RB6OLQ24rreWPhJY7UQ57vqiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9kmRvo/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748920757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLUswlGrIATyOOlI6fhYu4jJYFEad2pBjyge/hX+nFY=;
	b=c9kmRvo/bTbgE2fbYbh7Z4pyeARezSCdE3nHcglQD0Q7/eZtFtpFh1wDYY3718cgouArSd
	pa6wuilqGcz93kvHgfDmo5S+eXIixRpNqFKVVx3fBMoYFFwJ4fAwjXme5/rN+2FVLe18IZ
	arzkNu+P08srjPMg+BT1iDVrh5tjmsI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-OuMrhYW8Otuo-TtpuBioiA-1; Mon, 02 Jun 2025 23:19:16 -0400
X-MC-Unique: OuMrhYW8Otuo-TtpuBioiA-1
X-Mimecast-MFC-AGG-ID: OuMrhYW8Otuo-TtpuBioiA_1748920755
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234a102faa3so35399285ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 20:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920755; x=1749525555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLUswlGrIATyOOlI6fhYu4jJYFEad2pBjyge/hX+nFY=;
        b=BtbH6urlzRacTDxeCH88M6PrM/7lfFhZkwzlkL55VrPNr6YjzFm9usg3OpMhOkLUm6
         gzrlZBKQB2xqXU3opavpM1epxJBUadIctbBzLSVPDLppKMLHUVoBGm6I164P3qG0OI+o
         HtW0psSGOT/bmnUpG7QjPh5KJCseMWEuQrFhY523TAJHMXukb42kVfqlx1WdOJwfYW9H
         PQ8//pB34peAhp+6na8DTzPo5Q+Sxd8/NgD1DwvsJTUmwLe4XSvXmJHDovrvqb8RZTFs
         bccy479NoK3pK8oPHla3YNzQCcHw/8+hPh9F2OLeWvXAR5PPUdgGKgoSo1aGuCSmVkLB
         UEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKSwNBZFoVMUIvPpxMrge7s4Gf5ctEcngL/eNDJyzgSEI3giG5QBhJedvbmr1ayNK5HQRCbOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUZXc29QP1ZLVa42FPulqtDuTIBvMavVqqwXcx3H/D9dkUodk
	6WM+qlk5gwREFSwXjXBXFc+XUsBQ4FAxm13zzcIAso+ZtStpuyPCzJfY2bSdtlbVDvDoq1/N+zK
	Z2sn61IuXHJ86GCenuz2jT/mH50SCsoYacqxRcuvZEHXeNBysvKS57baEisRCvtYA4YHwPPBPV8
	g9Vd5hhH1wlHU1hazohsIhDUMYJzpY3b9c
X-Gm-Gg: ASbGncuhN2xmqPl5cRThCNW7f485DpEOFQKRF7UVPGweqvCrI3IUORLxCFbEm0svfQi
	ZjE4fKkgR3s34R1PDxBtyMSAfaqdKuNPlXOuUNWZ2bzXGfdkUvdL+goJ7GSFXyvmFu2T06Q==
X-Received: by 2002:a17:902:e849:b0:234:8a4a:ada5 with SMTP id d9443c01a7336-23529904f21mr247668385ad.37.1748920755087;
        Mon, 02 Jun 2025 20:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHywPCLM/Qh3jSdbKsF9dOuO472rVd+vIBVeTePaa/6GUJRTTw4v5rkd8bePaost/OoMXAMwCrz5QAOrqb7r5E=
X-Received: by 2002:a17:902:e849:b0:234:8a4a:ada5 with SMTP id
 d9443c01a7336-23529904f21mr247667985ad.37.1748920754675; Mon, 02 Jun 2025
 20:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-1-95d8b348de91@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 11:19:03 +0800
X-Gm-Features: AX0GCFv2w2DYNXanInKBc5HQRF8lqBk-gAKp63FMQ8nnSSAfo4iUv1CXTbXlSAw
Message-ID: <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> They are useful to implement VIRTIO_NET_F_RSS and
> VIRTIO_NET_F_HASH_REPORT.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
>  include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 188 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d..426f33b4b824 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -9,6 +9,194 @@
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
>
> +struct virtio_net_hash {
> +       u32 value;
> +       u16 report;
> +};
> +
> +struct virtio_net_toeplitz_state {
> +       u32 hash;
> +       const u32 *key;
> +};
> +
> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | =
\
> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
> +
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
> +
> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t le=
n)
> +{
> +       while (len >=3D sizeof(*input)) {
> +               *input =3D be32_to_cpu((__force __be32)*input);
> +               input++;
> +               len -=3D sizeof(*input);
> +       }
> +}
> +
> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_s=
tate *state,
> +                                           const __be32 *input, size_t l=
en)
> +{
> +       while (len >=3D sizeof(*input)) {
> +               for (u32 map =3D be32_to_cpu(*input); map; map &=3D (map =
- 1)) {
> +                       u32 i =3D ffs(map);
> +
> +                       state->hash ^=3D state->key[0] << (32 - i) |
> +                                      (u32)((u64)state->key[1] >> i);
> +               }
> +
> +               state->key++;
> +               input++;
> +               len -=3D sizeof(*input);
> +       }
> +}
> +
> +static inline u8 virtio_net_hash_key_length(u32 types)
> +{
> +       size_t len =3D 0;
> +
> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
> +
> +       if (types &
> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4)=
)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
> +                         sizeof(struct flow_dissector_key_ports));
> +
> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
> +
> +       if (types &
> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6)=
)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
> +                         sizeof(struct flow_dissector_key_ports));
> +
> +       return len + sizeof(u32);
> +}
> +
> +static inline u32 virtio_net_hash_report(u32 types,
> +                                        const struct flow_keys_basic *ke=
ys)
> +{
> +       switch (keys->basic.n_proto) {
> +       case cpu_to_be16(ETH_P_IP):
> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
> +
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
> +               }
> +
> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
> +
> +               return VIRTIO_NET_HASH_REPORT_NONE;
> +
> +       case cpu_to_be16(ETH_P_IPV6):
> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
> +
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
> +               }
> +
> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
> +
> +               return VIRTIO_NET_HASH_REPORT_NONE;
> +
> +       default:
> +               return VIRTIO_NET_HASH_REPORT_NONE;
> +       }
> +}
> +
> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
> +                                      u32 types, const u32 *key,
> +                                      struct virtio_net_hash *hash)
> +{
> +       struct virtio_net_toeplitz_state toeplitz_state =3D { .key =3D ke=
y };
> +       struct flow_keys flow;
> +       struct flow_keys_basic flow_basic;
> +       u16 report;
> +
> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> +               return;
> +       }
> +
> +       flow_basic =3D (struct flow_keys_basic) {
> +               .control =3D flow.control,
> +               .basic =3D flow.basic
> +       };
> +
> +       report =3D virtio_net_hash_report(types, &flow_basic);
> +
> +       switch (report) {
> +       case VIRTIO_NET_HASH_REPORT_IPv4:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v4addrs,
> +                                        sizeof(flow.addrs.v4addrs));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v4addrs,
> +                                        sizeof(flow.addrs.v4addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v4addrs,
> +                                        sizeof(flow.addrs.v4addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_IPv6:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v6addrs,
> +                                        sizeof(flow.addrs.v6addrs));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v6addrs,
> +                                        sizeof(flow.addrs.v6addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v6addrs,
> +                                        sizeof(flow.addrs.v6addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       default:
> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> +               return;

So I still think we need a comment here to explain why this is not an
issue if the device can report HASH_XXX_EX. Or we need to add the
support, since this is the code from the driver side, I don't think we
need to worry about the device implementation issues.

For the issue of the number of options, does the spec forbid fallback
to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.

Thanks

> +       }
> +
> +       hash->value =3D toeplitz_state.hash;
> +       hash->report =3D report;
> +}
> +
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_=
type)
>  {
>         switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>
> --
> 2.49.0
>


