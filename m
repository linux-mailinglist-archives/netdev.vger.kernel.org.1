Return-Path: <netdev+bounces-278363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCR/NgYH3mlRmQkAu9opvQ
	(envelope-from <netdev+bounces-278363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:21:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF513F7D14
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E64553022B99
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24873BE16C;
	Tue, 14 Apr 2026 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdnO5Jse";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwvkhqBo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F03BF682
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158269; cv=none; b=SDOZ5HsD8o0tm1V8a4POQ1JEvqf9e7yPoHx96N/oOwD4E5OeL/bUQP9ajI8+xCscb0sWe+0qjrBs1jVT3Xj38nbTd9W4pHYTocdsaXDRTQr2Wl3V6tn+dd6syBKEFThS3lpPeAu2nn3Z9WCO/gIFtmZsJM7ogcz9YzHtKBrh29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158269; c=relaxed/simple;
	bh=y9RBwNlL7JFhRplM8GzxiuHZYoF1Od4tFFoLb5d65OE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A1U2BW3thDNuxeL0RorTkLx9RV18Co/ynw3iGpjPnpmlkQ2orDKXeLhNO00bcwxingZCjJDYLUydMcWs6e40BTDM225NXQH/Xn/A+EFnt/lm2jlAJafoCbJbTi9T87kFPMwmoHL8wOCytafiLpBTsAZtGdQqR9uY2faeT00SHX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdnO5Jse; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwvkhqBo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776158267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o+jTcPee9ytS2fBNgNkDGXbrpoLlX9QLHbrMcVIiqY=;
	b=bdnO5Jsec8oe85F5BE7OHOWaPviY/K+USHQPQNqz7wQ3qZNyLM7+OF1ZS9wL5vTOoN8ivg
	H3mn8sRrSg9yr6tajDA9ch+kfz+2MUlgK0WqBONqUlRESwJD1cv+mpLwBx7ddvKz8/nr1+
	eAGCEtk6y94utVMv/9q6U+mcAp/9Sbk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-7kjG5a3iMLeph5BDJHn-pQ-1; Tue, 14 Apr 2026 05:17:43 -0400
X-MC-Unique: 7kjG5a3iMLeph5BDJHn-pQ-1
X-Mimecast-MFC-AGG-ID: 7kjG5a3iMLeph5BDJHn-pQ_1776158263
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c0fcc6deso33408225e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776158262; x=1776763062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8o+jTcPee9ytS2fBNgNkDGXbrpoLlX9QLHbrMcVIiqY=;
        b=QwvkhqBocpRUN3Z3uFUBBkMcOb0r89fhAUb646TnrDrZth+UeQmuw5UMofKTJlH91X
         cNv5ESVBbs6v7JphaOvQXXD81RJnk9qXDCMD4hfWtyJ6NZD3Z43irt1C4Q9wD5bTHg9+
         9uYhRYdfWDwmCoVcW9BJLez4m7dizBojugOUFpt26amZ0PlB6tsQbIwlQMNyqGuR+ouC
         TJLq+E6+P1fbjvmpKxrwY9fMc6NIvO8mTQ0sdeRWggwhidXJV8yUxY1ydPBVatowsM8h
         /R7hFe6lwAtGo048Sl3gz6YxS4ExCD0+UtxugVv9P/uPNPAoOxaYvUDTrNQ2I4pkt/d6
         BaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158262; x=1776763062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8o+jTcPee9ytS2fBNgNkDGXbrpoLlX9QLHbrMcVIiqY=;
        b=nXzWLPHjVrG+LG0i6RV2ZRtvTEHIXAC09lepTnMGs4VLBv5QkeV92/tJgAxVho8+iX
         WZ+m7DbmZWzTnxC4Bc8vglUzXopgwHvabDdCyPqpk3kuUS76ZuzBYA3H8zMnHpmCfLxA
         bnQOKw6GNetGXPaQmVQOMC5UjOSsOtL0dKdUa4HVnmz1FiIRI9T6FSnHA/0E+61J7V7N
         E28L7/zv1PX3jvS9r36I+1ypLA2nvNf2Gqs6LI4b9EdcWczYm6Oc8iKPs7Sf4YTm6s/I
         iGVb7Y175IWA8jsimEf7TrrZ47/pn6Fr4ghMqzQsJTY52itNIuA8aY0Dp7K2W+p3gHCj
         kAxQ==
X-Gm-Message-State: AOJu0YzeKjMLEj8N/E5yB3vTCdeiKRKM0Jbv4YRdUUWKRd01dQuWNBhI
	pOYTpLyfPZceBE4wt83vz0jHpLC9h3IwGRXQcMjOnk1prrVyvtZO/Jd4KhUQ12JYKFNFkSmQdF2
	rydgv1eZn3LTKh4+F9fTWLd24TZqFPl0zYL43rlaB3NLz/dwbb/HNQchqEg==
X-Gm-Gg: AeBDies5RyDOpS5gzJt19BbXQSGeil+vEE1pCHUnawtx2urIpnGLbpJIAEm2UBcvA9W
	50tVIrRIEu/aKJsEPBzgw4Ju/7iYNduec9gDVggnPzTmvbhriFvol/AeyRPHl/Ak0lQ3mhTu9uo
	EhRURJL90SfyYCzHyubJ6okyvZDTm81THIKCV7i6lo0D+10fCgyN1PJs5z83G3DtkVsdkdinLTD
	L6ui/K/eJBfASp2pHbAzvVeSU34ebnAwIa9bgnSWgGQT+j4UcDCfJRmZpnOtew832aWBwgWOo2N
	KBAWkAgJOdKy12FpFeeujSjDuCveFeyjUP40HJSzeQMpe+JlmMV6mKf87/P1HfJU1xXkGZu5fV8
	8x52mAV6sp6gIs4/m0mfC+G+F4+RToR8ygvYHRxieI7hEjSHm9dqVsKkF
X-Received: by 2002:a05:600c:a404:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-488d67b8d97mr197779005e9.2.1776158262578;
        Tue, 14 Apr 2026 02:17:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a404:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-488d67b8d97mr197778675e9.2.1776158262108;
        Tue, 14 Apr 2026 02:17:42 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede2ba5asm32868935e9.12.2026.04.14.02.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:17:41 -0700 (PDT)
Message-ID: <04cafd50-7af5-4835-b0df-67393d9f5a51@redhat.com>
Date: Tue, 14 Apr 2026 11:17:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie
 statistics in tcp_custom_syncookie
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
 <20260411013211.225834-2-jiayuan.chen@linux.dev>
 <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
 <6b22a595-cd65-42ec-b332-c835273bc174@redhat.com>
Content-Language: en-US
In-Reply-To: <6b22a595-cd65-42ec-b332-c835273bc174@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,linux.dev,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-278363-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: DDF513F7D14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 11:08 AM, Paolo Abeni wrote:
> On 4/14/26 7:50 AM, Kuniyuki Iwashima wrote:
>> On Fri, Apr 10, 2026 at 6:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>
>>> Add read_tcpext_snmp() helper to network_helpers which reads a
>>> TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
>>> test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
>>> LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
>>> BPF custom syncookie validation.
>>>
>>> The delta is captured between start_server() and accept(), which
>>> covers the full SYN/ACK/cookie-check path for one connection.
>>>
>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>> ---
>>>  tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
>>>  tools/testing/selftests/bpf/network_helpers.h |  1 +
>>>  .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
>>
>> As you touch bpf selftest helper files, please rebase on bpf-next
>> to avoid possible conflicts and tag bpf-next in the Subject.
> 
> To hopefully  minimize the conflicts handling I'm going to apply patch
> 1/2 to net-next. Please resubmit patch 2/2 to bpf-next after the
> relevant net core reach there.

Uhmm... the original feature went through the bpf tree, so I guess both
patches could/should via bpf-next. Hopefully conflict into the tcp code
should be minimal.

@Eric, @Daniel: please LMK if you prefer otherwise.
/P


