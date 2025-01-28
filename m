Return-Path: <netdev+bounces-161348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC25DA20CAF
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140761881BD4
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137CF1AF0D3;
	Tue, 28 Jan 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNY9utX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031342AA3
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077056; cv=none; b=ClIcUbLEznuMSVjl7zFuAnsGkNeiRUb1A1UR+IRc7FWK0aIqH9jFc+/6WNi3rksrRAEKhoiK2lNo1eMIbnD9SY9Z9zO+SYU/SrY+JFw3Sd6MZruMFpqId8SLHAtdpZQszgixS+/w+xNVlPigxHnp6+gc7k4OhcyFRrNvZl14aY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077056; c=relaxed/simple;
	bh=Bw89HtuIQ0wO/Ipyv4W2kneT9gGZL/ixN5g4aadKjc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzvJffrAMKpZLlu5ju4Mc3QBfis/1LX4drKJxRC1SgxNRUeeuHX3zOz4h5uwLY0c8VlNogvCdrYhGNApMzWrqG7D3fTE9JnIfnmo9kz7kKTXdgL1k/4gHaXk496sQIqQowDd+zfxCBRx6Guv09iffCHWiWLTGiF43V22JeJiW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNY9utX4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so8245281a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 07:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738077052; x=1738681852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw89HtuIQ0wO/Ipyv4W2kneT9gGZL/ixN5g4aadKjc4=;
        b=sNY9utX4uAbwy3xlmKkaCW1g2bvAmBnNDevGQGa8kmPWtm0/xoSGuUudl0sY/vzcqL
         21d18Xy+WVGz7K7GCV8hUiKUUtIX2wI6v30rVV33bfwQubuHmwAqLVjbFLPvYJJ54CqO
         fo5/AnvK2JaF91FS8lOtgs/WDflUrzsPuc1Tqf9q97nSSN7/iR4Vp4cKKfhkrJPsHksE
         ZeggzD335ro3gAO/2BAzhOxS6pH7ywK5oNkU6shXi8Wf2fd+XCqYqbEmoAHalj/7i8DH
         fBk1D5nL0uKpdMt9j7MgrUgckaGj+GjsPMpPb/P4mocH6In0sUodXiy6gkO5shTr1G+p
         xV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738077052; x=1738681852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bw89HtuIQ0wO/Ipyv4W2kneT9gGZL/ixN5g4aadKjc4=;
        b=BCr2VWx+g/7IyEHQkLaJdHbDsoLYbeWrTaG2vjkhTMNINiY+xGEzGrG/5pdfAy709q
         hWFHYmsz61/WSFmcivRMmiPalctllLKqo2wQ1DbHCBdcBTh9sQGH9ybxl9uzR6tORoZg
         EfucFqkYU9pLAWDphIOGc3cCzB01XLgx37oPr9M5Zm+I+bBnq/It/BI7sRfqAmL6do6B
         jOKbH4WVo4RTb2YQiwc+Lapnl5HpF4XXRFj4KaKNaMkWxmpb6Ahkn0/wsvdiqdcz7UwW
         XKfjTd4rZOmkOS0KtxWFSB4FrCaUmPjZgkxU2WOgy5dDtrOW98rz8O+rfx4uPAoLymGx
         nIBA==
X-Forwarded-Encrypted: i=1; AJvYcCW2v36i9kLh9XbK66hNeY3YeHuC3IV7CyqXH+dqqt3nqAlAVtA+otct+qGwB+MldJdNRJvvueI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJizZ1IMMhLppAHWOnxqQAVTBBYGrquvUgqM5LNvxjqwsafzUz
	SkEmv89bceeMUeS6M3yewWcC/euTtFhFNMjx6gyj7fXd6BLhPIvQpu4q0REkeqUht/iIses/Qnf
	85NnFUoIBgf92D27zHYaA837K2KT0nr/VyW9w
X-Gm-Gg: ASbGnct/yP0L+ME989w+/qdni3JWbybB2adi4q/i4sVIXnE0a4/3tkxwErAdpuN7nXJ
	bA9IJUjEswEzpTjI8s7zRK4Mek4RnP8y1E6sj9P9rAzJLAj9NptZ7PuTgY7o4N0HIFDMl2HeF
X-Google-Smtp-Source: AGHT+IGQ8jLojsjdagZzkcKnBVUowZnPpmrgO05eF1UXGjQxKoUpNazyZ+HCMSLDT7Pl91ZK9+5SPK6H8j2To/Yub/I=
X-Received: by 2002:a05:6402:4313:b0:5db:f5e9:6760 with SMTP id
 4fb4d7f45d1cf-5dbf5e96a10mr61817747a12.2.1738077052308; Tue, 28 Jan 2025
 07:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115185937.1324-1-ouster@cs.stanford.edu> <20250115185937.1324-8-ouster@cs.stanford.edu>
 <028f492f-41db-4c70-9527-cf0db03da4df@redhat.com> <CAGXJAmxqoPw8iTH0Bt4z5V2feM8rekDDOJapek4eyMuLJhUAtA@mail.gmail.com>
In-Reply-To: <CAGXJAmxqoPw8iTH0Bt4z5V2feM8rekDDOJapek4eyMuLJhUAtA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Jan 2025 16:10:41 +0100
X-Gm-Features: AWEUYZlgE67nQ4ufyWu895Uqjsf0cHikLtk8CaFOxYhNwal3GRUvXG0wkKMJvMo
Message-ID: <CANn89iJnhJCYE62jfpXesQhn-XrZJfPe3DGohH0+x5tpVC68yA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/12] net: homa: create homa_sock.h and homa_sock.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 1:41=E2=80=AFAM John Ousterhout <ouster@cs.stanford=
.edu> wrote:

> > The only caller for this function so far is not under RCU lock: you
> > should see a splat here if you build and run this code with:
> >
> > CONFIG_LOCKDEP=3Dy
> >
> > (which in turn is highly encouraged)
>
> Strange... I have had CONFIG_LOCKDEP enabled for a while now, but for
> some reason I didn't see a flag for that. In any case, all of the
> callers to homa_socktab_next now hold the RCU lock (I fixed this
> during my scan of RCU usage in response to one of your earlier
> messages for this patch series).

The proper config name is CONFIG_PROVE_LOCKING

CONFIG_PROVE_LOCKING=3Dy

While are it, also add

CONFIG_PROVE_RCU_LIST=3Dy
CONFIG_RCU_EXPERT=3Dy

