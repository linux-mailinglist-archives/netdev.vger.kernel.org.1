Return-Path: <netdev+bounces-232357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EAC048C4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807413B9C53
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013661EA7DF;
	Fri, 24 Oct 2025 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAM6AEce"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9E2AEF5
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288323; cv=none; b=OiQ4dVDs6nMMGFVQWb+15EHNHlRzxrOb3juTWtMcv5ZK1HUW1gnASXN/+weCVpRB0SkQ8sGr924KTb/AGmcP/Pr8JzsYoMz02biKj2Kf4ex6sUbtReakIT9xV9vOmCKcKPVDUB5WDHIGOpj5Kb8JRL3f82hLuhjUoaezdCei8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288323; c=relaxed/simple;
	bh=0iw9CwNPkhBvnTCr2cpA3UzfVbB5f9B73Acum9l+L1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6lldS8XcIkGkpa9bWaC4HjUuaEwE6zqctPLbnjzjyvbv4noSXJ3Hxv31zEkI8tnJVRvwzsypB1YR+TJWUBP3O9tvOzs0UJhI2wtJEZyxAlVfYXjpXddbBMguEjyk1xDYic74/s2o443f+OjzLKGuiVVoBxHC7jGDzLPUrlZpbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAM6AEce; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63e11347fd9so1948911d50.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761288321; x=1761893121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENJpw6lxJ/Kp0MjLnDpjJp+nMlZLuOMZ4v+w7E3FRSI=;
        b=gAM6AEce83MjE9jPKREHVMBBoZn0w6ncL/XrZHGUamAq3VqKLWX40WicbZc7x5Yn44
         SG3Md+43ZJoP967os+J31sdKErF0A5HfhA6Fgds+a3lPQyY+0l5svSGF2qvKJaPvuxsg
         VajzLR0CQh91TIpcIuShmRPk5e/d92sjbbW7I6LRsziJsh1QQ4yVnuuq+5a4pFe085AF
         0K6amnke0FA76uwpZIeln39Uua5p06CxOWHMXz/nN8BEr8gqF/IgFCHjqI7sYGPcph8/
         qUL5hgTisw/yddc+N87pC6qrALWJDbCsMce+6DLafJF6HyDQjTa8z2hCCv4qOXFeqHTL
         tG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288321; x=1761893121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENJpw6lxJ/Kp0MjLnDpjJp+nMlZLuOMZ4v+w7E3FRSI=;
        b=cjbUloSztl8avbLvOaw6EcNmZFLF3189m6R4Zk7W1arSwsUmb8Zkd5aoBIjwWJgnHD
         yNME1DEClNee7B3Nj2AHLWtXNqT6KgGQcrsiF8xg2GFGiui3ZhfqOohW/8+vKFUsHrgX
         7ZLSDrypeHkbQJBV73ruXV/WFC5a3aQyseZZX0Nzw7Cu/7qxORQQ54zfRCJ8riyEwN1g
         EDymisrgYAZzo9T3B/yN3kQe4GHDwjlpWNgmABBo2B9jDIiKLjQcHQWXoQyzvDe8Hm7z
         m8kyuZ1LqocCF98dQa/HK0J8gYt5izfx0dO7NIGlCdL+HSH5s3NoPZtg2X7Y6UvHBOmO
         kq8w==
X-Gm-Message-State: AOJu0Yy3LqjFyPf1TqLQY5OisBbB3ZFBepjGo2L+1tHVcQpyDBEw6+bP
	SimztRCaC2DV25wSC5kH/C8JhZSWgs/3WK+NYX5PJ2GbNKk7+dt6cX7znUlfae53o+//kxZANdR
	ppdG6swZnEOZWJdN0l6rIbxt8tX2fp0ldNu+kemM6
X-Gm-Gg: ASbGncsbgy7iJshr5ZE08GOBIKWZ8rnw0nA6F7qSJiA5GEPvxxnPHcLYhbCLHFby3j6
	hmuPNkm6F65vqoV3i2j/dAbQyo2E/CqF7ehHUL9am5Ex5SC9+EFkwsVAQD37TM5PiHMlA/cN91J
	VuYTAc9cribyjFCPz9C51NTSllll3i9KV5IKtGE9AQdgB2zfxBkH8Qc2zZ8ddkxCRnkxcbet9C6
	czVWn4UigYtEcsU5oddhCuA9UzVnHptqZMzT6fwqjuXgZbKxMhJvmZ9IFf/oEUs3A3B1EU=
X-Google-Smtp-Source: AGHT+IEE6xkStLPZ4tYqHmT+BNPndD8hmzRfnS9yu2RGFJrROYJnGSjt1r75f1bjSne8MfK5a07T6HokbAZWOY7xaBY=
X-Received: by 2002:a05:690e:1406:b0:63e:36c4:abb1 with SMTP id
 956f58d0204a3-63e36c4ac62mr13167261d50.39.1761288321009; Thu, 23 Oct 2025
 23:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1761286996-39440-1-git-send-email-liyonglong@chinatelecom.cn> <1761286996-39440-3-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1761286996-39440-3-git-send-email-liyonglong@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Oct 2025 23:45:09 -0700
X-Gm-Features: AWmQ_bkllJW6kG-o32vPFlZSUbRQW-QsRSauzdvwKUA9R7luR4rKlhRJ9IdEZAY
Message-ID: <CANn89i+yC1b_KRx0smi20FuQjcbUMnqMhwLmnW=feFNM0hcMfw@mail.gmail.com>
Subject: Re: [PATH net 2/2] net: ipv6: use drop reasons in ip6_fragment
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:23=E2=80=AFPM Yonglong Li <liyonglong@chinatelec=
om.cn> wrote:
>
> use drop reasons in ip6_output like ip_fragment/ip_do_fragment
>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> ---
>  net/ipv6/ip6_output.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index f904739e..575c7d1 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -875,6 +875,7 @@ int ip6_fragment(struct net *net, struct sock *sk, st=
ruct sk_buff *skb,
>                  int (*output)(struct net *, struct sock *, struct sk_buf=
f *))
>  {
>         struct sk_buff *frag;
> +       enum skb_drop_reason reason =3D SKB_DROP_REASON_FRAG_FAILED;

Reverse Christmas .... move this one line up, or move "struct sk_buff *frag=
;"

>         struct rt6_info *rt =3D dst_rt6_info(skb_dst(skb));
>         struct ipv6_pinfo *np =3D skb->sk && !dev_recursion_level() ?
>                                 inet6_sk(skb->sk) : NULL;
> @@ -995,7 +996,7 @@ int ip6_fragment(struct net *net, struct sock *sk, st=
ruct sk_buff *skb,
>                         return 0;
>                 }
>
> -               kfree_skb_list(iter.frag);
> +               kfree_skb_list_reason(iter.frag, reason);
>
>                 IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
>                               IPSTATS_MIB_FRAGFAILS);
> @@ -1050,12 +1051,13 @@ int ip6_fragment(struct net *net, struct sock *sk=
, struct sk_buff *skb,
>
>  fail_toobig:
>         icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
> +       reason =3D SKB_DROP_REASON_PKT_TOO_BIG;
>         err =3D -EMSGSIZE;
>
>  fail:
>         IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
>                       IPSTATS_MIB_FRAGFAILS);
> -       kfree_skb(skb);
> +       kfree_skb_reason(skb, reason);

Same remark as the IPv4 part.

>         return err;
>  }
>
> --
> 1.8.3.1
>

