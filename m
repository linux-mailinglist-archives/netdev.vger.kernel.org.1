Return-Path: <netdev+bounces-136549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1409A20C6
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B74E28AB35
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92411DCB0E;
	Thu, 17 Oct 2024 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyxL0/V2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744081DC75D;
	Thu, 17 Oct 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163775; cv=none; b=IEYJsuShrSp9Q2gnn+H6k6uf4XGAOUeGcGVe0awQz3jAzrbj4FiM0dBh0SxaKSIf174y1/HZa5dNQQd5iRxa21bhf0WT0a8v5X/5esQDs3Gkc3nCOFXv8epLpM3jgE+egWPwZjsP7llpBBJyZg5CXG6D0Acay4QsWwCi6vLdEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163775; c=relaxed/simple;
	bh=MVcY82cIZG9mlYifVoTi1EvokZakZYMQ2lfNC695WYE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DhP2WPmrKT8UdlekuZ1aBW8gJZIsPInlQnZwx8g9h8bUXKVR0vmfFByzwhhin1RZlJMA1wdnMBOlJ0UIRV2zn9ZkN9wNG8RI5nUAMC1Uzuaz5NEydPFj3X5PFqG4htjaQKXj3wcDsCaNJ61F0mHoOCJ3ZCFJDi0ROXuljMHVQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyxL0/V2; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-656d8b346d2so559953a12.2;
        Thu, 17 Oct 2024 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729163774; x=1729768574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVcY82cIZG9mlYifVoTi1EvokZakZYMQ2lfNC695WYE=;
        b=XyxL0/V2Jfgu0xLN9o8TRFfBPFb42KjQT63hIvybHfJqSuIiqSuVS6F3rWpBb8tY8R
         B2E3JHsKHv8ZBiwe8Nf9ZVfPu6a5pjOSfoPUXxOkEnGpt4OgVZCuVL8INmjVvn9J0+MB
         9AOr5UF5jFe1XaPhdgdh11vgIRJCuWh8hicdY/Nb10qWFyguISB6LBWOV9V8nUOSNCgQ
         POmUp9gB0hz2BsR9pKZgSbyQkV2w1gEIpmkYWJ1V1KUKsyv5qLYRSOp9ajtnPHAI4MzO
         aUOPDrnwp8r2UBz7PwB3PlgVeznzPTsxUGfh4sUYCDSEokR7EGHm7BYktXronIPzLiww
         Ie1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729163774; x=1729768574;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MVcY82cIZG9mlYifVoTi1EvokZakZYMQ2lfNC695WYE=;
        b=UQclnL0Fk1B46nXFtDsfvY5hPZE8186v7MtbPhkodRxTMxs74p7Pk83PZorVF/zn4D
         fLePs6cNL9AYVhPh7PTzxXrIFExEB3UqT+5jvLksWsWBGjebnMzXojjwoBJPQCpWqmy2
         OvFUfG/C0rSVHUfDgPbvsw2M8whFtA+KfNoX+khPunZgOrE3CP9kD6HXeBpCVKGfcjU0
         OKDIm+I+3fRsz2vq56nRaMwhjXFWbZBKCsJTLYLvb0Od7UpGZmVq7V1TTECjdKxAO3Y1
         v5K5RVr1525Ei0HllAlghqIx+yYSjd8sX/LXw9A3OcMX7ORAMLf3sx5GlnZd+h0YLhFB
         2j7w==
X-Forwarded-Encrypted: i=1; AJvYcCU4q6R6wygZwQA4dKWQZkMmZ1cSGyWz7Tqn+3LfcVIanoPMxopAtwIHkczu4sYVuBsOgGX20E+B@vger.kernel.org, AJvYcCWvStcvNi88kkP0O1mS0qHOrdeFaEDT68zAI85w0T5J1YB09CxKW0iQ4AVRom6xNzP+XP0XzNBiQkqFY6A=@vger.kernel.org, AJvYcCXIjXe22yeMm9XLp03Y3RqqsB2g9kpWpXlzSVwhj5dbkmnbB/oFrPWF0Ec1dqQNvTRlKszgQ33LsRqsOVy9yyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOAsidM2yJm1x9kWrAtUg36XxACaOW/ZUHXTb/JiVdj61z3Zu
	E+zp3KqSMHQI6TsnCX1u36tu5FNEa/jYtXECzz73TZw42u/NaQPH
X-Google-Smtp-Source: AGHT+IFY7LSDfZTK58hwjvImx78kf3TN0bOB+MAEYLId5hNM1j2AME4py/JxqoZB/K8O+elsmS/rlA==
X-Received: by 2002:a05:6a20:1924:b0:1d9:2269:c3b8 with SMTP id adf61e73a8af0-1d92269c828mr1383522637.42.1729163773735;
        Thu, 17 Oct 2024 04:16:13 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a2b2bsm4511872b3a.111.2024.10.17.04.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 04:16:13 -0700 (PDT)
Date: Thu, 17 Oct 2024 20:15:57 +0900 (JST)
Message-Id: <20241017.201557.144371392063010807.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgirVk+9aiJGgXe=ikT0i3XKEiXSSPVQr4ZUD+0sKrU6ew@mail.gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
	<20241016035214.2229-3-fujita.tomonori@gmail.com>
	<CAH5fLgirVk+9aiJGgXe=ikT0i3XKEiXSSPVQr4ZUD+0sKrU6ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAxNiBPY3QgMjAyNCAxMDoyMzo0OSArMDIwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFdlZCwgT2N0IDE2LCAyMDI0IGF0IDU6NTPigK9B
TSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4NCj4+IEludHJvZHVjZSBhIHR5cGUgcmVwcmVzZW50aW5nIGEgc3BhbiBvZiB0aW1lLiBEZWZp
bmUgb3VyIG93biB0eXBlDQo+PiBiZWNhdXNlIGBjb3JlOjp0aW1lOjpEdXJhdGlvbmAgaXMgbGFy
Z2UgYW5kIGNvdWxkIHBhbmljIGR1cmluZw0KPj4gY3JlYXRpb24uDQo+Pg0KPj4gdGltZTo6S3Rp
bWUgY291bGQgYmUgYWxzbyB1c2VkIGZvciB0aW1lIGR1cmF0aW9uIGJ1dCB0aW1lc3RhbXAgYW5k
DQo+PiB0aW1lZGVsdGEgYXJlIGRpZmZlcmVudCBzbyBiZXR0ZXIgdG8gdXNlIGEgbmV3IHR5cGUu
DQo+Pg0KPj4gaTY0IGlzIHVzZWQgaW5zdGVhZCBvZiB1NjQgdG8gcmVwcmVzZW50IGEgc3BhbiBv
ZiB0aW1lOyBzb21lIEMgZHJpdmVycw0KPj4gdXNlcyBuZWdhdGl2ZSBEZWx0YXMgYW5kIGk2NCBp
cyBtb3JlIGNvbXBhdGlibGUgd2l0aCBLdGltZSB1c2luZyBpNjQNCj4+IHRvbyAoZS5nLiwga3Rp
bWVfW3VzfG1zXV9kZWx0YSgpIEFQSXMgcmV0dXJuIGk2NCBzbyB3ZSBjcmVhdGUgRGVsdGENCj4+
IG9iamVjdCB3aXRob3V0IHR5cGUgY29udmVyc2lvbi4NCj4gDQo+IElzIHRoZXJlIGEgcmVhc29u
IHRoYXQgRGVsdGEgd3JhcHMgaTY0IGRpcmVjdGx5IGluc3RlYWQgb2Ygd3JhcHBpbmcNCj4gdGhl
IEt0aW1lIHR5cGU/IEknZCBsaWtlIHRvIHNlZSB0aGUgcmVhc29uIGluIHRoZSBjb21taXQgbWVz
c2FnZS4NCg0KWW91IG1lYW50IHRoYXQgYmluZGluZ3M6Omt0aW1lX3QgaXMgdXNlZCBpbnN0ZWFk
IG9mIGk2NCBsaWtlOg0KDQpwdWIgc3RydWN0IERlbHRhIHsNCiAgICBuYW5vczogYmluZGluZ3M6
Omt0aW1lX3QsDQp9DQoNCj8gSSd2ZSBub3QgY29uc2lkZXJlZCBidXQgbWlnaHQgbWFrZSBzZW5z
ZS4NCg0K

