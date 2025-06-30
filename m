Return-Path: <netdev+bounces-202624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED959AEE61C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D697E3B7726
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7BD28DB5E;
	Mon, 30 Jun 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="iH633Arn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6F23ABB1
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751305947; cv=none; b=u6OVfjmu/F2BuBroOYgVSfTYFS0JrQaQPqb/Rz/bJjqPJlgsILYvi+8gLLMxqwwJ1o7hs3vySWt6zEVc8Veu7/UMlrh01tK1P9VNaEg4vbwIUVxGVHTHcqge/B+QV4rk5G29NlFiJJNnrpiVQ3ZiltUT4sC/fgctr22K9GCn7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751305947; c=relaxed/simple;
	bh=1N5xLrxk9GoQacZGAZSwF1aR4ySTOr8ROVYq12+JXWg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=UmkuSpuEDEidwkBO/bOzUGwz/ZGAFK55VQuW58bUGftvqRDpdBWBqGPmS2tXw4gikeu66Rxo3QkgmOO1QAXPSbZLxlsyaZyFn/YemBhezZhH11ERT51PZ04Z7YQ2KWVNFQzV0J95UFIfjvJ9mopHr0CbWWoYhToLN38bdbh9g5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=iH633Arn; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-701046cfeefso16929286d6.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751305944; x=1751910744; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02Zam0e3KNqojJdnyqloOPyLPTfsNUfImxirSjgeMv0=;
        b=iH633ArnnTwyuG7DG+sSO6dK3FYTBM/YAhykYDX5DC4AY/5bBU53CcjAnc+MyTr4Ha
         36gSmxN1cyvXCJ0y55x3R5cZa+hZVS7NsfUxVc20w5+qbq2dLZdAeviCpnrWMvJMDcQH
         1aL9HgqN6uiq6PKsojME+no812gYTGbNIUyf5Fq8jlsKOQ8LAhpqyrEEIS0Hjyx4ksLz
         L6P3C3417UBEHqnB/uqVB3m7Sr7g7PEIfD0QuFTqwZ94AycV4ZsDTMedUU/IP2RVMs0Q
         8ppzaIqi4//BjwmBYIYP3brTgFc0tuSDmrwPCzpCV0qSoixtydT6LpsUxnBOysQMGWoj
         pwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751305944; x=1751910744;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=02Zam0e3KNqojJdnyqloOPyLPTfsNUfImxirSjgeMv0=;
        b=Z0uIAd83nG227eQM3gI+1gNEhp2kN5IQoIgKoepp6cFSQZZpJINZHMYOA9RBzBDePK
         0WM2aRsxWdih99bj+0NU9b+oW3zhrj0c9eRsKKU9tcH6sBJkjlZhboueFsrJo64w6HNi
         aTGc6NFASH/LaDvNH7+F+wj2htngb6fAQRiw4S0OdiK/jdVGRUZ1p/zRslFBHj9XAHPM
         Hq9JCjaF8rhQpwvxKxQCbFTo+Yaqbc9O8QM4WhRxyntmT3ni91tgQsS+FEuc/hIBp4QW
         lIzK6I22mx8wqPtGm3IrHF58/04rOo1gn5lcf+Jg6JkkLS6EAAHlJNXFwIc28am+wS8y
         +0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWx8bprASh0XU1orUhikWmYNK/sZJLizrMTR/sYfj5jZVnM7+cBhjq4UxzmOB5EJmCZkaJNBLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc8xxzcJGQgZ8f63iiYNHDP+ELnBeGNw75J59aHubrajHztTR2
	VWsrLAMU105nCGngy21Ka4fmRiHNHKPbx/x8A8LPQMps4Z8AWZXVg04M4FaxLCcocQ==
X-Gm-Gg: ASbGncvWlXHjEdvhtPkVQB8qHh8mwnfAZFpYt9Cb66bNY4N4xyovJh/xsU2N3ENI/uW
	U4yVxXtWTL0V8YTabCyhAMPc35BhM62JFmKheCsi6/6IV4jQld+iPu+BWNh3bybAlNE6OWMmq93
	IwyRlrx0xY5MMnPmzWgi9qPZUI1W9AUnNVJ2oygcilLlw/SUaJlxOD4CNscJ13qRN4fF66czSu/
	0BlRxjvkVVtvI4HHt7H6sfmv5ekLXsUKf4X1nOGAQ5Y2/SF80on7sPH/t4pIkxV7jjKb3ZRiR9v
	qUSxjo9bfO2Lw2Y+2QbVC2YZ5vdU7vpcDRNKw3pvZpHur/rDYeAla5V9ACuLvI5/4UYg44ziaM3
	urk7vF7q9S7ENd3QJvqmGA1ik1gZiIg==
X-Google-Smtp-Source: AGHT+IHRHYfXwfCIcleVAOzVdLMNonumxdDEu3UOlEsfIMtqZxBs/MJzZQIqFehSXVCtB63ypEVA+g==
X-Received: by 2002:a05:6214:3015:b0:6e8:ddf6:d11e with SMTP id 6a1803df08f44-70002247794mr217017546d6.21.1751305943584;
        Mon, 30 Jun 2025 10:52:23 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c1:ca4a:289:b941:38b9:cf01? ([2804:7f1:e2c1:ca4a:289:b941:38b9:cf01])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e434bsm71797996d6.67.2025.06.30.10.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 10:52:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------9XN1Kb46LNeDZwuePxkMKgGJ"
Message-ID: <442716ca-ae2e-4fac-8a01-ced3562fd588@mojatatu.com>
Date: Mon, 30 Jun 2025 14:52:19 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Jamal Hadi Salim <jhs@mojatatu.com>, Lion Ackermann <nnamrec@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>
References: <45876f14-cf28-4177-8ead-bb769fd9e57a@gmail.com>
 <aFosjBOUlOr0TKsd@pop-os.localdomain>
 <3af4930b-6773-4159-8a7a-e4f6f6ae8109@gmail.com>
 <5e4490da-3f6c-4331-af9c-0e6d32b6fc75@gmail.com>
 <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <aGGZBpA3Pn4ll7FO@pop-os.localdomain>
 <8e19395d-b6d6-47d4-9ce0-e2b59e109b2b@gmail.com>
 <CAM0EoMmoQuRER=eBUO+Th02yJUYvfCKu_g7Ppcg0trnA_m6v1Q@mail.gmail.com>
 <c13c3b00-cd15-4dcd-b060-eb731619034f@gmail.com>
 <CAM0EoMnwxMAdoPyqFVUPsNXE33ibw6O4_UE1TcWYUZKjwy3V6A@mail.gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAM0EoMnwxMAdoPyqFVUPsNXE33ibw6O4_UE1TcWYUZKjwy3V6A@mail.gmail.com>

This is a multi-part message in MIME format.
--------------9XN1Kb46LNeDZwuePxkMKgGJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/25 11:57, Jamal Hadi Salim wrote:
> On Mon, Jun 30, 2025 at 9:36 AM Lion Ackermann <nnamrec@gmail.com> wrote:
>>
>> Hi,
>>
>> On 6/30/25 1:34 PM, Jamal Hadi Salim wrote:
>>> Hi,
>>>
>>> On Mon, Jun 30, 2025 at 5:04 AM Lion Ackermann <nnamrec@gmail.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 6/29/25 9:50 PM, Cong Wang wrote:
>>>>> On Sun, Jun 29, 2025 at 10:29:44AM -0400, Jamal Hadi Salim wrote:
>>>>>>> On "What do you think the root cause is here?"
>>>>>>>
>>>>>>> I believe the root cause is that qdiscs like hfsc and qfq are dropping
>>>>>>> all packets in enqueue (mostly in relation to peek()) and that result
>>>>>>> is not being reflected in the return code returned to its parent
>>>>>>> qdisc.
>>>>>>> So, in the example you described in this thread, drr is oblivious to
>>>>>>> the fact that the child qdisc dropped its packet because the call to
>>>>>>> its child enqueue returned NET_XMIT_SUCCESS. This causes drr to
>>>>>>> activate a class that shouldn't have been activated at all.
>>>>>>>
>>>>>>> You can argue that drr (and other similar qdiscs) may detect this by
>>>>>>> checking the call to qlen_notify (as the drr patch was
>>>>>>> doing), but that seems really counter-intuitive. Imagine writing a new
>>>>>>> qdisc and having to check for that every time you call a child's
>>>>>>> enqueue. Sure  your patch solves this, but it also seems like it's not
>>>>>>> fixing the underlying issue (which is drr activating the class in the
>>>>>>> first place). Your patch is simply removing all the classes from their
>>>>>>> active lists when you delete them. And your patch may seem ok for now,
>>>>>>> but I am worried it might break something else in the future that we
>>>>>>> are not seeing.
>>>>>>>
>>>>>>> And do note: All of the examples of the hierarchy I have seen so far,
>>>>>>> that put us in this situation, are nonsensical
>>>>>>>
>>>>>>
>>>>>> At this point my thinking is to apply your patch and then we discuss a
>>>>>> longer term solution. Cong?
>>>>>
>>>>> I agree. If Lion's patch works, it is certainly much better as a bug fix
>>>>> for both -net and -stable.
>>>>>
>>>>> Also for all of those ->qlen_notify() craziness, I think we need to
>>>>> rethink about the architecture, _maybe_ there are better architectural
>>>>> solutions.
>>>>>
>>>>> Thanks!
>>>>
>>>> Just for the record, I agree with all your points and as was stated this
>>>> patch really only does damage prevention. Your proposal of preventing
>>>> hierarchies sounds useful in the long run to keep the backlogs sane.
>>>>
>>>> I did run all the tdc tests on the latest net tree and they passed. Also
>>>> my HFSC reproducer does not trigger with the proposed patch. I do not have
>>>> a simple reproducer at hand for the QFQ tree case that you mentioned. So
>>>> please verify this too if you can.
>>>>
>>>> Otherwise please feel free to go forward with the patch. If I can add
>>>> anything else to the discussion please let me know.
>>>>
>>>
>>> Please post the patch formally as per Cong request. A tdc test case of
>>> the reproducer would also help.
>>>
>>> cheers,
>>> jamal
>>
>> I sent a patch, though I am not terribly familiar with the tdc test case
>> infrastructure. If it is a no-op for you to translate the repro above into
>> the required format, please feel free to do that and post a patch for that.
>> Otherwise I can have a closer look at it tomorrow.
>>
> 
> We'll help out this time - but it is a good idea to for you to learn
> how to do it if you are going to keep finding issues on tc ;->

Lion, I attached a patch to this email that edits Cong's original tdc test
case to account for your reproducer. Please resend your patch with it (after
the 24 hour wait period).

cheers,
Victor

--------------9XN1Kb46LNeDZwuePxkMKgGJ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-selftests-tc-testing-Fix-test-case-831d-to-reproduce.patch"
Content-Disposition: attachment;
 filename*0="0001-selftests-tc-testing-Fix-test-case-831d-to-reproduce.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwMmI2NDNmNDc3N2M0Yzc4MjI3MTgzNGMwNWE0Zjk4OTM3OTc2N2EwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBWaWN0b3IgTm9ndWVpcmEgPHZpY3RvckBtb2phdGF0
dS5jb20+CkRhdGU6IE1vbiwgMzAgSnVuIDIwMjUgMTc6Mjc6NDQgKzAwMDAKU3ViamVjdDog
W1BBVENIIG5ldC1uZXh0XSBzZWxmdGVzdHMvdGMtdGVzdGluZzogRml4IHRlc3QgY2FzZSA4
MzFkIHRvIHJlcHJvZHVjZSBVQUYgc2NlbmFyaW8KCk1ha2UgdGVzdCBjYXNlIDgzMWQgZGVs
ZXRlIHRoZSBIRlNDIGNsYXNzIGFuZCB0aGVuIHNlbmQgcGFja2V0cyBzbyB0aGF0IGl0CmNh
biByZXByb2R1Y2UgdGhlIHJlcG9ydGVkIFVBRiBzY2VuYXJpbyBbMV0uCgpbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzQ1ODc2ZjE0LWNmMjgtNDE3Ny04ZWFkLWJiNzY5
ZmQ5ZTU3YUBnbWFpbC5jb20vCgpTaWduZWQtb2ZmLWJ5OiBWaWN0b3IgTm9ndWVpcmEgPHZp
Y3RvckBtb2phdGF0dS5jb20+Ci0tLQogLi4uL3RjLXRlc3RpbmcvdGMtdGVzdHMvaW5mcmEv
cWRpc2NzLmpzb24gICAgIHwgMzUgKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRlc3RpbmcvdGMtdGVzdHMvaW5mcmEvcWRpc2Nz
Lmpzb24gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90Yy10ZXN0aW5nL3RjLXRlc3RzL2lu
ZnJhL3FkaXNjcy5qc29uCmluZGV4IDlhYTQ0ZDgxNzZkOS4uMGQzOTc5MzM0YTRlIDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90Yy10ZXN0aW5nL3RjLXRlc3RzL2lu
ZnJhL3FkaXNjcy5qc29uCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RjLXRlc3Rp
bmcvdGMtdGVzdHMvaW5mcmEvcWRpc2NzLmpzb24KQEAgLTU4MCwyNiArNTgwLDIzIEBACiAg
ICAgICAgICJjYXRlZ29yeSI6IFsicWRpc2MiLCAiaGZzYyIsICJkcnIiLCAibmV0ZW0iLCAi
YmxhY2tob2xlIl0sCiAgICAgICAgICJwbHVnaW5zIjogeyAicmVxdWlyZXMiOiBbIm5zUGx1
Z2luIiwgInNjYXB5UGx1Z2luIl0gfSwKICAgICAgICAgInNldHVwIjogWwotICAgICAgICAg
ICAgIiRJUCBsaW5rIHNldCBkZXYgJERFVjEgdXAgfHwgdHJ1ZSIsCi0gICAgICAgICAgICAi
JFRDIHFkaXNjIGFkZCBkZXYgJERFVjEgcm9vdCBoYW5kbGUgMTogZHJyIiwKLSAgICAgICAg
ICAgICIkVEMgZmlsdGVyIGFkZCBkZXYgJERFVjEgcGFyZW50IDE6IGJhc2ljIGNsYXNzaWQg
MToxIiwKLSAgICAgICAgICAgICIkVEMgY2xhc3MgYWRkIGRldiAkREVWMSBwYXJlbnQgMTog
Y2xhc3NpZCAxOjEgZHJyIiwKLSAgICAgICAgICAgICIkVEMgcWRpc2MgYWRkIGRldiAkREVW
MSBwYXJlbnQgMToxIGhhbmRsZSAyOiBoZnNjIGRlZiAxIiwKLSAgICAgICAgICAgICIkVEMg
Y2xhc3MgYWRkIGRldiAkREVWMSBwYXJlbnQgMjogY2xhc3NpZCAyOjEgaGZzYyBydCBtMSA4
IGQgMSBtMiAwIiwKLSAgICAgICAgICAgICIkVEMgcWRpc2MgYWRkIGRldiAkREVWMSBwYXJl
bnQgMjoxIGhhbmRsZSAzOiBuZXRlbSIsCi0gICAgICAgICAgICAiJFRDIHFkaXNjIGFkZCBk
ZXYgJERFVjEgcGFyZW50IDM6MSBoYW5kbGUgNDogYmxhY2tob2xlIgorICAgICAgICAgICAg
IiRJUCBsaW5rIHNldCBkZXYgJERVTU1ZIHVwIHx8IHRydWUiLAorICAgICAgICAgICAgIiRJ
UCBhZGRyIGFkZCAxMC4xMC4xMS4xMC8yNCBkZXYgJERVTU1ZIHx8IHRydWUiLAorICAgICAg
ICAgICAgIiRUQyBxZGlzYyBhZGQgZGV2ICREVU1NWSByb290IGhhbmRsZSAxOiBkcnIiLAor
ICAgICAgICAgICAgIiRUQyBmaWx0ZXIgYWRkIGRldiAkRFVNTVkgcGFyZW50IDE6IGJhc2lj
IGNsYXNzaWQgMToxIiwKKyAgICAgICAgICAgICIkVEMgY2xhc3MgYWRkIGRldiAkRFVNTVkg
cGFyZW50IDE6IGNsYXNzaWQgMToxIGRyciIsCisgICAgICAgICAgICAiJFRDIHFkaXNjIGFk
ZCBkZXYgJERVTU1ZIHBhcmVudCAxOjEgaGFuZGxlIDI6IGhmc2MgZGVmIDEiLAorICAgICAg
ICAgICAgIiRUQyBjbGFzcyBhZGQgZGV2ICREVU1NWSBwYXJlbnQgMjogY2xhc3NpZCAyOjEg
aGZzYyBydCBtMSA4IGQgMSBtMiAwIiwKKyAgICAgICAgICAgICIkVEMgcWRpc2MgYWRkIGRl
diAkRFVNTVkgcGFyZW50IDI6MSBoYW5kbGUgMzogbmV0ZW0iLAorICAgICAgICAgICAgIiRU
QyBxZGlzYyBhZGQgZGV2ICREVU1NWSBwYXJlbnQgMzoxIGhhbmRsZSA0OiBibGFja2hvbGUi
LAorICAgICAgICAgICAgInBpbmcgLWMxIC1XMC4wMSAtSSAkRFVNTVkgMTAuMTAuMTEuMTEg
fHwgdHJ1ZSIsCisgICAgICAgICAgICAiJFRDIGNsYXNzIGRlbCBkZXYgJERVTU1ZIGNsYXNz
aWQgMToxIgogICAgICAgICBdLAotICAgICAgICAic2NhcHkiOiB7Ci0gICAgICAgICAgICAi
aWZhY2UiOiAiJERFVjAiLAotICAgICAgICAgICAgImNvdW50IjogNSwKLSAgICAgICAgICAg
ICJwYWNrZXQiOiAiRXRoZXIoKS9JUChkc3Q9JzEwLjEwLjEwLjEnLCBzcmM9JzEwLjEwLjEw
LjEwJykvSUNNUCgpIgotICAgICAgICB9LAotICAgICAgICAiY21kVW5kZXJUZXN0IjogIiRU
QyAtcyBxZGlzYyBzaG93IGRldiAkREVWMSIsCi0gICAgICAgICJleHBFeGl0Q29kZSI6ICIw
IiwKLSAgICAgICAgInZlcmlmeUNtZCI6ICIkVEMgLXMgcWRpc2Mgc2hvdyBkZXYgJERFVjEi
LAotICAgICAgICAibWF0Y2hQYXR0ZXJuIjogInFkaXNjIGhmc2MiLAotICAgICAgICAibWF0
Y2hDb3VudCI6ICIxIiwKLSAgICAgICAgInRlYXJkb3duIjogWyIkVEMgcWRpc2MgZGVsIGRl
diAkREVWMSByb290IGhhbmRsZSAxOiBkcnIiXQorICAgICAgICAiY21kVW5kZXJUZXN0Ijog
InBpbmcgLWMxIC1XMC4wMSAtSSAkRFVNTVkgMTAuMTAuMTEuMTEiLAorICAgICAgICAiZXhw
RXhpdENvZGUiOiAiMSIsCisgICAgICAgICJ2ZXJpZnlDbWQiOiAiJFRDIC1qIGNsYXNzIGxz
IGRldiAkRFVNTVkgY2xhc3NpZCAxOjEiLAorICAgICAgICAibWF0Y2hKU09OIjogW10sCisg
ICAgICAgICJ0ZWFyZG93biI6IFsiJFRDIHFkaXNjIGRlbCBkZXYgJERVTU1ZIHJvb3QgaGFu
ZGxlIDE6IGRyciJdCiAgICAgfSwKICAgICB7CiAgICAgICAgICJpZCI6ICIzMDllIiwKLS0g
CjIuMzQuMQoK

--------------9XN1Kb46LNeDZwuePxkMKgGJ--

