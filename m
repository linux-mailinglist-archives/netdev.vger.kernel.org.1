Return-Path: <netdev+bounces-160256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67CFA19099
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA2D188C9FC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7892121170D;
	Wed, 22 Jan 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leTPkjF1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8016211A0E;
	Wed, 22 Jan 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545245; cv=none; b=BG+7Uawa56qmLQk7u2pcHfbduI9wsWUPTDFaYPFpuXcLh/mAyXERvO5LYT4sxKv8c11OYZGmwf8gj1ve3y52U1iv/BMaWaik6pIP43JlCjYNx5MB0vVUAsVTz7nhBACGbCPQRpKuPZu0WSFTW3vlaF2o4lhzkZGsXYPe/msWxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545245; c=relaxed/simple;
	bh=ZYwmi6GB0vkTNz2/ycjcPqcyTC5gHgcYk9Ws259Nr98=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s45uu6wclK02WfnPhJbdew5YdW/mcscyrzjnGrPeV8le7h6lH+hsRyt5dVijjP5pJmaQISclZsvCSp9CMYyq2lIbPmvigEd8r3mU8823x2Vb0rO7cexCC0ryRm5boKTus/dVUrOxP2Wwjjpd1t05Dn4MPx9WDs31MhqMcn6cVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leTPkjF1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21636268e43so148249635ad.2;
        Wed, 22 Jan 2025 03:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737545243; x=1738150043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l571FV+lx6QmXm3hgrUk99v9kh1tcv+mcg7V204aGuY=;
        b=leTPkjF1bbXh+2zBiz6SlOd/ku8fcWFS5JrxSLWin905sB9dN6vNwFhXNt54u24Ru5
         nfPeRXdjQY0Z9rsuvsd2vP4CuoQ/hBItIFi0AgPLHUrnH3RZbfJEPz+x2p10g76uRm3S
         /Lt4YdP5wpVD4PFpizqBwPrGYZ3s1psjqT5YsY6FicfqDVpjXs8p9sDvQXPxEWwpzeq3
         mGK9Fo4/eBULDeZMhD1UcJa6z/iEoOAylvMs2q+33rDZklx5qg8ayUhK+GmC645UaGg4
         8kVabHHRS6+UkF1C5PwaMGi4cgT/rTx4vD86BDTcwBxWwiFT81yKouIo/HDB04dWdu0w
         6oGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737545243; x=1738150043;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l571FV+lx6QmXm3hgrUk99v9kh1tcv+mcg7V204aGuY=;
        b=nBOG9GDJLxCgmKjrigi2+4BCRlnSgOjKs65VWqRa1XfVHBZTKRiA0DROITGCzMfx5S
         /AErfCgb6jOdJg+OPzZpqCSuRBJsOHcL3n51NqMEdICTZOQI0wPPMobjV3QG8GJiKUuA
         WEyoXa4gzXq/pENCCUJwwzYgTBLOm4mdwj5BbFjvO5fWBp7mcaiFGnFJMoxbxyxflWfC
         juAnfH5lSIR2gvOANixikiWM4Zc5EwWFje1XX5QlCqAl4pbDMwAr4HA3sA3WYC2SOLNP
         zjSV+W6ui/XjmaJb9igEJqWyKc2WpQjn1a5BMPoiAjKYTY6tTNXnHTf0t2CH81a2SkFv
         3jPw==
X-Forwarded-Encrypted: i=1; AJvYcCUU6j5YVLGdCmzFHh07GKj0hMmRecVRVQluoGiPF6wUnBABagCKyxPIKGkSwMLUETB+K8LNmBaQlJXQDUj4gCU=@vger.kernel.org, AJvYcCVxJW8bOM9L6/7QHNE2SpKbiawMhk5XDW0FyNEAL6M9lX5K6mF2y2PB9E1Ku2p2JBTEJHsOZEMv@vger.kernel.org, AJvYcCWrdeE2MGnXmWQKz/Aup8oJIsNUair7ANIVGIuDQ8PWqPvaKd0lIsKnHRp0Pm1DlHyesLBu4+icowZcT1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBMh88//2bbyXYY6cErztBZCwao4aSMyb8ash8AEG1iMfKrhG
	c3elFIz8I/t+sZ3k5BShlxxx8vQEQ7ZsFLhTGWW1aMqAgYlbbQE0
X-Gm-Gg: ASbGncuPy3l1GSx64Hf8vRo2uKNqaks741K6ztBZEPxWUXV4y6Oninq+2DB0vGU80Yr
	og4r2Av17Vj4knc5tmD62jWvjJD7He5zMg1UbupYNwu1rh35BcI13EWiI2f4I1m3/5h+LPvZ9Tm
	c1Pei/+o6CW0YSGB/9zrSpAOPTFNeS1jUt4LmqTswnoxvCCH1DiRdPbFG2uz+Qf78fEeAgsagXr
	VfTC+q9OeZj/EMOYD1eDcFayoep/L4KxLX0s6Ei5MgEu/t+rSEeAh5JalQoYxT7wLu9r1rweAOZ
	OHHZaBFjGYXxn0WllyJZAyJSzskMBZ4afw5Avf7q93kkYC3rub0=
X-Google-Smtp-Source: AGHT+IHDszaFTBlC2q/20kIx9mUzKC7ylO8G4xSTRiCtdfEtSMegDDKz23qwiu+FN6iiNJL/S7N9PQ==
X-Received: by 2002:a05:6a20:394b:b0:1e1:d22d:cf38 with SMTP id adf61e73a8af0-1eb214f0f61mr31386268637.21.1737545243102;
        Wed, 22 Jan 2025 03:27:23 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8e65sm11136184b3a.103.2025.01.22.03.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:27:22 -0800 (PST)
Date: Wed, 22 Jan 2025 20:27:13 +0900 (JST)
Message-Id: <20250122.202713.205090167743426793.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, miguel.ojeda.sandonis@gmail.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgiEqd6uAzx5bkSDzst6hB0Ap=FAB7tOs96+WBL-pHN+ZA@mail.gmail.com>
References: <CAH5fLghgcJV6gLvPxJVvn8mq4ZN0jGF16L5w-7nDo9TGNAA86w@mail.gmail.com>
	<20250122.194405.1742941306708932313.fujita.tomonori@gmail.com>
	<CAH5fLgiEqd6uAzx5bkSDzst6hB0Ap=FAB7tOs96+WBL-pHN+ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 11:47:38 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> >> Ah, it might work. The following doesn't work. Seems that we need to
>> >> add another const like MAX_DELTA_NANOS or something. No strong
>> >> preference but I feel the current is simpler.
>> >>
>> >> let delta = match delta.as_nanos() {
>> >>     0..=MAX_DELTA.as_nanos() as i32 => delta,
>> >>     _ => MAX_DELTA,
>> >> };
>> >
>> > Could you do Delta::min(delta, MAX_DELTA).as_nanos() ?
>>
>> We need Delta type here so you meant:
>>
>> let delta = std::cmp::min(delta, MAX_DELTA);
> 
> If `Delta` implements the `Ord` trait, then you can write `Delta::min`
> to take the minimum of two deltas. It's equivalent to `std::cmp::min`,
> of course.

Ah, nice.

>> We also need to convert a negative delta to MAX_DELTA so we could do:
>>
>> let delta = if delta.is_negative() {
>>     MAX_DELTA
>> } else {
>>     min(delta, MAX_DELTA)
>> };
>>
>> looks a bit readable than the original code?
> 
> At that point we might as well write
> 
>     if delta.is_negative() || delta > MAX_DELTA
> 
> and skip the call to `min`.

Yeah, it's what the original code does. I'll leave this code alone.


