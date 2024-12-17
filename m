Return-Path: <netdev+bounces-152516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270EB9F4682
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3716AE01
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2C199FAB;
	Tue, 17 Dec 2024 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XPbnpWjX"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98821DD0C7
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425509; cv=none; b=WhHXFBlwGCaRtNAiOxntlzrDYs3p5llj897b+kelRb/DsiTesKqN9T3mp6LE+YtaJMGlDCiIafLpaL6I0xwIVhUH7vMtyiX3LzpoZJYDIfThQas5Adtq+2h25S1bxta//Khrswef52VMoEYVIs1tdhFEpJcAN0xnm1HZu3cRo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425509; c=relaxed/simple;
	bh=uzsTfwzpu5n2VfLJYONPPTdurUho60l5SpWtEx2cgso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGcWIwyUmOU8jAFlVsKiB/j3/B9f3L3KVj/rP3+0BODaMYxl8fwVc44IHwt1YHNEVNYVbhJcEWf8iAY6dTvWltu9lOZ9boH+PidkWRvQ5Lnye8CbvxUxxd+Cgk8ivbtow5/MkMU5bJXH+blnu1/xlC8PiPVcX3lCvfl8UMfubQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XPbnpWjX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1734425496;
	bh=uzsTfwzpu5n2VfLJYONPPTdurUho60l5SpWtEx2cgso=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XPbnpWjXuA0jd3csf6nsxn2zNEbK8mq62J+CYXiNF0+PLautrd72LkZzSOX3LH8Ub
	 rCGUU7mV5/tUufAJpL/rL3aCtw0xKR7VrZsMaqzqIjuqg4fOBic8fqhsG+jvXBnbL0
	 8u5pY2tS6Fs4Nxw57+hCuDHI1G8dBwfwIKNFl9IDbqjF46lY0gct5k4MPKWStHl4Hc
	 CDbqb12d2z8hnuKxtxKYCXE9Y+TfCqqYW4neEI4LdFxpVBOLfLUnP+Hxbz/LXPkzGW
	 RFTiIA1rxsiNY0lDrXbe58/y9kakalMaJKe6j3nvSSmKM/Z9S0RxEtsFyuB2LVpZYg
	 DSRfkixf70ZCQ==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EA41F6F37F;
	Tue, 17 Dec 2024 16:51:35 +0800 (AWST)
Message-ID: <5825fee13fa794dbe91f3e36224085a37c725d3b.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next 1/3] net: mctp: handle skb cleanup on
 sock_queue failures
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Paolo Abeni <pabeni@redhat.com>, Matt Johnston
 <matt@codeconstruct.com.au>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Date: Tue, 17 Dec 2024 16:51:35 +0800
In-Reply-To: <f3dba541-8880-4a03-b0c9-e7b9b552b8f3@redhat.com>
References: <20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au>
	 <20241211-mctp-next-v1-1-e392f3d6d154@codeconstruct.com.au>
	 <f3dba541-8880-4a03-b0c9-e7b9b552b8f3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUGFvbG8sCgo+IFdoeSBhcmUgeW91IHRhcmdldGluZyBuZXQtbmV4dCBmb3IgdGhpcyBwYXRj
aD8gaXQgbG9va3MgbGlrZSBhIGNsZWFuCj4gZml4IGZvciBuZXQsIGFuZCBmb2xsb3ctdXAgcGF0
Y2hlcyBkb24ndCBkZXBlbmQgb24gaXQuCgpKdXN0IHRoYXQgSSB3YXNuJ3QgY29uZmlkZW50IHRo
YXQgdGhpcyB3b3VsZCBxdWFsaWZ5IGZvciBuZXQ7IGdpdmVuIHlvdQpoYXZlIGluZGljYXRlZCBz
bywgSSdsbCBzcGxpdCBhbmQgcmVzZW5kLgoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLyogd2UgbmVlZCB0byBiZSBjb250aW51aW5nIGFuIGV4aXN0aW5nIHJlYXNzZW1ibHku
Li4gKi8KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIWtleS0+cmVhc21f
aGVhZCkKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmMgPSAtRUlOVkFMOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsc2UKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoa2V5LT5yZWFzbV9oZWFkKQo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMgPSBtY3Rw
X2ZyYWdfcXVldWUoa2V5LCBza2IpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGVsc2UKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmMgPSAtRUlOVkFMOwo+IAo+IFRoaXMgY2h1bmsganVzdCByZS1vcmRlciBleGlzdGluZyBzdGF0
ZW1lbnQsIGl0IGxvb2tzIHVubmVlZGVkIGFuZCBJCj4gd291bGQgcmVtb3ZlIGl0IGZyb20gJ25l
dCcgZml4LgoKWWVwLCBtYWtlcyBzZW5zZSwgYXMgd2VsbCBhcyB0aGUgZ290byBmb3IgdGhlIGVh
cmx5IGV4aXQgaGVyZS4KCkknbGwgZm9sbG93LXVwIHdpdGggYSB2MiBmb3IgYm90aCBuZXQgKDEv
MykgYW5kIG5ldC1uZXh0ICgyLzMgJiAzLzMpLgoKQ2hlZXJzLAoKCkplcmVteQo=


