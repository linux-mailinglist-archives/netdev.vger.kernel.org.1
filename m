Return-Path: <netdev+bounces-110729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555EE92DFB0
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 07:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C5B28360F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 05:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4A6BB33;
	Thu, 11 Jul 2024 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="uNwFtapn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FF176F17
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676418; cv=none; b=Pea4DHnWDDXwQN030w2em44Df7UFUg9+ZTVv87EdmIsCPauyuKpvzGvuZS4cVi66p4iB417cb12LUVbfMFb4j0ttJ/eiLfaJHO9hs6wk0qAYluTYDNUooKpB/JKGo0rZz+B9rx2A5TOx21ZD01UYocuv0bNf97ISr9n30SJ9As8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676418; c=relaxed/simple;
	bh=er2u/C0ayZ13lixi8pV/7AwVK//BH86gyj62gEdZx1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSL1rXTG9ckmHHN+Xo8DrzmUs+LMWPZuL7Nx4zn66G57rYrVSBf4cWqa29WjB5FDZ9N/VBmVByHktq+eXucxR1dmRxIU+7HOqZiuZbBG8V/E/jPbetXD0UcNpPf5YgoEXAmCvwvgwBYNzlsJVhXAJWACAz+UJ/H6xiZhr1FJCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=uNwFtapn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea929ea56so939046e87.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 22:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720676415; x=1721281215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtQfbSYXmPmFxIghTAuaXxtKY59+oSbNVAa06oAvgE8=;
        b=uNwFtapna79wdTJKkHWqopN+thTpQZnZjgTuOPCM8QpZaYpNuSWFiosCRNIOvCBdWR
         XUfoggw+CZ+8DS4HCLGPiJVnNRFM7/Yz1HeYhON0Re3/UXVLFRzRmiE68FUNkbMBWyEL
         S01597pyjPBHeYZYnTvTY6ojpmuHeA3QwALvp7WMn70jsGebKTSs1djASJrSh2xskf1v
         HOFLKQLb8bQdiQkWAZBeDlDtlTYYNic6uGlVTj5P3FXkPsxh+MfxnEkODIFvh0ZfpKjW
         r/8O5QwKg3WDk7clFIs4FPBTx/XmmnGf8xheixKOx2fWPED+SYV9IH/Htus/XYRmCgsD
         As5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720676415; x=1721281215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtQfbSYXmPmFxIghTAuaXxtKY59+oSbNVAa06oAvgE8=;
        b=jbkZFth6br6OfGleIZBP24z0ZqDz40SMFqv/vHQOIvacXBDJfmyFDGwAqho87s4BGd
         TpbTlDUbg/lS5YHLkEKVZqPBKcSuyCkBz0TF9dd5Y0uowMm0MosnkeIBuOuuDrNR1gKs
         kGNBSULL8+BJWp7AwyhPgLZYOqifkzHg/Mb/4P9Ds9dJGonK9P3S8EaGpY3kmSdodidG
         QFVSDLVnDRdSTC5nf348Iytjbem8pt4vDDrE9xjQFVCjtROzdQKar1cXh36l/cJ2i6+1
         jHlwodoQ3SK0+b9beioN/wUvztetI5pqc16Z2GuTeMXBua1+gJxNd9MLvgyrAB10r3Lw
         namQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo7e/KF1Y4cBIJv46BC6m8nGWo1h7IG9e3fhGb2YXZZXHxDSL8zatfcMo9z0XCBjVBeVBs5HDQWrHp04Tcv7rqGtEKawuL
X-Gm-Message-State: AOJu0YwGP2oiNpx1jHoT2q8OBpt2AiD0LV+a5pEtwMRT2lC0qJmkWQZo
	v8lzl4GJmUMgtYz1cbJE5/fqI25LvK0wxf7GBBr3cej4Bwhk1Mufa1+mB8rQo2ZKhnsFwQzjoEI
	NtIMtW3aY09PHPcvUw8PPkeLgNFIvQythGAopsA==
X-Google-Smtp-Source: AGHT+IF+BKDpNJnivyTpTW415g8VRESZbb/7e56pM3pMEuHmh9WnGF7mjq0NVvmuJHBA9fsXR2GqhBai5y9XkJzcVSA=
X-Received: by 2002:ac2:5544:0:b0:52e:751a:a172 with SMTP id
 2adb3069b0e04-52eb99d288dmr5355776e87.49.1720676413776; Wed, 10 Jul 2024
 22:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620113527.7789-1-changliang.wu@smartx.com>
In-Reply-To: <20240620113527.7789-1-changliang.wu@smartx.com>
From: Changliang Wu <changliang.wu@smartx.com>
Date: Thu, 11 Jul 2024 13:40:02 +0800
Message-ID: <CALHBjYFn_qB=Oo3TTg0znOnNz9rX5jP+eYSZbatAN94ys8Tzmw@mail.gmail.com>
Subject: Re: [PATCH] netfilter: ctnetlink: support CTA_FILTER for flush
To: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PING


Changliang Wu <changliang.wu@smartx.com> =E4=BA=8E2024=E5=B9=B46=E6=9C=8820=
=E6=97=A5=E5=91=A8=E5=9B=9B 19:35=E5=86=99=E9=81=93=EF=BC=9A
>
> From cb8aa9a, we can use kernel side filtering for dump, but
> this capability is not available for flush.
>
> This Patch allows advanced filter with CTA_FILTER for flush
>
> Performace
> 1048576 ct flows in total, delete 50,000 flows by origin src ip
> 3.06s -> dump all, compare and delete
> 584ms -> directly flush with filter
>
> Signed-off-by: Changliang Wu <changliang.wu@smartx.com>
> ---
>  net/netfilter/nf_conntrack_netlink.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conn=
track_netlink.c
> index 3b846cbdc..93afe57d9 100644
> --- a/net/netfilter/nf_conntrack_netlink.c
> +++ b/net/netfilter/nf_conntrack_netlink.c
> @@ -1579,9 +1579,6 @@ static int ctnetlink_flush_conntrack(struct net *ne=
t,
>         };
>
>         if (ctnetlink_needs_filter(family, cda)) {
> -               if (cda[CTA_FILTER])
> -                       return -EOPNOTSUPP;
> -
>                 filter =3D ctnetlink_alloc_filter(cda, family);
>                 if (IS_ERR(filter))
>                         return PTR_ERR(filter);
> @@ -1610,14 +1607,14 @@ static int ctnetlink_del_conntrack(struct sk_buff=
 *skb,
>         if (err < 0)
>                 return err;
>
> -       if (cda[CTA_TUPLE_ORIG])
> +       if (cda[CTA_TUPLE_ORIG] && !cda[CTA_FILTER])
>                 err =3D ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_ORIG=
,
>                                             family, &zone);
> -       else if (cda[CTA_TUPLE_REPLY])
> +       else if (cda[CTA_TUPLE_REPLY] && !cda[CTA_FILTER])
>                 err =3D ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_REPL=
Y,
>                                             family, &zone);
>         else {
> -               u_int8_t u3 =3D info->nfmsg->version ? family : AF_UNSPEC=
;
> +               u8 u3 =3D info->nfmsg->version || cda[CTA_FILTER] ? famil=
y : AF_UNSPEC;
>
>                 return ctnetlink_flush_conntrack(info->net, cda,
>                                                  NETLINK_CB(skb).portid,
> --
> 2.43.0
>

