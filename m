Return-Path: <netdev+bounces-272733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNR2NYN3x2nCXwUAu9opvQ
	(envelope-from <netdev+bounces-272733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:38:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DFB34D838
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DAF4300BDAA
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB82D3EE5;
	Sat, 28 Mar 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JcF7/mAR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F12877F7
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774679936; cv=none; b=BfYUmGLH9gJwzS7+ZneJMnSz2dmMEGiNKH5+derSR8ADwKBP10+3tsPJz/1PT3CWn3vR9fnPa38Oh+hZv96y/mS7xDcOgxQaHAmVNaRbQuY3pMvIbEPj6rjJtjStDWkJcM5IpFUvROqyL5U8Ks58zUZ2FjPF2ka1oNFvEZAwqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774679936; c=relaxed/simple;
	bh=Aqyxlcb9LcJkPu/f/zZ50VxBX8awcFdKj2BpXcy+8wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1LFEi7R6mJSzCxFB6FI0oEefQ7dOumcAigY+CxrBOQ37VO4MNeswwEHXBKHNkja/IIEKT+G2CEfR8cj4X131UeSVy1MmZLCGBmsHER6eTJNDA5HPTXT0kcR65Or1q8XhJojXV3Dj7tdFtqbd+cN/k1CPZ7fpla/pxWyk/0nS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JcF7/mAR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fb14227cso36031435e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774679933; x=1775284733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBLFnQ9HQVhO7qgyA4SBdWPPQilh86mTKClSB0mCE3E=;
        b=JcF7/mARwkmWNL8wWny/IvDn4iDxvoF02DNNzSO8RHmRsDnn9xShTLnMcW0k0aCZ3a
         4irSCQ0yoBlgjOtnvS2zb/lunY9S8sX/ostsWHkNgqqiOTpa2HYZpn2q6r8xRlKkmekl
         On7KIZNofbHlJVddBudBSMIEDQbtVZfnsBilUc1pyzRwM+48w2TfYeRuF06O2SliLVdi
         FtTylQaccdGuDj/mv0mFa6kSqttY3Go0Qj5I0IHK/N3eUkIBBlEPI1BkpMZ05Lfn1KMX
         xGfu+2k9sWyjQmUPCWBKWHmyK0jn9KSxU6W/wMugQM4UWPxy96VCeUixA1HJtoTyMPDK
         7yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774679933; x=1775284733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBLFnQ9HQVhO7qgyA4SBdWPPQilh86mTKClSB0mCE3E=;
        b=GP4BtvJDSoog6vNFav6MgaqpGg+5vNgYw+imYmVmsQbB5BETdSDqXJ5DEwztt/AVkk
         4mssZKBvbS6JLIe344BPIiEY/CBDFfPWjSPUj1QZHmBiWr6cNAzh98Mv0jEE/5dQ1X77
         +ps+qfMeRQywiBhXrEKaJZAwkCIvC/YmCOEWmnQe14dOJdB1s61Xdz8OBr6Pqzp//FW0
         YzgG5bSZdHiXGDNf7OS3G3NnAL8BugjkjXP7FWtsEzXYh93/2PAIhbTzCW+LjLwK+9O8
         POBLQk+fQfnBX8lvLSwuTKWcqokv43y6n99KBEdYTfsMFt9NLXJMLkiG9fvKkazX4TcL
         sDyg==
X-Forwarded-Encrypted: i=1; AJvYcCU5yH4wEzAqymZ2oIn75zGW4ODJioRc8/VplRwCZFKFjA6ITaeB+JS37NbOTuZR7wv0EKic4so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1fjiNjC+GpjqRSsYfXzCtqVOam9cARo+7AWGofBPDcSbTjTct
	LH95B0/qykwCuBstXj/YJSsDn12O0fxSLm4t7V0sXEwLp7bdJGEi5Gn2V2k2pWNksus=
X-Gm-Gg: ATEYQzwxFPuCzOfpZSUr8gjMXhJ22r00XkeiszfhIcfGUYBUPCLgSMlBQFO1hRLz8BZ
	LwVto6gByccFIE55q1Izq5suQjb3pwZagn9/jilIvyEia7kxoZem1K0priRzlVq2iAgTO/XYdF5
	oFav328O3kj2yZtZcAih8SsZ9IVJ5zV2BCGvTmT8nLSoniyau3/8zqZ5PyBzWabQC9IJRt6Owkb
	Qq5Pedc1GLuSCTnsUaFtPTw4y54t/S7FvERfdB111KrLs0xAxp7JUiwhv5s/SzxlrHPQRIaFE5T
	t/CO629bfqkWCnONO1OR2BRxYEHSlm3Jt4UZKAWCiQPRvMdkUUJjfUBENG+YWE/l0W570W0bFft
	UyVm7KIZ2DxCoS2zPxu/4mn7rIqNvpEMv7VAgR0zcHnNk/z92cnrzGMBeSEQCPbIoq26nRsUqud
	blK4Xhe/aAxO//WtzRkygLLQ2+FmsKgDhUZZRf22nFKuLBQQ95FwULTg==
X-Received: by 2002:a05:600c:a010:b0:485:3bb5:92cf with SMTP id 5b1f17b1804b1-48727e95a5dmr86834275e9.12.1774679933402;
        Fri, 27 Mar 2026 23:38:53 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487271a583asm30301225e9.34.2026.03.27.23.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:38:52 -0700 (PDT)
Message-ID: <1fee7395-ea68-460e-a47c-a61c191f5f43@blackwall.org>
Date: Sat, 28 Mar 2026 08:38:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
To: Xiang Mei <xmei5@asu.edu>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, bestswngs@gmail.com
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
 <cxf6kerzseqczgsdgznoqaxcgnx3hql65tbupt7rk4arjp6www@5jnc3nkrvljt>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cxf6kerzseqczgsdgznoqaxcgnx3hql65tbupt7rk4arjp6www@5jnc3nkrvljt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272733-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:dkim,blackwall.org:mid,asu.edu:email]
X-Rspamd-Queue-Id: 13DFB34D838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 28/03/2026 08:19, Xiang Mei wrote:
> On Fri, Mar 27, 2026 at 01:46:39PM +0200, Nikolay Aleksandrov wrote:
>> On 27/03/2026 13:34, Simon Horman wrote:
>>> On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
>>>> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
>>>> interval value from netlink without validation. When interval is 0,
>>>> usecs_to_jiffies(0) yields 0, causing the delayed work
>>>> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
>>>> itself with zero delay. This creates a tight loop on system_percpu_wq
>>>> that allocates and transmits MRP test frames at maximum rate, exhausting
>>>> all system memory and causing a kernel panic via OOM deadlock.
>>>
>>> I would suspect the primary outcome of this problem is high CPU consumption
>>> rather than memory exhaustion. Is there a reason to expect that
>>> the transmitted fames can't be consumed as fast as they are created?
>>>
>>
>> +1
>> More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
>> conditions. This is a configuration error and OOM doesn't lead to panic unless
>> instructed to. I don't think this is worth changing at all.
> 
> Thanks for your review. This path is reachable from an unprivileged user
> namespace. The capability check goes through rtnetlink_rcv_msg() ->
> netlink_net_capable() -> netlink_ns_capable(), which checks
> CAP_NET_ADMIN against the network namespace's user_ns, not init_user_ns.
 > An unprivileged user can create a user+net namespace, get CAP_NET_ADMIN> 
within it, set up a bridge with MRP, and trigger the zero-interval loop.
> This is not a privileged misconfiguration scenario.

Technically this is also conditional on configuration. It depends first if users
can create namespaces at all, then on the effective and inheritable caps.

Anyway, as I said in a previous reply, I'm fine either way. Please resubmit
with the fixes tag.

> 
> Also, the PoC can crash a kernel without "oops=panic" with this bug.
> 
>>
>>>>
>>>> The same zero-interval issue applies to br_mrp_start_in_test_parse()
>>>> for interconnect test frames.
>>>>
>>>> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
>>>> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
>>>> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
>>>> netlink attribute parsing layer before the value ever reaches the
>>>> workqueue scheduling code. This is consistent with how other bridge
>>>> subsystems (br_fdb, br_mst) enforce range constraints on netlink
>>>> attributes.
>>>>
>>>> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
>>>
>>> I think you also want
>>>
>>> Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
>>>
>>> As highlighted by AI review.
>>>
>>>> Reported-by: Weiming Shi <bestswngs@gmail.com>
>>>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
>>>
>>> ...
>>


