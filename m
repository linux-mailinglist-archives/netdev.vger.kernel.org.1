Return-Path: <netdev+bounces-81356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0711B887648
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 01:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E8B209E0
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 00:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1F1621;
	Sat, 23 Mar 2024 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COipAKc/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F17E1
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711155459; cv=none; b=hjT8bZxH4IQhw4jTe5eI8GcAkDOERViuTtGutbNIyz2piidMMpLDgJe28UMeoA0Z89sLMUdlem7zBkyeq5lhaNWraxZtZ2ryv57alqgrd/L4VuWIeeldiUPvgrB/svZCbRIqNPK80sOYNXL2eNun51XFze6f/3yTlkyJA7iLfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711155459; c=relaxed/simple;
	bh=6hDVEYEvmvnvpC9MWE2nZ5nV0gSog6KWE4C1wcVWPJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYX9XCG05RzEbcoCWi6V40/g+K1+U+hmfXoWiJw1JoVgSqXu/3Tz8Xbx8M8x86XOf+dtpXMwW0vLJ5BWVYFGvb8TbLHBv5j44AZBPOJBPtuY8xo1Fg0SmxDVhR/Pmd95YCP7hxzUpQlVlx6TPf+5csOkaZdpqrYdYg3rlFprgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COipAKc/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41412411672so21199075e9.3
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 17:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711155455; x=1711760255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hDVEYEvmvnvpC9MWE2nZ5nV0gSog6KWE4C1wcVWPJA=;
        b=COipAKc/E3pXZUDJzfkhC3NmUQ3cxkGUqf6gYrRPfVbAF50VQh/aJLVk/BjWxoTo+i
         IuVdusp+E1ZRGVzAQtje9pBkpS3mIIt60qwrsmjRQnZXrp5NQlzA2t4T8GznDDCTMdWJ
         dYSZgBFRu9gL4/guS9A62kNeN4gVlqgZSGvZc4zfUs5Hpnd1FwqVpZZo6E/o14h524U/
         JiPUJ+AQM8KxhYI01V++XfcZYb0PhUV9O+aGB1mf7wyDeF81wTbTFRb82h4kgqphV9Sa
         VDiTRbbmckDPukwY3q0UjKEzUYFAqV/Gpaf1zkf6vuJuFDTHqoPzhdFSbCN+pgKA3/V+
         mcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711155455; x=1711760255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hDVEYEvmvnvpC9MWE2nZ5nV0gSog6KWE4C1wcVWPJA=;
        b=aABtvl4ObLnEBxjKHQWzPhG4QdUVLrEQck8czSIApG2jGgYUMJijwjGK+0q9LPi7FN
         jxn+wxq6qXBptncL8eBiAZHofBHuDccjUERXLj8NXOT2u/Pw46/qSbCLVVwCziAGDIZ9
         VBYCQXB+BQjAlP8kocqcyvqiFeaudT3IA3gGK4K6CP5lBAKlJrXkR4fpa6HPO5O03nSG
         cYP4mpt0R6Pza35Rnr3BN4K+I71zexg2AuOU6uPsyW0U/7QT5Jsevc6nGqAS31iU9m12
         DFrrgb0SWpD9jXMkKhjLxPOVeNoINAXYk+8zQXczb5a7VQNhaEPKW5vNklQ/4f1F3ZrL
         0Jwg==
X-Forwarded-Encrypted: i=1; AJvYcCVpTJgNA07EauGoetIv3drg65rjKq1I28mzKtk5BqUAoUUTtSutq5Tr0P/P+ZcIuB1Fl0DZSLnHj8SX6LwQale1WK+EDZq9
X-Gm-Message-State: AOJu0Yzk0hoy6fxqcA71AHXBHiRp+78vVWfmG3hZQCFWybJErU5oyk1F
	yWHNF93RqP3KGdMrBPo8rUUcJ4fGXKJgFrhTD+sJnicCLt/hXIbq
X-Google-Smtp-Source: AGHT+IHBJChVKzKJ8Ha2DqnfkbtZYgesdtydIY4ye2NJ5g+9fT+XG0HZT9iUV72jyuZ2bSXgTVIQ4A==
X-Received: by 2002:a05:600c:1386:b0:414:7ddd:b92e with SMTP id u6-20020a05600c138600b004147dddb92emr539890wmf.39.1711155455400;
        Fri, 22 Mar 2024 17:57:35 -0700 (PDT)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id t13-20020a5d42cd000000b0033ec312cd8asm3226194wrr.33.2024.03.22.17.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:57:35 -0700 (PDT)
Message-ID: <c9f40771-be55-40fc-b3a5-085bad5c6e8c@gmail.com>
Date: Sat, 23 Mar 2024 02:57:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wwan: t7xx: Split 64bit accesses to fix
 alignment issues
Content-Language: en-US
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, netdev@vger.kernel.org
Cc: Liviu Dudau <liviu@dudau.co.uk>,
 Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
 Haijun Liu <haijun.liu@mediatek.com>,
 Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
 M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
 Ricardo Martinez <ricardo.martinez@linux.intel.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S . Miller" <davem@davemloft.net>
References: <20240322144000.1683822-1-bjorn@mork.no>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240322144000.1683822-1-bjorn@mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDMuMjAyNCAxNjo0MCwgQmrDuHJuIE1vcmsgd3JvdGU6DQo+IFNvbWUgb2YgdGhl
IHJlZ2lzdGVycyBhcmUgYWxpZ25lZCBvbiBhIDMyYml0IGJvdW5kYXJ5LCBjYXVzaW5nDQo+
IGFsaWdubWVudCBmYXVsdHMgb24gNjRiaXQgcGxhdGZvcm1zLg0KPiANCj4gICBVbmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBhdCB2aXJ0dWFsIGFkZHJlc3MgZmZm
ZmZmYzA4NGExZDAwNA0KPiAgIE1lbSBhYm9ydCBpbmZvOg0KPiAgIEVTUiA9IDB4MDAwMDAw
MDA5NjAwMDA2MQ0KPiAgIEVDID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIg
Yml0cw0KPiAgIFNFVCA9IDAsIEZuViA9IDANCj4gICBFQSA9IDAsIFMxUFRXID0gMA0KPiAg
IEZTQyA9IDB4MjE6IGFsaWdubWVudCBmYXVsdA0KPiAgIERhdGEgYWJvcnQgaW5mbzoNCj4g
ICBJU1YgPSAwLCBJU1MgPSAweDAwMDAwMDYxLCBJU1MyID0gMHgwMDAwMDAwMA0KPiAgIENN
ID0gMCwgV25SID0gMSwgVG5EID0gMCwgVGFnQWNjZXNzID0gMA0KPiAgIEdDUyA9IDAsIE92
ZXJsYXkgPSAwLCBEaXJ0eUJpdCA9IDAsIFhzID0gMA0KPiAgIHN3YXBwZXIgcGd0YWJsZTog
NGsgcGFnZXMsIDM5LWJpdCBWQXMsIHBnZHA9MDAwMDAwMDA0NmFkNjAwMA0KPiAgIFtmZmZm
ZmZjMDg0YTFkMDA0XSBwZ2Q9MTAwMDAwMDEzZmZmZjAwMywgcDRkPTEwMDAwMDAxM2ZmZmYw
MDMsIHB1ZD0xMDAwMDAwMTNmZmZmMDAzLCBwbWQ9MDA2ODAwMDAyMGEwMDcxMQ0KPiAgIElu
dGVybmFsIGVycm9yOiBPb3BzOiAwMDAwMDAwMDk2MDAwMDYxIFsjMV0gU01QDQo+ICAgTW9k
dWxlcyBsaW5rZWQgaW46IG10a190N3h4KCspIHFjc2VyaWFsIHBwcG9lIHBwcF9hc3luYyBv
cHRpb24gbmZ0X2ZpYl9pbmV0IG5mX2Zsb3dfdGFibGVfaW5ldCBtdDc5MjF1KE8pIG10Nzky
MXMoTykgbXQ3OTIxZShPKSBtdDc5MjFfY29tbW9uKE8pIGl3bG12bShPKSBpd2xkdm0oTykg
dXNiX3d3YW4gcm5kaXNfaG9zdCBxbWlfd3dhbiBwcHBveCBwcHBfZ2VuZXJpYyBuZnRfcmVq
ZWN0X2lwdjYgbmZ0X3JlamVjdF9pcHY0IG5mdF9yZWplY3RfaW5ldCBuZnRfcmVqZWN0IG5m
dF9yZWRpciBuZnRfcXVvdGEgbmZ0X251bWdlbiBuZnRfbmF0IG5mdF9tYXNxIG5mdF9sb2cg
bmZ0X2xpbWl0IG5mdF9oYXNoIG5mdF9mbG93X29mZmxvYWQgbmZ0X2ZpYl9pcHY2IG5mdF9m
aWJfaXB2NCBuZnRfZmliIG5mdF9jdCBuZnRfY2hhaW5fbmF0IG5mX3RhYmxlcyBuZl9uYXQg
bmZfZmxvd190YWJsZSBuZl9jb25udHJhY2sgbXQ3OTk2ZShPKSBtdDc5MnhfdXNiKE8pIG10
NzkyeF9saWIoTykgbXQ3OTE1ZShPKSBtdDc2X3VzYihPKSBtdDc2X3NkaW8oTykgbXQ3Nl9j
b25uYWNfbGliKE8pIG10NzYoTykgbWFjODAyMTEoTykgaXdsd2lmaShPKSBodWF3ZWlfY2Rj
X25jbSBjZmc4MDIxMShPKSBjZGNfbmNtIGNkY19ldGhlciB3d2FuIHVzYnNlcmlhbCB1c2Ju
ZXQgc2xoYyBzZnAgcnRjX3BjZjg1NjMgbmZuZXRsaW5rIG5mX3JlamVjdF9pcHY2IG5mX3Jl
amVjdF9pcHY0IG5mX2xvZ19zeXNsb2cgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQg
bXQ2NTc3X2F1eGFkYyBtZGlvX2kyYyBsaWJjcmMzMmMgY29tcGF0KE8pIGNkY193ZG0gY2Rj
X2FjbSBhdDI0IGNyeXB0b19zYWZleGNlbCBwd21fZmFuIGkyY19ncGlvIGkyY19zbWJ1cyBp
bmR1c3RyaWFsaW8gaTJjX2FsZ29fYml0IGkyY19tdXhfcmVnIGkyY19tdXhfcGNhOTU0eCBp
MmNfbXV4X3BjYTk1NDEgaTJjX211eF9ncGlvIGkyY19tdXggZHVtbXkgb2lkX3JlZ2lzdHJ5
IHR1biBzaGE1MTJfYXJtNjQgc2hhMV9jZSBzaGExX2dlbmVyaWMgc2VxaXYNCj4gICBtZDUg
Z2VuaXYgZGVzX2dlbmVyaWMgbGliZGVzIGNiYyBhdXRoZW5jZXNuIGF1dGhlbmMgbGVkc19n
cGlvIHhoY2lfcGxhdF9oY2QgeGhjaV9wY2kgeGhjaV9tdGtfaGNkIHhoY2lfaGNkIG52bWUg
bnZtZV9jb3JlIGdwaW9fYnV0dG9uX2hvdHBsdWcoTykgZG1fbWlycm9yIGRtX3JlZ2lvbl9o
YXNoIGRtX2xvZyBkbV9jcnlwdCBkbV9tb2QgZGF4IHVzYmNvcmUgdXNiX2NvbW1vbiBwdHAg
YXF1YW50aWEgcHBzX2NvcmUgbWlpIHRwbSBlbmNyeXB0ZWRfa2V5cyB0cnVzdGVkDQo+ICAg
Q1BVOiAzIFBJRDogNTI2NiBDb21tOiBrd29ya2VyL3U5OjEgVGFpbnRlZDogRyBPIDYuNi4y
MiAjMA0KPiAgIEhhcmR3YXJlIG5hbWU6IEJhbmFuYXBpIEJQSS1SNCAoRFQpDQo+ICAgV29y
a3F1ZXVlOiBtZF9oa193cSB0N3h4X2ZzbV91bmluaXQgW210a190N3h4XQ0KPiAgIHBzdGF0
ZTogODA0MDAwYzUgKE56Y3YgZGFJRiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIEJUWVBF
PS0tKQ0KPiAgIHBjIDogdDd4eF9jbGRtYV9od19zZXRfc3RhcnRfYWRkcisweDFjLzB4M2Mg
W210a190N3h4XQ0KPiAgIGxyIDogdDd4eF9jbGRtYV9zdGFydCsweGFjLzB4MTNjIFttdGtf
dDd4eF0NCj4gICBzcCA6IGZmZmZmZmMwODVkNjNkMzANCj4gICB4Mjk6IGZmZmZmZmMwODVk
NjNkMzAgeDI4OiAwMDAwMDAwMDAwMDAwMDAwIHgyNzogMDAwMDAwMDAwMDAwMDAwMA0KPiAg
IHgyNjogMDAwMDAwMDAwMDAwMDAwMCB4MjU6IGZmZmZmZjgwYzgwNGYyYzAgeDI0OiBmZmZm
ZmY4MGNhMTk2YzA1DQo+ICAgeDIzOiAwMDAwMDAwMDAwMDAwMDAwIHgyMjogZmZmZmZmODBj
ODE0YjliOCB4MjE6IGZmZmZmZjgwYzgxNGIxMjgNCj4gICB4MjA6IDAwMDAwMDAwMDAwMDAw
MDEgeDE5OiBmZmZmZmY4MGM4MTRiMDgwIHgxODogMDAwMDAwMDAwMDAwMDAxNA0KPiAgIHgx
NzogMDAwMDAwMDA1NWM5ODA2YiB4MTY6IDAwMDAwMDAwN2M1Mjk2ZDAgeDE1OiAwMDAwMDAw
MDBmNmJjYTY4DQo+ICAgeDE0OiAwMDAwMDAwMGRiZGJkY2U0IHgxMzogMDAwMDAwMDAxYWVh
ZjcyYSB4MTI6IDAwMDAwMDAwMDAwMDAwMDENCj4gICB4MTE6IDAwMDAwMDAwMDAwMDAwMDAg
eDEwOiAwMDAwMDAwMDAwMDAwMDAwIHg5IDogMDAwMDAwMDAwMDAwMDAwMA0KPiAgIHg4IDog
ZmZmZmZmODBjYTFlZjZiNCB4NyA6IGZmZmZmZjgwYzgxNGI4MTggeDYgOiAwMDAwMDAwMDAw
MDAwMDE4DQo+ICAgeDUgOiAwMDAwMDAwMDAwMDAwODcwIHg0IDogMDAwMDAwMDAwMDAwMDAw
MCB4MyA6IDAwMDAwMDAwMDAwMDAwMDANCj4gICB4MiA6IDAwMDAwMDAxMGE5NDcwMDAgeDEg
OiBmZmZmZmZjMDg0YTFkMDA0IHgwIDogZmZmZmZmYzA4NGExZDAwNA0KPiAgIENhbGwgdHJh
Y2U6DQo+ICAgdDd4eF9jbGRtYV9od19zZXRfc3RhcnRfYWRkcisweDFjLzB4M2MgW210a190
N3h4XQ0KPiAgIHQ3eHhfZnNtX3VuaW5pdCsweDU3OC8weDVlYyBbbXRrX3Q3eHhdDQo+ICAg
cHJvY2Vzc19vbmVfd29yaysweDE1NC8weDJhMA0KPiAgIHdvcmtlcl90aHJlYWQrMHgyYWMv
MHg0ODgNCj4gICBrdGhyZWFkKzB4ZTAvMHhlYw0KPiAgIHJldF9mcm9tX2ZvcmsrMHgxMC8w
eDIwDQo+ICAgQ29kZTogZjk0MDA4MDAgOTEwMDEwMDAgOGIyMTQwMDEgZDUwMzMyYmYgKGY5
MDAwMDIyKQ0KPiAgIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiAN
Cj4gVGhlIGluY2x1c2lvbiBvZiBpby02NC1ub25hdG9taWMtbG8taGkuaCBpbmRpY2F0ZXMg
dGhhdCBhbGwgNjRiaXQNCj4gYWNjZXNzZXMgY2FuIGJlIHJlcGxhY2VkIGJ5IHBhaXJzIG9m
IG5vbmF0b21pYyAzMmJpdCBhY2Nlc3MuICBGaXgNCj4gYWxpZ25tZW50IGJ5IGZvcmNpbmcg
YWxsIGFjY2Vzc2VzIHRvIGJlIDMyYml0IG9uIDY0Yml0IHBsYXRmb3Jtcy4NCj4gDQo+IExp
bms6IGh0dHBzOi8vZm9ydW0ub3BlbndydC5vcmcvdC9maWJvY29tLWZtMzUwLWdsLXN1cHBv
cnQvMTQyNjgyLzcyDQo+IEZpeGVzOiAzOWQ0MzkwNDdmMWQgKCJuZXQ6IHd3YW46IHQ3eHg6
IEFkZCBjb250cm9sIERNQSBpbnRlcmZhY2UiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBCasO4cm4g
TW9yayA8Ympvcm5AbW9yay5ubz4NCg0KUmV2aWV3ZWQtYnk6IFNlcmdleSBSeWF6YW5vdiA8
cnlhemFub3Yucy5hQGdtYWlsLmNvbT4NCg==

