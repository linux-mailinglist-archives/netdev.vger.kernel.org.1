Return-Path: <netdev+bounces-272516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBZtN6xuxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:49:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E788343C29
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95763306C463
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1876B382F33;
	Fri, 27 Mar 2026 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="kH9/ie0F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0AE318B9C
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612005; cv=none; b=cMB9sCRQJxgfvMJxrqwN6X5JCWUe+cRX3uYVL4GEdrn6QMhn3mykn6fxDLxbG6jp6EpjHZSAnYx9qS6dJ/ymS0wtFx/1mljqJyEu2b7UPHqwIoZy+TrhtdZ0Ldxx6ErlE3KMsAR1doMPZKTWsOVjd6a1/LAX9rCPZqvkuC9aqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612005; c=relaxed/simple;
	bh=eKAy6z3eeID/ZV+oMTzobfIHdZrDrSWFIIM6feni8JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNpwzK20RMHupCKmX/hS0DCJaSpLmW36mfJACJ6DwfjYOVjGWuiUKnNIpYV+RR8uYAKp/XlqMpCJrjWn1WM3mCcl3/pVaICfA49gon+Lpw1lduWUlJ1vWzDEnDwKL4EjZr+JnDDaEN8aeplWcF/vkq1bhT5Fr7ZjHzz1+qsdvms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=kH9/ie0F; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486ff201041so18174075e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 04:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774612001; x=1775216801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dc8kZiAOVDqJfTCwQ4sp4VFOqE7cbWv8ZLlFBvNl/+g=;
        b=kH9/ie0Fcs5rxOJrRPQ1ijrAGhzQTDTiaikPoHHzsurC4eNZST/ixzBsg8vXC1ul/2
         vVVvYxVq+qtWQTxuPDBcw2hrvu+qlS76CLV1VxAlwImNQnqgLaSaTWRMQ3sT91C955YQ
         spM8C7zcFk58Pf6hpKxaa6ouE8WOnQm7xaxyA1PpST3kZNKO4f7dnHkh0cIZreIZXmqv
         iCBFHTLPSaMFGHN9znXnkPqUcUZbiMMuVvIlWaNj/5lcsPBKsvrreUUmJbkq5iawLS8M
         d1LXmkA1IbOel9jN2dZtRggCQz7VwGnFU7u/esDixTB83fcscuauTUfMABpwoBD4KEyl
         Icvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612001; x=1775216801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dc8kZiAOVDqJfTCwQ4sp4VFOqE7cbWv8ZLlFBvNl/+g=;
        b=GNqo7IF0fsRUKr7FABCRjTPWASZ5Zg93Oql5Lf436okCCsD2CP7TPUCm801/0AVScj
         dgXMgGKbxXId07NkIX7FB4/Boj6lqcMiOau3cxvOoWQX9p8F//jz5rMgOyLT2fGzgrhC
         2F6S2JWR1cgeqtJbS9sXEn4CPKCyVS5TPWRYeyR4hB3vwf+xvoHPPHNLhCjeygbSW+n+
         gquAh0Fv+X12NMCo9/m99e9S3vXsLygKRDH2bEbWXZ2jb8tzN9KzVap7QkcZXBKYU8Zm
         c+WvuYkmWNE2rd9G1uY2iHKiyqVccXaDbwHvbGcxyl2m2nskrercaRydeLWlwoUJgmD/
         IChw==
X-Gm-Message-State: AOJu0YwZsFPYMl8CprPiV3xNKCxOfYNgzDJU05u2wR6vjibtCttwTVwa
	51FoWUK0uKu1xRGd9+vW7DAExoCSyDxuRkR1diglScemLGu+3SNMWHOxnmIu+1mkz1TrlsDnWho
	n8uB3
X-Gm-Gg: ATEYQzwEGlldor6aYPe4D2H1+kGO7Xeon8CLQREbfCCbS+09AbzyKMUHLmwWPVcE0z/
	2dnzZWokHGuwkBfEDTlHDa01FGW38EK83G41FTz8GxS24fWyLlG02na9DH/x1BsLbobRyFQb1Sj
	4RAnCkj0XDS6h4TD+L76V7CxN1qn9HeKa8xIb+oj8Re/ez+dkOPn+FXb7eDxlR91gsCXKwsZoRG
	R5b40g0cvg9yBZCpgfGsZz17QnaLVnP4taEZGzUNg+88oOn7wE4r0ALUPlV+atGaXO7Et5+asg6
	TCtmn30/oxKJvWFjVAlp1P9fhurWariqwYsv7we90HXk7D6G5/33YVrNmUN8TOT9BMblw70Z1f3
	bcaCBsBSDeo5v54irTRzr0b/WJNLe7isyEIR80cQDC+A4rPMV6Kt5VtTF0UtOhD/A6HGxZOs/EA
	2ONe7+q/vAjTGWzzcZcslz4UnW38zzir/Z6+v++YIxvI7IW2q6C7IoeA==
X-Received: by 2002:a05:600c:3f0a:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-48727d5941emr40047055e9.6.1774612000783;
        Fri, 27 Mar 2026 04:46:40 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722cb0d83sm83129465e9.13.2026.03.27.04.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 04:46:40 -0700 (PDT)
Message-ID: <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
Date: Fri, 27 Mar 2026 13:46:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
To: Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327113412.GD567789@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272516-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,blackwall.org:dkim,blackwall.org:mid,asu.edu:email]
X-Rspamd-Queue-Id: 3E788343C29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 13:34, Simon Horman wrote:
> On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
>> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
>> interval value from netlink without validation. When interval is 0,
>> usecs_to_jiffies(0) yields 0, causing the delayed work
>> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
>> itself with zero delay. This creates a tight loop on system_percpu_wq
>> that allocates and transmits MRP test frames at maximum rate, exhausting
>> all system memory and causing a kernel panic via OOM deadlock.
> 
> I would suspect the primary outcome of this problem is high CPU consumption
> rather than memory exhaustion. Is there a reason to expect that
> the transmitted fames can't be consumed as fast as they are created?
> 

+1
More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
conditions. This is a configuration error and OOM doesn't lead to panic unless
instructed to. I don't think this is worth changing at all.

>>
>> The same zero-interval issue applies to br_mrp_start_in_test_parse()
>> for interconnect test frames.
>>
>> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
>> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
>> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
>> netlink attribute parsing layer before the value ever reaches the
>> workqueue scheduling code. This is consistent with how other bridge
>> subsystems (br_fdb, br_mst) enforce range constraints on netlink
>> attributes.
>>
>> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> 
> I think you also want
> 
> Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> 
> As highlighted by AI review.
> 
>> Reported-by: Weiming Shi <bestswngs@gmail.com>
>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> ...


