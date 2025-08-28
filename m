Return-Path: <netdev+bounces-217969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E253B3AA72
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A878D7B13E4
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C02F0C4D;
	Thu, 28 Aug 2025 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wwMroWnT"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F8270576
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407374; cv=none; b=jOJd+kZ91EtoiLIcPtHSkpceg6ozTK4nVVyaOO2L/JU+ehn/6TtrPK4L+GqJiF+iGG/y6E6ajtI10HWuyBC5wY4LTk4BBFMBYdNB5w7M0NDN4hPyVVMgFmleopSLvB7DdbrJNZZD0KLLGREgEp261CKNJkoYIBm7pdaQtCZRUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407374; c=relaxed/simple;
	bh=o+rWWR9aAIlTHU/zAcgJ18ep0ecbKrZKfu3c9XnHWHI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=LGQoacLEPdHFvCfMnIu92gu0e/65F8cOQWqfJ2/Kkp+7oeUk9hpyeE/zahLhUC2vtnkOolQnBb7F7GnJ0Kq+cGIdDeDxFaWGBeWqjLu7wOWCrPkW216ny3lvcJlqAzGkp2AVy9TahxwQd+jYsAEayTCQx2nOW2/S5ewFg9pHDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wwMroWnT; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: multipart/mixed; boundary="------------0a6RtEyOUbqPmlEsckM4giYv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756407368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7BgjAKU2pA5MCsElCx1qstMximUD6yAyVfu9WTz2cR8=;
	b=wwMroWnTz+wgG5FOhD8iDDLAzTHiI5fUTlYrJOc51KcVSjc9tbrxtvxXIgMPqByDwAlwdO
	0aGdtPRvkKvjgJzDxUwZgLgUAjkUg+S/7k2LKsqNyGi1tmOKL4YAUbW4aLPom1pGugrnnx
	GEnYX8FcK4/NbpUqKB+P9lwemM4B9Ro=
Message-ID: <8e60d336-9cab-4003-8972-bda0b041d8cf@linux.dev>
Date: Thu, 28 Aug 2025 14:56:00 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: netpoll: raspberrypi [4 5] driver locking woes
To: Mike Galbraith <efault@gmx.de>, Robert Hancock <robert.hancock@calian.com>
Cc: Breno Leitao <leitao@debian.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4698029bbe7d7a33edd905a027e3a183ac51ad8a.camel@gmx.de>
 <e32a52852025d522f44d9d6ccc88c716ff432f8f.camel@gmx.de>
 <f4fa3fcc637ffb6531982a90dbd9c27114e93036.camel@gmx.de>
 <cbc6389e-069e-4f59-8544-fa59678e401b@linux.dev>
 <39f14032374d5d60c62b283637267a96ce535861.camel@gmx.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <39f14032374d5d60c62b283637267a96ce535861.camel@gmx.de>
X-Migadu-Flow: FLOW_OUT

This is a multi-part message in MIME format.
--------------0a6RtEyOUbqPmlEsckM4giYv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mike,

On 8/28/25 13:26, Mike Galbraith wrote:
> On Thu, 2025-08-28 at 10:57 -0400, Sean Anderson wrote:
>> Hi Mike,
>> 
>> On 8/27/25 12:02, Mike Galbraith wrote:
>> > Unexpected addendum to done deal datapoint, so off list.
>> > 
>> > On Tue, 2025-08-26 at 11:49 +0200, Mike Galbraith wrote:
>> > > 
>> > > The pi5 gripe fix is equally trivial, but submitting that is pointless
>> > > given there's something else amiss in fingered commit.  This is all of
>> > > the crash info that escapes the box w/wo gripes silenced.
>> > > 
>> > > [   51.688868] sysrq: Trigger a crash
>> > > [   51.688892] Kernel panic - not syncing: sysrq triggered crash
>> > > [   51.698066] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc2-v8-lockdep #533 PREEMPTLAZY
>> > > [   51.707234] Hardware name: Raspberry Pi 5 Model B Rev 1.0 (DT)
>> > > [   51.713085] Call trace:
>> > > [   51.715532]  show_stack+0x20/0x38 (C)
>> > > [   51.719206]  dump_stack_lvl+0x38/0xd0
>> > > [   51.722878]  dump_stack+0x18/0x28
>> > > 
>> > > That aspect is a punt and run atm (time.. and dash of laziness:).
>> > 
>> > Plan was to end datapoint thread, but after booting pi5's 6.12 kernel,
>> > for some reason I fired up netconsole.. and box promptly exhibited the
>> > netpoll locking bug warning, indicating presence of 138badbc21a0. 
>> > Instead of saying to self "nope, just walk away", I poked SysRq-C.. and
>> > the bloody damn monitoring box received a 100% complete death rattle. 
>> > Well bugger.
>> 
>> Did you get a backtrace for this?
> 
> Yes, logs for 6.12.41 and 6.17.0-rc2 attached.
> 
> Since a patch has meanwhile landed, also a log of patched 6.17.0-rc3
> now gripe free (yay) but with aforementioned broken output, followed by
> addition of the e6a532185daa revert to confirm it still cures that.
> 
>> And to be clear, the steps to reproduce this are to boot a kernel with
>> lockdep enabled with netconsole on macb and then hit sysrq?
> 
> Yup.

Looks like the tx completion path can also be called from netpoll. Can
you try the attached patch?

--Sean
--------------0a6RtEyOUbqPmlEsckM4giYv
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-net-macb-Fix-tx_ptr_lock-locking.patch"
Content-Disposition: attachment;
 filename="0001-net-macb-Fix-tx_ptr_lock-locking.patch"
Content-Transfer-Encoding: base64

RnJvbSAzZmU0Mzk3NjA5NTUzNzBiOWYwMDVlZjI3MjhiNWZjOWIxNGVlZWE1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQGxp
bnV4LmRldj4KRGF0ZTogVGh1LCAyOCBBdWcgMjAyNSAxMTo1NTowMSAtMDQwMApTdWJqZWN0
OiBbUEFUQ0ggbmV0IHYyXSBuZXQ6IG1hY2I6IEZpeCB0eF9wdHJfbG9jayBsb2NraW5nCgpt
YWNiX3N0YXJ0X3htaXQgY2FuIGJlIGNhbGxlZCB3aXRoIGJvdHRvbS1oYWx2ZXMgZGlzYWJs
ZWQgKGUuZy4KdHJhbnNtaXR0aW5nIGZyb20gc29mdGlycXMpIGFzIHdlbGwgYXMgd2l0aCBp
bnRlcnJ1cHRzIGRpc2FibGVkICh3aXRoCm5ldHBvbGwpLiBCZWNhdXNlIG9mIHRoaXMsIGFs
bCBvdGhlciBmdW5jdGlvbnMgdGFraW5nIHR4X3B0cl9sb2NrIG11c3QKZGlzYWJsZSBJUlFz
LCBhbmQgbWFjYl9zdGFydF94bWl0IG11c3Qgb25seSByZS1lbmFibGUgSVJRcyBpZiB0aGV5
CndlcmUgYWxyZWFkeSBlbmFibGVkLgoKRml4ZXM6IDEzOGJhZGJjMjFhMCAoIm5ldDogbWFj
YjogdXNlIE5BUEkgZm9yIFRYIGNvbXBsZXRpb24gcGF0aCIpClJlcG9ydGVkLWJ5OiBNaWtl
IEdhbGJyYWl0aCA8ZWZhdWx0QGdteC5kZT4KU2lnbmVkLW9mZi1ieTogU2VhbiBBbmRlcnNv
biA8c2Vhbi5hbmRlcnNvbkBsaW51eC5kZXY+Ci0tLQoKQ2hhbmdlcyBpbiB2MjoKLSBVc2Ug
aXJxc2F2ZS9yZXN0b3JlIGZvciBhbGwgYWNjZXNzZXMsIHNpbmNlIHRoZXkgY2FuIGFsc28g
YWxzbyBiZQogIGNhbGxlZCBmcm9tIG5ldHBvbGwuCgogZHJpdmVycy9uZXQvZXRoZXJuZXQv
Y2FkZW5jZS9tYWNiX21haW4uYyB8IDI4ICsrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jCmluZGV4IDE2ZDI4YThiM2I1
Ni4uYzc2OWI3ZGJkM2JhIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRl
bmNlL21hY2JfbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFj
Yl9tYWluLmMKQEAgLTEyMjMsMTIgKzEyMjMsMTMgQEAgc3RhdGljIGludCBtYWNiX3R4X2Nv
bXBsZXRlKHN0cnVjdCBtYWNiX3F1ZXVlICpxdWV1ZSwgaW50IGJ1ZGdldCkKIHsKIAlzdHJ1
Y3QgbWFjYiAqYnAgPSBxdWV1ZS0+YnA7CiAJdTE2IHF1ZXVlX2luZGV4ID0gcXVldWUgLSBi
cC0+cXVldWVzOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAJdW5zaWduZWQgaW50IHRhaWw7
CiAJdW5zaWduZWQgaW50IGhlYWQ7CiAJaW50IHBhY2tldHMgPSAwOwogCXUzMiBieXRlcyA9
IDA7CiAKLQlzcGluX2xvY2soJnF1ZXVlLT50eF9wdHJfbG9jayk7CisJc3Bpbl9sb2NrX2ly
cXNhdmUoJnF1ZXVlLT50eF9wdHJfbG9jaywgZmxhZ3MpOwogCWhlYWQgPSBxdWV1ZS0+dHhf
aGVhZDsKIAlmb3IgKHRhaWwgPSBxdWV1ZS0+dHhfdGFpbDsgdGFpbCAhPSBoZWFkICYmIHBh
Y2tldHMgPCBidWRnZXQ7IHRhaWwrKykgewogCQlzdHJ1Y3QgbWFjYl90eF9za2IJKnR4X3Nr
YjsKQEAgLTEyOTEsNyArMTI5Miw3IEBAIHN0YXRpYyBpbnQgbWFjYl90eF9jb21wbGV0ZShz
dHJ1Y3QgbWFjYl9xdWV1ZSAqcXVldWUsIGludCBidWRnZXQpCiAJICAgIENJUkNfQ05UKHF1
ZXVlLT50eF9oZWFkLCBxdWV1ZS0+dHhfdGFpbCwKIAkJICAgICBicC0+dHhfcmluZ19zaXpl
KSA8PSBNQUNCX1RYX1dBS0VVUF9USFJFU0goYnApKQogCQluZXRpZl93YWtlX3N1YnF1ZXVl
KGJwLT5kZXYsIHF1ZXVlX2luZGV4KTsKLQlzcGluX3VubG9jaygmcXVldWUtPnR4X3B0cl9s
b2NrKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZxdWV1ZS0+dHhfcHRyX2xvY2ssIGZs
YWdzKTsKIAogCXJldHVybiBwYWNrZXRzOwogfQpAQCAtMTcwNyw4ICsxNzA4LDkgQEAgc3Rh
dGljIHZvaWQgbWFjYl90eF9yZXN0YXJ0KHN0cnVjdCBtYWNiX3F1ZXVlICpxdWV1ZSkKIHsK
IAlzdHJ1Y3QgbWFjYiAqYnAgPSBxdWV1ZS0+YnA7CiAJdW5zaWduZWQgaW50IGhlYWRfaWR4
LCB0YnFwOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKLQlzcGluX2xvY2soJnF1ZXVlLT50
eF9wdHJfbG9jayk7CisJc3Bpbl9sb2NrX2lycXNhdmUoJnF1ZXVlLT50eF9wdHJfbG9jaywg
ZmxhZ3MpOwogCiAJaWYgKHF1ZXVlLT50eF9oZWFkID09IHF1ZXVlLT50eF90YWlsKQogCQln
b3RvIG91dF90eF9wdHJfdW5sb2NrOwpAQCAtMTcyMCwxOSArMTcyMiwyMCBAQCBzdGF0aWMg
dm9pZCBtYWNiX3R4X3Jlc3RhcnQoc3RydWN0IG1hY2JfcXVldWUgKnF1ZXVlKQogCWlmICh0
YnFwID09IGhlYWRfaWR4KQogCQlnb3RvIG91dF90eF9wdHJfdW5sb2NrOwogCi0Jc3Bpbl9s
b2NrX2lycSgmYnAtPmxvY2spOworCXNwaW5fbG9jaygmYnAtPmxvY2spOwogCW1hY2Jfd3Jp
dGVsKGJwLCBOQ1IsIG1hY2JfcmVhZGwoYnAsIE5DUikgfCBNQUNCX0JJVChUU1RBUlQpKTsK
LQlzcGluX3VubG9ja19pcnEoJmJwLT5sb2NrKTsKKwlzcGluX3VubG9jaygmYnAtPmxvY2sp
OwogCiBvdXRfdHhfcHRyX3VubG9jazoKLQlzcGluX3VubG9jaygmcXVldWUtPnR4X3B0cl9s
b2NrKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZxdWV1ZS0+dHhfcHRyX2xvY2ssIGZs
YWdzKTsKIH0KIAogc3RhdGljIGJvb2wgbWFjYl90eF9jb21wbGV0ZV9wZW5kaW5nKHN0cnVj
dCBtYWNiX3F1ZXVlICpxdWV1ZSkKIHsKIAlib29sIHJldHZhbCA9IGZhbHNlOworCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7CiAKLQlzcGluX2xvY2soJnF1ZXVlLT50eF9wdHJfbG9jayk7CisJ
c3Bpbl9sb2NrX2lycXNhdmUoJnF1ZXVlLT50eF9wdHJfbG9jaywgZmxhZ3MpOwogCWlmIChx
dWV1ZS0+dHhfaGVhZCAhPSBxdWV1ZS0+dHhfdGFpbCkgewogCQkvKiBNYWtlIGh3IGRlc2Ny
aXB0b3IgdXBkYXRlcyB2aXNpYmxlIHRvIENQVSAqLwogCQlybWIoKTsKQEAgLTE3NDAsNyAr
MTc0Myw3IEBAIHN0YXRpYyBib29sIG1hY2JfdHhfY29tcGxldGVfcGVuZGluZyhzdHJ1Y3Qg
bWFjYl9xdWV1ZSAqcXVldWUpCiAJCWlmIChtYWNiX3R4X2Rlc2MocXVldWUsIHF1ZXVlLT50
eF90YWlsKS0+Y3RybCAmIE1BQ0JfQklUKFRYX1VTRUQpKQogCQkJcmV0dmFsID0gdHJ1ZTsK
IAl9Ci0Jc3Bpbl91bmxvY2soJnF1ZXVlLT50eF9wdHJfbG9jayk7CisJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmcXVldWUtPnR4X3B0cl9sb2NrLCBmbGFncyk7CiAJcmV0dXJuIHJldHZh
bDsKIH0KIApAQCAtMjMwOCw2ICsyMzExLDcgQEAgc3RhdGljIG5ldGRldl90eF90IG1hY2Jf
c3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
KQogCXN0cnVjdCBtYWNiX3F1ZXVlICpxdWV1ZSA9ICZicC0+cXVldWVzW3F1ZXVlX2luZGV4
XTsKIAl1bnNpZ25lZCBpbnQgZGVzY19jbnQsIG5yX2ZyYWdzLCBmcmFnX3NpemUsIGY7CiAJ
dW5zaWduZWQgaW50IGhkcmxlbjsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOwogCWJvb2wgaXNf
bHNvOwogCW5ldGRldl90eF90IHJldCA9IE5FVERFVl9UWF9PSzsKIApAQCAtMjM2OCw3ICsy
MzcyLDcgQEAgc3RhdGljIG5ldGRldl90eF90IG1hY2Jfc3RhcnRfeG1pdChzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQogCQlkZXNjX2NudCArPSBESVZf
Uk9VTkRfVVAoZnJhZ19zaXplLCBicC0+bWF4X3R4X2xlbmd0aCk7CiAJfQogCi0Jc3Bpbl9s
b2NrX2JoKCZxdWV1ZS0+dHhfcHRyX2xvY2spOworCXNwaW5fbG9ja19pcnFzYXZlKCZxdWV1
ZS0+dHhfcHRyX2xvY2ssIGZsYWdzKTsKIAogCS8qIFRoaXMgaXMgYSBoYXJkIGVycm9yLCBs
b2cgaXQuICovCiAJaWYgKENJUkNfU1BBQ0UocXVldWUtPnR4X2hlYWQsIHF1ZXVlLT50eF90
YWlsLApAQCAtMjM5MiwxNSArMjM5NiwxNSBAQCBzdGF0aWMgbmV0ZGV2X3R4X3QgbWFjYl9z
dGFydF94bWl0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYp
CiAJbmV0ZGV2X3R4X3NlbnRfcXVldWUobmV0ZGV2X2dldF90eF9xdWV1ZShicC0+ZGV2LCBx
dWV1ZV9pbmRleCksCiAJCQkgICAgIHNrYi0+bGVuKTsKIAotCXNwaW5fbG9ja19pcnEoJmJw
LT5sb2NrKTsKKwlzcGluX2xvY2soJmJwLT5sb2NrKTsKIAltYWNiX3dyaXRlbChicCwgTkNS
LCBtYWNiX3JlYWRsKGJwLCBOQ1IpIHwgTUFDQl9CSVQoVFNUQVJUKSk7Ci0Jc3Bpbl91bmxv
Y2tfaXJxKCZicC0+bG9jayk7CisJc3Bpbl91bmxvY2soJmJwLT5sb2NrKTsKIAogCWlmIChD
SVJDX1NQQUNFKHF1ZXVlLT50eF9oZWFkLCBxdWV1ZS0+dHhfdGFpbCwgYnAtPnR4X3Jpbmdf
c2l6ZSkgPCAxKQogCQluZXRpZl9zdG9wX3N1YnF1ZXVlKGRldiwgcXVldWVfaW5kZXgpOwog
CiB1bmxvY2s6Ci0Jc3Bpbl91bmxvY2tfYmgoJnF1ZXVlLT50eF9wdHJfbG9jayk7CisJc3Bp
bl91bmxvY2tfaXJxcmVzdG9yZSgmcXVldWUtPnR4X3B0cl9sb2NrLCBmbGFncyk7CiAKIAly
ZXR1cm4gcmV0OwogfQotLSAKMi4zNS4xLjEzMjAuZ2M0NTI2OTUzODcuZGlydHkKCg==

--------------0a6RtEyOUbqPmlEsckM4giYv--

