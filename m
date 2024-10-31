Return-Path: <netdev+bounces-140805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E579B82E6
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 19:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BCD1C2134E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F81C9EAA;
	Thu, 31 Oct 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="HyiufS6H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F113A865
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400963; cv=none; b=H1U3Zd+zq7fyEkUWtc2eAivcu7Mt6BdpmcEqnSLJBmYo0ZlJzaUAfx15IjoDuohRar0t5DxYPV+6S1wmIZYsDAfYR1Z6b47MzYaK7Z8r8shmwlmiYtSxRpleo3z4gKYcP8BbTSxsmHUiUv3jGMxhHoAswrbFEr7tkwS6T37Ej6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400963; c=relaxed/simple;
	bh=YY8d60DXa18BBD4gDlCZsDvJKVJirANi+p8wITaNGQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDtOE26Xfb9vTK67TSIaMW4zIKEmlm7V53tFNmgRxk00PfQE3/CjNGMy6R/P4DStlJKBuAyZ+Ra5uXPHsuZ3w/DW3ozBsfisf0WMjtxSLNgF6O3C9Rw0/AsFWvlRTuXrcMTXToNtBeAFwJY4+cA/ugp/x/cFkUeg0LeB7M9RH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=HyiufS6H; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2Uye1lyKqf1zZpVIk66oaESg84GQd4S0tFfApwUCHhs=; t=1730400961; x=1731264961; 
	b=HyiufS6HaAKrKhfhx6bImqgQg4TKgomR54exdybF2cPj93LssBNHwMi4tKkHhVdGTIRgfDO6/s/
	9dMGTVbmn1wfYRcygOPaglRCDgjAzjvaT8dw5rlOa5UoPKPJhTGlgPog0uy5moA/BxM3+hR3fawEf
	knPuPCwBRq0PYQYcR/x8tvOSCdG6ul58orlN05Q1Tpbyc8t2MPkVzr0nVeMeCPiCZ4owvQuxJk2Pw
	b+GYAOGmAOLm+c1tLLLzSBbkr/K0prRNr9a8z7hNCHRCGRuOj46u7N3PD3HTQ/8L3wh9cYkrBxRqF
	plI9Wvj0dsdcqRXKKhBBZ5Sn2vmY8EyuK5/w==;
Received: from mail-oi1-f174.google.com ([209.85.167.174]:56575)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t6aKo-0008CL-Ni
	for netdev@vger.kernel.org; Thu, 31 Oct 2024 11:55:55 -0700
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e604425aa0so710374b6e.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 11:55:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNxN34+9DmnCbQcqsVFlIm9x1etbu/VhK1DG6TZEbwUy36taLG
	wWWURGpJeRb7G0TtWHa8r2wp2vP8ToQr15+cJdfE0myAPjyqDVVCHAaLBvbGgtpOVqANpljrqGh
	t6vvwg7ZoAx6UFbktgeNQf5DpKCw=
X-Google-Smtp-Source: AGHT+IE2Eds3O1rkMucr20ns2iHZjj78g/DTfZwLVYaDmH+9jgQMTn3vWtr2WJY+vGZbUyQO4df3+2Sz2ZjqMnXT0UI=
X-Received: by 2002:a05:6808:158f:b0:3e6:2772:2a4b with SMTP id
 5614622812f47-3e638452da8mr20097815b6e.9.1730400954120; Thu, 31 Oct 2024
 11:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-11-ouster@cs.stanford.edu>
 <94840d1d-f051-4c07-8262-a17f0d5ce300@gmail.com>
In-Reply-To: <94840d1d-f051-4c07-8262-a17f0d5ce300@gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 31 Oct 2024 11:55:19 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyiG5CkYgmAMigp01NKyUqnDzJCY__U+Z+EHx917AeBTw@mail.gmail.com>
Message-ID: <CAGXJAmyiG5CkYgmAMigp01NKyUqnDzJCY__U+Z+EHx917AeBTw@mail.gmail.com>
Subject: Re: [PATCH net-next 10/12] net: homa: create homa_timer.c
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: a11a15d02c0ec4233875b3872b0caebb

On Wed, Oct 30, 2024 at 12:02=E2=80=AFPM Eric Dumazet <eric.dumazet@gmail.c=
om> wrote:
> ...
> > +                     if (rpc_count >=3D 10) {
> > +                             /* Give other kernel threads a chance to =
run
> > +                              * on this core. Must release the RCU rea=
d lock
> > +                              * while doing this.
> > +                              */
> > +                             rcu_read_unlock();
> > +                             schedule();
>
> This is unsafe. homa_socktab_next() will access possibly freed data.

Yikes; you're right. When I added the self-preemption code I forgot
that RCU not only keeps sockets from being deleted, but it also keeps
the hash table link structure from changing out from underneath scans.

I have implemented a fix (making socket scans work even in the face of
socket deletion), which will be in the next version of the patch
series. Thanks for catching this.

-John-

