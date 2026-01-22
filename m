Return-Path: <netdev+bounces-252158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEkaK7OZcWngJgAAu9opvQ
	(envelope-from <netdev+bounces-252158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:29:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A9F61584
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45DFE4E3392
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B823D3315;
	Thu, 22 Jan 2026 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB0wlMIw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942722BE65B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769052340; cv=pass; b=HlMMbOZXvBNVO1IQpoKR0USoDS3WdNKwYwyydwXEH1i3hSzzGo+erjU1a+nVPecYggw+0496jD1xnA4WC1uguE5p38sogypVQJroxnYjceUXcNrOdl4ZuDGvZldclaibNfeLN7x7iex2vMyTa3mj0BG0nB0xx9WJaDXjbzSMMzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769052340; c=relaxed/simple;
	bh=RxcFmI2IAGkmYdnYkNa89B1ljCXr8uo8gHzSY3WvK9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kK9655BHLXZzx9fbTKAzqNPmdmyTDsnTG3F5zyjbozuHUIcMQKn1QdoOtJzeOjyKEA7a5CdEEnhfB4BSMD3TXPLlvwa1EnFtOP6e6L23o2LtqHUTU9YE+BLcsksb0FHgFnEQeI8Qietq+zhHpdlOInIhFWpIGRPevnhv78/TuDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB0wlMIw; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfd819ae5eso164641a34.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:25:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769052337; cv=none;
        d=google.com; s=arc-20240605;
        b=ZaYGYSYro/NPSmCHIZXzgHsHhmIeMD/yuFKGIbSoLhm04VRpvIoMCIOwaJl3EeYfcV
         NCMlfUhEybI+ogFPiK0UmrWH6K3fUDlyEZAY0SO8jq5bJc4Xc9HldMiaDhXS2SU+6F8H
         Ir1sdtBFnYmj+ROr/asdcv/KwsCKCDs0tUiSt6bZ1nmzn6hVOBDELBBAxwKXJT8gNoAb
         mDs3cziWcqTCG7CkFRhY8FQjDX7mVN2vqASsEoiP1soEYalSiyIYlzi5qy+/NfTBgRU+
         +Xg/l593hng9INoLVzTH8J9CrlzIClTuA1lFUFDs/sLiq1l/ZotqYKl7btHfKzvAiP4y
         t2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RxcFmI2IAGkmYdnYkNa89B1ljCXr8uo8gHzSY3WvK9U=;
        fh=mcu7M5U3p/8XiU7aVsIoyLinZz6mZ3AvJp5ARBeUids=;
        b=jn3ANjOgwQQVpHDM7eN8N6AkT7tX4FN/beQOspbxiOCUtTDRuyj/jljive2CHA0YW4
         KXCUln3NKes0DC6/ljc8+suyCtoT6xYWYNv0sV6HoZ2AGKlZELuf8q1TBD0qRIUsw2o8
         PjDVpax4BPcdL1rSY1KaOsJpq5I408TUIRh/NOCEQrU97B/m1qvaHaPHTyJtE7WO1wGu
         BU9zR3EdZh3f/qsxbPqrbgo7Xi2pjnXbho1VNDoineTHFMe18DfXfWbmkQ9covDbav0K
         Xge0B6VmNK0SoZLJC4C31Y6n0WGX1EAxn+55Mcl2gJxxXrKWKXBFffkUlM/qp65I+q1w
         qdcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769052337; x=1769657137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxcFmI2IAGkmYdnYkNa89B1ljCXr8uo8gHzSY3WvK9U=;
        b=kB0wlMIwZft5yoNg9jtjL1qV9T3g5+odcXh8BHV6L57EOunzWzT0R7s6jr6GTMJali
         0JTXluj+Iae80GCFb+QThteShLYywGJpUOH2zlOLMhZtEWD3cP2KjKzU6Jl4+C87aMFK
         C+Ce3Nlua1Xpi83kjLQUwa32pwDB61/RdyKAswceMlhLqf6j9t2exJiHZITLUApzcgmM
         nLW6Li6KFEnONjAIMNF4MGGiwOyuiJpZFj8hrhfOfmz4iPtWmjzMDrmSeU3neiUIFi5V
         mlW220zxyihQifueyN8p752m/egF3QLsDG58+PuAIbvNBjAKZAqK0CQSI5OMNJjH4yt9
         Fcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769052337; x=1769657137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxcFmI2IAGkmYdnYkNa89B1ljCXr8uo8gHzSY3WvK9U=;
        b=ZgvRyAe1440ON998cxLC1W6Mu5CaGNHWJf/xUez0wGUB1alnJ1CZgMT2vjzEcKPdlb
         wzs8R5ZSIHnw+Epgj5LR4iRUtRqoLqkToAlEu9MfbC7XC5np3qwZcbGHYRImt4nKH0o1
         E3Lbtrkqv8RMWB4jtjrYN4O4pHpolJtr3/hJ+LM/2z6s6SRdgYVtQUFXAgihBh/FgNSz
         +4wlGQPyV9yiXyiyODSo+Alp8PEmLvvf2FgMVHmx72Q4G2BS9VyyMv+2gN/nKpl6Aesz
         UHI7jQd9W7Qp4vT6+6JFoL4Hgd1AQ7qoQrhv2p4Wt88UyTg9AV9Qz417W3RRzP0umYoB
         dzDg==
X-Forwarded-Encrypted: i=1; AJvYcCVl/5KbLf7mEEdRbTcG0HXZ/G4yFTrn2MVKKNexenRUL5+Evu74WYnvNZ0mSncsoWMqOdofw2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStOjql4YjjDZgPsdANR902DxN/JA3OnEGhdy3ZORJA5HwirkL
	S87RGIq1rxsI5x99loP4gNrd0slgMygwc+3O6zW1/aRyS7ZOKQG2K27D6iLdyKSfqVOfLO2DzUr
	qNpb0Bql+ZZY7YGidFShnSy9MIyI34OI=
X-Gm-Gg: AZuq6aLhQtDQWEiwqkn/oATD39Qjz/zgFgryNqG8bdn9exr4kon6DgdD4QNGhkjb5UD
	f83AqEFOrtPYbv7e5v9w/bUfU1ffhsycxJnII2wMvkohHZVB9WAGdouHicmP3/mPs94ibt03QFg
	yLQD6k6WA9f/DdoqiiMQg9r6/B0U2PhXYKNh9graqg+qLp7g0B0GaF//OL6OZYKHwmBsafq8lFM
	3SZ8D5h9hDKeKpinfCVpT2O+KC9Hn6fBcc0IK7qZjvPhKMoW1WplfI5PE/F55S0SplXe4EkHfe4
	vGV6Ag==
X-Received: by 2002:a05:6830:3982:b0:7cf:db69:5475 with SMTP id
 46e09a7af769-7d140ab6895mr4490648a34.24.1769052337402; Wed, 21 Jan 2026
 19:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-4-686d0af71978@meta.com>
 <20260120163650.5a962648@kernel.org> <aXBnqYQdomzH9bT/@devvm11784.nha0.facebook.com>
 <20260121173512.748e2155@kernel.org> <aXGNhEKOhkTHbJvw@devvm11784.nha0.facebook.com>
 <20260121185021.446b00e8@kernel.org>
In-Reply-To: <20260121185021.446b00e8@kernel.org>
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 19:25:27 -0800
X-Gm-Features: AZwV_QjAIr5HWq1OvyaswWVCAIdwEzJFXqJ7idBVevJ43OdVoqWduskcsKDBYHI
Message-ID: <CAKB00G2xNvfiV6J3RzKDs=GHMGZ7L16+VKUYLGjpZdOrLnSYKA@mail.gmail.com>
Subject: Re: [PATCH net-next v10 4/5] net: devmem: document
 NETDEV_A_DMABUF_AUTORELEASE netlink attribute
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252158-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 56A9F61584
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 6:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 21 Jan 2026 18:37:56 -0800 Bobby Eshleman wrote:
> > > > Show an example of the three steps: returning the tokens, unbinding=
, and closing the
> > > > sockets (TCP/NL)?
> > >
> > > TBH I read the doc before reading the code, which I guess may actuall=
y
> > > be better since we don't expect users to read the code first either..
> > >
> > > Now after reading the code I'm not sure the doc explains things
> > > properly. AFAIU there's no association of token <> socket within the
> > > same binding. User can close socket A and return the tokens via socke=
t
> > > B. As written the doc made me think that there will be a leak if sock=
et
> > > is closed without releasing tokens, or that there may be a race with
> > > data queued but not read. Neither is true, really?
> >
> > That is correct, neither is true. If the two sockets share a binding th=
e
> > kernel doesn't care which socket received the token or which one
> > returned it. No token <> socket association. There is no
> > queued-but-not-read race either. If any tokens are not returned, as lon=
g
> > as all of the binding references are eventually released and all socket=
s
> > that used the binding are closed, then all references will be accounted
> > for and everything cleaned up.
>
> Naming is hard, but I wonder whether the whole feature wouldn't be
> better referred to as something to do with global token accounting
> / management? AUTORELEASE makes sense but seems like focusing on one
> particular side effect.

Good point. The only real use case for autorelease=3Don is for backwards
compatibility... so I thought maybe DEVMEM_A_DMABUF_COMPAT_TOKEN
or DEVMEM_A_DMABUF_COMPAT_DONTNEED would be clearer?

