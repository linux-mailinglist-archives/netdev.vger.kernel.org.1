Return-Path: <netdev+bounces-197605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E79AD94BB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557461E4FA4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF7230D1E;
	Fri, 13 Jun 2025 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="k6ZHNytG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D862356DA
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840346; cv=none; b=ayOKe8/GBqSLY2eBn1EoNqhT7qHWnaKWxjuAYAt5yM8gcqo2K9TFERtP2MkSaTBhePZbpE6uv3nLNhOws3KHd2U8S7kSXdDV+Wwvv4/HOlC8IHzwVpAnBxS1clFYJsic21meKBpM+AMCpaFE38uQqUioMLliareZGYSHd8UvXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840346; c=relaxed/simple;
	bh=FaVeQrmt7agNT1LuG00I95A+3dvfTtOexqCLt3e4dRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujNsahlHAp8WNJiEexDpKdm5ckHdaeRn+0j+2k4Tcy5YPL7tYceaA11/9TapzHY7Wp2eN09aoIjoS3/LRjN4ryAPEXqc/FKjizFRbysBg55IqZkhFKaGfu61k4GV9eQb1b71hw1fzn3q2SAfYimjWjXywV7jGuAcMDN1NW5rVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=k6ZHNytG; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5hLJtm/bcU0hEO333D20GNoYocKHnarT/vOWKlg7MwE=; t=1749840345; x=1750704345; 
	b=k6ZHNytGMhMieo1VbtY4wjrs7O+XvB5wiMoTPjWMDfSmVVH0gg2yyvzHeiCAJLmliCLunWC95DA
	QLNjeDqf8VJbeRetBGvg1l2C1KFKwuVG7zJ1fBuqcwi+xV3p1NvhdUwc7P0CdZgC2hYjtX5zbqvwz
	GJTs4PgEu8jEHSAz7chDgThev75O+E98USyHMx+Ms1WW9lBJygDEXB4Sbi1/q+fhTVwgRFJb+S3Lx
	jHQlFwVh3rScnzvdIGkq2hxGhtG8ADxe05LOc+Laka1jlps2C9ThVrY1qbzqT2JAA3aX2PhtiCVKu
	LZFWgRrxP97GLK1+nvx6MwlwH6Gi4KbAARew==;
Received: from mail-oa1-f44.google.com ([209.85.160.44]:60740)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uQ9PM-0001En-9L
	for netdev@vger.kernel.org; Fri, 13 Jun 2025 11:45:44 -0700
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2e541e0b974so1515678fac.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 11:45:44 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw1l7pc5649i0jZ4Mssr7Gm5xSw2wFQXGq2bl141xl95zrM+FoZ
	QgF5epTQ/Q9zEtK0vPp179TrSSKVJdB7sGs/bCFBZG9dYrqTwcUC0mbdLYcGCzjiTE0VDBQyXHJ
	gImwh4j04Nde6xtjFZkyNQQA+5WHRoFU=
X-Google-Smtp-Source: AGHT+IEpxSHWMtnRUdfgOGfnsnlravMG7/dk0SF1RS/8H3g7kg/Zry02x90keYj7D+UdPBPQGxhrNFqWZFd/Qu4VPLQ=
X-Received: by 2002:a05:6871:7a02:b0:2e9:e2e6:4a20 with SMTP id
 586e51a60fabf-2eaf08c0cd4mr563342fac.16.1749840343735; Fri, 13 Jun 2025
 11:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609154051.1319-1-ouster@cs.stanford.edu> <20250609154051.1319-14-ouster@cs.stanford.edu>
 <20250613144133.GJ414686@horms.kernel.org>
In-Reply-To: <20250613144133.GJ414686@horms.kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 13 Jun 2025 11:44:54 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzwRkpjPSWyyPv-P9=rrN6u=Lc=dXOXMJMgNo0mY3Rc6A@mail.gmail.com>
X-Gm-Features: AX0GCFvICoXfZBWFbo4uiA45Hx4lV0nSW5TlT57EVCq1-4Nn1Hgp4sAj8pjDAd0
Message-ID: <CAGXJAmzwRkpjPSWyyPv-P9=rrN6u=Lc=dXOXMJMgNo0mY3Rc6A@mail.gmail.com>
Subject: Re: [PATCH net-next v9 13/15] net: homa: create homa_timer.c
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 9dddbef7dbf47a29383c7a3c8e5dce6e

On Fri, Jun 13, 2025 at 7:41=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
> > +/**
> > + * homa_timer() - This function is invoked at regular intervals ("tick=
s")
> > + * to implement retries and aborts for Homa.
> > + * @homa:    Overall data about the Homa protocol implementation.
> > + */
> > +void homa_timer(struct homa *homa)
> > +{
> > +     struct homa_socktab_scan scan;
> > +     struct homa_sock *hsk;
> > +     struct homa_rpc *rpc;
> > +     int total_rpcs =3D 0;
>
> total_rpcs is set but otherwise unused in this function.
> It looks like it can be removed.

I have fixed this now. For some reason gcc didn't flag it, even with
-Wunused-but-set-variable.

-John-

