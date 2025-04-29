Return-Path: <netdev+bounces-186791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA21AA1124
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC221A85B79
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEFB23BF9E;
	Tue, 29 Apr 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQBjbLQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB698227BA2;
	Tue, 29 Apr 2025 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942618; cv=none; b=dg5cmIGdBiH52KrOFuXoAvFOpp2Mre1g/08aJA+NoSr/nPsCHruNJQkCDyQ/Y4wfanYFdOYp20P67KzSiVZ8buV3M1WdBULln2SWtuQhlC0/j0COWx18IATBgv+pOR5DyqNDZkyHLAyj+P1/rqNFSM/uyDIAMMCuFG/VEhotyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942618; c=relaxed/simple;
	bh=YdSkEEiFZncAhrc22+PytLmETOgRYaylmTOMtuIRgl8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=chsjIe2sXqYWblLhOruBTNJR3Q2q5Eb/vVDL9mFtayUOWJXQEeV2hlAAYYoIF/44RJtJABUHU8/L84R73TzjRFbo/BU7rzMKTUlv6iPig2+sRfbrdVMYLnaE8jjXyl41i6JpmtYPJ1zY4zJFt7i/cwuDbUQx0eQXJg5k/xojEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQBjbLQ2; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f2b04a6169so68231086d6.1;
        Tue, 29 Apr 2025 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745942615; x=1746547415; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZqALT9s58kVrCiMKZIE6HXnZIGBvMdRsf7s/8Crr9g=;
        b=TQBjbLQ2AFpbLic7HCZNmic1ImvfWeA4VEjIHPiIr/1uImCcunzF+l7tkSrpJ6sfqe
         DAzYKTy9fzM0rFXrDtuKYfeL+mzOMhnlZKG5TiOpJLteXxzx80Qcyee7Z5SNiJWs7ILS
         0OKCo4cfTwp88VZRsdLQH+ZTychonwMpxMhdMdFmSmN/KkyTZyZsvIpBvkJGCEjnQrga
         pdTlUL82XQuSAUXi81JC2WogVRS1inO/kRfiB6/GOplA+sd+x31/Dsd5pQtmsu4N3Kv3
         3nMxWRNOw1xUUwK+tGPsk8c77Ci/Kiv+6hxyGqlP3UzJCNQdcMzjF7cOsn3O12kZvCxE
         SHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745942615; x=1746547415;
        h=content-transfer-encoding:subject:references:in-reply-to:message-id
         :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tZqALT9s58kVrCiMKZIE6HXnZIGBvMdRsf7s/8Crr9g=;
        b=lN/GYold+/F4cRRsLpeOm+EIHwhzJhI2/d+zu44iLvgTX5urwFugwa6M00/T+bMUar
         22CggyRhnasYspCJfTbQhCHY2mN50CxkstJVEcoke3wWtMuJQW0sdDcy0Eh+8XI5e+4j
         3f7mQqCJQLwkzzjEwFaICZ0zWGek0FmLu2eS7iS+uwj/9veGTiLoW+/SDJlidlB5wDUq
         sqXaVQ5bwfw9cKZAk8RIaE+7eRuM+1fyih7ONuI5xrwNBK7OQcBvwvRLOWsZk4mmgT3q
         lGEXdx3Mws961/Tfr9GShS4pttH170FPpEzLl09Oy7qEt3Xjk/kBM2icyDVEc/G5uVbd
         gX/w==
X-Forwarded-Encrypted: i=1; AJvYcCVdEfyWftBn2bHdlWXJ8eLKmfgpvqcl2EvBs8xAYeEdPexBzGse/YkRiEMmyhMyrhOzokZPIzW7@vger.kernel.org, AJvYcCVxGVVhtOt5aTlhGBSCFK1f7EAfbe5MSYQNo5+L5iNW8aH2wRs/v4qKn3VhkFKh+AOpPUv+2mLfztgqQtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mpRrJHJjt/YXIz7j0de0CHxtB2iQYn42OTec4s4ooVAWRWLA
	glqIYDt+yXx9SnIv1cfMV+DHBliNvWV5W4p+RMNehCONsSyCCubB
X-Gm-Gg: ASbGncvd+cMZwryOxiYi3LrBYtrACeU/T8CtvJDRxBprDSMSZMf2vZfU+3I6/dZO1Te
	18WDUFeHRHTnGYFRARNIaS8hMiS4NYKLPiq1DESCUFBnZCv+QA+HOoeRaYsCdqbhNWCeSyJgnwq
	woHV26gB2wWRnxt0ddPaARIjIkqMpRz6sYK0ikamqSB8PqHm2ar5GGPMtkumSuWX3o+X2TPQhb5
	ra3YXitgex0D8netinh5TGB4qkdkcf8NSbfA06z5WZOA1huODibr22y3tGBRv/bNTdUjYp3j5vc
	L4Q6n912vgFvC+vBPJcZoQnkiuIhuxvzAtH1FA98YeBGrYvjQ15D2MYnNhGD3agm2vXTxewSbdQ
	f4+JviJ6PEXDo5HAiwRTqK5FNc7JcH18=
X-Google-Smtp-Source: AGHT+IF7JT3P39Y8Lbf9+t55VGljtWVy576+gkRsH8+tkLSB4QFI0Ow6bJbm6D+aNwlLetlihslbNA==
X-Received: by 2002:ad4:5148:0:b0:6f4:f162:ce24 with SMTP id 6a1803df08f44-6f4f162ceb5mr44549006d6.44.1745942615437;
        Tue, 29 Apr 2025 09:03:35 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0aaea52sm73498716d6.105.2025.04.29.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:03:35 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DBD891200043;
	Tue, 29 Apr 2025 12:03:33 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 12:03:33 -0400
X-ME-Sender: <xms:VfgQaHVHvgYDg_SAzsbh6JBQzLuOUUglF-JJIqG_H4FRhQIKLThhBg>
    <xme:VfgQaPmmCXGev7A8g27WORst5jAh8xNDbEn-gjW24hX55b7cWaCWUgThAAKTm6ZDn
    xaHp4binDsR4xn4_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfuehoqhhunhcuhfgvnhhgfdcuoegsohhquhhnrdhfvghnghesgh
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedufeelfffghefgveejteekvedt
    leegfedtkedvieekgfffleelkeefhfefhfejnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeef
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmh
    grnhhnsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdho
    rhhgrdhukhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepug
    grnhhivghlrdgrlhhmvghiuggrsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohep
    ghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoheprghlvgigrdhgrgihnhhorh
    esghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsihdrshgthhhrvghflhesghhm
    rghilhdrtghomhdprhgtphhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesgh
    hmrghilhdrtghomhdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:VfgQaDYmDKDMNIrwRfUDMoZ51GADRpmeprMHpf6hAksJnkfhpd1q0w>
    <xmx:VfgQaCU1LGJ0x6kzNU7m8TGOsHHWPQLeoRJ35JwpaZik6j6ODrYOaQ>
    <xmx:VfgQaBmj8dRwMW50HMMG611HdxGbj0THbo4iJiv_zGoKGSGnmpCHSA>
    <xmx:VfgQaPeDXU3VUA_IHO8-QyNYmtdJAN5hM8nS_Lk9n19uTknsqaR0AA>
    <xmx:VfgQaLGrskHNLlSANi_DsNMgo0JOBlDWuTbw_XggrA-8X__FGtuX-2NH>
Feedback-ID: iad51458e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B37372CC0075; Tue, 29 Apr 2025 12:03:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T32d91d43ea38c8d5
Date: Tue, 29 Apr 2025 09:03:13 -0700
From: "Boqun Feng" <boqun.feng@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org, "Gary Guo" <gary@garyguo.net>,
 "Alice Ryhl" <aliceryhl@google.com>, me@kloenk.dev,
 daniel.almeida@collabora.com, linux-kernel@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, "Andrew Lunn" <andrew@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 rostedt <rostedt@goodmis.org>, "Benjamin Segall" <bsegall@google.com>,
 "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>, tgunders@redhat.com,
 david.laight.linux@gmail.com, "Paolo Bonzini" <pbonzini@redhat.com>,
 "Jocelyn Falempe" <jfalempe@redhat.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>,
 "Linus Walleij" <linus.walleij@linaro.org>
Message-Id: <de778f47-9bc6-4f4b-bb4f-828305ad4217@app.fastmail.com>
In-Reply-To: <5c18acfc-7893-4731-9292-dc69a7acdff2@app.fastmail.com>
References: 
 <6qQX4d2uzNlS_1BySS6jrsBgbZtaF9rsbHDza0bdk8rdArVf_YmGDTnaoo6eeNiU4U_tAg1-RkEOm2Wtcj7fhg==@protonmail.internalid>
 <20250423192857.199712-6-fujita.tomonori@gmail.com>
 <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
 <5c18acfc-7893-4731-9292-dc69a7acdff2@app.fastmail.com>
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Apr 29, 2025, at 8:51 AM, Arnd Bergmann wrote:
> On Tue, Apr 29, 2025, at 15:17, FUJITA Tomonori wrote:
>> On Mon, 28 Apr 2025 20:16:47 +0200 Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>      /// Return the number of milliseconds in the [`Delta`].
>>      #[inline]
>> -    pub const fn as_millis(self) -> i64 {
>> -        self.as_nanos() / NSEC_PER_MSEC
>> +    pub fn as_millis(self) -> i64 {
>> +        math64::div64_s64(self.as_nanos(), NSEC_PER_MSEC)
>>      }
>>  }
>
> I think simply calling ktime_to_ms()/ktime_to_us() should result
> in reasonably efficient code, since the C version is able to
> convert the constant divisor into a multiply/shift operation.
>

Well, before we jump into this, I would like to understand why
this is not optimized with multiply/shift operations on arm in
Rust code. Ideally all the dividing constants cases should not
need to call a C function.

Regards,
Boqun

> div64_s64() itself is never optimized for constant arguments since
> the C version is not inline, if any driver needs those, this is
> better done open-coded so hopefully it gets caught in review
> when this is called in a fast path.
>
>        Arnd

