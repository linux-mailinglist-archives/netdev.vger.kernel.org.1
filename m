Return-Path: <netdev+bounces-249731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FDD1CC94
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA1AA306FFC0
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C87378D80;
	Wed, 14 Jan 2026 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3dbsEVX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BB3793A8
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768374962; cv=none; b=Sc3sw4d5nQkM7OhTfQElzK86I175lBQqQ8gXO8ul46fXWiSZH87/d2MQc/3q7PyLFhF50YLz6pXobvCnv2QOT+Q9ABDT0abEDPsiw3jnhgvloYJ+8PWhMHrozU099W0ddQWymVGj2N80tm6CpDfLHXNIx+d5gO75lZ/konBJvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768374962; c=relaxed/simple;
	bh=Piy8YBm07+jMazblsEPy36XePK0a4Ln3sGMpnd+mrWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dh6c7c/SyUOEDtwp4KQokz9TEybVHCD7mVQwxhtQnBKhftJxJlUO5LmRkn51E4WTFz9UUgqqDi2zMOYx4RQob3cRP4BRJSQ1RsFUNkBH8zXcvurnDWWqJMItyOgk2E4N0aNQFq9cGaFR96fdQLtI3N2uaBxHtOx3jHMYzhxpJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3dbsEVX; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1233702afd3so563842c88.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 23:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768374954; x=1768979754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs7+8D8JnuZMt5LjtRb0WRway125bvnbxPx7Fo2XEbY=;
        b=S3dbsEVXYXx8xGailAA4eiZ/4ccEusxGpR+Tvux6Frt8lngt8OIo+T+hNFwgflW+0/
         Ly0ipB3aVNZiTQghCvNkhHi3o25NRfkBG1M7hs/bfCMb4DjcCVQXiw7FL6QfUgCQ7biV
         kdELjss+smJqsftUCWSX4N2CYMhLLQkL4J/afAtPtPvyi/eJq3sDWmRU/+NvWj8aWV1Z
         +ldB/OP57hxNz9jlzGOb3fuQXpGwcjU7rzyTGGeV0kwnQUUuVbxqopXQ6MNjo8hLNriO
         J/sQ6ngZId8x8Oft0XVPc36asrD8Pnyh0puHZdbZw43KdN4s1S79V4iIliSSFAQ17WLF
         Qcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768374954; x=1768979754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bs7+8D8JnuZMt5LjtRb0WRway125bvnbxPx7Fo2XEbY=;
        b=N8K1WeYnlXmIKwhKpZkolejY3dnaVrCPmmxFZn8swv+9EWK2OtNUInZD4+egc9Z5IW
         d9oHhhE8VcCM3mX2mWbm2PfEzFb/EU/1iDdCSb5q/lYv2R8P26qr8dnlXVnKpDpfhxcN
         7z+u4Ro4EbXohPSY8yIaiROAlzpHxHSEQmy1mInW0fwe41shtBfRYHnjzvxwzLB/u7/9
         72xOETk7WlFHqxA12W5eN/cBmU7O7HngXwMUgwLxXtsDRDTtPQWIif7flfnU6zmiP2uP
         UwX3aTeMrVlqvDd6Y+SKoYN1TzKhCz0P/LKBNHzi0KxpUStPQxXT1Fp4F1BIo+su515M
         4/OA==
X-Forwarded-Encrypted: i=1; AJvYcCV9IrG4+gfUqjYuArfvS0QLAs3lkh+Nn7+H8UynjpOM96l0r31DC0iQd795MnJHyI12W5aeahQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCTOFieoBW7jwTsI0WpsREi8vnyDJ4OI263TB7N/MUsNc44R7I
	BfXYeWIXHwNpLOlNTaRRgAIy+Gzr7YpGeIWou01dNuejogRXeyMfDNzQvhMF0rALwfy569TDsl4
	e7pagEUUAeBlwl1gbdmI8HWvckbERlrFTcp7oBogn
X-Gm-Gg: AY/fxX6XtcF5F0wF5FzHJj5GF8qSVxvxprV8pZwgW8hvzU8dv5oAPVCNPBGYBX2v2vI
	3gG1WsDqY9jA7qadQi8dBGvEJvihZwrjVIcCX45dWRnr6g0VQdcBSsi0kgmu/cYGCnpchNdrS1a
	q4IP/gRGno4+GALiQIFmxhptSfdPAV1StclxtWJXNDWCviqo8IxL3j7HcLDqFR/PavlKJLhMOm4
	r4aO5LDSDqglq9fmO0IaP7GAkUAJnYwNM4spJsWjmpivnIMzdid79rhpCsocw21H7s9VtwON27+
	3jFXsPVd8qze/raQYUVODSZuYzw2UtNP7HFHqNnX0rhPf5YwkPNDutzDNB9Q
X-Received: by 2002:a05:7022:3f08:b0:121:a01a:85d8 with SMTP id
 a92af1059eb24-12336aa95b5mr1646688c88.45.1768374953445; Tue, 13 Jan 2026
 23:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112200736.1884171-1-kuniyu@google.com> <20260112200736.1884171-3-kuniyu@google.com>
 <20260113191122.1d0f3ec4@kernel.org>
In-Reply-To: <20260113191122.1d0f3ec4@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 13 Jan 2026 23:15:42 -0800
X-Gm-Features: AZwV_Qj_KYC0wh6KR_Xh-vDYZtA2bH9h4PCiqkqgoUiX41UCVBaHBcpzzNqI5vs
Message-ID: <CAAVpQUD9um80LD36osX4SuFk0BmkViHsPbKnFFXy=KtYoT_Z6g@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] fou: Don't allow 0 for FOU_ATTR_IPPROTO.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Tom Herbert <therbert@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 7:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 12 Jan 2026 20:06:36 +0000 Kuniyuki Iwashima wrote:
> > fou_udp_recv() has the same problem mentioned in the previous
> > patch.
> >
> > If FOU_ATTR_IPPROTO is set to 0, skb is not freed by
> > fou_udp_recv() nor "resubmit"-ted in ip_protocol_deliver_rcu().
> >
> > Let's forbid 0 for FOU_ATTR_IPPROTO.
> >
> > Fixes: 23461551c0062 ("fou: Support for foo-over-udp RX path")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/fou_nl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
> > index 7a99639204b16..0dec9da1bff46 100644
> > --- a/net/ipv4/fou_nl.c
> > +++ b/net/ipv4/fou_nl.c
> > @@ -15,7 +15,7 @@
> >  const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] =3D {
> >       [FOU_ATTR_PORT] =3D { .type =3D NLA_BE16, },
> >       [FOU_ATTR_AF] =3D { .type =3D NLA_U8, },
> > -     [FOU_ATTR_IPPROTO] =3D { .type =3D NLA_U8, },
> > +     [FOU_ATTR_IPPROTO] =3D { .type =3D NLA_U8, .min =3D 1 },
> >       [FOU_ATTR_TYPE] =3D { .type =3D NLA_U8, },
> >       [FOU_ATTR_REMCSUM_NOPARTIAL] =3D { .type =3D NLA_FLAG, },
> >       [FOU_ATTR_LOCAL_V4] =3D { .type =3D NLA_U32, },
>
> This code is generated, please use :
>
> diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink=
/specs/fou.yaml
> index 8e7974ec453f..331f1b342b3a 100644
> --- a/Documentation/netlink/specs/fou.yaml
> +++ b/Documentation/netlink/specs/fou.yaml
> @@ -39,6 +39,8 @@ kernel-policy: global
>        -
>          name: ipproto
>          type: u8
> +        checks:
> +          min: 1
>        -
>          name: type
>          type: u8
> diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
> index 7a99639204b1..309d5ba983d0 100644
> --- a/net/ipv4/fou_nl.c
> +++ b/net/ipv4/fou_nl.c
> @@ -15,7 +15,7 @@
>  const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] =3D {
>         [FOU_ATTR_PORT] =3D { .type =3D NLA_BE16, },
>         [FOU_ATTR_AF] =3D { .type =3D NLA_U8, },
> -       [FOU_ATTR_IPPROTO] =3D { .type =3D NLA_U8, },
> +       [FOU_ATTR_IPPROTO] =3D NLA_POLICY_MIN(NLA_U8, 1),
>         [FOU_ATTR_TYPE] =3D { .type =3D NLA_U8, },
>         [FOU_ATTR_REMCSUM_NOPARTIAL] =3D { .type =3D NLA_FLAG, },
>         [FOU_ATTR_LOCAL_V4] =3D { .type =3D NLA_U32, },

Oh thanks, I missed it's auto-generated.

Btw I needed the change below to generate the diff above
by "./tools/net/ynl/ynl-regen.sh -f".  Maybe depending on


diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index 81b4ecd891006..fda5fe24cfd47 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -29,9 +29,9 @@ for f in $files; do
  continue
     fi

-    echo -e "\tGEN ${params[2]}\t$f"
-    $TOOL --cmp-out --mode ${params[2]} --${params[3]} \
-   --spec $KDIR/${params[0]} $args -o $f
+    echo -e "\tGEN ${params[5]}\t$f"
+    $TOOL --cmp-out --mode ${params[4]} --${params[5]} \
+   --spec $KDIR/${params[1]} $args -o $f
 done

 popd >>/dev/null


fwiw, $params were like

3- Documentation/netlink/specs/fou.yaml
4: YNL-GEN kernel source
--
3- Documentation/netlink/specs/fou.yaml
4: YNL-GEN kernel header

