Return-Path: <netdev+bounces-138193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86E39AC8DB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F18283A38
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6676A1AAE16;
	Wed, 23 Oct 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/l8SEgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043201AA7AF;
	Wed, 23 Oct 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682687; cv=none; b=e84QcYUgWVY5TaH/Mztk/Tu6jntpMy18bD+E5/tm8RW5i1EtVVToULK0TnXG4o534h/6d63MQsmNJmUZFymgJ2Z0y/4d0qXgmaaibT95C/5SPiyCJxvnKIBOHglIezHuJvc+zE5wMKKR/XwrLEurvSJlyDlgcCdxXX2/c9r5QRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682687; c=relaxed/simple;
	bh=8lc3qOnfAmQPIDetgDZDO2TNymcIOP4HzuKcT1txCEA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mFdshwkFMlDvymE1LMHSTpo2TdgKDMslF1cEfeE07jnfYOoxdqzxYcwHxErP9ZH1TFUN7hpLXlApkefqPDRZ110fk+cj2xswp+NrElzKKmh/Y8Sz9uctzSWy93+zVxDg0puIYa0IhFutpW9r/AImsuqTWPBUAE3/JspaUmyBKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/l8SEgQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso4579453b3a.3;
        Wed, 23 Oct 2024 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729682684; x=1730287484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lc3qOnfAmQPIDetgDZDO2TNymcIOP4HzuKcT1txCEA=;
        b=Z/l8SEgQqChRQBkCyN8YxwYDkFcU+2VwH+GsWbZKYNydmPTwd15wMpMvDhGFPJ+ZCU
         GG52G4QM5/LqA4bXC1/juaLoNkEw1l3nbEgEqy8+yCSNYnfG0YFvS/6nEdHKlvaSoLwy
         tgf/Cpvjh/nkc8nyG/zaeNbDC+7scl6Y52BgTElQfTFIk+g2AuJrrU8R28bLirdx7ynz
         oFdVkpOcv4nBMO3iLAPPEmgbNBKyC5qJKhP4LXscg7InkzkTK5bTmZAe8kxGdm8ULGpc
         Xwd8MnZGonEAqgfE/fCWKcuUgI0xMNAUfgfG84gs+uak0v6Ws6odqBkxy2Azn2Qeltk9
         fdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729682684; x=1730287484;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8lc3qOnfAmQPIDetgDZDO2TNymcIOP4HzuKcT1txCEA=;
        b=UpA6Bmt4gzqLxUpxcuz/L61tdbs/wzQThdxrLr6f3Aq+71GUv3CwCi3Q9gbgyjmaKc
         Z34BeB1Sbj8lu4XaD387z1yRvJR5utW4nfYvSDt4/8E6Pc92mgyhFZ/88DcWvClWeODw
         1GXp6KEMANLZYRousaOgc+aQ/Xpj/4q4MaJIwT+85krAbzymGDrmx0mxKLs1S0LGdIaG
         mHg0BEyqtQmV0/+VusxkpTkCJELdBQ6zr+yVNYZWoeyCPYSpnb1U94RacQOxFQScKGpu
         XONQ119MmodcI/cNRRngXMQYsb2U3Lb+L9Mxzcb1VQcMwUTWEMKZ+YMF1ylOUqJAXqBs
         QHPg==
X-Forwarded-Encrypted: i=1; AJvYcCUkwn8y3tDjvKSE6CNE0ZEwG+GnoWTyCz5Z5c5QiUWvaItBCJAtLSgEhLXnNjVTwJ2jnrXwfZbu1vgxZew=@vger.kernel.org, AJvYcCUyy+ELz0Sf6uOnakCtPHlWdVQbhHVTrEDJUNjfPq2isxbJ2f5SWV+JJeHIfkVVkmc3n3WoJtgVl/DmEMK8vac=@vger.kernel.org, AJvYcCXUCULwfaIX/yVLGR1iduUra+HNBq61axcZrsoV5/yYI/+m9qTMGDNAApl+w0STAESu2NDTxbUx@vger.kernel.org
X-Gm-Message-State: AOJu0YyBA/LnlscdftzNsEh8/i/XNe7dp3QCS16xIrH+ySKn2MZtiUTp
	Umb/YCPiD9680DT4L8uEeMm/UsQm6jp1+dWjN4jWVMzi5UJXGr7f
X-Google-Smtp-Source: AGHT+IFuK64H3m+g+8n4ncgETi3hfCtnqx9Gw5KaUYfzRUtKkcv+yi+GRiPm4xW6m9v0q3Y8WhAijQ==
X-Received: by 2002:a05:6a00:6607:b0:71e:1e8:8b7c with SMTP id d2e1a72fcca58-72030be7386mr2380147b3a.15.1729682684031;
        Wed, 23 Oct 2024 04:24:44 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffc3sm6159383b3a.62.2024.10.23.04.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:24:43 -0700 (PDT)
Date: Wed, 23 Oct 2024 20:24:27 +0900 (JST)
Message-Id: <20241023.202427.1480968709304688972.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of
 Ktime and Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72nvMAMff7Oar-UCvajZ-sP4XdE9vNGW49L9CMsRzSTwCQ@mail.gmail.com>
References: <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com>
	<20241023.155102.880821493029416131.fujita.tomonori@gmail.com>
	<CANiq72nvMAMff7Oar-UCvajZ-sP4XdE9vNGW49L9CMsRzSTwCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAyMyBPY3QgMjAyNCAxMjo1OTowMyArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBXZWQsIE9jdCAyMywgMjAy
NCBhdCA4OjUx4oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiBDYW4gd2UgYWRkIHRoZSBhYm92ZSB0byBEb2N1bWVudGF0aW9u
L3J1c3QvY29kaW5nLWd1aWRlbGluZXMucnN0Pw0KPiANCj4gU291bmRzIGdvb2QgdG8gbWUgLS0g
SSB3aWxsIHNlbmQgYSBwYXRjaC4NCg0KR3JlYXQsIHRoYW5rcyENCg0KPiBKdXN0IHRvIGNvbmZp
cm0sIGRvIHlvdSBtZWFuIHRoZSB3aG9sZSBvcGVyYXRvcnMgb3ZlcmxvYWRpbmcgZ3VpZGVsaW5l
DQo+IHRoYXQgSSBtZW50aW9uZWQgZWxzZXdoZXJlIGFuZCB3aGF0IHNlbWFudGljcyB0aGUgYXJp
dGhtZXRpYyBvcGVyYXRvcnMNCj4gc2hvdWxkIGhhdmUgKGkuZS50byBhdm9pZCBoYXZpbmcgdG8g
cmVwZWF0ZWRseSBkb2N1bWVudCB3aHkgb3BlcmF0b3INCj4gZG8gIm5vdCBzdXBwb3NlZCB0byB3
cmFwIiBhbmQgd2h5IHdlIHJlbGVnYXRlIHNhdHVyYXRpbmcvd3JhcHBpbmcvLi4uDQo+IHRvIG1l
dGhvZHMpLCBvciBzb21ldGhpbmcgZWxzZT8NCg0KSSB3YXMgb25seSB0aGlua2luZyBhYm91dCB0
aGUgZ3VpZGVsaW5lIGZvciBuYW1pbmcgKGF0IGxlYXN0IGFzIGENCnN0YXJ0ZXIpOyB5b3VyIG1h
aWwgaW4gdGhpcyB0aHJlYWQ6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9DQU5p
cTcybWJXVlZDQV9FalZfN0R0TVlISF9SRjlQOUJyPXNSZHlMdFBGa3l0aFNUMXdAbWFpbC5nbWFp
bC5jb20vDQo=

