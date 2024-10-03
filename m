Return-Path: <netdev+bounces-131435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8B98E821
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 03:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F178D1F2272C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3060B10940;
	Thu,  3 Oct 2024 01:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+kMvedH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A515E86;
	Thu,  3 Oct 2024 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727918698; cv=none; b=lja+jYKPvLp6sq40AkpF8HI/64X06HBSfLOghWemKHih3U9tcV0bLPKaB/xIr2/BrIQnxl/hCcE+P4qz4TbEj47XWGz6FSdIEbbWfkeECB8O4wsnDyuT1uEMUVc1sa+IcX7YtdKIU0YZjR8AQbDulKSWH5ZgIBGlgESifjdWBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727918698; c=relaxed/simple;
	bh=SXP/LsK9Fr+HqHHF30BKEosuBUdjBfTa3FVCg7IYCZI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fda1AiICsPvWS8x3uVO2GkczTXz5KOpKYsBy6BeeSpdbDU3XtwfKmq8csCIaP2FD4DWDh49hCrRvlhlOQFrLrdeOPbjv6ASUfkk7rskXF+L495kuQf5mk0Pb44VQHsXDIcH7HRYzlv46cMxYHwL8NpKZEUAuqWtSvWRS8Z2N/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+kMvedH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71b0722f221so360121b3a.3;
        Wed, 02 Oct 2024 18:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727918696; x=1728523496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXP/LsK9Fr+HqHHF30BKEosuBUdjBfTa3FVCg7IYCZI=;
        b=l+kMvedHkXiezrAB7XWa4aB1/6PEl83cX4Xdo9oF89qzxvUtb24WjDfCL1T/1RG9Wd
         FQYhnK6d3qaQ7YdsJ2P2/CSk5sMGPDZPza6fq4/K/niTDixoBiEV22qzfTDpptAxFEae
         0lhnitzU5yty80BO+ssd9cV6xhyhRZSLvrT8Ecxt+4V/byGc6D7k6qjH7QqT69x4LjTA
         39IMHUrJFWDYSM+yLzRmPevc1cB6ZV4yGlvODkw8rVDR+De0xlsa3qIZUr08IxFrbEU5
         6/7FEF8WM4RG15UVjEUVeSGN0FX9hk9igz3q8a5kfoN52kMIBOBV9GO082O2L+RmpcVU
         tgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727918696; x=1728523496;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXP/LsK9Fr+HqHHF30BKEosuBUdjBfTa3FVCg7IYCZI=;
        b=uZARiJMnfEy4euxJIYYXiZjU5otwKphtr9plALxr0e6V3WicIY6BlNCm/O2kEQQZsj
         qSTOMwMx77Uww9bE9r1Gs97ZJvvekfvdKzLmcuDpd1tTmdNCFt1rvWb2SMkBxjAGWTLE
         P44GMxN7NaKNwZI6aerX4+JM/5P5rx26Eg96zsO5OCbIk0SssnPLLr93MfL0F84z3Dgo
         RWZnc849kA0sGZTuJJvCozC4Ofu/PxqBdPbn3mmt96M3feITcZ+zppU7bFaq4iCfqVp/
         jC5xGo6azsF7OBNZfUwlOfyrMgk9Z2VgrLCrOneHLaTVx51kgi9caI/djneGpWqLEdE0
         yKtg==
X-Forwarded-Encrypted: i=1; AJvYcCWLkAcNwkpIXFz23yfOOP122NOaQw5O9PvLEzv89dPZd+yCjoNsXwZgxQmOCD14sIpnQwEKtJ4=@vger.kernel.org, AJvYcCX42T3FsTitzJN63+ZwNMa3WRJdh7md9wqRd4Bm9Ml+Xvo878iYCZceudcLJNA6Rn7ztbc1u7VgxD5vuIU3nNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw82arJyvH/jnf7cRaxy7ZwLR/wm4G2bBEyfW65x+mEcYwim9oP
	Ddin8gQbfOVOh4UD9Ep9o6qou9FPeabDaZOIaRrAER9zND4Sgejl
X-Google-Smtp-Source: AGHT+IF/CVy2wZQNwSbHgtuzl4EKu6mKZ/vd6ZfDzHkz61cwyqmA5nP2c0Fb/T2hENSK0PyQeLLkKg==
X-Received: by 2002:a05:6a00:a8b:b0:70d:2708:d7ec with SMTP id d2e1a72fcca58-71dc5c4df23mr7302253b3a.5.1727918695956;
        Wed, 02 Oct 2024 18:24:55 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9df02dasm139078b3a.164.2024.10.02.18.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 18:24:55 -0700 (PDT)
Date: Thu, 03 Oct 2024 01:24:44 +0000 (UTC)
Message-Id: <20241003.012444.1141005464454659219.fujita.tomonori@gmail.com>
To: tglx@linutronix.de
Cc: miguel.ojeda.sandonis@gmail.com, fujita.tomonori@gmail.com,
 aliceryhl@google.com, andrew@lunn.ch, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: [PATCH net-next v1 1/2] rust: add delay abstraction
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <87bk02wawy.ffs@tglx>
References: <20241002.144007.1148085658686203349.fujita.tomonori@gmail.com>
	<CANiq72kf+NrKA14RqA=4pnRhB-=nbUuxOWRg-EXA8oV1KUFWdg@mail.gmail.com>
	<87bk02wawy.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAwMiBPY3QgMjAyNCAyMTo0MDo0NSArMDIwMA0KVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KDQo+IE9uIFdlZCwgT2N0IDAyIDIwMjQgYXQgMTY6NTIs
IE1pZ3VlbCBPamVkYSB3cm90ZToNCj4+IE9uIFdlZCwgT2N0IDIsIDIwMjQgYXQgNDo0MOKAr1BN
IEZVSklUQSBUb21vbm9yaQ0KPj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4+DQo+Pj4gU3VyZS4gU29tZSBjb2RlIHVzZSBrdGltZV90IHRvIHJlcHJlc2VudCBkdXJhdGlv
biBzbyB1c2luZyBLdGltZSBmb3INCj4+PiB0aGUgZGVsYXkgZnVuY3Rpb25zIG1ha2VzIHNlbnNl
LiBJJ2xsIGFkZCBzb21lIG1ldGhvZHMgdG8gS3RpbWUgYW5kDQo+Pj4gdXNlIGl0Lg0KPj4NCj4+
IFdlIHJlYWxseSBzaG91bGQgc3RpbGwgdXNlIGRpZmZlcmVudCB0eXBlcyB0byByZXByZXNlbnQg
cG9pbnRzIGFuZA0KPj4gZGVsdGFzLCBldmVuIGlmIGludGVybmFsbHkgdGhleSBoYXBwZW4gdG8g
ZW5kIHVwIHVzaW5nL2JlaW5nIHRoZQ0KPj4gInNhbWUiIHRoaW5nLg0KPj4NCj4+IElmIHdlIHN0
YXJ0IG1peGluZyB0aG9zZSB0d28gdXAsIHRoZW4gaXQgd2lsbCBiZSBoYXJkZXIgdG8gdW5yYXZl
bCBsYXRlci4NCj4+DQo+PiBJIHRoaW5rIFRob21hcyBhbHNvIHdhbnRlZCB0byBoYXZlIHR3byB0
eXBlcywgcGxlYXNlIHNlZSB0aGlzIHRocmVhZDoNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3J1c3QtZm9yLWxpbnV4Lzg3aDZ2Zm5oMGYuZmZzQHRnbHgvICh3ZSBhbHNvDQo+PiBkaXNjdXNz
ZWQgY2xvY2tzKS4NCj4gDQo+IENvcnJlY3QuIFRoZXkgYXJlIGRpc3RpbmN0Lg0KDQpVbmRlcnN0
b29kLiBJJ2xsIGFkZCBhIG5ldyB0eXBlLCB0aW1lOjpEZWx0YS4gQW55IGFsdGVybmF0aXZlIG5h
bWUNCnN1Z2dlc3Rpb25zPw0KDQo+IEJ0dywgd2h5IGlzIHRoaXMgc2VudCB0byBuZXRkZXYgYW5k
IG5vdCB0byBMS01MPyBkZWxheSBpcyBnZW5lcmljIGNvZGUNCj4gYW5kIGhhcyBub3RoaW5nIHRv
IGRvIHdpdGggbmV0d29ya2luZy4NCg0KUnVzdCBhYnN0cmFjdGlvbnMgYXJlIHR5cGljYWxseSBt
ZXJnZWQgd2l0aCB0aGVpciB1c2Vycy4gSSdtIHRyeWluZyB0bw0KcHVzaCB0aGUgZGVsYXkgYWJz
dHJhY3Rpb25zIHdpdGggYSBmaXggZm9yIFFUMjAyNSBQSFkgZHJpdmVyDQooZHJpdmVycy9uZXQv
cGh5L3F0MjAyNS5ycyksIHdoaWNoIHVzZXMgZGVsYXkuDQoNClNvcnJ5LCBJJ2xsIHNlbmQgdjIg
dG8gdGltZXJzIG1haW50YWluZXJzIHRvby4NCg==

