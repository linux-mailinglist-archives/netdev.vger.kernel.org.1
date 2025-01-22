Return-Path: <netdev+bounces-160197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF8A18C6A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 07:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C51883710
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 06:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033301A9B4E;
	Wed, 22 Jan 2025 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb0jNckV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A814F9F9;
	Wed, 22 Jan 2025 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737529033; cv=none; b=e/h++Xszlek/WJXomc26b9NMiwkqD1YGLHkvxDbKe5xB9DajNWjmSMSN/1zPlZYHGOpHbK5OLN8QZd2TUJvzCH7X08vMe2q9UKWNmtKmjz+uuMkFSb6vqNhJ9GYdzl9SESAJ6xM+hZBuDN5VtyBLeS9cOlhxk6Rj2Tkbz7kY14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737529033; c=relaxed/simple;
	bh=ckTwCpolH3tC3roRZ+7TPeowU7m0BvtAtZBjbWPXruc=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dLxiOMVwpOeozYQS5HH8QrdzsV8Kw4gs3L8XLpuMzq9niF8HFbLKTW6arTv96D4cUmwBKKhIgwOXmZVNGMWq0ZjUdC0WcGULYUsAnIQgB3Uo7A2snMIig0tEN/UWEwQzp7sK3JjcHDBT9zfovHQTVB+Qh79DAte+ZomaYUhAnks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb0jNckV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so850068a91.0;
        Tue, 21 Jan 2025 22:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737529031; x=1738133831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckTwCpolH3tC3roRZ+7TPeowU7m0BvtAtZBjbWPXruc=;
        b=bb0jNckVDjX6IrZkRBDqo/Wv18r2YSxzGDe4u/fY29iOkm7kbVawkh7NsI8kPIZa4m
         B6oT7qLVjN2V3ftSccafknIXCtmRGsNRnvt94qXqxdGg7J/LybCGHZT35vA7RyPyFwWb
         8G6Hyih0TWYuHbjZgrXNIseo4m+B0OUyf+xVYGffjLw41uQZhhdf8Eu4CXxUjNNl1nmi
         Voc2bGMyC6HUbCIrVxEQVRzyr+DxMtdyzrtKt9LIwEFnGCT8mgFOyMynkGccLZvqzf+Y
         J8B7Tgr9Zve9lB4/0nCHbSlfW/9j3jhZGwJPC/G5ypd1/6LukTwZ710OBMVECRahW8CE
         v/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737529031; x=1738133831;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckTwCpolH3tC3roRZ+7TPeowU7m0BvtAtZBjbWPXruc=;
        b=Jt08MYvwpGydkMOCU/b304qKRi3J+Ta9rFzI2OzIxAQ4iTMLBx17f0s9Q6CwmkrJEo
         QdlcQDZTxlitCE4A/AkX+cN7U2hhDFEU0PvjbLyzaF7/eCJoJ6rCo18WUyVq7EATJ/w4
         SUd6mA3CuP9W83Q/hR58iidVSzDdayem8hSJalWAEHK3rIrNPSOeMJLjnPVHFSALKIDX
         VF61gO6ZmmLERtjD/jXCk4VkN4KNLRY9j2ORX2qxdhv/bf5hGLuhipOcRlPQyAEyporz
         2CsVZIo25UAgav6EL26KuraejgzIo7PkNaJdgVcEfzrYtieXj+o0G9Qa/FcLxyYvRff/
         oWag==
X-Forwarded-Encrypted: i=1; AJvYcCUisVYCz5mZuXoY3sLGw6RHD3vvha22qnYIyoVX1TQ8jjNN3OIA2QoF9dkuyT9QpWshvI6AT/Qzh6WIdXY=@vger.kernel.org, AJvYcCVEJiJHhjfMq4p2mZYTpqgnVS97jdTer3y4/4kEnXpCFeUihrVqspfNcfnTuavx79r3iaHc2kxfxSGRhZ295pI=@vger.kernel.org, AJvYcCVJE8G2zpDVUw21MSA/xWnWEbsLYB2f+ny5Id+ublxj+Qxf/jZc7KmHcgn4Y+mPP0x4fMLAXxU6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Dg9bBGpMEfYGoAnXNNrDvXdwpIofn2F3FhxiIknhQk5ZcPGI
	7Oq39m8cLajTmsZE07xqt1Ng8kWV48YDxYo+CsyadfHea5NzDalo
X-Gm-Gg: ASbGncs2wgMzeSKIGAbtPcIpiIN9JT8B+FLtXnG1tEm4Etz6FY076BwXDwNTn0TAXV0
	vUCTaUJjC0fbdpiRjfUMXVkSZPjfzqcIlm/xKTryZuzTr6dOIa225xsbCqxyn3Ium1VSI99cx4E
	PLR3DlISkZo6TVmrZhGzoQY+zRXbM/PJUApFwNj6vvkKCyfZq0Nap5/NgSz+2NG7ANELIhKwWmc
	zjKpSpPBSDlVbi3z8XnQ0F/QVBQeGBYZMWS9rt31QVWpmFWScog5E6G+jXBgyMJfMJXs4ZiFW8U
	JWTqjToYZ1AjVuIeg13UpGDFfA0R6zr/HZKr/N5sde+tLWRbETo=
X-Google-Smtp-Source: AGHT+IEpON78xM22Hm5rzm/io/VOZDLXo8YlRbrVpIlTKNJ1UcGmJcz0zHhvRxeb84P9EdseyHR9pg==
X-Received: by 2002:a17:90b:3eca:b0:2ee:8253:9a9f with SMTP id 98e67ed59e1d1-2f728e48411mr43164217a91.11.1737529031523;
        Tue, 21 Jan 2025 22:57:11 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6aa608csm749465a91.27.2025.01.21.22.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 22:57:11 -0800 (PST)
Date: Wed, 22 Jan 2025 15:57:02 +0900 (JST)
Message-Id: <20250122.155702.1385101290715452078.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72kqu7U6CR30T5q=PvRam919eMTXNOfJHKXKJ0Z60U0=uw@mail.gmail.com>
References: <CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com>
	<20250118.170224.1577745251770787347.fujita.tomonori@gmail.com>
	<CANiq72kqu7U6CR30T5q=PvRam919eMTXNOfJHKXKJ0Z60U0=uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gU2F0LCAxOCBKYW4gMjAyNSAxMzoxNzoyOSArMDEwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBTYXQsIEphbiAxOCwgMjAy
NSBhdCA5OjAy4oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiAvLy8gVGhlIGFib3ZlIGJlaGF2aW9yIGRpZmZlcnMgZnJvbSB0
aGUga2VybmVsJ3MgW2Bmc2xlZXBgXSwgd2hpY2ggY291bGQgc2xlZXANCj4+IC8vLyBpbmZpbml0
ZWx5IChmb3IgW2BNQVhfSklGRllfT0ZGU0VUYF0gamlmZmllcykuDQo+Pg0KPj4gTG9va3Mgb2s/
DQo+IA0KPiBJIHRoaW5rIGlmIHRoYXQgaXMgbWVhbnQgYXMgYW4gaW50cmEtZG9jIGxpbmssIGl0
IHdvdWxkIGxpbmsgdG8gdGhpcw0KPiBmdW5jdGlvbiwgcmF0aGVyIHRoYW4gdGhlIEMgc2lkZSBv
bmUsIHNvIHBsZWFzZSBhZGQgYSBsaW5rIHRhcmdldCB0bw0KPiBlLmcuIGh0dHBzOi8vZG9jcy5r
ZXJuZWwub3JnL3RpbWVycy9kZWxheV9zbGVlcF9mdW5jdGlvbnMuaHRtbCNjLmZzbGVlcC4NCg0K
QWRkZWQuDQoNCj4gSSB3b3VsZCBhbHNvIHNheSAidGhlIEMgc2lkZSBbYGZzbGVlcCgpYF0gb3Ig
c2ltaWxhciI7IGluIG90aGVyIHdvcmRzLA0KPiBib3RoIGFyZSAia2VybmVsJ3MiIGF0IHRoaXMg
cG9pbnQuDQoNCkFncmVlZCB0aGF0ICJ0aGUgQyBzaWRlIiBpcyBiZXR0ZXIgYW5kIHVwZGF0ZWQg
dGhlIGNvbW1lbnQuIEkgY29waWVkDQp0aGF0IGV4cHJlc3Npb24gZnJvbSB0aGUgZXhpc3Rpbmcg
Y29kZTsgdGhlcmUgYXJlIG1hbnkgImtlcm5lbCdzIiBpbg0KcnVzdC9rZXJuZWwvLiAiZ29vZCBm
aXJzdCBpc3N1ZXMiIGZvciB0aGVtPw0KDQpZb3UgcHJlZmVyICJbYGZzbGVlcCgpYF0iIHJhdGhl
ciB0aGFuICJbYGZzbGVlcGBdIj8gSSBjYW4ndCBmaW5kIGFueQ0KcHJlY2VkZW50IGZvciB0aGUg
QyBzaWRlIGZ1bmN0aW9ucy4NCg0KPiBBbmQgcGVyaGFwcyBJIHdvdWxkIHNpbXBsaWZ5IGFuZCBz
YXkgc29tZXRoaW5nIGxpa2UgIlRoZSBiZWhhdmlvcg0KPiBhYm92ZSBkaWZmZXJzIGZyb20gdGhl
IEMgc2lkZSBbYGZzbGVlcCgpYF0gZm9yIHdoaWNoIG91dC1vZi1yYW5nZQ0KPiB2YWx1ZXMgbWVh
biAiaW5maW5pdGUgdGltZW91dCIgaW5zdGVhZC4iDQoNClllYWgsIHNpbXBsZXIgaXMgYmV0dGVy
LiBBZnRlciBhcHBseWluZyB0aGUgYWJvdmUgY2hhbmdlcywgaXQgZW5kZWQgdXANCmFzIGZvbGxv
d3MuDQoNCi8vLyBTbGVlcHMgZm9yIGEgZ2l2ZW4gZHVyYXRpb24gYXQgbGVhc3QuDQovLy8NCi8v
LyBFcXVpdmFsZW50IHRvIHRoZSBDIHNpZGUgW2Bmc2xlZXBgXSwgZmxleGlibGUgc2xlZXAgZnVu
Y3Rpb24sDQovLy8gd2hpY2ggYXV0b21hdGljYWxseSBjaG9vc2VzIHRoZSBiZXN0IHNsZWVwIG1l
dGhvZCBiYXNlZCBvbiBhIGR1cmF0aW9uLg0KLy8vDQovLy8gYGRlbHRhYCBtdXN0IGJlIHdpdGhp
biBbMCwgYGkzMjo6TUFYYF0gbWljcm9zZWNvbmRzOw0KLy8vIG90aGVyd2lzZSwgaXQgaXMgZXJy
b25lb3VzIGJlaGF2aW9yLiBUaGF0IGlzLCBpdCBpcyBjb25zaWRlcmVkIGEgYnVnDQovLy8gdG8g
Y2FsbCB0aGlzIGZ1bmN0aW9uIHdpdGggYW4gb3V0LW9mLXJhbmdlIHZhbHVlLCBpbiB3aGljaCBj
YXNlIHRoZQ0KLy8vIGZ1bmN0aW9uIHdpbGwgc2xlZXAgZm9yIGF0IGxlYXN0IHRoZSBtYXhpbXVt
IHZhbHVlIGluIHRoZSByYW5nZSBhbmQNCi8vLyBtYXkgd2FybiBpbiB0aGUgZnV0dXJlLg0KLy8v
DQovLy8gVGhlIGJlaGF2aW9yIGFib3ZlIGRpZmZlcnMgZnJvbSB0aGUgQyBzaWRlIFtgZnNsZWVw
YF0gZm9yIHdoaWNoIG91dC1vZi1yYW5nZQ0KLy8vIHZhbHVlcyBtZWFuICJpbmZpbml0ZSB0aW1l
b3V0IiBpbnN0ZWFkLg0KLy8vDQovLy8gVGhpcyBmdW5jdGlvbiBjYW4gb25seSBiZSB1c2VkIGlu
IGEgbm9uYXRvbWljIGNvbnRleHQuDQovLy8NCi8vLyBbYGZzbGVlcGBdOiBodHRwczovL2RvY3Mu
a2VybmVsLm9yZy90aW1lcnMvZGVsYXlfc2xlZXBfZnVuY3Rpb25zLmh0bWwjYy5mc2xlZXANCnB1
YiBmbiBmc2xlZXAoZGVsdGE6IERlbHRhKSB7DQoNCg0KPj4gQSByYW5nZSBjYW4gYmUgdXNlZCBm
b3IgYSBjdXN0b20gdHlwZT8NCj4gDQo+IEkgd2FzIHRoaW5raW5nIG9mIGRvaW5nIGl0IHRocm91
Z2ggYGFzX25hbm9zKClgLCBidXQgaXQgbWF5IHJlYWQNCj4gd29yc2UsIHNvIHBsZWFzZSBpZ25v
cmUgaXQgaWYgc28uDQoNCkFoLCBpdCBtaWdodCB3b3JrLiBUaGUgZm9sbG93aW5nIGRvZXNuJ3Qg
d29yay4gU2VlbXMgdGhhdCB3ZSBuZWVkIHRvDQphZGQgYW5vdGhlciBjb25zdCBsaWtlIE1BWF9E
RUxUQV9OQU5PUyBvciBzb21ldGhpbmcuIE5vIHN0cm9uZw0KcHJlZmVyZW5jZSBidXQgSSBmZWVs
IHRoZSBjdXJyZW50IGlzIHNpbXBsZXIuDQoNCmxldCBkZWx0YSA9IG1hdGNoIGRlbHRhLmFzX25h
bm9zKCkgew0KICAgIDAuLj1NQVhfREVMVEEuYXNfbmFub3MoKSBhcyBpMzIgPT4gZGVsdGEsDQog
ICAgXyA9PiBNQVhfREVMVEEsDQp9Ow0K

