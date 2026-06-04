Return-Path: <netdev+bounces-295297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rOgsDI2XIWojJgEAu9opvQ
	(envelope-from <netdev+bounces-295297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:19:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEEA6415BE
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:19:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=cdBsguUr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295297-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295297-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF0E03149977
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE63019C3;
	Thu,  4 Jun 2026 15:07:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517C2BEC34
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:07:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585648; cv=pass; b=iDCvKPCeERMmyHaM1IuwbCFFYvZHsgq+C6y4eRZ/NoNXIWXDYoM3pr8pUbBYeeXHj3LtW7rY8U4MmrsaUS7KXBmmw+VqeqdS93sN5Nu++PaPFyXuRBD1g279v7fY99LruU8je3kdqh/T++wYF88KkkURAOcqITeK+xu/Luv6+3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585648; c=relaxed/simple;
	bh=79EKVvuMv9xfHRjF2iEvgvH1DdCUixuuk9pXlI1Vz1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hckgJX9Z5sRWAC0RxeDaEqDZMpuV9DWFPLSyrpcx1/Fmm9Pj7g/19vMQ6PB4h/ZVePFK1KuNPy3lMnEHWlIEgDPKgWWqDTydIfKXMXsNo2gfrYorcpELpUQQy6r8v5xqEJkxHxTYme9+WFw/sTW5hAr7XBaEgnL+Uvync5MrEuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdBsguUr; arc=pass smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9158629a220so95577785a.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 08:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780585646; cv=none;
        d=google.com; s=arc-20240605;
        b=UHmmBeTToHGvannF83Tu+H+JcjPc1h09DmPUebJecC0iGs+oUt9yD90aW3xQbJaCsf
         ++BWqiLdcisGX583GDP9rZ035feDkNMcXytCJ9pc3yh6hStgkchIVDBuZbCCX4B5Xp2X
         jaRUM4zmXMoTO2wjBqqBzplGH+8TZQTgVsgGmqVYk7ih2HKfzx78NMZs1zJTlCdUu1u3
         2dFZJwkanMzJ/fA5+59Tkc6dcMdGVqRRB4rXPG42wfjevSiRmwdiIycVm2wk3yp/uWtX
         JrDhh88SmyDIUTTG2REJFnxPjICn4gtTHCquEihbhgqLYtr7ITuN1UGLxC20M1vGajRJ
         kBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=79EKVvuMv9xfHRjF2iEvgvH1DdCUixuuk9pXlI1Vz1U=;
        fh=oSOIMYgJoaXBl/pnOK4QMyi2D6UHsuDL3zyVvk3K55s=;
        b=OQc4U5tpGd44cti6wmYudG1OB+hUqiVvEbf6O7JKXeR0g1EgWfcTuWUbcR51L+SDzV
         M/GJYMSOCWAASTfqEmHnkQFaOB5tnSUtPcebTimCcvjjkY1fjWOVwJXV4RqLCMg1pWwM
         iVwYqPNO+5xsyooorKUnEc1+CnzaMPvfuPxdxjn44fAKtp5HgbIPnRjp/OAcrcWsxwzt
         5q9hRuJvk99x5NnhYfkbWaqDkjRB5taQdSwiPBf7LjjtwYhtpc27x+D8ivl/cMgm8IL3
         YRbergdsLvxR/Pc87YSzulbREruSnFD5KfyTv9ApxB727HnF9Z6zUt2nyJNlHmdWuewV
         td+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780585646; x=1781190446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79EKVvuMv9xfHRjF2iEvgvH1DdCUixuuk9pXlI1Vz1U=;
        b=cdBsguUrqju6Ty675cMj9jTwIw4IO9nkD00WQONZh2HHLrPUOx6OEV5ZBBsj9tdfvB
         SBbu/X7c80lMuf4RzT8JTA0N/ZHmvD7CTwWPjPOcxqzYRrsWyvDymbGBuvjVxxOvPSsn
         Xa7bFymHNKq/5e7rGuquBB1OJMENdBz3qFrmxj9/mLmkHFSOlDallMMCJj3cvyGL1u2L
         gHoCa9PEzG4fUjfOFxGZlf0ooFUjEurW8Uba0+HzBP5T1c741cr4psC3RVkDAB0+/+Ez
         DFsO3Gt3t3iRhqROs+tt720aaO4uo/R/CDEeQBkJUgzS0M3iEn9uhQE02nvZ/F5OeXeR
         uCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585646; x=1781190446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79EKVvuMv9xfHRjF2iEvgvH1DdCUixuuk9pXlI1Vz1U=;
        b=kgzRDyLN5e7LySpsE9ybgxHLQpArLj5KKz4eZboIDaK6lNNsZO6QEosgY6/sskd5pm
         ESfE9F2cvCLooT3O/C+WsX0TlSlARnHLjbISK23zaey9e4CunK5nqoAeh28rngJm0eGf
         Z1fozL3QYGGmo8VmOYz/BlzxCplNOasGIe00WpW2H4CcgKpe8pZ7tqHJHNd5oUDE3YLP
         XMMQRPoqTOFxAkxORxx5YAfZYVubHZhGXfswLyK1+N3VvyaTBoAPd1XY6WqdQIuWtkex
         c/fFiXtED20WhzI/TDOBlUq//HXtBPw8BocZt/+BUiDw5dLlbsoe2IzfcDuts62+Cf6O
         LZ7Q==
X-Gm-Message-State: AOJu0YycjdcuCloRdnjExorHpU/9fNWi94TZKJcH7/1sYVYd8nljod/N
	mKmsudFxl/L9/BzUBAtU9M0QnuqyaXaDXuq1GHXBz96KNHusFy66ajo3QjThGEw2uyh5D1E97vb
	ACWN7X4OyHy6K+Vq2antEcIpO3X8Dg7+7T3yfCbvW
X-Gm-Gg: Acq92OE6Zx3tqNQOkpokq2hpVXWoKmz8QK9leDUPAif9g2ga30PufDug48RbaCgaXJ1
	Tr4HF8wNAfWzBF2r4uyE22Dji/zDVqzQs2WqzopjCsEPnNSHbACnCPn87mq2QE/yAPjUAo7+U+Q
	gJMxBwYqkOjS1D/J4J12FrNyiQx5YdHMHUicetO3+g9EcsioZXfbx500EMDQo9o9gJL1mK7xNZa
	CMQoiFwuYpATxXiY9UGKcyK7PniHcmJa3zrb2rrb/fC49aDbwSINnDX+m4hn9n1JzyR2KgbMZLN
	NaP4uUTMv+BR/qUSH8nQtPflYChBTyAVEWkHXpnO8qjfDI7Nf2TETHRXV6u/TnZaaIx0cqfDKua
	Br7BAXYrJytjH7O+cF8f7KlOdSKwSGg==
X-Received: by 2002:a05:620a:400b:b0:914:e691:60c4 with SMTP id
 af79cd13be357-9158a697573mr1349221085a.16.1780585645550; Thu, 04 Jun 2026
 08:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604144625.3860228-1-eilaimemedsnaimel@gmail.com>
In-Reply-To: <20260604144625.3860228-1-eilaimemedsnaimel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jun 2026 08:07:14 -0700
X-Gm-Features: AVHnY4Kf4_aBrh62bj_GeahNOSe4y_Eps6_HBgTwpxAcCWlEqHcxC5QfZ5blMf8
Message-ID: <CANn89iLrnOVGnbh14OM2XPcthU+Gph8uAs4P+Q+yVZu2a6MYTg@mail.gmail.com>
Subject: Re: [PATCH net] net: add pskb_may_pull() to skb_gro_receive_list()
To: HanQuan <eilaimemedsnaimel@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	security@kernel.org, nbd@openwrt.org, MingXuan <bwnie0730@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eilaimemedsnaimel@gmail.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:security@kernel.org,m:nbd@openwrt.org,m:bwnie0730@outlook.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,openwrt.org,outlook.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,outlook.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDEEA6415BE

On Thu, Jun 4, 2026 at 7:48=E2=80=AFAM HanQuan <eilaimemedsnaimel@gmail.com=
> wrote:
>
> skb_gro_receive_list() calls skb_pull(skb, skb_gro_offset(skb)) without
> first ensuring the data is in the linear area via pskb_may_pull(). When
> the skb arrives via napi_gro_frags(), skb_headlen can be 0 (all data in
> page fragments) while skb_gro_offset is non-zero (after IP+TCP header
> parsing). The skb_pull() then decrements skb->len by skb_gro_offset
> but skb->data_len stays unchanged, hitting BUG_ON(skb->len < skb->data_le=
n)
> in __skb_pull().
>
> The UDP fraglist GRO path already contains this guard at
> udp_offload.c:749. Adding it to skb_gro_receive_list() itself provides
> centralized protection for all callers (TCP, UDP, and any future
> protocols), and ensures the precondition of skb_pull() is satisfied
> before it is called.
>
> On pskb_may_pull() failure, set NAPI_GRO_CB(skb)->flush =3D 1 so the
> skb is not held as a new GRO head and is instead delivered through the
> normal receive path, matching the UDP handling.
>
> Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
> Reported-by: HanQuan <eilaimemedsnaimel@gmail.com>
> Reported-by: MingXuan <bwnie0730@outlook.com>
> Signed-off-by: HanQuan <eilaimemedsnaimel@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Please note that you should not cc security@kernel.org on patches
sent to public lists.

