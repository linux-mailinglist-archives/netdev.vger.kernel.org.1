Return-Path: <netdev+bounces-291264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOwhMj0KFGrVJAcAu9opvQ
	(envelope-from <netdev+bounces-291264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:37:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C935C7DC0
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44354300668A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAB13E3C57;
	Mon, 25 May 2026 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXmCfaTY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C1332621
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698206; cv=pass; b=tbhrw1o8ukyyIKuVC481eae9PikBR9P/QdpwwTR/06Umzhfg1iau7YR1zr07XSjHQbjW2KFvO/zcL7axhLLWTsKgT5u5VCIif+dO7azedM4773wNjbs+6CAUWetoJm01jBvciXU9xeKx4UL3SCLaADrsgB8gec+LrgH8M/vA/Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698206; c=relaxed/simple;
	bh=ApcNSED45L+0kzP+fBMWpFPp7gsyfcR2kTrCY/D25Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGhFR6bcoeKVrte7RwL6K6Gis83vm9LSgOhcZnFhN1jJY5+b5WetJ3ZnqFcIrZqE2brbzHS+30LnMnWt9oPjzEr2ud+gym3ynIuN8oaI3zHCAvVzrhh9hDtC9GaCAOW29W74lAxryF4s8iVokS95RyDLD0b5eHdBD0uC/V3u4R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXmCfaTY; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-914b4be9c4bso296681785a.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 01:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779698202; cv=none;
        d=google.com; s=arc-20240605;
        b=CC9Gi3Xfb8oXveP1xbzkhGzLXVM9UF88PIkEeYINnnRF2pujtsVR1vyHTF3VOZfrON
         eGfR020/kOOvB9NrA99TMZ/+baQN24d0rtpDohWdQYRA9ANJ0J2vQdUNti3K5ylGgtjt
         b7Jga8B17ZmzotX1PGLJQF5VWXqH/RSE5GSiYnVBOvUxcy48X/wYgk/x0hO2YRsnrOhs
         zH/ooJ5mpDOW2vAVY6PDj1F+jka3FWPU/vV6HVwajYMV4Kz6PSNTNTIWjO4DcJ6jqWLc
         hJHhAkY8l1iK1mXE/E0O0PmrCSfUID5o4Ot4j3ESGxGtNwRslY1QwXGB0DYqSopk3zMx
         EwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ApcNSED45L+0kzP+fBMWpFPp7gsyfcR2kTrCY/D25Z0=;
        fh=mRibXN4zu9S9SiO1Fl0pzgNKlEEGFJ9wYnyZ5OHs/64=;
        b=lLmM04bEVKNLw1FHT98F71wtt2YJDHOpdEZj1OS1uGa9ktTEnyeGYRO7th71GKRC80
         qBtxMszuOqGAKqz4bYb6g5LyHt7MbGtTtJvjV31QCt2ho1ZerpVL+dk00HB4rmWeC8EJ
         NCDBb7lUign3eSEO858vLcziHlcL4WzJe2MYGn2Fc2hQjSMZRc++dBtv5T2a+TV/TBzk
         Oq8qe1ffkqXMdLeQUVm6ed1lebsRcPcI/RUmUVP+9Q3+RHwBlpTwyEyz1Mnk7Kbuz3lQ
         nL0S44yn5dVli/t/Biz7GI1eqLk07XOOpVlb3pW3ejTDytg2b3ZBQxqMHocpT+dNX0z+
         gQ/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779698202; x=1780303002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApcNSED45L+0kzP+fBMWpFPp7gsyfcR2kTrCY/D25Z0=;
        b=oXmCfaTYmv7I4gTpoTpuyGkx/pmzug5MEL3iH+Z8jQW9fM4q7OsfRcpqTrDjIuvUYf
         hdAacG2bEsGo6FMdVGOYjYjjPRoM8O2QZrZmYHuPdmlkoE7XACGF4EakEStfAVl7tHbQ
         RMrSvQsjOTJH4n1kwVNbWM4J/BaYAg+euHWpzZVj/wWrpuJuYauYxMMDazFyWEgoRyET
         Ue9HlswPzMyKStnNlowbVz9eDTEuz7+9r1PE/m6FT0zJL3c6ehkbEFC0BfYU/7TBqoQk
         HjhNTicIfHGxfWpkJLfa7K7vpZY5BBbBjx+mHWy5Hgiu2H6AdC8iyCUiNVWOgRnrHtKl
         rAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698202; x=1780303002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ApcNSED45L+0kzP+fBMWpFPp7gsyfcR2kTrCY/D25Z0=;
        b=ah4KcjQqey9H1IJs5oBhLs3IxcB1Ac47WLLSFsh9pZ5lPcNdGEwQrI/9ykQiNyitbE
         xkvJXenrIMdPhen1ulTkDTFCsPUVyTOXtaDLCElZbPxEH36WnTkFdHs/QR/bAWZLyPGY
         psunrViUQwVEL8qyuACWvUybTsOf4ipxjDs3jKdyfBzGbNZppCRS0p1zyUlhRkwocVxo
         ZtIQhkuc0SMmTKlhpWJzGTubxSk+AqSrDQurHwJQI82O+ftHPTXADDHvTgvDlNXjXm6o
         kKwQi8G0xPp9vu3MCBqoeFfS3vodWdAOf7CLNRQqILMNAy1Hfjb/2KTCsxt/y9sTKlC5
         WEog==
X-Forwarded-Encrypted: i=1; AFNElJ+iI5fvlr7Qt0/GdEiXcQAGj5iGh7TPQ4mo6AhuLX/eJ/XKt2qLhykpC2jmXGwYjXb1wuU35Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoYJZBUSsbJMTJdcGN5v4phqCSQHeU6ivnNM2TXrBnMr1ggwN
	EDCvZsdW9eDVatYLw379Azizx1E47hMsDK9EqOpVAo4pMNPbdrKAIaij+W8np9p26muJhqBs4QO
	p528Yl3o2xp0G9PJ6WZju0ag+vwMYYK/6S5NI68Ka
X-Gm-Gg: Acq92OHXW/9a6gpoKdhiI/rS/RZ41oHAWU30UmVg223/AaZYSY3PZ6L3ScG1Nx4S8rF
	eeJb3CyjAlQXc/hbS2a+6KcjByLLiE/b2FQAxaYHat98IZvoClwSiKXzqSXRAy8k/hovYQx//6R
	54auixRIX/pj39fS0HQDgxmWVbXPdUR1BIDl+X51eEMGxrGYcvY0a+kVLuad5m4xtALe9mjArpM
	r8m60oJ9GkD9IMba6QlbpM8GBCkw1Kk/XlVUo3/9zLO9x5PQM0lPNbeMkSdqMyzaSWYpktBjWFf
	0USrb0UOOmQd1by1Bhp9U5+f13YBRRIcCBm6s6xqOVFNK1uvRJjVAg1JDlXJZSWpNnKVmuydOe5
	M8BP1Bbrpd8swfRQ/s1O0GaQ+dBsFYTM9hSHYbjFWLJeTijw6lV0v9MVsc3HKoDX5
X-Received: by 2002:a05:620a:448e:b0:912:bb4b:a900 with SMTP id
 af79cd13be357-914b49cdbf4mr1876317085a.40.1779698201108; Mon, 25 May 2026
 01:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525001745.1251640-1-kuniyu@google.com> <20260525001745.1251640-3-kuniyu@google.com>
In-Reply-To: <20260525001745.1251640-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 May 2026 01:36:29 -0700
X-Gm-Features: AVHnY4LMf1jmAedPLnLhmGeDz_h9SBTH0uMA0ohKmzcYLZRyCV_m485u_n4lx04
Message-ID: <CANn89iLx0L+q0A=_+-a0P=jS4hLF_ivZrRW-V4e+yZEp35MWWw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/5] geneve: Pass struct geneve_dev to geneve_create_sock().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,kernel.org,redhat.com,networkplumber.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-291264-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 77C935C7DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 5:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> This is a prep patch to make a subsequent patch clean.
>
> We will need to access geneve_dev->cfg.info.key.u.{ipv4,ipv6}.src
> in geneve_create_sock() later.
>
> Let's pass down struct geneve_dev from geneve_sock_add() to
> geneve_create_sock() instead of individual config fields.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

