Return-Path: <netdev+bounces-72139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987CE856B15
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BADA31C21461
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ACD136674;
	Thu, 15 Feb 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="e85t5s/U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D2131E5F
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018395; cv=none; b=s667L+2U38xZRXR2bmwo+XSrICxHGakRKSdU/Bvqvc19S2I8zGZmZhj1rsU/+in/onntpenOFRtRbAt1QWuZvDkFgMDGiDpaAZdla5rnd7Q1leHioULF+DhQ6DzaR901o3TwUqjzpHkKQcckHmlHF10LkkqGuFxdlpvS++QTd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018395; c=relaxed/simple;
	bh=XOoJrBaOhX8STqveR3ax6C+g6iCePzVqRrqjR/o0mNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjyPFEzffV+F2xRcttYuHd6UqLTZ4HQehN6h3u7HAo4wUOFxJjRbc71ZanPCISfpGx9CY4B4foTYdSfyYxKzXpYl1cPMJWGYYpihClZiHw4iNtCJQml5vKbPNETRdvYHC4jeso/OAfc5wCLcgo5i5FLhr3C9WpQgflxX7YTvsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=e85t5s/U; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6077444cb51so16598437b3.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1708018391; x=1708623191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ax5GBiDBDAol2EEyKZxKj0DasdQDJGBTOuGru0vLaI=;
        b=e85t5s/UIP9LmwNL+wSHzlIknUL6hiY+z6e1xqnp04gGapd4KobBWQ5pEAdZSHvQKD
         XaZijMKgyPXxL8U1D4IxBn7AEyZQjF2+mG6yj26h8TS/dvzRBLJT4z7vCr1vOvjHfmOU
         sbNU/CETlVOJ3sLBAcjj2BwNZDF4fw1vlF7hyXEGwxJwUgiUjVbvUlkPI3vNuaDT9IrY
         fs5URAZyPL6kBaRBX0cb431yU/OuNiFdJ9msO4duwm79GkwXU2lHCzQ5YvVKzsNlH7eK
         tuiV2Es76HRyi8/j6MP26gPNQznj+5dti+LTJpyYDODVZWnOJ+j0ZeuVjdcc/poJ1sqz
         BFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018391; x=1708623191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ax5GBiDBDAol2EEyKZxKj0DasdQDJGBTOuGru0vLaI=;
        b=XFehdIacL7t2TJjTlYmFFg20IKcmlZekg3jnkqeSyoqGqagnb80EmCw9dHtpMZMbLP
         y3xliLoUX8r5N3sL9DzO0/zOE8Ky74phxlaVwja3KlPqloPV3OQRghkohyrBDy7mJBuX
         YqLqGlm7/u5KXdjBFkeiVR/q5u9nQufYThIuUysoAKqYqyZP1sm5wH4bnIGnS5LXl1Xu
         OcuetDz5wBa4fnRppsrDPjipLiKX9N604vdSdRjzQ14CTOGT5PrVynLaDhqWxr018lXo
         Euy8bxh0ikiGV+hw/WoQaqM4u3ufXzUcrb1Ilq1NJ3So/xUd9xNpscf2g5RDAym5dcvI
         Dr1A==
X-Forwarded-Encrypted: i=1; AJvYcCVQvMbbVu7DG+6gwb35hQwhur5oGPiRnPAyMUsFgXLi2u4BfNN9Q4vpzDMH8DnfDzirTfgWsXJKNI/yubrrtyNXDUktIUT6
X-Gm-Message-State: AOJu0YwqeamOCXuyi6g5VNPLMe67osam9UfMFNL907E0qwTuBH87ZwYX
	DB9i21KSoYW9PUpxW/9wOEVgbZPhTX25hqy/V+oitjYS9cJYOXKbIFkhmFgglh9QcBNO+x0keN4
	nFBk6Jf1XqUJITAlIY/quFam7RLaOfYNGC/4z
X-Google-Smtp-Source: AGHT+IE7BFVjRvJttW8j5zyUeF9xqWALpKxq95/YFbCSOroAwcvwJFwUrlwEahnuLkFRZpP1d2sj+ae7VsI9+rQuP4A=
X-Received: by 2002:a0d:fa03:0:b0:607:d337:3355 with SMTP id
 k3-20020a0dfa03000000b00607d3373355mr1747416ywf.11.1708018391675; Thu, 15 Feb
 2024 09:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215143346.1715054-1-kuba@kernel.org>
In-Reply-To: <20240215143346.1715054-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 15 Feb 2024 12:33:00 -0500
Message-ID: <CAM0EoMnzsSspPockj3kA93ZUD5ibroA8by93cwC11uCTgLEP=g@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net/sched: act_mirred: use the backlog for
 mirred ingress
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Davide Caratti <dcaratti@redhat.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	shmulik.ladkani@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlo=
g
> for nested calls to mirred ingress") hangs our testing VMs every 10 or so
> runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> lockdep.
>
> The problem as previously described by Davide (see Link) is that
> if we reverse flow of traffic with the redirect (egress -> ingress)
> we may reach the same socket which generated the packet. And we may
> still be holding its socket lock. The common solution to such deadlocks
> is to put the packet in the Rx backlog, rather than run the Rx path
> inline. Do that for all egress -> ingress reversals, not just once
> we started to nest mirred calls.
>
> In the past there was a concern that the backlog indirection will
> lead to loss of error reporting / less accurate stats. But the current
> workaround does not seem to address the issue.
>
> Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions")
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Link: https://lore.kernel.org/netdev/33dc43f587ec1388ba456b4915c75f02a8aa=
e226.1663945716.git.dcaratti@redhat.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: jiri@resnulli.us
> CC: shmulik.ladkani@gmail.com
> ---
>  net/sched/act_mirred.c                             | 14 +++++---------
>  .../testing/selftests/net/forwarding/tc_actions.sh |  3 ---
>  2 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 0a1a9e40f237..291d47c9eb69 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -232,18 +232,14 @@ static int tcf_mirred_init(struct net *net, struct =
nlattr *nla,
>         return err;
>  }
>
> -static bool is_mirred_nested(void)
> -{
> -       return unlikely(__this_cpu_read(mirred_nest_level) > 1);
> -}
> -
> -static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
> +static int
> +tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff *s=
kb)
>  {
>         int err;
>
>         if (!want_ingress)
>                 err =3D tcf_dev_queue_xmit(skb, dev_queue_xmit);
> -       else if (is_mirred_nested())
> +       else if (!at_ingress)
>                 err =3D netif_rx(skb);
>         else
>                 err =3D netif_receive_skb(skb);
> @@ -319,9 +315,9 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, str=
uct tcf_mirred *m,
>
>                 skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingres=
s);
>
> -               err =3D tcf_mirred_forward(want_ingress, skb_to_send);
> +               err =3D tcf_mirred_forward(at_ingress, want_ingress, skb_=
to_send);
>         } else {
> -               err =3D tcf_mirred_forward(want_ingress, skb_to_send);
> +               err =3D tcf_mirred_forward(at_ingress, want_ingress, skb_=
to_send);
>         }
>
>         if (err) {
> diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools=
/testing/selftests/net/forwarding/tc_actions.sh
> index b0f5e55d2d0b..589629636502 100755
> --- a/tools/testing/selftests/net/forwarding/tc_actions.sh
> +++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
> @@ -235,9 +235,6 @@ mirred_egress_to_ingress_tcp_test()
>         check_err $? "didn't mirred redirect ICMP"
>         tc_check_packets "dev $h1 ingress" 102 10
>         check_err $? "didn't drop mirred ICMP"
> -       local overlimits=3D$(tc_rule_stats_get ${h1} 101 egress .overlimi=
ts)
> -       test ${overlimits} =3D 10
> -       check_err $? "wrong overlimits, expected 10 got ${overlimits}"
>
>         tc filter del dev $h1 egress protocol ip pref 100 handle 100 flow=
er
>         tc filter del dev $h1 egress protocol ip pref 101 handle 101 flow=
er
> --
> 2.43.0
>

