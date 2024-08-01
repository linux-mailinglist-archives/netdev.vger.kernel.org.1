Return-Path: <netdev+bounces-114773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A2194409D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B951F21FE1
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C8042A8B;
	Thu,  1 Aug 2024 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6B4RHlo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920310979;
	Thu,  1 Aug 2024 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475322; cv=none; b=FnuJuiEXNPwgP6vSGbYgTE2FO5n5KJ8ZkPut0MFAS+FM12tWC1V3z+DjHLWU9CmfnwVVHVWI1lJrhlY0l6nRrAZS4fhM1A5h6id23XJAJkA6nZV8QDuPx9MjkLJcLP0yW0klwjVQCm7Tq7bW8wktg6vgpz1phgCt91KAdiXN71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475322; c=relaxed/simple;
	bh=QMl40B518A1bHhCb+JtSldRX80r07t5zTPu5e9wOqb0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aLEXpKovzavjijB5eb+WSKh8/OakyNBLzISanyazmL0Itrj9OfpSwWPxjMx25FzciaEwckrp7eHgdBomEGmn607VF/3sbKmxp5IL06G3F2bkmdIv0wXb8ZUyto7pEJOThzFLnp70NU+RzTbCXRuqkTDdqo6oUnwQbfzgaPDL2+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6B4RHlo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc53f91ed3so2984115ad.0;
        Wed, 31 Jul 2024 18:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722475321; x=1723080121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpNgRuzmu6fNnnwXc6CBDTtU2zTgAmXlH2oDM59VNpA=;
        b=k6B4RHlozHAUjYJmJIlYXQBN2oBrUaRz1+PdOW0PMlpmIFjP/3IS8UzFJ4vTKGhW3Z
         jk6nwRvT3e6PKJTywN58gTpRMGWF17rNVJO2cbTwPz7r36DUpRgmMxWDO379SA4EQk8W
         H7vI9NS3NhdFkq0f7Mx8Zh1+0BBbajRvQvkEXbRiQjV33slAbht/3PTowiYEBcK/R16t
         0qcwqyaLVPcAfvY5ceTzP5TpfxcM4OV0tmueurW2ACrRc5jKIAmni2oozTi4kXawjbhJ
         l3IUNuUtweorUF9sM6lyxG/4KGSEq92Cw4e9eQl8Aaw1AUemrJboIryx5Jdmpcwy2lPw
         SW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722475321; x=1723080121;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GpNgRuzmu6fNnnwXc6CBDTtU2zTgAmXlH2oDM59VNpA=;
        b=nkcgNMoBsKthlHOMrzC8bIXT6+xNaYgTc8+sUJwHtr9sPzs78GMMQ88+AOHz0mcy+J
         360O9+e++lBDjTwfEkIDJZdfwtEMK8A3x/F7P4i46NMXn8Z+TNC7L6br5oIX4QWzw9W4
         C8nGofcSPOOSJGpR7/kRJ3iJPPyNxHIWbYcpWHM0dcCrVLPJB+fOD/DJQ93HFRMu4w5K
         5KN99nRF7+TfHA2BZ+swF3oP4E28fSHzLtP9bUDHwunvJalYHhJhJ3fY9BX2AC+hYESA
         l+Sng8Qo563a/eFr4XU5WAPk5wt/XLg715GsS98vIEoA3eRvOcC0AHK5PvgvAbjFMRk+
         2wWg==
X-Forwarded-Encrypted: i=1; AJvYcCXnlJ8ynIz6oC/MU8nGC6QNWz4PN9Dv+1tPYAvLmPlS1bGiC6LdIXKt4iSkOoX+Xx6LXruz7f5rLXgZULgrdIgB+s4n1HNPWn76cW2PcQqIs4CgnAXe9Dw3gn0BK4XFj2vZEDHr9XQ=
X-Gm-Message-State: AOJu0YxpcFO0/WDd31K6pmn9rX/w+uJkI9gkRuAtfrcoJ8yyOb298r9+
	Xbk6ZEH9Z+hZpU2LEmBhDNYGYF0S6PhxXSgMhs9bbhMJb07xG2Yd
X-Google-Smtp-Source: AGHT+IGxZAa39/oZ5SvY4JjgRduHhKnp4M6RjhwX7J7QZ1rYPwlLVOQEUIhdrRjEXFOKzS9hOmIDkg==
X-Received: by 2002:a17:902:cec2:b0:1fd:a54e:bc41 with SMTP id d9443c01a7336-1ff4d2af358mr7859045ad.8.1722475320525;
        Wed, 31 Jul 2024 18:22:00 -0700 (PDT)
Received: from localhost (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8cbd5sm126933325ad.57.2024.07.31.18.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 18:22:00 -0700 (PDT)
Date: Thu, 01 Aug 2024 10:21:46 +0900 (JST)
Message-Id: <20240801.102146.301991981941433687.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me
Subject: Re: [PATCH net-next v2 1/6] rust: sizes: add commonly used
 constants
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgiGAqMTL9mRA_3RXZULV06KF+FJRxYMHC5xsE_=od3Azg@mail.gmail.com>
References: <20240731042136.201327-2-fujita.tomonori@gmail.com>
	<6749fc34-c4e0-4971-8ab8-7d39260fc9bb@lunn.ch>
	<CAH5fLgiGAqMTL9mRA_3RXZULV06KF+FJRxYMHC5xsE_=od3Azg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 14:30:23 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

>> > +//! Commonly used sizes.
>> > +//!
>> > +//! C headers: [`include/linux/sizes.h`](srctree/include/linux/sizes.h).
>> > +
>> > +/// 0x00000400
>> > +pub const SZ_1K: usize = bindings::SZ_1K as usize;
>>
>> 1K is 1K, independent of it being C 1K or Rust 1K. In this case, does
>> it makes sense to actually use the C header? I don't know? But the
>> Rust people seems to think this is O.K.
> 
> Shrug. I don't think it really matters.
> 
> If using the C header required adding constants in
> rust/bindings/bindings_helper.h to actually make the constants usable
> from Rust, then I would say we should just set the constants from the
> Rust side. But in this case using the C header just works so I don't
> think it's an issue.

Either is fine by me. I'll keep the current version if nobody has
strong preference.

Thanks for the quick review!

