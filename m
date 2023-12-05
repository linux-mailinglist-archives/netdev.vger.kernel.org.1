Return-Path: <netdev+bounces-53755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57019804813
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 04:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECE4B20D55
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664018C07;
	Tue,  5 Dec 2023 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhyfWfxF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC9BC6;
	Mon,  4 Dec 2023 19:45:32 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce40061e99so320484b3a.0;
        Mon, 04 Dec 2023 19:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701747932; x=1702352732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55zYcX2qsOiqJHVhozAurcXs6LQBWTTMFJJb7hHw3k8=;
        b=bhyfWfxFo5pK5DZ6Muac2Ik8ZOyWqn1dbknGi6tMV3UxiXj0bSZG0xide/xAhF/w+K
         kUECEcqOZZN75Eg2xadLkJbL95YdUotCctK7M8QC2tQnrr1z3o93BdKqlXYsLjV2/w2v
         11hdfRqrrvxvIUpxeVFhazFgLO/yQwQonazz+K3aKQ26R+VfkF3y+JZvY37S9ZgosMDt
         4yIjUd7KEYpNaA9IV9Ln4YE04FYv77L3KynHxjZerfzcF9YfaoMQSLmna5Q49DWp37bl
         aPe8G8WRM+qEHbaXVBlVAQZyPipzLsYRiTu3h7HHUz9/Qv/Yc+wmA0Ca/L5d00KAUTOg
         u2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701747932; x=1702352732;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=55zYcX2qsOiqJHVhozAurcXs6LQBWTTMFJJb7hHw3k8=;
        b=QjIibjFqM1AbXUuWfg5fooO8Yxy7Soz3ltLtwYhMTRcdOdq/9EHTnneoOQgq+gOz2C
         wAXpneeYOMbUTKjgiwifFnKclvRItUECb4jd0PfXrHU6N1FP15AeGTyv9Jso0UPdwgFZ
         vGlaTstSOnbm8NlPHVrgcugHT4tV5bJfIaWys4em0OPo4AE5Bl3PuAyGsHDPBEfQ6flY
         CRXPvWaHUBhdxvXEzPcNNK1s+yn5BGw9yCJdf4AqZuabdv1NKfx0gUiEOUY+dsd1ROOo
         ldr4w1Ux4y5m/GpsxnDb8ziCq8YsaIBlZD7ePXvb4imIo5nR9eCk8XL53ZdUeBpC8w01
         oQWA==
X-Gm-Message-State: AOJu0YxtIEumckoVk67KuQqNuj46RKLSidTcR0CS4JAbh91K3vjSX+A4
	1MUzRdk759O8uw7Nw1O6RDM=
X-Google-Smtp-Source: AGHT+IGAvGeYthNwfBpN0G33VtpB/P7IFgnuZ3IApShkErSjvA7jGKkfVAw/UzhEWFtPwPFnpmzavQ==
X-Received: by 2002:a05:6a21:a598:b0:18b:d26a:375c with SMTP id gd24-20020a056a21a59800b0018bd26a375cmr47090335pzc.1.1701747932128;
        Mon, 04 Dec 2023 19:45:32 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b001ce6649d088sm9130500plh.195.2023.12.04.19.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 19:45:31 -0800 (PST)
Date: Tue, 05 Dec 2023 12:45:31 +0900 (JST)
Message-Id: <20231205.124531.842372711631366729.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v9 3/4] MAINTAINERS: add Rust PHY abstractions
 for ETHERNET PHY LIBRARY
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47v4zq3-W137iEzEwdd63iZNA_iWULKHWJrEA42mzRC8+w@mail.gmail.com>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
	<20231205011420.1246000-4-fujita.tomonori@gmail.com>
	<CALNs47v4zq3-W137iEzEwdd63iZNA_iWULKHWJrEA42mzRC8+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gTW9uLCA0IERlYyAyMDIzIDIwOjUzOjIzIC0wNTAwDQpUcmV2b3IgR3Jvc3MgPHRtZ3Jvc3NA
dW1pY2guZWR1PiB3cm90ZToNCg0KPiBPbiBNb24sIERlYyA0LCAyMDIzIGF0IDg6MTbigK9QTSBG
VUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0KPj4N
Cj4+IEFkZHMgbWUgYXMgYSBtYWludGFpbmVyIGFuZCBUcmV2b3IgYXMgYSByZXZpZXdlci4NCj4+
DQo+PiBUaGUgZmlsZXMgYXJlIHBsYWNlZCBhdCBydXN0L2tlcm5lbC8gZGlyZWN0b3J5IGZvciBu
b3cgYnV0IHRoZSBmaWxlcw0KPj4gYXJlIGxpa2VseSB0byBiZSBtb3ZlZCB0byBuZXQvIGRpcmVj
dG9yeSBvbmNlIGEgbmV3IFJ1c3QgYnVpbGQgc3lzdGVtDQo+PiBpcyBpbXBsZW1lbnRlZC4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBGVUpJVEEgVG9tb25vcmkgPGZ1aml0YS50b21vbm9yaUBnbWFp
bC5jb20+DQo+PiBSZXZpZXdlZC1ieTogQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KPj4g
LS0tDQo+IA0KPiBZb3UgbWF5IGFkZDoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRyZXZvciBHcm9z
cyA8dG1ncm9zc0B1bWljaC5lZHU+DQoNClRoYW5rcywgSSB3aWxsLg0K

