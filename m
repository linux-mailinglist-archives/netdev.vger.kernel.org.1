Return-Path: <netdev+bounces-161402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669FAA20F60
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AA13A5252
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A381D79B3;
	Tue, 28 Jan 2025 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="XtXIom/e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4042199E94
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083944; cv=none; b=jhI9EoITPVXbLMWfCvIxAAxeF9YWkiEM7M6jJwCCxRQQt0saFQa3jLbLFboQhLr67jNUXvw+rGpkMnuVJYJvkng5KUhl/6kKIl8SJlXG2ytY+d7XFt3u4+ixUvONztyc404ZfbJdwMwmYL/yTn8eAddnq79e8pnhfBsVnTCAaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083944; c=relaxed/simple;
	bh=giD4N2WAh5nFry+8Y1xwQKHbbHHJYEwzJFUdel3vEL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8sra+nzD93RCV25XEzf5i87IMZ28akowzxcojKTotFBOcTIqRRla9VMw2H1Bz3qs9ABtNk1rSHuEmqe3XmI0nAkKHv7JyrY0kVFp9q1EYb5Dl5TKL3JO9JeTF7ZaeaWbuF8r/TUqOn8Eij1qZv0JwtOJmnb1379yG7RKUCa2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=XtXIom/e; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=giD4N2WAh5nFry+8Y1xwQKHbbHHJYEwzJFUdel3vEL0=; t=1738083942; x=1738947942; 
	b=XtXIom/eR+tflf6KI5l1JYlBQnsR0/YHebuckgelm0rsL+fcGD6J4CH6XnDkFV2OL7JoCpzi+U+
	LKXuEzlNzcK73ToEpsoAysQf8HPr7w2J5VdgML/d2slhln/N4wMAIH07lKT3OQubTuc7uXLJu7sjh
	7zJ/vKFGhu/d9adYnlZBzdbY++uaIuv95pdAorNGGNgRGNoR02cANZwAsHsHuJ1R68WwNAD5kNb/K
	bSy0rIuVd/pIdR46ZcLWD/qsvpoR5st5BJw+7yl+DPPT1OD1V1kvcUKy5IZSV776mcG99R3sMVAJZ
	WSWM4xyJfmEfMSsAxEj+HgUHri9i45pihTBQ==;
Received: from mail-oo1-f42.google.com ([209.85.161.42]:49636)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tcp1s-0003ik-7y
	for netdev@vger.kernel.org; Tue, 28 Jan 2025 09:05:36 -0800
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fa2685c5c0so2578426eaf.3
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 09:05:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIDvKXOPxFRjkXKON3K+Hyp1mQluQFRfOcQnAhgdvplD90XaC9t7/zdwHQHHJ0TEakEl1YNS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRw/Mv5NPudcs2TlV3Q1A9HHzU13AJ2dgTlqH8G302z57A25na
	YbeaUujiebGpftM7J/q26INYaRx1BA6urvU8h/IFpcYxC5vAZA+2mlFm3h/G7uiZ14/7p1IrSPv
	5lB2wQjmKh2TEVhVvwgpRgLcoUvs=
X-Google-Smtp-Source: AGHT+IGeZW2so549pFiAL20x5sPWRnnqNpAI1iya6IdC9PbBOmkt1Pmgabk3K2yezOw/m0/4sE+X72njV+WkUsNdOjM=
X-Received: by 2002:a05:6870:ae01:b0:296:2cb4:2394 with SMTP id
 586e51a60fabf-2b1c0b018eamr24478917fac.17.1738083935638; Tue, 28 Jan 2025
 09:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-8-ouster@cs.stanford.edu>
 <028f492f-41db-4c70-9527-cf0db03da4df@redhat.com> <CAGXJAmxqoPw8iTH0Bt4z5V2feM8rekDDOJapek4eyMuLJhUAtA@mail.gmail.com>
 <CANn89iJnhJCYE62jfpXesQhn-XrZJfPe3DGohH0+x5tpVC68yA@mail.gmail.com>
In-Reply-To: <CANn89iJnhJCYE62jfpXesQhn-XrZJfPe3DGohH0+x5tpVC68yA@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 28 Jan 2025 09:04:59 -0800
X-Gmail-Original-Message-ID: <CAGXJAmwrKV6bDZgAvDUX2Y0XqhsHROfXPaAYVMsKRNU1XTodTw@mail.gmail.com>
X-Gm-Features: AWEUYZkD5xQ9YkU3Ybfn2IFibufffeIdUNlQIUAB1qaoq1t9a04hd50jUvUR8Vs
Message-ID: <CAGXJAmwrKV6bDZgAvDUX2Y0XqhsHROfXPaAYVMsKRNU1XTodTw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/12] net: homa: create homa_sock.h and homa_sock.c
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: d568c20fab0e2ccae07d583947984559

On Tue, Jan 28, 2025 at 7:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jan 28, 2025 at 1:41=E2=80=AFAM John Ousterhout <ouster@cs.stanfo=
rd.edu> wrote:
>
> > > The only caller for this function so far is not under RCU lock: you
> > > should see a splat here if you build and run this code with:
> > >
> > > CONFIG_LOCKDEP=3Dy
> > >
> > > (which in turn is highly encouraged)
> >
> > Strange... I have had CONFIG_LOCKDEP enabled for a while now, but for
> > some reason I didn't see a flag for that. In any case, all of the
> > callers to homa_socktab_next now hold the RCU lock (I fixed this
> > during my scan of RCU usage in response to one of your earlier
> > messages for this patch series).
>
> The proper config name is CONFIG_PROVE_LOCKING
>
> CONFIG_PROVE_LOCKING=3Dy
>
> While are it, also add
>
> CONFIG_PROVE_RCU_LIST=3Dy
> CONFIG_RCU_EXPERT=3Dy

I had CONFIG_PROVE_LOCKING already, will add the others now.

-John-

