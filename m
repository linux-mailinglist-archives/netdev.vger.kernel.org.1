Return-Path: <netdev+bounces-110756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A1C92E2E0
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C5F1F21083
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 08:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD5155A47;
	Thu, 11 Jul 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYg4H5UN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D701155A24;
	Thu, 11 Jul 2024 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688382; cv=none; b=VNqNLqldQECnL3ngDEzSKNIhHdE1SkmK7lN6QzdqoWtxBf30kVOroLKAPeSzk99AXkUrZ0eURES1zF+Fb6xHA+0aAR8vgGFsi9AG+grnNrYAuhyuCrwEWSAp5e9XPUtrkWDGezFohGe5iTpYougJwc4KY/VzifjxIWHDSMKk8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688382; c=relaxed/simple;
	bh=qAPsvsx6ujthvgUgIeyjObrCJvC+F+atQvK0TRnobtE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=CQkkDsmJrXsME0MStchqKOpoYyLUNDf53dUs1HrOD/AOdD8aiMBHzFUwQRd1dBSdQshhf/YI8eSc2DCm51Ee/TsspueZDQJ2hF3P0ZtllcUEFhLJM2HdtpMC3kebGtUYGYAIKT17cxD8Kb4gCO/p8XZcZnaBaBWLR1zkSivSPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYg4H5UN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4977C116B1;
	Thu, 11 Jul 2024 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720688382;
	bh=qAPsvsx6ujthvgUgIeyjObrCJvC+F+atQvK0TRnobtE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qYg4H5UNGXx0abpiXxr7QNLcnVEZCgJ0uPY0xwdt6THoar8srBitZN0lzPwrxEiN+
	 rCnlrucXI6YpXoJowLessxsdXV2+Hd60YMuyA9pdZmVzgUlxShSbRDjcWgrthfz8By
	 FS/16u3l43uGJpUiPvZ3r5/v8R3qFjoPoLbUY0L/Zwrux7+UWllyQ4wJKc9s7zoLQ2
	 nLHhDrEJ58hVgBBebhO4AWmFPJcvaf1181R9/TvBoqdVlyyLojuX7cFBtRLrA5MuHa
	 TM+p17a93TLwn5bxAlmmmUcCeQANbQ5iA84RJDLBjWPc4pjzHGplesAITqon804yur
	 v5K14LXbokrJQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710171004.2164034-1-amorenoz@redhat.com>
References: <20240710171004.2164034-1-amorenoz@redhat.com>
Subject: Re: [PATCH net-next v3] net: psample: fix flag being set in wrong skb
From: Antoine Tenart <atenart@kernel.org>
Cc: Adrian Moreno <amorenoz@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, Yotam Gigi <yotam.gi@gmail.com>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aaron Conole <aconole@redhat.com>, Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Date: Thu, 11 Jul 2024 10:59:39 +0200
Message-ID: <172068837904.3846.3435522780630123273@kwain.local>

Quoting Adrian Moreno (2024-07-10 19:10:04)
> A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wrong
> sk_buff.
>=20
> Fix the error and make the input sk_buff pointer "const" so that it
> doesn't happen again.
>=20
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

Thanks!

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

