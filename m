Return-Path: <netdev+bounces-160436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025BBA19BAD
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9923A3710
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 00:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431682576;
	Thu, 23 Jan 2025 00:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9YrP5XU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635F1C01;
	Thu, 23 Jan 2025 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591153; cv=none; b=bsKkPrxXwpvAMN5ZZ52WYJvSzeqeuFNuwNd4O1kRRt1Qi13LgELZPGXLEOlknQS0+1txrvizzLIbpw7Ikn7kPOuZNQmduXVZ17qGK5zIqba5K6b89IED1FKMdkth3POwFMQhcCQtSgY9x3mmV0JNdVek1fqyeMp7swHr25lCuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591153; c=relaxed/simple;
	bh=X1XECz49qWcxWeG/GB6BNF2gmFTz+ylWBz8BE0QNiJA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rhehvGBbWg5Tiz8BCh7OLpJqO0mWTlUOpv0/ymico8yDDPbLUDKnOPKNErUZ794SEcAuAu6vhyZ8dRQ8c6qQh7fNZduJ9z1XbP+s3/SNH7tzTOiHj3OM76aSzYdf/vH0wqLJmBEOVxUQy51vB0AWs2CaJkWp0mi1bsxQkzpPHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9YrP5XU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21a7ed0155cso5004205ad.3;
        Wed, 22 Jan 2025 16:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737591151; x=1738195951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Piw58QD9uf+j8b2ua/HAZ6tweWQTcyMdimhsEJ9IrPo=;
        b=N9YrP5XUgxBNZhfBm3iMhwivi23ul1HGApK7C197VOyXH3JZXHm2znSRoRk0z/geQI
         hx7ZT/pLn+SO4D2mqgw7hmqXOltuYWw4vnONij5bZrkccgWmd29AW839HQKxLWSOc02A
         q19+8wBgHdmbS+PkH6RQkpfnw/0duutoDgJ+SCXD/I+HYpH2P6++7E+Hl2FWBBmaQW94
         Il14U/dkXY73FBQd4Eme93yRWCoPjgJ6uhhERcpB67P1Nb0DF8nAk1u4ARWDpr1oFVMP
         3xceirbu2h/Q16I/hkDYFqSN9NtjnMfQ2UPhmZCpM3T8rfHCiSWQAbQ02/sJC6ZhI33T
         vCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737591151; x=1738195951;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Piw58QD9uf+j8b2ua/HAZ6tweWQTcyMdimhsEJ9IrPo=;
        b=O0jBu83J3fQfujDoqEsLj6BKsFHcDTRFLLidSiZhUpDXjOE31LdyF4B28yiWxS0Z9F
         AQZjCQULHeShPye486EDumdx5DBpWpVtixEbUpPMaKqmf+s2AUhoNjGkfs72FGsBa4Xw
         W52R4pBwKpDHNKGGesjC0HAPy94MALmueNB7JMORuV6j83kaQQ6IKR2WfQqBMsR6VpKE
         s0MjQ8m+HmAPEFCA25r28f0uyjKGR0NAGU3q/kXyn7x4xEFcdLqXZgenG9mO1UJiH4o7
         6LmY6ufqbEDtq+6Zvmt2VgWeiG09tdJ1S9PDcQtTFHyYGcMSGPXxekZJB0LTw3JrDalk
         QEyw==
X-Forwarded-Encrypted: i=1; AJvYcCUxxXYAJ0gEgcWSqvm2cAXJ6Fu47dAxYFwNwsR5kIoRgAukKoy9Pn3bAE8F0qvLW/eepyXW4LhriJlNv8/38DA=@vger.kernel.org, AJvYcCV1ShBMSZBAaekhzZgF3xl6XwwQemFJkVOT1lnalDkI/NbTQrRCfkVoDW5NZGZFN7h4ss3vbWsIj/WsaDw=@vger.kernel.org, AJvYcCV6hWo87QlTyHTae8PivHzYtZGihgvm8Iw64cNX1XlhxCDMCF0LFBQbT2YJqnaGdguDsJiL3pns@vger.kernel.org
X-Gm-Message-State: AOJu0YzLg9eTlWQKjhhdOLRoCUYwIkii9jdCMLrBEnHBa/guN7L1J8F6
	c4FpBQH1NhfFzKwtC8VVRzv7mTWkmQy5Fl6E5iUe2b+QEicAW7CM
X-Gm-Gg: ASbGncuJGyqXSRk8Tfjuuqb2rNr7iKbonX4DrrtXvd/pF7VJWAVJjU+n1jaBCvjB9C7
	BMK5GhUS5r10Yeovg/s+uaO3aWFk637YIhx+/s4g9voEWP2cfuEIa7sPvvyVDVGuX5nO9HowAxa
	q03yCX/E8J8TG8zmOmUeIzvhZbeI5UPjJIl9SwGgfXcz/emqnwPh2rBtOopo6Zl9HOEzXiOMHjl
	PcYDoT3ZzN8eeqfm3vb4l2nRK9bv6pyz9VHOTh8ef8ifi+Z1PKbMnJd1EiuO6ZR2KzuMuVE0n8X
	RA4I1Jj9g5VcjSrgA4/rUAcZ9Zpe7ieBMof0o/9TP1vaciLyp6c=
X-Google-Smtp-Source: AGHT+IFbzEzDepffLCJBduNjJCrXd9MQqm9y1MzMSu+HJp+DT1OxEewkjFhjOhEzH9VOMpb0jb0NKQ==
X-Received: by 2002:a17:902:c94a:b0:216:2abc:195c with SMTP id d9443c01a7336-21c352dd6ffmr323373965ad.7.1737591150970;
        Wed, 22 Jan 2025 16:12:30 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea07e1sm100915785ad.19.2025.01.22.16.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 16:12:30 -0800 (PST)
Date: Thu, 23 Jan 2025 09:12:20 +0900 (JST)
Message-Id: <20250123.091220.883080907537783935.fujita.tomonori@gmail.com>
To: aliceryhl@google.com, gary@garyguo.net
Cc: fujita.tomonori@gmail.com, miguel.ojeda.sandonis@gmail.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgiEn27VMUfrXcidu0rUpM7MPZVCOjywa-vQBO7dOdQrRQ@mail.gmail.com>
References: <20250118.170224.1577745251770787347.fujita.tomonori@gmail.com>
	<20250122170537.1a92051c.gary@garyguo.net>
	<CAH5fLgiEn27VMUfrXcidu0rUpM7MPZVCOjywa-vQBO7dOdQrRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 18:06:58 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> > >> +    let duration = if delta > MAX_DURATION || delta.is_negative() {
>> > >> +        // TODO: add WARN_ONCE() when it's supported.
>> > >
>> > > Ditto (also "Add").
>> >
>> > Oops, I'll fix.
>> >
>> > > By the way, can this be written differently maybe? e.g. using a range
>> > > since it is `const`?
>> >
>> > A range can be used for a custom type?
>>
>> Yes, you can say `!(Delta::ZERO..MAX_DURATION).contains(&delta)`.
>> (You'll need to add `Delta::ZERO`).
> 
> It would need to use ..= instead of .. to match the current check.

Neat, it works as follows.

let delta = if (Delta::ZERO..=MAX_DELTA).contains(&delta) {
    delta
} else {
    MAX_DELTA
};

