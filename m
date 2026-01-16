Return-Path: <netdev+bounces-250459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CFD2D1BA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 08:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B352530101F8
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 07:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC2313E1C;
	Fri, 16 Jan 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIq36sIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DD63126D4
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548172; cv=none; b=uJU9luR73DiMujeJLp0qlyf/T1EEM0Dykh1pIAIL4P6r0fHSFklJFX4yvCnKorSl3tID++zticEDQnKiQJeQGb/35lstgOx4xX9Qutj+3doxSJsrPE6O1BB1gvaIXyxBzTRoins8Qkh57oSFTqmqJpq09vhz9NH+M0FxOphC+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548172; c=relaxed/simple;
	bh=Mbz3N9u9WFTQ+vW2DtrY4Pue3c//ELuXAs0zbZ02vHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9Kyjbg1XUQBWYo1MRiJgJDt+Dd++XOiO9U1xZ/LoOSGXQtvyVAMUgv86xJa8twkyBhch5zWDmV65Oqlt81LdwN6N+pvIg7KZYU0BMotQmmY6Koung+iswYLB/b4a7p8LfBEf6Gsg9hDWIi8ki6HtSJmyDNeO1E/SPEPHPkGaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tIq36sIc; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11f1fb91996so4113418c88.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 23:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768548170; x=1769152970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpQgpNCENdrSR8ckOGRwYeHU5sDQWToh/hwaNS2lFFs=;
        b=tIq36sIcvHQobllIqoe6698Z7u2tFIyZlqP+DifdH9qo1W7bK6XWkkZkE8o0FStRD4
         WHmG+1oyXLS9mYgn8/BTr6MEQMwe8QrJUApSG83ovOXn4lvdOGwMzfsugxCDIQZaR3P0
         5AbqO6rkdFVjMcSpNKO4vdHyvlxHZmAb7vO4Izu+XS1qsCTs0vcVoSJDABV7v1uABx5b
         qaD1oMt2Yw+csHA+WUB7zQ2jCpbdTtK9IOKHh7UevG2UNJ0Pkh9QHSOtnucI5KB9O5EA
         4heT1AcBQj2GKoqha2dB6V5tSqaGq9UJ02ICMyCgPo5TzrUjXaaQ4Zn8kRPnK1P1Txtk
         aEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768548170; x=1769152970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpQgpNCENdrSR8ckOGRwYeHU5sDQWToh/hwaNS2lFFs=;
        b=Gy4pmjxTKd5zb2TYiLwea/Lv72YBQv1hrsLxQQ7DKxa2qZpaWr9ZmzApHQcS0O+qet
         TlycjL2O6rr6xrqkfvQUP+Fsis401Wl1/vp64hKeIi5zVMJP0EXKxlu30yWdpUlnsOgZ
         133al6h2pixz+1ZZTpmV4GNDUaS5k+gJ9gEndSSxahz44eOje+9Bq/DIWjMsWWayX29t
         cwO5IjH+ShBOSljKejoxdIOSa40wnN5BghTj1zLrL3gAO4dqi6X0F/8/AR+mAIi43m4h
         x3kFXeRuI9eXX9TlU/QM9QbcIcBNnk9iDByLuDf+a11T9BlSzqjn9zwg74TI6PFt6Wuc
         AsYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOUN2L/vKffqIA71GWWWQ+jozN76PvBzRz/XOsVyS2zMzEyxi+vzgnaHS3JczryJxzJeZf4fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxI1r1TVfD24JYN5OJsJ2LVAmOjBiPi8B3xrWdb/GIUJE4+Sr
	VpcH/2e7snGptKTUtkhqavTFfSONKf+70+0KzKj5E1ewljill2pm7CTcgBkS7IXxkZyqiWODQBy
	7Vomko1abhBcaTU5/W99PLqaP2MIf37KRdA4tKvxs
X-Gm-Gg: AY/fxX7EDxiTm4e4WuBjBxgmf7sAYARwp7Ym4Z+R5iCfBISKXwT20l00FXPI1tly4+s
	QoZQOR2EicNtiQavdPwWz1rtpRANSwQainAms0DXBtK2QAYKGyzAhaZyXwdXBved5ArGYHrYoXl
	ID3g3bjyZAuBv3ZT8yHWeWFFyVItw/TOzAGDK20ug67kZPvTt9NqlN/v27eTpDwjzpbpG4huqAe
	hI8KvDO5/tcgYL50sBeefEEJZY01g82LBjV9WEZQHufQXTCBT9S7/xPFpF/v8SzgFw9f03iF8jL
	lS2SedIiQNjqXLMRFJYsjv/D+FkBnrsBTkm2CVqBmoa5pJQxzQBj3ZTMNiE=
X-Received: by 2002:a05:7022:4590:b0:11b:9386:a3c4 with SMTP id
 a92af1059eb24-1244b395ee1mr1733145c88.47.1768548169688; Thu, 15 Jan 2026
 23:22:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768225160.git.petrm@nvidia.com> <accfea32900e3f117e684ac2e6ceecd273bd843b.1768225160.git.petrm@nvidia.com>
In-Reply-To: <accfea32900e3f117e684ac2e6ceecd273bd843b.1768225160.git.petrm@nvidia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 15 Jan 2026 23:22:38 -0800
X-Gm-Features: AZwV_QiF7oDv63HMerY9BTxB3q3308bQbdP9CFoo6P1EtDSww-EUuavR610yNXA
Message-ID: <CAAVpQUAoo0JBCPgf_Mc4cO2tpUmn0=Rn7aiUj0Q7HiHWRyoWpA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] net: core: neighbour: Add a
 neigh_fill_info() helper for when lock not held
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, 
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>, 
	Francesco Ruggeri <fruggeri@arista.com>, Stephen Hemminger <stephen@networkplumber.org>, mlxsw@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 1:56=E2=80=AFAM Petr Machata <petrm@nvidia.com> wro=
te:
>
> The netlink message needs to be formatted and sent inside the critical
> section where the neighbor is changed, so that it reflects the
> notified-upon neighbor state. Because it will happen inside an already
> existing critical section, it has to assume that the neighbor lock is hel=
d.
> Add a helper __neigh_fill_info(), which is like neigh_fill_info(), but
> makes this assumption. Convert neigh_fill_info() to a wrapper around this
> new helper.
>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/core/neighbour.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 96a3b1a93252..6cdd93dfa3ea 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2622,8 +2622,8 @@ static int neightbl_dump_info(struct sk_buff *skb, =
struct netlink_callback *cb)
>         return skb->len;
>  }
>
> -static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
> -                          u32 pid, u32 seq, int type, unsigned int flags=
)
> +static int __neigh_fill_info(struct sk_buff *skb, struct neighbour *neig=
h,
> +                            u32 pid, u32 seq, int type, unsigned int fla=
gs)
>  {
>         u32 neigh_flags, neigh_flags_ext;
>         unsigned long now =3D jiffies;
> @@ -2649,23 +2649,19 @@ static int neigh_fill_info(struct sk_buff *skb, s=
truct neighbour *neigh,
>         if (nla_put(skb, NDA_DST, neigh->tbl->key_len, neigh->primary_key=
))
>                 goto nla_put_failure;
>
> -       read_lock_bh(&neigh->lock);
>         ndm->ndm_state   =3D neigh->nud_state;
>         if (neigh->nud_state & NUD_VALID) {
>                 char haddr[MAX_ADDR_LEN];
>
>                 neigh_ha_snapshot(haddr, neigh, neigh->dev);
> -               if (nla_put(skb, NDA_LLADDR, neigh->dev->addr_len, haddr)=
 < 0) {
> -                       read_unlock_bh(&neigh->lock);
> +               if (nla_put(skb, NDA_LLADDR, neigh->dev->addr_len, haddr)=
 < 0)
>                         goto nla_put_failure;
> -               }
>         }
>
>         ci.ndm_used      =3D jiffies_to_clock_t(now - neigh->used);
>         ci.ndm_confirmed =3D jiffies_to_clock_t(now - neigh->confirmed);
>         ci.ndm_updated   =3D jiffies_to_clock_t(now - neigh->updated);
>         ci.ndm_refcnt    =3D refcount_read(&neigh->refcnt) - 1;
> -       read_unlock_bh(&neigh->lock);
>
>         if (nla_put_u32(skb, NDA_PROBES, atomic_read(&neigh->probes)) ||
>             nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
> @@ -2684,6 +2680,20 @@ static int neigh_fill_info(struct sk_buff *skb, st=
ruct neighbour *neigh,
>         return -EMSGSIZE;
>  }
>
> +static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
> +                          u32 pid, u32 seq, int type, unsigned int flags=
)
> +       __releases(neigh->lock)
> +       __acquires(neigh->lock)

nit: Does Sparse complain without these annotations even
a function has a paired lock/unlock ops ?


> +{
> +       int err;
> +
> +       read_lock_bh(&neigh->lock);
> +       err =3D __neigh_fill_info(skb, neigh, pid, seq, type, flags);
> +       read_unlock_bh(&neigh->lock);
> +
> +       return err;
> +}
> +
>  static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn=
,
>                             u32 pid, u32 seq, int type, unsigned int flag=
s,
>                             struct neigh_table *tbl)
> --
> 2.51.1
>

