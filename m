Return-Path: <netdev+bounces-159176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13366A14A6B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5737E188C03B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D3F1F7080;
	Fri, 17 Jan 2025 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4qd+Mmw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9263149DF4;
	Fri, 17 Jan 2025 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100418; cv=none; b=kdKQraIZPIyFRwOoW/3LuNl01oIA17oQGu58LlQJ0q75YFKtxA+uBEPGNYzt6A221VDrbGlQJvbnc7mQZpfB1Et4uEuMRMDITzHHc8Davv72TijyCFCtKr5KWkGB9vUSGB/uLeFRTjVXm9hdJ+huHHfhSiv9+XTyfn95K2hqbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100418; c=relaxed/simple;
	bh=wYRSYuEZTmOdDWgZDM41um78SI6chB+p+eqgLJZBK/o=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mz15KDqiW87qkw1gTQ1mwzaZFFsKGJEBx2CA2iZ6fliW/PzgD1QQRBldoCFkFmCLjo3Y9+7Mrpetegt5uwHYlPQlSAMIYl5I/+VLmEcf6R4zwvJrbTT8cXP44i70pP/KZm9aAdkzTD6Y5zSa2klC3NVq59KIITcZLKdk2VkMkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4qd+Mmw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21654fdd5daso30736565ad.1;
        Thu, 16 Jan 2025 23:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737100416; x=1737705216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4GmvjHNeM4m/IxyHTTfCfV+4PNJd7FbqxnQuFVomQA=;
        b=W4qd+MmwNs04r0H3wV6mP5WlMvu2kp8/Ev0zAs0WYUeBJcKi80DVaW7X+VK+jbG+nE
         e5ipkwSkZyRD8L9EcZpDNMYwRrP7Esq6mXmCdSXnbl3FOw2nZLuV+eEmSDBIprCsCt4v
         Z/ptyHkS416+idZctkpNYLq9Ww6rtzcDd33nA7RxOaoDR01t6+uBCDtnlM5QancpjisQ
         axCRvLSXhyy9Q4zB1QDXeQyWWVHSGZP/7PCuwgRrfp3uWAZsDIpy0GwtOsGX1WbWBany
         Ap+WIPvhJrIiuHlTdFjQ0NyNUyTBrJnZR578Hus9uYBAI8O69yUbMQmxYBXPowNiSvwU
         Ji1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737100416; x=1737705216;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w4GmvjHNeM4m/IxyHTTfCfV+4PNJd7FbqxnQuFVomQA=;
        b=R9WqxwA0sE0jehhEHi5bciOlvC0RFPqgvPx1MIZhfGxV/wcEZR5KVwBe/b89e8AfLo
         MMP85YVhG4Y24NkxrKT1I79NCSzbPTRT271ZFnbcDLm8kAkiELKzAFQwoJN2xyoL+xuk
         bmvMy68GuKuuGXEBCZ70+gc2LVzE4vWYyzHk6/IJlF/6oyagkmy+8lVMO0T5UJatNWrH
         96K1hiyZvuMw3XgiviKN6qC5g6qNtyEYsmKN77R0FO1itj2AdidC2j/eJivijCTC254v
         YZJioWuMjaNkWMccNkTlfZ8roUN2eIEm9wU4Rd/l25cytr0xw4fRsSDIsrAB3ubtEqP2
         CytQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8SJ2yU7sjmTKJ3h4+LWvTq/veDAs/Bzg60RIrcQqbFi7XpMXmA4LXMbbk7JhT4hDMpMdEFN4B@vger.kernel.org, AJvYcCUttcQ6s13qenYo49sOoJ6jo2f/b9lHqk3TMg3KrSL727DVel80kOfGXIrnMYG64ejgdZRxnm2V809w8oo=@vger.kernel.org, AJvYcCWH45oOqwwwPM7V+CV9iReJfeeo/dnvETU91WK+FcEbHZCKC4lLiRNukPGchxzfcFyTvfA7UnFHJq8n7dw+ZIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+TE2AdORwxHuhVvsvyT70u0H1qtZk7nxsaYpt7JRr1WPwaFc
	n7Wh9fq26+98IWyCFfgJIb154moMX9HRaP6IsqmMDQkCKmN+tPaU
X-Gm-Gg: ASbGncsSIo31+ij7D4/AcqIjDbPLd3O/Q06G0Zfs+TjUvzJM1Jc+RssjtRJiymHbqBx
	UdItgWYXn02KFngd69b2J6BnyOytQlgK8w1PsPqkNJcpXbmAqpEXqF2EENMeAtULdYwNou8JBp2
	BrmZUFhwoqAykoTfa7iwBe7ELhIQAwow6Eyl6DkAM+L8xff3s0QwGuruup8IF4ycLZFQb4IdXvn
	tQ7/qICry41wlcMWayU8jMMCu8CqviYSmGdFQY2SBDnltAtXxgO0/huT6UHXvIOmF0seFLk7em6
	sTDpDcZ/GA3G+t8T6XqY5G6r9rSzElGks/dsAg==
X-Google-Smtp-Source: AGHT+IHta8LtnsQXgmf6GtcGNuqhh/LR/rBpDLR2JJJZ9Ntk8sL6h8FnxqNApdxEMN5yutdLxyafiA==
X-Received: by 2002:a17:902:d487:b0:215:e98c:c5b5 with SMTP id d9443c01a7336-21c352c9f30mr28014775ad.1.1737100415960;
        Thu, 16 Jan 2025 23:53:35 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9efb9sm10664315ad.45.2025.01.16.23.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 23:53:35 -0800 (PST)
Date: Fri, 17 Jan 2025 16:53:26 +0900 (JST)
Message-Id: <20250117.165326.1882417578898126323.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgjwTiR+qX0XbTrtv71UnKorSJKW26dTt2nPro6DmZiJ-g@mail.gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-5-fujita.tomonori@gmail.com>
	<CAH5fLgjwTiR+qX0XbTrtv71UnKorSJKW26dTt2nPro6DmZiJ-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 10:27:02 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> +/// This function can only be used in a nonatomic context.
>> +pub fn fsleep(delta: Delta) {
>> +    // The argument of fsleep is an unsigned long, 32-bit on 32-bit architectures.
>> +    // Considering that fsleep rounds up the duration to the nearest millisecond,
>> +    // set the maximum value to u32::MAX / 2 microseconds.
>> +    const MAX_DURATION: Delta = Delta::from_micros(u32::MAX as i64 >> 1);
> 
> Hmm, is this value correct on 64-bit platforms?

You meant that the maximum can be longer on 64-bit platforms? 2147484
milliseconds is long enough for fsleep's duration?

If you prefer, I use different maximum durations for 64-bit and 32-bit
platforms, respectively.


>> +    let duration = if delta > MAX_DURATION || delta.is_negative() {
>> +        // TODO: add WARN_ONCE() when it's supported.
>> +        MAX_DURATION
>> +    } else {
>> +        delta
>> +    };
>> +
>> +    // SAFETY: FFI call.
>> +    unsafe {
> 
> This safety comment is incomplete. You can say this:
> 
> // SAFETY: It is always safe to call fsleep with any duration.

Thanks, I'll use your safety comment.

