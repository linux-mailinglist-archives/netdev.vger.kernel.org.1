Return-Path: <netdev+bounces-306369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZIChIwoGUGo9sAIAu9opvQ
	(envelope-from <netdev+bounces-306369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:35:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 269767356FD
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:35:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V1bBJ8W7;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306369-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306369-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68949304364D
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3353CF1F6;
	Thu,  9 Jul 2026 20:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C63BE165
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:34:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629259; cv=pass; b=YlhBvRITgAZVjUUomEF1MOVstDaB7H2t/tlK2kvKZPk+K9NTe3yaVxMhbc/n7erdz/GdDRsQygFxA2kD0R84S2nDafdNMu9vyQbn1XBfcBj2X0RklgS67Lm7RB8uwJhJ20H/ctGe9tQYZpVSJjefXLh0uPxFCPYb3MqkpzOe4ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629259; c=relaxed/simple;
	bh=3Itm/tg+Tm3JwuMc2zeYR8b5ySP7Uvg2IWDzrrT32NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzQSNUU5h6JAaql9aMTh3ft9xKfhlBis0Z7KHvyW/l8YXUE+Rbb4hyozQy7wdVlWb5oSART9B+8JnoIDFcKv7dvsnIUZHYuJ4rQXFP7lFJfJ+r3ibHwnRcmhWC+H4g14V4c4oAb0cNvOcIYJ0PyQ/Bg/rztNNeRqQBsyc7akfSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1bBJ8W7; arc=pass smtp.client-ip=74.125.224.49
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664d4478a64so278706d50.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783629257; cv=none;
        d=google.com; s=arc-20260327;
        b=HlN8d2ImVaBTeK8TmNnB43f7t9aA75amUgKWsnHnGdzflo1J1+K9IW7xpvBiBD9Uov
         rvZ5INr1+KilWSletIJn91P9rlm2qlVbFi57OqCAZ3HHMf3tBlGXc8d2Z+DVX5BqnhTe
         NyyGHGGUa9l2Hf42wx/r0s1M5LyNfndFAcd4Ajm+uSebmYvrLQCW56HViFbF0ctX9VP7
         Pn++UvI3Z/6/TXPTSuNQTT5TFvOSpgcgV+DvCbGnqXGbXgbG7Cx5+Bt5eOz9mqbn7kio
         JaVJ46i8qT0Z2o7ggu3lcwybSvKQXQl0xQEDy8Z45sxkvJHP86oMTvg/Gv6Q+aioejzF
         b9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Itm/tg+Tm3JwuMc2zeYR8b5ySP7Uvg2IWDzrrT32NU=;
        fh=RZINLQcS3VeIfRr0UpZ30z0O1sedcd08lkXJ9o3FSM4=;
        b=XiKiT9GN+Itd23df9IiCbA8viJfrj7LYNpdfIKE4FQ/AyylaVVItHAhxBe88cv/uWQ
         BGx3VsOL8oBy85orSqOtIpX2Qy/guCumKcdHbRRf7v2lu/niGRtn7vNBatw3UaHQQzBY
         pVMpdD6PuJIiAvjcAh/CI15KM7dqxeAm9s+x7xQFrcu1fmfQoo2GBu0t6iu5LOxoOTf7
         HqCQwtz5YGTvMidCWV7425KeD3W79cFGebttSo3/Oe3K2IigdgjUdRIl8Qnj6k0dsCSb
         HWDKyG77EFIXuKwbqoSn5250T8tw3rRluy5vPgU7N5bansv8cmwJwuh9GgkYk+cjgJWu
         xXyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783629257; x=1784234057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Itm/tg+Tm3JwuMc2zeYR8b5ySP7Uvg2IWDzrrT32NU=;
        b=V1bBJ8W71AODDbZv/Cqpt8LY0y/VvAM0dNdV+aWKP77bP3coXPj+1Dg6RvGo4VKSEd
         nTVOucViMuRp3Aw9YRk+GZLKispRMWnEqLCiji0wDZkxhxi+WHUrL+DJkcODiFuabe29
         c2UcVSL/MwkXS11SIArRiGW08nZp+JZN/rdAXNsT6pXpFVgcjZml02b7Ob+c03ndA5+K
         NXxyqA4sOhSC2RMuzBZyE5DTSCbfVgbKmdEaTOvwQiHIqgIgUsKaJ+7xLVz4yroKDkpP
         B79p5V2h1PDDfNWw/ewhOB/F92Hu2VwpDRLOcWMPLS148gJCyiXzySrzmbxzUh3qx61Z
         NZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783629257; x=1784234057;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Itm/tg+Tm3JwuMc2zeYR8b5ySP7Uvg2IWDzrrT32NU=;
        b=pIOtiI/bnpIVIhuXdoDpM8iRZgC6i6ZvKa3YGW6Ltk09ZEU09WZz5XF6PGjOZgX2RX
         CP7FMlpRN1THZhHQ15sg8uylWcMe9VO+yvZCXva4otE7WpBWZ8k6zh5f/XUu9jtWeQXR
         Pnk7sA2UlOtx4MKQVW6+EBScHw04Y8cPXLwGipphiPLUBwBKMuz0vxbGEwLIluRqpdWQ
         tcoa9HmxlbtWs04/+5mFAsHSseEQJhakleCeSvjzAngtElZP67dSNPn9XcQ4Rt/r6w41
         35GLgY8muwWvD/NVTShJgdXQlePE/YKCvN7u4zy2Vqsx9+hLJIB174SUceljnG2+9RoI
         LDqA==
X-Forwarded-Encrypted: i=1; AHgh+RpkoLjC5Yz9lILKYk8Dkkeeyc3eSw0CIEQ0eN9NjvPMo31wJ0I1UVmjz7s6OUSIA5sv669DQXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0s+uQh/Q94NZg9aQGYUy+iFMEN4HFUUHKgHO8jXuLBBj/KkcP
	uGxtBWpxwufv+DnqSpS7VS9ku3CHLIPx8+tERpRihqtXnzfpIsHGxnoJJOndCQITFrtlvk6J2PU
	un4N6RYm2KH51Lyvx1asKu6djAQ52PTGySFVzEm729fokWag=
X-Gm-Gg: AfdE7cnBXk9pIqtdJZ8eQixaSQJfkrQG9zoV+Of9E6w+Hp96ZUtqz/bnA3SceS6tsWK
	feuDPUBnwYc1FJk0z9u5QBGlVBaYFKPrZ/wwjgvaYkAwnR+w9OSFCboNYciZIRVEf0Q+nk4D7kL
	tpV5zZLe4dw4cuzEJOe3IlUITPEWAgtMjP0XcORblmQ+luRYQ27waiL2aZsiU/B5fg1d98f248e
	Tf/cz0TRsvn94i1z9LbdLQ45Z+MrOgizXgZrf0fr7pH8dk41OdtzxENLtXIpsTDNS2zZCxolyqh
	OI1kdKGH
X-Received: by 2002:a05:690e:d04:b0:667:b84f:e408 with SMTP id
 956f58d0204a3-667b84ff14dmr2662678d50.5.1783629256851; Thu, 09 Jul 2026
 13:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708205404.911832-1-anzaki@gmail.com> <ak_VoSJ7fozDdOzM@chamomile>
In-Reply-To: <ak_VoSJ7fozDdOzM@chamomile>
From: Ahmed Zaki <anzaki@gmail.com>
Date: Thu, 9 Jul 2026 14:33:40 -0600
X-Gm-Features: AVVi8Cdgg5kTDMa4iLOD29tsjNfKzbl4dqR0_vZdo8RWLyjTUxjqsao25hm6USY
Message-ID: <CANczwAHgj+iNVVmZtUkSUGxsKrgxk=9VN=xAL-+6G0y47fZXkw@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: flowtable: tear down HW offloaded flows on
 FIB route changes
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de, kuba@kernel.org, 
	edumazet@google.com, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, Ahmed Zaki <anzaki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:anzaki@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306369-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[anzaki@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anzaki@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,netfilter.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 269767356FD

On Thu, Jul 9, 2026 at 11:08=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> On Wed, Jul 08, 2026 at 02:54:04PM -0600, Ahmed Zaki wrote:
> > Hardware-offloaded flows bypass the CPU and, unlike the software
> > datapath, dst_check() does not invalidate them when a route changes.
> > For ephemeral flows, this is usually not a problem as the flow expire o=
n
> > its own and the driver clears the entry in the HW. However, for persist=
ent
> > flows forwarded through the device, the HW is never informed that the
> > route has expired.
> >
> > For tables marked with NF_FLOWTABLE_HW_OFFLOAD, listen to the per-net F=
IB
> > notifier chain and tear down the affected flows so they are re-evaluate=
d by
> > the SW forwarding path.
> >
> > A lockless list is used to reduce the work items overhead in case of a
> > route change storm allowing many FIB events to be processed by one work
> > item.
>
> This walks the hashtable anyway in case of fib event, maybe simply
> walk over the hashtable and call dst_check() to check if the cached
> dst is still current.

Good idea. I will replace the tuple matches and the lockless list with a
dst_check in the hashtable iter func: nf_flow_offload_fib_cb().

> > Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload suppor=
t")
>
> No, this is an enhancement, not a fix. This must be targeted to nf-next.
>

Will tag v2 to nf-next.

Thanks.
Ahmed

