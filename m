Return-Path: <netdev+bounces-219652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61689B42820
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 19:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE9818866F1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88E4320CB3;
	Wed,  3 Sep 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hWiAJgH6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5044C92
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921314; cv=none; b=kEQkUzIUc71jYPn0RM1KIYzedp8ANveFgrVr2orwn4k2tI0chgR/rbZgPJbcE1ZfgheleQm8P8uzOILOGj3QFVDJ8fb8x0bArUyuZ+MB0cCCglw1GSQpTy2tOSobbyDtgb5gjn4oyKw8AjjA7iKAYMQujWvyMIo9u2N6VSD2hdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921314; c=relaxed/simple;
	bh=bpoCJi75TuAw42e6A3dn26O70w/74ptLXE3tM4BcXic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbkKaBtrUQOhZrVO9Md/+A/G3b8HDdGvfpxIIf6ovW/o3YTtsKk6Vs4X/2ZLFVJbNZiPokH5EgqQWZBGCBwsuD2B4c9iLbi7/NW6XmiIKNvIwjDDbEmjr6rHk6DdhiaxjiqM/EyAmFaWohnABm7akt5mcwfTX25U0Iz01++It+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=hWiAJgH6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so82916a91.2
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756921311; x=1757526111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWtU1bedA+xl7PsW7lcEl49lqWYG3Q0Mxi9lWkpXK0U=;
        b=hWiAJgH6OQ1TE0g6Lx+lGuIoJXXLe+WIdUcSoB7hSx6tQezb4cSz7bbG0Rz1XSWHXI
         fHTP8bclZoxwmVa/84IF6qfd9GdEfg3GEpyURMZa2UCEeDOFF2SQZ1FTcAdlHAS31/+U
         1rSTkHx8L8G+XcVHb1aLWnXHyBFaWfnPXSY4UAlQMjj6j+HfJCwxkTsXJT4MQJWnxHnm
         rDwntMEfPE1zku4SViA5n5o9zYMg7ST32DPu/TyCjeD29TxE6t5jasNJJQ+qmmqr1bYx
         /ahxdvVaUYMpd8NWjed9Sv5p5mwn2Lv9eIp1i61TELO8B1FM8Z0nkxswPOAg7T5rFB5V
         riEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756921311; x=1757526111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWtU1bedA+xl7PsW7lcEl49lqWYG3Q0Mxi9lWkpXK0U=;
        b=Xp6yh/v1m3qo2nJU+Xy4r8twruf7PLC9IUfE8Pt2TzKUge8KpAyAxYUKDpAhcv+Ty+
         bZWa0/iy1u824frwD0W+pBdtu7ihtsg2B7qzidIO2pFvlFEbUacaBJUDn4IERwg/v4fz
         zrpZhgNbVgwG7zyKpSiEbvRn38a4DUQ6tITgVL4Y5xs6DJG+NwZA0HdDeh5TQXlNyW44
         Tp96BTLpwlbSaPqGuxNZJ7BKknqJ4Hj7cUQ7mwToWCH4KQgsvpFsKicLTqMWG+1LNr4P
         pq1cYO/A1uMMO8yT9Iwa0+SsC3+cEMt7kmO1KIwwZWgyVuOqxEdk+B/p8/DQxBWZ24w4
         8jHg==
X-Forwarded-Encrypted: i=1; AJvYcCVkvX2nl8ka1uK26IFVbk233L6/rry8WsjZ3PB8y0c9E0NE/bCSR1dQ5Fm5Dx2PFqR/8apn+wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8iUtFzf99OE61/PyKZSoWaX/yoD0MFSmpu4qLtpKp9IQUe8Z
	tiHKd1n67o4mFYIOTd/7gyaQ8i/TFW8LZnKVMeaNJMhgfDQRjPfDNg+UFAKaPyWfuYg0bVQnf05
	SIelexlzB/a0+2kgEbUzZyXk/rMW1wZ6ywi5OpZyIG6n5pvj/VFkVzVjJ
X-Gm-Gg: ASbGnctS7/F8CR9wLyXG4HPPjSpTYCn7+C7Px8oGyVqGSZeFz2uK3C7yHeIuUI3w4Y4
	bhYsiKyA/YhT9v4drENobTn8w3cCHabNY0zwoAxeuLYwV36+ckhc52Nx4w5tZzJenX3mAX+5q3g
	1qiWJtkyUbGFtM0SY39Ll2CkWNqhVtjoMSLEirHdqk+1Lo5NPiqFi6SRerCj5eRCagsHIfhC5A+
	EHv9U5X0e5SuxswFKD2rTqotRSKlsEJU2pK4y3qjAAkT7OLsfgVP7fXPKE0P+EE35EyAL7xZhrb
	6RXsNkTfA0/CfByFJdXliQ==
X-Google-Smtp-Source: AGHT+IEdLWK2VV7ZxjQos7fBkP7u8BQWyaln03sqyxsZVqDVAVkrTc5Wpas3Svc4Qfy0iKtmL1jDBmsodTgI4M4eHgo=
X-Received: by 2002:a17:90b:530d:b0:329:ca48:7090 with SMTP id
 98e67ed59e1d1-329ca4873c6mr11775847a91.37.1756921311323; Wed, 03 Sep 2025
 10:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
 <20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com> <20250902160858.0b237301@kernel.org>
In-Reply-To: <20250902160858.0b237301@kernel.org>
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 3 Sep 2025 18:41:39 +0100
X-Gm-Features: Ac12FXyUeZzt3ewl6-0Cy_MpfxEF2HbCkiS16_FH_5RnMTn3QtB_EuyigatOeeI
Message-ID: <CAGrbwDRHOaiBcMecGrE=bdRG6m0aHyk_VBtpN6-g-B92NF=hTA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bob Gilligan <gilligan@arista.com>, 
	Salam Noureddine <noureddine@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:09=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 30 Aug 2025 05:31:47 +0100 Dmitry Safonov via B4 Relay wrote:
> > Now that the destruction of info/keys is delayed until the socket
> > destructor, it's safe to use kfree() without an RCU callback.
> > As either socket was yet in TCP_CLOSE state or the socket refcounter is
> > zero and no one can discover it anymore, it's safe to release memory
> > straight away.
> > Similar thing was possible for twsk already.
>
> After this patch the rcu members of struct tcp_ao* seem to no longer
> be used?

Right. I'll remove tcp_ao_info::rcu in v4.
For tcp_ao_key it's needed for the regular key rotation, as well as
for tcp_md5sig_key.

Thanks,
             Dmitry

