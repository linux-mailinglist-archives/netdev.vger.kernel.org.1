Return-Path: <netdev+bounces-158867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F001EA1399E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158BD161199
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65FB19FA92;
	Thu, 16 Jan 2025 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1i/6p69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38575156F57;
	Thu, 16 Jan 2025 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028855; cv=none; b=caGvT9a7QJNu7guwGpU+MDfACyEYd6msZw2z3w6nnN30zPKaq3tbtkrf5yRmCbOQ9sXORGJ3GF7DxVEELjhS3sjI9EBQoPPyZtvPwanQsS68019nJRmTC3B2jv/t7D4fKSMO/B5cb5XYSW2hkXG4ZbPbNXo978knePWPyL5GpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028855; c=relaxed/simple;
	bh=mzRnJLkb3Ruw5HTjlk1xCQUs218U3dRZhKI7d6EV+yw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IX/YyEnTqQvswMGef7UBl7ZDX+DxJDeKEmzJoYKhrKweC2vOKXCzon4/RqHfmq5HSFIjuBVuOFvIRx7EuWL47cwtLv4ocsFusYw1GCrln1HIajhTr+EVoyO8Efz2xpgG7kkWuanCQgN8q7Bbiz7cUrph7sTsDultFQarnskl5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1i/6p69; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21628b3fe7dso13544375ad.3;
        Thu, 16 Jan 2025 04:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737028853; x=1737633653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzRnJLkb3Ruw5HTjlk1xCQUs218U3dRZhKI7d6EV+yw=;
        b=a1i/6p69OI0zr7kjtpjpPdTfdmcNkfO1Ou2p+pZYZqsehWMB7hAxvVJE6ltJYUgjav
         XSxuSxf5z6I6Ef6cHYp+2805VWs9aGstBOnPQ3cPfz+0l7vj2H+GG9mkGXRIWWOcKljx
         ufQaOGxxgfPFsDuMCbC0KPPa+R8YEl8JNXDL3ugxTFjNMVEaczv6QxfKbf0CWDKLShK0
         5WHM0Viywzr7bEo4z1ZaUvt5oAts5poKyBRzF/RzwhnHTlf9LdAvMwAg5ezdMLO4s53I
         4GVadVsFuthHA70kPtsvdZzwXDAK4A5T+hvEa2vw2BEUNEcPmtdELpQVXzCstIIADLPS
         7frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737028853; x=1737633653;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mzRnJLkb3Ruw5HTjlk1xCQUs218U3dRZhKI7d6EV+yw=;
        b=l2ixJmmhjDCKx5/0dr7HZ7IHIZ3WUofKnHpdaskgvPsHOM2uPtszSLyWeUiOsgZbfU
         ndrW6U4btnsUy2Jijo2MJ+DF93VFRszRr00NPDAPv1jt2nG0Cf3S6nmG8Xfa/zBFc4Mp
         sz7JQurKw/qykt1r2x+P3dNbVlqGwSiezm4cFsvdMzZJvs1PWgy6NFUaqoACep/FS/Go
         LkqcHfoZL5E0pDm39MgVukRo40psrg2hnEmGP5rymTLIGbQBqGmfSb+t0e/FOAKqJP3g
         Fkq40A1BSL5UIE5XY0epLdl3lLYk6vo/L8vjNE5kYGfl2RzQv+PrCzHv561xX1wl+SMM
         BKAA==
X-Forwarded-Encrypted: i=1; AJvYcCUw3FvOlWQKPv4unuCMWRji9emY/eIfSZOIb/Y8cIy5JuhnmfIFcMYBaF5Hv/W+/mAtRxawZ6Seqhpo+QM=@vger.kernel.org, AJvYcCXEZyexoguEQS+9vfcsjfhRxmrv7wF5g52UrRBJuP3TITS3kGWhF6FXgysCoCB7gO+bwUT4JI4G@vger.kernel.org, AJvYcCXrj2ZqQRXDzKZuPPPCOd7gBIxJkui936QRYKK0N2hNBwnY6u3boRPXvnfxLItAlBabnW7tXUjTiHOsqJ27b8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+qZGDDYjvAw5dWta7R3hTflPmwkI5Mrf6hCYI1AIgIlXHzTW
	wVjYirFbFdHbjLeYy5TibCzCNgkjtVz1NTDgdmypxnOOHQiHzF1U
X-Gm-Gg: ASbGncvDm+vCTYFeYYQjY5nraJYVUmlSc//gDK8KtEvQwcz9ykHyaN+0I9B3JFNp5+4
	nzsuIpmdEPQEm6B3ot7AoOgo6K+vD1iOy/PjuJcZSKc3RepTYW0CfhXgDisPBiiIJ6OBMA+f/Jy
	kjAWuaPKDyXkhP+P/31Cm2w0fYyWydjgkzxqEPCr2tbDbHYmMJEcLWCX3ORc/QjNkUcztaiY6gj
	hjFgiYzbs1x94NK+L+2/6UAG8eSrn/M/8/77kzhhp4sxZu3hS7dFv4ePf5/6OwMNMpjpUiK6HRu
	IboGqq/iBJ7Jwu/uaA3W2B+Pshv0i4wT71LQdw==
X-Google-Smtp-Source: AGHT+IHt0zaudgYG/mpLiHolJ2UDB1y/8Uu7OsoUC5tocGiariRcjfiH1ulLwwMqrjF8kWcd8WEsSQ==
X-Received: by 2002:a17:902:e84c:b0:215:4757:9ef3 with SMTP id d9443c01a7336-21a83f338b0mr453007905ad.9.1737028851986;
        Thu, 16 Jan 2025 04:00:51 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253e02sm97919815ad.225.2025.01.16.04.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 04:00:51 -0800 (PST)
Date: Thu, 16 Jan 2025 21:00:42 +0900 (JST)
Message-Id: <20250116.210042.151459337736478197.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 andrew@lunn.ch, rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 2/7] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLghAfovcm0ZJBByswXRSM4dRQY4ht7N7YGscWOaT+fN9OA@mail.gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-3-fujita.tomonori@gmail.com>
	<CAH5fLghAfovcm0ZJBByswXRSM4dRQY4ht7N7YGscWOaT+fN9OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVGh1LCAxNiBKYW4gMjAyNSAxMDozNjowNyArMDEwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFRodSwgSmFuIDE2LCAyMDI1IGF0IDU6NDLigK9B
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
IG9iamVjdCB3aXRob3V0IHR5cGUgY29udmVyc2lvbi4NCj4+DQo+PiBpNjQgaXMgdXNlZCBpbnN0
ZWFkIG9mIGJpbmRpbmdzOjprdGltZV90IGJlY2F1c2Ugd2hlbiB0aGUga3RpbWVfdA0KPj4gdHlw
ZSBpcyB1c2VkIGFzIHRpbWVzdGFtcCwgaXQgcmVwcmVzZW50cyB2YWx1ZXMgZnJvbSAwIHRvDQo+
PiBLVElNRV9NQVgsIHdoaWNoIGRpZmZlcmVudCBmcm9tIERlbHRhLg0KPj4NCj4+IERlbHRhOjpm
cm9tX1ttaWxsaXN8c2Vjc10gQVBJcyB0YWtlIGk2NC4gV2hlbiBhIHNwYW4gb2YgdGltZQ0KPj4g
b3ZlcmZsb3dzLCBpNjQ6Ok1BWCBpcyB1c2VkLg0KPj4NCj4+IFJldmlld2VkLWJ5OiBBbmRyZXcg
THVubiA8YW5kcmV3QGx1bm4uY2g+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGVUpJVEEgVG9tb25vcmkg
PGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+DQo+IA0KPiBPbmUgbml0IGJlbG93LCBvdGhlcndp
c2UgTEdUTQ0KPiANCj4gUmV2aWV3ZWQtYnk6IEFsaWNlIFJ5aGwgPGFsaWNlcnlobEBnb29nbGUu
Y29tPg0KDQpUaGFua3MhDQoNCj4+ICsgICAgLy8vIFJldHVybiB0aGUgbnVtYmVyIG9mIG5hbm9z
ZWNvbmRzIGluIHRoZSBgRGVsdGFgLg0KPj4gKyAgICAjW2lubGluZV0NCj4+ICsgICAgcHViIGZu
IGFzX25hbm9zKHNlbGYpIC0+IGk2NCB7DQo+PiArICAgICAgICBzZWxmLm5hbm9zDQo+PiArICAg
IH0NCj4gDQo+IEkgYWRkZWQgdGhlIGt0aW1lX21zX2RlbHRhKCkgZnVuY3Rpb24gYmVjYXVzZSBJ
IHdhcyBnb2luZyB0byB1c2UgaXQuDQo+IENhbiB5b3UgYWRkIGFuIGBhc19taWxsaXMoKWAgZnVu
Y3Rpb24gdG9vPyBUaGF0IHdheSBJIGNhbiB1c2UNCj4gc3RhcnRfdGltZS5lbGFwc2VkKCkuYXNf
bWlsbGlzKCkgZm9yIG15IHVzZS1jYXNlLg0KDQpTdXJlbHksIEknbGwgaW4gdGhlIG5leHQgdmVy
c2lvbi4NCg0KSSBkcm9wcGVkIGFzX21pbGxpcygpIG1ldGhvZCBpbiB2NCBiZWNhdXNlIEkgZm9s
bG93ZWQgdGhlIHJ1bGUsIGRvbid0DQphZGQgYW4gQVBJIHRoYXQgbWF5IG5vdCBiZSB1c2VkLg0K

