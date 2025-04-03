Return-Path: <netdev+bounces-178959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24240A79A61
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 05:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29BDC3A2AB5
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5C81662E7;
	Thu,  3 Apr 2025 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4NDA5R+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403292E339D;
	Thu,  3 Apr 2025 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743650253; cv=none; b=ZCn3murQ0KstWIoUJYAWlJbqCOqYGD3y/fLTAjL3dmOb2B00SCeZ3nHti7Mpsh+fKU1J7mBeX0JFaca0isC+g9q4MN5QP9GjgOX9rboft64zbFl/hUytww2Vt1jVKo6GwBf+u7dyXSlSGpMjyhhPRvnQoNkhikmVgepMbplKDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743650253; c=relaxed/simple;
	bh=itgEycm8pRAAc9zKahP4HM0uCFpeRLqYcLXmCGuRrBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMle8YTNKk5AElQW1o+Kk0OxwpwS+dEcOcGo7fdNw6zypEmWj3QYnIt6LJYktN2e0GxNVgxKai1gN0e7Rpdvv8m3rUJfqR1101KxNLtTy1dz4rm8TawXGb9ejxKdv94ZF2dyRtHSo8TSkpDfwxlBUjA8NfuRUPM3gvbMbJheByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4NDA5R+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47690a4ec97so4414391cf.2;
        Wed, 02 Apr 2025 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743650250; x=1744255050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g7kelX9sigiMyYI8oNHn8YmS9tjgLV0LswGrVfbJLh8=;
        b=a4NDA5R+I+NcB5o5QpDePyXImiPPP+FZVwxiQMJiFln7c2mqoLPezBkZEScCwDPxPi
         2QRiS00xJ2a/aefyLd5q7OlXtUnkv/LJnHGhWpErW1hhIKbqGecUnAQCgVR0d/pfqS0j
         cX6CNfqEGLMu1WsmFdl/H4MjiSd64VLtB/rGtDDFei/ThcuWE+a/Yjd2FFMHSpv9qY91
         B4nuPNqvTeUC0y2uWbkENliA/vtYmhCDZATSfoOXw0P/JmIjAGhN+em88tGqpMDtG0su
         Z7hJxTHx03GFjZCERcd2kskJjKBJn9zNipSl6SVIZ3JWJZ8hIl50OQd3aCPEsOndBmZ+
         5d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743650250; x=1744255050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7kelX9sigiMyYI8oNHn8YmS9tjgLV0LswGrVfbJLh8=;
        b=DcGcq+I93JdCRTAnq2OQZ99DJcsnENM/Yrva1rT7ugD6mhZKKfGBROx6VCmXzDZdwy
         NDfJf2+1aUXACXW0yu6/Daumfx4av8h5vBvZOqiMb8USNQEjFgRlj7SCrO05Ek7/PvXz
         J3Qaz0Mm7XBNUm5OQ6osmFfp8HBcFG6osYJDNjgL64WtjfPNz8pRJwbezium5fANpsfg
         0v8NdrEq+FxBYw8Fh5Bqynm4oaa4ffeQfXeb2KzV2InYgnkTp8qCHLbKjiK5UGNw4kDV
         MabxqJHQQ2BMdaAmJC94Oskkmtr/fnYFK5WEW41vXOXYdm48G2T4CX+72gL8lwpKKQZ2
         VtWg==
X-Forwarded-Encrypted: i=1; AJvYcCUtunqx+hnjGBjCZAzxrPkAY97wkAmGaM6wi7A1SWbry0AjpHJv0F8R9bCJvWMGS6sOcH8ibKgMxLmqN5g=@vger.kernel.org, AJvYcCVX91NkJUhHV2cbGefPNZDoIJr1A/O/tcePraiX1P5Np7wt5xwq8WS9MwJq39jLi3vwzAaEtgjNnIT+Uqjwey4=@vger.kernel.org, AJvYcCXxCwGuG7OV5crzN+wWs2oSqxM3ki5/XnylZ7SKUsdQTo07X/uLkq9e6Y2pjhzNeuqLdjF9KRRs@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZdKXW/Q92Q/GkgimkqlEOaZiXK7qdDr+akI/qIiCw0i/6Ty/
	7TyiBPQAHIxIqKTxtgzHrAxTHuTgy4K6xTNDjeKLcLghqZTT29ub
X-Gm-Gg: ASbGnct0QSiohvlvJP9d8mSeVb4lMvBkL7uWJlOqGDt1it25OlgjCUqJWP3V+/h/8tw
	niJU3R4tvecLdxPEA9Mp0SEwDmVVTEyAbIW9GOG2Edlh3yFVJ9NulY7eMfdh+iIkaEsrG+HicNo
	sWO8/qSMgem03EaLsZPUr8jqbvIqP2YHqmrdEy6JSKntsChIgI/4JXp+m9Pd1icNAY8uSXFfbbs
	8TQTTPjSJd6xm782UYeYHycA8Ecdv+Qcm0qDJFSVwM/Hv88RmC1iH61ilT1VXzcy++wE+tWs4Mw
	mfrLDHplrWeT2ka1nv4FYiR9JsgPBRqp8HyTRDUK+taTTeTIEMpQABpiBaiK+KCUtR8YfdlHGgt
	R97tP2UA3QK3mOVXbGJgHLpKXGDai3ljAxXo=
X-Google-Smtp-Source: AGHT+IFTf5kFeGqIsg8lqULY4ZFLd6fMPrOrxVd34tms3JfsyYYWhX/unwieeiTfzYUf9BeMXRjTYw==
X-Received: by 2002:ac8:5c92:0:b0:476:98d6:13f8 with SMTP id d75a77b69052e-4791b1ebe63mr10551061cf.21.1743650250306;
        Wed, 02 Apr 2025 20:17:30 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b1446ecsm2439541cf.77.2025.04.02.20.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 20:17:29 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id E436F1200071;
	Wed,  2 Apr 2025 23:17:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 02 Apr 2025 23:17:28 -0400
X-ME-Sender: <xms:yP3tZ4oeWut0X7_qSkngEQ1HTqOMrPxlWukbPhOPczALWNFQLuWHkw>
    <xme:yP3tZ-oY_Uc4IhYvtX8t8xyWxav5VZbinmsma__xpiDCW4nsgscbfU5Bs8NsMWSit
    rwv80tCHSj0vZGSOg>
X-ME-Received: <xmr:yP3tZ9MvPubQY-NWiMCsvOmWyehachjTfQtVLF9OMbkofHlJMVBVVFov>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tddunecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepgfelheetkefgudetjeejkefhjeefvdei
    fedthfehgffgheehieeliefhtdetheefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepfeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgi
    eslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinh
    hugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthh
    dprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthho
    pehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:yP3tZ_5a2TwhQP-UQJYeyriK9B7fa6DWmBi24q5BSov2PmHkFEBrsQ>
    <xmx:yP3tZ362t5IH8H8eStIigyVglolzDhOAt80MZ_I7KWt7RP4HRZTJTA>
    <xmx:yP3tZ_iDPIdd95rv_JbHKwWRLWYxqG5weUmiWvfI-hZAf6FgY3ZKFg>
    <xmx:yP3tZx6Skh7ki7RhXZcEw9QThkq291yRcOnve6FJahT7vkwtQnZVKw>
    <xmx:yP3tZ6L3B3SGWrMjq1FlLTlaLmtkl6ffMWKejownscGoSq729QBvY8tS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 23:17:27 -0400 (EDT)
Date: Wed, 2 Apr 2025 20:17:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, arnd@arndb.de,
	jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
Message-ID: <Z-39xtyFyLjKRxsl@Mac.home>
References: <Z-1l3mgsOi4y4N_c@boqun-archlinux>
 <20250403.080334.1462587538453396496.fujita.tomonori@gmail.com>
 <Z-3bnUucR5EX8XVu@Mac.home>
 <20250403.120200.1300877147444853564.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403.120200.1300877147444853564.fujita.tomonori@gmail.com>

On Thu, Apr 03, 2025 at 12:02:00PM +0900, FUJITA Tomonori wrote:
[...]
> >> > version of read_poll_timeout(), which is strictly worse. I'm happy to
> >> > collect patch #1 and the cpu_relax() patch of patch #7, and send an PR
> >> > to tip. Could you split them a bit:
> >> > 
> >> > * Move the Rust might_sleep() in patch #7 to patch #1 and put it at
> >> >   kernel::task, also if we EXPORT_SYMBOL(__might_sleep_precision), we
> >> >   don't need the rust_helper for it.
> >> > 
> >> > * Have a separate containing the cpu_relax() bit.
> >> > 
> >> > * Also you may want to put #[inline] at cpu_relax() and might_resched().
> >> > 
> >> > and we can start from there. Sounds good?
> >> 
> >> I can do whatever but I don't think these matters. The problem is that
> > 
> > Confused. I said I would do a PR, that means if no objection, the
> > patches will get merged. Isn't this a way to move forward? Or you're
> > against that I'm doing a PR?
> 
> I don't object to you doing a PR.
> 
> I meant that it's unclear whether we can move forward with the
> approach, as we haven't received much response from the maintainers
> and we don't know what the blockers are.
> 
> >> we haven't received a response from the scheduler maintainers for a
> >> long time. We don't even know if the implementation is actually an
> >> issue.
> >> 
> > 
> > If there's an issue, I can fix it. After all, printk confirmed that
> > ".*s" format works for this case:
> > 
> > 	https://lore.kernel.org/rust-for-linux/ZyyAsjsz05AlkOBd@pathway.suse.cz/
> > 
> > and Peter sort of confirmed he's not against the idea:
> > 
> > 	https://lore.kernel.org/rust-for-linux/20250201121613.GC8256@noisy.programming.kicks-ass.net/
> > 
> > I don't see any major issue blocking this. But of course, I'm happy to
> > resolve if there is one.
> 
> I know but this patch adds a workaround to the C code for Rust´s sake,

The workaround at C is a helper function and the original C API
still works as it should be.

> I would understand if the maintainers reject it and prefer having Rust
> work around the issue instead.
> 

The workaround at Rust means we could have a function interface but we
use a macro interface.

I say we pick the C workaround, because read_poll_timeout() is a public
API, it's worth the effect making it better.

> Anyway, let's try one more time. I'll modify the patch #1 as you
> suggested and send a new patchset.
> 

Thanks!

Regards,
Boqun

> 
> Thanks!

