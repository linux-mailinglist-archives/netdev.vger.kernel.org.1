Return-Path: <netdev+bounces-166861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37229A37980
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 02:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F83A8B2A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 01:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9246142A8B;
	Mon, 17 Feb 2025 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiO1YXE7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963479D2;
	Mon, 17 Feb 2025 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757098; cv=none; b=r4TnItJWcyKqvrzDp19YsQ3x6E7PTHJA00ZJEPrYhJDQtF228I6OeeIUYcCyLDo9DP0UUkjkAp0c3KKMkTxDuharfuwRpTp3T6LNgRMxNs40k4E+i7cuzATlY+23qRqTmEU9n1qBBm7+ndw6ZuKK0wWqfn7xO94ZxtCvUgw06ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757098; c=relaxed/simple;
	bh=i2y9NCKAA5mf0lCCR4CE06BpzZ/tWFLaANF1MitbJQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa/DKk1htYdHE4WXMfwVxXQ/Y44k9Ae3OPdEm56UVMhWGTkCubSqm7n4vyetTphwy5t3JxsygMD/Py2yR7f7ElLEqT9IiDk636dmX3uednz07V1UD0dOFSlcRUdPGTnm30Wsk3WM7KckgmkJ27xnmywrDOq9XH/9dj2z8clP15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiO1YXE7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46fa7678ef3so43238751cf.1;
        Sun, 16 Feb 2025 17:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739757096; x=1740361896; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HqwamwawLH6bGg8Wb3IGxPf64cClhyn1gpuzpHxM+RM=;
        b=UiO1YXE7uJUV0+KC0vAI/sww3B5odZSldl0TK6In2WIkh/qPOVJzw+CmVBWfqSD0Ke
         oQQxUURlB6E+16LxHHU4Vyg5TRH2aOFcKmQy9YXAtGecF+AcS84epLXOo6FZ7AFLo8Pi
         PuBhlo02zv3WpoxXcj2AX2rOl6+KkGcEmuxACzIYXNt0Ku/zarnTY2t+qrtHSOp2zrrH
         +SXNN8OHwLYLPeAGPZXcTMFfjCKRbgAhCZhTPZ9fqc2J10USHF6M+Qv3lqExJuEDEE2i
         gMgoVbZNk8w8h7K9NZXAwKxJByWbrdZjtDe19OBArHdQXcvKCp6S+RlRY+msGtWTqDo2
         UrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739757096; x=1740361896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqwamwawLH6bGg8Wb3IGxPf64cClhyn1gpuzpHxM+RM=;
        b=I8QzAfOQCb1WUauFslwGDCQS3Zwf/60ByZIGKTPVMF7AxKztyQtFnDBKOQln+wXmpQ
         +erS4JwOCsc999yyh9Oi22fl3v9WtZlSCAYI3EPXGH7oBX+gLQ2jx4C9/RuLnavWnmzZ
         YL9dFVdRiuCZqqmc85Q/oer2zFOlANOqKcExZfM8r2ziqQ5BHJRmYhKnhUSOw/WYxTXd
         VDbSkKSW9ALNnrvKP1QZ3OqDwgPB3LtD52vSHzI/K3Ohaos4sXMjK4EH5JmRLoMmXcu1
         QPryjGO0HtcGg2MZ/Q6M90WF4rh2oBQ/eqXdy25kOPLiVthps913wXjYzcWryXo24ZPW
         IYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkbxHtpqPpqQ4I+oIHVtsL8bI5wrscQlojA0+Ol0Ae/D+lDmAVuA4zWJdb6RTQkGfid+Zu1MCZ@vger.kernel.org, AJvYcCVzQBEANXWCKnCnvcLH0pPO1IaFn01arJ/fzuznyNAUQbfx6TnKUKxma44qVBVHyyB98sJLrChoUWeVdhUZsf4=@vger.kernel.org, AJvYcCXy7P1LRSEVSKj2XKf0gwbZtT4Fw0SFdk+oYN9tT4YxJ+kNPrCqCp6EZeZ5v7mO63LBM2ggbT/jh8FM2To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7o7uI61rS2KaP2Ccy/21KRuRjHtGK7h3bTqebHfHPKHPXbfJM
	AM0MUHaoW8fCap0EvHUBfsVx6rEBGVxxM9fD03eTeO7gRXg3nKNI
X-Gm-Gg: ASbGncvDxFUG8KkUchNlQ7ME6K0hUZpfez7jpqRkP8uX4Zmp3dUTiXFqdrAeNHffOhC
	bjQXi2ljmi2uCxZ1/Orrn4qrvKFpbhbor4owKCv8ODPWm8Z5J565/hFmuh2L+tiUBrt85ktxuau
	BM5WcgrKDNP2issULOb9iA7uZk7c9Sw6bLldlAgE1rmlEtWiauG/eQHjR1Bq/2rb9Q4BmIhWv2/
	O/G2AEYp9SoT4IYIro/RP0osypkUleAJ3T/zRL0/yuF9PtBqC7+Fb+5eNwQ1TvBN06+05+cahoe
	Jfjw7O7kEBMiI3nfe8xlvozng0PWrAs5QPn5BSna94LVveySxHZvvKxL8eS6w3fjdaR9Q8lPTdc
	XQTi6mA==
X-Google-Smtp-Source: AGHT+IFCe3muZ9N1jrtvkc2NqYvORhIIhHsHMZGjyqrd+lG1J5/kWyY6Pb4fw2mxowJVBIQrrXEfBQ==
X-Received: by 2002:a05:622a:28a:b0:471:d67d:fe54 with SMTP id d75a77b69052e-471dbe9fc70mr119764401cf.49.1739757095695;
        Sun, 16 Feb 2025 17:51:35 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f5a75cc3sm570451cf.25.2025.02.16.17.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 17:51:35 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6292B1200068;
	Sun, 16 Feb 2025 20:51:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 16 Feb 2025 20:51:34 -0500
X-ME-Sender: <xms:JpayZzFgb2jBnzWRzWFU2fivVlcG5-_0KHx-qWnWXQ0UUEMw9a_phQ>
    <xme:JpayZwUX-voj6J-w-aQsptM-_Mw-tjCXz0B17Qn5UDEAGAejF5APfyJV_kcdDxzD6
    vVa8_qrd-StjYv_5A>
X-ME-Received: <xmr:JpayZ1KjJhNYjOyaGesCeH_cxDViqCR-COo5DFMaabkVQU7AIXuwB2yWlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehjedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrg
    hllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhm
    ihgthhdrvgguuh
X-ME-Proxy: <xmx:JpayZxGiqs5OO17IPWI7TIMB_hzDJu2B6YNPFL4mJEUow_V4mowfmw>
    <xmx:JpayZ5ULMq7zlP-BMYv9BX17MMdbCtMvSVggKGychMxfbSTBFn6g2Q>
    <xmx:JpayZ8No-YWyGu2LfnlTAlJIAh31kSAAdH2dkWITYkNgDsmAllau9w>
    <xmx:JpayZ41esj_Gf6Nx7SxvO7jSrBECSmct0M4zfJOz9IJUkjTWHzvAcw>
    <xmx:JpayZ-W8kdh1uvgTEd6sUZhNdz6ZNhJB9eo9kjpMfKvbJXMuV6XL-xgT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Feb 2025 20:51:33 -0500 (EST)
Date: Sun, 16 Feb 2025 17:51:32 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	david.laight.linux@gmail.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
	jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 1/8] sched/core: Add __might_sleep_precision()
Message-ID: <Z7KWJGc-Dji3Kacu@Mac.home>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
 <20250207132623.168854-2-fujita.tomonori@gmail.com>
 <20250207181258.233674df@pumpkin>
 <20250208.120103.2120997372702679311.fujita.tomonori@gmail.com>
 <CAH5fLgiDCNj3C313JHGDrBS=14K1COOLF5vpV287pT9TM6a4zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiDCNj3C313JHGDrBS=14K1COOLF5vpV287pT9TM6a4zQ@mail.gmail.com>

On Mon, Feb 10, 2025 at 10:41:00AM +0100, Alice Ryhl wrote:
> On Sat, Feb 8, 2025 at 4:01 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > On Fri, 7 Feb 2025 18:12:58 +0000
> > David Laight <david.laight.linux@gmail.com> wrote:
> >
> > >>  static void print_preempt_disable_ip(int preempt_offset, unsigned long ip)
> > >>  {
> > >>      if (!IS_ENABLED(CONFIG_DEBUG_PREEMPT))
> > >> @@ -8717,7 +8699,8 @@ static inline bool resched_offsets_ok(unsigned int offsets)
> > >>      return nested == offsets;
> > >>  }
> > >>
> > >> -void __might_resched(const char *file, int line, unsigned int offsets)
> > >> +static void __might_resched_precision(const char *file, int len, int line,
> > >
> > > For clarity that ought to be file_len.
> >
> > Yeah, I'll update.
> >
> > >> +                                  unsigned int offsets)
> > >>  {
> > >>      /* Ratelimiting timestamp: */
> > >>      static unsigned long prev_jiffy;
> > >> @@ -8740,8 +8723,10 @@ void __might_resched(const char *file, int line, unsigned int offsets)
> > >>      /* Save this before calling printk(), since that will clobber it: */
> > >>      preempt_disable_ip = get_preempt_disable_ip(current);
> > >>
> > >> -    pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
> > >> -           file, line);
> > >> +    if (len < 0)
> > >> +            len = strlen(file);
> > >
> > > No need for strlen(), just use a big number instead of -1.
> > > Anything bigger than a sane upper limit on the filename length will do.
> >
> > Ah, that's right. Just passing the maximum precision (1<<15-1) works.
> >
> > The precision specifies the maximum length. vsnprintf() always
> > iterates through a string until it reaches the maximum length or
> > encounters the null terminator. So strlen() here is useless.
> >
> > Alice and Boqun, the above change is fine? Can I keep the tags?
> 
> I'd probably like a comment explaining the meaning of this constant
> somewhere, but sure ok with me.
> 

Agreed. The code should be fine but need some comments.

Regards,
Boqun

> Alice

