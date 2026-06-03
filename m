Return-Path: <netdev+bounces-294594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vmdKAInPH2rXqAAAu9opvQ
	(envelope-from <netdev+bounces-294594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:54:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF64634D8B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:54:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IgmjgGX0;
	dkim=pass header.d=redhat.com header.s=google header.b=GxU70Utq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294594-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294594-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03B353016006
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DF38B7B1;
	Wed,  3 Jun 2026 06:53:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587B320CBE
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:53:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469637; cv=pass; b=HrwnByk/FzElwZD0epuSfbcZeeg/pO75Txjvdn9JdX9OUwRZDXz7U7WCkxODn0pTSjsZNUy2FEsbe8dI3KTcoRmRKgWNOMzo4IUuNsZB0xh6MRfRk0+4AlUeu/TzMklXxfBtdQVn1ffBYHa03KLLEh8A5e1BgfGxKxe8jDamwPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469637; c=relaxed/simple;
	bh=YtoExcp1vKCmmemHMTzqZLSo4dfGSjDVY5YroZRwHyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qav8Ua6cg5l/iO384zOEWZObb+z9bh3sje5RkjniFeI9OFZtfi2tqZcjkv0VilaJBQZE+q9wUUfBq8s6GxdBUte6Lww0TZywlXKnKQPxMb5Kd86Nfb6MSh+qM7+yasubjp6lwi6yo8qD5Ll1A6qUW22A/3EI/ZP0sd/QM4q2nqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IgmjgGX0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxU70Utq; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780469634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtoExcp1vKCmmemHMTzqZLSo4dfGSjDVY5YroZRwHyE=;
	b=IgmjgGX0dMY34bwtcUNpupqVKMidP/kH1scnyAx+pPeFja82LvjFopqO7rJuhtl3kAWX1q
	mEEC1ZJC090qzc/OgBYyl3LKZ8DgA2CqoTZvfmUajo0aCSDm+C1LLshAiEmyfSxrAoZ0TL
	/urmZrKO3E5NoXrPL2J4Z8J77Wsdjtw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-ZG4g1D5iMASv1B_VEeyXuw-1; Wed, 03 Jun 2026 02:53:53 -0400
X-MC-Unique: ZG4g1D5iMASv1B_VEeyXuw-1
X-Mimecast-MFC-AGG-ID: ZG4g1D5iMASv1B_VEeyXuw_1780469632
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3967fa2efe3so16813321fa.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780469632; cv=none;
        d=google.com; s=arc-20240605;
        b=KKBcDQSNQmbwcEeZYKK/7i0Ah316XsZYq4x85oBj8CGPJ3GE5SEDxfk74Mu700nwhc
         1A2sqnligBJ/NWtzB7ynB4UNV1iKJUQ/5zYKuHrXa6CUA95VrPomtD84hdH7SMCqAreD
         s9uKfO8c3eHNySAOvGKio5sAihmKaBruw9gqSeF6JvuC3eyUS/89q6YzFT1VQtrsunj4
         xMo4EaC8TNAQV8RyenW+NKu+KcQjj7qRcfvPSXNUhUiTUalE7ltVMG12meUdmrwXr1wL
         +3mynnOVV+uF1nSD1kgQqRxBrnE22sl3YRHDDDoftOK7y8mvVPtzYScK/KV8Nf8KMXC/
         wxHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YtoExcp1vKCmmemHMTzqZLSo4dfGSjDVY5YroZRwHyE=;
        fh=Hkl8LAsb6DQtjT6I3THLXQfvOvku3qlvjwvDfM5cF4c=;
        b=DuYxPcb58Xg2d4ZLlSGDvrzlnHq7MMonKlrPUr6kpaeFj+zWPawKm0uWCxDtg0k7Lf
         fn2NCXqjpCrkwfZSLiYlifvOV4Hg2Rl6A7gtH8EvU3cx3Xd2ADuXFnWlY7MhTJdKWMLk
         DWBGfgKhQ5ccxfoe90FbPd53H2B0X819oj9bq1ZT0K1YN1tRL+jSOQxYHCVkDgrC5len
         5DHiNhS3DFs4Z62kC6X85lQufaSY29Q0ZxSb6GhnoZoa7PyJqnxoZnWX/1CEWiGGrcY6
         u76XAE9895gzNwE7zSVe9L57RMbGYHecrzQ+XcxkYtU592MorF9V0FBAAp/CeGDjVlUD
         mtsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780469632; x=1781074432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtoExcp1vKCmmemHMTzqZLSo4dfGSjDVY5YroZRwHyE=;
        b=GxU70Utq+gyU3kvFzMuJqoQkILxJ9pPwuGlFlOSLn/r3+2U/haI/8hD5nxbEpKot0m
         8TCAlcIOzgH3GaBHmJskiOe0Uk53HtXmvFozouK4mrYe28uAvHCWnF29SY2PTG4EdRkw
         /WPtIAcq6jx4NNcflgAYI0NhjyFLAl9YjCjLAbP5ib6eqxmk/jx4u0Vsk5dXwtFa9hRg
         UqvC2zkUBwwC9k4MK0vH59YSIOLS5SKN2s9l167EmtzUsr3kAfV+38ZdpYnppIjYkCII
         IUmqqj1xV/OT03xC76QMzX3zQdi2lX3lh6Cpxb0N3WB7M25Hc3CACXJD3r8JGdNlMZTn
         soQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780469632; x=1781074432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YtoExcp1vKCmmemHMTzqZLSo4dfGSjDVY5YroZRwHyE=;
        b=eYqkDluLfiT9rhpzR7a1X0S1gT8kp8mPr4Ysi5KZg4HAI3h9bBidgMJ3z5JtLLccs3
         1uNnt9rPL8/T5VI6F8xMx0jBZa+d5YHxJkznKO8lLWa29MXgHqWrHZWxBs/H+e/vj+rp
         Qiz6Vd+xiYPdVC4E4hF+D2DKTlno0p+gsSTBjCnMLrFFi3N3J6MHbBKgrJnh2tVLUXwH
         LesF26CT2Kh1lvVZcG2B+znZQkXSKhs04Y+m0K5Ya2gLlHJxBfT7K01D+ekgIN59sJa7
         PhWzosfp6Xp81DsCJXfWCx23PoNBI1Q2NMYTax4zqSvXKfPkpRpWhDnWAkHEKTqff3QL
         EURA==
X-Forwarded-Encrypted: i=1; AFNElJ9sQVDXxH7O+HlCVO0SAn+5+jYBhQ972LQCRvlwlSUr6YdW0VSC3DXShPZJmAFJPUDlJfeiuTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKeXfY0mcvjlMER6ql58ZZs12lvazNxiB2PsgrcUoFPyqJF+tl
	ZZJceqYibkxsmHSfDcMBIUdEkxR2e17HyLnKV6VODFZRoC2ha9lWFCtipTZUVQPROsdqMQKqnWz
	7jo/kgxesEpSjKRVyVBgAsQ3SDou/frTtHVuKhCEQtJQ4NGWgx8Rlyaj/vphQlaBmphv2GOg3Hx
	2fDDqy6HsfS3EkQV+Qhrg18yyWYNMOm0ER
X-Gm-Gg: Acq92OESYef6dewJGHAkUvA0y5jV0uHoiEORJTIM6iyTyD7Ymkkz0W+pRHliggkewCb
	Bz1SV18GqLjl3Jf9cVuvgQtaFibQWW5APKMpwaaOJn90Y9c+6p6WAvvQepuE6+hjcNlJyDLm8mU
	Td9T2QjmGezrGnr/skSbVAsG4Xk82UTprZayjYO3QTHBigYhP+8sx1W3gCqJIfibDPaKu6HouVe
	Atu3Qq+oqvWzra8
X-Received: by 2002:a05:651c:1473:b0:394:184:f7a7 with SMTP id 38308e7fff4ca-396af0640ddmr6172251fa.6.1780469632097;
        Tue, 02 Jun 2026 23:53:52 -0700 (PDT)
X-Received: by 2002:a05:651c:1473:b0:394:184:f7a7 with SMTP id
 38308e7fff4ca-396af0640ddmr6172051fa.6.1780469631660; Tue, 02 Jun 2026
 23:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529112357.5079-1-fmancera@suse.de> <20260529134045.56330243@elisabeth>
 <5079261a-79e5-421b-bf6a-a511acaaeca4@kernel.org> <20260601153525.546746a8@elisabeth>
 <CACT4oueDv=KRZmJw=1N58EN7eoFz5AqbBBMP8FE4=+rQ99oFEg@mail.gmail.com> <8e9cbf0a-caff-4575-afb7-fe852df8a51a@kernel.org>
In-Reply-To: <8e9cbf0a-caff-4575-afb7-fe852df8a51a@kernel.org>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Wed, 3 Jun 2026 08:53:40 +0200
X-Gm-Features: AVHnY4Izv8ZOfaMVFpzu_XMyUekVJzqWDGlejEBqBpAhhiBHZ-XfProno9wNXz0
Message-ID: <CACT4oueJ3GsVvnWcZHgYVL-fCjpt5nOw+2=0BTmiz-9xKY4B0w@mail.gmail.com>
Subject: Re: [PATCH net v2] Revert "ipv6: preserve insertion order for
 same-scope addresses"
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>, Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org, 
	yuhuang@redhat.com, justin.iurman@gmail.com, horms@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	idosch@nvidia.com, dsahern@kernel.org, Chris Adams <linux@cmadams.net>, 
	David Gibson <david@gibson.dropbear.id.au>, Beniamino Galvani <bgalvani@redhat.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Andrew Lunn <andrew@lunn.ch>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.62)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294594-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:sbrivio@redhat.com,m:fmancera@suse.de,m:netdev@vger.kernel.org,m:yuhuang@redhat.com,m:justin.iurman@gmail.com,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:linux@cmadams.net,m:david@gibson.dropbear.id.au,m:bgalvani@redhat.com,m:regressions@leemhuis.info,m:andrew@lunn.ch,m:regressions@lists.linux.dev,m:justiniurman@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ihuguet@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,suse.de,vger.kernel.org,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,cmadams.net,gibson.dropbear.id.au,leemhuis.info,lunn.ch,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BF64634D8B

On Wed, Jun 3, 2026 at 7:46=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
> I guess it is safer not to break UAPI and not reapplying the patch,
> especially when there is no clear way to know which order is taken by
> the kernel.
>
> What about clearly stating that the default order is "random", except
> when an additional flag is set to sort them chronologically or the opposi=
te?

Stating that the order is "random" implies that someone will change
the default insertion order in the future, as the documentation says
that it's not UAPI. So they'll cause the UAPI breakage that we are
trying to avoid now. Moreover, if we consider the default order
"random" and state that userspace programs must not rely on it, why
can't we change it now?

As mentioned in the other thread by David, we have programs broken by
the original "fix" (NetworkManager), and programs that will be broken
(again) by the revert (pasta). But more importantly, I think that,
with the revert, there may be programs that are broken but they don't
know it yet. Again, see how `ip addr restore` will be broken again.
So, both solutions are bad, but doing the revert is worse, IMO.

As I'm not much involved in NetworkManager any more, only Beniamino is
who can truly speak on behalf of the NetworkManager project, but as a
former NetworkManager maintainer, I think that my proposal earlier in
this thread is the way to go:
https://lore.kernel.org/netdev/CACT4oueDv=3DKRZmJw=3D1N58EN7eoFz5AqbBBMP8FE=
4=3D+rQ99oFEg@mail.gmail.com/.

It's slightly controversial because it may be considered an UAPI
break, but on the other side it may be considered as a fix to a wrong
implementation of the UAPI, instead, as Stefano pointed out:
https://lore.kernel.org/netdev/20260528165320.15b90ded@elisabeth/

--
=C3=8D=C3=B1igo Huguet


