Return-Path: <netdev+bounces-239826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E80AFC6CA98
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F08CE4E204E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EDA2EC579;
	Wed, 19 Nov 2025 03:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyA899Ec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48B298CA7
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763524693; cv=none; b=qoFdAh99jBdMTQM7poBoIpIWMyoV9Mi/TyyQND90j5507m16Y/5yODQ65iEebK8EovoVDv+mEDjPrzG/ChlwE1sWa9jxKCO+DRZSXOopQhIiwntFSuRwiT/ORFckvBXycEOwbgFBjbUZFn3ECj8bihV0nnYl3H1ER0s4in2XAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763524693; c=relaxed/simple;
	bh=PI3QKLL1UFflRMFBd9gNh7xeqS0cnp6FXnZ/gxAlTuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaalwbjBuihUmBgWI3L9+u1gA+eo78Xb1y4PyW7kw1jAA/V2SOZXi1a/0OWQXYjeXj8cRyko7X2s8aqDLtVWu/RNpvQ+H1V3M0mtAUrYIRpZnFpdnbjyosHLctWnN0Opd+HKOUxm5kNVNR4atouixn4/bB2ZMtV1PxLqA80jkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyA899Ec; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so8406845a12.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 19:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763524690; x=1764129490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PI3QKLL1UFflRMFBd9gNh7xeqS0cnp6FXnZ/gxAlTuI=;
        b=iyA899Ecjt4iDeTAl7ahAB5SI8oWexpKYqt7JHLGBr8PC5gtDNoGP4oT9bLH4S+sJk
         ABDNrdtESPEVCGxoc41QUngckXvJB4IQz1ttzjlzYRsRplc0KWUtjujhokQMCFhC8V68
         jN0CBA+sxzjucRD2lazJ30RxN4RITVS4TKMNGCMzprXWaUcRufId5YKaH7vyDF1f57Np
         gN1ZugUcJdMwJsxAyEYiWtgqxLvnY+KmQn6xwEHgIULqoLbghjDKOopV+BI8ZNBnQ0LV
         Y7a2AzwQJrCf3Te4CI8TT2mcEvs9/AoIoBED16i1DKlIktEBDlVaHtrHspA9VbRKVVJN
         dAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763524690; x=1764129490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI3QKLL1UFflRMFBd9gNh7xeqS0cnp6FXnZ/gxAlTuI=;
        b=NpuwLOralVDzv7Q0tii91AD6+r9orbMOt/wF5ihke/upVTvtQju8CR7DzLjweMvmUd
         of4/HUpH8Au0K+zOBpiEtvA9LXo2SwPhmpj90RSwODrUfQxNyuXFG3xKiFdCQTixQFEC
         sXw2IMN/vHvWErJ276hJ6DDW2iMIwLpiDgEod1R9PxtYfpg9I0rOCxQyk+naGDEDZuTP
         XqPXnm20akHgy4b5vxgd+Lz7aZuM+ui/6ywkVaWAcdSNEJwLK3dkMHkfsCuxyjqoLxfs
         WHygUoj0RfUI3CQ0pDzHGHOtLj9ja0PI6I3AsBXRww1jtnKHeozfgHbhEOdVuQbQ1/Hn
         bhYw==
X-Forwarded-Encrypted: i=1; AJvYcCVMkrNmQFTbCyQIIgNeoAYO6VT4s3OGbGVK7eB7XGG7u3Mi5zVZTApS0w/6n4uxSXQeGgch05A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7a+NzeU1resvtbULrKlidzPnmcKntuDuAqBJ+lRKQtdyHKwqU
	QRUANcbMUleoOodqdG/gOB5++d5pWzefB1Bdni44NBCiQqg9QziDep1+n1c/88P+31gjjGQGROJ
	XjSGVvjS/lvaiACaPJ3bXdiAz7UcZYQo=
X-Gm-Gg: ASbGnctYNrsBovOLgZ+e3ZCYiGX8zhewUK1C0N2az7kUT9PtxjG9yXhsaygno/abpVa
	WS/KveztI+dT//uuOlSGT10fCcQtVkL39F5RkJs0/XPv8tqGKCKSFd3bTBJpP+m8334vuXSk0LT
	QhCtpYphMm8HRugAU+rG4AjRpJUOuSI6G1myW9+sO2Vtcv4WFPDo8vsPmtLqU9mc0nAQq+cN5D1
	5IwU3qa0X6nxuWrKPbZwQTy8i1S89zUtM5D5Gz4+uKCyPItELO+mYWNXqLisCTRgkUPstvEyPWC
	l+xLvQ==
X-Google-Smtp-Source: AGHT+IG3PwSV/TBqcgYiQTrXM8pDMO5dg/Jf6yZQNxRWinFCJb2bV92dB5BAFrlKAhEykr/231k5fj1ur5+oNuf4Gz4=
X-Received: by 2002:a05:6402:52d5:b0:643:c8b:8d30 with SMTP id
 4fb4d7f45d1cf-64350eac57bmr15010389a12.30.1763524690169; Tue, 18 Nov 2025
 19:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
 <CAPrAcgNSqdo_d2WWG25YBDjFzsE6RR63CBLs9aMwXd8DGiKRew@mail.gmail.com> <20251118105047.20788ed9@kernel.org>
In-Reply-To: <20251118105047.20788ed9@kernel.org>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Wed, 19 Nov 2025 09:27:58 +0530
X-Gm-Features: AWmQ_blCdRe1tCw5lI8xL4ehntzBrd_SGHl4OQqj-ctDdgKE4rWDvz00iLoDe1Q
Message-ID: <CAPrAcgOBa5Q3k5r=G4qixzWRuvK+PEinj9sGVf-nxWYon4BkpA@mail.gmail.com>
Subject: Re: [RFT net-next v4 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, sdf@fomichev.me, 
	kuniyu@google.com, skhawaja@google.com, aleksander.lobakin@intel.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 00:20, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Broken as in patch titles or broken as in it crashes the kernel?
> Both are true.
Yeah, I will fix both

> Just to be safe "as soon as possible" hopefully
> takes into account our "no reposts within 24h" rule.
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
Yes, It does

> Also I'm not sure what you mean by RFT, doubt anyone will test this
> for you, and you're modifying virtio which you should be able to test
> yourself.. RFC or PATCH is the choice.

Just to be clear, would testing packet flow with all the possible mode
combinations
under heavy traffic be sufficient and exhaustive? I think this should
be PATCH once
I sort everything out

