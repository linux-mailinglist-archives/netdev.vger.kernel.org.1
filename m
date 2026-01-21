Return-Path: <netdev+bounces-252042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIQdMVU4cWnKfQAAu9opvQ
	(envelope-from <netdev+bounces-252042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:34:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3A75D545
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63284A4F493
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA63C1976;
	Wed, 21 Jan 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LjYZfC7X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AF73793C8
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024580; cv=none; b=SwXjBDPlAk/XNtgbvCacezN0UCbYsSprhpEM06A4FXt+Z/EbjRJcJ4vKSc4fszeaoxZD0Bc1WbQWWja+BnDR0J5nsOjlFAxdnKTMp5yy55IjDWnDQ4iJJNESZS8Aur9MIDnn6vXqvB5wPaFZAbYcIX4kPtjjH4evi1fPrtx15Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024580; c=relaxed/simple;
	bh=F1jquYdbse0f+h5PoDNJ9pGakn5CxPZjQwcYQH1T+jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ojr2BpKQmDsdaofLmajzJoFbg9LSZdBNmky79B/DW1yB+sql8NgN9uarnPgjlxQWS/4nFf5SrlcQEsKWxnlM0IF3bjwVD8y/s0918K6wZtpXzHAv/9QfZ6ENnCcNwcTtiVHIH/udZ10ea3yBNmVMYfJftWlpXDY8WXubWxpve6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LjYZfC7X; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b70abe3417so399637eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 11:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769024578; x=1769629378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQvGCJmxpkROPmN9OrxKrrBVJtlOjFG6UFxmO3kVd3M=;
        b=LjYZfC7XW0ReDqdceYyCRzzO8cO0INzBeniWDhuOMniY2c2GQJurt3n3LxFA6n3Ikf
         IpCsWwWTZ9NOZhLEqy3f1zxDjNXj4kVtJVkNvXelBaKTmRLNclmi1H1TkMzLQWUtk0kq
         xztRmMel9QKg2MPg9Ujp30IGlj7KhYvOA1iEpS3W2bu3pP06GIwPa90jnb7qK5kaM3HN
         AqQXhBFsOQ3yA0MDSOgYJJBdKCIvhEadBASwf2ardiv2U0dh18g/99yGnsMl7cQm7y27
         5W0q8INYGL73nq8mQMohbbQIuooL2yc2lqbMeW43c5oUvi9gOYZxjEOoRWu14MyzEXpO
         TR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024578; x=1769629378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQvGCJmxpkROPmN9OrxKrrBVJtlOjFG6UFxmO3kVd3M=;
        b=b/P23WKAXzEjYM0BIHZ11XGJhrm3JH83ZmgRR22XWX8nG/qANR9XudvLrw3ieH0y3g
         60dtCIwS1qUaOQC3h/2D/Vw15kIEeO0+zot0riQoCCav7KwUYy6D+EW73u43osbSIJzl
         up1OjesB8maK6jOTCpbaMZBtsmZy8FUkhF548dC2XOB4uruuB+5qSX6P/f5e/rTYf0he
         f8OUZqOl2qC6cnw+iMBUpdEnW3RFUnwhF2lyp8kO2qpzAwqxg0QfWJbyeKN8rVuc5Y3F
         NxkZYYWLgiE2op1iGIFil6oSQq69ute8D6t8DvY9KhjZmGbfCuqkdR4NIRQYzVFT3a8v
         q5sA==
X-Forwarded-Encrypted: i=1; AJvYcCU5CFnEyhSdh6kUm0Qv2/yMxZvSb4Otaf1ULthrLrQfAED6uG4LBgDz9l/py8LJDrrb8FWDf3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YySSexQ0rcvzGscAF1MkTxnT4+DFgC/fUBMNBJLL42nHfTdUnlb
	VuCE0cNmku0u5BYcVdFAlilVsCVocNWbbmF7MZzF8ArMqpVUHq62J9ellQGl5zE8Gg==
X-Gm-Gg: AZuq6aKBQk8F+KxxKMWDYKHEluJDl5tmMOS3ADlObnDtAxDOssNxiZC9041PVd13xjh
	9JBYRDt+xmd+vdH6HO2g0ea4iawmQAZCFnR+4JHZ+2kLMMefAo4ebsYng3q3vm/+G5oy41qCqws
	O49Gc+kUalP3NIgwxtrlfO8ZCyaFzvaajZGt0X/aTSxMu11tMuTg8J7KR6z6zEbvV6p89wXPFH8
	TtO2HVWPygv1d85he2+kqgjtDVAprr5nebSacGFSWaXXSJffVnJxRf8fKHrsAE6D8/qXzKXdcrv
	9RCcCSCwBkLTbdWHQ9ZYXjr3lFE6kRyC5J7iy8Lf7bgfzjAj2ZYIi4mhqEntVnFrVYFXyZtATPg
	PWvimUEWm8a5ICueI0VAAfwb4tU2+eGHGwESXqEesZscjoDT/N+2VJV6xQ91qjQhxGwJhFlqMuM
	s6MWO/VjCfvMUIUbY0zKjhEpehv9Di28Ei
X-Received: by 2002:a05:7300:cd8a:b0:2b7:1320:f280 with SMTP id 5a478bee46e88-2b71320f4f2mr1913474eec.15.1769024577414;
        Wed, 21 Jan 2026 11:42:57 -0800 (PST)
Received: from ?IPV6:2804:14d:5c54:4efb::1c9d? ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7171be2dcsm3022869eec.11.2026.01.21.11.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 11:42:56 -0800 (PST)
Message-ID: <e58a29bc-3512-47ce-80cd-6c96a879c9cc@mojatatu.com>
Date: Wed, 21 Jan 2026 16:42:50 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/7] net/sched: act_gate: add RCU support for
 parameter update
To: Paul Moses <p@1g4.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260121131954.2710459-1-p@1g4.org>
 <20260121131954.2710459-3-p@1g4.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20260121131954.2710459-3-p@1g4.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252042-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mojatatu.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3E3A75D545
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 10:20, Paul Moses wrote:
> Make gact->param RCU-protected and reclaim old params via call_rcu(). This
> follows the pattern used by other actions: act_pedit swaps params with
> rcu_replace_pointer() and defers free via call_rcu() (commit 52cf89f78c01bf),
> act_connmark uses rcu_replace_pointer() under tcf_lock (commit 288864effe3388),
> and act_tunnel_key does the same under lockdep (commit 445d3749315f34).
> 
> Dump readers in act_ct and act_pedit already use rcu_read_lock() +
> rcu_dereference() (commits 554e66bad84ce4 and 9d096746572616), so act_gate
> must keep old params alive past updates as well.
> [...]

I think you could've transformed patches 2, 3, 4 into a single patch.
Since all of them are RCU-related changes and they sometimes overwrite
each other.

