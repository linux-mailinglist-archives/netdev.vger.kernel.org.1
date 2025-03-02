Return-Path: <netdev+bounces-171053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9207A4B4B8
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 21:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1155188E2FF
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 20:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6451C3F02;
	Sun,  2 Mar 2025 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="idGbfgs4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0413AF2
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740948583; cv=none; b=BzbHPRPVZL9LI9ZJp12A9Go720uz4Lv65Pmh/VbKYHeWgGF/6RxafIBzSqDGoBYzE4Aotq0VVvfVB1Wh69xzfy8u8A1HLwescZXXdnR5NSQ4iNSku0iQ27bkyhcWI4MwW6RVmdS4Ft1ff54au1ihXDxSODK0/bUX3hcbBnBVyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740948583; c=relaxed/simple;
	bh=Ok0AsmENAVP73AMBqpuB2wPSvh2kaCxETdXfquYmb1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdW/4lmEQRHKpEIywriffEyDOyXUwcXdo+CCnJoC+FIjleNHuKZmEPimUm+k0VJ8dk/1jkenvVLnh8vs+Qvbd5bZFoWey76mSETy2gpTppHvIGQdmYIg0VICzkXedFZQS1CESudg8awylWZdDJ/Fiq0xHeQb8d2tMSrqvRRPNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=idGbfgs4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fe8c35b6cbso5930902a91.3
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1740948581; x=1741553381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH3OpRiU9y4TAWb6UG+b3BOv4YLFGuPWAKqHHM/aa6Q=;
        b=idGbfgs4WGRsJQaqGWaTwn3o94hh34+4js03z2zR5Y2zULLzvZb/5upEL4cFahYYdb
         wQaMNO42w6t6gwokOmSVl5NpdW18AftUifuxYc7fmcPbcclF158M6qcLpDvWULsnwLeb
         wemCDxvxWclXrhCWfwuph7KJ8S8ATkVRRiW2CpPw1L1MrQvdMXj66RQ8ILNuvPSjvfzQ
         +BkoC07O4OO+VvSe4u2q9hMLIss57tKXB3iq5V/2B/c3nP7K5VY/AYcAgtnip3qcByPv
         SDZvOftG2+M2eySOoECelEpw4HRUouC4LYQ24ehxd2TSRv0IkhqcCEqL7xTjnKiAl+e5
         kaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740948581; x=1741553381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH3OpRiU9y4TAWb6UG+b3BOv4YLFGuPWAKqHHM/aa6Q=;
        b=RRetUfVsbt9xQmIOeaDttpjSP1TTNCSZueI5nEVH1xvlTqy9Bi0oYGXjCEWlX2InIJ
         E+U2gD/VPDgF7F6XHkQtsHLdxrVnQ2WFBnAJROrMLVKknYqY0jGOAy5RGKNzuVeAPE7J
         AoPZuzbIFDFr7rctDRIQuBAp07YM7ozsT5h5TLLdtXZN5FgEcubkVK7DvGEvH/UGPB7c
         NGGTtKE9V98nmHjHpHpYUFrjAbfPFCPiuW5X4mMgu1v8mM99gG28GC6T6+FhRU7z1qqo
         nlmEg3tMTSarAe/WW5nPL4RSQ/IcoF+5lPW35EwEak7GvZfFQdwnOJrC4EfzcfWmrsQ5
         YgtQ==
X-Gm-Message-State: AOJu0YyTx663qJ35SIxOedffhOpWjIDqbv976/IfQso9gWpRQE4nd6gj
	Y8RZYOdL9TmQfJH5ByfqvTFHMwqmZep82Q/OHpTLcXK3AYVPQ19u48GMdpy46Esz/OgM2A0tH0s
	sn+E9SRP0I86DEKWQ424nRhmsqzNAjWnkTp2J
X-Gm-Gg: ASbGncvJAmEVYeeSKdRbflnvtCbVj/8UmEcEGyf6mTHv1zfcnNCoFlcN4Uriy7rhSmE
	xDfbxdOrWrQ31y1NZd4Q8mp9wjY1gXgRprHCIVSph8dIvQr0QebHF7T57WhN+QF5vSE4/ll2z7B
	BqNYNKEqwgJ43JzVIds3/nYgEc1w==
X-Google-Smtp-Source: AGHT+IFuDLyLj+yymcZ+cqojNMtSwBwbGhIZvdbPTd888FUP/E5Fq/zlcsvGWzoChy4e5tKOwtRGLec3DVHVg094OwE=
X-Received: by 2002:a17:90b:17cc:b0:2fe:a77b:d97e with SMTP id
 98e67ed59e1d1-2febab3c705mr17023376a91.11.1740948580655; Sun, 02 Mar 2025
 12:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302000901.2729164-1-sdf@fomichev.me> <20250302000901.2729164-4-sdf@fomichev.me>
In-Reply-To: <20250302000901.2729164-4-sdf@fomichev.me>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 2 Mar 2025 15:49:29 -0500
X-Gm-Features: AQ5f1JohiEC3IMT_eOPAb9YrPLF80rF7iwlqtJJkTxd7reWUuUtYmHy48PDPqD4
Message-ID: <CAM0EoM=jOWv+xmDx_+=_Cq2t5S731b3uny=DWrVX4nba3yjv7w@mail.gmail.com>
Subject: Re: [PATCH net-next v10 03/14] net: sched: wrap doit/dumpit methods
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 1, 2025 at 7:09=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me>=
 wrote:
>
> In preparation for grabbing netdev instance lock around qdisc
> operations, introduce tc_xxx wrappers that lookup netdev
> and call respective __tc_xxx helper to do the actual work.
> No functional changes.
>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Saeed Mahameed <saeed@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  net/sched/sch_api.c | 190 ++++++++++++++++++++++++++++----------------
>  1 file changed, 122 insertions(+), 68 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index e3e91cf867eb..e0be3af4daa9 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1505,27 +1505,18 @@ const struct nla_policy rtm_tca_policy[TCA_MAX + =
1] =3D {
>   * Delete/get qdisc.
>   */
>
[..]
> +static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
> +                          struct netlink_ext_ack *extack)
> +{
> +       struct net *net =3D sock_net(skb->sk);
> +       struct tcmsg *tcm =3D nlmsg_data(n);
> +       struct nlattr *tca[TCA_MAX + 1];
> +       struct net_device *dev;
> +       bool replay;
> +       int err;
> +
> +replay:

For 1-1 mapping to original code, the line:
struct tcmsg *tcm =3D nlmsg_data(n);

Should move below the replay goto..

Other than that:
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

> +       /* Reinit, just in case something touches this. */
> +       err =3D nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
> +                                    rtm_tca_policy, extack);

[..]

cheers,
jamal

