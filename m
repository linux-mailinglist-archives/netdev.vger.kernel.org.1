Return-Path: <netdev+bounces-159211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CEBA14C91
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579537A0F44
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA651FA8EB;
	Fri, 17 Jan 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFf2uZhF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7B1D5CE5;
	Fri, 17 Jan 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107712; cv=none; b=LaFVLGu1cWSj5atiujq9ChNjTfvIRN0WBscj4Owe2hHvedIi1cRF3/aBL3dV+ShQsjvNENaWWUfG6B+ggSdkHC0v2Ml6u6x+84YOytwdk+myY1foFcyxdjF6bEZQjr2PRR/ndwmh4HbtQq2N3VnmsnOo+HvR9hQjc6ycEmZc0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107712; c=relaxed/simple;
	bh=NDPiiDL2EJgsMiMDgkfEcuxcVz2vxKtRDjArjJB78J8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=boeJX5wezqk4UQqyTpdBu3GPoj60eck2lMqtjkzpAiLVvC7yphHAczuj0bY72rcNNqWwSXCjRwtjELOT2He7zHuCfh/aZBSq5FalZ5W9HUoSzc1jleJew3Fy/OqeBdDd4ns7mcq5w5uQuncuaJ37SkcAwxP6lpDJYcbx7lRDS2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFf2uZhF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21bc1512a63so37665375ad.1;
        Fri, 17 Jan 2025 01:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737107710; x=1737712510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDPiiDL2EJgsMiMDgkfEcuxcVz2vxKtRDjArjJB78J8=;
        b=iFf2uZhF/SFAtdWMp8jMR0zI5lcaABE4XojRjnYfz7d7XlZHhzgQ8Zwp1BEtCeWvpJ
         Own+fp5OZLaf5wTfDxkB2NRoJrb8IWahOR3xdfMrMteh/2sGI0waWPBTxFsVE8LK9cH0
         IA2SVfCmm3YABVzQt72md+Mxy3Op28W/uWmE7QfpT71FWQrgEPepmDr27+VvtRUMurhc
         NwOfsIOQP7Z0MR7rq2zjpVDvfiw3oUYWiuxRLihdoUKbVPeDNMFsPCQ+Iv/0K7K2VVY9
         Wrh43OuKyNUaUCuCpH0L8/ReJmAxc9R45Mfds0qtLaOtKw7CkmJWSm9YuiXqh4X5k0xL
         G83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737107710; x=1737712510;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDPiiDL2EJgsMiMDgkfEcuxcVz2vxKtRDjArjJB78J8=;
        b=L5mR7QOuqo81H7rZIiDU9qIv/XnWMFECyG1VXVsoeME+/tsL3BB0IRm73+CUcA3XGb
         /hZnI+XSyNHJ0ok0aU/tI+i5Uo3y61YtNP8FCD3nc8vDTjviboWHRutWa02WQVLvseFi
         Q7jtks40MGpEacBaL/+Hovd4uk68NgOreh0UWsO7bXC2FMApvfvBRorVOaYWJ6ImqiO/
         Jho99/aeRaLQcJRLKF6FBWK/fE6MHgyje0gRfoNFNaH/mUYYciUOKw9PPnqnd/LzNlKl
         XP+zRMTR9DP+CMZjcBYr6iueBu98Zt4RMLkoQwUVzdC5/WKS/imTC5+/VlO6sxTXHjUC
         CWXg==
X-Forwarded-Encrypted: i=1; AJvYcCU+CPfYgDt8kuTTbCmEP+LXx+vXoXgzKQ+A9WDu2f3/PRsMHTn9hSiVqF+2VukCYzCYvwnRWW6J@vger.kernel.org, AJvYcCUjzK8u4nHxH4DoH9Orz2irARoqbmyBGnfC9WKcL2eRkmTnmPg8Jh76jBHxcUDFmjh7tlLoVz98jLwJdyk=@vger.kernel.org, AJvYcCXjl+l6OYW0WK/UPRpnFsXuk+6Q5FnfVuHnGtzxHSFojJcapRZIGdiy5HC90hkGWjl/wNPg4Fz9rnJUu/j9EE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/ecbbYmq3elx6zgnSANln0t0uCa5lzf7wxkZPoqaEnCfq2bz
	qWB1pOpVnOQUy5SbNilypgguqgMe9an7BAMhdKkI0Lj97pH5CU5u
X-Gm-Gg: ASbGncsXYpblPwy8lxUbufx1OxhpNyu+Drfdn8hKj7v44+tBTnNFh31/249yaR02MWN
	/iVsij14/ppKjUqKO+F3Tk7YOungB/ddA5RuJWsNsUpF0LPDhsnOZQ8Rlcmy90PBXZlhJmMa/Nc
	vqnBsdE+hMPJXTUCway6JjVfwUCXh/WbD/IJgNdEYQaFYNSx7VSWq/cJcqj+wumWs8Avd6QqZF1
	3lOrzy2hPEpUQb0OKwJTm3k82oD9MnXJ63vIDmjqbRWPCG483gjRTveXX5sU8rYKZSBjfTLaLWt
	8+UYSns58EcE/AmmahF3RImzSozvaYcWW3Xbvg==
X-Google-Smtp-Source: AGHT+IG9dH++mB/LJTdyM/kqUXpkgibjw92NJP40h2Cnm1AFwNMomE+o8DLfPRXFUAkExF0MBfVRmA==
X-Received: by 2002:a17:902:cf01:b0:215:5ea2:654b with SMTP id d9443c01a7336-21c3553b6efmr38433915ad.1.1737107709888;
        Fri, 17 Jan 2025 01:55:09 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e14aesm12265375ad.195.2025.01.17.01.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:55:09 -0800 (PST)
Date: Fri, 17 Jan 2025 18:55:01 +0900 (JST)
Message-Id: <20250117.185501.1171065234025373111.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 4/7] rust: time: Add wrapper for fsleep function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLggUGT83saC++M-kd57bGvWj5dwAgbWZ95r+PHz_B67NLQ@mail.gmail.com>
References: <20250117.165326.1882417578898126323.fujita.tomonori@gmail.com>
	<20250117.180147.1155447135795143952.fujita.tomonori@gmail.com>
	<CAH5fLggUGT83saC++M-kd57bGvWj5dwAgbWZ95r+PHz_B67NLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gRnJpLCAxNyBKYW4gMjAyNSAxMDoxMzowOCArMDEwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIEZyaSwgSmFuIDE3LCAyMDI1IGF0IDEwOjAx4oCv
QU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwuY29tPiB3cm90ZToN
Cj4+DQo+PiBPbiBGcmksIDE3IEphbiAyMDI1IDE2OjUzOjI2ICswOTAwIChKU1QpDQo+PiBGVUpJ
VEEgVG9tb25vcmkgPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0KPj4NCj4+ID4g
T24gVGh1LCAxNiBKYW4gMjAyNSAxMDoyNzowMiArMDEwMA0KPj4gPiBBbGljZSBSeWhsIDxhbGlj
ZXJ5aGxAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+PiA+DQo+PiA+Pj4gKy8vLyBUaGlzIGZ1bmN0aW9u
IGNhbiBvbmx5IGJlIHVzZWQgaW4gYSBub25hdG9taWMgY29udGV4dC4NCj4+ID4+PiArcHViIGZu
IGZzbGVlcChkZWx0YTogRGVsdGEpIHsNCj4+ID4+PiArICAgIC8vIFRoZSBhcmd1bWVudCBvZiBm
c2xlZXAgaXMgYW4gdW5zaWduZWQgbG9uZywgMzItYml0IG9uIDMyLWJpdCBhcmNoaXRlY3R1cmVz
Lg0KPj4gPj4+ICsgICAgLy8gQ29uc2lkZXJpbmcgdGhhdCBmc2xlZXAgcm91bmRzIHVwIHRoZSBk
dXJhdGlvbiB0byB0aGUgbmVhcmVzdCBtaWxsaXNlY29uZCwNCj4+ID4+PiArICAgIC8vIHNldCB0
aGUgbWF4aW11bSB2YWx1ZSB0byB1MzI6Ok1BWCAvIDIgbWljcm9zZWNvbmRzLg0KPj4gPj4+ICsg
ICAgY29uc3QgTUFYX0RVUkFUSU9OOiBEZWx0YSA9IERlbHRhOjpmcm9tX21pY3Jvcyh1MzI6Ok1B
WCBhcyBpNjQgPj4gMSk7DQo+PiA+Pg0KPj4gPj4gSG1tLCBpcyB0aGlzIHZhbHVlIGNvcnJlY3Qg
b24gNjQtYml0IHBsYXRmb3Jtcz8NCj4+ID4NCj4+ID4gWW91IG1lYW50IHRoYXQgdGhlIG1heGlt
dW0gY2FuIGJlIGxvbmdlciBvbiA2NC1iaXQgcGxhdGZvcm1zPyAyMTQ3NDg0DQo+PiA+IG1pbGxp
c2Vjb25kcyBpcyBsb25nIGVub3VnaCBmb3IgZnNsZWVwJ3MgZHVyYXRpb24/DQo+PiA+DQo+PiA+
IElmIHlvdSBwcmVmZXIsIEkgdXNlIGRpZmZlcmVudCBtYXhpbXVtIGR1cmF0aW9ucyBmb3IgNjQt
Yml0IGFuZCAzMi1iaXQNCj4+ID4gcGxhdGZvcm1zLCByZXNwZWN0aXZlbHkuDQo+Pg0KPj4gSG93
IGFib3V0IHRoZSBmb2xsb3dpbmc/DQo+Pg0KPj4gY29uc3QgTUFYX0RVUkFUSU9OOiBEZWx0YSA9
IERlbHRhOjpmcm9tX21pY3Jvcyh1c2l6ZTo6TUFYIGFzIGk2NCA+PiAxKTsNCj4gDQo+IFdoeSBp
cyB0aGVyZSBhIG1heGltdW0gaW4gdGhlIGZpcnN0IHBsYWNlPyBBcmUgeW91IHdvcnJpZWQgYWJv
dXQNCj4gb3ZlcmZsb3cgb24gdGhlIEMgc2lkZT8NCg0KWWVhaCwgQm9xdW4gaXMgY29uY2VybmVk
IHRoYXQgYW4gaW5jb3JyZWN0IGlucHV0IChhIG5lZ2F0aXZlIHZhbHVlIG9yDQphbiBvdmVyZmxv
dyBvbiB0aGUgQyBzaWRlKSBsZWFkcyB0byB1bmludGVudGlvbmFsIGluZmluaXRlIHNsZWVwOg0K
DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1p4d1Z1Y2VOT1JSQUk3RlZAQm9xdW5zLU1h
Yy1taW5pLmxvY2FsLw0K

