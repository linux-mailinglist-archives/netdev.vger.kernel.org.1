Return-Path: <netdev+bounces-85226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F0D899D34
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9BA1F2272A
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AFF13C681;
	Fri,  5 Apr 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYttEdZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22937143
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320829; cv=none; b=cMEabBsQQ4r2WWaJDByo//uhu8+9tHYwbt7FdCTMo61j4zPS07UqFa7+XVKPI7THLvbv8HIRzw71hbJVIQk+gIjIwOlNYANzk7PeQ7tf/Pyo5rQKMenTMZ2vOFduqcb55vEE8awCtoAa/WrjmK4Sp+wRsNZ4D7v3KywW1SlXTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320829; c=relaxed/simple;
	bh=R6+BhSwTJjln4WnQCjacr5poEUTqt3nEa/5dq+LBvU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwKvh6biMS1vDn0hpjzpcFh9QGslgOgFg9KNqmB2JTJHzner+pcEDLs2CuaTz5r8cHZJwwRJEPFCxmJGmVh/kSQHj/4PrhE+Iu8gLi38Ni2q3q5dTFAGMbwU2Ojng4BR/9moez4Jx6jDbgpvR6ZK+XcAJrii+JMQ+Uki38RZ1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYttEdZ3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e0430f714so9874a12.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712320826; x=1712925626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6+BhSwTJjln4WnQCjacr5poEUTqt3nEa/5dq+LBvU0=;
        b=NYttEdZ32zsAp/rSBEOJdtYm/9nmoGEbDZyelEhIo0bIiEXt6wbsiF2YEXYy1AjB1p
         IHqc6XWaeA7bw1CioYNBndJkBC0YBMMrd8mlTv9bw4zu+cmnr6LNJgolmbwY3Wad0gvn
         oe/4aILI2OCloDixKMIZLXx1Ekq7+1s4/xQJVqbLPPgobuLVc0qBm+Kf7sdliLyGa/70
         aJWJcV92Fz6V/QVAYvsFvuHTmGFKRHHXJnkrNVKAYtwqfvqyhYKirqcoA0zxgtTgKvMn
         xf5YuwsSrc5wiUjmNHEWGwcAfEupRfmal9oS5gW5iiFJdTznKQI1930GTaQS0zQzg48H
         +Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712320826; x=1712925626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6+BhSwTJjln4WnQCjacr5poEUTqt3nEa/5dq+LBvU0=;
        b=CN2+ahlPiQNfdDiRMgJ8iGwkFRFtS/1RpYc6/V1igL5atjw7nsV86PgrvpqlyVPpaO
         cBlRfyPqp8jWQWfXu8tmgtcvM4YuoAwg9A2XNNsu9B7v+qesJ3SeR4o5vZB0Af6PiAbT
         vvJ3+LcMobCdCU5OqDCG6T4DWMfZI2CFBDRTrxPGnhb3NHF/2f7bjA7yR0RGwRjITk04
         c0Ubtdq8MWvZeGyk5ZEgelzYN+1uivqWlb0ICYE4a+WcGegvLYEmqG6yKYs3WGVEcq88
         wBA09HrHTPjU0XJd3IHbIcTlg2JnYgmyXl2zu78YWUwfO7o1+tdIKZtxuE1yuYDlzNNG
         ejdw==
X-Gm-Message-State: AOJu0YzuoGxK7EYMKsCOPksPleULyM4vInQcI9moprviJlO39ZjkG8u1
	nUVh4j1/dkAFkf9sMKo2J7Jlqt2JIwnEoQVlmocf8KaeLhdByg1TAEGBLbqkho8AcpeUKQj6eWm
	fkZcG47btf3D2YE/Kg1XOK+wRQ1FR05d7g4dF
X-Google-Smtp-Source: AGHT+IHpoCLf6EhV39AEvNkBg+FRlIkoIrR2GcUaSVaO49C3YirVj2QtgxixbuPqCIbSkVPp9JYuS+bPAcx60/eDgds=
X-Received: by 2002:a05:6402:274c:b0:56e:34de:69c1 with SMTP id
 z12-20020a056402274c00b0056e34de69c1mr70366edd.4.1712320825955; Fri, 05 Apr
 2024 05:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
 <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com>
 <d475498f-f6db-476c-8c33-66c9f6685acf@gmail.com> <CANn89iKZ4_ENsdOsMECd_7Np5imhqkJGatNXfrwMrgcgrLaUjg@mail.gmail.com>
 <30882f03-0094-42c7-b459-3f240ae94f20@gmail.com>
In-Reply-To: <30882f03-0094-42c7-b459-3f240ae94f20@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 14:40:14 +0200
Message-ID: <CANn89iJRXFsrNBUz=0EWngyw6AunpTyB3ssFLGDvA7jktR3JsQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v3] net: cache for same cpu skb_attempt_defer_free
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:35=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:

> Ok, alternatively, I can make it a series adding it on top.

Sure thing, thanks.

