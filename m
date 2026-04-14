Return-Path: <netdev+bounces-278355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJOQKkAE3mkQmQkAu9opvQ
	(envelope-from <netdev+bounces-278355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:09:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3523F7ABD
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78363042415
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DF3B95E9;
	Tue, 14 Apr 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy+9abgh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="trukhHo7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA63B7B80
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157744; cv=none; b=Vip9xMMIOQGkmt6rFqf1mKnxrlyXoiwc7puqPlTNRjhufHCsaSjxAmLik6ZvSqO0WjF8svX4Xl7c2LN/cwLTxZgIwyG7Sh6PfztyZsnMNVwXU4N0h6d5DGEJPgH7YQEfTYORf2i65vKamYjXzOkxbCK3RiWn/+H66lAuUaTV7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157744; c=relaxed/simple;
	bh=KHwVwvdW8+/51wnJjG3RP3NUzvq0DnMcvlt8hTAVStw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7VAuHte+rmGgHkG5vZz96dRHXgISDKsKeBpZjSHiPac6hQK7JEZBtF2toJqDra9E0NcrjFhxkkDu5A5pHkP2gJU4ZxUBXUE1HmFmda3PIHaPFlAmyvxNctRn1mkk//YjspmqbXmtWasjPTZLDkW7GSSqqqIxvvohlr1L8XwoO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yy+9abgh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=trukhHo7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776157742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkPnqRGl1gXZbEvB1A+stpFWNQBl4kOwSYgNSHlYul0=;
	b=Yy+9abghgsSkfBw5SlH73VzCuNkwhoKDMOpGERLgukfNhXkM2p4h0VadLAGVMXB5NXT8k+
	7PpGoYVY5EAVyn3/pJ22f2pxnl49uL58b/kSYWmTczbvb8Wd3V2U0wWwi9/JhLNLPm2g6u
	/9Qjm+keePdLqFyfshANqw3ZeDJpfTU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-vg2AhD5xOLuhL5wBlzq-XQ-1; Tue, 14 Apr 2026 05:09:00 -0400
X-MC-Unique: vg2AhD5xOLuhL5wBlzq-XQ-1
X-Mimecast-MFC-AGG-ID: vg2AhD5xOLuhL5wBlzq-XQ_1776157739
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7c6d58c8so1776046f8f.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776157739; x=1776762539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkPnqRGl1gXZbEvB1A+stpFWNQBl4kOwSYgNSHlYul0=;
        b=trukhHo7ToUrLsQlJGHUpMzXkV0j86zm3SP5ZEPi7KRyfNoGLf0NxIIJAbT1a1oBL5
         L/liApKE5PbXS+TepVKrNR6ck9jJZXoEOnRqLcAncP3u3A/2B8LFCWcHxgMo5L1uKUWb
         z3tkVFfSmA+ahZQpD7I/S1dSwRH4MhutbW5TeXWJlYl/79WW/l65mDnneYvOKZT9+E46
         WqTmBZbXfxm4AJalX+yAoq3GWsdL0tUYIW2GKChEj+Y0iZxOYZzn/7zB6la4MWAvadWZ
         Ka1QBTvBHtqTonfZ2Q58ppFf3+yWRPV0s9wjtbiLIsABxMGL+r4asfF8ksAAIstKdm5l
         BuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157739; x=1776762539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkPnqRGl1gXZbEvB1A+stpFWNQBl4kOwSYgNSHlYul0=;
        b=Lw4vctmsX4Mc2kmxXIwrgzWGY7mn2ZWI6R5hisnzOyUqQtpkYnDYJq8XJ1ElThvext
         Ul3xUhJG+0HIp5cycrd5/E+dyiJnWk4XDxIkvYK3UmwRvL1L5mw1BbzlM+I4QRmO//Yz
         +0s7oM1G+OdcmxlJkoaLcj5jDav7OU7fpG/1jUMJhX+9lQtR/KtZhzCs7PcypNMlMmzq
         Lh8d4vnSebR1Qx7LYamwY+1PyPsaHUtewWwcEgR5N9C7yLj9vOwpPmN6BsYtq5RDNZ78
         uRUP6/jcsA4jtDYgvDqH3dMum4npEzd/z6GZT/QMokKqcr0uhKLqq6qAz4bWlScaLWSh
         HEtA==
X-Gm-Message-State: AOJu0Yz0Ny85oADZSLb6WyY50FTCR027IebJs90kn4X/AlvHweZHuSJt
	/3jy9Lc7GsDa8hJSpxg1KeKT35bfIa1D76QXpJlQ692ptcnS3k45xUpLFbuKGXgUdUce5oDU0Tb
	UcA+bEwVU1a9YCnJ3ITUkv2Qz95PFsLuh2yRlmCXaas3Ek+VpUMwcMKfRag==
X-Gm-Gg: AeBDieulwvTDN9QJkvpAY1YLRd6sHKZ564JN6B4kBHpKdBejkQXt1gafQ+A0jHUV9i8
	13acp7iDjDLpjwHAF0Q7EXPGgE1xWJBkGf8XJlIKED9tqh3zwfegd54iSAtkGqWJnGlJpHI62BM
	Yywg13UJAeAfgIIE8gGYiAQWy9iB2vQ2TTcY0I2crqrWLwjFnMKR56AY1K2IcoiKQs10juXdJ9G
	ZslalG6zaHw8VUBvup+0jCt86MmH+YAv5hSTJg1eK9D2GmFmBDl0b0iv+LG4c+jdaydjTUiyPI9
	1WLm69ILC8aPJb2uqrIN0nZrhneUQI/mm9xQxhFUCmQC/QXyiiUqafWWwFAsCvkDWmKJPBF+v3M
	J4WMxE07j4bmVDLj6erj/Lvzthy04DBHb6s/AbD6MZexhaOP8p2R7VFc+
X-Received: by 2002:a05:6000:24c3:b0:43d:77a8:3bb6 with SMTP id ffacd0b85a97d-43d77a83df5mr11097046f8f.47.1776157739318;
        Tue, 14 Apr 2026 02:08:59 -0700 (PDT)
X-Received: by 2002:a05:6000:24c3:b0:43d:77a8:3bb6 with SMTP id ffacd0b85a97d-43d77a83df5mr11096988f8f.47.1776157738818;
        Tue, 14 Apr 2026 02:08:58 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5061fsm41420908f8f.30.2026.04.14.02.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:08:58 -0700 (PDT)
Message-ID: <6b22a595-cd65-42ec-b332-c835273bc174@redhat.com>
Date: Tue, 14 Apr 2026 11:08:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie
 statistics in tcp_custom_syncookie
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
 <20260411013211.225834-2-jiayuan.chen@linux.dev>
 <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-278355-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C3523F7ABD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 7:50 AM, Kuniyuki Iwashima wrote:
> On Fri, Apr 10, 2026 at 6:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>
>> Add read_tcpext_snmp() helper to network_helpers which reads a
>> TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
>> test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
>> LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
>> BPF custom syncookie validation.
>>
>> The delta is captured between start_server() and accept(), which
>> covers the full SYN/ACK/cookie-check path for one connection.
>>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>  tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
>>  tools/testing/selftests/bpf/network_helpers.h |  1 +
>>  .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
> 
> As you touch bpf selftest helper files, please rebase on bpf-next
> to avoid possible conflicts and tag bpf-next in the Subject.

To hopefully  minimize the conflicts handling I'm going to apply patch
1/2 to net-next. Please resubmit patch 2/2 to bpf-next after the
relevant net core reach there.

/P


