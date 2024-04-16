Return-Path: <netdev+bounces-88285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB08A697C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E9F1F21828
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07CA128814;
	Tue, 16 Apr 2024 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyDQQGT9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D3763F1;
	Tue, 16 Apr 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266179; cv=none; b=Cl+1M59MjmgaBodEtQ0u5vqVCz/K8gF5P/1jDHHLUmsET4XGKTX60Kz5mKmufztxOjZuQ1bI7ptOPBZ7UoDMhQLBc+KCn4qiiDwdsLLuVMa6U22D9LfTGL7dcMubkiXnVawt6CDtWOBPmg0q4KBnvarb4hZ4KwdIQ6037y/LFW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266179; c=relaxed/simple;
	bh=TGbR3JnUzJ3sa+v4fZa7yWG+DybFD/U+zGFtAXB+ESA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I32K/S7NzKYK8uWk+3mS1Vw8YOm9v4NHG2ntKBDWzAbMBv/AdDzIrpZUwX/wazH6LQD+NSBvgeym0pON1+yeBn0KWkulpmaD1o408vg3p3p/mEv/HzShWLbLOh0pMD+HdpC2wAHTX4aY3jlZ+ooZ3/M1enfL4KMhIamjcBhb1DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyDQQGT9; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c6febc1506so544629b6e.1;
        Tue, 16 Apr 2024 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713266177; x=1713870977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGbR3JnUzJ3sa+v4fZa7yWG+DybFD/U+zGFtAXB+ESA=;
        b=VyDQQGT9Diqc0bD3xfCNg7RAMYdo5LhE9o+wSPK1mZ9R/PR4XNEdazGnoWvS6n+K3o
         H5QAihhYJ38WdnT3jt8CaoN3Ul0oZnOHxsKLOkLKiqV02tZwum6mMtM8DKnO5yGK1LQy
         X5VcTiuLvKaeRjGE4qQPfXXCOm+qqmkpF7Jj/uM1TEBtYk9kUnSCeLO3nEqXVZQeqh8D
         vwxdeL4VVHHtM1ksipLho9ZXueI7cLlO/kj0hXXJ87P0hK4yzcOPWkk8ZNN0UtF/ZJV8
         bA+WHD8obuq3DSh0AzwP3O5vbJhNk+R51VEN2sOYE0B5ZbIKjrIiPr4XmBMnc4PRReAT
         c7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713266177; x=1713870977;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TGbR3JnUzJ3sa+v4fZa7yWG+DybFD/U+zGFtAXB+ESA=;
        b=jhQHiIabrtrZDCgn+Ro04XUdhJDjT08J0+wBhtGoTMXZ7G0eQC/MsZ5vVq5NwfBV6+
         H3D01GWcIH33RRqmfdFIiNuiJerAIwXzPIjzboBrmKuLSeBFcxqE3vTUdOiuFHc51HI/
         DZ+aKz816E5NEXUWqa2/+HvmfT+rFitlKdENHr+SzZ0KTZ+Fhj0PExxniZvUdrA5RqD/
         VUa556drabZNpfWP8kXKg4Gtbp1WPLHzMQMV1M9xsRmb+T48q+DWc/FPwPk6SUOviVjs
         w+2Pu4XCzssZR3SWCB6tjVBg90L1GABP2kedgx6B60EI+/2kroRJFXHf4Vq/SslDiCBt
         9qhw==
X-Forwarded-Encrypted: i=1; AJvYcCU8AHBqpGCM1oi0pV1JCsYni6sKG4Z51cLlCdJ+W5Ah6Gq6L/hUFbEYo+ZIZU+/2Ju7mfyriu8si8c2ZvnsLwuBKfFuHqpe9C5zI52bIWXXbsnwQagdXysfZCPzmCHL1txe37GuvZY=
X-Gm-Message-State: AOJu0YxS5b+lew1bukxx7a66PgDVBTEU7dqUDS+7FeiP4GZ0g2EsrM4z
	WfuKb3kCXAHODclN1v2Q4lAgm23DM7FvZyYTtwL1uo0I1Ns3/P+P
X-Google-Smtp-Source: AGHT+IGit+fB/42fmhXB1CelgMMRSX/STdA8s0Oi8gy02MLaCnX9EzJC64HMWIkFPTWeD00J+20aKA==
X-Received: by 2002:a05:6870:5248:b0:220:bd4d:674d with SMTP id o8-20020a056870524800b00220bd4d674dmr13671443oai.5.1713266177341;
        Tue, 16 Apr 2024 04:16:17 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id o11-20020a056a001b4b00b006ed5ffc3751sm8789565pfv.139.2024.04.16.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 04:16:17 -0700 (PDT)
Date: Tue, 16 Apr 2024 20:16:03 +0900 (JST)
Message-Id: <20240416.201603.1026787007638816255.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: tmgross@umich.edu, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 andrew@lunn.ch, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <89f6cd1e-2e3c-4fc1-b9a5-2932480f8e60@proton.me>
References: <20240415104701.4772-5-fujita.tomonori@gmail.com>
	<CALNs47v+35RX4+ibHrcZgrJEJ52RqWRQUBa=_Aky_6gk1ika4w@mail.gmail.com>
	<89f6cd1e-2e3c-4fc1-b9a5-2932480f8e60@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksDQoNCk9uIFR1ZSwgMTYgQXByIDIwMjQgMDY6NTg6MzggKzAwMDANCkJlbm5vIExvc3NpbiA8
YmVubm8ubG9zc2luQHByb3Rvbi5tZT4gd3JvdGU6DQoNCj4gT24gMTYuMDQuMjQgMDY6MzQsIFRy
ZXZvciBHcm9zcyB3cm90ZToNCj4+IE9uIE1vbiwgQXByIDE1LCAyMDI0IGF0IDY6NDfigK9BTSBG
VUpJVEEgVG9tb25vcmkNCj4+IDxmdWppdGEudG9tb25vcmlAZ21haWwuY29tPiB3cm90ZToNCj4+
PiArc3RydWN0IFBoeVFUMjAyNTsNCj4+PiArDQo+Pj4gKyNbdnRhYmxlXQ0KPj4+ICtpbXBsIERy
aXZlciBmb3IgUGh5UVQyMDI1IHsNCj4+PiArICAgIGNvbnN0IE5BTUU6ICYnc3RhdGljIENTdHIg
PSBjX3N0ciEoIlFUMjAyNSAxMEdwYnMgU0ZQKyIpOw0KPj4gDQo+PiBTaW5jZSAxLjc3IHdlIGhh
dmUgQyBzdHJpbmcgbGl0ZXJhbHMsIGBjIlFUMjAyNSAxMEdwYnMgU0ZQKyJgICh3b29ob28pDQo+
IA0KPiBXZSBoYXZlIG91ciBvd24gYENTdHJgIGluIHRoZSBga2VybmVsOjpzdHI6OkNTdHJgLCBz
byB3ZSBjYW5ub3QgcmVwbGFjZQ0KPiB0aGUgYGNfc3RyIWAgbWFjcm8gYnkgdGhlIGxpdGVyYWwg
ZGlyZWN0bHkuIEluc3RlYWQgd2UgYWxzbyBuZWVkIHRvDQo+IHJlbW92ZSBvdXIgb3duIGBDU3Ry
YC4gV2UgYWxyZWFkeSBoYXZlIGFuIGlzc3VlIGZvciB0aGF0Og0KPiBodHRwczovL2dpdGh1Yi5j
b20vUnVzdC1mb3ItTGludXgvbGludXgvaXNzdWVzLzEwNzUNCg0KU2VlbXMgdGhhdCBzb21lb25l
IGFscmVhZHkgc3RhcnRlZCB0byB3b3JrIG9uIHRoaXMgaXNzdWUgc28gSSdsbCBrZWVwDQp0aGlz
IGFsb25lIGZvciBub3cuDQo=

