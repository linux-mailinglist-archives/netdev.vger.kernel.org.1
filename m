Return-Path: <netdev+bounces-156030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA5A04B40
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15F8188610C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352521DF979;
	Tue,  7 Jan 2025 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="j+daRk34"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA77A95C
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283248; cv=none; b=bCiDRquw+n9pahv4zhv69+ok/kkeCiUAfsyQ4L2A8S2Uro5CxjVYm065elo7PZXAc6UiaHvQbH3q64Sh/fp0RCoQKBnVOsjWP31bgUOUeBDYA67HgdLJ5AWXuFeZ1Hj/lX7QGsUKK4GL3Ncgjw872NZo8JGu/iq7vFIx/Rjnx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283248; c=relaxed/simple;
	bh=FqwJK/Kotz9EeOlyQhX80UIt2MWH2UzXJHsXAvcNen0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqwAIVzjGM6PxQzKsesgZH9NIMV90fbP7+2l1kzTa6gmyJqrVPuSp50FmZuKEFO+kftjXHiy4fTjLN+/sIW4JNuH9zx7mWmU633D5FjlSaC3gLF+g7qs+jZe2z3ssc+X2VaG/aaDVjb1qQS948Sbrd+hUoLJJry/+QwXmNE8ytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=j+daRk34; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2WtiWALrzgF2FfespmiXLp/29Bj/q3I7jDIRL0rPFd4=; t=1736283246; x=1737147246; 
	b=j+daRk340vd3kPq0LDkhHC5o20cVhLcVw69Ph18qFUZuSoufTxSvQQo7n5dm4tETWfcVuBL6VxW
	of3KOxr10WTq9tMVP6MrX36Ksg/7gG3xjmlsEuNFLTPTeDiXBPnrDeSxHGxsaBWljy4wtXEaa5wHH
	Ae6mNG9ZN87UavrvYNgD31on3wIfFqT1Fm8hNPmO0tgCBB9sz/vVOY53oBPpnmtBSosqbfDTcr5Rm
	9i6Po4AFzYRF3l4fEzIU2LaoU8n+PPVsuEkx6KDVM8mdfMHo1nsWu6nQrmmKCn0XuhbPki/CXC7Da
	wmsn4rTV92rTlSFVFJ5qy1WtWSgsu2N8b+Nw==;
Received: from mail-oi1-f173.google.com ([209.85.167.173]:60916)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tVGaT-0001Yx-5p
	for netdev@vger.kernel.org; Tue, 07 Jan 2025 12:54:06 -0800
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb9a0a2089so8644754b6e.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 12:54:05 -0800 (PST)
X-Gm-Message-State: AOJu0Yy0h6Ejo6XKlYUzqFS8a6R8p0iqDD6V4IyJ1r4MGtk86XU1FbPE
	7eASEM08cG6CLaNrzj4JJtGNwqU9Jv6Woz0vizUyfN37PI/WDBjDyZPch490bJAPZg93Y7U2rlN
	fU5svm2ehAc2hXekNNbkML5nId/E=
X-Google-Smtp-Source: AGHT+IFIueS8Xpse2hmbEDp8qXmWZGDKNOmmD0WPQO9ABN07P/g17y8+7Cra6t5ha27wH7tytZa02wtE16CXNW2bpyA=
X-Received: by 2002:a05:6871:4108:b0:29e:32e7:5f17 with SMTP id
 586e51a60fabf-2aa0690f135mr208610fac.28.1736283244617; Tue, 07 Jan 2025
 12:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <20250106181219.1075-7-ouster@cs.stanford.edu>
 <20250107061510.0adcf6c6@kernel.org>
In-Reply-To: <20250107061510.0adcf6c6@kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 7 Jan 2025 12:53:28 -0800
X-Gmail-Original-Message-ID: <CAGXJAmz+FVRHXh=CrBcp-T-cLX3+s6BRH7DtBzaoFrpQb1zf9w@mail.gmail.com>
X-Gm-Features: AbW1kvbhG7anwSGgRUMMqRKYXMYZstn0aaWyXaGGOWm8dBgE4k6Jiek3PfwbLo4
Message-ID: <CAGXJAmz+FVRHXh=CrBcp-T-cLX3+s6BRH7DtBzaoFrpQb1zf9w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 06/12] net: homa: create homa_peer.h and homa_peer.c
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 5e15904e367bf57319d290d73554c551

I have removed the cast now.

-John-


On Tue, Jan 7, 2025 at 6:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  6 Jan 2025 10:12:12 -0800 John Ousterhout wrote:
> > +void homa_dst_refresh(struct homa_peertab *peertab, struct homa_peer *=
peer,
> > +                   struct homa_sock *hsk)
> > +{
> > +     struct dst_entry *dst;
> > +
> > +     spin_lock_bh(&peertab->write_lock);
> > +     dst =3D homa_peer_get_dst(peer, &hsk->inet);
> > +     if (!IS_ERR(dst)) {
> > +             struct homa_dead_dst *dead =3D (struct homa_dead_dst *)
> > +                             kmalloc(sizeof(*dead), GFP_KERNEL);
>
> coccicheck says:
>
> net/homa/homa_peer.c:227:32-52: WARNING: casting value returned by memory=
 allocation function to (struct homa_dead_dst *) is useless.
> --
> pw-bot: cr

