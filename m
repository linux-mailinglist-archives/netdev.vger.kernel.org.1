Return-Path: <netdev+bounces-184692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D9AA96E24
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4A3AA075
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601222857DB;
	Tue, 22 Apr 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="d4ftkFWB"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDBF285407;
	Tue, 22 Apr 2025 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331391; cv=none; b=KTyRAuK7xoLURv0KXmc9vxPqB2OQiNzv84wH9EhVH0MXEWTOc+UNLnukZqgwPzUU5TkAaeG/lYHQaBP+BZhVgb6KW+LWg8T/nCs9cJNj5sLJJ3/tc4isD2CuNTvCTjneDn/GPJDQFJX3S098iaih2xS6jN2uJhxxKyrUjkFEDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331391; c=relaxed/simple;
	bh=HtPzaRkRoi38/+/mEVnn1vewPf7Ei+7QHXpz/dJQu5Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUBjPRJ2IvaVaNrrJLv4FIYj9UC1yoPD6ARluzsGMNhXdjO3IUTrcN1W6nsawwARkUJpT4EaqE9RZ8uc2KudCx0c2Ra+DqZPHhCJnjA4fT+O2CbM4B0DQ7Q3XMjKmLLjohKrOPEv2orpD93AIQo9lGxbWPTAsmbbAeBwJonJqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=d4ftkFWB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1745331387;
	bh=HtPzaRkRoi38/+/mEVnn1vewPf7Ei+7QHXpz/dJQu5Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d4ftkFWBwttQOLFp1Q5NZjbebk11aH83vDLVLT2OBVTBHF2QqL9i0t684uYUkdjL8
	 pTkdy09eeZXQ2ka+taWknwS275HeFjmwGmD+Lb/f8C+o+V5dw8dSRdbgg5WfyTL1yf
	 bSHOpDBbsj7kjHw4rDxZfsOlKjgc20fl7P1+1JV6z4d4WIgyAu5FGSh5gTyfDSHRJ2
	 /RWAR6xKw3RXetfYXUbPz5oW3GhaBFvC+Bksw3d4FnUApJb+gUCQ2Jy80SHQLuelCY
	 ypNkw3mobfsPiTLQcSOGpSibuGVdLsnpNmT0IGlVrn1+WFFvly4wru1nwmpk5roVYv
	 fodaHHy8c9g2g==
Received: from sparky.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5CB0A7EB68;
	Tue, 22 Apr 2025 22:16:27 +0800 (AWST)
Message-ID: <cb1a24ef23523f01868127430dbbe48428ad5e0d.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v19 1/1] mctp pcc: Implement MCTP over PCC
 Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: admiyo@os.amperecomputing.com, Matt Johnston
 <matt@codeconstruct.com.au>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Tue, 22 Apr 2025 22:16:27 +0800
In-Reply-To: <20250418221438.368203-5-admiyo@os.amperecomputing.com>
References: <20250418221438.368203-1-admiyo@os.amperecomputing.com>
	 <20250418221438.368203-5-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQWRhbSwKCltyZXNlbmQsIHVuLUhUTUxlZC4gU29ycnkgZm9yIHRoZSBub2lzZSFdCgpPbmUg
YnVnIGluIHRoZSBjb2RlLCBhbmQgYW5vdGhlciBjb3VwbGUgb2Ygbm90ZXMgc2luY2Ugd2UnbGwg
bmVlZCBhIHJlLXJvbGw6Cgo+ICsjZGVmaW5lIE1DVFBfUEFZTE9BRF9MRU5HVEjCoMKgwqDCoCAy
NTYKPiArI2RlZmluZSBNQ1RQX0NNRF9MRU5HVEjCoMKgwqDCoMKgwqDCoMKgIDQKPiArI2RlZmlu
ZSBNQ1RQX1BDQ19WRVJTSU9OwqDCoMKgwqDCoMKgwqAgMHgxIC8qIERTUDAyNTMgZGVmaW5lcyBh
IHNpbmdsZSB2ZXJzaW9uOiAxICovCgpNaXNtYXRjaGVkIERTUCByZWZlcmVuY2UgYWJvdmUgLSBE
U1AwMjUzIGlzIHNlcmlhbC4KCj4gK3N0YXRpYyBuZXRkZXZfdHhfdCBtY3RwX3BjY190eChzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqbmRldikKPiArewo+ICvCoMKgwqDC
oMKgwqDCoHN0cnVjdCBtY3RwX3BjY19uZGV2ICptcG5kID0gbmV0ZGV2X3ByaXYobmRldik7Cj4g
K8KgwqDCoMKgwqDCoMKgc3RydWN0IG1jdHBfcGNjX2hkcsKgICptY3RwX3BjY19oZWFkZXI7CgpB
bm90aGVyIGRvdWJsZS1zcGFjZSBoYXMgY3JlcHQgaW4gaGVyZS4KCj4gK8KgwqDCoMKgwqDCoMKg
dm9pZCBfX2lvbWVtICpidWZmZXI7Cj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBmbGFn
czsKPiArwqDCoMKgwqDCoMKgwqBpbnQgbGVuID0gc2tiLT5sZW47Cj4gK8KgwqDCoMKgwqDCoMKg
aW50IHJjOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBkZXZfZHN0YXRzX3R4X2FkZChuZGV2LCBsZW4p
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqBzcGluX2xvY2tfaXJxc2F2ZSgmbXBuZC0+bG9jaywgZmxh
Z3MpOwo+ICvCoMKgwqDCoMKgwqDCoHJjID0gc2tiX2Nvd19oZWFkKHNrYiwgc2l6ZW9mKHN0cnVj
dCBtY3RwX3BjY19oZHIpKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmMpCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByYzsKClRoaXMgd2lsbCByZXR1cm4gd2l0aCBtcGRu
LT5sb2NrIHN0aWxsIGhlbGQuCgpBbmQgc2hvdWxkIHRoaXMgcmV0dXJuIHRoZSByYXcgcmMgdmFs
dWU/IE9yIE5FVERFVl9UWF9PSz8KCkNoZWVycywKCgpKZXJlbXkKCg==


