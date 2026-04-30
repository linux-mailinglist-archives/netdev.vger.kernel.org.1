Return-Path: <netdev+bounces-282663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIx1NYby8mnNvwEAu9opvQ
	(envelope-from <netdev+bounces-282663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:11:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF549DE64
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40F0F302BDC3
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97506369224;
	Thu, 30 Apr 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fp2hJvGG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5F9443
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529406; cv=pass; b=LwKlwtLAtuk+lPUGUCSBD2yPY8rOIxvQvK+dvhF/nqsx0RSG/Bqev5cQZiaaFt6Lagwv2IgNQqjLB+UKTuQ1SiOAUXCbsT77vYnL5FgndxSw4sWazyhrEB6eig98lMw8dc8vFYXiRqFANrqE+aSv01PB2XARZSjXLTWmJTuMIqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529406; c=relaxed/simple;
	bh=ytDUIabneQahI8io99oXzhArtwd20FIEQzF2zUEpDdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHYnyW5lRkWzw8TFwTuFjIotjB0emw+XJS9QUFMVL5nNUbhWxexV/gIoLG2ZVa+6xXWeBUdFdhGdpwluyj+V1YO+fEBnMUqELT4NFbGH2uAaYwwIXv3NM+0qqvUKn+De0/N9hUpJInrub562fbOr5vt0iUZHdPt+0+dP2Pbv7Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fp2hJvGG; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5102582e237so3914751cf.2
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777529404; cv=none;
        d=google.com; s=arc-20240605;
        b=GqUWj5cHhNs5ENd3L2W8sXXVfgShfwWbX2/XBkDWuuUhWM0F2ZL4lhF9z+4tKTiAae
         ngzcoj2RH7z9wq0yy4XhIG6sadCuW3Uv9XegjyPJQNoq9UUKYqtG37eQTUWR0ZIIa9ii
         MxWa6BqgwsJ88ETrgkAmucgCvZfyuEMg1R6qXli47bdj635vz89dds/gCsDFGA5ijoxR
         VmCnvAn96/mtW32R8AoCWEc8tXv/xtHv5ehlSETKY3MFi6EDQ7bH3IzlZymavE7OFn7U
         FiGxbR/qyhZj+jcsx5b7vjKdUMxTAC65dsO5qhm0umgrctrHXAHUOzxDJfOQT7FQx4lE
         JJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ytDUIabneQahI8io99oXzhArtwd20FIEQzF2zUEpDdg=;
        fh=7HHGKnHrwBwFPHkUoFmFDeTKvjfDxNMANWplk9U9wgg=;
        b=ZDCUyS8fU0sW5QuJuXQAPYj7AnqWQJorko6EO2pMyIs0I/ZbdiHYE8+h71v0StjHmf
         VQ9D+F4M7ifptqot5ptL7DkDxi2dutpYX97WlG9jJGbuYqPxYxrwYRBBb0IVVQNFajfl
         JnUJgkr9t0qYqWUWmeLGLb2XkLhFV7HsH2GplADQXIfwtimZFfzZ6qz8Q+gkHqRUsC1v
         bh1I4BPfZ4xCDBPkbf1tAgC8RUSZFZCR/7DmlW6fcFwsv5ZOF6vFHHtkziIxPUn2N6UI
         B1G791m9uQBR0nTVjprYenylKgxCJfbpb9gCevU2T0rxSJ0R5+lZ1Wfs3/c8r4O8J89S
         IqtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777529404; x=1778134204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytDUIabneQahI8io99oXzhArtwd20FIEQzF2zUEpDdg=;
        b=Fp2hJvGGWU1tvePUjwQDgK1DG0wiUxI1ULLsVE/7akSS0KY5e1mvxRD1CVgh4Rl1Wm
         yXoRNUiOj3xtHEesinycn34Vfvz4aXFfSTBhOUfo7jcuD2N5NUMBvaK6xfPe8Bp2p5IG
         IH96NMB2a9XIPlDFyuyu4wanUTWwJzMjvrsb/oiyhJ/f7+zm/OaxL7ylXK7Lw4UZZ/CG
         b9Gum2WLUsJ0ZwL5WvdgEOyg4MiYD1Kgk6ZEQtMkZSIDGqq+JwMUoGuhh+7gOVwsy/0c
         Mxsmdm7UgS6Jn2fubm/esOLQCModO/Mi/gqy0KEzfnL6/fwr1TztkhKn5TUubXwKQ3l1
         bvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777529404; x=1778134204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ytDUIabneQahI8io99oXzhArtwd20FIEQzF2zUEpDdg=;
        b=RRrgBh1ofYW3UMr9bvAYCFbAnDZ/c7MEnj+2czdRJnv0guoK3/NlcjIUhj6W8JRsNN
         +AXM5WjGO9WO2luEW3Wxv8qYJboaZKW4OXcPrKXRA6wY1v3qZbr52eYAuE2U9ja6gLaK
         NacX5hNnSWSpv6PY6JwN0Ss2dZBM8jkA7p1QKY5pueZcG1U2J2RTB7+m/7KHHGmlaYGM
         qAaVBNrN+ovB9868KRUCaiwW02XKoFwODBNLYF8Tmd5GTDPrxGOS6SzjBwubTghxo61P
         pkBM0VwYZ716iRZ5v1WyiPcAQot2ssRF0z442d2M3UUWKuisB+dS3aBw3SNPjs4i0C/q
         vfNw==
X-Forwarded-Encrypted: i=1; AFNElJ8lKQPtBYSsMrXD5e5C0Upl/T9d124fzytBzm6852ZHkedJrrM5pay+fr9y+pe9DX2EsAwgI24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3dP1BWfiSL1Xod0GT4f0HQIfnMTbfF3miJzxE0WaOSQIn4o1
	ziUE9GeXNNir8Ars3oz4nng5gM3eBkrkmxG+nAuxh/jSgCRYKSnF5oKn4u4EbbQSq7d9UIy+yE9
	MWObpwsGgPjDNUmOdFHBAkZFJRYubY6jiM1hK/zbH
X-Gm-Gg: AeBDietNBWbmS2nAZcYLrsvECH/6zDPDMls1wtNhQW/RJQb+NUCoMGQTfsJcyYgepI1
	3M7yo4Dzq7LwInDIG3X75/ZlCuM3XibAVB8LnE1TL42cmUKr+GkCyfZXKLWhfIVUCDOzSFWRPJ3
	Kj5twfg0LOQ2bL8uEYCBBqPjoUG8p2Vyya0Ve1N8s79sHA+xAgr/eg/jbxEFsCleDYQ+X1Kbizr
	cwP4bNDKX4BZQL3dD7EVhHDq9KZ4J7K82IBAm6bX2Gp0YmP+JCEqLIQ8cDxhFvyz3kCaHurT4wj
	0l8cTK/3f05f0V+XXrPflzZoKv9LYvg4iUvNBAADyb1A8VWLj3PT5asSkSeZk4T42xgZsSBrGu8
	a2Odc4TI=
X-Received: by 2002:ac8:5d45:0:b0:509:1579:7c38 with SMTP id
 d75a77b69052e-5102ad9aef3mr20837821cf.35.1777529403614; Wed, 29 Apr 2026
 23:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429091632.26509-1-kohei@enjuk.jp> <20260429091632.26509-4-kohei@enjuk.jp>
 <willemdebruijn.kernel.2345608a210cc@gmail.com> <afLftTCDDzw4bE0P@x1>
In-Reply-To: <afLftTCDDzw4bE0P@x1>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 23:09:48 -0700
X-Gm-Features: AVHnY4KMmAo0hot1hQSWgaaX0pIS3XKxSkd02EzrELf-HuQZhnRVwYSSnkvIgNw
Message-ID: <CANn89i+0iK-Ci+Gokq5VW+SCvQLyA4vjairsf422P6hjZErquw@mail.gmail.com>
Subject: Re: [PATCH net v1 3/3] tcp: use skb_get_hwtstamp() for hardware timestamps
To: Kohei Enju <kohei@enjuk.jp>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Gerhard Engleder <gerhard@engleder-embedded.com>, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 39AF549DE64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282663-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,engleder-embedded.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:email]

On Wed, Apr 29, 2026 at 10:07=E2=80=AFPM Kohei Enju <kohei@enjuk.jp> wrote:
>
> On 04/29 17:09, Willem de Bruijn wrote:
> > Kohei Enju wrote:
> > > Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination=
"),
> > > skb_shared_hwtstamps may contain netdev_data instead of hwtstamp. TCP
> > > receive timestamping can then interpret the stored value as a ktime_t
> > > and report bogus hardware timestamps to userspace.
> > >
> > > Use skb_get_hwtstamp() instead of reading hwtstamp directly, so TCP
> > > sockets follow the same hardware timestamp resolution path as the soc=
ket
> > > layer. When coalescing SKBs, resolve late timestamps before copying t=
hem
> > > to the merged skb.
> >
> > Why? Does this preclude supporting SOF_TIMESTAMPING_BIND_PHC for such
> > sockets at a later time?
>
> You're right. If we want to keep the door open for
> SOF_TIMESTAMPING_BIND_PHC on coalesced skbs, resolving the timestamp at
> coalescing time is the wrong approach.
>
> >
> > It is just as easy to coalesce the cookie as the htwtstamp.
> >
> > That also avoids the need to mask out SKBTX_HW_TSTAMP_NETDEV.
>
> Indeed. We should also carry the matching @napi_id, since
> skb_get_hwtstamp() uses it for late resolution.
>
> I'll update this in v2.

Do you plan adding a selftest ?

I am confused by your series, a test would really help clarify the
issue at hand.

