Return-Path: <netdev+bounces-278290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BRVZAoLP3Wl9jgkAu9opvQ
	(envelope-from <netdev+bounces-278290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:24:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 532803F5B8E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80FA6300D46E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 05:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119512F290E;
	Tue, 14 Apr 2026 05:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmxLPpW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18422D9ECD
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 05:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776144255; cv=none; b=jXXrlEONACq6LQWlpPSqB/1bwPt09tmUNyypBILzXnFhkw/w3KeBQjq7cMDKoseR7/MC+rSGqmLxr3RUpY7XqkUOmPQbm3AAUvSZJo9xWHNwzaLkr47+PuHGU/vLgHfkAM7i+DF78Ckld49LC539xJNelgZBAToozp3ZUuHhqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776144255; c=relaxed/simple;
	bh=E6WjbmEWe+S34PTulf60T6Wo7hTAM58aLyy7z6p2nBM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID; b=dNocIcpEkzitu4f2f//tvNWEk20TSA1Boiax1SOuQx9lm8lazpcieDkBz6jQQ3YZYyKNNZeLk7mrShVL/Fd8XGLr5xrdxcXwdPomsKDfZBsT7cE+XStsHugdzaD02HTmjG43YgO7+WFBt8S2c4WANDhn9rL9S3kyMcUaZA/LDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmxLPpW/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d65f4073bfso769578985a.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776144252; x=1776749052; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6WjbmEWe+S34PTulf60T6Wo7hTAM58aLyy7z6p2nBM=;
        b=AmxLPpW/4BVzW0I3iAP3Q5wAc+XXWANRmMQ71fz05NGugVmhS6kDCB5qD4+x4/KVXC
         DvMUd/o9x2Y03y6fADY+3xNJkGcu23JGevxWzySVMg2/Aat87iJ16ZH6tqeGgtI30Tu7
         pqXjAS/gwKsNB1N42y0Roysbi7UhjUetJuVjimlp7noVR/+K1/YJjKM7KN1SIQ7O1kWF
         cfqyo3NMyY8Ig/FUDjGu/BlodwEQXT6E2cdru7W2HyELkYiZwO8PQefsYbJcwYJTUClB
         ZFUiZilOY/9syKUHVaf38IJOFIyhSQU82gfWiO66v2bZrGz9JKuj/pOqgEpt3dZ1ELTp
         lEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776144252; x=1776749052;
        h=message-id:date:subject:cc:to:from:content-transfer-encoding
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6WjbmEWe+S34PTulf60T6Wo7hTAM58aLyy7z6p2nBM=;
        b=ortHpUJvDAwfdD4oluDdB/AuJUsXZVXCQsh6cfuOW5MaUiBBIIUdvUr4T/mTmeRkmN
         59k0YldBvg5SwtHWO1ioA9FtL/tvwVDLnFmGc9rpMDXM4OHdaRCRpd8cdPZ/YDExxYzu
         eEWna9CCCRTn8hwGMwaUfaeY4h0/SEzCfVljdQcCtFrvgzp0EveyDKAjj4rdbqNCSIoQ
         LjzMrVXbXl+yAbvu4Y5aL0rtU+B1cI+AP8oBnMqksBR7MfcLp3BKrmOkTnOBCGrfZgL8
         thZRV4SspnvX2ydxCEg+fGFLxDRX+Emh1U93SNEm5+F5S5DRUaW2MEOo+m/+CIm5E8+T
         KSLA==
X-Gm-Message-State: AOJu0Yx5kgmVXFNqyvg2FePI7sxCiV/AtjLpr71k2m9OjXPSTupSVvFE
	c9f83FlBoltWsWirv3amjk8QOy0OL4X12K+uXsD3gX3uPzK4QAz8To9/b0AIA8NxzV+0Nw==
X-Gm-Gg: AeBDiet1Ywu16cApKfzrwsMDX5oDYWfm/Worikg8nX1QBVoS1JyaX1+PnGtAYo52iCr
	FOiM0ziTdUWAnKE7k0rV85pzomt0TALPEjLZ4KSnrxSj97KxT5l+PEvuoZUr9ryX0etUBJQig0R
	RqejSDR3hnL+5EpSgt27F70vbUMqfTrjDR7AEFnjCBJBgS+3/m1zfjspRPUz4pWjArMGF77Of0T
	vsUDjc/cG8XboGfPHa5o8xzQM3xIA5+nwthwKfzdv6vNHeZI+XrRXlFvxyNGcn94kKnuPO1NyDu
	8eEo4fAec8s12u8e0uRypcb3bIuHChnZJMnxj3apVU2cYFLX5Rogq+q1YWgmalQF25m5dua6H54
	a1I76VKcgez7K7fZ2mAAkknZOwqzMGRxU4+hEw0XV+2ysM/Ugu1i2hJH7YbchyHQa0t5iu4SxwP
	whcq4TZELslwebD1ZugcBw1vDkkqaAom76Cc7uKP2SErx+vmF4hJlI8EhplF2cvAHjDtEBO48=
X-Received: by 2002:a05:620a:4112:b0:8d6:9e5c:36c with SMTP id af79cd13be357-8ddcd40a515mr2258927385a.6.1776144252505;
        Mon, 13 Apr 2026 22:24:12 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8deb5d9b336sm828868285a.9.2026.04.13.22.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:24:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, edumazet@google.com, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] nfc: hci: fix out-of-bounds read in HCP header parsing
Date: Tue, 14 Apr 2026 05:24:10 -0000
Message-ID: <177614425081.3600288.2536320552978506086@gmail.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278290-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 532803F5B8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bmZjX2hjaV9yZWN2X2Zyb21fbGxjKCkgYW5kIG5jaV9oY2lfZGF0YV9yZWNlaXZlZF9jYigpIGNh
c3Qgc2tiLT5kYXRhCnRvIHN0cnVjdCBoY3BfcGFja2V0IGFuZCByZWFkIHRoZSBtZXNzYWdlIGhl
YWRlciBieXRlIHdpdGhvdXQgY2hlY2tpbmcKdGhhdCBlbm91Z2ggZGF0YSBpcyBwcmVzZW50IGlu
IHRoZSBsaW5lYXIgc2tfYnVmZiBhcmVhLiBBIG1hbGljaW91cyBORkMKcGVlciBjYW4gc2VuZCBh
IDEtYnl0ZSBIQ1AgZnJhbWUgdGhhdCBwYXNzZXMgdGhyb3VnaCB0aGUgU0hETEMgbGF5ZXIKYW5k
IHJlYWNoZXMgdGhlc2UgZnVuY3Rpb25zLCBjYXVzaW5nIGFuIG91dC1vZi1ib3VuZHMgaGVhcCBy
ZWFkLgoKRml4IHRoaXMgYnkgYWRkaW5nIHBza2JfbWF5X3B1bGwoKSBiZWZvcmUgZWFjaCBjYXN0
IHRvIGVuc3VyZSB0aGUgZnVsbAoyLWJ5dGUgSENQIGhlYWRlciBpcyBwdWxsZWQgaW50byB0aGUg
bGluZWFyIGFyZWEgYmVmb3JlIGl0IGlzIGFjY2Vzc2VkLgoKRml4ZXM6IDhiOGQyZTA4YmYwZCAo
Ik5GQzogSENJIHN1cHBvcnQiKQpGaXhlczogMTFmNTRmMjI4NjQzICgiTkZDOiBuY2k6IEFkZCBI
Q0kgb3ZlciBOQ0kgcHJvdG9jb2wgc3VwcG9ydCIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ClNpZ25lZC1vZmYtYnk6IEFzaHV0b3NoIERlc2FpIDxhc2h1dG9zaGRlc2FpOTkzQGdtYWlsLmNv
bT4KLS0tClYzIC0+IFY0OiBhZGQgRml4ZXMgdGFncwpWMiAtPiBWMzogZHJvcCByZWR1bmRhbnQg
Y2hlY2tzIGZyb20gbmZjX2hjaV9tc2dfcnhfd29yay9uY2lfaGNpX21zZ19yeF93b3JrLAogICAg
ICAgICAgcmVtb3ZlIGluY29ycmVjdCBTdWdnZXN0ZWQtYnkgdGFnClYxIC0+IFYyOiBzd2l0Y2gg
c2tiLT5sZW4gY2hlY2sgdG8gcHNrYl9tYXlfcHVsbAoKdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL25ldGRldi8yMDI2MDQxMzAyNDMyOS4zMjkzMDc1LTEtYXNodXRvc2hkZXNhaTk5M0BnbWFp
bC5jb20vCnYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNjA0MDkxNTA4MjUu
MjIxNzEzMy0xLWFzaHV0b3NoZGVzYWk5OTNAZ21haWwuY29tLwp2MTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbmV0ZGV2LzIwMjYwNDA4MjIzMTEzLjIwMDkzMDQtMS1hc2h1dG9zaGRlc2FpOTkz
QGdtYWlsLmNvbS8KCiBuZXQvbmZjL2hjaS9jb3JlLmMgfCA1ICsrKysrCiBuZXQvbmZjL25jaS9o
Y2kuYyAgfCA1ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9uZXQvbmZjL2hjaS9jb3JlLmMgYi9uZXQvbmZjL2hjaS9jb3JlLmMKaW5kZXggMGQz
M2M4MWExNWZlLi5jZDljZjZjOTRhNTAgMTAwNjQ0Ci0tLSBhL25ldC9uZmMvaGNpL2NvcmUuYwor
KysgYi9uZXQvbmZjL2hjaS9jb3JlLmMKQEAgLTkwNCw2ICs5MDQsMTEgQEAgc3RhdGljIHZvaWQg
bmZjX2hjaV9yZWN2X2Zyb21fbGxjKHN0cnVjdCBuZmNfaGNpX2RldiAqaGRldiwgc3RydWN0IHNr
X2J1ZmYgKnNrYikKICAgICAgICAgICogdW5ibG9jayB3YWl0aW5nIGNtZCBjb250ZXh0LiBPdGhl
cndpc2UsIGVucXVldWUgdG8gZGlzcGF0Y2gKICAgICAgICAgICogaW4gc2VwYXJhdGUgY29udGV4
dCB3aGVyZSBoYW5kbGVyIGNhbiBhbHNvIGV4ZWN1dGUgY29tbWFuZC4KICAgICAgICAgICovCitp
ZiAoIXBza2JfbWF5X3B1bGwoaGNwX3NrYiwgTkZDX0hDSV9IQ1BfSEVBREVSX0xFTikpIHsKK2tm
cmVlX3NrYihoY3Bfc2tiKTsKK3JldHVybjsKK30KKwogcGFja2V0ID0gKHN0cnVjdCBoY3BfcGFj
a2V0ICopaGNwX3NrYi0+ZGF0YTsKIHR5cGUgPSBIQ1BfTVNHX0dFVF9UWVBFKHBhY2tldC0+bWVz
c2FnZS5oZWFkZXIpOwogaWYgKHR5cGUgPT0gTkZDX0hDSV9IQ1BfUkVTUE9OU0UpIHsKZGlmZiAt
LWdpdCBhL25ldC9uZmMvbmNpL2hjaS5jIGIvbmV0L25mYy9uY2kvaGNpLmMKaW5kZXggNDBhZThl
NWE3ZWM3Li42ZTYzM2RhMjU3ZDEgMTAwNjQ0Ci0tLSBhL25ldC9uZmMvbmNpL2hjaS5jCisrKyBi
L25ldC9uZmMvbmNpL2hjaS5jCkBAIC00ODIsNiArNDgyLDExIEBAIHZvaWQgbmNpX2hjaV9kYXRh
X3JlY2VpdmVkX2NiKHZvaWQgKmNvbnRleHQsCiAgICAgICAgICAqIHVuYmxvY2sgd2FpdGluZyBj
bWQgY29udGV4dC4gT3RoZXJ3aXNlLCBlbnF1ZXVlIHRvIGRpc3BhdGNoCiAgICAgICAgICAqIGlu
IHNlcGFyYXRlIGNvbnRleHQgd2hlcmUgaGFuZGxlciBjYW4gYWxzbyBleGVjdXRlIGNvbW1hbmQu
CiAgICAgICAgICAqLworaWYgKCFwc2tiX21heV9wdWxsKGhjcF9za2IsIE5DSV9IQ0lfSENQX0hF
QURFUl9MRU4pKSB7CitrZnJlZV9za2IoaGNwX3NrYik7CityZXR1cm47Cit9CisKIHBhY2tldCA9
IChzdHJ1Y3QgbmNpX2hjcF9wYWNrZXQgKiloY3Bfc2tiLT5kYXRhOwogdHlwZSA9IE5DSV9IQ1Bf
TVNHX0dFVF9UWVBFKHBhY2tldC0+bWVzc2FnZS5oZWFkZXIpOwogaWYgKHR5cGUgPT0gTkNJX0hD
SV9IQ1BfUkVTUE9OU0UpIHsKLS0gCjIuMzQuMQ==

