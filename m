Return-Path: <netdev+bounces-194824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D3ACCC9C
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3A41891370
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E96C1C84CB;
	Tue,  3 Jun 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHSs+hbs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A143D3B8
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973752; cv=none; b=kOjh2dQu2g8YI9AKUB/as0e164BZZi62msncqIfApopl9fscB1tDKRZTZ0VCOJj6zmJKGr2EL8Z5bzaruLIhbF1kpk7SVpKc1wzfFY29L60SgDwQYfi81RENWatZsCKzl/HIv0dAnVIt38+4JNaH9fpBOWyi9i2gPivIyiydXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973752; c=relaxed/simple;
	bh=lxbHwT89FX0z6KinlP67fsFpath/+Mc4Kx0XnmT7D+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9z+XxhstWMU0dHFRZ82/Oez5XLmHKz8VoV5UBnrBv5seKusmYeUWji2MjARVvMRo1Qw1YW0Z3S0XA3EJAPJhAWjE2xAnsjBrA2sHkKrv0akpbNnlkA3iQ46+mZaqDvTOyOXUejOm2oVj0eFcZmqVJRCdejcnDpZbtrpenjPew8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dHSs+hbs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a433f52485so53991cf.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748973750; x=1749578550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxbHwT89FX0z6KinlP67fsFpath/+Mc4Kx0XnmT7D+o=;
        b=dHSs+hbsYzmGbAXtxaMGKVVggAooZEUuWawjbljTgc6g7XpyRttaRbG7dQVcQvM99N
         pWTj07q/HesjpS6LuQPTVsUQiD6ZYtuZI7L2XsA1IRLBKdHTsUqTxSGp09zsIJYRmwYe
         ZbgagaFQZD0Eqt1qnZswHzD5xbzQ+I2JV7bMr2HF266RzCh26aCJgERSMp4GZ5lVSEHV
         uk2BrghLVhd68HNlx1BRES1589fPHH0uwRvVKHwE6TmEeqvPCl7obwYFg6efH5ZAzuQ/
         4QjNl7ky++J7cg+1m4fa7vSLam1QJO8AlFD7fGSHJ5N7G9a1OzUfWgV1qEt4OcMzJnPf
         bbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748973750; x=1749578550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxbHwT89FX0z6KinlP67fsFpath/+Mc4Kx0XnmT7D+o=;
        b=aLcO8e7PKmWnkKwE0r+Rb3W9GI4a7aDJD1VhMVsfyb+ReDQ1u6K1ykdd76S6ubjPsU
         USCIzE3zWVdFzK86GrAVlZG6XdpghCG32UdZoyR3U3jWkjC7yy31JuQMeQjpEXDq6GUE
         i1AD5SCIaP7GsnrMUr0Sjke+Y16owBHAAzbsRvAma7IAyVX5PuSKH8J4qGFPLBA3tSY8
         qsui828UzlZsBjsIncSKM/uATwH2sZIN3zz3n7OEuMzCk5QWvlzRTWm8MMO/lLCQTwjW
         8O90mjFIegxLv2bNCynMlhGrArlqUdOJTiVAz4uuT/PQEQzuNk5pzQ94VmJ/I6WnnztQ
         qKSg==
X-Forwarded-Encrypted: i=1; AJvYcCX06pjABZmA8zQSqnvuSMeyPcMOzqoWfDE/Mb4LyRwDzCRXLYONVGSbrBUZxU/UGWDcwceEB1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWDIKuycnFEczvcHjCKz0cd+lJFZWZp5WnMbYtdqQsGCkesEZ
	B+SF4czmDo5fvJ6tLRo1A+eQiGWjBkQE0ohMCI8sq14Hd9TVLzB+wiVpglgSHAyIyhrV60DvQVP
	OV4AU6CUjSY3O2T9+2rs+oKR/Zy/6b/5Hd5OBI4gt
X-Gm-Gg: ASbGncumy67epE6od+EFLNjPaFLZQuwQ5xCvNH8A2SBKIqN3A2G5gfnJDShDH2s5S5j
	2zSBQ+67PepY72aoAAz4KLkLyEgosAqeVTl/rae99gaNXPSK07lIDaEW2pZp7Nu1quDTDB+fTve
	2eCv6zElvI4WuBNUgDONRywR0Hc7JgNmCSWKPAvW/9XbYEXYhDKJfddzjM1pBV6urCSsSc28v9z
	KjnMfEu+Hg=
X-Google-Smtp-Source: AGHT+IFWo0uebQD7O3vcbTkA5s8t/G6RW4hquWATsZdfasRC+XMVOD0P/z1omQuoCPaDsmXd89sKt/OjC23eBGfsbrQ=
X-Received: by 2002:a05:622a:488a:b0:49b:72e2:4058 with SMTP id
 d75a77b69052e-4a5a53ca761mr11511cf.11.1748973749501; Tue, 03 Jun 2025
 11:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601193428.3388418-1-alok.a.tiwari@oracle.com>
 <CAHS8izOqWWdsEheAFSwOtzPM98ZudP7gKZMECWUhcU1NCLnwHA@mail.gmail.com>
 <cc05cbf5-0b59-4442-9585-9658d67f9059@oracle.com> <bf4f1e06-f692-43bf-9261-30585a1427d7@oracle.com>
 <CANn89iJS9UNvotxXx7f920-OnxLnJ2CjWSUtvaioOMqGKNJdRg@mail.gmail.com>
 <CANH7hM5O7aq=bMybUqgMf5MxgAZm29RvCTO_oSOfAn1efZnKhg@mail.gmail.com>
 <abb065ab-1923-4154-8b79-f47a86a3d30e@oracle.com> <b8d181e9-d818-4cf4-b470-a54b6df763a4@redhat.com>
In-Reply-To: <b8d181e9-d818-4cf4-b470-a54b6df763a4@redhat.com>
From: Bailey Forrest <bcf@google.com>
Date: Tue, 3 Jun 2025 11:02:18 -0700
X-Gm-Features: AX0GCFvwHb5Lvh_26htHBAviwi6fz_uyPaSQ1gsaqfUjJJHI7tGGz3kpr2lLVIs
Message-ID: <CANH7hM6qyU4+uEB06FSAiQyitQ8jyuBXzzTD0QkoH7vYca71mw@mail.gmail.com>
Subject: Re: [PATCH] gve: add missing NULL check for gve_alloc_pending_packet()
 in TX DQO
To: Paolo Abeni <pabeni@redhat.com>
Cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, Eric Dumazet <edumazet@google.com>, 
	Mina Almasry <almasrymina@google.com>, joshwash@google.com, willemb@google.com, 
	pkaligineedi@google.com, kuba@kernel.org, jeroendb@google.com, 
	hramamurthy@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
> IMHO it's indeed confusing that the same condition is checked in
> gve_alloc_pending_packet() and ignored by gve_tx_add_skb_dqo().
>
> Even gve_alloc_pending_packet() is only called after the
> gve_maybe_stop_tx_dqo().
>
> Either always ignore the NULL condition it in both places (possibly with
> a comment) or always check it.

It's probably not harmful to go ahead with this patch, I agree this
will make it easier for readers.

My point was it's not technically a bug, so it doesn't need (Fixes ...)

If we do make this change we can now remove the comment on gve_tx_add_skb_d=
qo()

 * Before this function is called, the caller must ensure
 * gve_has_pending_packet(tx) returns true.
 */

Reviewed-by: Bailey Forrest <bcf@google.com>

