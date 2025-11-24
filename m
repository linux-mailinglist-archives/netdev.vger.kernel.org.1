Return-Path: <netdev+bounces-241262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7C4C820CD
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9F374E6547
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2A2BE64F;
	Mon, 24 Nov 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0DI7Gcj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA072628
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008137; cv=none; b=olghLpQnxb3WSZXpbs7kQYQOR9aGNPYDCR16+NXdbQvf1qrWkHPTVwPF721b0uHkbzZTZTWR4goQEE52fKCvlYP+LVkbXwWulRjID2Hj9+Okkkg1xoYyM6fHkx09ifIsUSZXavjDtLQalKhWgPu1ln/a0SShB3Ohv6FX/9vt25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008137; c=relaxed/simple;
	bh=9OsOtu2FdRcdJ07h5ePZqFdT7LILIFGuF6mCtnACmDk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GLYzS/7SPSwjOs4IafiE081EYoeoI9b5t5hXBw5kUVSGN1UYkqpdrlYyla9hZEgjVeGu9sU//08SGdiSHfIo8ghiuQy6NG5cSqIZbqYj+tMhGjwnhkXSMYbkjYEuj8c2CeFlVWNTS3Pe1+vg0S7WgNWmXqXI09VueY1aLyKbsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0DI7Gcj; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-787c9f90eccso47554007b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764008134; x=1764612934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocgYXOVPq3H23c7s3bIbF+RIkWJqwfLZLsXUE58QTME=;
        b=F0DI7GcjN2Zh6kP52XzPrWWK6vpuf1FxNx5vvkjnRgGw8bfowb63tX768OP3OD3zfB
         fPFU86xibhiaLPmuxnbvSD7owo+a95j4I6lFfKt/ORyg2aIubCQpj5m9jYoA/TK/hNm9
         T8mUnumI0aiC+hxLcCHPuyU1Yiprx3wHYnYpqp7p4OIRnFqDpjH/Cllev1RAm866pnst
         RhU+JtGnli4K64yoMczcyeppe/FfQmsPRayxbfs+h/vWPTe8HWg2U6DFbfQV3GvH3Wbl
         V3kxzPEsAeD8JmqgWI6CyHg/1v0zrWkFw/AvrkNevhlK025GcklTuf6VD8PIAdK6U8gN
         zkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008134; x=1764612934;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocgYXOVPq3H23c7s3bIbF+RIkWJqwfLZLsXUE58QTME=;
        b=EOc6p416/NQDdCzs879VqhTlNUoIguvX2bYqrWDUAYDi/vVoSIFtDr4SSA6AiOOchU
         3LkETJGLSU3l+h4iMB/i+7cBcmmfRKCQadjuUi5p804ZEAhj82Fzdl7Ms4bGDJSuJkLg
         nmBrSHFLH1cW4DjyqLJxILfsqAMpaFglUYRMYyRfwPB+bH4tiNCDuSA6fpDpb0xb+QjJ
         YxfKrZNL8sqqWKUajayXFInkhymHBXSGUQHi8EmTv2Ht+0ccxn//Hlz68ZJ5Dwugsy9p
         UTmH93eYCyjFL0FWXhjae04lKe8knZxFkdfIXjaT+97NWBbjf6aHv8C84nb3pVibKwfV
         d/pg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Fm7j8Ce6qT13vf3M7WJ10qoswyEP5zi40MBS3limwoRA54QZFQo8km5FNs7obGZybP69toE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4x7lhjrqD3y0FS76aWwhFPHht5jHbG8LyrTq417/ADjOFvSs
	ei+5Zq6nu+ybsjUlDnCr+EuZQZ40TzvYuFfYFKlErliM8Dk7zSFm3qnt
X-Gm-Gg: ASbGncuvpDwN7FZWe1qJhEmIufArHSMqcL8U0jbsH6Z2xys/HlrkzcMDTaXPgpaKppN
	joJCcPG9X2H9Q2tXR690KBwe0b1l2OaLaHj8C/rbywwqHQLni7Q8n6W1B/YsO4qAEJ+IUCwyz0Q
	MfUdfW5xgsGRz/47sD9u0lrb2g23wY++jfbUsB0cNvDk5lX0GhdNWn+ZJYT+PYat7/rhbqA67Vx
	OpofYQNQqhuBzMUcH/uuwU0IV3HboLRL2vyQqRFZZxQEf74wpz9kIHRjsw2ylvNedi3ZbYP/R5e
	K46EovSubxbbZH31bYchKv5E6omt0PrYKgOyqMlFL179NPYby1PMzu3UFJlIHBnxn+Ivl8RQDQS
	pHMX+a87uoFOgfwUIDVbPxC2cVPYgGZCyXwdnfW8ouTB1tFgmHRuFU49bQ/1cCx5T754eLwkjeR
	RuG+ELyusHICWlsOxJGuqeSMnrEbwAnQYvZ8PJ161u/HjCeA95r1Ce/NIfAsmi8+Xml/E=
X-Google-Smtp-Source: AGHT+IHKw38JYHIxZFzyhwOjV8GuTsmYuY4+zL8F9XRTar88RbjKnm9PRPGZuonaN2Z6WT66KIVDGg==
X-Received: by 2002:a05:690c:4482:b0:786:a185:13b6 with SMTP id 00721157ae682-78a8b4aec25mr105084257b3.22.1764008134312;
        Mon, 24 Nov 2025 10:15:34 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a798a5decsm46985517b3.21.2025.11.24.10.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:15:33 -0800 (PST)
Date: Mon, 24 Nov 2025 13:15:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1e69bae6de428@gmail.com>
In-Reply-To: <aSSdH58ozNT-zWLM@fedora>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
 <aSSdH58ozNT-zWLM@fedora>
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ankit Khushwaha wrote:
> On Mon, Nov 24, 2025 at 12:46:52PM -0500, Willem de Bruijn wrote:
> > Ankit Khushwaha wrote:
> > > char variable in 'so_txtime.c' & 'txtimestamp.c' left uninitilized
> > > by when switch default case taken. raises following warning.
> > > 
> > > 	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
> > > 	whenever switch default is taken [-Wsometimes-uninitialized]
> > > 
> > > 	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
> > > 	whenever switch default is taken [-Wsometimes-uninitialized]
> > > 
> > > initialize these variables to NULL to fix this.
> > > 
> > > Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> > 
> > These are false positives as the default branches in both cases exit
> > the program with error(..).
> > 
> > Since we do not observe these in normal kernel compilations: are you
> > enabling non-standard warnings?
> 
> Hi Willem,
> 
> this warning appeared while building the 'tools/testing/selftests/net'
> multiple times. 
> Cmd used to build
> 	make -C tools/testing/selftests/net  CC=clang V=1 -j8
> 
> while test building by "make -C tools/testing/selftests/ CC=clang V=1
> -j8" doesn't raises these warning.

This does not reproduce for me.

Can you share the full clang command that V=1 outputs, as well as the
output oof clang --version.

