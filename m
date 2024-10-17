Return-Path: <netdev+bounces-136476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B69A1E6F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0087285926
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B131D4150;
	Thu, 17 Oct 2024 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTQIEI2i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938BF12DD8A;
	Thu, 17 Oct 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157518; cv=none; b=uAmtpWkJbKhnRmZdRpT15xHb7TYKk8IAcO0OU6GvZ9CATj+4oGTuCi75cB11lpmN2Ojm8lJXmFx7OWWmNWmPR8fo0NNSKEx/T47lWYHHuMQXyBWG+UBPPM+GAQUeHxijGJgeaHY4aVt2DFfGA0dxiKfyN45o4jUi+ywrH8Yo4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157518; c=relaxed/simple;
	bh=Azrfnx4dkIKaqXi3xjEg+tYVqbFMmUOo5eoV4jcn9is=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hWa5NjR7w7VWKR4M5iTtHPrYtRdQ+FDBwgR+jLHgcm+VUfJ75HzRLifhnQoH95/rlTvnVHPl6sYXw4gwaMLOwc/YTLf8Y4osc1u2spTsYZiK3NmV6ihKmDvg5ktcaIXP0AEofR/izrNBKBVAjQcdAM4QoNZyJmXHERztcW+p+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTQIEI2i; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf3e36a76so7443835ad.0;
        Thu, 17 Oct 2024 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729157515; x=1729762315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tN++gsqAlKPKPGgxXBW6D+DyyXfnHxCWQvMGhN763v0=;
        b=LTQIEI2iAU2FqsiHhNYXQpKJ0qTLScWoPQgDaSDuZ1jqqlw3J9Wm/94KTNwhY14wt9
         U/HCzvulgY2hUpM8mPLBOq/JTU9TXAd8Nb4eA8YmoFYa+XbgmJh9+9hPR9r/yMZ63lIq
         0Vsybv3m+3z53qAGnpxG6BUH+PP8+S274E38TzjS+6yghsYSAin6y7j3fhwrcKwdhHWn
         it1dV5zLrdV7Cxq+XcGac2ODSDK7kNV2Z2BSdXNaUAnR550Lh5n16mZ1Ew2bJqCu4xGQ
         EV6ilNyLKSf1GosuBq/AFQuwlX7Y0Jlqg0uzGK4bQP+ITICrJFip0lIPVoPrOEoCEIOx
         Uo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157515; x=1729762315;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tN++gsqAlKPKPGgxXBW6D+DyyXfnHxCWQvMGhN763v0=;
        b=Lmc1+YYok6JnyubpxBJJJVqZGXhfrSzeXklYqb5jpkljHfqfUhBA5zWRjFKIwX9eAM
         KkJllo2kV7wgyWPoLpR3fdn4wodHExs+eyKrWQnRxnBddH/zonLM78iX30IjejEcReiI
         FZwHJG5pdMEGkd4TkH4AqE3dS5SmIXUkpMWlzEC7DItGk4O0TY299OwLjyAE6NcdmLfv
         TleERDuytM1dhrNbGkuumnY722Crn+/5r54hu787O8HWpxNnt/K3aGj7BD2SsKK8Ka1T
         LAnmPhIImIqZR1ioD4g7lBjYIvMPB07kViMNF3+gE+AkvHse537c6fFy6sRWhfytVk8z
         E8Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVOJ5SEfi9QtY1el5FzUmLD4aMTeIXkYsem8YqOjXChX7tKYf0Dq5kxZGmOPyGqZNOc41ALA0J+@vger.kernel.org, AJvYcCXnroXj4sV4vlMcDuLR/H1pWfhQh/rU7rnMBXCXHQVN69N812VcDs4bZaaBWCf3AcFdkQ9WYhX8jLcEcW4=@vger.kernel.org, AJvYcCXofPsQ3wc9bdJka/1ZBhyA2W9fd5ji5XsQM7dK7oa6iqr8j31rzLAzTZDLG9bu5m4rUenMrRvw5X3zGX1bmC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTE8DF4/6ks5vlG4Imd8VcsEUC0AdrbZ+7Tqt/L9ek4S8/f7Qe
	zLV/42TadbStZ26ipjlvppWE4bRxIHeTUXMmmmEiMOqiDKzhAz3z
X-Google-Smtp-Source: AGHT+IHWu4sce8SXvMI7k7KC6MwT7KYqEZrczhbNBoZFfuH7eqzrDyQ5IFDbRuE9sYEM1p/hft9bUg==
X-Received: by 2002:a17:903:2301:b0:20c:7d4c:64db with SMTP id d9443c01a7336-20ca16be1f5mr326084545ad.49.1729157514823;
        Thu, 17 Oct 2024 02:31:54 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17fa4cafsm40580725ad.65.2024.10.17.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:31:54 -0700 (PDT)
Date: Thu, 17 Oct 2024 18:31:41 +0900 (JST)
Message-Id: <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of
 Ktime and Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
	<20241016035214.2229-5-fujita.tomonori@gmail.com>
	<ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 12:54:07 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

>> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
>> index 8c00854db58c..9b0537b63cf7 100644
>> --- a/rust/kernel/time.rs
>> +++ b/rust/kernel/time.rs
>> @@ -155,3 +155,14 @@ pub fn as_secs(self) -> i64 {
>>          self.nanos / NSEC_PER_SEC
>>      }
>>  }
>> +
>> +impl core::ops::Add<Delta> for Ktime {
>> +    type Output = Ktime;
>> +
>> +    #[inline]
>> +    fn add(self, delta: Delta) -> Ktime {
>> +        Ktime {
>> +            inner: self.inner + delta.as_nanos(),
> 
> What if overflow happens in this addition? Is the expectation that user
> should avoid overflows?

Yes, I'll add a comment.

> I asked because we have ktime_add_safe() which saturate at
> KTIME_SEC_MAX.

We could add the Rust version of add_safe method. But looks like
ktime_add_safe() is used by only some core systems so we don't need to
add it now?

