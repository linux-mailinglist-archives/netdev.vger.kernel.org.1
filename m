Return-Path: <netdev+bounces-271931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLpmGpnwxGnv5AQAu9opvQ
	(envelope-from <netdev+bounces-271931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:38:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E733317B0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A916303A12F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7B3A7F48;
	Thu, 26 Mar 2026 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKoW2Y77";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rCOnQ1Uq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6928506A
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513888; cv=none; b=B7MXyFOiiIcHTCRz3APqED5qLiBDJ3CgwkvKDQ/sAglvsRiRLaXA19VGF02m4eLbrbu/FvzZtCMCYnzmeTJuVaUL7fTaRMJPbKY+taESCoY1sR+GX038Qlb9/Wr/nvpRJbXwfWDMxTeKCwX4JlSE6QgXZnJJHPcrK411VYZ9b2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513888; c=relaxed/simple;
	bh=HJ8lCiF59X0g1//sdZdXalOYoEGKz2/r4hNn4E6PKa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9ooblyE1Zz+1q/CK3LJvxqM4iHYj6dahK0d9JFrmYI2Sxkc/3PZPyIp/fZgHNCAoGtpLS/x5Iteo8Oz/JgfuubyxJm+zLwFy6++MWR5uWcqIFuUw2CIRAg+gdLyv34JM5CTrn2KgtU27VlatLBGBKNiEK9YUavYHvpfu7n+L9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKoW2Y77; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rCOnQ1Uq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774513885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/luC6el/mw99mrk3zRpM9ICUlTK3AqWpNegZ4N5alNo=;
	b=bKoW2Y77sCrIqiqJFCL/s9j/iCuFMIOtnyA2e0X022413bh301Y+XfVJ8Ydesz8QAMnhdN
	9yy/Y5C0639rs7Jc0iaMvTjeW7fI8mnoJcTWrwb1caDDUrunjZWgLK7I4X06sevSLgZ37L
	9UdAtj84zGtLT89WcFtv1J395aiJz4k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-3XSsLJwkPdSHp_J9sRJCaQ-1; Thu, 26 Mar 2026 04:31:23 -0400
X-MC-Unique: 3XSsLJwkPdSHp_J9sRJCaQ-1
X-Mimecast-MFC-AGG-ID: 3XSsLJwkPdSHp_J9sRJCaQ_1774513882
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fa35b005so9546115e9.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774513882; x=1775118682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/luC6el/mw99mrk3zRpM9ICUlTK3AqWpNegZ4N5alNo=;
        b=rCOnQ1UqD76M2yuXwxls54PouHtM706OhyPTkP2AAYHunvHJwVUqktjE24/JZUHsZk
         azwI72dzaqoHXd89LvN65vosxo3QfoDt4bDV+k5VqneGK2NjLDLP/IRr3yDYIVYA4Mix
         hWMh1+6yFkV1vGmHb6QEnOfzusM5Uv8wIiJE3Us8DBAewBhy7lCnGOnL6wM1htghYez3
         SHGDyNHPkqQc/6UJEd7blmy3gN7H4F99Y4uadqWhNQTwrz9ordwEabwV6LOdG88k5lPE
         wBj35kTkIL1NOHSZ3V0zGtU1Pd9pj9LEBOQV6RfY4MtG3nEr7A4+C6qyI/1L0Ptp7lap
         OEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513882; x=1775118682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/luC6el/mw99mrk3zRpM9ICUlTK3AqWpNegZ4N5alNo=;
        b=dKhCrPZ5k+2utkQTLkSmV8BZsw3kC1f3BhfYYDBzaIj8CfK37Qdvw+zsk//eGiF2Ot
         BtB9qSXS2qkMrFNiv3a56fw2xbup/s6b3/us5QgU68OyxDOOm8CoKipm0XhovhTDiySl
         3X1Jqh/UxUZ2Ewvqz1HeSMWDDJHFYwq4QSag3znTml8z4A/ckTLVJ9I0aO4SXMXeyucg
         jwQ89J6SRRIZYmvmgE0Q84bBq6DSdbI8qRuPt8mGnVF5WHRgf9M36c47B1XAyrFU79Er
         yQViD+6XAGXa0eyOLHQn+2vptd+AQSDsXes7oir13Jyeo8RApOliUuymRvpfa0DTZcWu
         sQHg==
X-Forwarded-Encrypted: i=1; AJvYcCXgIbf3Dzp0JXU9Cw3KOxYeF+1dcYzYEFm8hjSbXsZLNTpxpv9q15fBYWZ7CRza273/dq7+8aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEdwJHacEHh8QraLxJFnZoRfsEcclk9tBJp1RAoYC9qoIUsHr
	Mh6LPuiBkNivclIh4COYoMG8jvbXgMYh9K0SM/6fQFbPtTTZoP7O4EeXeNb3Wbcl942o1rirXv+
	+OP5/2bxI7W7Mzi+88uIQsrFgUnzdSOEXKwp9iQj/SO+bqBYoZzxjOjgO1g==
X-Gm-Gg: ATEYQzyWoAJ7OXQQTBu211NFXCrAKkLWIDIiVcNh3rl2mJD8yAIhLwIpkwqqqcIUKbW
	tE5G0OShozB/Ilp4DT7CeETZDweJeZvvr1SLh0UaL+gLtX+2FyU7hctLsrtQ41l+Vp526pL2JD4
	aGtxxbN2jTq4cOmUvuXyZBwIZJFNaH1uMCQ7kggSZQaY5uuUQWEZfMnW3+n8z6QKpcC5AzBQhs+
	sbdwkrHUBTvJG3jk14Zr9v+cRfdnsD8LftbgDaQ+ny5loIbUPBeBg1LB9ZmkxX8fA3Q7UL1cE8a
	lZ0byChCOfR66VprIStjV44qN4betflk4od2oBAGT55azjUZtZGE0lhQPOWUPhdNPpjhiICTqh7
	drP5GNwrAR2VzMwrLFC0Inch6rMiwayz2Mprlf1lqF468YvxeSlz+Zl6e
X-Received: by 2002:adf:e84b:0:b0:43b:9416:1aeb with SMTP id ffacd0b85a97d-43b94161bb6mr2274273f8f.45.1774513882252;
        Thu, 26 Mar 2026 01:31:22 -0700 (PDT)
X-Received: by 2002:adf:e84b:0:b0:43b:9416:1aeb with SMTP id ffacd0b85a97d-43b94161bb6mr2274211f8f.45.1774513881704;
        Thu, 26 Mar 2026 01:31:21 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df6d4sm6006940f8f.25.2026.03.26.01.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 01:31:21 -0700 (PDT)
Message-ID: <1b02bbe0-cdc0-4f03-bae1-40cc5c9d6ee2@redhat.com>
Date: Thu, 26 Mar 2026 09:31:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: broadcast_pmtu: Fix false failure from
 incorrect ping exit code logic
To: fffsqian@163.com, davem@davemloft.net, edumazet@google.com
Cc: kuba@kernel.org, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>
References: <20260326040645.2020782-1-fffsqian@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260326040645.2020782-1-fffsqian@163.com>
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
	TAGGED_FROM(0.00)[bounces-271931-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com,davemloft.net,google.com];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcast_pmtu.sh:url,kylinos.cn:email]
X-Rspamd-Queue-Id: B9E733317B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 5:06 AM, fffsqian@163.com wrote:
> From: Qingshuang Fu <fuqingshuang@kylinos.cn>
> 
> The broadcast_pmtu.sh test verifies that broadcast route MTU is respected,
> but it uses an incorrect criteria for test success: it relies solely on
> the ping command's exit code, which leads to false failures.
> 
> When the kernel correctly blocks oversized broadcast packets due to the
> configured MTU limit (1500), ping fails to transmit any packets and returns
> exit code 1. The original script interprets this as a test failure, even
> though the kernel is properly enforcing the MTU (the core goal of the test).
> 
> Fix this by:
> 1. Checking ping's output for clear signs of MTU enforcement (instead of exit code)
>    - Match "0 packets transmitted" (no packets sent due to MTU limit)
>    - Match "message too long" (kernel rejects oversized packets)
> 2. Use an exit code variable to avoid early exit breaking the script flow
> 3. Maintain full compatibility with the original setup/cleanup logic
> 
> After this fix, the script returns 0 (success) when the kernel enforces the
> broadcast route MTU (packets blocked), and 1 (failure) only when the kernel
> fails to enforce the MTU (packets are transmitted but no response is received).
> 
> Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
> ---
>  tools/testing/selftests/net/broadcast_pmtu.sh | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/broadcast_pmtu.sh b/tools/testing/selftests/net/broadcast_pmtu.sh
> index 726eb5d25839..a8d2a205c51d 100755
> --- a/tools/testing/selftests/net/broadcast_pmtu.sh
> +++ b/tools/testing/selftests/net/broadcast_pmtu.sh
> @@ -41,7 +41,13 @@ trap cleanup EXIT
>  
>  setup &&
>  	echo "Testing for broadcast route MTU" &&
> -	ip net exec "${CLIENT_NS}" ping -f -M want -q -c 1 -s 8000 -w 1 -b "${CLIENT_BROADCAST_ADDRESS}" > /dev/null 2>&1
> -
> -exit $?
> +	ping_output=$(ip net exec "${CLIENT_NS}" ping -f -M want -c 1 -s 8000 -w 1 -b \
> +		"${CLIENT_BROADCAST_ADDRESS}" 2>&1) &&
> +	if echo "${ping_output}" | grep -q -E "0 packets transmitted|message too long"; then
> +		exit_code=0
> +	else
> +		exit_code=1
> +	fi
> +
> +exit ${exit_code}

Apparently now the CI test is consistently failing:

# selftests: net: broadcast_pmtu.sh
# 0.03 [+0.03] Testing for broadcast route MTU
not ok 1 selftests: net: broadcast_pmtu.sh # exit=1

/P


