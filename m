Return-Path: <netdev+bounces-280211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNdoOI+852mu/wEAu9opvQ
	(envelope-from <netdev+bounces-280211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:06:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDBD43E59E
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09E7D305614D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC8C3A1E6C;
	Tue, 21 Apr 2026 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kywc/0DQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE132DCBE3
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794342; cv=none; b=CEJCWoBTQBcbtDhysRUL0ypmnth6C3sp89w7FCxyub5Bw1bJy0hROgA//tGr+YGZ8KHCcCg/9U4Sd1LMGijx6cKLxhVckItumySU6qrxSA5xeb3BfG38AJGaKQaTO1QtlqoVtKjV51rUquxHbbSzKMiq/NiW0M6NfVwM9os4ngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794342; c=relaxed/simple;
	bh=UNWzQoiJLHZsycgSGADwufVDpldfq3IAxUjRrKn9GJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBtCe3Vh8g752cKqz62nnCxlErvAZt6JEggPTZcxClJ+WSxeTIRgDR0+OhreOY94RYKDp900oEuBMpi0psqZLctQNcQ/IAjx5fjIi1mlEKol7PVofIWFE+whG5H0hzzeJi3pjarknPqoPlLSQcfUftfGJE6vCFeP5n6WjS9PT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kywc/0DQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso14432635e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776794340; x=1777399140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlQuH9I8d8JGzpXuro5Nk2tmErbsbCQw/sXQZA/3BQc=;
        b=kywc/0DQIDli2z5hBKxQMHAFgK0HdLvpD1ZsQGeOs/+ucadM4/LyOwtmKJ/ONXlJnN
         MBCrgMdA6BGV3TsXKiDra+rxOf3RfvMqTsSBfVNgmjVv0PUL/Anr3vVOFbldg5CzATdz
         1ySJfpaoJMulpYdFqkZThamEhG9tJVP2pKePdL9kKH/uFU/GMZ3SGm4jLfG4XDoIy0Fd
         KJh0D9GQkRH+LOIDj3caUrQi9rrb2+fMacqbtSS33bWI4teXuJRUB8XaOkYm8+CmVp9j
         hjH94X0jEjqCV5Z4yF6nsAAa2OMkKGN2/5Rmp+n9I6qmey0ZU7H2K/Sh+pSPTXCxJM3U
         xV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776794340; x=1777399140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlQuH9I8d8JGzpXuro5Nk2tmErbsbCQw/sXQZA/3BQc=;
        b=eCN3dqUM0DIe8C4rOj3qEvADlYWFervnRqoAnMciXiXdUwWEkBwDedaAwx+5o2TBgC
         Cv4r2S2w4sWBhmPO2OOIK2vxAE24utZQIOr37P4JgROUTHlQx6/rNnL8DMMWnVugGQvA
         axppXC0VK06dUeGbAhJPoYyQgX+a4qfqP5lhZPpXY76f4Dq4BtDWkt/6Xv25HhkE3HOj
         yNL8ehSvy5y1klWw9IJVeI+reYJkXdOBNCAZIySpYhwu/2Q/riOTxg7AnOP+ZCH8TNZN
         hV6eRB9CxqbGLqgw/rUnoVhx61xwxMaRtlpfqbiSOGfVf6Bl0nqMsyaDvOtAPWbRZT9Y
         XgHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/D5hK4JJAwLk2sI9o1bnEfJhyb8TxsDvMj1LkwWE8ZOtpgMPn7GboJc7yVvYArQU2qghwXoUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPek1pFAHAlEER7p917V8Zilb/AiinkW3n3tM6N0KwTOB5pHlQ
	zhd//yRzOWpBlbHchkaJPKDrQYlQVi0VQOBWGsE+AokLt8KHA4hSVG0S
X-Gm-Gg: AeBDietmEIk5iU+ANcqGhfVDJjfKUoDOZ08lazvso6KvQ7P/DzPuydApubnud5dIylF
	ABN0e6h58K/xCyOVLRds8ejA7zgQF69mv5RQxdCHP9PmuTdI4+ZRhkIcpWtZCqGl97zcBTpjWU8
	7RfAs4PbNmuFxEXbQIS0hlYr576I9Q7jwM9pLwVuI1a8oLIge6aPn0CQMkglLv4jREMj/14x4ig
	6RzqO4bCDXFLq1PWrbuwpEIycv6LPZSApUGZ41CyD8qAUs4p4WXfLWJ1vG0XmjfNeTm3A4ue6NG
	yyHU1W7GYhjYIfQdUXBZOnJ372pnqdrriIn4kh2lAhq8oGVNmLJrz4/yGCbgXF0m4xVgZnmmZkK
	OgXi4+fm2BvFKqgFt0bBRS8za4ipl/485dgGkeXonhqKFB/BkVK0OcV9SKHGw5ZVzCKuheve/tQ
	qDXWSfObmZ7LpfuHTVztPcHeyHpe3U+PyZzocL1twzEhEPFB08xVUYK5mabJU8PegeJwXf7SHEm
	wGXEffzN8cme07YwYF319ClCik=
X-Received: by 2002:a05:600d:b:b0:48a:56de:d63c with SMTP id 5b1f17b1804b1-48a56dedadfmr32847085e9.27.1776794339439;
        Tue, 21 Apr 2026 10:58:59 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879? ([2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm121049875e9.11.2026.04.21.10.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:58:58 -0700 (PDT)
Message-ID: <db82f89f-0811-46e8-bf81-f3ef1db646cb@gmail.com>
Date: Tue, 21 Apr 2026 19:58:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Carlier <devnexen@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Harald Welte
 <laforge@gnumonks.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Weiming Shi <bestswngs@gmail.com>, osmocom-net-gprs@lists.osmocom.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260417055408.4667-1-devnexen@gmail.com>
 <b44de581-9f41-4804-afb1-72c491d9443a@gmail.com>
 <20260420125815.3a920d9a@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260420125815.3a920d9a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280211-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,gnumonks.org,lunn.ch,google.com,redhat.com,lists.osmocom.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CDBD43E59E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 21:58, Jakub Kicinski wrote:
> On Mon, 20 Apr 2026 21:02:55 +0200 Justin Iurman wrote:
>> On 4/17/26 07:54, David Carlier wrote:
>>> gtp_genl_send_echo_req() runs as a generic netlink doit handler in
>>> process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
>>> which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
>>> on softnet_data.xmit.recursion to track the tunnel xmit recursion level.
>>>
>>> Without local_bh_disable(), the task may migrate between
>>> dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
>>> per-CPU counter pairing. The result is stale or negative recursion
>>> levels that can later produce false-positive
>>> SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.
>>>
>>> The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
>>> the data path runs under ndo_start_xmit and the echo response handlers
>>> run from the UDP encap rx softirq, both with BH already disabled.
>>>
>>> Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
>>> commit 2cd7e6971fc2 ("sctp: disable BH before calling
>>> udp_tunnel_xmit_skb()").
>>
>> Why not fix iptunnel_xmit() directly, rather than fixing all possible
>> callers? Basically, jut like we did for lwtunnel_{output|xmit}(). The
>> advantage would be that we no longer have to worry about BHs in the
>> callers, and BHs would only be disabled when necessary.
> 
> Oops, I pushed this already. The bot hasn't caught up yet.
> Let's revisit this if we find another caller in process context?

No worries, works for me!

