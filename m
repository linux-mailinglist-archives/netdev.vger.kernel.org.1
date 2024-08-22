Return-Path: <netdev+bounces-120818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF65395ADC0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C08D1F23201
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DE61422A8;
	Thu, 22 Aug 2024 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMuxCQOf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21713C812
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308813; cv=none; b=gfk8f8phQsbxjg/GXHyJajav2k2M9AwoZQCH4QiK9owdt8zQgZRlD1Oi3GpdRlbwB3uzzFT0H5ucmMyW3Ifq6Eesx/7FLzbADWB5nlCLdvZp7u3+rRUsG8awyQ8x8hwJrHlGndXfmNoMMuBJDSPn8YpDELveoSX6AM+MnRjxF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308813; c=relaxed/simple;
	bh=2A4HiXbxUpbJVShB+LYAZTlaNaqdrSP4cGx7OPcc4Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYH68C6XVFqj2kJuyEOGM2h+1zvyvIjt8ez2JFLWL+u9FtaVIh1orLGtqZvdmXPi+2e7k/PvDsdXhsFkhYlEk91rsBhpPwX/r5O+kgtBal978tP/T49dXHHU4kPFIDLSX+LxnGDqgnn8/+6N5c0hdgszb8GGKAQqNel5VAVOf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMuxCQOf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-533461323cdso502785e87.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724308809; x=1724913609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYA73EUxFywwgD7O+Of8ycRgazOOQxdnTSpVRNaik5g=;
        b=IMuxCQOfl1Nki1CHf5uBvjNZHceWsNZZPbOMPjyQ1q5J7wzuEm+oOB77FnhAvXZcWo
         IyUcIvGzv3G9RlpXDJg1uSG1U/9oScJEnZ7pmETDuItONV6BtDXhv+oPOapK28ixYjQa
         MgcQyUIPHNd8jRBEsWfMxJdpWG0bd7dY2cmyDdUT6E3jZe4bqjcNlgwdn18dstU36uSH
         gKJsdGx0sBHWxDUv6oU0PdZVihR8Tehn5eHru3YxJJ+MrCnFbDTO+vdr1KbyZ25FqHun
         LPinCM1YWLNM0dVMKHv65tN91IrzaNNXUTy10HPeUI+xfwpoj/yd77bDrLFVubamHqyt
         CEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308809; x=1724913609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYA73EUxFywwgD7O+Of8ycRgazOOQxdnTSpVRNaik5g=;
        b=IDWcvzCfZ630GAjDf5AK5VbbQNle/QRLHyzXCrAxL/X8SSc4/6VfRkLqz5lcpn1fNO
         bcFOn2ZvzqXKKaBJFe3H8QvBrRN+m8IIWJ3ZW4dcXsw+skmJKZs5GjlZDuJezXkDvyk0
         trWfw8DIrLR4FNNZRvdGyP4yg2Fj9pXIK3jmEhtyBmBkwa7awO6l4+uVo79R9IWEWRo1
         uEzH4ZtWvCANEv+3j3Fkq4Mi9bzRRyEPVMDE1648ccOxtXG57hE6HMo7FYkQWCYSkDZN
         YXQpTsPskgnAqSnhhvl99NeggeKDzppRQXk5CNXB1M1mU2TSomvYPEBnie+ifn8vgC5t
         /lZA==
X-Forwarded-Encrypted: i=1; AJvYcCUxNJ0JrE8UJlh8EDrgXQANLXEMXl2lux8aCcKh9nmoVdCedy81+5VfsE6JOudk07t2/4iDbKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0BTWSfoPVTuG/eiEhDVOV3/Smq6gnRDXT1UjcmAfMBQw3vEA
	mYPCl90wBYcOhfkdi9KlRfAt+WUc75EhbTcYeacvCd/xczNrhlfc8sWQ+bVYTaVYR9Gn4gRmtuk
	5HyXKekCQfrgCC3+A0RVs9+KfqUSdFh9dkbd2eieqRpc5fl7Yi5VH
X-Google-Smtp-Source: AGHT+IGH+PSBY42jTWnk/XzN/b3i8gBxF8Jkzac9bic8op0LbO+3hDjgUBjVUgHowP1q5zPDbCA64ifePLJu8OaG9s4=
X-Received: by 2002:a05:6512:e89:b0:530:ea6a:de42 with SMTP id
 2adb3069b0e04-5334fd03a80mr426011e87.26.1724308808648; Wed, 21 Aug 2024
 23:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822001707.2116-1-pablo@netfilter.org> <20240822001707.2116-4-pablo@netfilter.org>
In-Reply-To: <20240822001707.2116-4-pablo@netfilter.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Aug 2024 08:39:56 +0200
Message-ID: <CANn89iL6DA3Gha1h8uje5U5rObnKCOrF360Q-U1bGaDCmm3wWQ@mail.gmail.com>
Subject: Re: [PATCH net 3/3] netfilter: flowtable: validate vlan header
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 2:17=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> Ensure there is sufficient room to access the protocol field of the
> VLAN header, validate it once before the flowtable lookup.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in nf_flow_offload_inet_hook+0x45a/0x5f0 net/net=
filter/nf_flow_table_inet.c:32
>  nf_flow_offload_inet_hook+0x45a/0x5f0 net/netfilter/nf_flow_table_inet.c=
:32
>  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
>  nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
>  nf_hook_ingress include/linux/netfilter_netdev.h:34 [inline]
>  nf_ingress net/core/dev.c:5440 [inline]
>
> Fixes: 4cd91f7c290f ("netfilter: flowtable: add vlan support")
> Reported-by: syzbot+8407d9bb88cd4c6bf61a@syzkaller.appspotmail.com
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  net/netfilter/nf_flow_table_inet.c | 3 +++
>  net/netfilter/nf_flow_table_ip.c   | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/net/netfilter/nf_flow_table_inet.c b/net/netfilter/nf_flow_t=
able_inet.c
> index 88787b45e30d..dd9a392052ee 100644
> --- a/net/netfilter/nf_flow_table_inet.c
> +++ b/net/netfilter/nf_flow_table_inet.c
> @@ -17,6 +17,9 @@ nf_flow_offload_inet_hook(void *priv, struct sk_buff *s=
kb,
>
>         switch (skb->protocol) {
>         case htons(ETH_P_8021Q):
> +               if (!pskb_may_pull(skb, VLAN_HLEN))
> +                       return NF_ACCEPT;
> +
>                 veth =3D (struct vlan_ethhdr *)skb_mac_header(skb);

Is skb_mac_header(skb) always pointing at skb->data - 14 at this stage ?

Otherwise, using

  if (!pskb_may_pull(skb, skb_mac_offset(skb) + sizeof(*veth))  would be sa=
fer.

