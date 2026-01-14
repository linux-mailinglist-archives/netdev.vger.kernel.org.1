Return-Path: <netdev+bounces-249739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF7AD1CF97
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28D1E300287B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E281537BE85;
	Wed, 14 Jan 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vY9AIg7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3C24A067
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377517; cv=none; b=aJ1aX/KtXs6dY+jrhSwjSzoJCx1/L96aJafVtkY5PpQIvwz+H/TDoBTDVYFbMQ+me1MHMPoFLO31rSM3ZpuPQ4bTY0r33P4quFDPTPJ+wh8Wl9h5WmzJVomI54HD4MHzEppwkJnMfvUcEb51ghWs9+dwaQIVhJGx7sDYZA1CCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377517; c=relaxed/simple;
	bh=ur/1N+8Pp5tlFhAdJOrSuu8hzNf52osfOEhoJK6COP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7B7/zBxM+lvNfwbDRuXa1N7gOdn2qsk9RE+7UnXtQJiJdwLBJqxJurEFYlFUC5bZEK341+D+HnxLaAuDmEMxvuXKnlu8lgdcvjfkmGMFyemIMvNQqEtvxifgVqX5bULlwaLPbA7DbmI8x+hK18yC9kRnCVTO2F85KsJ7CnCVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vY9AIg7Q; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50146483bf9so15185081cf.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 23:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768377513; x=1768982313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS0RgjKS4kK/13ZceFw0e8/jjccYR83h4CV62hyXWGQ=;
        b=vY9AIg7QZfeBAkpDCAtFbHd4SHvImIU7QLcjFepkgM76TN93gPGGKvsKzoJ27+s0cU
         Ocbnng6EulV/h2zwQDObd5hmKFVsgJ7fhnk9FXQkSMmFQWRbyePJcyivFpHrbc5y2I1J
         0DWefCa0SLV+Mx1MFAdPbA3LqikqweV+On3PSuavjxMkLemoSXahNSECU3wtPbdDsw+h
         pUtYiAe5zYDYpgIdW79MBseFVvtEcufFSeYv+nw/cBpQFioyEa3zB4T/uSKYJG1d+IXt
         oPYXv/yoIRSmLyUZU0EYRDThRkGQD7L5TEb1zCeRPsJqJ4/SvgNnZ8nh2jVDuC0+X5Sk
         j+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768377513; x=1768982313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KS0RgjKS4kK/13ZceFw0e8/jjccYR83h4CV62hyXWGQ=;
        b=c2RtTgxRTRG+AQ0GnJpvUuDJJ+YNb4Ho+J9pQaEMr1x06uCPh/ytMstxake1NYNkve
         wYfLD7hknaXWp6wQMEfyhQZIemZDIf17+PamKlfhrAP0SacaOxGDjW/6b9CL5XFQo8sO
         OZWYOE2AhC0+D0vUIlatd3kCtDy3MqQM44dmTaP0jq04wavbBpnyHxua3QbvqgoMkwLE
         x2l2pTwsG5IxDnzN9npKNkMAU/EypqYadpppSxHyvMgIa7GnWeYoqNlXYA6VU1n4nla5
         4dmjMp+TURzq+S+AzRqNeQ4LFunI+1hyTl6GlGnN5jL0tMZm1Zq7x24FcaOjfAPcf6SC
         RYWg==
X-Forwarded-Encrypted: i=1; AJvYcCXgZHrsisjk65APVggfbvSgaTFhZOQED1N1pYlHzW593e5u1zaASlreESwZhEleVJWCM9oBVrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqtVYPftGzn028XDdqFCVakHhTkeIUodhAOZi+5WeOOK+semXj
	Ok7NlyuwHFG3JPwaJUzZwmYjh5yRLB+xE034spJ0qujclVeq0ZJ2h4j7QZ+EDaWaWxoIdtotXWh
	60h2xCFbe/Y0+bYdxbod0twbWbz00KH2/Fds0vclR
X-Gm-Gg: AY/fxX6cKyq0/jMrfFANnu7jlM5WoxgMbcprKo1rHu00ibdnUyqICkPjFqszq2d2yJF
	sV5BlvIJTqO9P3d6TJ93hynpDcs8qCrxL2LoQRW0+It7X10yfaq86GhMXifcADpjpw2uZNBHekj
	2VVvdCwcmONAU6KJeyWTDEqPPdLCxkjvOJAPDgJFBvMebq7jjnf+gkkhpW+1AwotPkxzMpdmC9Q
	1r3tASA9I3d5+YZu5Wmm9TKOi7l2A5ioqM4AivQ4D/RDK5r7B4BX2cucnPLAeTlwkpUYrUi
X-Received: by 2002:a05:622a:4203:b0:4ed:df82:ca30 with SMTP id
 d75a77b69052e-501481e9360mr22469121cf.13.1768377513015; Tue, 13 Jan 2026
 23:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113143157.2581680-1-toke@redhat.com>
In-Reply-To: <20260113143157.2581680-1-toke@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Jan 2026 08:58:22 +0100
X-Gm-Features: AZwV_QgnLNgfxSc_QYvpFJdNGcLOfkKl5TVYTVho5qgGdKMeOVvQUnotTW6I4yw
Message-ID: <CANn89iLdM=a=oagYA=LKbfaDuhQaYtxA0wNERuzNLGghA58Phw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: cake: avoid separate allocation of
 struct cake_sched_config
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	cake@lists.bufferbloat.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 3:32=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Paolo pointed out that we can avoid separately allocating struct
> cake_sched_config even in the non-mq case, by embedding it into struct
> cake_sched_data. This reduces the complexity of the logic that swaps the
> pointers and frees the old value, at the cost of adding 56 bytes to the
> latter. Since cake_sched_data is already almost 17k bytes, this seems
> like a reasonable tradeoff.
>
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

This is also fixing a panic, so :

Fixes: bc0ce2bad36c ("net/sched: sch_cake: Factor out config variables
into separate struct")

For the record, a fix for the panic would be :

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index e30ef7f8ee6862a916acc06e568e37f35fd675b1..742fb850e2afb159f215b263bc3=
6c372552911bc
100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2825,6 +2825,8 @@ static int cake_init(struct Qdisc *sch, struct
nlattr *opt,
        struct cake_sched_config *q;
        int i, j, err;

+       qdisc_watchdog_init(&qd->watchdog, sch);
+
        q =3D kzalloc(sizeof(*q), GFP_KERNEL);
        if (!q)
                return -ENOMEM;
@@ -2838,7 +2840,6 @@ static int cake_init(struct Qdisc *sch, struct
nlattr *opt,
        qd->cur_flow  =3D 0;
        qd->config =3D q;

-       qdisc_watchdog_init(&qd->watchdog, sch);

        if (opt) {
                err =3D cake_change(sch, opt, extack);

