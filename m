Return-Path: <netdev+bounces-39211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122397BE55F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118561C2093B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4865374DE;
	Mon,  9 Oct 2023 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQGaN16G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37834374D7;
	Mon,  9 Oct 2023 15:50:11 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0554A6;
	Mon,  9 Oct 2023 08:50:09 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57de3096e25so1087841eaf.1;
        Mon, 09 Oct 2023 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696866609; x=1697471409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COApHFeIGdnnYzT4V3aJXAqhzZeFgW33VcQEneabOhk=;
        b=bQGaN16GE1HqBGq5Fhzt9x+SkFDgTE9DVfjs06HBX7nBnPVZeJs9yPgXl4KbWhq6YR
         qSXLmN8JkinJnLM9EqGFrAj3qCg/jcVtQiv4wOwC6VvqcOPnRYJ0bcRL+Gx9bqrKqTLv
         7NErwhdILQ9qtA7Nd9kL5ETQqww//Az8yS3t2VJFYXk9suP3GQbHgXd3IeAt2G1oD6Bj
         c/otoLefahoFtKCVCsutuPzwwJzr5VC/BueRg6IlAEO/HqlcN5ylr54ETlERx1/fDEsV
         odue+AJBNqVlAGExzdptSGOwd3kr1hhbjW0yQNg8DFnCOrCg9Ro8Y/GlU5T/tQAXcByK
         B0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696866609; x=1697471409;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=COApHFeIGdnnYzT4V3aJXAqhzZeFgW33VcQEneabOhk=;
        b=G+PiDdjz6czbkSjGUbzIZkWKGhxKnjurSWi44LmsCSF9viLZ9rTBGN8fzkU82pmI/W
         20S2Ro9PhdjpQhqTgf0wRwTHgeKiy9J7x2pVMh6vyR+xrd6brK1PUpPw5i9Ku+z5PVmw
         B53X/F1CoCC9U+YMSG5Pk2xDI2cE138tXnktkkw7ytHsCfCKx40DbjUKybP5feaewI2G
         mIV4PruJII2GG3JjxQrho14C5jmbHS/sIm+gsmqSq68duQV86feQdirS+wmwBWJkzX96
         Z/5hDMCr6Bwf7kUY3gyiPlc2VrXqHc8dKlgGW8Yoti8U9YQrvewWCyup6MKdomoOTdqg
         VVWg==
X-Gm-Message-State: AOJu0YzbrbJC6fYvRsHbbiRbNNlbwe3HjDYspcB4OGBxvHstDv9kH50W
	4mwZUg/gvPwyeRKyje9lTr0LJggvV3uGdBzj
X-Google-Smtp-Source: AGHT+IH4XtUQXTDjkJgQxiu+5ZI6MWupMaN0S+KVTfATYkBZJU2pkZX+UWBHWwR7Adg15Y20znyvhA==
X-Received: by 2002:a05:6358:c10a:b0:14a:cca4:55d7 with SMTP id fh10-20020a056358c10a00b0014acca455d7mr12316786rwb.3.1696866609072;
        Mon, 09 Oct 2023 08:50:09 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id e28-20020a63371c000000b0057401997c22sm8416591pga.11.2023.10.09.08.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:50:08 -0700 (PDT)
Date: Tue, 10 Oct 2023 00:50:08 +0900 (JST)
Message-Id: <20231010.005008.2269883065591704918.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72nj_04U82Kb4DfMx72NPgHzDCd-xbosc83xgF19nCqSfQ@mail.gmail.com>
References: <2023100926-ambulance-mammal-8354@gregkh>
	<20231010.002413.435110311325344494.fujita.tomonori@gmail.com>
	<CANiq72nj_04U82Kb4DfMx72NPgHzDCd-xbosc83xgF19nCqSfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gTW9uLCA5IE9jdCAyMDIzIDE3OjM5OjI3ICswMjAwDQpNaWd1ZWwgT2plZGEgPG1pZ3VlbC5v
amVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIE1vbiwgT2N0IDksIDIwMjMg
YXQgNToyNOKAr1BNIEZVSklUQSBUb21vbm9yaQ0KPiA8ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gVHJldm9yIGdhdmUgUmV2aWV3ZWQtYnkuIE5vdCBwZXJmZWN0IGJ1
dCByZWFzb25hYmxlIHNoYXBlLCBJTUhPLiBTZWVtcw0KPj4gdGhhdCB3ZSBoYXZlIGJlZW4gZGlz
Y3Vzc2luZyB0aGUgc2FtZSB0b3BpY3MgbGlrZSBsb2NraW5nLCBuYW1pbmcsIGV0Yw0KPj4gYWdh
aW4gYW5kIGFnYWluLg0KPiANCj4gV2VsbCwgdGhlcmUgd2FzIG90aGVyIGZlZWRiYWNrIHRvbywg
d2hpY2ggaXNuJ3QgYWRkcmVzc2VkIHNvIGZhci4gU28NCj4gbWVyZ2luZyB0aGlzIGluIDIgd2Vl
a3MgZG9lcyBzZWVtIGEgYml0IHJ1c2hlZCB0byBtZS4NCg0KV2hhdCBmZWVkYmFjaz8gZW51bSBz
dHVmZj8gSSB0aGluayB0aGF0IGl0J3MgYSBsb25nLXRlcm0gaXNzdWUuIA0KDQo+IEFuZCwgeWVz
LCB0aGUgZGlzY3Vzc2lvbiBvbiB0aGlzIGhhcyBiZWVuIGdvaW5nIGFyb3VuZCBmb3IgYSB3aGls
ZSwNCj4gYnV0IHRoYXQgaXMgcHJlY2lzZWx5IHdoeSB3ZSByZWNvbW1lbmRlZCB0byBpdGVyYXRl
IG1vcmUgb24gb3VyIHNpZGUNCj4gZmlyc3QsIGJlY2F1c2UgaXQgd2FzIG5vdCByZWFkeS4NCg0K
SSdtIG5vdCBzdXJlIGFib3V0IGl0LiBGb3IgZXhhbXBsZSwgd2UgcmV2aWV3ZWQgdGhlIGxvY2tp
bmcgaXNzdWUNCnRocmVlIHRpbWVzLiBJdCBjYW4ndCBiZSByZXZpZXdlZCBvbmx5IG9uIFJ1c3Qg
c2lkZS4gSXQncyBtYWlubHkgYWJvdXQNCmhvdyB0aGUgQyBzaWRlIHdvcmtzLg0K

