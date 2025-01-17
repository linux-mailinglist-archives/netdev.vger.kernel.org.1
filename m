Return-Path: <netdev+bounces-159115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B242BA14706
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6AA3AA00A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A751C32;
	Fri, 17 Jan 2025 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfxzGhmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644A8828;
	Fri, 17 Jan 2025 00:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737073776; cv=none; b=OSrS6TS2TtK3uDsCCjnSp/ngpDTrh+5lkTQ7GupYdLi2B9USIxYFDDySTHRRs7NaopM+NxJa+QsmNRyUnJ/9zwJ/tOa35s97QslnBMwAMzhB6M7HNRqvs4DCkOWAdnn3JfXIynHZ0kzSZWbNVTQJfF5YXqhTl2GgKMcIph4nxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737073776; c=relaxed/simple;
	bh=4akI33331U/RQHO6RNjQrgZp5mWYbnDsJz0cnGXRpWE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ihaS72EOwSpVkqS3sbOsb6GgsuEJHXLAPXyy1/qXg3Wolp9ldITcD0MP+lyGG29DYkTe6RIipPoRzJRc0/x9vPimPQlghzBmyvzsH/ykgK12PJ9syMT+dFcSu64DHzcUMVy3SzKVQGClpS3nBGl7QYPPHL4gulXGY31d9vgpY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfxzGhmB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2161eb94cceso18836815ad.2;
        Thu, 16 Jan 2025 16:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737073775; x=1737678575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4akI33331U/RQHO6RNjQrgZp5mWYbnDsJz0cnGXRpWE=;
        b=lfxzGhmB89krCoN7R8ZlvmLB9YFvyqRZqIuW4qAS4X+vreeAroFhmDXQk8ynbNvWUi
         f0Asus36xCOy8opPy9IxhpwPXmfk9Kqy7v/DCLF6c37XOssL7XUau30qZWl9tR7/WSOK
         j4bguVTvSwUazxSuI25pNiLDQY5nMVABUTV1nvcxDupIM7udw7+jCd+VQRXhCU7qGs8W
         zn/ux2FEvxeW3eNn1ZmGHJisVigcCcDoEtRGxAX95gH54sTgPhd0NutAlRAWCHw9t/jI
         d2l9+xdEFQjF5z57EDYt6cRSOJg+c4m3ICqMi7SP6SyYMKRB0s2dr+pxtWL6+nrM8l9Q
         f+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737073775; x=1737678575;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4akI33331U/RQHO6RNjQrgZp5mWYbnDsJz0cnGXRpWE=;
        b=Jh5kZO6vAAMD/zPe+09jb3O/UeFOUHwY0Thov6IP5DOqTYHHluNZwvwC0J51TTYd28
         bdEj2f2Der8RvjXG/HB0Jr6Q+nX0nI6oYE11r+6tOjj9zFSNDmRrtZXJv1GaHjqhgmQb
         bB5BqDtrgreR1629ijDFfm9C4adm6t1TEX/AoXnHBjI86IEW5Lhp4ippqGdaWyAiDkYE
         prU2z9NTFTRFTaT2vHyxXuF5dPxc2zXUlbihzhPIMsm5JBcGE27DShFEPQLT1sQIXPSA
         umcqn8C3wfUTcySpo14yCyf9NXKFBMsv4kD4xtoxBo15JoZR+oMnVIPNlj86pH+4+0h3
         raRg==
X-Forwarded-Encrypted: i=1; AJvYcCVMdHyGPYj3siCRQ75NKw9sJdlgj3QTajH+LXZ9bVPh7MjX0vzhSAzTiDeG5iE+iZKyryZgMRKQ37o01wr8LR4=@vger.kernel.org, AJvYcCVMptpCadh85gERSU6BWdxqtc4BbpBc3dumxCGRYH/T4Y6J8H5TAn72IiiWJVS3hYfCvDuIeF2R@vger.kernel.org, AJvYcCXH1IZUuXHa78WJkMzvF1G2IJme6FkGXgnYkwuYR2dTEzCGluWleF6v5niwsI0nnx3yH9Lq3wXfKifE/JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIm4jp69qnJBtWFipr2sEpqIrb75jSIpkAm7UNqmqbehhv7Dn
	ycsnSzOHyGGScavQu5CZMznimyTI4z1zM7y3MRFKH3tIoOEd2uXC
X-Gm-Gg: ASbGncu203R1TOnuz/EKT/WXILrPvhM02SuMEK/do8mHNMLFdl/x+oOi+gtYK8Lnp88
	FQKrI2XRFkoJq28fnYxJ4tEqRAWPnn5beoGyn/pJTQeCZ8lBkE27gwTIJeQrIu6JGoZ5VuPTIFX
	rQfuon+7DygGDnqdvqk7Nj7x81pdsLs6AzUQQwJGhTSiF0Zy3A4M9CVEBBjSfP058bnh/C5IBba
	oqYHAMgk8fAcD0JNOdwlhXYzTcQLeYiSQIkWG87I2m2gGX9K28txmXyZzqNdN1khWwSOYnnMYCp
	D0ts1CrGXw8l5REKy11K5Tze7yhGIEAnSEJ9mA==
X-Google-Smtp-Source: AGHT+IGfpWVgLIeJkOamAn/2F5sE3urf2c0AOUvmMZuqPbRBJpPxW4N27EVmdxU8erWI362nDaadfA==
X-Received: by 2002:a17:90a:c883:b0:2ee:d824:b559 with SMTP id 98e67ed59e1d1-2f782d35addmr823038a91.28.1737073774923;
        Thu, 16 Jan 2025 16:29:34 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7761a713fsm720614a91.25.2025.01.16.16.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 16:29:34 -0800 (PST)
Date: Fri, 17 Jan 2025 09:29:25 +0900 (JST)
Message-Id: <20250117.092925.774975674138617203.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 andrew@lunn.ch, rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 2/7] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=pm4L_eU74S8_-SBpQWGbFM208FNTP_Vm0bSLEp3rjPg@mail.gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-3-fujita.tomonori@gmail.com>
	<CANiq72=pm4L_eU74S8_-SBpQWGbFM208FNTP_Vm0bSLEp3rjPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVGh1LCAxNiBKYW4gMjAyNSAxMzo0MzozNiArMDEwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBUaHUsIEphbiAxNiwgMjAy
NSBhdCA1OjQy4oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiArICAgIC8vLyBSZXR1cm4gYHRydWVgIGlmIHRoZSBgRGV0bGFg
IHNwYW5zIG5vIHRpbWUuDQo+IA0KPiBUeXBvOiBgRGVsdGFgIChoZXJlIGFuZCBhbm90aGVyIG9u
ZSkuDQoNCk9vcHMsIHNvcnJ5LiBJJ2xsIGZpeC4NCg0KPiBCeSB0aGUgd2F5LCBwbGVhc2UgdHJ5
IHRvIHVzZSBpbnRyYS1kb2MgbGlua3MgKGkuZS4gdW5sZXNzIHRoZXkgZG9uJ3QNCj4gd29yayBm
b3Igc29tZSByZWFzb24pLg0KDQpTdXJlbHksIEknbGwgdHJ5Lg0KDQpUaGFua3MsDQo=

