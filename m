Return-Path: <netdev+bounces-247890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A54D003F4
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 22:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0A830DF72C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4D2FD675;
	Wed,  7 Jan 2026 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDgOLQli"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B02315772
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822415; cv=none; b=hc6wFduC02uUXlUn3pF/XnQHQUtvvbEhKadicfI0oBBtmU2DwZ8l6IspQQbiPHO/v1ei2kICZ0o5UbD/ZHrdBydbpLssTUbccWoBs+OaSAvmnKT8aFHEC7xEfoLu6d3kt6thxnbPYDbpzQotic12/Y2M7sksekNH/gpWV5BRwIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822415; c=relaxed/simple;
	bh=B+rmMcPAukV8wuSRaPIjiyTdfpSg4OhxtOun7+AHguA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pkqq9xqz9qgf5toLgUgPHnQYNx4pP6gy60Vv6UQPfdPused59iYH/YixQ42bBfh53kM2jwNrDqkKd3nE/jk1PSvY6szeekiHdb9GbC6C2D+JoSM2YqxLJxoXJ8VWzl9+d3qeOGDDuarvLZcrH0t1LJkq0fGW+WcwyTwDkNJs510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDgOLQli; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79045634f45so30167997b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 13:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767822411; x=1768427211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba5UnTHKPwT9HtMYOwC8JNbAeWdAQbjjXolShjBiZf0=;
        b=YDgOLQli5rA0w/vIivaXNTTwqvt7ChuppKarzhzoEKmH0Qioi+ttZr6LZdakV78aO7
         pdGyeHtSU3xAH7wLHxvaSYAw2Im32PWOWe3RS9OUu8hb6YK0TnNpbIWKkvVyi0NvJMKw
         6mo0uUEQBMg8FonuGuAzf5tRZadB+JyN7egLSCvuJBNi3UQz8g+/Dn0ST1KcoBIlB3BP
         M8ctz/YMLobOjjSFfOxNlPTbMG7kglJxtQBeqwvueozkZLNNDaYxaNlQm5H/u+LC7XQO
         kdkN8K0csC7flLgCMjg5nIlHDR2/Hs8noTu6hG30BFEs1dfhW66AkcxQobg8OXWD0Z9o
         x7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767822411; x=1768427211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ba5UnTHKPwT9HtMYOwC8JNbAeWdAQbjjXolShjBiZf0=;
        b=KjQEA702mBAh486DZAJg3qZLQv8uBY9RrDeCSHNnLSAcUp7o6x0lJbriUGfZxRzCjD
         FBAnfYbdPxBU2HYX+RBO3e7Bug2q/MZ0zDAlSmNOd+xZmmo48rA9J8qCUD5j0Kw0/VmR
         msP/OYA25AO7nNaGGGiZC+KhbvW2dV06JBL1cgltAuotrdhsteyAWZ6NXLr33IeD2MN8
         ypfvijpHVZ6A3DNKjmOR46IzIs3maW0rVDCB+qYyF5V9RoVRXqY2bwV1WhW3iUFVnjnh
         xZ2Brtv7TB9c8TaAYzUlD0RTrCqmwmDViFS4iK34lgCWUC2reJCf7zSVIvvzLD1SXCS3
         bAdw==
X-Forwarded-Encrypted: i=1; AJvYcCUJPX/larJz73gIHs1jJCh5NuW6CrXHeQKX6yrPSRUeqxW8vQEinfIqlbfC4in0cSyqHFfwGxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRB8zOba0DU7+baWyOS3ky5nvFuSseQsZ5srhNpcCuVFclJUqF
	WMgPzF1i+9lYx1zT1uDlCd+s3+pRYpz6D9ZUmmLs2Und3Esd6xo1pT706tazjw4yqKdI00yZADg
	6GDXrU3IwJEXdjfkGxleB5YifHVtKfhk=
X-Gm-Gg: AY/fxX4n5Y/9fBUrA6o/WOZMJCuDABFCQHIbsDS625Qhv2+mnooSyuO8UyurlYkh8PR
	Q8jkusDEdK8YWhwrVtwWf2YXaTzl9T8NDYL9e/TO0jqRvlj+Lj76x57SSYpogBrF0c47L4euNqK
	OqXFFlpGjYJEU7axZe5r4O3fPAt1UBZ/s+wCHTZP6e3JDG/HwrJPWDBJl2us9UgTU3aNhW70UtW
	R2/C+Q7gz2Jo02Zu4+P+bLsJwKIK3k5G2gjyRnooR3udo0FJgyhGX1UvmVrU7UwEEGb7fjZzxHR
	jFUWpA==
X-Google-Smtp-Source: AGHT+IGll6GkDJRECp3vd3uBcAowUXr9H4G/cY7soax6Ov9ZEYpUbqrQTLmg9LVPS73K73iw6iSr8M877BSFbOfz4Z4=
X-Received: by 2002:a53:cb8c:0:b0:646:68b4:a7e with SMTP id
 956f58d0204a3-64716b3aa6cmr2541573d50.18.1767822411069; Wed, 07 Jan 2026
 13:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105114732.140719-1-mahdifrmx@gmail.com> <20260105175406.3bd4f862@kernel.org>
 <CA+KdSGN4uLo3kp1kN0TPCUt-Ak59k_Hr0w3tNtE106ybUFi2-Q@mail.gmail.com>
 <willemdebruijn.kernel.36ecbd32a1f0d@gmail.com> <CA+KdSGOzzb=vMWh6UG-OFSQgEapS4Ckwf5K8hwYy8hz4N9RVMg@mail.gmail.com>
 <willemdebruijn.kernel.21c4d3b7b8f9d@gmail.com>
In-Reply-To: <willemdebruijn.kernel.21c4d3b7b8f9d@gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Thu, 8 Jan 2026 01:16:39 +0330
X-Gm-Features: AQt7F2qMoi56gSvYyITmgBSAIsgANYbxOWU4X9u9jh7cwQNo5oHKjma4fVDQcAs
Message-ID: <CA+KdSGOW0+V9KTA6CebvJ5dSqBxCV5XFAJshJByQ36=GWX6yiQ@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:39=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Mahdi Faramarzpour wrote:
> > On Tue, Jan 6, 2026 at 10:52=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Mahdi Faramarzpour wrote:
> > > > On Tue, Jan 6, 2026 at 5:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.=
org> wrote:
> > > > >
> > > > > On Mon,  5 Jan 2026 15:17:32 +0330 Mahdi Faramarzpour wrote:
> > > > > > This commit adds SNMP drop count increment for the packets in
> > > > > > per NUMA queues which were introduced in commit b650bf0977d3
> > > > > > ("udp: remove busylock and add per NUMA queues").
> > >
> > > Can you give some rationale why the existing counters are insufficien=
t
> > > and why you chose to change then number of counters you suggest
> > > between revisions of your patch?
> > >
> > The difference between revisions is due to me realizing that the only e=
rror the
> > udp_rmem_schedule returns is ENOBUFS, which is mapped to UDP_MIB_MEMERR=
ORS
> > (refer to function __udp_queue_rcv_skb), and thus UDP_MIB_RCVBUFERRORS
> > need not increase.
>
> I see. Please make such a note in the revision changelog. See also
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#cha=
nges-requested
>
Ok.

> > > This code adds some cost to the hot path. The blamed commit added
> > > drop counters, most likely weighing the value of counters against
> > > their cost. I don't immediately see reason to revisit that.
> > >
> > AFAIU the drop_counter is per socket, while the counters added in this
> > patch correspond
> > to /proc/net/{snmp,snmp6} pseudofiles. This patch implements the todo
> > comment added in
> > the blamed commit.
>
> Ah indeed.
>
> The entire logic can be inside the unlikely(to_drop) branch right?
> No need to initialize the counters in the hot path, or do the
> skb->protocol earlier?
>
Right.

> The previous busylock approach could also drop packets at this stage
> (goto uncharge_drop), and the skb is also dropped if exceeding rcvbuf.
> Neither of those conditions update SNMP stats. I'd like to understand
> what makes this case different.
>
The difference comes from the intermediate udp_prod_queue which contains
packets from calls to __udp_enqueue_schedule_skb that reached this branch:

    if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
        return 0;

these packets might be dropped in batch later by the call that reaches the
unlikely(to_drop) branch, and thus SNMP stats must increase. Note that such
packets are only dropped due to the ENOBUFS returned from udp_rmem_schedule=
.

> > > > >
> > > > > You must not submit more than one version of a patch within a 24h
> > > > > period.
> > > > Hi Jakub and sorry for the noise, didn't know that. Is there any wa=
y to check
> > > > my patch against all patchwork checks ,specially the AI-reviewer
> > > > before submitting it?
> > >
> > > See https://www.kernel.org/doc/html/latest/process/maintainer-netdev.=
html
> > >
> > thanks.
>
>

