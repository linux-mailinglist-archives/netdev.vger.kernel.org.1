Return-Path: <netdev+bounces-159195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D601EA14BB8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAF13A8E6A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F51F8EE8;
	Fri, 17 Jan 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO796tFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651491F790B;
	Fri, 17 Jan 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737104518; cv=none; b=WthdoI7bRt9D4UofL6FcUFSOc4FTgHN5ZFIu31E6nmA3uyYmrvNGAkJTlp7bHYptp2LguInW5GoztJb4MukPO1ftAxkKmSmnuRDniVCJmVKIpDSNZjSp++PsIkNCCdW03C6CqBksoEcAw40Asmjr3ROoYXQbl16GR8/h64wvXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737104518; c=relaxed/simple;
	bh=hFcJTz5hsr8kdPCQH3dsbYIvJogJXcoHdr7EvQHqxEU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=opqz6SHdvvvNZH6O1NJ1XS9LSFgi4UOhRljDCesLCzS0A1G98znpQ7AfXj5JucgJsQs1ETSdzCs3qfplkhFGQjvg3WGmomxRwUKlgSQFgR1/X1hN+/OX2Ewd6DFEFsOSfPJnlSJd8RYSR5+ufvf2tusu7cQ4htI0VEf+/25Sfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO796tFA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2162c0f6a39so57533015ad.0;
        Fri, 17 Jan 2025 01:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737104516; x=1737709316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3A0m5QKzpyHbRzSR3DmcgEE5q5ElazaIe2Cv7srEXQQ=;
        b=fO796tFAunrm0NFeFp8H/PYsDbzgx7ndO3nOxSHgbl0f6Z9yrq/Zy7WPaxvS565EH4
         CmaU0lrYVkMVItc7fFqOKdqVND7uKAOGR9T5y5WD0uQuqJZ5KdGT09rKmC7fbipnXpnV
         0TVwTrwPlkTk6nlLcQ6PeWUchd15XpepA2RitQRtRDZsKq+9ivTwKAirLhj4Xhku5+KM
         72ItCGGQ7uYWeVwpd+BF49FxMNGWqgrsa8qj82z+YG3bXAm1K/rZoqC5H+trgE2qNRw0
         TGYQtUEVW2ikA/mr7z8DQdZuBwnuzyIYY0KZiApiZ/EKWE+WAoGS7jxIhWfZ6nvWvWx/
         BdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737104516; x=1737709316;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3A0m5QKzpyHbRzSR3DmcgEE5q5ElazaIe2Cv7srEXQQ=;
        b=VVzGeepUMU4OoZGwEbZf/SKNGjECQk35FjTaeU9H/1HaFqQM4IeqbXkCl2IaowTzFT
         SHyR+E659I+BsjBvo+PMT1du9HkGtW59MJkOa0x/FZ0AQSf9padtgzij/n9/HAVg+aT2
         LrmXfcGPARSvEp1AGXXABnp8BGRwRAuwYCTAkqeC/XyIcOtc/HKbpz0rtnhPa8pyhMQ/
         AA32SQ3vYMOrML3pX6aON8OHqSV5kUuszAJdvrbHpE9RbmQgGz+rnQmpnSADYHUgyXz5
         S3kEaxW+KJv5dxMSrbxZo3FXEtsU+d+NCLT0VwvtQjp/6OrSnHrRDepWo7vANr9pzdU9
         XIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZYydPPLRVYMOzU1NgYSKbcLdIZIpScVPhBMyPgpoL7+QUIsaxnUEdLazhnmlAvK3YWQFSGveLrEFkwp6Zxs=@vger.kernel.org, AJvYcCWokDo6Bb1+gC+9ifVeIqrhNwUXnnytuQQqwicBRPFh2sT0uppjMwYgL/vzlKpG6DOFWj+j90s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBqTyDhzAlziaF5NF07PTwD+Dtkv53P4cKNiKnGr9QcazbrVd
	u4BIBqB/07cS1tIuCdKHteXmj65UM1S+GUHONMe26IMdqcqnuSlH
X-Gm-Gg: ASbGncvUMOORN3HpfpSPg3ll5SlsSvIQ9jW2raObEOe30MC4hHIIlgkm0QJQexTSR3Z
	z3iYIQRIAQaZTm5UoFhX2CzXx3Co+PhZurn4F4+Zq6oulfIjufzEVni6A0gQO4vmdL4wjIiCo1A
	2sDMd9yl8h9jcw5DF0+AVt0Qc+A/ftXLD1Xjjs+g5ukyigmeOXylsOSOtyJWosd+SNt/XI33nPM
	LnlO+fZaCVKUfdE+7yVnhESdj5o7t8x6UKMD3AFZ9SJrC0iB+7zdPthVmGAYdHl0ixd/aH0P4n6
	3llPJNjFdP5oOfSq2BxinlXhr8thO6C2CxYGXQ==
X-Google-Smtp-Source: AGHT+IGVkMn+CkArooloRAbkXppERQH1xx/5PHNjh7Qg2q97Sxprfpx6+xFfk8/WAi4k9KXg9LKinw==
X-Received: by 2002:a05:6a00:ad2:b0:725:f359:4641 with SMTP id d2e1a72fcca58-72db1b311cemr2398551b3a.1.1737104516470;
        Fri, 17 Jan 2025 01:01:56 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f0436sm1355361b3a.22.2025.01.17.01.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:01:56 -0800 (PST)
Date: Fri, 17 Jan 2025 18:01:47 +0900 (JST)
Message-Id: <20250117.180147.1155447135795143952.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
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
In-Reply-To: <20250117.165326.1882417578898126323.fujita.tomonori@gmail.com>
References: <20250116044100.80679-5-fujita.tomonori@gmail.com>
	<CAH5fLgjwTiR+qX0XbTrtv71UnKorSJKW26dTt2nPro6DmZiJ-g@mail.gmail.com>
	<20250117.165326.1882417578898126323.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 16:53:26 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Thu, 16 Jan 2025 10:27:02 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
>>> +/// This function can only be used in a nonatomic context.
>>> +pub fn fsleep(delta: Delta) {
>>> +    // The argument of fsleep is an unsigned long, 32-bit on 32-bit architectures.
>>> +    // Considering that fsleep rounds up the duration to the nearest millisecond,
>>> +    // set the maximum value to u32::MAX / 2 microseconds.
>>> +    const MAX_DURATION: Delta = Delta::from_micros(u32::MAX as i64 >> 1);
>> 
>> Hmm, is this value correct on 64-bit platforms?
> 
> You meant that the maximum can be longer on 64-bit platforms? 2147484
> milliseconds is long enough for fsleep's duration?
> 
> If you prefer, I use different maximum durations for 64-bit and 32-bit
> platforms, respectively.

How about the following?

const MAX_DURATION: Delta = Delta::from_micros(usize::MAX as i64 >> 1);



