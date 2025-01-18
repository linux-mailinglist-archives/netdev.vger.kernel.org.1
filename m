Return-Path: <netdev+bounces-159547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9AAA15BD4
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 09:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0A13A9287
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713BA15667B;
	Sat, 18 Jan 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJISa9hl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB9126C16;
	Sat, 18 Jan 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737187357; cv=none; b=hm9O6W7TwBTQc/+KSwye6AoL5NCW4z+OtekZFutX5+484CLNi7JfnzyhUgvDTNABdZs/AXw/z9HpExIbXfB8XWtles9+n7bRgy6lN1fI65kx6nqtjxHcJA2dAytM2x+cem5l33zqqZaGOfxB7QBTny+PuIbBEUhna/UAXJAp7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737187357; c=relaxed/simple;
	bh=PRWJ/8+kbYx6TxuW8kMfMS9U1TCERcAdxvnuUYQfxh4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YKNrjJHJfSY4I3cHOPJ/mLoiDf3k4s4R3/ZEjRdbGpxToSY5NyRQyCeM+H58nBHjXABBjtWrP0Jeoo+VSxGrjPFuqtEQKsXgmq99K9EQxZu/T+gleI7KsYueap50R9509+GvckzgrobFNLSR6Q6M6mxu9d17Ix/rwUWVp7TzhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJISa9hl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216728b1836so51279065ad.0;
        Sat, 18 Jan 2025 00:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737187354; x=1737792154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRWJ/8+kbYx6TxuW8kMfMS9U1TCERcAdxvnuUYQfxh4=;
        b=IJISa9hlSyfE4N9/oLYgM4xTYWLSCctjSjGPpk38qJ/aq1jUkVx5J+BHc8ZlkF2LaV
         1/cTpk9Qw8bNB/CLnHCczcEDumzc9x3AvJ17ddwReNGb9ZxCN/WHxy0WtnR6OXyb1UTl
         OetHyCV5MitxNqStkx+Su8woq2djm6LXg2Zuvsb1jiRrLmt44VI6botxHa4/0ED61P4H
         WlGmnMqxtxP/tTPGQiOQE1QSdhzfnsaz48nHj5nWrIeArS1eZMDN3VuAyz1iyyf6h8/P
         M2QUJVofFU/a9K/kZHqz/nw8bmNGsqc3dpyHts2pYhNREnD9zwnGvoqMIWzvyS9cYSWN
         7q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737187354; x=1737792154;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PRWJ/8+kbYx6TxuW8kMfMS9U1TCERcAdxvnuUYQfxh4=;
        b=wAXpN/nyWTsH2ywyx30H3s9SAqmM9sJDFUnkFH5knnudSy1qIDP5xi+yjuHRqOL5LR
         S7ErAgZgyN6luk8N3TZQnNrKNzpm7fowb5zseP9Xu2HNKWMTlxvAhUwjASEHwj7x3xkT
         17AjFR7aQNqUWT2vOiuQ79BX71UmMe9hXrVjzjN3sqp9qRZqxbkjyoCuAfQdxcuCiLWb
         Qgtt1uVWyihl1mxIarp93Gk6IFs5t1bGkKaS49qtigCLLMJR6jqWdCnqp7bAl5h727Qw
         x6+dgjCbqP0Gm4TGhyHIxC6VUscr1IPxPQBvTEBlYkG2x+0dkGdcmNWDc8/uuo0o3ms+
         cYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU03K0/EUxdIXK7tkI/OYCD+eUHK2bQSs7uNXnEpOovnQ8C1j7rdV7LeclNhTSSMA0wbaIeh3e8@vger.kernel.org, AJvYcCV/9LvoNR59G9eTmplm8Ak6deZXFQ7lS5DSO+74kQ9TP5GvhP5bhJUIEBFGctz72/iBEpE3RC7EokqZ4EA=@vger.kernel.org, AJvYcCWrz4vklRGmo7gzvzQZRHbHwVuSZmBe0QPaFauhshc2iQ4gY9Cf/FYIguGXJjf/igsNMqCtbqtmGOnCETgseYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKU/IjJyKL/ZgSGY54F2WuXD21GSzEU+NwSyUzzK8IMEgATEYH
	VOWd9UUD4nJ1+M4Mh7yJz5r6B29znU7+IzHh4h0ErtqXE01dgiRO
X-Gm-Gg: ASbGncs993tw0ZNFAqzTUqdfPImuYKGGBcSbOSCdJDHXIhXLN7fWv53RUs7KiUK9jGT
	z9PQ0JvzRGiXFOba7dBAGHYBz95x+b9PZJ5J4ettQRnJq83OtmGY7w3HmaL/wLWiADPF09N+e85
	r9ATrZS6RXudxgju34Cq0B5bbDC05aCx+ukFEuUlSZnIPArGoC/X+dxsv3TY023V/s/7Zfa1fVe
	fEopknrYTyjriMlW/M1k11HBHjGDM+VCvCPvWci4qauvldmcWowvW9tXD3jkQiu+Ygyk/UncOPB
	nidcWvyOByW3ZVeSwOYNlLpvOrXoXVUuriOD8bxBjPxbqHAG8+Y=
X-Google-Smtp-Source: AGHT+IFZrQXn4cQjqqjO6tp4zcTVLI1Jlk9CHumufsfxsCGfjMscu+INcztPlSnDjVJQfTXL2v7AJQ==
X-Received: by 2002:a17:902:ce8d:b0:216:56d5:d87 with SMTP id d9443c01a7336-21c355ad56cmr91346145ad.34.1737187354090;
        Sat, 18 Jan 2025 00:02:34 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb735esm27299215ad.64.2025.01.18.00.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 00:02:33 -0800 (PST)
Date: Sat, 18 Jan 2025 17:02:24 +0900 (JST)
Message-Id: <20250118.170224.1577745251770787347.fujita.tomonori@gmail.com>
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
In-Reply-To: <CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-5-fujita.tomonori@gmail.com>
	<CANiq72nNsmuQz1mEx2ov8SXj_UAEURDZFtLotf4qP2pf+r97eQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gRnJpLCAxNyBKYW4gMjAyNSAxOTo1OToxNSArMDEwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBUaHUsIEphbiAxNiwgMjAy
NSBhdCA1OjQy4oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiArLy8vIGBkZWx0YWAgbXVzdCBiZSAwIG9yIGdyZWF0ZXIgYW5k
IG5vIG1vcmUgdGhhbiBgdTMyOjpNQVggLyAyYCBtaWNyb3NlY29uZHMuDQo+PiArLy8vIElmIGEg
dmFsdWUgb3V0c2lkZSB0aGUgcmFuZ2UgaXMgZ2l2ZW4sIHRoZSBmdW5jdGlvbiB3aWxsIHNsZWVw
DQo+PiArLy8vIGZvciBgdTMyOjpNQVggLyAyYCBtaWNyb3NlY29uZHMgKD0gfjIxNDcgc2Vjb25k
cyBvciB+MzYgbWludXRlcykgYXQgbGVhc3QuDQo+IA0KPiBJIHdvdWxkIGVtcGhhc2l6ZSB3aXRo
IHNvbWV0aGluZyBsaWtlOg0KPiANCj4gICAgIGBkZWx0YWAgbXVzdCBiZSB3aXRoaW4gWzAsIGB1
MzI6Ok1BWCAvIDJgXSBtaWNyb3NlY29uZHM7DQo+IG90aGVyd2lzZSwgaXQgaXMgZXJyb25lb3Vz
IGJlaGF2aW9yLiBUaGF0IGlzLCBpdCBpcyBjb25zaWRlcmVkIGEgYnVnDQo+IHRvIGNhbGwgdGhp
cyBmdW5jdGlvbiB3aXRoIGFuIG91dC1vZi1yYW5nZSB2YWx1ZSwgaW4gd2hpY2ggY2FzZSB0aGUN
Cj4gZnVuY3Rpb24gd2lsbCBzbGVlcCBmb3IgYXQgbGVhc3QgdGhlIG1heGltdW0gdmFsdWUgaW4g
dGhlIHJhbmdlIGFuZA0KPiBtYXkgd2FybiBpbiB0aGUgZnV0dXJlLg0KDQpUaGFua3MsIEknbGwg
dXNlIHRoZSBhYm92ZSBpbnN0ZWFkLg0KDQo+IEluIGFkZGl0aW9uLCBJIHdvdWxkIGFkZCBhIG5l
dyBwYXJhZ3JhcGggaG93IHRoZSBiZWhhdmlvciBkaWZmZXJzDQo+IHcuci50LiB0aGUgQyBgZnNs
ZWVwKClgLCBpLmUuIElJUkMgZnJvbSB0aGUgcGFzdCBkaXNjdXNzaW9ucywNCj4gYGZzbGVlcCgp
YCB3b3VsZCBkbyBhbiBpbmZpbml0ZSBzbGVlcCBpbnN0ZWFkLiBTbyBJIHRoaW5rIGl0IGlzDQo+
IGltcG9ydGFudCB0byBoaWdobGlnaHQgdGhhdC4NCg0KLy8vIFRoZSBhYm92ZSBiZWhhdmlvciBk
aWZmZXJzIGZyb20gdGhlIGtlcm5lbCdzIFtgZnNsZWVwYF0sIHdoaWNoIGNvdWxkIHNsZWVwDQov
Ly8gaW5maW5pdGVseSAoZm9yIFtgTUFYX0pJRkZZX09GRlNFVGBdIGppZmZpZXMpLg0KDQpMb29r
cyBvaz8NCg0KPj4gKyAgICAvLyBUaGUgYXJndW1lbnQgb2YgZnNsZWVwIGlzIGFuIHVuc2lnbmVk
IGxvbmcsIDMyLWJpdCBvbiAzMi1iaXQgYXJjaGl0ZWN0dXJlcy4NCj4+ICsgICAgLy8gQ29uc2lk
ZXJpbmcgdGhhdCBmc2xlZXAgcm91bmRzIHVwIHRoZSBkdXJhdGlvbiB0byB0aGUgbmVhcmVzdCBt
aWxsaXNlY29uZCwNCj4+ICsgICAgLy8gc2V0IHRoZSBtYXhpbXVtIHZhbHVlIHRvIHUzMjo6TUFY
IC8gMiBtaWNyb3NlY29uZHMuDQo+IA0KPiBOaXQ6IHBsZWFzZSB1c2UgTWFya2Rvd24gY29kZSBz
cGFucyBpbiBub3JtYWwgY29tbWVudHMgKG5vIG5lZWQgZm9yDQo+IGludHJhLWRvYyBsaW5rcyB0
aGVyZSkuDQoNClVuZGVyc3Rvb2QuDQoNCj4+ICsgICAgbGV0IGR1cmF0aW9uID0gaWYgZGVsdGEg
PiBNQVhfRFVSQVRJT04gfHwgZGVsdGEuaXNfbmVnYXRpdmUoKSB7DQo+PiArICAgICAgICAvLyBU
T0RPOiBhZGQgV0FSTl9PTkNFKCkgd2hlbiBpdCdzIHN1cHBvcnRlZC4NCj4gDQo+IERpdHRvIChh
bHNvICJBZGQiKS4NCg0KT29wcywgSSdsbCBmaXguDQoNCj4gQnkgdGhlIHdheSwgY2FuIHRoaXMg
YmUgd3JpdHRlbiBkaWZmZXJlbnRseSBtYXliZT8gZS5nLiB1c2luZyBhIHJhbmdlDQo+IHNpbmNl
IGl0IGlzIGBjb25zdGA/DQoNCkEgcmFuZ2UgY2FuIGJlIHVzZWQgZm9yIGEgY3VzdG9tIHR5cGU/
DQoNCj4gWW91IGNhbiBwcm9iYWJseSByZXVzZSBgZGVsdGFgIGFzIHRoZSBuZXcgYmluZGluZ3Mg
bmFtZSwgc2luY2Ugd2UNCj4gZG9uJ3QgbmVlZCB0aGUgb2xkIG9uZSBhZnRlciB0aGlzIHN0ZXAu
DQoNCkRvIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmc/DQoNCmNvbnN0IE1B
WF9ERUxUQTogRGVsdGEgPSBEZWx0YTo6ZnJvbV9taWNyb3MoaTMyOjpNQVggYXMgaTY0KTsNCg0K
bGV0IGRlbHRhID0gaWYgZGVsdGEgPiBNQVhfREVMVEEgfHwgZGVsdGEuaXNfbmVnYXRpdmUoKSB7
DQogICAgLy8gVE9ETzogQWRkIFdBUk5fT05DRSgpIHdoZW4gaXQncyBzdXBwb3J0ZWQuDQogICAg
TUFYX0RFTFRBDQp9IGVsc2Ugew0KICAgIGRlbHRhDQp9Ow0K

