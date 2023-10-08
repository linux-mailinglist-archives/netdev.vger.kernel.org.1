Return-Path: <netdev+bounces-38897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA047BCEEA
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 16:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27ECC2816F1
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 14:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D59F9F6;
	Sun,  8 Oct 2023 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuzoPTQF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F9BE52;
	Sun,  8 Oct 2023 14:28:31 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FBEA4;
	Sun,  8 Oct 2023 07:28:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690f2719ab2so865810b3a.0;
        Sun, 08 Oct 2023 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696775309; x=1697380109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A60CDLkto81UokTEGhrd+UkZVi3egtzYgTyPq75qsKs=;
        b=OuzoPTQFS2Dt8x8TJ2dhQqM/lBpumRSkruJIAiN+zgh/qz1STX7jHvhfGYT6twpRzB
         pGRvh2G502I/EzNPWNRVVN7DXBq4KhlpFXgiNzttI6PLPECxw9C0tRCZ2vGtDqDw0RIB
         j37BCy6WqEZyVLJHTyXxymOqwuS0wa24M1IzZ1p48WJ1LzR8Uh5G8HTWltA/Q1y8Tvq0
         3/SSftqvQvVt2OaRg2R/AdPJbJT+UnsFKas5LghWmxgsMKFFuAmRTUlwvzK5ybNCOCJE
         pBiVeP/FJ8YtLl2aKscy8dh8mMMKvi0aCgy8h3xgRydWel0iJYL8J5fyV21Mot0EjEXw
         dfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696775309; x=1697380109;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A60CDLkto81UokTEGhrd+UkZVi3egtzYgTyPq75qsKs=;
        b=OTlaG6T5+2QsUWE2jcdgN5cNn6S3nOTyphB/FLSUuYVDqRnepp1pYnIl/ntwwwBgLl
         G8GxBOTZBnJEDjaBlFeJm/O8am03rdrZ8qH3RhhXsWB0cbvRpwNvvNgDuDd1P77zD/JP
         3v7HEdXS9a2Qv/r+jx4VcC+UBQ9o7/fbIq92/DLTpfnLSggvd58dx77bSQmfZ3u8GXka
         3jPpJ30vClyYIarDVSAo6XyZTTcmXWznobbhCTsrw+gsV1eBI3Xy8VIWiiDYSNH09SlS
         svEyXZSh8H+/luXpqDRju6+ZYTh88KW0sS16EeYpqHf/+NyO6WXiA7NNBrGEu8WriVPa
         yOXg==
X-Gm-Message-State: AOJu0YyJT/d8xZOyc0sIe81HzIXr8KzPjNtA3aN3siEUnaR0E5hKi/qf
	uvNcf90XMj7rm9fC5X7iPbM=
X-Google-Smtp-Source: AGHT+IH7BmaoUhyUPLDdPGJ2OhEwTC6EoRHpZJRSTDsNgQdKeNEbaSFW/28X8dV2AJVJ/EpmDQiLsg==
X-Received: by 2002:a05:6a20:9393:b0:16c:b95c:6d38 with SMTP id x19-20020a056a20939300b0016cb95c6d38mr5819334pzh.2.1696775309177;
        Sun, 08 Oct 2023 07:28:29 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d24-20020a17090ac25800b00274a9f8e82asm8422205pjx.51.2023.10.08.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 07:28:28 -0700 (PDT)
Date: Sun, 08 Oct 2023 23:28:27 +0900 (JST)
Message-Id: <20231008.232827.1538387095628135783.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: andrew@lunn.ch, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
 greg@kroah.com
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47ujBcwHG+sgeH3m7gvkW6JKWtD0ZS66ujmswLODuExJhg@mail.gmail.com>
References: <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
	<7edb5c43-f17b-4352-8c93-ae5bb9a54412@lunn.ch>
	<CALNs47ujBcwHG+sgeH3m7gvkW6JKWtD0ZS66ujmswLODuExJhg@mail.gmail.com>
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

T24gU3VuLCA4IE9jdCAyMDIzIDAyOjA3OjQ0IC0wNDAwDQpUcmV2b3IgR3Jvc3MgPHRtZ3Jvc3NA
dW1pY2guZWR1PiB3cm90ZToNCg0KPiBPbiBTYXQsIE9jdCA3LCAyMDIzIGF0IDExOjEz4oCvQU0g
QW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPiB3cm90ZToNCj4+DQo+PiA+IFRoZSBzYWZldHkg
Y29tbWVudCBoZXJlIHN0aWxsIG5lZWRzIHNvbWV0aGluZyBsaWtlDQo+PiA+DQo+PiA+ICAgICB3
aXRoIHRoZSBleGNlcHRpb24gb2YgZmllbGRzIHRoYXQgYXJlIHN5bmNocm9uaXplZCB2aWEgdGhl
IGBsb2NrYCBtdXRleA0KPj4NCj4+IEknbSBub3Qgc3VyZSB0aGF0IHJlYWxseSBhZGRzIG11Y2gg
dXNlZnVsIGluZm9ybWF0aW9uLiBXaGljaCB2YWx1ZXMNCj4+IGFyZSBwcm90ZWN0ZWQgYnkgdGhl
IGxvY2s/IE1vcmUgaW1wb3J0YW50bHksIHdoaWNoIGFyZSBub3QgcHJvdGVjdGVkDQo+PiBieSB0
aGUgbG9jaz8NCj4+DQo+PiBBcyBhIGdlbmVyYWwgcnVsZSBvZiB0aHVtYiwgZHJpdmVyIHdyaXRl
cnMgZG9uJ3QgdW5kZXJzdGFuZA0KPj4gbG9ja2luZy4gWWVzLCB0aGVyZSBhcmUgc29tZSB3aGlj
aCBkbywgYnV0IG1hbnkgZG9uJ3QuIFNvIHRoZQ0KPj4gd29ya2Fyb3VuZCB0byB0aGF0IGlzIG1h
a2UgaXQgc28gdGhleSBkb24ndCBuZWVkIHRvIHVuZGVyc3RhbmQNCj4+IGxvY2tpbmcuIEFsbCB0
aGUgbG9ja2luZyBoYXBwZW5zIGluIHRoZSBjb3JlLg0KPj4NCj4+IFRoZSBleGNlcHRpb24gaXMg
c3VzcGVuZCBhbmQgcmVzdW1lLCB3aGljaCBhcmUgY2FsbGVkIHdpdGhvdXQgdGhlDQo+PiBsb2Nr
LiBTbyBpZiBpIHdhcyB0byBhZGQgYSBjb21tZW50IGFib3V0IGxvY2tpbmcsIGkgd291bGQgb25s
eSBwdXQgYQ0KPj4gY29tbWVudCBvbiB0aG9zZSB0d28uDQo+IA0KPiBUaGlzIGRvZXNuJ3QgZ2V0
IHVzZWQgYnkgZHJpdmVyIGltcGxlbWVudGF0aW9ucywgaXQncyBvbmx5IHVzZWQgd2l0aGluDQo+
IHRoZSBhYnN0cmFjdGlvbnMgaGVyZS4gSSB0aGluayBhbnlvbmUgd2hvIG5lZWRzIHRoZSBkZXRh
aWxzIGNhbiByZWZlcg0KPiB0byB0aGUgQyBzaWRlLCBJIGp1c3Qgc3VnZ2VzdGVkIHRvIG5vdGUg
dGhlIGxvY2tpbmcgY2F2ZWF0IGJhc2VkIG9uDQo+IHlvdXIgc2Vjb25kIGNvbW1lbnQgYXQNCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcnVzdC1mb3ItbGludXgvZWM2ZDg0NzktZjg5My00YTNm
LWJmM2UtYWEwYzgxYzRhZGFkQGx1bm4uY2gvDQo+IA0KPiBGdWppdGEgLSBzaW5jZSB0aGlzIGRv
ZXNuJ3QgZ2V0IGV4cG9zZWQsIGNvdWxkIHRoaXMgYmUgcHViKGNyYXRlKT8pDQoNCkRldmljZT8g
SSBkb24ndCB0aGluayBzby4gSWYgd2UgbWFrZSBEZXZpY2UgcHViKGNyYXRlKSwgd2UgbmVlZCB0
bw0KbWFrZSB0cmFpdCBEcml2ZXIgcHViKGNyYXRlKSB0b28uDQoNCg0KPj4gPiA+ICsgICAgdW5z
YWZlIGV4dGVybiAiQyIgZm4gcmVhZF9tbWRfY2FsbGJhY2soDQo+PiA+ID4gKyAgICAgICAgcGh5
ZGV2OiAqbXV0IGJpbmRpbmdzOjpwaHlfZGV2aWNlLA0KPj4gPiA+ICsgICAgICAgIGRldm51bTog
aTMyLA0KPj4gPiA+ICsgICAgICAgIHJlZ251bTogdTE2LA0KPj4gPiA+ICsgICAgKSAtPiBpMzIg
ew0KPj4gPiA+ICsgICAgICAgIGZyb21fcmVzdWx0KHx8IHsNCj4+ID4gPiArICAgICAgICAgICAg
Ly8gU0FGRVRZOiBUaGUgQyBBUEkgZ3VhcmFudGVlcyB0aGF0IGBwaHlkZXZgIGlzIHZhbGlkIHdo
aWxlIHRoaXMgZnVuY3Rpb24gaXMgcnVubmluZy4NCj4+ID4gPiArICAgICAgICAgICAgbGV0IGRl
diA9IHVuc2FmZSB7IERldmljZTo6ZnJvbV9yYXcocGh5ZGV2KSB9Ow0KPj4gPiA+ICsgICAgICAg
ICAgICBsZXQgcmV0ID0gVDo6cmVhZF9tbWQoZGV2LCBkZXZudW0gYXMgdTgsIHJlZ251bSk/Ow0K
Pj4gPiA+ICsgICAgICAgICAgICBPayhyZXQuaW50bygpKQ0KPj4gPiA+ICsgICAgICAgIH0pDQo+
PiA+ID4gKyAgICB9DQo+PiA+DQo+PiA+IFNpbmNlIHlvdXIncmUgcmVhZGluZyBhIGJ1cywgaXQg
cHJvYmFibHkgZG9lc24ndCBodXJ0IHRvIGRvIGEgcXVpY2sNCj4+ID4gY2hlY2sgd2hlbiBjb252
ZXJ0aW5nDQo+PiA+DQo+PiA+ICAgICBsZXQgZGV2bnVtX3U4ID0gdTg6OnRyeV9mcm9tKGRldm51
bSkuKHxffCB7DQo+PiA+ICAgICAgICAgd2Fybl9vbmNlISgiZGV2bnVtIHtkZXZudW19IGV4Y2Vl
ZHMgdTggbGltaXRzIik7DQo+PiA+ICAgICAgICAgY29kZTo6RUlOVkFMDQo+PiA+ICAgICB9KT8N
Cj4+DQo+PiBJIHdvdWxkIGFjdHVhbGx5IHNheSB0aGlzIGlzIHRoZSB3cm9uZyBwbGFjZSB0byBk
byB0aGF0LiBTdWNoIGNoZWNrcw0KPj4gc2hvdWxkIGhhcHBlbiBpbiB0aGUgY29yZSwgc28gaXQg
Y2hlY2tzIGFsbCBkcml2ZXJzLCBub3QganVzdCB0aGUNCj4+IGN1cnJlbnQgb25lIFJ1c3QgZHJp
dmVyLiBGZWVsIGZyZWUgdG8gc3VibWl0IGEgQyBwYXRjaCBhZGRpbmcgdGhpcy4NCj4+DQo+PiAg
ICAgICAgIEFuZHJldw0KPiANCj4gSSBndWVzcyBpdCBkb2VzIHRoYXQgYWxyZWFkeToNCj4gaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNi1yYzQvc291cmNlL2RyaXZlcnMvbmV0
L3BoeS9waHktY29yZS5jI0w1NTYNCj4gDQo+IEZ1aml0YSwgSSB0aGluayB3ZSBzdGFydGVkIGRv
aW5nIGNvbW1lbnRzIHdoZW4gd2Uga25vdyB0aGF0DQo+IGxvc3N5L2JpdHdpc2UgYGFzYCBjYXN0
cyBhcmUgY29ycmVjdC4gTWF5YmUganVzdCBsZWF2ZSB0aGUgY29kZSBhcy1pcw0KPiBidXQgYWRk
DQo+IA0KPiAgICAgLy8gQ0FTVDogdGhlIEMgc2lkZSB2ZXJpZmllcyBkZXZudW0gPCAzMg0KDQpP
ay4gQXMgSSBjb21tZW50ZWQgb24gdGhlIFJGQyByZXZpZXdpbmcsIEkgZG9uJ3QgdGhpbmsgdGhh
dCB3ZQ0KbmVlZCB0cnlfZnJvbSBjb252ZXJzaW9uIGZvciB2YWx1ZXMgZnJvbSBQSFlMSUIuIElt
cGxlbWVudGluZyBiaW5kaW5ncw0KZm9yIHVudHJ1c3RlZCBzdHVmZiBkb2Vzbid0IG1ha2Ugc2Vu
c2UuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDkyNi4xMDE5MjguNzY3MTc2
NTcwNzA3MzU3MTE2LmZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20vDQoNCk9uIHRoZSBvdGhlciBo
YW5kLCBJIHRoaW5rIHRoYXQgaXQgbWlnaHQgd29ydGggdG8gdXNlIHRyeV9mcm9tIGZvcg0Kc2V0
X3NwZWVkKCkgYmVjYXVzZSBpdHMgYWJvdXQgdGhlIGJpbmRpbmdzIGFuZCBSdXN0IFBIWSBkcml2
ZXJzLg0KSG93ZXZlciwgSSBsZWF2ZSBpdCBhbG9uZSBzaW5jZSBsaWtlbHkgc2V0dGluZyBhIHdy
b25nIHZhbHVlIGRvZXNuJ3QNCmJyZWFrIGFueXRoaW5nLg0K

