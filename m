Return-Path: <netdev+bounces-132631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E69928D3
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C75285E71
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE71A76A2;
	Mon,  7 Oct 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KiSalISL"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CB231CA9
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295814; cv=none; b=l9/FO/+k1KcNFz5S6RZAiAHXARYlDBls4QGSnesyAIpgClXUY8c2MuV7LqMxVpjb7wT4oDlg6m8LAoPWmwk4ipBbufWtL+GZt7MB9GlzSxTNZtg5RLLAYLBnXYAgrmeT7O5pi59K2Mxq4a+9DwjdRWQDBGGUrwlunLZ/Bu/ya0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295814; c=relaxed/simple;
	bh=ukxnln4+Kp/4FY1LSjEJ6dgfnkvanK2/a7JnKT0JHT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rJnKiEW2kMYvTr/qgqf01sV9C2MOfYiQBSprizArmmgvGNxsS7JBYYuvJpG5UMC/XNqWaG7l8GY501cXyg2UX0nJN1NUHI/JFrFodA5p5uB5hKCJp+WhlbmwKSVhE2S++0+ihA7H5N5TsU/XXhT4ynfbCrkyE40nmjxQGv3MPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KiSalISL; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1728295800;
	bh=ukxnln4+Kp/4FY1LSjEJ6dgfnkvanK2/a7JnKT0JHT8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KiSalISL9x93Wd6/jCI2myaAtdj7CjZtzqoUQ/o10AD3/wrEX1vFgi2fSSbg9q5fu
	 DwpkkjnojLVIf0BR6ljuoAgr+8DJaNNyEWwwU2/hF7E6wL8SXpL16PR6reOEAzbg0p
	 y+3kzzV9B+xe4OW1XVQJ5AvAR0ykI5fbeGlrEZqcpWEXuPMX9o7aR+lDhn9KTMcIJH
	 JpJyWAX11Wfgw9E94CG9wCFLRYUP/AIU6FPHVLhCe+JuNZvWj1QbDOP2pP9ZwZbM4Z
	 5cYxmHfEQD37+I/89v93RXPG5obW26+Zwv/75VlH5K4wlp+o0AVR++3Dw39zfWYMLX
	 LkDpUpNAgFRag==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 57F5E6497F;
	Mon,  7 Oct 2024 18:10:00 +0800 (AWST)
Message-ID: <dcaa0489e90f7c294f6b5e4858b98210766383dc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 net 4/6] mctp: Handle error of rtnl_register_module().
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Matt
	Johnston <matt@codeconstruct.com.au>
Date: Mon, 07 Oct 2024 18:09:59 +0800
In-Reply-To: <20241004222358.79129-5-kuniyu@amazon.com>
References: <20241004222358.79129-1-kuniyu@amazon.com>
	 <20241004222358.79129-5-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgS3VuaXl1a2ksCgo+IFNpbmNlIGludHJvZHVjZWQsIG1jdHAgaGFzIGJlZW4gaWdub3Jpbmcg
dGhlIHJldHVybmVkIHZhbHVlCj4gb2YgcnRubF9yZWdpc3Rlcl9tb2R1bGUoKSwgd2hpY2ggY291
bGQgZmFpbC4KPiAKPiBMZXQncyBoYW5kbGUgdGhlIGVycm9ycyBieSBydG5sX3JlZ2lzdGVyX21v
ZHVsZV9tYW55KCkuCgpTb3VuZHMgZ29vZCEKCkp1c3QgYSBjb3VwbGUgb2YgbWlub3IgdGhpbmdz
IGlubGluZSwgYnV0IHJlZ2FyZGxlc3M6CgpSZXZpZXdlZC1ieTogSmVyZW15IEtlcnIgPGprQGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PgoKPiBkaWZmIC0tZ2l0IGEvbmV0L21jdHAvZGV2aWNlLmMgYi9u
ZXQvbWN0cC9kZXZpY2UuYwo+IGluZGV4IGFjYjk3YjI1NzQyOC4uZDcwZTY4OGFjODg2IDEwMDY0
NAo+IC0tLSBhL25ldC9tY3RwL2RldmljZS5jCj4gKysrIGIvbmV0L21jdHAvZGV2aWNlLmMKPiBA
QCAtNTI0LDI1ICs1MjQsMzEgQEAgc3RhdGljIHN0cnVjdCBub3RpZmllcl9ibG9jayBtY3RwX2Rl
dl9uYiA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgLnByaW9yaXR5ID0gQUREUkNPTkZfTk9USUZZX1BS
SU9SSVRZLAo+IMKgfTsKPiDCoAo+IC12b2lkIF9faW5pdCBtY3RwX2RldmljZV9pbml0KHZvaWQp
Cj4gK3N0YXRpYyBzdHJ1Y3QgcnRubF9tc2dfaGFuZGxlciBtY3RwX2RldmljZV9ydG5sX21zZ19o
YW5kbGVyc1tdID0gewo+ICvCoMKgwqDCoMKgwqDCoHtQRl9NQ1RQLCBSVE1fTkVXQUREUiwgbWN0
cF9ydG1fbmV3YWRkciwgTlVMTCwgMH0sCj4gK8KgwqDCoMKgwqDCoMKge1BGX01DVFAsIFJUTV9E
RUxBRERSLCBtY3RwX3J0bV9kZWxhZGRyLCBOVUxMLCAwfSwKPiArwqDCoMKgwqDCoMKgwqB7UEZf
TUNUUCwgUlRNX0dFVEFERFIsIE5VTEwsIG1jdHBfZHVtcF9hZGRyaW5mbywgMH0sCj4gK307CgpD
YW4gdGhpcyAoYW5kIHRoZSBvdGhlciBoYW5kbGVyIGFycmF5cykgYmUgY29uc3Q/IEFuZCBjb25z
ZXF1ZW50bHksIHRoZQpwb2ludGVyIGFyZ3VtZW50IHRoYXQgeW91IHBhc3MgdG8gcnRubF9yZWdp
c3Rlcl9tb2R1bGVfbWFueSgpIGZyb20gMS82PwoKPiDCoGludCBfX2luaXQgbWN0cF9yb3V0ZXNf
aW5pdCh2b2lkKQo+IMKgewo+ICvCoMKgwqDCoMKgwqDCoGludCBlcnI7Cj4gKwo+IMKgwqDCoMKg
wqDCoMKgwqBkZXZfYWRkX3BhY2soJm1jdHBfcGFja2V0X3R5cGUpOwo+IMKgCj4gLcKgwqDCoMKg
wqDCoMKgcnRubF9yZWdpc3Rlcl9tb2R1bGUoVEhJU19NT0RVTEUsIFBGX01DVFAsIFJUTV9HRVRS
T1VURSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIE5VTEwsIG1jdHBfZHVtcF9ydGluZm8sIDApOwo+IC3CoMKgwqDCoMKgwqDCoHJ0bmxf
cmVnaXN0ZXJfbW9kdWxlKFRISVNfTU9EVUxFLCBQRl9NQ1RQLCBSVE1fTkVXUk9VVEUsCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtY3Rw
X25ld3JvdXRlLCBOVUxMLCAwKTsKPiAtwqDCoMKgwqDCoMKgwqBydG5sX3JlZ2lzdGVyX21vZHVs
ZShUSElTX01PRFVMRSwgUEZfTUNUUCwgUlRNX0RFTFJPVVRFLAo+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWN0cF9kZWxyb3V0ZSwgTlVM
TCwgMCk7Cj4gK8KgwqDCoMKgwqDCoMKgZXJyID0gcmVnaXN0ZXJfcGVybmV0X3N1YnN5cygmbWN0
cF9uZXRfb3BzKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoZXJyKQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBnb3RvIGZhaWxfcGVybmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBlcnIg
PSBydG5sX3JlZ2lzdGVyX21vZHVsZV9tYW55KG1jdHBfcm91dGVfcnRubF9tc2dfaGFuZGxlcnMp
Owo+ICvCoMKgwqDCoMKgwqDCoGlmIChlcnIpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdvdG8gZmFpbF9ydG5sOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIHJlZ2lzdGVy
X3Blcm5ldF9zdWJzeXMoJm1jdHBfbmV0X29wcyk7Cj4gK291dDoKPiArwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gZXJyOwo+ICsKPiArZmFpbF9ydG5sOgo+ICvCoMKgwqDCoMKgwqDCoHVucmVnaXN0ZXJf
cGVybmV0X3N1YnN5cygmbWN0cF9uZXRfb3BzKTsKPiArZmFpbF9wZXJuZXQ6Cj4gK8KgwqDCoMKg
wqDCoMKgZGV2X3JlbW92ZV9wYWNrKCZtY3RwX3BhY2tldF90eXBlKTsKPiArwqDCoMKgwqDCoMKg
wqBnb3RvIG91dDsKPiDCoH0KCkp1c3QgYHJldHVybiBlcnI7YCBoZXJlIC0gbm8gbmVlZCBmb3Ig
dGhlIGJhY2t3YXJkcyBnb3RvIHRvIHRoZSByZXR1cm4uCgpBbmQgb25seSBpZiB5b3UgZW5kIHVw
IHJlLXJvbGxpbmcgdGhlIHBhdGNoOiBjYW4gdGhlc2UgbGFiZWxzIGJlIGVycl8qLApzbyB0aGF0
IHdlJ3JlIGNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgZmlsZT8KCkNoZWVycywKCgpK
ZXJlbXkK


