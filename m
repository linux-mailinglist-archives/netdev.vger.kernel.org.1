Return-Path: <netdev+bounces-210844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA64B15146
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D0418A39D8
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE16A296158;
	Tue, 29 Jul 2025 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2kaatgR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2A298CC5
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806320; cv=none; b=WU+lIEs+DgIJrHmix3WIcyzE6WrdNRZn0N3LRvqUwIXL/yJz2nQUlenaG8dCn/sNpTqyQvIC+Gh/YMtcyYDfB/JSyrO6nNmomS0kXroJF4zJVQaflGsDZgijSNIjd2r5ktwJCflcmdTtIri8ejvf0mQgjcaGrA+l2cSpoREjmAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806320; c=relaxed/simple;
	bh=sO5yxEGqWVpvFWQ3GwceqAkG4feRNTHp6Orppu0BuGA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pjELpwuoahjX6Y5ZcX88W2nVosNgTvRvmPQHhCXdbItL6O86WyOa/1QnxGV9JFMBvi2Y4M3knH/77V1yzOD8FlC+RrNeNS0bvMkFLk7EE3QCPkGy7y2rr5Txu1sN8/achE8YZP8naGgGx7p6NdUwxWuOCGQxcFKj8j7CEGQWo7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2kaatgR; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71a39f93879so737437b3.0
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753806318; x=1754411118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93jkiS+2rgwbCaCqDt/VUhR+5ZEs0rjpjtCcztyAaus=;
        b=R2kaatgR1+wKkGmiJj1F51kAxn4WFcmnOvIH751jC1mxL4U+lrhWwcklID8EdGGN+c
         95tdCiUPq70Z1puB+JwvfXFajUYtJBrd0kgMbU6kirEYTsaAYA13nvX/UKtyuQjNt1kI
         +LxrdLfm0gHirzjXC9Z12X9RLmlbi9YtnFDzsusoLXl5lECSuMqzU5VW4wEzNa/fGQLC
         pxhUirbbBxKP+LiM7wAGDznW2urHMtk2nLKgtFSqxHnztWZ9lMtaad0sEI3kNhdV16yy
         lPF0J/c32prDCmQZdDWws0WgstztKFXf2vyRTqSOKVi939saAj+3AQ5kB8oQmazK4z8P
         Wrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806318; x=1754411118;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=93jkiS+2rgwbCaCqDt/VUhR+5ZEs0rjpjtCcztyAaus=;
        b=ZYJY+4Zlr2Z7i7L+vFqe7UI2sIpBNcpwXJLPxSf71QJxGC/FTu+aEaJtUL2q4TQDOE
         yf+cxrqhrG/y8d2bZ+4oe8F1nmhbC394xbP1T+pbfjONXl1DKszfltl80tK2Jk3+utQe
         cTR7N0xICpps22aU952q0AdfrPE+YqIfOIdictdpGyjn3M1yFt592c6/K2JtcNikJDwd
         TUgOFbL2w8tvBRxykdVGCslBqVffX2zuf1IaOn7bPOBwz0+X2m5IuRtDX+VXB20VsJFU
         TBPTglwSN/zgm77lTzov44SdRwakY8cQDQTasvFG9KF/iNJJwKYBxvopucZiyIFLvBXE
         wVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGmn5jJ4l0En4FJTOErttYBDwCBWfTnFMffZoEri2ukleD+G1vl+e0ONF3yzG5U83zpIv0Gy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4j4xZMT/udKQmL2tLXa3crhG0EcVTih+dWWqLMjj4O4oDp2i
	hs4BMi/sMKRWHtqDZtnxPQpRwL+czmblcrwrlWGaSDjsjFHRRWVNs5gL
X-Gm-Gg: ASbGnctqfFbzP0jaTgSj3v4IKoehO3q/xUr88fFSfeyc0/Ot/c5J9ymPAOoyNFw630F
	Wtm5xBQxSqgzH9GyQKQSTOZr4Xgwh1pMDqam3bZVnuubnrdgikHmg7jSb+rFuQvYDXVpnzsleTi
	hZ3m9KcgLbAzSeFOpDpq7ocgD2z395FqWIWJsTSWXDiN0cYYjtaj3RpgFdDUnXxLOQp0AskClma
	xOFzbyGn2D0fqYUcQoQO8dkHMk2RlftcaDkM0Pl0ny2doLbSt9VmtGjBdZcAvyu697MCZzmyJWx
	CLI5V9b6Aitr1r7apouoaqWbilmNXZi+Bl1kwHjuCtPjrtl6Ss0WkgLNIO6YJDd9F1aDt9m3tGS
	vpVswmMGwNQRA5Vj41km6DMcahIAasekQmQ0pYdyHWqOpo51SEDIfCn0FN8qpX6gN8p/k0Q==
X-Google-Smtp-Source: AGHT+IHR6YYNQ6+Q76EJbUQhH0STxiazWjPcoh4LKghlxOTk3mONRJQYPsbj6fBkc771oysbxuG8/Q==
X-Received: by 2002:a05:690c:7447:b0:71a:8c1:fc4 with SMTP id 00721157ae682-71a4741976dmr2496417b3.2.1753806318131;
        Tue, 29 Jul 2025 09:25:18 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719f23e076fsm18712837b3.77.2025.07.29.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:25:15 -0700 (PDT)
Date: Tue, 29 Jul 2025 12:25:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 quic_kapandey@quicinc.com, 
 quic_subashab@quicinc.com
Message-ID: <6888f5eb491ac_1676002946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iLXLZGvuDhmTJV19A4jBpYGaAYp3hh3kjDUaDDZJqDLKw@mail.gmail.com>
References: <20250729114251.GA2193@hu-sharathv-hyd.qualcomm.com>
 <6888d4d07c92c_15cf79294cb@willemb.c.googlers.com.notmuch>
 <b6beefcf-7525-4c70-9883-4ab8c8ba38ed@quicinc.com>
 <6888f2c11bd24_16648b29465@willemb.c.googlers.com.notmuch>
 <CANn89iLXLZGvuDhmTJV19A4jBpYGaAYp3hh3kjDUaDDZJqDLKw@mail.gmail.com>
Subject: Re: [PATCH v2] net: Add locking to protect skb->dev access in
 ip_output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Tue, Jul 29, 2025 at 9:11=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Sharath Chandra Vurukala wrote:
> >
> > > >> +  rcu_read_lock();
> >
> > How do we know that all paths taken from here are safe to be run
> > inside an rcu readside critical section btw?
> =

> This is totally safe ;)

I trust that it is. It's just not immediately obvious to me why.

__dev_queue_xmit_nit calls rcu_read_lock_bh, so the safety of anything
downstream is clear.

But do all protocol stacks do this?

I see that TCP does, through __ip_queue_xmit. So that means all
code downstream of that, including all the modular netfilter code
already has to be safe indeed. That should suffice.

I started by looking at the UDP path and see no equivalent
rcu_read_lock call in that path however.

