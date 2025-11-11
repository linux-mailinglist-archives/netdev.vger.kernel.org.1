Return-Path: <netdev+bounces-237762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39302C5006B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E968D189C2C0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F72EC090;
	Tue, 11 Nov 2025 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0ZuW6pj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F520257831
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901752; cv=none; b=WlaDyLRyS+bLR5beDH2rBus5gTRg5O1KHvGXySlqHLlw0Xut4JGVgAzIkm1u4CU5RBGaGhg9sys9rqZu6f3syGPQ0zbFqvRbH0B0bAqCuXkuHYwdaFrFA4WhxZoy0IAlvQYRTuGfcMQs7rWd9ZJ+0lRdfC6cktCnAAxZrk/x+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901752; c=relaxed/simple;
	bh=no6awPYlNWD2ZDTvcdrXtI2J2BOWdlGtNS+ynn3kOI8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=loLqoF6QjFThg/I3eSdm2QOkbnq4fGAjMUi2vIMqmniBqh3Gy9jEMY4k9EB+JSh1p5z84+8vtuUWWYDGx1n52DqKK3DQMfcUwlA2mUfPTjdNDZ6EN7+0A3oZtR4TUXMokaMHj8ldmscj16TpgTL9W4RfR11lYKVrvU/uOCntXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0ZuW6pj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3436a328bbbso296711a91.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762901750; x=1763506550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WV8SpjyToHnox8eW+EUZvNmanBSrZ2+/14Ld9cc4nK4=;
        b=O0ZuW6pjtdjLnJdOtcZ8Nh7lLY6eApabOp/rqBpf0rzuyPrQarGOjciEx0T/T4vWzW
         PnAWOMuIEBR+Q52aPh0nc26J7M0Y2WkCEKi1ZCOBlyCkLj26fiNzlcOFhJaPYtHnsmA9
         DLHQsr4ddq/bTHqSRVFC6663AaOYEZaAMlluRHlRyPr1ii+ebKNUyxPFdfa1kceVZl7H
         FsT5HISWcVLRCljY/0dbEO/kqIwITHikuBUBVtC+/t/vtHbNHEyAbDSrn6oEru62216+
         j/1ImsnLZDyGuIgyGuKwvgSqs6bUE1CDgOzLhQJbQHRF9yF4+tZpZF/aFPIdmkGEz42h
         w4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762901750; x=1763506550;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV8SpjyToHnox8eW+EUZvNmanBSrZ2+/14Ld9cc4nK4=;
        b=I+QzE+EAvIWPghOfAw6350Bx2RckzCH4UvrOfeHAG0OxHQloSI6q/HBtdMTfnnmSey
         z8wlUnqzYWkI3QQqdEolY9oZHPA7ASBpZ3utBLT+EPgsphYqQq5uKrW2lO74l/9/PQcs
         DTilpH2iEBcxWlaHqFZetRypBE0lzYnBW7Vm6Cgcde4owtNbPwZN/baIgpLOJzZlggUC
         Tnk4qzvmCNU0tGe8bCjGUchEwBF9Rq7FYRPLzenOSbS1pdX6mgYSh91uvjZeQ47godgE
         jiqYWDv5N+tqs8fYi8z2mxi1Xo6XKfTYBPjT/H8Y6jiYs5l4kkKAj/2xFDwL1EmWPZsm
         fSyg==
X-Forwarded-Encrypted: i=1; AJvYcCXRVVA9poog5e6ar8Ncq0xjsQAyxC3ZxUoz5LmFwt5AdfqSqEKulumouUVMfjInB1Ra8pRNcVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDLjXKsqFr+gdnLGKK+wvSodW6Ysq3B3YyoWj0xyg/kXf3pw1
	uhyaEO69r3GcNTuxzKH00TlERRPoPCdBPVqAvniu2hPMJn2bcyor+Ho5
X-Gm-Gg: ASbGnctubUcc1BOsBVFWp4cvncoVKAibyL24/ux/8gyXLkf0aQ0H3uI/bv3M8NpWyVB
	xvXjFR8dY8Hvq4RvGhoIuvszWKZE/VBAsXkD64hvfBQOHzVE3cdcCOl9AAkEnVkZX7aKQw74ITy
	avZ/IsUD+XueLmHvK2Ta8yLEcxIl5hdffbM5VPdBRdVeQly9rBO0G+CXjcrp3r6G0eSn0K8PalS
	TiAWyZ9Fj7Oac+tq/cWW5sfQIWHFBorwjNcbmEl/oev7JpjyE5DGWNVODas7EJ6px9jNRSsR3tJ
	+w6Uq6XdiSToqEImoDn3Zr0uu/xgwsiN5Em8bJpAD17iU0a5TAPm+OTMeku3JJnHAIWQJuUL6ex
	QvYbe00GTZsRopEDhJiebjd0hvYLU4x1JFkJhSBeTLJDQSwoQw/ruTw9O/BTKni1Nw2VZRoATt/
	Sol5FIIKdfrUs+unUqu2xqHIVzMJNR3au1XD6FZt0/FWJ0JA2fs3kTgn8XRhSWfLnyCPcMhBUa8
	ZE=
X-Google-Smtp-Source: AGHT+IF4OnkRMbd6m4HrTuqN+m+jnjr3E5I1/MHuhkYwY6fxfKQpu9u5zArrBIuDS/wyoE+OqOffGw==
X-Received: by 2002:a17:90b:1b0c:b0:343:7714:4c9e with SMTP id 98e67ed59e1d1-343dddeef91mr1097421a91.2.1762901749896;
        Tue, 11 Nov 2025 14:55:49 -0800 (PST)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07156absm214042a91.5.2025.11.11.14.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 14:55:49 -0800 (PST)
Date: Wed, 12 Nov 2025 07:55:34 +0900 (JST)
Message-Id: <20251112.075534.1069241481796218298.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 tmgross@umich.edu, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 guillaume1.gomez@gmail.com
Subject: Re: [PATCH 2/3] rust: net: phy: make example buildable
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=_KAgUZ9u5YY-iw7kyA9R1Nv6eNzZqMLSwOLQk6sR7kw@mail.gmail.com>
References: <20251110122223.1677654-2-ojeda@kernel.org>
	<20251111.083413.2270464617525340597.fujita.tomonori@gmail.com>
	<CANiq72=_KAgUZ9u5YY-iw7kyA9R1Nv6eNzZqMLSwOLQk6sR7kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 22:02:26 +0100
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

>> I think that some code begin lines with # for use lines in a "#
>> Examples" section, while others do not. Which style is recommended?
> 
> There is no hard rule for all cases -- we typically hide things that
> are not important for the example (e.g. fake `mod bindings` that are
> used to support the example but aren't important and would bloat the
> example or confuse the reader).
> 
> For imports, some people prefer to see them, others don't. Here, for
> instance, it may be interesting to show the paths (e.g. that the
> `Device` is a `net::phy::` one, or where `C22` is coming from), so we
> could unhide it. So up to you!
> 
> So I think the rule is really: if it is something that we think people
> should see to actually understand the example, then we should show it.
> 
> And if it is something that would confuse them more than help, or that
> generally should not be used in real code (like the fake bindings),
> then we should hide it.

Understood, thanks!

Then I don't think that the imports in this example are important so
please add:

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


