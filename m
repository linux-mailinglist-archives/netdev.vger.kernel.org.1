Return-Path: <netdev+bounces-178442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 020FDA77082
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17F216318A
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FEF21CA16;
	Mon, 31 Mar 2025 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kd3YYJzc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8D3C47B
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743458307; cv=none; b=BiYiWExeGnDZeA8x4VRgqmoZKCoM8hbvLOEO9+0cQxrQHZrKZOfP0/fMfmuN+hvYAxcqXPQbbj6RodsFloftc9mV5xI+sEWYGFGbVreoFZcG84jLeKw/1EiXS5qy+EBLkWVj4OR/EcZgdnXnAkGrSgWwPR3TJt9hwrBVKUSMsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743458307; c=relaxed/simple;
	bh=1x9X1dVh7AZkYtwX2kTaY8rwU5WLQKpH/I/zt8xd/Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBuU+auu+Yi8L/cTaeiKbHh888cuzxm5LkONdc5h/0cwj6La+EJGH7X0BdMJyDZcAFJQncMkX4qu9awDMEcKU6xPYJH79bRG1KE3PjQgf38yuCRrXc/jkwZAb8almV38M9xJKnbK2tK4Pi/FNuXtgJ22GNOcukI1CRCMsMGwcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kd3YYJzc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ee2e154a35so3787a12.0
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743458304; x=1744063104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1x9X1dVh7AZkYtwX2kTaY8rwU5WLQKpH/I/zt8xd/Zw=;
        b=Kd3YYJzc8WNloEOVpJcnINQ5aMJqVbnopDLup2h9Xtd/MKpTi+iHpFB1aYM1D9nzmr
         ZcS+f5L81wuLkt3p3G2PYtQeohZAVLMaVIf72FZqHR4SZK2lylxXQBbiNx5GzelTD+h0
         sRiKblE/VzJPM6Sq/U8J/GJGLKQxUy8rWYA0S8w9YmBeIaKRJt3/tk3zo8vAO7heX51e
         WXTmWY1cKyLkac03hMeELiREqNWBbGUG1djeEH9T2i0MSHk8YOJxZJMuJ9l3YpeT/MBG
         IFcllsG8UAMMrepyY2OQ7ofXdQOagjH+YwEGNAmp0F/KsWe5ja3NBO07F5c1kZRxdYPh
         H1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743458304; x=1744063104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1x9X1dVh7AZkYtwX2kTaY8rwU5WLQKpH/I/zt8xd/Zw=;
        b=rQaVVVNqEuOz7l/E6I0XvX9stiMc/XyRZqH0z/4SsnkjHOMCtPXkX3cDzBMU7NmRt/
         DqKxkyPtRLxSlw16QV2yKh0o5vKfiyvquYG0soP4HNrVBs/yqmyqKtyFVt4r2F7qilou
         z145AoofUlTxIJAliUJ8HEL0TZ0mK/lLz7mCW4hBG94t7otdOg6Knk6CIZpXQD/QAJT8
         7knmtbw+dLOAzqFE3867e2NQrCahvHKijPgeu+5HOACudj5WMApjNZyk+Q2i5x0FkaqH
         96go8EWPda8u/gd7cKU5etubdHEfpwlNCR0aGG3WD+MMv3j0la3E82K/fsAPI7PkuF3S
         S0Vg==
X-Gm-Message-State: AOJu0Yxep74VedARG+5owhBjCQQO9CjLen+9ovSu5D3bK4pkVeOemvuR
	oawEtoy9IIa69V++yUlCa6aZdbfREKFKTNi95xtdj+LaQX9GGqaZ3HLkhPpz4+ZxDwCxHwPhXnQ
	uRTkabKL/CgCOxmiL6F+4jfMZzJI+Pd8yurX9KIUD3qy2fCUhoElZ
X-Gm-Gg: ASbGncuKbJLobxU8w3wy26rHPXV4tmPypIJTH6mTgcThfkdmv7vIT+eWo2Bo0+5hIS2
	yKHE+JGPAoK4kNLE9W4dq1iwYLEmq+l/zrSJ2jjlzDuu04+6XaRpArqkW+RG5QZXmutZU1AiY2O
	efAWwmZZS8+uhu07cAAiBJ4zgBjjTd3B8D4IGH+iBesb4BaTLzUs8EiLFbUezSzM/KkGeekw==
X-Google-Smtp-Source: AGHT+IH9AxOybL1BP6eidjwU+1emQ5H/MDGmo8IJ2VJ2pIHX88mLFKEuGHB+srleq8Dt/81bvptsUs9shiGmuv+HypA=
X-Received: by 2002:a50:d692:0:b0:5dc:5ae8:7e1 with SMTP id
 4fb4d7f45d1cf-5f02b1fda43mr38780a12.6.1743458304133; Mon, 31 Mar 2025
 14:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
 <c53cee32-02c0-4c5a-a57d-910b12e73afd@linux.dev> <CADKFtnT+c2XY96NCTCf7qpptq3PKNrkedQt68+-gvD9LK-tBVQ@mail.gmail.com>
 <8910c6a2-9a57-4eae-826b-2c81dbd9150d@linux.dev>
In-Reply-To: <8910c6a2-9a57-4eae-826b-2c81dbd9150d@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Mon, 31 Mar 2025 14:58:12 -0700
X-Gm-Features: AQ5f1JqGTWlz2nbx5TV6HnIlEF08jJwUxmc4fzaJxhEd-YdFMFTECzTTliKlt84
Message-ID: <CADKFtnRa71WH4WC5tipGAAWK9hiqWcA85AT_jz_L4kcGzorh7Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket iterators
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

> > array scanning could be slow, but since changes to a bucket should be
> > rare, one optimization could be to only compare to the saved socket
> > cookies if the bucket has changed since it was last seen. I think
> > saving and checking the head, tail, and size of the bucket's linked
> > list should be sufficient for this?
>
> Not sure if head, tail, and size stay the same is enough to imply the bucket('s
> linked list) has not changed. I think tcp may be ok since I currently don't see
> a way to re-bind() a bind()-ed socket without close()-ing it. I don't know about
> the connected UDP...etc.

Yeah, forget about the head/tail/size thing. I think I was still
waking up when I typed this :). A linear scan through the cookie list
should be enough as you say.

> I think udp should be easier to begin with for PoC.

Ack, sg. I'll start with UDP iterators.

-Jordan

