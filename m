Return-Path: <netdev+bounces-128611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD7797A8DA
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 23:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3208286355
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E0145FEB;
	Mon, 16 Sep 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYGJR9ZY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721D3B295
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522597; cv=none; b=H8xw7x3nugHyFUd9hU2ZdtORU9oICsdAtoSmdtnD9i6lHtJScL1EUQFZKSmAMm6h2q7HlpwBSmcXbRctr2Rl9JJeA6AXjm0uqXw/u+E/twU60/UDAkMj4RZGfLDC12Q1QdE8pxcPOeqsvl5+KRcJGNYcOe9BBcBoAA6amVYPpcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522597; c=relaxed/simple;
	bh=vEDp0m+VqU4fwjhXRytXE9/0wboKJ6MhCEftKzH2tIA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CwxukOTtEnWGkB1SwXVifU688T482PVoKRwHI+U+e27B2uracMwq6puI8GPIpRmrQL5z6pmhu0mqXWaIf8YAJGU++j14DOPz+PfnIXrBzlV0fQH/KRbNuz80yxXlQ1g+B3AScNpMqiPQvzpG71O17ylkGO375FrwglZXmYaNlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYGJR9ZY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c27067b81aso4309731a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 14:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726522594; x=1727127394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEDp0m+VqU4fwjhXRytXE9/0wboKJ6MhCEftKzH2tIA=;
        b=OYGJR9ZY1TvKz9WmD1fs8C8lGKNiZFllGsaKuJgZnqVbA2J0c4zxxoH0VsSv/ExhEN
         gsuz4AJvhfdZ8LsXJB9++u1V6W++uCio8eFfAsBY41PT12jyhnMGTYMv7lPEnurN2/Bt
         8VeK4btFRKsqvLXqJ4mXzGvHNUxc5ZyssaBOZ4IY5kIyO3ZKYipD7ssAtb/0jRzydgDx
         J3k228kPmqVkTr1fp2mEmA2EISpTCfPlgV6R2YbFVOZH9c1ukMmVqhMJzoq2m9n6WFrl
         okyUI3bO5zC95G9oZ3RjX+CG8M9T8VNTZBenyN8lRMo3p9VS94/rI1Ol5RxdU4bCq+PF
         nx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726522594; x=1727127394;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEDp0m+VqU4fwjhXRytXE9/0wboKJ6MhCEftKzH2tIA=;
        b=QHTDgQlxtoTUxRD74j0CiQB/BpJm0DUwgQiiIL7sVRGrDXnzM9wD4DHTGPXOZJSH28
         LIE8l6X+Ugu+1Xa4tKECJohuwtLKaYxcmt7StXdBcW8v30WM7fTd3WiW7v99gaTw1PVR
         yffZsvbIaiVAIem22T/4IjypQhm/UwMmzpFKnwFST0o41q+K74w5RKoXcArSUhDqkYoJ
         kl2EAJFJ9IpAW9Q27T6xDCYihX+1kjsHusFYyuofRCfKSR8suTic+/Hwf+va0I6Wz0Gf
         X/lu7I4xmVS9jZvBVIkvFBs55O9Ea6xY8b0qIDHdEsZYzmtKZloiRlzbAIggnZ4iVj4N
         mI0A==
X-Forwarded-Encrypted: i=1; AJvYcCVlczqKbPd2NHkmkrnV+8XVMcz008mqMydYuioiF2XXT6A4suEyqBtFdD2X/XZmVTLoaTQnDqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xFvopC/Sy+vMbuch1IB5LuqpvTDKmleYAD3wWfh2VztbNr6G
	1QArpPVSaVJiXRufOwGroKSVeomLnunA3AKXrjO5V5E3D0QQfbsv
X-Google-Smtp-Source: AGHT+IEtgnXHhIVVpr8q1KKhj8VEE+yzX8l7tgUkohXZBl4gAsWsgHeypbx8CvCoitx4YINpO6xcog==
X-Received: by 2002:a17:907:6d14:b0:a7a:a212:be4e with SMTP id a640c23a62f3a-a9047b50504mr1276138666b.7.1726522594418;
        Mon, 16 Sep 2024 14:36:34 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e560csm369490966b.170.2024.09.16.14.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 14:36:34 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <a8a7bfc4-312d-497b-83c4-64c1207d86e3@orange.com>
Date: Mon, 16 Sep 2024 23:36:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: horms@kernel.org, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYvMDkvMjAyNCAxMjoxMywgUHJ6ZW1layBLaXRzemVsIHdyb3RlOg0KPiBPbiA5LzE1
LzI0IDIyOjQ5LCBBbGV4YW5kcmUgRmVycmlldXggd3JvdGU6DQo+Pg0KPj4gMi4gV2hlbiBt
b3ZpbmcgYW4gaW50ZXJmYWNlIChlZyBhbiBJUFZMQU4gc2xhdmUpIHRvIGFub3RoZXIgbmV0
bnMsDQo+PiBfX2Rldl9jaGFuZ2VfbmV0X25hbWVzcGFjZSgpIGNhbGxzIHBlZXJuZXQyaWRf
YWxsb2MoKSBpbiBvcmRlciB0byBnZXQNCj4+IGFuIElEIGZvciB0aGUgdGFyZ2V0IG5hbWVz
cGFjZS4gVGhpcyBhZ2FpbiBpbmN1cnMgYSBmdWxsIHNjYW4gb2YgdGhlDQo+PiBuZXRucyBs
aXN0Og0KPj4NCj4+IMKgwqDCoMKgwqDCoMKgwqAgaW50IGlkID0gaWRyX2Zvcl9lYWNoKCZu
ZXQtPm5ldG5zX2lkcywgbmV0X2VxX2lkciwgcGVlcik7DQo+IA0KPiB0aGlzIHBpZWNlIGlz
IGluc2lkZSBvZiBfX3BlZXJuZXQyaWQoKSwgd2hpY2ggaXMgY2FsbGVkIGluIGZvcl9lYWNo
X25ldA0KPiBsb29wLCBtYWtpbmcgaXQgTyhuXjIpOg0KPiANCj4gIMKgNTQ44pSCwqDCoMKg
wqDCoMKgwqDCoCBmb3JfZWFjaF9uZXQodG1wKSB7DQo+ICDCoDU0OeKUgsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBpZDsNCj4gIMKgNTUw4pSCDQo+ICDCoDU1MeKU
gsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9ja19iaCgmdG1wLT5u
c2lkX2xvY2spOw0KPiAgwqA1NTLilILCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZCA9IF9fcGVlcm5ldDJpZCh0bXAsIG5ldCk7DQoNCllvdSdyZSByaWdodCwgdGhvdWdo
IHRoYXQgaGFwcGVucyBvbmx5IHdpdGhpbiB1bmhhc2hfbnNpZCgpLCB3aGljaCBpcyBjYWxs
ZWQgDQp3aGVuIGRlbGV0aW5nIGFuIG5zbmV0Lg0KDQpPYnZpb3VzbHkgdGhpcyBxdWFkcmF0
aWMgaG9ycm9yIHlvdSBmb3VuZCBpcyBldmVuIHdvcnNlIHRoYW4gdGhlIGxpbmVhciBvbmUg
SSANCnJlcG9ydGVkLCBidXQgaXQgY2FuIGFyZ3VhYmx5IGJlIHdvcmtlZCBhcm91bmQgaW4g
dGVzdGVyLWxpa2Ugd29ya2xvYWRzIChqdXN0IA0KbmV2ZXIgZGVsZXRlIHRoZSBuYW1lc3Bh
Y2VzKS4gV2hpbGUgdGhlIGxpbmVhciBvbmUgY2Fubm90LCBhcyBsb25nIGFzIHlvdSBuZWVk
IA0KdG8gbW92ZSBhbnkgaW50ZXJmYWNlIGludG8gdGhlIG5ld2x5IGNyZWF0ZWQgdGhvdXNh
bmRzIG9mIG5hbWVzcGFjZXMuDQo=

