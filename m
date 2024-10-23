Return-Path: <netdev+bounces-138202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DCB9AC978
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A4D1F22567
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE461AB6E2;
	Wed, 23 Oct 2024 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs+OqEwj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259331AB6C2;
	Wed, 23 Oct 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684409; cv=none; b=gIyg7Vz7/hvL3c48zovytTo0K3fP7judRzyXHYfzm2xUdylTwu0v2mvq+Hvq7XB8+4OtCgIYKTW7S7WO74SPg9gAvdrdKxD7z9v225Ou/dIMOI4Y+7vVGuWnRoSpCnl2B+i25JH5A7j3tv/uQ6MGFOZT3BHvspoYueabd3ZiP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684409; c=relaxed/simple;
	bh=xpUXNbcfBX0xDyTt0e4N9Vrd0dcOLqTl6DoApUzeeBY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ly4VvknfPuTh7np6OeL9cCaiRXeTHDirI1cNnT2rLdwvpw+1NNMVCQXjCOHKMSgqCTO/CEwJRExOScx+pQ3eNq6egKwAPFxbRcRuhHdyGrusVgh9MI6RTaaOel1rvcDhyAlBaHdzrqVzgobzhau7RmdyW2I4iCwDlwNPeETYz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs+OqEwj; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3b4663e40so26057165ab.2;
        Wed, 23 Oct 2024 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729684407; x=1730289207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpUXNbcfBX0xDyTt0e4N9Vrd0dcOLqTl6DoApUzeeBY=;
        b=hs+OqEwj1sb5BfwHOWdYDSq/8+ckvIAHKG5f+VHxra5vkPzkIpD5NB6GNy6cBs7bSa
         +NsE7bxRj8PRPgF02O3LX144LLpNMnoswHpx8nbFtHRQbvVKjSczqLmbH3QETlPLjwmI
         ZrrMshhlG5wvTDlDwzStogBP4SI1VPP/pDFXLrDacgO5OkCz3Ytn0N/x+Igv8lfQTUc+
         VLlnnrS9pQOwpXzGjFMJYhk/yDvYKN/fAVee6aM6ngnWIS4GKQ6I8NBPBYBsuOHiI3SG
         gudqenkawdUWMC1oFCI9+4xKnd9dZO/+3MsTBk2PEAv+A4KA7nLB5WmA/mw0+RRV9wv9
         kyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729684407; x=1730289207;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xpUXNbcfBX0xDyTt0e4N9Vrd0dcOLqTl6DoApUzeeBY=;
        b=GV+19riDWQ+/FwaVF608sgIR5Z4OzV5zC4HhJnElacGs53iWZfyfP5Dq1BMzF/TNa6
         DZlrg0+36EYfFZg+uOfcB8JrI439FxDBj9+08C50aHVdSbIZODyQyGsBgg7svrJgTpGx
         mRYjx9DLKhJtJRTlyPlYnxL/6leYPrN4egG/xNpUix3mKIfmhbXs91uyHGY998Zd+lRI
         qYb0U89MEGC9j/ckhtU8k9BHhcJ9vw/U3v85po/wKxRgPh5dbbdFtrCT3q5dXz0OlkN+
         CdA35uB44/Yy9iV1658/VA5YZBb6Jnzzu+DcoG8HqvC+rDW3zAKfKLchYKS3jRcQlCnq
         eBlw==
X-Forwarded-Encrypted: i=1; AJvYcCUssWzSvDmNaLxlA/zqHtBSYAn9H++X8riT4FhHRou5Kzc51+AUcMFk1neYzvWEYl7vPz75H1r4rKvebI7t7cg=@vger.kernel.org, AJvYcCWbP8rTLfFemFkiV4KBCE3l5dXzAFrTiRkfVeOcUrXbDnvMm6pyjkJJErzwjOCQ0n+y5FLNDUUY4/czGQs=@vger.kernel.org, AJvYcCXFJuk/k2pk4uqpxFlilCp2NQYuqsd3R6ol7eL95jx5rKwBvWp5uiDx9dIMOn8gfxeqCrBRacsq@vger.kernel.org
X-Gm-Message-State: AOJu0YyqfApED4HgSGegJyOv6CIDKWJGL445EyE+mW6p81gQ3mnrsmi8
	GeCnR+DVFt5X4OexXd0I5cjWjEyrnMetDk3tkZdKPzfGokfLGRZF
X-Google-Smtp-Source: AGHT+IHH5B72cSBCbY5Yrw1UnarnQaxVJx1ABBEEKRtzlzXz4ucq8fvEsGMc/PlZCAcleuWSRaQ3Lg==
X-Received: by 2002:a05:6e02:1c44:b0:3a3:4164:eec9 with SMTP id e9e14a558f8ab-3a4d598caa9mr24724945ab.14.1729684407100;
        Wed, 23 Oct 2024 04:53:27 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabde7d5sm6577038a12.93.2024.10.23.04.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:53:26 -0700 (PDT)
Date: Wed, 23 Oct 2024 20:53:10 +0900 (JST)
Message-Id: <20241023.205310.480345328758576061.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] rust: time: Introduce Delta type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=SDN89a8erzWdFG4nekGie3LomA73=OEM8W7DJPQFj0g@mail.gmail.com>
References: <940d2002-650e-4e56-bc12-1aac2031e827@lunn.ch>
	<CANiq72nV2+9cWd1pjjpfr_oG_mQQuwkLaoya9p5uJ4qJ2wS_mw@mail.gmail.com>
	<CANiq72=SDN89a8erzWdFG4nekGie3LomA73=OEM8W7DJPQFj0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gU2F0LCAxOSBPY3QgMjAyNCAxNDo0MTowNyArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBTYXQsIE9jdCAxOSwgMjAy
NCBhdCAyOjIx4oCvUE0gTWlndWVsIE9qZWRhDQo+IDxtaWd1ZWwub2plZGEuc2FuZG9uaXNAZ21h
aWwuY29tPiB3cm90ZToNCj4+DQo+PiBkaWZmZXJlbnRseSwgZS5nLiBgdG9fbWljcm9zX2NlaWxg
OiBgdG9fYCBzaW5jZSBpdCBpcyBub3QgImZyZWUiDQo+IA0KPiBXZWxsLCBpdCBpcyBzdWZmaWNp
ZW50bHkgZnJlZSwgSSBndWVzcywgY29uc2lkZXJpbmcgb3RoZXIgbWV0aG9kcy4gSQ0KPiBub3Rp
Y2VkIGBhc18qKClgIGluIHRoaXMgcGF0Y2ggdGFrZSBgc2VsZmAgcmF0aGVyIHRoYW4gYCZzZWxm
YCwgdGhvdWdoLg0KDQpTaG91bGQgdXNlICZzZWxmIGZvciBhc18qKCkgaW5zdGVhZD8NCg==

