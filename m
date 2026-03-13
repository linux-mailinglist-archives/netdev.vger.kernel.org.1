Return-Path: <netdev+bounces-267469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHT6NPMgtGnahgAAu9opvQ
	(envelope-from <netdev+bounces-267469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:36:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9791285191
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 15:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64D463112C76
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096C038D019;
	Fri, 13 Mar 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="QJQ945mM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3F334C0D
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410801; cv=pass; b=GG5pEgd88LtY0fMxGMWOhhO20dJeWA9PlGu5P7y+EoPq4O1ieFeiu6D3TcAHKrUErq1b3D18Tr1/tDHKI9OBBIThdzBRinYDt3f/gaw9xozs7UuFdzCz84JXTTZP6c/8Jr2pApeqLSmooismocA3IRU5Hc04XjlA2jhGsRxkHEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410801; c=relaxed/simple;
	bh=0i6RDod2fox+yuB4+Ur+sx2XCfZIlpbkAPl+B0njmdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2/KmDOHyc+TCXCeG/G60NqRcK88ZLsLI7njAyQQBn9SuEspboODEifkGswstgm1ejzH2oina/BwRKlSQeTcNMgjLMUWI5OVDDBRxMP5LSdLnbNtdP4ciPAWh2uLSw/JUysZS2G1IjR/8Ep2qY4cbgPZ5s3kXmSMxX2kY9uAsvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=QJQ945mM; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso3158145a12.1
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773410798; cv=none;
        d=google.com; s=arc-20240605;
        b=PM1YdqVVonmTgcf/kJI/sPIP2TbE4Q8BRNH9reu2fq0NxfdSoF9kVU3Mm97e+B0UeF
         2O40r4T4n/Ssdo6+cpinMJD3kETut3edNVsYtPHfVTVJsBqK+e3pVBiFbSM6kWzHfcDM
         OPZomE9HaQkARpq8beY30d8QxV+l4aHK9y9ZlupuZjuh4+TPXXoH3y1ljbfkDZiy9f5P
         Z96YxMQf+d07BA+wqJ56SxmcGMfSWS/mw3I9d2l0A3DyhVnQ/BthqNOPW3Ha1aZZDeWs
         fvXWBC1Rm0nRhU28Q1V8vTyXj37e17Wx+Ln+h2xhu9s+x565Dtd1r+53gtZuYIdrmN8U
         Gkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0i6RDod2fox+yuB4+Ur+sx2XCfZIlpbkAPl+B0njmdU=;
        fh=hr4X8tK7fkBsDOxVE3NJtR0P9F9OtovUiOqu7Tvu0GM=;
        b=fuKbtoN0BMszuiDx33EGcY7y4US5F8vPROn4Wo4ksP2Qci87yMGn6DQ5FkENVGbs04
         6PNWjdDMefmCq1oy2/n933nnTw+Mo5rRKPDtfAqH8D1HRP1eXe6TTliouW5/MYjOsSWb
         sL84LJAes4Kr3s2zEg+YVLnLmG3BRltFsmbJEPbIwnmBJGykEmidrHE631UB1ZaSrTw1
         eL/vzEQSQuN9pCuAKZxtSqOnV2WDfggxCas+Qa9UC73QuYy2Bq+rIipMjTG4Qd+ckzhF
         y32b4KWjm1o6yeYF0el11MveGTC4/KZ1omkd+ErKn4mbctRJyAeDQ/9aA/Q5Uo/eYHOm
         3jTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773410798; x=1774015598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i6RDod2fox+yuB4+Ur+sx2XCfZIlpbkAPl+B0njmdU=;
        b=QJQ945mM43WRkFZXDx/TswogHMQ4DYiOGkM0kBfyVk+teCXo8yy8yKJCHw5Z+9Bpu4
         pOKleym/FpAdV3+qkjL9PNG81ktrsJM5KUCXaPdBu80/3TiIppwpyUTquADLb+0qCJxU
         l4Jb16gb9wdpS+acwELwd2gOSOUabpMTcN93id9WQ2N8Q6UljMhiURQDOU0LFY/zPvs8
         Yzr/5YkL3LfnglgfFWkk2rfpJ4qazPuEwdOm5EpDm3eksOemelxBgHYlqR0VZy8XReQ+
         G19L8b4v8biCaKf32zca2S4wD8gCnTCCxcjSZ/YHheee5Mk0i/L6lIc78Qqm79UMtNVR
         edjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773410798; x=1774015598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0i6RDod2fox+yuB4+Ur+sx2XCfZIlpbkAPl+B0njmdU=;
        b=LB7ONorz7Gyfr5sh4OR52vdnsy1m9mf/CQRB3De28rXY61E9fJAt3HbmrRkPbqHu8e
         xX3KPNpaILyZtRWLz01Lqb4zvSOXC4+GgxzB4K4jXoRCrdypctSzXSe43B4p7+n+UJKo
         98TG8NkqHElPzOw1u27BL1KwJcsOV20FwSKbauBYU6yJMkdXYIxXOnuJDBdojAXEMqIS
         kgjRGB0DdeBn+pBaIDKb+Js3N58JpGxcE+lTk9KXZ/qAAh+C5JZ5ttSdZnPzruBjPiVR
         FNMV8Kj/we82gQZpB9yhHKqjHf7YlJhvWsvX7n6jPFD/INweiaOyWzYjFGEgogFcOHdJ
         jsrA==
X-Forwarded-Encrypted: i=1; AJvYcCVbVOzgghQRLnTdl8uiaa0Ah7xZFcI+Y9fcEqbGCFBvtS1E+zbV1aeQfGl/p5Iy3cz1cHy4V+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Sr4QImjcdPrq7iHERj7OE2u1WAilt3ipgrd9TXtP20ltOxXh
	1/He4uO/vs/BcBIl3HrugaoKpvdKVziOHFbx17CETdaZltIizMSgd+xohtxTCrlzOp+SV73/vE9
	MCbWmbwfS//i7I8taUBPHkrCLxFXNcuVZ25+TTXtrzA==
X-Gm-Gg: ATEYQzzL+hZwA4u3yqCnX3tI3rK/oW+p+Ss6Gs3cXoBWz7oVQW+hESh4u79yhN4Cdvn
	Sb6LObPHpZFCjKzZ8QG63fr1ikqcsYB3BVHXNJqNyL79Gm5y/nNxAy6IlLLiAp+PfLKyW4XVsYZ
	o8lzLqm/6+QoJpp8Ziief6joA0lXvTQh9WBBwIqL9f5X2NiOne6VyUm5xRcZLdxajKn3QR/veE8
	K3swZB0uc2bcQy85/fjwlh//divEUouj1d9uYIO8GQDtiWDBRfYOtFmvWF8Md4bktd/TEa7rxNQ
	+GTeV8Y0gBDtimxt8lgx+O3JcfEC5dydBCQ45jyqlg==
X-Received: by 2002:a05:6402:3646:b0:663:9739:6279 with SMTP id
 4fb4d7f45d1cf-663baab8397mr1482051a12.10.1773410798200; Fri, 13 Mar 2026
 07:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311152845.278354-1-justin.iurman@6wind.com>
 <20260313030220.af70f3b5f2c5d2cb7b4a840e@uniroma2.it> <CAOY2Bqz8_8iT2Auw=sWob0-XUQg-sPmdAFvzRLg+KszrU6LMqA@mail.gmail.com>
 <43e16e45-5fb1-4413-bbd1-4752bbcdec7d@6wind.com> <CAOY2Bqx6jjBc5FCoRg+64v2L17bBsaAE8sy7P4JCwVXc+1n7_Q@mail.gmail.com>
 <3d9d384f-d001-4293-b7d5-7a88596ffc1d@6wind.com>
In-Reply-To: <3d9d384f-d001-4293-b7d5-7a88596ffc1d@6wind.com>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Fri, 13 Mar 2026 14:06:26 +0000
X-Gm-Features: AaiRm50gtxvTcXaWwNHVbxEndfl29k3xpokRxbzGsr5r1noNqeMeFLl8iUKVksE
Message-ID: <CAOY2BqwgYYibttTCc15a2SD=4RHMj43F47Ev20_u-a-siPzuOg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] seg6: add per-route tunnel source address
To: nicolas.dichtel@6wind.com
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, justin.iurman@gmail.com, stefano.salsano@uniroma2.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[uniroma2.it,vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-267469-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,6wind.com:dkim,6wind.com:email,bootlin.com:url]
X-Rspamd-Queue-Id: C9791285191
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:59=E2=80=AFAM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 13/03/2026 =C3=A0 11:20, Justin Iurman a =C3=A9crit :
> > On Fri, Mar 13, 2026 at 9:47=E2=80=AFAM Nicolas Dichtel
> > <nicolas.dichtel@6wind.com> wrote:
> >>
> >> Le 13/03/2026 =C3=A0 09:44, Justin Iurman a =C3=A9crit :
> >>> On Fri, Mar 13, 2026 at 2:02=E2=80=AFAM Andrea Mayer <andrea.mayer@un=
iroma2.it> wrote:
> >>>>
> >>>> On Wed, 11 Mar 2026 16:28:45 +0100
> >>>> Justin Iurman <justin.iurman@6wind.com> wrote:
> >>
> >
> > [snip]
> >
> >>>> Whether to also reject link-local is debatable: ip6_forward() does
> >>>> drop it, but is there a legitimate use case where a link-local tunne=
l
> >>>> source would actually be needed?!
> >>>> I'd argue we should reject link-local addresses as well.
> >>>> For instance, using them as a tunnel source violates scope boundarie=
s and
> >>>> breaks ICMPv6 error reporting.
> >>>
> >>> IMHO, I also think we could reasonably forbid LLs.
> >>
> >> Why rejecting LL? It's legal to use LL as a source address of a tunnel=
 (and
> >> forwarding packets in this tunnel). Is this forbidden with srv6?
> >
> > Well, this is indeed legal (at least nothing prevents it), but they're
> > not routable. So question is does it make sense at all? We're talking
> > about two nodes on the same layer-2 link as the only valid use-case
> > here. I'm not sure it makes sense, especially in the context of SRv6.
> Yes, you're probably right. I'm usually uncomfortable with a configuratio=
n being
> forbidden without any real problem/reason.

After consideration, it looks like ip6_forward() does filter LL source
addresses (see [1]), so such packets are never forwarded and there is
no violation of scope boundaries. I agree it makes little sense to
allow LL source addresses in the context of SRv6, but Nicolas has a
point too (i.e., it's not harmful, let's not restrict things
unnecessarily). I guess both ways are fine, maybe others can shim in
and share their opinions. For v3, I'll just keep it as is, we can
still make a change later.

 [1] https://elixir.bootlin.com/linux/v6.19.7/source/net/ipv6/ip6_output.c#=
L643

