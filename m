Return-Path: <netdev+bounces-105740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83F9128EF
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5B81C266F9
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7167481A7;
	Fri, 21 Jun 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4GnPINK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011057C9A;
	Fri, 21 Jun 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982426; cv=none; b=tiDsHpPil5O1QDOWecYdXG0SLU75WAV4YglxJw8jftuuAeGqennmesfXoYrIgtCt9Crx+/YMQsdg04szZFuEooPOJOkUzN2czJ6Vnsc8cyReK4yYZY4m6qL8JJQbLDXkL6qbYJ1vUwPar2qPRN/lBgPK2J88KS7p2Z+dHDrTWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982426; c=relaxed/simple;
	bh=Ur/WZykXXu7kvz1N6Q9t83YQn0E8IANcZlc+7X8SUvA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=brYyF24pZuwxJxGumJ6HDV7uxwd3r8B7LLo1+Q0kTgtwZGUmWj6TPIVwPv6Gu6qC6APiOQQrg6lVVrOGtNTTbXGA5os01HjrseLbOvEI6JxzNskc2Vx3q9H4BpYr4UHfAV7qdw7QQuYHfkkIuTitAvNNyNjG4gN+8c4z7ycT0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4GnPINK; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-713fa1aea36so1122245a12.1;
        Fri, 21 Jun 2024 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718982424; x=1719587224; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkpV64ctwY5CIG+UWpeGfk1eKHCUDAmjqYGVIxw/wSo=;
        b=l4GnPINKQb4KqZGaMd98Lkmt20eAD0+TrKSwH+uFJF2vTbaIB0Mmg3DC6fPrhz2gPQ
         IOYq34h+OUo1D9cxkBVTlnxd6YdP0lbIl7vSpYJ7pz5M1U4PwtMgSAd4OkbFoqBAGMf8
         LTHcPOVDfHSiurNq9+RzjjjU/k2wiV4ey35jlO5Bi/fJaCaFdeANCYU+ZDDooyiW9gl9
         hmKDiVRrwxjWl31Kl/aJu2mTidgY0KqPoI6MtE9gaXYCklJNg3F+YRmsJ0bCd0Z9w/oT
         x/pUj0sRN1eeOtWHvBFKTCYezeoXBK3VHoSWoRGCdUUaKEXjthNe9X7JdLux41Nvc5Cv
         OGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982424; x=1719587224;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkpV64ctwY5CIG+UWpeGfk1eKHCUDAmjqYGVIxw/wSo=;
        b=bbwo+TJ8CbjBoAyP2UAoOpZGKQhTVl+/UKmm7Gybtzr/i+exPsoRCF9BLAaGp4DhuQ
         H4EstExhbeq4aX6DfqZn4hN180HdBBgiNAkzfYeDIZVE3ypzFx8zi5wKKdhFI05ujyG4
         GcMfZTYH+VdBIwByITaHmNyyNxa8ecxYY6v+qcWlsFegnpgXmrR+E6insYKrvoHI1jvw
         OuFYcIzu+whjq9nF6HkdrhcOmEVrFQ72hAOfH2lRuB934DMsmx+h+/OlQ5TVw1336v7I
         TWEXsGJiG4VCBeWoUK5aaW+VLRQ5uE/WBQ8Xf0Q14l5YZIRUdwXzWZCm7wh2zNVK7wYd
         jrMg==
X-Forwarded-Encrypted: i=1; AJvYcCVtTG67NIec9olgx9gLQP27FCpjVw7AAaqtNFJ0y0yHDkPivdYyXtRS0pu20IpyuzjFurRd9OkmH1pvRStZeu2owbCq41YINglJ177hbDQ36upmfE4n18OuWcoe1zWw8NfNk3q6XA0UICLLmfnMc2fwOzykh8yRn+qW34YtMqvJCrK4lgSUnVWs
X-Gm-Message-State: AOJu0YzJA/2wWviFXJg9xvKQchmJvS8ZF2NeQUKirW3TvNB3BRKZm1YB
	I/w2f1bVk7wHGo8qymNzWEOne1IEL/wI+E4ZPc43L3uaUUGJ+mOi
X-Google-Smtp-Source: AGHT+IHFXUrN2nZPXIqAiHr1YahZpni8ZGnuf0rChQDrUMM1FOwKRRYkHGp/+6IQihm+52VYaq4IVw==
X-Received: by 2002:a17:90b:3d8:b0:2c7:ab00:f605 with SMTP id 98e67ed59e1d1-2c7b5cc6b21mr8957543a91.20.1718982423772;
        Fri, 21 Jun 2024 08:07:03 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9c39sm3725419a91.46.2024.06.21.08.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 08:07:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------tz0mDvnFYLERuADC9gvRwthr"
Message-ID: <23f571cd-aaf6-46d9-a2b1-38e7b6a1f908@gmail.com>
Date: Sat, 22 Jun 2024 00:06:56 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qdisc: fix NULL pointer dereference in
 perf_trace_qdisc_reset()
To: Pedro Tammela <pctammela@mojatatu.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Takashi Iwai <tiwai@suse.de>, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Taehee Yoo <ap420073@gmail.com>, Austin Kim <austindh.kim@gmail.com>,
 shjy180909@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pbuk5246@gmail.com
References: <20240621114551.2061-3-yskelg@gmail.com>
 <f2ff57c9-1c10-429f-8739-39743bf58daf@mojatatu.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <f2ff57c9-1c10-429f-8739-39743bf58daf@mojatatu.com>

This is a multi-part message in MIME format.
--------------tz0mDvnFYLERuADC9gvRwthr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Pedro,

On 6/21/24 11:24 오후, Pedro Tammela wrote:
> On 21/06/2024 08:45, yskelg@gmail.com wrote:
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from
>>
>>   qdisc->dev_queue->dev <NULL> ->name
>>
>> This situation simulated from bunch of veths and Bluetooth
>> dis/reconnection.
>>
>> During qdisc initialization, qdisc was being set to noop_queue.
>> In veth_init_queue, the initial tx_num was reduced back to one,
>> causing the qdisc reset to be called with noop, which led to the
>> kernel panic.
>>
>> I think this will happen on the kernel version.
>>   Linux kernel version ≥ v6.7.10, ≥ v6.8 ≥ v6.9 and 6.10
> 
> You should tag your patch for the net tree
Thank you for the code review, I will tag the next patch for the net tree.

>> This occurred from 51270d573a8d. I think this patch is absolutely
>> necessary. Previously, It was showing not intended string value of name.
> Add a 'Fixes:' tag with this commit

I will added 'Fixes: 51270d573a8d' Tag on patch v2 message.

>> I can attach a sys-execprog's executing program, kernel dump and dmesg
>> if someone need it, but I'm not sure how to safely attach large vmcore
>> with vmlinux.
> 
> The syzkaller program + C reproducer is usually enough, please make it
> visible somewhere

I got it, I have a converted C syz program. So, I've attached the GitHub
gist link and C source code in this mail.

 https://gist.github.com/yskelg/cc64562873ce249cdd0d5a358b77d740

>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>, Yeoreum Yun
>> <yeoreum.yun@arm.com>
> 
> Should be two SoB tags

Oh, It's the first time we've sent together, I made a mistake.. Sorry.
Thank you Pedro for the advice!

>> ---
>>   include/trace/events/qdisc.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
>> index f1b5e816e7e5..170b51fbe47a 100644
>> --- a/include/trace/events/qdisc.h
>> +++ b/include/trace/events/qdisc.h
>> @@ -81,7 +81,7 @@ TRACE_EVENT(qdisc_reset,
>>       TP_ARGS(q),
>>         TP_STRUCT__entry(
>> -        __string(    dev,        qdisc_dev(q)->name    )
>> +        __string(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "noop_queue")
>>           __string(    kind,        q->ops->id        )
>>           __field(    u32,        parent            )
>>           __field(    u32,        handle            )
> 


Warm Regards,
Yunseong Kim
--------------tz0mDvnFYLERuADC9gvRwthr
Content-Type: text/plain; charset=UTF-8; name="qdisc-null-ptr-deref.c"
Content-Disposition: attachment; filename="qdisc-null-ptr-deref.c"
Content-Transfer-Encoding: base64

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29n
bGUvc3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGVuZGlhbi5o
PgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3Rk
bGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiNp
bmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKI2lmbmRlZiBfX05S
X2FkZF9rZXkKI2RlZmluZSBfX05SX2FkZF9rZXkgMjE3CiNlbmRpZgojaWZuZGVmIF9fTlJf
YnBmCiNkZWZpbmUgX19OUl9icGYgMjgwCiNlbmRpZgojaWZuZGVmIF9fTlJfaW9fdXJpbmdf
cmVnaXN0ZXIKI2RlZmluZSBfX05SX2lvX3VyaW5nX3JlZ2lzdGVyIDQyNwojZW5kaWYKI2lm
bmRlZiBfX05SX2lvX3VyaW5nX3NldHVwCiNkZWZpbmUgX19OUl9pb191cmluZ19zZXR1cCA0
MjUKI2VuZGlmCiNpZm5kZWYgX19OUl9rZXljdGwKI2RlZmluZSBfX05SX2tleWN0bCAyMTkK
I2VuZGlmCiNpZm5kZWYgX19OUl9tbG9ja2FsbAojZGVmaW5lIF9fTlJfbWxvY2thbGwgMjMw
CiNlbmRpZgojaWZuZGVmIF9fTlJfbW1hcAojZGVmaW5lIF9fTlJfbW1hcCAyMjIKI2VuZGlm
CiNpZm5kZWYgX19OUl9tcmVtYXAKI2RlZmluZSBfX05SX21yZW1hcCAyMTYKI2VuZGlmCiNp
Zm5kZWYgX19OUl9tdW5tYXAKI2RlZmluZSBfX05SX211bm1hcCAyMTUKI2VuZGlmCiNpZm5k
ZWYgX19OUl9vcGVuYXQKI2RlZmluZSBfX05SX29wZW5hdCA1NgojZW5kaWYKI2lmbmRlZiBf
X05SX3JlYWQKI2RlZmluZSBfX05SX3JlYWQgNjMKI2VuZGlmCiNpZm5kZWYgX19OUl9zaG1j
dGwKI2RlZmluZSBfX05SX3NobWN0bCAxOTUKI2VuZGlmCgojZGVmaW5lIEJJVE1BU0soYmZf
b2ZmLCBiZl9sZW4pICgoKDF1bGwgPDwgKGJmX2xlbikpIC0gMSkgPDwgKGJmX29mZikpCiNk
ZWZpbmUgU1RPUkVfQllfQklUTUFTSyh0eXBlLCBodG9iZSwgYWRkciwgdmFsLCBiZl9vZmYs
IGJmX2xlbikgICAgICAgICAgICAgICBcCiAgKih0eXBlKikoYWRkcikgPSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAg
ICAgIGh0b2JlKChodG9iZSgqKHR5cGUqKShhZGRyKSkgJiB+QklUTUFTSygoYmZfb2ZmKSwg
KGJmX2xlbikpKSB8ICAgICAgICAgICBcCiAgICAgICAgICAgICgoKHR5cGUpKHZhbCkgPDwg
KGJmX29mZikpICYgQklUTUFTSygoYmZfb2ZmKSwgKGJmX2xlbikpKSkKCnVpbnQ2NF90IHJb
N10gPSB7MHhmZmZmZmZmZmZmZmZmZmZmLAogICAgICAgICAgICAgICAgIDB4ZmZmZmZmZmZm
ZmZmZmZmZiwKICAgICAgICAgICAgICAgICAweGZmZmZmZmZmZmZmZmZmZmYsCiAgICAgICAg
ICAgICAgICAgMHgwLAogICAgICAgICAgICAgICAgIDB4ZmZmZmZmZmZmZmZmZmZmZiwKICAg
ICAgICAgICAgICAgICAweGZmZmZmZmZmZmZmZmZmZmYsCiAgICAgICAgICAgICAgICAgMHgw
fTsKCmludCBtYWluKHZvaWQpCnsKICBzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgx
ZmZmZjAwMHVsLCAvKmxlbj0qLzB4MTAwMHVsLCAvKnByb3Q9Ki8wdWwsCiAgICAgICAgICAv
KmZsYWdzPU1BUF9GSVhFRHxNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFKi8gMHgzMnVsLCAv
KmZkPSovLTEsCiAgICAgICAgICAvKm9mZnNldD0qLzB1bCk7CiAgc3lzY2FsbChfX05SX21t
YXAsIC8qYWRkcj0qLzB4MjAwMDAwMDB1bCwgLypsZW49Ki8weDEwMDAwMDB1bCwKICAgICAg
ICAgIC8qcHJvdD1QUk9UX1dSSVRFfFBST1RfUkVBRHxQUk9UX0VYRUMqLyA3dWwsCiAgICAg
ICAgICAvKmZsYWdzPU1BUF9GSVhFRHxNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFKi8gMHgz
MnVsLCAvKmZkPSovLTEsCiAgICAgICAgICAvKm9mZnNldD0qLzB1bCk7CiAgc3lzY2FsbChf
X05SX21tYXAsIC8qYWRkcj0qLzB4MjEwMDAwMDB1bCwgLypsZW49Ki8weDEwMDB1bCwgLypw
cm90PSovMHVsLAogICAgICAgICAgLypmbGFncz1NQVBfRklYRUR8TUFQX0FOT05ZTU9VU3xN
QVBfUFJJVkFURSovIDB4MzJ1bCwgLypmZD0qLy0xLAogICAgICAgICAgLypvZmZzZXQ9Ki8w
dWwpOwogIGNvbnN0IGNoYXIqIHJlYXNvbjsKICAodm9pZClyZWFzb247CiAgaW50cHRyX3Qg
cmVzID0gMDsKICBpZiAod3JpdGUoMSwgImV4ZWN1dGluZyBwcm9ncmFtXG4iLCBzaXplb2Yo
ImV4ZWN1dGluZyBwcm9ncmFtXG4iKSAtIDEpKSB7CiAgfQogICoodWludDMyX3QqKTB4MjAw
MDAwMDQgPSAwOwogICoodWludDMyX3QqKTB4MjAwMDAwMDggPSAwOwogICoodWludDMyX3Qq
KTB4MjAwMDAwMGMgPSAwOwogICoodWludDMyX3QqKTB4MjAwMDAwMTAgPSAwOwogICoodWlu
dDMyX3QqKTB4MjAwMDAwMTggPSAtMTsKICBtZW1zZXQoKHZvaWQqKTB4MjAwMDAwMWMsIDAs
IDEyKTsKICByZXMgPQogICAgICBzeXNjYWxsKF9fTlJfaW9fdXJpbmdfc2V0dXAsIC8qZW50
cmllcz0qLzB4ZTY4LCAvKnBhcmFtcz0qLzB4MjAwMDAwMDB1bCk7CiAgaWYgKHJlcyAhPSAt
MSkKICAgIHJbMF0gPSByZXM7CiAgbWVtc2V0KCh2b2lkKikweDIwMDAwMDgwLCAxMTEsIDEp
OwogIHN5c2NhbGwoX19OUl9pb191cmluZ19yZWdpc3RlciwgLypmZD0qL3JbMF0sIC8qb3Bj
b2RlPSovMHhhdWwsCiAgICAgICAgICAvKmFyZz0qLzB4MjAwMDAwODB1bCwgLypzaXplPSov
MXVsKTsKICBzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgyMDAwMDAwMHVsLCAvKmxl
bj0qLzB4YTAwMHVsLCAvKnByb3Q9Ki8wdWwsCiAgICAgICAgICAvKmZsYWdzPU1BUF9GSVhF
RHxNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFKi8gMHgzMnVsLCAvKmZkPSovLTEsCiAgICAg
ICAgICAvKm9mZnNldD0qLzB1bCk7CiAgcmVzID0gc3lzY2FsbChfX05SX2JwZiwgLypjbWQ9
Ki8wdWwsIC8qYXJnPSovMHVsLAogICAgICAgICAgICAgICAgLypzaXplPSovMHhmZmZmZmZm
ZmZmZmZmYzkxdWwpOwogIGlmIChyZXMgIT0gLTEpCiAgICByWzFdID0gcmVzOwogICoodWlu
dDMyX3QqKTB4MjAwMDAwYzAgPSAtMTsKICAqKHVpbnQzMl90KikweDIwMDAwMGM0ID0gMDsK
ICByZXMgPSBzeXNjYWxsKF9fTlJfYnBmLCAvKmNtZD0qLzB4MjF1bCwgLyphcmc9Ki8weDIw
MDAwMGMwdWwsIC8qc2l6ZT0qLzh1bCk7CiAgaWYgKHJlcyAhPSAtMSkKICAgIHJbMl0gPSBy
ZXM7CiAgKih1aW50MzJfdCopMHgyMDAwMGM4MCA9IC0xOwogICoodWludDMyX3QqKTB4MjAw
MDBjODQgPSAweDIwOwogICoodWludDY0X3QqKTB4MjAwMDBjODggPSAweDIwMDAwMjgwOwog
ICoodWludDY0X3QqKTB4MjAwMDAyODAgPSAweDIwMDAwMTgwOwogICoodWludDMyX3QqKTB4
MjAwMDAyODggPSAweDk1OwogICoodWludDY0X3QqKTB4MjAwMDAyOTAgPSAweDIwMDAwYjgw
OwogIHJlcyA9IHN5c2NhbGwoX19OUl9icGYsIC8qY21kPSovMHhmdWwsIC8qYXJnPSovMHgy
MDAwMGM4MHVsLCAvKnNpemU9Ki8weDEwdWwpOwogIGlmIChyZXMgIT0gLTEpCiAgICByWzNd
ID0gKih1aW50MzJfdCopMHgyMDAwMDI4YzsKICBtZW1jcHkoKHZvaWQqKTB4MjAwMDAwNDAs
ICIuL2ZpbGUxXDAwMCIsIDgpOwogIHJlcyA9IHN5c2NhbGwoX19OUl9vcGVuYXQsIC8qZmQ9
Ki8weGZmZmZmZjljLCAvKmZpbGU9Ki8weDIwMDAwMDQwdWwsCiAgICAgICAgICAgICAgICAv
KmZsYWdzPSovMHVsLCAvKm1vZGU9Ki8wdWwpOwogIGlmIChyZXMgIT0gLTEpCiAgICByWzRd
ID0gcmVzOwogIHN5c2NhbGwoX19OUl9yZWFkLCAvKmZkPSovcls0XSwgLypidWY9Ki8wdWws
IC8qY291bnQ9Ki8wdWwpOwogICoodWludDMyX3QqKTB4MjAwMDBjYzAgPSAweDFiOwogICoo
dWludDMyX3QqKTB4MjAwMDBjYzQgPSAwOwogICoodWludDMyX3QqKTB4MjAwMDBjYzggPSAw
OwogICoodWludDMyX3QqKTB4MjAwMDBjY2MgPSAweDlmZjsKICAqKHVpbnQzMl90KikweDIw
MDAwY2QwID0gMDsKICAqKHVpbnQzMl90KikweDIwMDAwY2Q0ID0gclsxXTsKICAqKHVpbnQz
Ml90KikweDIwMDAwY2Q4ID0gMDsKICBtZW1zZXQoKHZvaWQqKTB4MjAwMDBjZGMsIDAsIDE2
KTsKICAqKHVpbnQzMl90KikweDIwMDAwY2VjID0gMDsKICAqKHVpbnQzMl90KikweDIwMDAw
Y2YwID0gLTE7CiAgKih1aW50MzJfdCopMHgyMDAwMGNmNCA9IDQ7CiAgKih1aW50MzJfdCop
MHgyMDAwMGNmOCA9IDQ7CiAgKih1aW50MzJfdCopMHgyMDAwMGNmYyA9IDQ7CiAgKih1aW50
NjRfdCopMHgyMDAwMGQwMCA9IDA7CiAgcmVzID0gc3lzY2FsbChfX05SX2JwZiwgLypjbWQ9
Ki8wdWwsIC8qYXJnPSovMHgyMDAwMGNjMHVsLCAvKnNpemU9Ki8weDQ4dWwpOwogIGlmIChy
ZXMgIT0gLTEpCiAgICByWzVdID0gcmVzOwogICoodWludDMyX3QqKTB4MjAwMDBlMDAgPSAw
OwogICoodWludDMyX3QqKTB4MjAwMDBlMDQgPSA2OwogICoodWludDY0X3QqKTB4MjAwMDBl
MDggPSAweDIwMDAwMDQwOwogICoodWludDhfdCopMHgyMDAwMDA0MCA9IDB4MTg7CiAgU1RP
UkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDAwNDEsIDcsIDAsIDQpOwogIFNUT1JF
X0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwMDQxLCA0LCA0LCA0KTsKICAqKHVpbnQx
Nl90KikweDIwMDAwMDQyID0gMDsKICAqKHVpbnQzMl90KikweDIwMDAwMDQ0ID0gNDsKICAq
KHVpbnQ4X3QqKTB4MjAwMDAwNDggPSAwOwogICoodWludDhfdCopMHgyMDAwMDA0OSA9IDA7
CiAgKih1aW50MTZfdCopMHgyMDAwMDA0YSA9IDA7CiAgKih1aW50MzJfdCopMHgyMDAwMDA0
YyA9IDA7CiAgU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDAwNTAsIDQsIDAs
IDMpOwogIFNUT1JFX0JZX0JJVE1BU0sodWludDhfdCwgLCAweDIwMDAwMDUwLCAxLCAzLCAx
KTsKICBTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3QsICwgMHgyMDAwMDA1MCwgMCwgNCwgNCk7
CiAgU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDAwNTEsIDB4YSwgMCwgNCk7
CiAgU1RPUkVfQllfQklUTUFTSyh1aW50OF90LCAsIDB4MjAwMDAwNTEsIDAsIDQsIDQpOwog
ICoodWludDE2X3QqKTB4MjAwMDAwNTIgPSAweGM7CiAgKih1aW50MzJfdCopMHgyMDAwMDA1
NCA9IDA7CiAgKih1aW50OF90KikweDIwMDAwMDU4ID0gMHgxODsKICBTVE9SRV9CWV9CSVRN
QVNLKHVpbnQ4X3QsICwgMHgyMDAwMDA1OSwgMCwgMCwgNCk7CiAgU1RPUkVfQllfQklUTUFT
Syh1aW50OF90LCAsIDB4MjAwMDAwNTksIDQsIDQsIDQpOwogICoodWludDE2X3QqKTB4MjAw
MDAwNWEgPSAwOwogICoodWludDMyX3QqKTB4MjAwMDAwNWMgPSA1OwogICoodWludDhfdCop
MHgyMDAwMDA2MCA9IDA7CiAgKih1aW50OF90KikweDIwMDAwMDYxID0gMDsKICAqKHVpbnQx
Nl90KikweDIwMDAwMDYyID0gMDsKICAqKHVpbnQzMl90KikweDIwMDAwMDY0ID0gMDsKICAq
KHVpbnQ4X3QqKTB4MjAwMDAwNjggPSAweDg1OwogIFNUT1JFX0JZX0JJVE1BU0sodWludDhf
dCwgLCAweDIwMDAwMDY5LCAwLCAwLCA0KTsKICBTVE9SRV9CWV9CSVRNQVNLKHVpbnQ4X3Qs
ICwgMHgyMDAwMDA2OSwgMSwgNCwgNCk7CiAgKih1aW50MTZfdCopMHgyMDAwMDA2YSA9IDA7
CiAgKih1aW50MzJfdCopMHgyMDAwMDA2YyA9IDB4ZmZmZmZmZjk7CiAgKih1aW50NjRfdCop
MHgyMDAwMGUxMCA9IDB4MjAwMDAwODA7CiAgbWVtY3B5KCh2b2lkKikweDIwMDAwMDgwLCAi
R1BMXDAwMCIsIDQpOwogICoodWludDMyX3QqKTB4MjAwMDBlMTggPSAzOwogICoodWludDMy
X3QqKTB4MjAwMDBlMWMgPSAwOwogICoodWludDY0X3QqKTB4MjAwMDBlMjAgPSAwOwogICoo
dWludDMyX3QqKTB4MjAwMDBlMjggPSAweDQxMTAwOwogICoodWludDMyX3QqKTB4MjAwMDBl
MmMgPSAweDUwOwogIG1lbXNldCgodm9pZCopMHgyMDAwMGUzMCwgMCwgMTYpOwogICoodWlu
dDMyX3QqKTB4MjAwMDBlNDAgPSAwOwogICoodWludDMyX3QqKTB4MjAwMDBlNDQgPSAweDIx
OwogICoodWludDMyX3QqKTB4MjAwMDBlNDggPSByWzJdOwogICoodWludDMyX3QqKTB4MjAw
MDBlNGMgPSA4OwogICoodWludDY0X3QqKTB4MjAwMDBlNTAgPSAweDIwMDAwMTAwOwogICoo
dWludDMyX3QqKTB4MjAwMDAxMDAgPSAzOwogICoodWludDMyX3QqKTB4MjAwMDAxMDQgPSA1
OwogICoodWludDMyX3QqKTB4MjAwMDBlNTggPSA4OwogICoodWludDMyX3QqKTB4MjAwMDBl
NWMgPSAweDEwOwogICoodWludDY0X3QqKTB4MjAwMDBlNjAgPSAweDIwMDAwMTQwOwogICoo
dWludDMyX3QqKTB4MjAwMDAxNDAgPSAzOwogICoodWludDMyX3QqKTB4MjAwMDAxNDQgPSA5
OwogICoodWludDMyX3QqKTB4MjAwMDAxNDggPSAweDYyOwogICoodWludDMyX3QqKTB4MjAw
MDAxNGMgPSAweDUwMzg7CiAgKih1aW50MzJfdCopMHgyMDAwMGU2OCA9IDB4MTA7CiAgKih1
aW50MzJfdCopMHgyMDAwMGU2YyA9IHJbM107CiAgKih1aW50MzJfdCopMHgyMDAwMGU3MCA9
IHJbNF07CiAgKih1aW50MzJfdCopMHgyMDAwMGU3NCA9IDU7CiAgKih1aW50NjRfdCopMHgy
MDAwMGU3OCA9IDB4MjAwMDBkNDA7CiAgKih1aW50MzJfdCopMHgyMDAwMGQ0MCA9IHJbMV07
CiAgKih1aW50MzJfdCopMHgyMDAwMGQ0NCA9IHJbMV07CiAgKih1aW50MzJfdCopMHgyMDAw
MGQ0OCA9IHJbNV07CiAgKih1aW50NjRfdCopMHgyMDAwMGU4MCA9IDB4MjAwMDBkODA7CiAg
Kih1aW50MzJfdCopMHgyMDAwMGQ4MCA9IDI7CiAgKih1aW50MzJfdCopMHgyMDAwMGQ4NCA9
IDM7CiAgKih1aW50MzJfdCopMHgyMDAwMGQ4OCA9IDI7CiAgKih1aW50MzJfdCopMHgyMDAw
MGQ4YyA9IDc7CiAgKih1aW50MzJfdCopMHgyMDAwMGQ5MCA9IDA7CiAgKih1aW50MzJfdCop
MHgyMDAwMGQ5NCA9IDU7CiAgKih1aW50MzJfdCopMHgyMDAwMGQ5OCA9IDc7CiAgKih1aW50
MzJfdCopMHgyMDAwMGQ5YyA9IDc7CiAgKih1aW50MzJfdCopMHgyMDAwMGRhMCA9IDQ7CiAg
Kih1aW50MzJfdCopMHgyMDAwMGRhNCA9IDQ7CiAgKih1aW50MzJfdCopMHgyMDAwMGRhOCA9
IDY7CiAgKih1aW50MzJfdCopMHgyMDAwMGRhYyA9IDB4YTsKICAqKHVpbnQzMl90KikweDIw
MDAwZGIwID0gMjsKICAqKHVpbnQzMl90KikweDIwMDAwZGI0ID0gNTsKICAqKHVpbnQzMl90
KikweDIwMDAwZGI4ID0gNzsKICAqKHVpbnQzMl90KikweDIwMDAwZGJjID0gNzsKICAqKHVp
bnQzMl90KikweDIwMDAwZGMwID0gNDsKICAqKHVpbnQzMl90KikweDIwMDAwZGM0ID0gMTsK
ICAqKHVpbnQzMl90KikweDIwMDAwZGM4ID0gMHhmOwogICoodWludDMyX3QqKTB4MjAwMDBk
Y2MgPSA4OwogICoodWludDMyX3QqKTB4MjAwMDBlODggPSAweDEwOwogICoodWludDMyX3Qq
KTB4MjAwMDBlOGMgPSAweDQ2ZjsKICBzeXNjYWxsKF9fTlJfYnBmLCAvKmNtZD0qLzV1bCwg
Lyphcmc9Ki8weDIwMDAwZTAwdWwsIC8qc2l6ZT0qLzB4OTB1bCk7CiAgbWVtY3B5KCh2b2lk
KikweDIwMDAwMDAwLCAiYXN5bW1ldHJpY1wwMDAiLCAxMSk7CiAgbWVtY3B5KCh2b2lkKikw
eDIwMDAwMjQwLCAic3l6IiwgMyk7CiAgKih1aW50OF90KikweDIwMDAwMjQzID0gMHgyMTsK
ICAqKHVpbnQ4X3QqKTB4MjAwMDAyNDQgPSAwOwogIHJlcyA9IHN5c2NhbGwoX19OUl9hZGRf
a2V5LCAvKnR5cGU9Ki8weDIwMDAwMDAwdWwsIC8qZGVzYz0qLzB4MjAwMDAyNDB1bCwKICAg
ICAgICAgICAgICAgIC8qcGF5bG9hZD0qLzB1bCwgLypwYXlsZW49Ki8wdWwsIC8qa2V5cmlu
Zz0qLzB4ZmZmZmZmZjkpOwogIGlmIChyZXMgIT0gLTEpCiAgICByWzZdID0gcmVzOwogIHN5
c2NhbGwoX19OUl9rZXljdGwsIC8qY29kZT0qLzB4YnVsLCAvKmtleT0qL3JbNl0sIC8qcGF5
bG9hZD0qLzB4MjAwMDAzMDB1bCwKICAgICAgICAgIC8qbGVuPSovMHg0NHVsLCAwKTsKICAq
KHVpbnQzMl90KikweDIwMDAwMGMwID0gNTsKICAqKHVpbnQzMl90KikweDIwMDAwMGM0ID0g
MHhiOwogICoodWludDY0X3QqKTB4MjAwMDAwYzggPSAweDIwMDAwMTgwOwogICoodWludDhf
dCopMHgyMDAwMDE4MCA9IHJbMl07CiAgKih1aW50NjRfdCopMHgyMDAwMDBkMCA9IDB4MjAw
MDAyMDA7CiAgbWVtY3B5KCh2b2lkKikweDIwMDAwMjAwLCAiR1BMXDAwMCIsIDQpOwogICoo
dWludDMyX3QqKTB4MjAwMDAwZDggPSAweDQwMDAwMDQ7CiAgKih1aW50MzJfdCopMHgyMDAw
MDBkYyA9IDA7CiAgKih1aW50NjRfdCopMHgyMDAwMDBlMCA9IDA7CiAgKih1aW50MzJfdCop
MHgyMDAwMDBlOCA9IDB4NDBmMDA7CiAgKih1aW50MzJfdCopMHgyMDAwMDBlYyA9IDA7CiAg
bWVtc2V0KCh2b2lkKikweDIwMDAwMGYwLCAwLCAxNik7CiAgKih1aW50MzJfdCopMHgyMDAw
MDEwMCA9IDA7CiAgKih1aW50MzJfdCopMHgyMDAwMDEwNCA9IDB4MTc7CiAgKih1aW50MzJf
dCopMHgyMDAwMDEwOCA9IDA7CiAgKih1aW50MzJfdCopMHgyMDAwMDEwYyA9IDA7CiAgKih1
aW50NjRfdCopMHgyMDAwMDExMCA9IDA7CiAgKih1aW50MzJfdCopMHgyMDAwMDExOCA9IDA7
CiAgKih1aW50MzJfdCopMHgyMDAwMDExYyA9IDA7CiAgKih1aW50NjRfdCopMHgyMDAwMDEy
MCA9IDA7CiAgKih1aW50MzJfdCopMHgyMDAwMDEyOCA9IDA7CiAgKih1aW50MzJfdCopMHgy
MDAwMDEyYyA9IHJbM107CiAgKih1aW50MzJfdCopMHgyMDAwMDEzMCA9IDA7CiAgKih1aW50
MzJfdCopMHgyMDAwMDEzNCA9IDA7CiAgKih1aW50NjRfdCopMHgyMDAwMDEzOCA9IDA7CiAg
Kih1aW50NjRfdCopMHgyMDAwMDE0MCA9IDA7CiAgKih1aW50MzJfdCopMHgyMDAwMDE0OCA9
IDA7CiAgKih1aW50MzJfdCopMHgyMDAwMDE0YyA9IDA7CiAgc3lzY2FsbChfX05SX2JwZiwg
LypjbWQ9Ki81dWwsIC8qYXJnPSovMHgyMDAwMDBjMHVsLCAvKnNpemU9Ki8weDkwdWwpOwog
IHN5c2NhbGwoX19OUl9tbG9ja2FsbCwgLypmbGFncz1NQ0xfRlVUVVJFfE1DTF9DVVJSRU5U
Ki8gM3VsKTsKICAqKHVpbnQzMl90KikweDIwMDAwMjgwID0gMHg3OThlMjYzNjsKICAqKHVp
bnQzMl90KikweDIwMDAwMjg0ID0gMDsKICAqKHVpbnQzMl90KikweDIwMDAwMjg4ID0gMDsK
ICAqKHVpbnQzMl90KikweDIwMDAwMjhjID0gMDsKICAqKHVpbnQzMl90KikweDIwMDAwMjkw
ID0gMHhlZTAwOwogICoodWludDMyX3QqKTB4MjAwMDAyOTQgPSAwOwogICoodWludDE2X3Qq
KTB4MjAwMDAyOTggPSAwOwogICoodWludDMyX3QqKTB4MjAwMDAyOWMgPSAweDgwOwogICoo
dWludDY0X3QqKTB4MjAwMDAyYTAgPSAwOwogICoodWludDY0X3QqKTB4MjAwMDAyYTggPSAw
OwogICoodWludDY0X3QqKTB4MjAwMDAyYjAgPSAwOwogICoodWludDMyX3QqKTB4MjAwMDAy
YjggPSAwOwogICoodWludDMyX3QqKTB4MjAwMDAyYmMgPSAwOwogICoodWludDE2X3QqKTB4
MjAwMDAyYzAgPSAwOwogICoodWludDE2X3QqKTB4MjAwMDAyYzIgPSAwOwogICoodWludDY0
X3QqKTB4MjAwMDAyYzggPSAwOwogICoodWludDY0X3QqKTB4MjAwMDAyZDAgPSAwOwogIHN5
c2NhbGwoX19OUl9zaG1jdGwsIC8qc2htaWQ9Ki8wLCAvKmNtZD0qLzF1bCwgLypidWY9Ki8w
eDIwMDAwMjgwdWwpOwogIHN5c2NhbGwoX19OUl9tdW5tYXAsIC8qYWRkcj0qLzB4MjAwMDAw
MDB1bCwgLypsZW49Ki8weDQwMDAwMHVsKTsKICBzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRy
PSovMHgyMDAwMDAwMHVsLCAvKmxlbj0qLzB4YTAwMHVsLAogICAgICAgICAgLypwcm90PVBS
T1RfR1JPV1NET1dOfFBST1RfU0VNfFBST1RfUkVBRHxQUk9UX0VYRUMqLyAweDEwMDAwMGR1
bCwKICAgICAgICAgIC8qZmxhZ3M9TUFQX0ZJWEVEfE1BUF9BTk9OWU1PVVN8TUFQX1BSSVZB
VEUqLyAweDMydWwsIC8qZmQ9Ki8tMSwKICAgICAgICAgIC8qb2Zmc2V0PSovMHVsKTsKICBz
eXNjYWxsKF9fTlJfbXJlbWFwLCAvKmFkZHI9Ki8weDIwMDAwMDAwdWwsIC8qbGVuPSovMHhj
MDAwMDB1bCwKICAgICAgICAgIC8qbmV3bGVuPSovMHgzMDAwdWwsIC8qZmxhZ3M9TVJFTUFQ
X0ZJWEVEfE1SRU1BUF9NQVlNT1ZFKi8gM3VsLAogICAgICAgICAgLypuZXdhZGRyPSovMHgy
MGZmYTAwMHVsKTsKICByZXR1cm4gMDsKfQo=

--------------tz0mDvnFYLERuADC9gvRwthr--

