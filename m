Return-Path: <netdev+bounces-296172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OnVtLebKJGpG/QEAu9opvQ
	(envelope-from <netdev+bounces-296172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 03:35:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A8A64EA76
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 03:35:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openai.com header.s=google header.b=XHq6YYOg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296172-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296172-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=openai.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC299300460B
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 01:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEA121A453;
	Sun,  7 Jun 2026 01:35:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324B15B998
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 01:35:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780796129; cv=pass; b=QTJPu2X/ug3ibQA7RfPVTHwj128n1zakVqmgIg4EUC5C1kiyOvWFhn9idT0zKS/LspzX72n+XgOR8kQROH/e9+cFuEN0gf6t092c0Iu1E2H/oj7h5yfpJyZclsrrW1U2m+1luOWlLTCXFmKVntX8v1Gloql44fA3xw8RD7EI7JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780796129; c=relaxed/simple;
	bh=qo3XC8yjFWxeoTcByv0gD5R8LQuAsaijUk6jKbpcUqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/o9CQLxg6pBlkiKP7ICteM3Qgdfg3B6DEOiZUVHLb2Laz9/4T1T7I2oekXYvHmzjTz2lgEB0kiXYvuOkAfTkB3Yu2VxYYU32i1SOVbG/y3BoBIYGsxZtn1OyykIwVERpiOLOrTXxmQx6vZagOYBkLxzddsaB33aQVxpNzOnj00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=XHq6YYOg; arc=pass smtp.client-ip=209.85.167.181
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4863ee8474eso2418806b6e.2
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 18:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780796126; cv=none;
        d=google.com; s=arc-20240605;
        b=IEPupzLX6//ZH78jCptmp1OdPJlfE2FjsX1bSWFL0yicAz6N9Fg6WWxKd8JHebL3Hs
         bkmH5SDuSOb4xUKlRepXAGyilt2Qxt0yY9XNhooiv6ahJNca99osa+CJ27/LvoKsUjAp
         wXwposh5CM1MdXUbMEENW7eFunav8U/ZaNnpwSa37gpm7Wgbeu3V/p6P43DQe+CQUYoD
         M4pQ05UwcEQL4aHv5W/iZLllPx1THok0ojDVuOglXjxEUogyttDcIJKUf8rhkakNE+jl
         YZ2doE8Jj3Tqhij3JtPb7M4EK51oe4JtPvIkOop+TLdcnFIsICCM9GKJAIaP/mXy/LsD
         1/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PYeJtucV/pofU0a3vidJiO2yHvrpKBoKYQ+PwZnR3oA=;
        fh=dUhgh8e3aLY+rS/tlCDCC6FFjYoB1JvgsR0nfbbkDdY=;
        b=MiP7+F21wIBCqvJ5K+8yaz3GBTLBWbrKCZfMP3ohm/r+hMyaRPIM4K1KGcBHC3krIj
         711BqedA/qghChLSrDxgcLkvbzPfnJMHwSQ9aCEzCWOyExgKDthsIfvusf2g7e3ZYVHA
         7AlT82KVjKX/QvdGEfor+u3QeGUE/rPcs8spdUuWUsXc9VMhgqxV6caY+RdgkN7IJjL4
         lR1fJsvM1QpwAl9XipivaqrylVzTTd0baTy5LVkVrkNqASLsS2sPtKQVNL5ChwYiGGcX
         EPRNG6dsmGUcFNLejslmLW/nvjbTRqksrN9uKCnEDMHJTUIJbdOFRV/Vp/40f1F0gMHV
         wHWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1780796126; x=1781400926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYeJtucV/pofU0a3vidJiO2yHvrpKBoKYQ+PwZnR3oA=;
        b=XHq6YYOg1COX2jWGAEu92fJ6f9ydZkEEITJNdnuqnUkI8cc9WVImNzSHEB8w7FT+0k
         f/Qm4DF/7p01++RSaNQI7DloK/V58UA0Ghpxz5eHZU0RJlrmcISmJSjAVwkibnsXJIZD
         Xt/AUMERLj6stMozsiYfaQ4auOyeFzpZ0AL8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780796126; x=1781400926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYeJtucV/pofU0a3vidJiO2yHvrpKBoKYQ+PwZnR3oA=;
        b=A3WSz9AUU8F4+TM920q/omR03S4eJCoiWYlyL7jr2PmEQ+IIVoaH8IoN+o4rVH3XfA
         TWr4HKvndqXVm1T896W1h0Tt0yhOrQghaNE+/i7pNKlbhK4x3OOSu2iJclR1NwbuaYSK
         0jLOO4XfhNy3qgBhd30nwr5h8eAe+bK1bmpuiEXtPpTG3J4M4A/NNSGyZBNlWmbUTLfE
         fpGhHpUhYu63Ck1kTu5uYHrewnG4p2VL0zWr8Wo3jI+XrnkX/A8Az7288kD1ALYQ9Y3V
         ZVJoKShdr/ZOApTc7Rkl9C6fJNCGDAl2DqvbzmuYhyTY88ik6cqC2DZi3ot7GtUYIErC
         d2+Q==
X-Gm-Message-State: AOJu0YwiIM38dzaU4UQKYSWomoaJZkpKCpwsE0u+fXcN26iprk2zwrt2
	KW8PfmjIUI/fAcfIVqq/+pVnCSGWJcDV7+fqtwI48rvqYQHULV1kh613EheSJnI4Yx71IrODqyL
	838MFmC9+vuh6/oUneqZdDr7ks0txTLNvRR2lbJHxyjBXg5uPwrG7aRY=
X-Gm-Gg: Acq92OFEi9iW7/jwMVnEPHm1DRWFpk5BuYDlCXaqdamswmgO14qCFJaGS3EFPBL+uSu
	2ldr7rcqqaOfTyly2CPKIta4cHG1PY/3eJUj7bzp8OmDFcdjJhU2WYcvlDx1Vv+hKL4MZT6SeE+
	Vo8epqWYwpugcLBb7ypAbRYGSRFlQO6EvvzEkzQQ3qM+U3x7jB+65ZgsFPQN0foNVQCSS4kgLPz
	BIOchkQxAMBfCQLhtFLj0P7NuoEHhudk+UlT2rrZlBfXPMT0pMLx4gGMAylBF2XzFJE5c9IG2KX
	WRqO21kqD4ErftXXsoAlRzf7Tnyy4VIkaezrvQe77Rd5M02NkGN8mDestHJlsIeD
X-Received: by 2002:a05:6808:1454:b0:479:d7ea:ae34 with SMTP id
 5614622812f47-4868de83f5bmr6064918b6e.24.1780796126587; Sat, 06 Jun 2026
 18:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607013406.7294-1-kylebot@openai.com>
In-Reply-To: <20260607013406.7294-1-kylebot@openai.com>
From: Kyle Zeng <kylebot@openai.com>
Date: Sat, 6 Jun 2026 18:35:15 -0700
X-Gm-Features: AVVi8Cc7VSQ8g2sE32J7gbzGgR1D76tvPuTxb0IOBjY2s1E2ue0YZhOig1pL0hc
Message-ID: <CAC7i46-5WynwRsftC6LZ7fNo16w_YnmaQn3RykAR0j+Hi5dTPQ@mail.gmail.com>
Subject: Re: [PATCH] net: geneve: gate GRO completion hints on socket config
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296172-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[openai.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:dkim,openai.com:from_mime,openai.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6A8A64EA76

Hi,

We have a PoC that can trigger warning or KASAN report.
Please DM if you need it to reproduce the issue.

Thanks
Kyle

On Sat, Jun 6, 2026 at 6:34=E2=80=AFPM Kyle Zeng <kylebot@openai.com> wrote=
:
>
> Geneve GRO receive only consumes the netdev GRO hint option when the
> receiving Geneve socket has gro_hint enabled.  geneve_gro_complete(),
> however, parses the hint option directly with geneve_opt_gro_hint_off()
> and therefore extends the completion offset even for sockets that did not
> enable hint processing.
>
> That lets a packet for a normal Geneve socket carry a syntactically valid
> hint with an attacker-controlled nested_hdr_len.  GRO receive validates
> and pulls only the ordinary Geneve header/options, but completion can the=
n
> run the inner protocol completion callback at nhoff + gh_len where gh_len
> includes the untrusted hint length.  This can make completion access beyo=
nd
> the header area validated by receive.
>
> Use geneve_sk_gro_hint_off() in the completion path, matching receive and
> post-decap processing, so the hint is honored only for sockets that enabl=
ed
> the feature.
>
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>  drivers/net/geneve.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index c6563367d382..d62cbee6c0fe 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -948,13 +948,13 @@ static int geneve_gro_complete(struct sock *sk, str=
uct sk_buff *skb,
>         struct genevehdr *gh;
>         struct packet_offload *ptype;
>         __be16 type;
> -       int gh_len;
> +       unsigned int gh_len;
>         int err =3D -ENOSYS;
>
>         gh =3D (struct genevehdr *)(skb->data + nhoff);
>         gh_len =3D geneve_hlen(gh);
>         type =3D gh->proto_type;
> -       geneve_opt_gro_hint_off(gh, &type, &gh_len);
> +       geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
>
>         /* since skb->encapsulation is set, eth_gro_complete() sets the i=
nner mac header */
>         if (likely(type =3D=3D htons(ETH_P_TEB)))
> --
> 2.43.0

