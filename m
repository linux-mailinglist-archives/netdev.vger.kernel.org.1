Return-Path: <netdev+bounces-70981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A080F851755
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56692282962
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24F3CF45;
	Mon, 12 Feb 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hFilfRX9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA23CF49
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749494; cv=none; b=T+8+l6IEDqsExuVMYHwaNV9Ks/XSZH11T3hJW4CJVrvaq65zloN6yOscNtoAMmvQ5vV/cfsIgpnx39DsF8st7X8/wkI1IILFLgpBh7AnJTSmAYMFWFilrDkcTbmy4/REr/pOne4n5vPii+86QqnwL2J3WQNdrZJO4cong3ZEO0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749494; c=relaxed/simple;
	bh=EKTPx1I9DCB4snrEv1KrFVPojJBEFxl3/ySPIhsrknM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBdtoRMqSu6c2MU1HOyEdDB3FX0Crn2Rbyr3g/eSbLtBYlRGRTeguT30rk9fVWCaHne9yLMJHtkESSk3RxOgKkBeHDJBG5GJTMVQh8O4FKSXiObRyDCaMX9PY2g5CfxknJBQlnRYleGE9+u/AynsgOBDjpuILX7qxGZJ9sI6X+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hFilfRX9; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60499a12ca0so33429467b3.2
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 06:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707749491; x=1708354291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/TLyNvZ+yWhZ4oa77M06VQsU/4WDuJ/kEwhaaIT8PQ=;
        b=hFilfRX95y93pXQIAHk/jRGmxAt8DjeshqGxood0SueMeuewWTAVRhUG0pf0UWtcVQ
         s9bjZQsfwh1i3f8utJ7jYG2rSqHnD7+l1hcnrO17REOFktt3zJpsArcnJnhM9JQW287O
         iuL89T+LAeR7ni3DSqLfOrgLvb+SzbuwTs3wjoGcdJ8e+ZxGJjsvez6a65Uamlu98q+v
         J07rmT26udU6mG6fozJn4zZjeSvg4clamJZTkjyfJZxPppXYeBDbNgqJ+eWbs6jJWcIk
         Kc9h+90EprVGFgHJcvzG9LC79Pbg8apETdghqnc0ZqTQJI5y+vTMUO1vXnUWwG3z3h3t
         RCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707749491; x=1708354291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/TLyNvZ+yWhZ4oa77M06VQsU/4WDuJ/kEwhaaIT8PQ=;
        b=jRLQfmz6Z6XgFsyL8qPje+Lp4NBtTrrdJoKBpIFL1udfxadNSD5xM09KGsRX/wJ4W8
         gOiSoCq5Os5ISD3VbVMa+5Gl/+0JRrWVruNSF8E5Q0722RVOmNbrMrK0XLF2tzjSjfhu
         5LPAaSTsLwgWZsJTlVTiN7KR+hbMMqk7Eclz8s3vfIz1obG6dyoirZ9j21p52dJmq/NK
         y4Mgv/bxIDAQponEX61V2JoO2HzW73gHeachIVTgj6sJGDff4ZnG513Qy/OsW4Kvpt7W
         +EK7diasL9r97ELT6rYeEss/OC3YanO2LjmOn3QP2qQHPSCmSJKQ1cFVmTQsHlKEPKtR
         YYLg==
X-Gm-Message-State: AOJu0Yzh5HPwqQLSb8LtrEsj9izXz3pVuXrbdo0vK5OQZ5qv7N/lYKOG
	y2g56euuMTz67WcOQW8SRWzFzl22ZsMed4pzr4jpW7BwfdqwxQgrIYFnfvuy4MpNI3r20TSmzT3
	hyHsnnVBXHg5n0OOcjPyDvmWmmobbEIkt1F3/
X-Google-Smtp-Source: AGHT+IHIXd81wTKUgyG11WQgHoI+chf6xLB8EkEbsk6VVf8AvWwnWMVryBfBMnjBUgLVQVZ9f8SnV1dxfyTHohupY34=
X-Received: by 2002:a0d:ffc6:0:b0:607:6fe9:f55a with SMTP id
 p189-20020a0dffc6000000b006076fe9f55amr1178250ywf.35.1707749491614; Mon, 12
 Feb 2024 06:51:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209235413.3717039-1-kuba@kernel.org>
In-Reply-To: <20240209235413.3717039-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 12 Feb 2024 09:51:20 -0500
Message-ID: <CAM0EoM=kcqwC1fYhHcPoLgNMrM_7tnjucNvri8f4U7ymaRXmEQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred ingress
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Davide Caratti <dcaratti@redhat.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	shmulik.ladkani@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlo=
g
> for nested calls to mirred ingress") hangs our testing VMs every 10 or so
> runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> lockdep.
>
> In the past there was a concern that the backlog indirection will
> lead to loss of error reporting / less accurate stats. But the current
> workaround does not seem to address the issue.
>

Let us run some basic tests on this first - it's a hairy spot. Also,
IIRC Cong had some reservations about this in the past. Can't remember
what they were.

cheers,
jamal


> Fixes: 53592b364001 ("net/sched: act_mirred: Implement ingress actions")
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Link: https://lore.kernel.org/netdev/33dc43f587ec1388ba456b4915c75f02a8aa=
e226.1663945716.git.dcaratti@redhat.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
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
> index 93a96e9d8d90..35c366f043d9 100644
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

