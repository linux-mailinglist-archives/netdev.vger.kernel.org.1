Return-Path: <netdev+bounces-166739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24235A3724A
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 07:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD8F189213D
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 06:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416721422D4;
	Sun, 16 Feb 2025 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0qZSGB1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AB12E1CD;
	Sun, 16 Feb 2025 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739687763; cv=none; b=alrR4vRHomV/ZroAO25ynuQoKJV+AY+CH3GKG4Efq7x3f+yQ65leKNuaNFSYZ3PCaqlPmjPSz3vS7KvIomnHUt377PoMH5MczKOGuzDTW+Lj9ov0tQ8VOrJ7fdVs9SMtsD41d+g4IPfkQ6dbO+QncKKDcYkNNmLuZ47UEK01BbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739687763; c=relaxed/simple;
	bh=xibi1nGANYUGTO/IRSiOyVODq0c9qJcEp0eA14oksbY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ICpcl1jK5+U8+57OQUKkpCms3DsdPr9v/dRV4Yz+rgFCQYcg80h1x8NxF9BjEy/NkCVGmqFePwklspkTyQM95XHCvOzgRBKZOBLL8AN/5VWCtEFcH6U06jttnQm5fIHiFVbiQ2GxrBSqCLWVphYdvMxlWoVS4l7jptY8UnY7NhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0qZSGB1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c92c857aso53102085ad.0;
        Sat, 15 Feb 2025 22:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739687761; x=1740292561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xibi1nGANYUGTO/IRSiOyVODq0c9qJcEp0eA14oksbY=;
        b=Z0qZSGB1trEbMSOxXLAmSXSv7O6mAVBuLUVZK0TIVvN+eusrfq9DUZc7cAvsOVw5DL
         iqqh6X5YeZNBTyG+m/1P94Y6heSEdA/0UC4uMB5poAqhHWhgZZGiAejhGQpFUZrHDxlG
         ce2wngqZrpQe9gftxqoZ2yhuYZZNhUrQx4fZ/yI+MjAuGL2wRszqNI53K9oHSAr/UexF
         Lh4k50ejSOJxfznQAukgWVeBE1h5Lu4Y2VOnJhPx49d2tcxncx7jmOleBgSYoCPXLVV8
         nsljcY1k4nZJ/A5V/ZuMz9JhIP2C7A4DDXf+y7vjxCxsirl4JnLtol0mnm6DdWDAtqk6
         ch1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739687761; x=1740292561;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xibi1nGANYUGTO/IRSiOyVODq0c9qJcEp0eA14oksbY=;
        b=w0vV6i1lIh4H3/R4zi2sHUW3cTpIt1ZeDOHLeaxNDN16Ye0ep9hgKYJQABRLUxzutB
         ScUX2qBPLJCtsTNiHoRzDZs763K0uhswAcT6l5twF4JGzBf4FcUf4WV91YkviTvpwIL8
         pS9coAvOx2PW2tag8HCMekJyUS4E97GT7tqr3jT2d97+qxj5DmUYh3yGzFRGsgxJ7vqL
         hwujpsmA9QhrB32PXWh1hubG6+I1nKOb4qjW5pvroJtIIwqCOafCnwsuvdb6zIiaKCyZ
         0pgoWwenXh8RGDxTl+rXcO0Gj455BXJCD+pQcADgcw8IO4zoNm67ad4XRQy7I5gCIJ59
         6E8w==
X-Forwarded-Encrypted: i=1; AJvYcCUWQQQWOhNoj3ech+QQV9gZRpech+Zf0gtGbhl8DI7ufFmHQTcAqb1TnF+fDioBEPDsVC4++NXC9En7crE=@vger.kernel.org, AJvYcCVPn722Kg7D0kmvJqVOFfUo7VVvkcCFD79TEncnBr9YHX9srXH5QpFjLVfj42O60RJntWfeUSRD@vger.kernel.org, AJvYcCWiM31osbcIbkuKbIHFwwRX4XjIjp7JrAQXwXVnTW0dMvHWO8pBrIeyxExENruAC2Iw5iB+giNy8D8M1hNQUZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzufnfyKzKDC7Fm+tNRyTAsxZclmEghyatAwwWl3fbWFwmavfWh
	njHm3K/O83JW1+I9xFnKxPeXsoB0tVUedxT72LdAhzY7gikkBU4y
X-Gm-Gg: ASbGncvst3h5oUpjUXgDn1CJwHpYJ30Y7yIJo8HbsX3uGOxySx2aEbC0Ndnm1tVkx+N
	1EIRUlDCsiH35HK7FR5NbiBuvR4zfgubYpM+jf0P/aKkBio+Nx/9vUBY93eSlvKSLw+YniEpxUX
	N7+xsQkwdENn2I+FHPeUPVSgYyFuipqN4gmbc+D3FUePYRIqrs9HHitRjf0edVKGzbARp6ViqL0
	Cmf4jGKmpcGnlNq2MQpxwNgWHdfja93WTWAU8O9opVwnQiNCbl86HGjFRLEdh61tCK8IbOvEIJX
	4zu9y/0W5REgUVaVvIxyuf7qaWVpBmf7WiD81HyJAzPoTb4AZh0HjEAtv0Q5gc8oxU/NoUVV
X-Google-Smtp-Source: AGHT+IH41UGTLy/72mfTSzDewVBBXKuIIKGWUQiY+eFadWiy8MCZVlTsQ1TKwm+SYKhPL4hvNwDdIw==
X-Received: by 2002:a17:902:f64f:b0:215:6c5f:d142 with SMTP id d9443c01a7336-2210460c80dmr70906595ad.20.1739687760840;
        Sat, 15 Feb 2025 22:36:00 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53668d1sm52137325ad.75.2025.02.15.22.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 22:36:00 -0800 (PST)
Date: Sun, 16 Feb 2025 15:35:51 +0900 (JST)
Message-Id: <20250216.153551.1205568288010505529.fujita.tomonori@gmail.com>
To: daniel.almeida@collabora.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 0/8] rust: Add IO polling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <8BD5E78C-0B91-4BD0-A38E-7A3681536DB4@collabora.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
	<8BD5E78C-0B91-4BD0-A38E-7A3681536DB4@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gU2F0LCAxNSBGZWIgMjAyNSAxODoyODozMCAtMDMwMA0KRGFuaWVsIEFsbWVpZGEgPGRhbmll
bC5hbG1laWRhQGNvbGxhYm9yYS5jb20+IHdyb3RlOg0KDQo+PiBBZGQgYSBoZWxwZXIgZnVuY3Rp
b24gdG8gcG9sbCBwZXJpb2RpY2FsbHkgdW50aWwgYSBjb25kaXRpb24gaXMgbWV0IG9yDQo+PiBh
IHRpbWVvdXQgaXMgcmVhY2hlZC4gQnkgdXNpbmcgdGhlIGZ1bmN0aW9uLCB0aGUgOHRoIHBhdGNo
IGZpeGVzDQo+PiBRVDIwMjUgUEhZIGRyaXZlciB0byBzbGVlcCB1bnRpbCB0aGUgaGFyZHdhcmUg
YmVjb21lcyByZWFkeS4NCj4gDQo+IEkgdGVzdGVkIHRoaXMgb24gYSBkcml2ZXIgSaJ2ZSBiZWVu
IHdvcmtpbmcgb24uIFRoaXMgaXMgd29ya2luZyBhcyBpbnRlbmRlZC4NCj4gDQo+IFRlc3RlZC1i
eTogRGFuaWVsIEFsbWVpZGEgPGRhbmllbC5hbG1laWRhQGNvbGxhYm9yYS5jb20+DQoNCkdyZWF0
LCB0aGFua3MgZm9yIHRlc3RpbmchDQo=

