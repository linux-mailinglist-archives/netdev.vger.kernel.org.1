Return-Path: <netdev+bounces-110570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099092D2D5
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33320284272
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F7194093;
	Wed, 10 Jul 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l13m+4+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765A192B91;
	Wed, 10 Jul 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618218; cv=none; b=tpC29uQE805y50Wb8bWqEb90HEVCHeOZ7B1Z3Ez8atv2SKOVVcAddZlv/7n0BBpkAaFivi9dio6OpR9tHrvN1lkxlVChn2BC/wH0cWn4lpcKrfzB6RCmJDaEoYlytUrA9cgNOymZbga69QWJ2sdJ6IFeOWJZdlu9VYCDcpV8DiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618218; c=relaxed/simple;
	bh=WnmHFbV9qGDjAcF91zk+1or9P4/JEgGUFqWbs8nvKw8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=TASGdFg5uDOr3ev3R17w5tWZgr+2DQ4t66afYxv3lwpLyjwhc41/vXdqtK76pDfoB2uLxjUsGaiwNoPQs0jOQYEtd79ilMtSqC6v5IE1dk+AunbUj7KLZRnVgEzfbvs6wBJCp/GK8xrYfKGRTweYsHJzEqaalDtEzo7gSc+Mkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l13m+4+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D98C32781;
	Wed, 10 Jul 2024 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720618218;
	bh=WnmHFbV9qGDjAcF91zk+1or9P4/JEgGUFqWbs8nvKw8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=l13m+4+5zjvjn3m1cCI2exo5SU7UHQYQOvj1oeEADWbO04p+MN2XDFgvZ11xxGFtv
	 8HRjuhCtNEQKHoqL26rC7hBK0DawUoXLFPnT52uACqfi6yIuVbmqmYj/fMcucBSvs8
	 SRjMn5oEsIkhvKQGfYqEeLDJgFxl8IqDb1z+Y4CdEGMA23CWOHzvpvyqYmW2vxPqF5
	 OLWk4A12HLbWvDlNKQjvODfh2WlWqP07oFvqc7ON9UoPCF8KUr3XHAj6X81ZioYMLz
	 UWFhFUOlflbdkIOafZM9fK4xjAWfKSPoa5dzL4/YKCrYkwOTjNWU+WJWWGyVQ9PPdg
	 /kljNrsYdcoSA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710090742.1657606-1-amorenoz@redhat.com>
References: <20240710090742.1657606-1-amorenoz@redhat.com>
Subject: Re: [PATCH net-next v2] net: psample: fix flag being set in wrong skb
From: Antoine Tenart <atenart@kernel.org>
Cc: Adrian Moreno <amorenoz@redhat.com>, Yotam Gigi <yotam.gi@gmail.com>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Eelco Chaudron <echaudro@redhat.com>, Aaron Conole <aconole@redhat.com>, linux-kernel@vger.kernel.org
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Date: Wed, 10 Jul 2024 15:30:14 +0200
Message-ID: <172061821475.5582.9226948763101271068@kwain.local>

Hi Adri=C3=A1n,

Quoting Adrian Moreno (2024-07-10 11:07:42)
> A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wrong
> sk_buff.
>=20
> Fix the error and make the input sk_buff pointer "const" so that it
> doesn't happen again.
>=20
> Also modify OVS psample test to verify the flag is properly emitted.

I don't see that part; although it can be sent as a follow-up and not
part of the fix.

Thanks,
Antoine

> Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  include/net/psample.h | 8 +++++---
>  net/psample/psample.c | 7 ++++---
>  2 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/net/psample.h b/include/net/psample.h
> index c52e9ebd88dd..5071b5fc2b59 100644
> --- a/include/net/psample.h
> +++ b/include/net/psample.h
> @@ -38,13 +38,15 @@ struct sk_buff;
> =20
>  #if IS_ENABLED(CONFIG_PSAMPLE)
> =20
> -void psample_sample_packet(struct psample_group *group, struct sk_buff *=
skb,
> -                          u32 sample_rate, const struct psample_metadata=
 *md);
> +void psample_sample_packet(struct psample_group *group,
> +                          const struct sk_buff *skb, u32 sample_rate,
> +                          const struct psample_metadata *md);
> =20
>  #else
> =20
>  static inline void psample_sample_packet(struct psample_group *group,
> -                                        struct sk_buff *skb, u32 sample_=
rate,
> +                                        const struct sk_buff *skb,
> +                                        u32 sample_rate,
>                                          const struct psample_metadata *m=
d)
>  {
>  }
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index f48b5b9cd409..a0ddae8a65f9 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -360,8 +360,9 @@ static int psample_tunnel_meta_len(struct ip_tunnel_i=
nfo *tun_info)
>  }
>  #endif
> =20
> -void psample_sample_packet(struct psample_group *group, struct sk_buff *=
skb,
> -                          u32 sample_rate, const struct psample_metadata=
 *md)
> +void psample_sample_packet(struct psample_group *group,
> +                          const struct sk_buff *skb, u32 sample_rate,
> +                          const struct psample_metadata *md)
>  {
>         ktime_t tstamp =3D ktime_get_real();
>         int out_ifindex =3D md->out_ifindex;
> @@ -498,7 +499,7 @@ void psample_sample_packet(struct psample_group *grou=
p, struct sk_buff *skb,
>                 goto error;
> =20
>         if (md->rate_as_probability)
> -               nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> +               nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
> =20
>         genlmsg_end(nl_skb, data);
>         genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
> --=20
> 2.45.2
>=20
>

