Return-Path: <netdev+bounces-103926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64C90A5EA
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 08:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF6E28CDD7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 06:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298AE17F36D;
	Mon, 17 Jun 2024 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaerU64D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE279D3
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605940; cv=none; b=O6gyFLkMUWmsPxjRO6lm6u7+P/XVmXY+DZh/Czvxh4QzFw9rsJ96Ne1wYlYSJNhSYpqnnwL4ocjmh4SXTx64j1Tv7SbJ27iU5JDs/zg6FWrkv5WmuityYJc8CeROl/P0TcE4zTVYQvAujXaa4MytEo6Tc2BecKdURqe5deOETqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605940; c=relaxed/simple;
	bh=KRrB/O5yQX8OPBbsQKrWwNIfyDnBh+PQCIyoFPES/Ko=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GD5w+64iDkzEs/zViaZq8vKkXDj7uvuvXrND8b2azUI4H7GP9LWLLHqvng2+wKj/SgZuTjlG1UjmuTknI0nR4WBvlZfE45suQpZ+AJpInOFX9Rka1pBx/WahAf05DmhHbgcm3NKf/ezg9elHZFxx95UIhf3KI77LkGfSkHnkWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaerU64D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718605937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRrB/O5yQX8OPBbsQKrWwNIfyDnBh+PQCIyoFPES/Ko=;
	b=DaerU64Dpx/a3vwTJf4m2NaHzNwJwx4ZoZSBqrS0PDFkt+hgROc9m8I4I3tTrZCNBG9sLh
	3dVVtiktdo6XuJ3JwtMYD+BORYWQvC/NZT+ZiJcDh441sNgrm9bAFBo+mgh/9UIWvq2+dB
	kQCa3y4Qnn5sWnNq5sy+Bws+XyLnKnI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-gMKLKQr8NySDQqtMk40_IQ-1; Mon, 17 Jun 2024 02:32:16 -0400
X-MC-Unique: gMKLKQr8NySDQqtMk40_IQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b2bee3654aso34389306d6.1
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 23:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605935; x=1719210735;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRrB/O5yQX8OPBbsQKrWwNIfyDnBh+PQCIyoFPES/Ko=;
        b=PtNqWE7bDULBVtFOss8z8TEs1RXuYf25L6Ijs0BFZvbWpOXsoHjd9cv1XwC1r1J7ZC
         jxw+pAuPliWHiUNc6+Gq5+ddKNKvOyVM5G4IQHs/ZwlLx6w74TtIjCktg56dCIhYaXxb
         ppTk+4NSneQGN7t1Z34WqEZoekwe4Y0RtkPjxetpFN3Buk5lmpyKsqwGLfQRG9gKH9Y4
         qWWdVn4yujLt3kfgRljsNHF8vqWmQEMWUlGYPtmdEeKLCCj2CmeFceGqJePdYuTZODTC
         rtTgThyKJUNSyzWacQvt0oOyQuvapL1gLb0jsrSnRdf07OCA1kuX41nKmsLYhnT+FrvL
         M9Wg==
X-Gm-Message-State: AOJu0YxktV/d6o5HK3JNp+65R6TotdCg4qLDtpSsHW+we/vT5tmnQWgL
	caGdblL6s3khisn6C7x2972ZesNpXMzKY8JSNHkqKzfb37I6uSRHilv8P+9/9gUDh4Cfv65i9Ww
	AuUtK76n6IOsNmuL2M2AK8/98HnrTQh3EdHKlq5CIc+NnrRV+8UmJa71Bk4mDzovRiHEvqa0LY3
	dpI2Rxi9guVG4NHGHp22RZjY73I91R
X-Received: by 2002:a05:6214:293:b0:6b2:a47d:8f2d with SMTP id 6a1803df08f44-6b2af2ec799mr156801576d6.24.1718605935609;
        Sun, 16 Jun 2024 23:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4tB/FFUFsmnbNdE62HLufpIEZwTTCThxc9q8czc7ntVqJ47pkFtsTVqws9cwSgSrH5BSmFGqpzcbLP5qigvs=
X-Received: by 2002:a05:6214:293:b0:6b2:a47d:8f2d with SMTP id
 6a1803df08f44-6b2af2ec799mr156801426d6.24.1718605935299; Sun, 16 Jun 2024
 23:32:15 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Jun 2024 06:32:14 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-5-amorenoz@redhat.com>
 <20240614161130.GP8447@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240614161130.GP8447@kernel.org>
Date: Mon, 17 Jun 2024 06:32:14 +0000
Message-ID: <CAG=2xmOhMMg8JDVi4x5P5F39yfG2p72kyYxDud0fcjc9VzDeLA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/9] net: psample: allow using rate as probability
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	i.maximets@ovn.org, dev@openvswitch.org, Yotam Gigi <yotam.gi@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 14, 2024 at 05:11:30PM GMT, Simon Horman wrote:
> On Mon, Jun 03, 2024 at 08:56:38PM +0200, Adrian Moreno wrote:
> > Although not explicitly documented in the psample module itself, the
> > definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
> >
> > Quoting tc-sample(8):
> > "RATE of 100 will lead to an average of one sampled packet out of every
> > 100 observed."
> >
> > With this semantics, the rates that we can express with an unsigned
> > 32-bits number are very unevenly distributed and concentrated towards
> > "sampling few packets".
> > For example, we can express a probability of 2.32E-8% but we
> > cannot express anything between 100% and 50%.
> >
> > For sampling applications that are capable of sampling a decent
> > amount of packets, this sampling rate semantics is not very useful.
> >
> > Add a new flag to the uAPI that indicates that the sampling rate is
> > expressed in scaled probability, this is:
> > - 0 is 0% probability, no packets get sampled.
> > - U32_MAX is 100% probability, all packets get sampled.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>
> Hi Adrian,
>
> Would it be possible to add appropriate documentation for
> rate - both the original ratio variant, and the new probability
> variant - somewhere?
>

Hi Simon, thanks for the suggestion. Would the uapi header be a good
place for such documentation?

> That aside, this looks good to me.
>
> ...
>


