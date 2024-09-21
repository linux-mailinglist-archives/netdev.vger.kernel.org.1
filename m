Return-Path: <netdev+bounces-129135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5025597DBB9
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 07:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED648283B99
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 05:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD518EBF;
	Sat, 21 Sep 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWq+ZD6u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCD179A3;
	Sat, 21 Sep 2024 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726895143; cv=none; b=DcnUXPDKQrLm5DQAcj5tmMZb6tXvUEbV1/ZN0QLIuOx2aQi7RiQI+77lzmVg7PluCS+J7vBWiE3GcOuRYxW0n/oKBo4YPCNtMqZxW2mFY4sc/agm4X6j/8WdD7nnNLap3NuNqI2wYKRbXYtOEr0v+ziPzJjrATb2leT557i8OPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726895143; c=relaxed/simple;
	bh=MJJOjLobciSf5OU//tAZSwvxztioLgpdYZiMckGPjxA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qmN9kHXYhSTZtQDjOp9O3F9LfFqDndCq31F4e/7AI8lwX9qg0t2iIW6ioDphDA3zKFa8vxyjX/dj5Ql6FOdRzJxmo+FUw3vVF5cotHGgwtbmr7t02rt9pZIt2/qkWgnX3o1al7cE//zm7QgtsS05CLkpwYhql9/9XuBz1GMlrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWq+ZD6u; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2db89fb53f9so1892716a91.3;
        Fri, 20 Sep 2024 22:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726895141; x=1727499941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJJOjLobciSf5OU//tAZSwvxztioLgpdYZiMckGPjxA=;
        b=CWq+ZD6uXUv1pF/rHuoJiJ48JjG9x6Y4jGiusBmia7bUCjFF1SIGBdRRSRARTuFX6F
         H63dK5czCoyFiuQtUiDVYTZvKmTTv0zxtA36Uj6GmzdodZKuWEI8xFNkFAiwpFDVPwVR
         NZqXYQwPdx5Uf0wtv5/ONpgH0df5JmRn1HBPO6Vp6hIAmej2PRQ3tCasRKBZNBTqFkV7
         LeHsZvfncbxVlMCGLEGXASC/9tf8ROzitJ9nmin91G3/UkFTeZ5oXlOlLHbH4d6miifO
         15hFgznxuNop1AybwlT9hvDLuFAftf53d/DoGqgt8OAgBd8om2WJ0FzLY/mGg7E0Ms74
         JRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726895141; x=1727499941;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MJJOjLobciSf5OU//tAZSwvxztioLgpdYZiMckGPjxA=;
        b=Jpw6obVnddPNNMsvx0uekbhP6F3IzdfpuUV96ifu/yL1GVNCp7kQPUut0dpPKsyfPI
         G3P2qRt4YIJmsHBZCQxg35NtfnKilPh8TOEF8YR9ggPrf0odJSK7GbfLmTmbx+RgpLy2
         vSzdIj3y/nWm5MPxl+Unv1xs7MDdnkgh/sxos8FukQoi7DmjOKhGy0Mg7wUPzzqIR5go
         SxOaSJzMTY9CqMXmIfgD1IfIGS6mFW0WUDSLaOjampQfGBAd7ObJs5U87LwZj2ehoipx
         TvqUtcY9ObySLJ9cXkLRZ2LyAJP+ce6sAACleBh3oOoNJDFIfcw9kdzDleSg/I+nwrAD
         W5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU17ZJUm2zYQXJbU0cfAgaPF15GIjULM550VXhXzZeD87axUU5+WIrkbmkas1LPNIyOaIT/yTl9LOXgzhKQ/g4=@vger.kernel.org, AJvYcCVJbfd/K54qEZBHLSfugWhhqWWQ2/RzIiyedPKXtF3614Pi7MW5Oghv/eSGHGUkovqNVGFIz1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YweMvEdFZbf4/PSTiHurLNVKLP19vAxW2+z5j8CAfZGQJZreIV7
	+Ixi1R1jlGbeN3MUPV2qQAmKLrqUvZnExNtE7P8QQxANMIPd+eBx
X-Google-Smtp-Source: AGHT+IHS+bJFZFbjMl2kDriagOkFv/ORdVTiPbT2GR91UJ5zX0oFfywoMtaVt+pC5uoFm0N4IBuJfg==
X-Received: by 2002:a17:90b:3b50:b0:2d8:7a3b:730d with SMTP id 98e67ed59e1d1-2dd80c4da68mr5363941a91.21.1726895141372;
        Fri, 20 Sep 2024 22:05:41 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ee984f0sm5124550a91.19.2024.09.20.22.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 22:05:40 -0700 (PDT)
Date: Sat, 21 Sep 2024 05:05:37 +0000 (UTC)
Message-Id: <20240921.050537.1209337185316346637.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, lkp@intel.com
Subject: Re: [PATCH net] net: phy: qt2025: Fix warning: unused import
 DeviceId
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47sKXVrMdC-vraJG3gt-b6yDWvFTOvfrL6+G=j6-1Y-BYQ@mail.gmail.com>
References: <20240919043707.206400-1-fujita.tomonori@gmail.com>
	<CALNs47sKXVrMdC-vraJG3gt-b6yDWvFTOvfrL6+G=j6-1Y-BYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gRnJpLCAyMCBTZXAgMjAyNCAxNzo0MjoxMCArMDIwMA0KVHJldm9yIEdyb3NzIDx0bWdyb3Nz
QHVtaWNoLmVkdT4gd3JvdGU6DQoNCj4gT24gVGh1LCBTZXAgMTksIDIwMjQgYXQgNjozOeKAr0FN
IEZVSklUQSBUb21vbm9yaQ0KPiA8ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNvbT4gd3JvdGU6DQo+
Pg0KPj4gRml4IHRoZSBmb2xsb3dpbmcgd2FybmluZyB3aGVuIHRoZSBkcml2ZXIgaXMgY29tcGls
ZWQgYXMgYnVpbHQtaW46DQo+Pg0KPj4gPj4gd2FybmluZzogdW51c2VkIGltcG9ydDogYERldmlj
ZUlkYA0KPj4gICAgLS0+IGRyaXZlcnMvbmV0L3BoeS9xdDIwMjUucnM6MTg6NQ0KPj4gICAgfA0K
Pj4gICAgMTggfCAgICAgRGV2aWNlSWQsIERyaXZlciwNCj4+ICAgIHwgICAgIF5eXl5eXl5eDQo+
PiAgICB8DQo+PiAgICA9IG5vdGU6IGAjW3dhcm4odW51c2VkX2ltcG9ydHMpXWAgb24gYnkgZGVm
YXVsdA0KPiANCj4gVGhlID4+IHNob3dzIHVwIGFzIGEgcXVvdGUgb24gbG9yZS4gU2hvdWxkIHRo
aXMgZW50aXJlIGJsb2NrIGJlIGluZGVudGVkPw0KDQpBaCwgSSBqdXN0IGNvcHkgYW5kIHBhc3Rl
IHRoZSBvcmlnaW5hbCBtYWlsIHdpdGhvdXQgdGhpbmtpbmcuIEknbGwNCmRyb3AgIj4+Ii4NCg0K
Pj4gZGV2aWNlX3RhYmxlIGluIG1vZHVsZV9waHlfZHJpdmVyIG1hY3JvIGlzIGRlZmluZWQgb25s
eSB3aGVuIHRoZQ0KPj4gZHJpdmVyIGlzIGJ1aWx0IGFzIG1vZHVsZS4gVXNlIGFuIGFic29sdXRl
IG1vZHVsZSBwYXRoIGluIHRoZSBtYWNybw0KPiANCj4gbml0OiAiYXMgbW9kdWxlIiAtPiAiYXMg
YSBtb2R1bGUiDQoNCk9vcHMsIEknbGwgdXBkYXRlIHRoZSBjb21taXQgbG9nIGFuZCBzZW5kIHYy
Lg0KDQo+PiBpbnN0ZWFkIG9mIGltcG9ydGluZyBgRGV2aWNlSWRgLg0KPj4NCj4+IFJlcG9ydGVk
LWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+IENsb3NlczogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI0MDkxOTA3MTcuaTEzNXJmVm8tbGtw
QGludGVsLmNvbS8NCj4+IFNpZ25lZC1vZmYtYnk6IEZVSklUQSBUb21vbm9yaSA8ZnVqaXRhLnRv
bW9ub3JpQGdtYWlsLmNvbT4NCj4+IC0tLQ0KPiANCj4gRWFzeSBlbm91Z2ggZml4LCB0aGFua3Mg
Zm9yIGJlaW5nIG9uIHRvcCBvZiBpdC4NCj4gDQo+IFJldmlld2VkLWJ5OiBUcmV2b3IgR3Jvc3Mg
PHRtZ3Jvc3NAdW1pY2guZWR1Pg0KDQpUaGFua3MhDQo=

