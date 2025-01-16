Return-Path: <netdev+bounces-159107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBC5A14688
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F523A3787
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7709E2475C4;
	Thu, 16 Jan 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4JQG5GH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FFA22BAB7;
	Thu, 16 Jan 2025 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737070283; cv=none; b=RpceBLncfny9gxyqDaSVLaXc4uXU08tE1Vejtd7QV416x/ZincPUKOlR02l5NKVYTtLvFgyjejPYb+0w/KYmxH9N8gel2DhpfaJwMni0oIdua7X9+fR+/CTLhHZ0kbAgiD3swLpSuu8vOkXulO+yVSINsd/Fl6fxO6/kqSXiMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737070283; c=relaxed/simple;
	bh=UfKma9d0xETrwi8ZoIZdLsQyUatMrCHzFPHJG3UsyOs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Irj5wGrSk2noBaoH+wU4QN3k4neKL8X95LXzGz78RUYCNbhG+zrlEACe8tqvHV5CYhAVRzROy38DNslibjOkcj7u31/9YJPL6BOkFw+hSvoUpqECsN/jFyrUWFE9XK5xK07O5mfth1RdAwhITrLwxXLpcMiZP6z8/vr7A1V6z4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4JQG5GH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216395e151bso21745305ad.0;
        Thu, 16 Jan 2025 15:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737070281; x=1737675081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfKma9d0xETrwi8ZoIZdLsQyUatMrCHzFPHJG3UsyOs=;
        b=L4JQG5GHr/slq9WveMip6/kBL9xF9b96mo+F/sPb4aHKXOAh+XmO6siKBPF2RA/TEk
         Y4ZSwe8yFQ1X6rNEJX1V8PyaXzU8i+el3TqkTbYsKn5BMuTT6Q5H9h8VptuePU8wL2b+
         yiTpF9Dmfurqd9fStT7Pq06i6GuoioQuYBTSweNBGy67B6tYILU0qA4CugNTspLsV+IE
         CFIBt2rLjxgORig0FD215q6PxSM/IzWDTulpBEzMKJ+prbWGMejljQ/DmSwc8lCg8zLC
         GMk/EzeVfZPVfimafd72CI/G/2zdfekk0nS/b5s0kok9aZFAaj52ehRNB8lJJIdKI9ND
         /2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737070281; x=1737675081;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UfKma9d0xETrwi8ZoIZdLsQyUatMrCHzFPHJG3UsyOs=;
        b=H76IdLGHDyN/Rhg74Yh18/b9HvVWqPC0fKVWLpDq9nSkmP3NePaOlBk2r7oXntwLJE
         ifFctcyBk21KliAbtNTFS3DHja5l8teU/1gPp8qHOHy4lt21YOkeYdwZgfwTmyCXVzUu
         rQ+UzEuliUxzho0K5yZZLsU7wGkimbWhbARhzJgDjvtyaec8Tj5O7viRXBITUaaHyRa5
         DcOnMQzQxmdeK6+1lJclBXSDBJ/BxM1PTP9ZuMg/eRNwcq3Qfh6VqIVh70h4QrLYgtYG
         +tukPShbY2hwEUoHJQ4aH0GPxYkeajL4MqWY6wA+s1NyI48bhH2MZKH1Nd2CxIsDJIlI
         jIOw==
X-Forwarded-Encrypted: i=1; AJvYcCVOLhQielunioyf7Bt1hoXB4DQqcPjQd78qUZ5RAGIu0O8sSVef/xxmBbADB7jxCAZuOXu4seCULshzf9X7XCY=@vger.kernel.org, AJvYcCWT7kBMn5l8CcmafaDExvNeoZwbz4G8goFP80ZcmBfkCrGBB3VqlT5wExtHUrvXj0M9JnWWLtJr+7HBTIo=@vger.kernel.org, AJvYcCWmsndamIAaE+/VWVgm6njOJyNHrw1qSiDDOXJ3j98dZWT4oPRdk+K+9e5D7Qe+4WTyyTEQkUQB@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8YN7pMdPNAvy6WciZpiBsp/P7EFZjBBjOWQOMh+Adxp/nzGY
	62RWXouXU68Hnc8cebGLQqjTPtZD3XNL0Trq2Lkhz8SFtYHTm4xW
X-Gm-Gg: ASbGncv1vnfdbGhldGBlO3kd00LpuuzkA/uaK3mpReuxaE51lDXSf+XIBjxGOrbqeFm
	I6Ds3SFL7IfnM3eozZ7QYGsRq/KAUrn03ggz6SlcvllVxmnc11xvhenP+Xjt6gmNni5TTK5gc8H
	BtLw/hs3fMauYrIa4X/D2v4eCxhVbcgVMKVaxP2/khgaeCkHTwfwejjORAQJhXqB7TFcAqwFWk1
	z9/yryeDdZOZAR5UF7oaJsydergEGbeTv4UfYHr4Xe3sZ2ILMMiCtg+pWE/kTw+i2ZoSMiE5ywT
	8kPIWxwzs0m/596JUqHAm1MB1Xs/VOtBV+rEDw==
X-Google-Smtp-Source: AGHT+IGEDQxlg/01NjEjOI45d0A0qbX9g1W7pa2BSOcT3h7l7hT74jMuTEu5uJSjHusvbowq6bXlVA==
X-Received: by 2002:a17:90b:4f92:b0:2ee:d9d4:64a8 with SMTP id 98e67ed59e1d1-2f7284e2e9fmr14493157a91.0.1737070280928;
        Thu, 16 Jan 2025 15:31:20 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c2c310csm4250594a91.31.2025.01.16.15.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:31:20 -0800 (PST)
Date: Fri, 17 Jan 2025 08:31:11 +0900 (JST)
Message-Id: <20250117.083111.1494434582668066369.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72m++27i+=H0KUaf=6fn=p29iueEV-+g8toctp0O0zEW+A@mail.gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-4-fujita.tomonori@gmail.com>
	<CANiq72m++27i+=H0KUaf=6fn=p29iueEV-+g8toctp0O0zEW+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVGh1LCAxNiBKYW4gMjAyNSAxMzozNzo0MiArMDEwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBUaHUsIEphbiAxNiwgMjAy
NSBhdCA1OjQy4oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiAtLy8vIEEgUnVzdCB3cmFwcGVyIGFyb3VuZCBhIGBrdGltZV90
YC4NCj4+ICsvLy8gQSBzcGVjaWZpYyBwb2ludCBpbiB0aW1lLg0KPj4gICNbcmVwcih0cmFuc3Bh
cmVudCldDQo+PiAgI1tkZXJpdmUoQ29weSwgQ2xvbmUsIFBhcnRpYWxFcSwgUGFydGlhbE9yZCwg
RXEsIE9yZCldDQo+PiAtcHViIHN0cnVjdCBLdGltZSB7DQo+PiArcHViIHN0cnVjdCBJbnN0YW50
IHsNCj4+ICsgICAgLy8gUmFuZ2UgZnJvbSAwIHRvIGBLVElNRV9NQVhgLg0KPiANCj4gT24gdG9w
IG9mIHdoYXQgVG9tIG1lbnRpb25lZDogaXMgdGhpcyBpbnRlbmRlZCBhcyBhbiBpbnZhcmlhbnQ/
IElmDQo+IHllcywgdGhlbiBwbGVhc2UgZG9jdW1lbnQgaXQgcHVibGljbHkgaW4gdGhlIGBJbnN0
YW50YCBkb2NzIGluIGEgYCMNCj4gSW52YXJpYW50c2Agc2VjdGlvbi4gT3RoZXJ3aXNlLCBJIHdv
dWxkIGNsYXJpZnkgdGhpcyBjb21tZW50IHNvbWVob3csDQo+IHNpbmNlIGl0IHNlZW1zIGFtYmln
dW91cy4NCg0KQXMgSSB3cm90ZSB0byBUb20sIHRoYXQncyB0aGUga2VybmVsJ3MgYXNzdW1wdGlv
bi4gRG8gd2UgbmVlZCB0byBtYWtlDQppdCBhbiBpbnZhcmlhbnQgdG9vPw0KDQpPciBpbXByb3Zp
bmcgdGhlIGFib3ZlICJSYW5nZSBmcm9tIDAgdG8gYEtUSU1FX01BWC5gIiBpcyBlbm91Z2g/DQoN
ClRoZSBrZXJuZWwgYXNzdW1lcyB0aGF0IHRoZSByYW5nZSBvZiB0aGUga3RpbWVfdCB0eXBlIGlz
IGZyb20gMCB0bw0KS1RJTUVfTUFYLiBUaGUga3RpbWUgQVBJcyBndWFyYW50ZWVzIHRvIGdpdmUg
YSB2YWxpZCBrdGltZV90Lg0K

