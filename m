Return-Path: <netdev+bounces-119714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F513956B10
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF88281AFC
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F716B3B8;
	Mon, 19 Aug 2024 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBcrUdh8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72C16B396;
	Mon, 19 Aug 2024 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071290; cv=none; b=sP/e4FYgszqxA2E8Zxz1r3+7Ti94zeTqIwVnB7XmijR1lp61lSNrOXIuAY8Nqk1BcOKOZ8lFVV6+opIeTLl0oSaPstZd/8HcdSjKdJSV3aCd+Orhs1uMh3Y8SmwRzpJ2zt4sEmBkvr+019HqjIqkfO587sNA5GySIfF/st0q6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071290; c=relaxed/simple;
	bh=lRaPX6S1bZ8indFiMb4mf48fCGz25lNpXfx+CkGAmB8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dJIcqyAtsLbiMgcTERFgjsfuwUlCd++eYbrTfApnTFtoSsw8hnsNVXsGiLo589yyHV6Lq6UJIlX+u2SSXXUuMYltiNeSl8uFEQYZfm4+FxyTmuFk6YlxYOnfskP1lL0GFn/vjtdo2s83c7ijdoPdqTir/uhKiTeO2bWM5f2vunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBcrUdh8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20212f701c9so1712245ad.1;
        Mon, 19 Aug 2024 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724071288; x=1724676088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRaPX6S1bZ8indFiMb4mf48fCGz25lNpXfx+CkGAmB8=;
        b=LBcrUdh8i4ZEZxdGVdsIzDz1ykhY5IqY4mF7KA8qYBO0EvcQLNaeskszH8l46lNxjJ
         5YYy+6hdijG2ON8qN26wHxxY/M9oXDZ+jtJqHsV8ltps8EWrti7ftKr/OZaI62SltfCo
         2cAGXSPaWx9MJRPXamwF3ZvoWGQNMaqMBvipkV+7Z0SCzhMiSUzDOBvk5DWq2+wf4SkZ
         mT1cVG6gZFq9wBctvl/F9nJssXaMTJMnf2v+MuDuXCWTDcD9dDvqO4qUBkOUaCaXIEef
         gmRjegh1/GB4WlHATlHIhsY4h3ObgLNCv337epTfu6QhbUrbmq+Ew1/JVmmVnMWbPBdL
         GBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071288; x=1724676088;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lRaPX6S1bZ8indFiMb4mf48fCGz25lNpXfx+CkGAmB8=;
        b=G6uq9ilQxyI6IaF3FMiS9PmCX2V/rmELToNJdRJSe7h4vhw0VYKUjer8M8fDx+zM9/
         csUD6SXVq0lJSbSGhJobA3UNnVUK2q8t4Ynk7D1ZFyMBrYJ/QrhsCPbZ6e7nVtNwmygd
         Rxm45dvABRo9BF6P0kKz9WLu0E2TuTX4lHs7TeiAZ1SwrAf8rSpLUv+/Hg+t2WbrFSgL
         VbK3BE+aFk/SNZrJRmM8nfTCXElQq3gzngw1G4FCwiNPOm/PZ1H+TiisZWT/aZkhvSHo
         s3LXVwQq/PFuNJZp0DrG+0R++HPga4sxyekzts83oBkLYbEBaniHgBkhLrGhiOm+iCkM
         LbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdtQ9PBivTI+3Dk+RA+RhUedCc9Re5FmDMsZ3VclrfQoig1qcoM29sqVTAjkjSdhN/UhpGwGtEmhEoVnutqzmt4ZWYR57fGqeWx/yiZaqtXH5qU3g6Kw84NlaXPFetiw7EVg/q0Bw=
X-Gm-Message-State: AOJu0YweXJi3FUIEgexWOudbqjrSDn9753ZapCNNMiYZzuW5hBRwl8Pg
	5Fdnr3oiZF1pLnogni9xHUGpTEely5pmnLKAyFxjF7zlRf7FYIOF
X-Google-Smtp-Source: AGHT+IHB087+0ykuohY71edkUQhHL9oXB6wMzHqn9CYQaSbAwH6U5RW37/Vr7eJwZII7dMPqzbEh/g==
X-Received: by 2002:a05:6a20:72a6:b0:1c4:84ee:63d1 with SMTP id adf61e73a8af0-1c9a2a975e7mr9391801637.9.1724071288058;
        Mon, 19 Aug 2024 05:41:28 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f039e9ccsm62082535ad.247.2024.08.19.05.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:41:27 -0700 (PDT)
Date: Mon, 19 Aug 2024 12:41:13 +0000 (UTC)
Message-Id: <20240819.124113.785655943995048226.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v5 4/6] rust: net::phy unified read/write API
 for C22 and C45 registers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47tLDD2SQDeJ7h24Sakd6N244OXM8HvPsHQMds4XjwOTQw@mail.gmail.com>
References: <20240819005345.84255-1-fujita.tomonori@gmail.com>
	<20240819005345.84255-5-fujita.tomonori@gmail.com>
	<CALNs47tLDD2SQDeJ7h24Sakd6N244OXM8HvPsHQMds4XjwOTQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gTW9uLCAxOSBBdWcgMjAyNCAwMjozNzowMiAtMDUwMA0KVHJldm9yIEdyb3NzIDx0bWdyb3Nz
QHVtaWNoLmVkdT4gd3JvdGU6DQoNCj4gT24gU3VuLCBBdWcgMTgsIDIwMjQgYXQgODowMeKAr1BN
IEZVSklUQSBUb21vbm9yaQ0KPiA8ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNvbT4gd3JvdGU6DQo+
Pg0KPj4gQWRkIHRoZSB1bmlmaWVkIHJlYWQvd3JpdGUgQVBJIGZvciBDMjIgYW5kIEM0NSByZWdp
c3RlcnMuIFRoZQ0KPj4gYWJzdHJhY3Rpb25zIHN1cHBvcnQgYWNjZXNzIHRvIG9ubHkgQzIyIHJl
Z2lzdGVycyBub3cuIEluc3RlYWQgb2YNCj4+IGFkZGluZyByZWFkL3dyaXRlX2M0NSBtZXRob2Rz
IHNwZWNpZmljYWxseSBmb3IgQzQ1LCBhIG5ldyByZWcgbW9kdWxlDQo+PiBzdXBwb3J0cyB0aGUg
dW5pZmllZCBBUEkgdG8gYWNjZXNzIEMyMiBhbmQgQzQ1IHJlZ2lzdGVycyB3aXRoIHRyYWl0LA0K
Pj4gYnkgY2FsbGluZyBhbiBhcHByb3ByaWF0ZSBwaHlsaWIgZnVuY3Rpb25zLg0KPj4NCj4+IFJl
dmlld2VkLWJ5OiBUcmV2b3IgR3Jvc3MgPHRtZ3Jvc3NAdW1pY2guZWR1Pg0KPj4gUmV2aWV3ZWQt
Ynk6IEJlbm5vIExvc3NpbiA8YmVubm8ubG9zc2luQHByb3Rvbi5tZT4NCj4+IFJldmlld2VkLWJ5
OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGVUpJVEEg
VG9tb25vcmkgPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+DQo+PiAtLS0NCj4gDQo+IElmIHRo
ZXJlIHdpbmRzIHVwIGJlaW5nIGFub3RoZXIgdmVyc2lvbiwgY291bGQgeW91IGxpbmsgdGhlIHBy
ZXZpb3VzDQo+IGNoYWluIGZvciB0aGVzZSB0d28gcGF0Y2hlcyAoWzFdKSBpbiB0aGUgY292ZXIg
bGV0dGVyPyBJIGtuZXcgaXQgd2FzDQo+IGZhbWlsaWFyIGJ1dCBjb3VsZG4ndCBmaWd1cmUgb3V0
IHdoZXJlIEkgaGFkIHNlZW4gaXQgYmVmb3JlIDopDQo+IA0KPiBbMV06IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3J1c3QtZm9yLWxpbnV4LzIwMjQwNjA3MDUyMTEzLjY5MDI2LTEtZnVqaXRhLnRv
bW9ub3JpQGdtYWlsLmNvbS8NCg0KU3VyZSwgSSdsbCBhZGQuDQo=

