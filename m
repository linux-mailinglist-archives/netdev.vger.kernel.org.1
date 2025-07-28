Return-Path: <netdev+bounces-210508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63277B13AC7
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 14:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F841627FE
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E3926561E;
	Mon, 28 Jul 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2/qWS35"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120B25178C;
	Mon, 28 Jul 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753707146; cv=none; b=WUSONGb4LWvg3hceTw+wWxSR8R1kLUvn/9zB+dJjapP6+BEAfyjJsMl6yOPJcvQ0D4gBPfXlq2eUImSROoTBcKmKDilDM8FYxWu6Uk1Mfjzyn+gvToBYFOOWQidtNO6Uzw0whTlSzxgdcY0HdYpt4XUxXO2QSwbMLpkgrr4b2iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753707146; c=relaxed/simple;
	bh=Bzx7885w8b5hrR9JTuHQKsYWtXB/nAo6dn34ZuHsM88=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fVza6Jrx93qAf5pYr7pFqThtq3S1vZsAVNlcAB2Dok7CspCkJhEKvE8CTaEJeJJ7EinhTM3D9ki9nkJPG22Dc3ZTsDXoaB3KjpSA3A+4+ksmCp0CLeYc8W8+w8OjTofthHeR1PIJj6qNoueTJhSC7+mnjYiYbkqHBkj3GmHinRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2/qWS35; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so4019453a91.1;
        Mon, 28 Jul 2025 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753707144; x=1754311944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzx7885w8b5hrR9JTuHQKsYWtXB/nAo6dn34ZuHsM88=;
        b=G2/qWS35/Hh94+Cr88ZuSxLE1w6g/NF+XywTc2xIFSxFnRqvnafs308fyksEV4vE+v
         WMQUFIZ0wwpVZfxGoZPpfvNjgiHqje9uqw6HAFICAXMiNyPfr1IwE1qCCtrn5wTwu1Li
         PmzU4nAVGOlXc5q0+Gh/ZM3ViZVD7HKF2EvFHvc190kDwIc3OONb1dTKH63/w1AhVrLL
         Ap3qAhwtDx1zFKQ09zye0BPnP/HiwyFRnTG/M5BdtDhh/3+pU9FlkZ8oDi1NxJj82lt/
         iYlr4sWBf9ZNvTPuCdO5yAyzBN+vDE9S2VvdjtFTuMXdvqttAloY+0UfIsZBdCh6m0iL
         LaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753707144; x=1754311944;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bzx7885w8b5hrR9JTuHQKsYWtXB/nAo6dn34ZuHsM88=;
        b=nHLjX+BEIAvbdHMbxpsoJqF3+YSsGvGUEYLCVHNcmLUhOD5WHkcRFGVZ/JUag289N8
         R/EGpUUgBxWjm5d3gycGoB316hAWUnTNDD/ljwGe3T63SHUFXSLfYUSwZ1tB814BLHyS
         bxodN65re4+P31Q1WLlybE8irjAIfnsDKMLAEW8H4WwyW3otuSlDjPjKLELfhXMoTMi2
         UV+sBwcw0tx1iQEH+D7wx2K9tAYPxLO/T+dtGu/KIgBYO0Uqd8F/3H5ZG276/PpBDCwu
         rWMb3GImRhsu0WCCm/FWxB++L0Gf87nfVwuSclIQlnhwpZOnvUabvlWIdeTMhlgb/5MS
         Ep/w==
X-Forwarded-Encrypted: i=1; AJvYcCW6/a2H/i2Iv/uWeEHMUYpHOL+73uWzkquL3Ufe17WjlFoiq6rjTotdj95u7GGe1kUit2MZ+b30O2buMIrbRNg=@vger.kernel.org, AJvYcCWwAw3N9cSDM6RinpOYFq+vLD7GGNvHRFwCST6BJwE+sxUtW2CH2LyafjuqS/CriarZ+1xdxKcrkEwdIN8=@vger.kernel.org, AJvYcCX0mZEw/nmtiUqYeeMUY0oepEXwfwqYVCjyFw0udfEJQMm3bKYQL1TNPco5L+2GHmlKhdlmhgpb@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2hyRz+uMFcK8HYlhwqm7ui6mS+RjruQVK0KQvkgfCOIf21hp
	/BiMQvI8rSg1MKb+0kLoZTCVTPKVnThSb6jY0M0J7xbfsKh1Dr+VwN5E
X-Gm-Gg: ASbGncs2vnqik/3po9LvcVrevNs/bYZtmtx7kYEWNIxtmaHwuWmWHbfO/gKHiXT7hvT
	cYwSJ0/Ofi8y48xDr7qgQlgsV+lkkszE3Qp07A0uyZvygS8YGVD6fdW3IqsAF4m/oJ0nAJj1wiF
	S05bLPFFeb/2Cme9nSWpKHySoMqLuawmQX/XcFEtiWaRYJVJ5Kwe1N3MWE+7+UpE8Zfk15CmUbA
	8HlTJx9wo68TZVrwIXJZO9h9xV/yAY5DWl9QTxppZtVKXQjFPhvbWUgxgzZWv3jUBokA45OvTsT
	m2cBGOq3/OzGuuLelp7PaULkWhB1JskphENMJka9nvTodh9QDG7MbLO39+k/Dnmvuh9kfGoLgs+
	mruJO5QuquPG2PwMIhy+nRiO2pPi5LqfrVG7WzqJ8F9UCj0vBH7xfxrDJhEfCjhGZ5VtfdTdRgq
	tS
X-Google-Smtp-Source: AGHT+IEn52gJehP0ml9jaKxUnsIWsjv7MCUJDGTiLjRA5hhdT40/dzIQ8CU6vCWnWkTEFB0aqIfqdg==
X-Received: by 2002:a17:90b:3b4c:b0:313:db0b:75db with SMTP id 98e67ed59e1d1-31e77a24b41mr17406692a91.33.1753707143934;
        Mon, 28 Jul 2025 05:52:23 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8ea37b21sm5293098a91.22.2025.07.28.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 05:52:23 -0700 (PDT)
Date: Mon, 28 Jul 2025 21:52:09 +0900 (JST)
Message-Id: <20250728.215209.1705204563387737183.fujita.tomonori@gmail.com>
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
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev,
 david.laight.linux@gmail.com
Subject: Re: [PATCH v11 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <FC2BC3FF-21F2-4166-9ACD-E14FE722793D@collabora.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
	<20250220070611.214262-8-fujita.tomonori@gmail.com>
	<FC2BC3FF-21F2-4166-9ACD-E14FE722793D@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64

T24gTW9uLCAyOCBKdWwgMjAyNSAwOTo0NDozOSAtMDMwMA0KRGFuaWVsIEFsbWVpZGEgPGRhbmll
bC5hbG1laWRhQGNvbGxhYm9yYS5jb20+IHdyb3RlOg0KDQo+PiBBZGQgcmVhZF9wb2xsX3RpbWVv
dXQgZnVuY3Rpb25zIHdoaWNoIHBvbGwgcGVyaW9kaWNhbGx5IHVudGlsIGENCj4+IGNvbmRpdGlv
biBpcyBtZXQgb3IgYSB0aW1lb3V0IGlzIHJlYWNoZWQuDQo+PiANCj4+IFRoZSBDJ3MgcmVhZF9w
b2xsX3RpbWVvdXQgKGluY2x1ZGUvbGludXgvaW9wb2xsLmgpIGlzIGEgY29tcGxpY2F0ZWQNCj4+
IG1hY3JvIGFuZCBhIHNpbXBsZSB3cmFwcGVyIGZvciBSdXN0IGRvZXNuJ3Qgd29yay4gU28gdGhp
cyBpbXBsZW1lbnRzDQo+PiB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5IGluIFJ1c3QuDQo+PiANCj4+
IFRoZSBDIHZlcnNpb24gdXNlcyB1c2xlZXBfcmFuZ2UoKSB3aGlsZSB0aGUgUnVzdCB2ZXJzaW9u
IHVzZXMNCj4+IGZzbGVlcCgpLCB3aGljaCB1c2VzIHRoZSBiZXN0IHNsZWVwIG1ldGhvZCBzbyBp
dCB3b3JrcyB3aXRoIHNwYW5zIHRoYXQNCj4+IHVzbGVlcF9yYW5nZSgpIGRvZXNuJ3Qgd29yayBu
aWNlbHkgd2l0aC4NCj4+IA0KPj4gVGhlIHNsZWVwX2JlZm9yZV9yZWFkIGFyZ3VtZW50IGlzbid0
IHN1cHBvcnRlZCBzaW5jZSB0aGVyZSBpcyBubyB1c2VyDQo+PiBmb3Igbm93LiBJdCdzIHJhcmVs
eSB1c2VkIGluIHRoZSBDIHZlcnNpb24uDQo+PiANCj4+IHJlYWRfcG9sbF90aW1lb3V0KCkgY2Fu
IG9ubHkgYmUgdXNlZCBpbiBhIG5vbmF0b21pYyBjb250ZXh0LiBUaGlzDQo+PiByZXF1aXJlbWVu
dCBpcyBub3QgY2hlY2tlZCBieSB0aGVzZSBhYnN0cmFjdGlvbnMsIGJ1dCBpdCBpcyBpbnRlbmRl
ZA0KPj4gdGhhdCBrbGludCBbMV0gb3IgYSBzaW1pbGFyIHRvb2wgd2lsbCBiZSB1c2VkIHRvIGNo
ZWNrIGl0IGluIHRoZQ0KPj4gZnV0dXJlLg0KPj4gDQo+PiBMaW5rOiBodHRwczovL3J1c3QtZm9y
LWxpbnV4LmNvbS9rbGludCBbMV0NCj4+IFRlc3RlZC1ieTogRGFuaWVsIEFsbWVpZGEgPGRhbmll
bC5hbG1laWRhQGNvbGxhYm9yYS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGVUpJVEEgVG9tb25v
cmkgPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+DQo+IA0KPiBUaGlzIGFwcGVhcnMgdG8gYmUg
dGhlIGxhc3QgdmVyc2lvbiBvZiB0aGlzIHBhdGNoLiBEbyB5b3UgaGF2ZSBhbnkgcGxhbnMgdG8N
Cj4ga2VlcCB3b3JraW5nIG9uIGl0PyBJcyB0aGVyZSBhbnl0aGluZyBJIGNhbiBkbyB0byBoZWxw
PyA6KQ0KPiANCj4gSWYgeW91IGRvbqJ0IGhhdmUgdGhlIHRpbWUgdG8gd29yayBvbiB0aGlzLCBJ
IGNhbiBwaWNrIGl0IHVwIGZvciB5b3UuDQoNCkFsbCB0aGUgZGVwZW5kZW5jaWVzIGZvciB0aGlz
IHBhdGNoICh0aW1lciwgZnNsZWVwLCBtaWdodF9zbGVlcCwgZXRjKQ0KYXJlIHBsYW5uZWQgdG8g
YmUgbWVyZ2VkIGluIDYuMTctcmMxLCBhbmQgSSdsbCBzdWJtaXQgdGhlIHVwZGF0ZWQNCnZlcnNp
b24gYWZ0ZXIgdGhlIHJjMSByZWxlYXNlLg0K

