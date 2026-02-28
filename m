Return-Path: <netdev+bounces-262139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IWFAqD9omnG8gQAu9opvQ
	(envelope-from <netdev+bounces-262139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:37:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 839D91C3983
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D71483079BBA
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A4326953;
	Sat, 28 Feb 2026 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SY7lHOY2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71627CB04
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289436; cv=pass; b=dcWVFgEmrtbrsjqY6jztcs6DaqDAxNjwKPG1yhSXntkMB83494qRxK8+LjskyKMGRDk5QMPqko2yCyfF3AA8qTlAz1KtAW14h2scspfN96UgnSVdxnBYIqIUbmjXedY0grkSwKpSdvtX18DTDd1NUN1OTfTIRdQmJGXzxMli4/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289436; c=relaxed/simple;
	bh=0+1HlrNZs3+OCloAQAcsMVsttjnyIFInaRjUYNc+qtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uerntLBqj5rRJDa84ZrKsunEKQSJwmuQUyE9JbZL7cNpNIaqTEd6Wkz1/+CBftBfmMza4EWJg1pERnpgwy5i4jQztHXC61xiWDpk4RtmVc6iNXext+PmqGJOYYwigCceqLDAi/qpa+W38Fc1w4Oy/4oacujaupkL14cMvOnduYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SY7lHOY2; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c70b5594f4so319626685a.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772289435; cv=none;
        d=google.com; s=arc-20240605;
        b=YyNcYtIadXCl4exOqH2BbRSc4Y2/0x+k7WKmk4FX5IwjecnaXYzfww0LlkusaRtGZy
         O7D0cGnV+uA8YV9hedHuTwP8PDLQRqaX0ibjLC9+6mgCx+8Ma2c9Hi6T9JQG3BsILrfc
         d21a7tARKuPt6pS42nCMaBT+uyb86LBmrAV5ZsWghT5KYh+bby0HidWFAYkbropMsleD
         j8Oe5NKYaLx43sKsgC3MzFj9waAJADp6b0d8GJNCBAVdZhERJ2sSVnuJW+O2ABiAwWBW
         /rXM2t0tZKX9+Bgo4HvwWrIozGasA5RlZr1muuSJOWyVFr/VhUNj3vW+F7ed4A1wxjmi
         JycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0+1HlrNZs3+OCloAQAcsMVsttjnyIFInaRjUYNc+qtI=;
        fh=tRCQpRjJCqjVmOAtnmuYyQzXogKM+G1ZiSXF70ExdqQ=;
        b=GnryN25WKS/+e/j/O4x2nHKcOdhQw5a90X4I+Ye2HJVDtaWYco7UiZhI8brTkAz9Tw
         GrRtF83XwW1MjQwRX3bWRZ3VbAgF5KQVs9lDrbD6z4sVVIVwA4+4VDKbstzmlbyW3CUW
         coKyi83W8xI3CJzbuEZOlwZJuMmfIAvoOJCF6r44wHq2ymY+XbyXecamOHpFxeLsJLBY
         vCluBFu5PpZUZ3Kdlpg8rTthljUX3Vdb2eCn95xyaZkbPwL2FoQWKA+rZHbbzlO82VAN
         WfcHTNtR6FEk29V0zD0Yia2blCKEBBlt7SHfzyXyCIdzOz8qrKShPxcFjEQ/a9Iz968g
         e+ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772289435; x=1772894235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+1HlrNZs3+OCloAQAcsMVsttjnyIFInaRjUYNc+qtI=;
        b=SY7lHOY2WS/QhwdtFXr8tS+GJ+zkR5jwhGGSMT9/bTOz+58MdkQchjXaabU0gbkGMw
         9lH6ZEfjMoMsivwrahQxddkZ6oAtWDUMt67X1jbWRnJSh7qxHt9kfxtsnrUTuuJJfqOm
         oNGlHwwJlVc4zVj3FpV270mZPn8sl7ymFc+F2e9DHqXI8a58ohYPGXD8FVOgYEoNQUZ3
         S76cu9DSYZxVIjSvqao1c+Y1CFjlMAzL1oZk+K/hll3zet+eS1BUNntkw3h54NpseXi7
         N86d19XbnSUl8IwcoDw/wV8dcZ6+0J7a+f0DUAgrS/0oKMAwti8Lgg+MkXFjjjS3PZu0
         vXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772289435; x=1772894235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+1HlrNZs3+OCloAQAcsMVsttjnyIFInaRjUYNc+qtI=;
        b=kZ7/z+EgCjoX1QegN3DVzxZT1nYtWtTrgUqiXQM/XDsXu+y0p01Np0IsGsQJSr1fQ1
         Xi89AdjxX0tSHquuxE9Uvbdal2sTmrz5f2kM9GXCxjAkfAn4XuWly6KoL2r9XdFErnPh
         /kFe0MsXAjXNu+aqWbExAICBiE2p3C7nmFYFcJXc9mX+cXiDW/70otoqYQlbTBJLoO/8
         zmyfYaIH48TvOfZwLYTy7JCvHgY0H6EHhaHcqabv2i7dI6HpK3BIA6pkQTTWkS+x8K6y
         cjf3V8/jFHWqEImqjPvYq8hBBcm86ghf/dUNqsi23kws5r2nnufbvjb43QQnjHP9YPGB
         +B/A==
X-Forwarded-Encrypted: i=1; AJvYcCVkxW/iuTmFwVWtk34qpxFWS63vopkkszRJsoncB10z4NFUNeowg7FWulQpckq9U67IXVR8UyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzueQYY4M/3P0RMnEvGx7FiqCg7E4TTQkQlN98B7kL0iMgFrFoA
	VgE9BppRKoTLsb4V7O0XHt+DN711ybuhNzHdCOMJ2/DERRkNiopxMAJlhwYEV2K0eqkN/QW4IAn
	FdBoEnd9Uo5PccrTqFeH9quQi/BWUck7KjuBSvHIT
X-Gm-Gg: ATEYQzzLaQKkoyOdChDmV1oNcm2GEpCaDLe+bcXzChP487EpFWO51qYBSgqegX1Lt7J
	jfP0T3MnhJ9d6NHhmGirWQH0KbJJSEQWfxGmb0kAO65PxSA83hripnihgqa30eni5XDplZBesQQ
	Rx85JVP/y1e1wOVH7HSV2lYQuYdeNWueelU8k21dxDpOTBHkTGN5ZTQZAs04dA6Cp3/DiRFVLeQ
	YYzBkK+WEtrPyKt7TtxVwRbCob286S8ud0ixyPtvle/WHgdYBx1UhugD/MsNkPo+Y6OA/Yvk3hc
	WMJgBucI
X-Received: by 2002:a05:620a:2a05:b0:8c9:e989:9d8c with SMTP id
 af79cd13be357-8cbbf3522a4mr1217493885a.3.1772289434204; Sat, 28 Feb 2026
 06:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227035547.3321327-1-kuniyu@google.com>
In-Reply-To: <20260227035547.3321327-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:37:03 +0100
X-Gm-Features: AaiRm50pmV8g1V46i89ExmmluIwA_tucB6S1zTbG0gpUwFRJ5b9C55oVz2RxCGU
Message-ID: <CANn89iJ6MReP=wJc1M+YZr5MZCO+A=VLyAoyXGC9eFV-TGVJRQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] udp: Unhash auto-bound connected sk from 4-tuple
 hash table when disconnected.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Philo Lu <lulie@linux.alibaba.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,redhat.com,linux.alibaba.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262139-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 839D91C3983
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:59=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Let's say we bind() an UDP socket to the wildcard address with a
> non-zero port, connect() it to an address, and disconnect it from
> the address.
>
> bind() sets SOCK_BINDPORT_LOCK on sk->sk_userlocks (but not
> SOCK_BINDADDR_LOCK), and connect() calls udp_lib_hash4() to put
> the socket into the 4-tuple hash table.
>
> Then, __udp_disconnect() calls sk->sk_prot->rehash(sk).
>
> It computes a new hash based on the wildcard address and moves
> the socket to a new slot in the 4-tuple hash table, leaving a
> garbage in the chain that no packet hits.
>
> Let's remove such a socket from 4-tuple hash table when disconnected.
>
> Note that udp_sk(sk)->udp_portaddr_hash needs to be udpated after
> udp_hash4_dec(hslot2) in udp_unhash4().
>
> Fixes: 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash for connected socket")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Moved udp_portaddr_hash update later
> v1: https://lore.kernel.org/netdev/20260225002709.156882-1-kuniyu@google.=
com/

Reviewed-by: Eric Dumazet <edumazet@google.com>

