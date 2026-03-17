Return-Path: <netdev+bounces-268638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGP5M8RruWmvEQIAu9opvQ
	(envelope-from <netdev+bounces-268638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:57:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 354692AC7EA
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D4431807FD
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE7B3E867F;
	Tue, 17 Mar 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2A7LRJ/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pMlPTG9P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E43E8680
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758804; cv=none; b=qiaKkjdoA3nsafsuEYRoPPzE02ZEY9hsYGM8IsBzT9tGAOmx4UCOWYZjvhMf6gwnqG5V0kKUGufWCxM55A0uMPCM+r9A92bxzMKfGVf7kpChx+sXGYOhc0H/t4IJW+lOYMKA22L75wcvc847CNZNLiJB8fUIDuficZ9J+R1aldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758804; c=relaxed/simple;
	bh=PJwDGvf6trB943jn00qkBQDhhgwKxS7QkCVGOozd50M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0jvErMm6qlc6pacD8BkYpb22EbH0RUTbQWN/QoaJ2kgV1YaBVEILZDrT7UMh2WOGlz4gcVbkgkRlwfCrAt4GVc0RrbvlH6e9YjqkdH1bwc5cuAIaZ/RqRMb+5XFWdEkIzD/XcGNKYw1Sl1PNmjhX4RrhHw1o6skpm/GzVA6B6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2A7LRJ/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pMlPTG9P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773758802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYgcgasxNaCa6wbkN3+j7gIOt+KWXemXDliasEJTpOA=;
	b=A2A7LRJ/2whnqF0+5brKrBkWohnBH8hxWEE7EFVs4pxOfLKb1Ck2jPIFUpB1oFzQ00U+RF
	h20kej/4YG6VHxg+WTY4+2ezcHfEXUtODay2/xXLlfDOvCONa2uVJ1f1mCLv6P1O440J0F
	YWDpPL1x9QgOivtK8eXRNPO40LVeF1A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-xXHhuMRcOxaNKQsAhwClaw-1; Tue, 17 Mar 2026 10:46:40 -0400
X-MC-Unique: xXHhuMRcOxaNKQsAhwClaw-1
X-Mimecast-MFC-AGG-ID: xXHhuMRcOxaNKQsAhwClaw_1773758799
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89c4885814dso511730456d6.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773758799; x=1774363599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYgcgasxNaCa6wbkN3+j7gIOt+KWXemXDliasEJTpOA=;
        b=pMlPTG9PVkskqz/dOz3RrAN0rica3bqhcGOP1yr90IjXf0/wzBFNlX8jYoHw+Otgmc
         s+twZKY8zKjhRPjpJiEPYi1vL1yAr35Lc5KCsic0TxSoHFVWTjkW8oDz+t0dHZX7hdvQ
         Uy27x7kXIUazrKO2i2Hpyxw+Ilsl0xL/okDwchS4VyUB/jyOXSwsK7G2PaY7pKILbzwV
         DjrKfH9XyY0SFPj1oHEM5YHxzunlBsVxSR6wF9L8OjJzSTfz1SwGJ8UBjnKSmDD9gVhl
         Ikt2C61WByxfkov9D2mOUi45zzizXx7jYZWGgeJa7/Fe+5NKzxfgI+3/P3RuAVRWaxFA
         iTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773758799; x=1774363599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYgcgasxNaCa6wbkN3+j7gIOt+KWXemXDliasEJTpOA=;
        b=M/YoPNrjrqV3YTUYJXj8g0RuQ+RmLlQ3owmmDT2xQKW5uxaH2Zwq8lu0YvOlMpkt0j
         8JTJfIYHnlwiM1yLeXhanDBaR7vGBEg91FdObbRe065adlrvQ8ZXloTozT0E6dNnjMsA
         bWnrnveNe5wpCJ5cIIZXN6uRtMWAQvzqHVVpCWjg3mUHum9MzunQLiG2M26rUsYVL2Oy
         w59FfbOeRAHAVqAsUkA2aXm1UByoLALZoqP5Z6K3jGWHOHF9Zne5AjvLFq4liU1xDRZO
         pHwIiU2oBag8Xmw0gsJt35KrwEYO32dgMHNDu5mKqHTFjC9IzYjR1gTiFiOzOjM2uhlX
         KAQA==
X-Forwarded-Encrypted: i=1; AJvYcCVKJeStu3Fv7BT3HWGvcNPaHQbmFcrJ5vOTeH12u8FCYfgUHCS7IkFOF62jJtle6jXK8mytYdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEM/vU97/lSOSPp07N9/VFEQlR8v91pWUJwWoVCu8L1e/PHaW
	qkOxeiqmLpTut6FN91M7BsFLOd5eAXpjRJm444U1iuUPB/cHQrvkq6MOVln+BZYBvZuTfKx7dkW
	r5IpETDQX4WXjChtd9a9wPNPbk5Cbi8ny7GoiEKX2Xyf+FRB1uyMf9hg9EsnigEgdfQ==
X-Gm-Gg: ATEYQzzUw9ie46/qeyo0pg4g5vmGzOiOHmQBF5UURWPip7fiYWGgYcTPEOOGTazU+sq
	bs1F5aPrlCugi7M3xu4XGq4A8hrUSiTumJ2UadyhL4WTzDwTY9cukiwmhUgf3neNpKiIXQfmXcW
	4wDwuc8TgBKD76EkHy2qqg9vGuYuLQMfecd+tnCRZN06zpTwZPXyiowvu3FIv7ifG/KKbpDob9S
	EsKyzqFDSjpq5j5/EvMPmfJRvnt119ggSZCknU0noLV65Zz3td5vGy633JDJyCHjJi+ZWQJypkb
	XkAzYIRrs1xLjkPzZsUJ286Kz8vQi+vGSvc/yoP/Vkla9OKsKqw4XeNKHAtn6VDXn2IJu1259kP
	tLCdqd81gsTicOp0joywjP6MrcC/3uKc/w6BXwGUmTE87ezOj7/oeHz0=
X-Received: by 2002:a05:6214:130d:b0:899:ee4e:63b6 with SMTP id 6a1803df08f44-89a81f6062fmr268303436d6.44.1773758799374;
        Tue, 17 Mar 2026 07:46:39 -0700 (PDT)
X-Received: by 2002:a05:6214:130d:b0:899:ee4e:63b6 with SMTP id 6a1803df08f44-89a81f6062fmr268302936d6.44.1773758798845;
        Tue, 17 Mar 2026 07:46:38 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c4feaaebasm49171566d6.37.2026.03.17.07.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 07:46:38 -0700 (PDT)
Message-ID: <302d1a45-dd5d-4d50-a99c-ce73de196d0c@redhat.com>
Date: Tue, 17 Mar 2026 15:46:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] selftests/vsock: fix vmtest.sh for read-only
 nested VM runners
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
 <20260313-vsock-vmtest-nested-fixes-v1-1-d0e6274c3193@meta.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260313-vsock-vmtest-nested-fixes-v1-1-d0e6274c3193@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-268638-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vmtest.sh:url]
X-Rspamd-Queue-Id: 354692AC7EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 1:00 AM, Bobby Eshleman wrote:
>  tools/testing/selftests/vsock/vmtest.sh | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> index 86e338886b33..c2cfcdf05d99 100755
> --- a/tools/testing/selftests/vsock/vmtest.sh
> +++ b/tools/testing/selftests/vsock/vmtest.sh
> @@ -42,6 +42,8 @@ readonly KERNEL_CMDLINE="\
>  	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
>  "
>  readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
> +readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)

shellcheck complains:

In vmtest.sh line 45:
readonly TEST_HOME=$(mktemp -d /tmp/vmtest_home_XXXX)
         ^-------^ SC2155 (warning): Declare and assign separately to
avoid masking return values.

> @@ -451,11 +464,14 @@ vm_start() {
>  		--run \
>  		${kernel_opt} \
>  		${verbose_opt} \
> +		--rwdir=/root=${TEST_HOME} \

And here, too:

In vmtest.sh line 467:
		--rwdir=/root=${TEST_HOME} \
                              ^----------^ SC2086 (info): Double quote
to prevent globbing and word splitting.

Did you mean:
		--rwdir=/root="${TEST_HOME}" \

The first occurrence could possibly be explicitly silenced explicitly,
but it's probably better to really address the latter.

/P


