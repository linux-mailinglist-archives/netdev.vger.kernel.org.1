Return-Path: <netdev+bounces-38726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C507BC463
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 05:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E29281FF3
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 03:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32017EA;
	Sat,  7 Oct 2023 03:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqq2Wq5z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAB17E8;
	Sat,  7 Oct 2023 03:26:14 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58772BD;
	Fri,  6 Oct 2023 20:26:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-693400e09afso669996b3a.1;
        Fri, 06 Oct 2023 20:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696649172; x=1697253972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mm7dva/66/XW0Rduewc2wXqRmP5u+1KTM/GhmC+YkQU=;
        b=Hqq2Wq5z7V+/DIyD/UwP6diX/6FQ+vW+C+ndK516FY2u9kRe+fRqkujoLzujtUSnTG
         d+HpQ+m+9nAK3emU6YruUuu6EO6vVgaqC+hbuKxCQ9MuWGN5VawsdaZNRKxrAYVgrHQm
         iaonMBl68hixAWwS9lpNv/PXVnM7W/m/VlLwADJ33opl2FFEZOnHcgPMbmxjmucYzzWp
         N/fYLyUgwArLxOJfi72aZe/Wr7iVkGFRh8rAN6PEkB37QeJN0/+gg1bB5K7hS35tzFZC
         /iSwRHsccvVlwpSk1452+dYp8vE65xaXMPor935J7QMLrgNVs4w8fONYcT5h/A4kGnEe
         eUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696649172; x=1697253972;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mm7dva/66/XW0Rduewc2wXqRmP5u+1KTM/GhmC+YkQU=;
        b=CxkQH6AJopAYg6Jl2LASEzlsiZXW0WPxwBOBtl759OeA2FqBEHqMlS746X5xTbnZRv
         PVrE4oO0ITjOkthhoJBmBOVNq9AMb9PwT9jJraTGtpVqNH0Dhrtcpc8U+U8FkyHPDA2O
         CZXOWLh/5ojek6NGMH7SZVwI8w5JE24fVBRkH7pnF/mTzPIKCqLW/bBVsYZ/xo1cuPmt
         y6ktLotvskm4zDiuc+ENs0/U0uVhrvVnQTDXjnUgBG3dV1QQ7GfDSYiyDVjCObe71dIC
         zUDPylPWmPSK7hdknFvGIJM9Vu5sBwnvcFa3pTISbiT+bmFvdjV8ZxbuEe/a1OR2GQ7g
         gM5g==
X-Gm-Message-State: AOJu0Yz0JZj62nFjU/h3FEsxbRzvyqM8k/OUq6PW4Z/yFZQBDj6Ixk9/
	hDkI19Rxgg3yN4suKL/wmjY=
X-Google-Smtp-Source: AGHT+IHj0aXMLVpb0kr8hV+yio6vBkDD+Ec2RnQik2azQv48NAlT1wqMn9GLGxhP0z2Kb8ZclBOfFw==
X-Received: by 2002:a17:902:e80a:b0:1c4:1e65:1e5e with SMTP id u10-20020a170902e80a00b001c41e651e5emr10737491plg.0.1696649171698;
        Fri, 06 Oct 2023 20:26:11 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b001bbb25dd3a7sm4695940plg.187.2023.10.06.20.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 20:26:11 -0700 (PDT)
Date: Sat, 07 Oct 2023 12:26:10 +0900 (JST)
Message-Id: <20231007.122610.6850673637000283.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com,
 miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH v2 0/3] Rust abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47ukgFCs631v7wiaMTH0wtW6y4AcHcZ7uOaAS505vOEnzQ@mail.gmail.com>
References: <20231006.230936.1469709863025123979.fujita.tomonori@gmail.com>
	<40859cee-2ee7-4065-82d0-3841e5d7838f@lunn.ch>
	<CALNs47ukgFCs631v7wiaMTH0wtW6y4AcHcZ7uOaAS505vOEnzQ@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCA2IE9jdCAyMDIzIDE5OjM3OjE1IC0wNDAwDQpUcmV2b3IgR3Jvc3MgPHRtZ3Jvc3NA
dW1pY2guZWR1PiB3cm90ZToNCg0KPiBPbiBGcmksIE9jdCA2LCAyMDIzIGF0IDEwOjQ34oCvQU0g
QW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPiB3cm90ZToNCj4+ID4gU28gSSB0aGluayB0aGF0
IG1lcmdpbmcgdGhlIHBhdGNoc2V0IHRocm91Z2ggYSBzaW5nbGUgdHJlZSBpcyBlYXNpZXI7DQo+
PiA+IG5ldGRldiBvciBydXN0Lg0KPj4gPg0KPj4gPiBNaWd1ZWwsIGhvdyBkbyB5b3UgcHJlZmVy
IHRvIG1lcmdlIHRoZSBwYXRjaHNldD8NCj4+DQo+PiBXaGF0IGFyZSB0aGUgbWVyZ2UgY29uZmxp
Y3RzIGxvb2tpbmcgbGlrZT8gV2hhdCBoYXMgaGFwcGVuZWQgaW4gdGhlDQo+PiBwYXN0PyBbLi4u
XQ0KPiANCj4gTWlndWVsIGhhcyBzYWlkIGJlZm9yZSB0aGF0IGlmIHN1YnN5c3RlbXMgYXJlIGNv
bWZvcnRhYmxlIGJyaW5naW5nDQo+IHJ1c3QgdGhyb3VnaCB0aGVpciB0cmVlcyB0aGVuIHRoZXkg
YXJlIHdlbGNvbWUgdG8gZG8gc28sIHdoaWNoIGhlbHBzDQo+IGdldCBhIGJldHRlciBpZGVhIG9m
IGhvdyBldmVyeXRoaW5nIHdvcmtzIHRvZ2V0aGVyLiBJZiB5b3UgcHJlZmVyIG5vdA0KPiB0bywg
aXQgY2FuIGNvbWUgdGhyb3VnaCBydXN0LW5leHQgd2l0aCBubyBwcm9ibGVtLg0KDQpJdCBtYWtl
cyBzZW5zZSBiZWNhdXNlIHRoZXNlIGJpbmRpbmdzIGFyZSBtYWludGFpbmVkIGJ5IHN1YnN5c3Rl
bXMuDQoNCkknbGwgc2VuZCBwYXRjaGVzIHdpdGggJ25ldC1uZXh0JyB0YWcgaW4gdGhlIG5leHQg
cm91bmQuDQo=

