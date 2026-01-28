Return-Path: <netdev+bounces-254137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFPAEfC3eWl5ygEAu9opvQ
	(envelope-from <netdev+bounces-254137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:17:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E524C9DA7E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92FC230312D4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C88328247;
	Wed, 28 Jan 2026 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT6cLG9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312325782D
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769584501; cv=none; b=NkeOirKHVFsh56J9V4N+If7HwcqonVM2smf0Jik5WWIjbHKpbMFxJWbGw/cterj/m8crElsW/dsqYwytc2korEE+d/lDeU4XnnYq0eyY49yKov0KiLL71BQuVoXxNUSVWoPNHfAkeCJ8j/+EaYd/iEiT7y7JNiRPqDkdn4YgFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769584501; c=relaxed/simple;
	bh=V02HxfQ9RsspwOQYXSjiv9STuyAvNPhJsf92qGNWRO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVPPE9AFhDR/IzsQDcsZDwLMjAOjr9XJCF6lJ/8R6a+86R56j9DF127fyGMYidjhpwMZ74TvNGCbK01XN0p4+6lraFINElBReCWdM9Dd8H9ws2KQ5y9gQgV+ZVVkf+VUpllhaG2tpCJhrlJX4b2kupJWVPManB0+xLeHwGz2ERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT6cLG9s; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso4578995e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 23:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769584498; x=1770189298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4mHnmREA3ivtce+rHh5XeeKRw0SRT5qe2A7xs9am0M=;
        b=UT6cLG9sayoG2B72rocJ2Vho62g0ZnQwAzV/ivmMSRR11QxtGXwU8VI9FxY/gEFxLv
         hFTD/I19i/ccCn1hpbkzrFbMhPD/268Iut+AtLHEMeEM29IZc3iC9NDyOJTnmqUt+mcq
         jdMBaRgk1fLTMAJ0mFaIdm8irDQWV4eYIEJ/fklnjOpVdYgivWh+CTV7Cp0/kf1JVbjx
         fQSZsLOZrgV5YsdHw7po6t3Nl96erC04yDFTi3ksCzvvxqbxwL+HGaDxmJiALTV7/Px2
         5fCPPtawYGu7svSEVqn2rzDBOmSgBGPAlH5A4YsjNwa4HKi9/eFDObG6jvv2XOJV9ial
         QFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769584498; x=1770189298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4mHnmREA3ivtce+rHh5XeeKRw0SRT5qe2A7xs9am0M=;
        b=qUDf028OW69Rm/Rkq6tFlzKsPp6q0RGa+fKF0X7gPe9t4B8Zz5ZFehzmdlhZ1NxBS2
         dw/F/Za9NT9mzAdoosjOnZl72XYzuyO2LdXYljs/TbMD4hf5Yf0XDdm1aSSXhcBNQ1zC
         W1MP2n0NTbzIwhOCzUaQgr5Vb4x3nD804wALjyuXYvHM2/Iz86l6r2plleUXV0X3gn1m
         4djffclKML71iJgVLk+YTnVMxlxQae/XnZhCKuwOpYXqQ1dNQD9U5VYupLdLDQVsCKSV
         dSrdUbdBBI51vP9Gr5XF8NeEEBiD1/sVeIjM6i0qYggT5AI7t/+D/8qCtCnSCchgyZmk
         w+1w==
X-Gm-Message-State: AOJu0YzUyqJg83D89fqqLNQDhMYlHhq18N9riocWfn1OoP7BFj9ZHuQA
	Pgc9mfPXYP4lj4A1OyGJX/0A/cHcEo826oHYAUqgMgtBRkvRjFp8LS81
X-Gm-Gg: AZuq6aJ5tR30d15IYAa8MI5JqtuYm0L0kd+nNK3SpJ8eaJIbM28Pc249SvhRs2kI0Bt
	B6uD6mJi/6WEVleqvlsxuEV6qFjuY0l51SGkVQG3+t46KiTWPtFgcZtPWljlXRZVaqeTwSByaMY
	d/f0imB4ckbT4d+fAPr3xH+MJ5zeOZknlF3R2hK3SXXAn/KQnVGYqrnNvF3u/haDkhYGaaJHJqv
	gsdkz9NvCVbXpQKKpyW240i+7lQC+/Pg1rhbKo+0minWgMpTLe+84yTXxCW7XfxNJo7P82CnUu3
	GXueoZojsMwXkTnRRHP90eTPXDwStDAX6v5FOvaxdpLH3TzwMpWKA1AmI2NbviQTyiLwzNGDQwb
	2dyIgZdezvNR/V5X3G1MwOabsvrY/cunRDvGNUsw+O3i2JCY9iP9vraFsUpxb1Zw5B4m27y99Gv
	CWwOHIKpgqHWmmjkPJ+/bGcK2sTsGF
X-Received: by 2002:a05:600c:620b:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-48069e79968mr50923575e9.12.1769584497835;
        Tue, 27 Jan 2026 23:14:57 -0800 (PST)
Received: from [10.80.1.200] ([72.25.96.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d255d2fsm19375925e9.1.2026.01.27.23.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 23:14:57 -0800 (PST)
Message-ID: <ba9b732c-7c83-4837-9310-02b6a133169f@gmail.com>
Date: Wed, 28 Jan 2026 09:14:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC mlx5-next 0/1] net/mlx5e: Expose physical received
 bits counters to ethtool
To: Kenta Akagi <k@mgml.me>, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0106019bb70737d5-06bcc3e0-d534-4e42-b8a3-71dc3b53f318-000000@ap-northeast-1.amazonses.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <0106019bb70737d5-06bcc3e0-d534-4e42-b8a3-71dc3b53f318-000000@ap-northeast-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E524C9DA7E
X-Rspamd-Action: no action



On 13/01/2026 13:04, Kenta Akagi wrote:
> On 2026/01/13 15:43, Tariq Toukan wrote:
>>
>>
>> On 13/01/2026 8:31, Tariq Toukan wrote:
>>>
>>>
>>> On 12/01/2026 9:03, Kenta Akagi wrote:
>>>> Hi,
>>>>
>>>> I would like to measure the cable BER on ConnectX.
>>>>
>>>> According to the documentation[1][2], there are counters that can be used
>>>> for this purpose: rx_corrected_bits_phy, rx_pcs_symbol_err_phy and
>>>> rx_bits_phy. However, rx_bits_phy does not show up in ethtool
>>>> statistics.
>>>>
>>>> This patch exposes the PPCNT phy_received_bits as rx_bits_phy.
>>>>
>>>>
>>>> On a ConnectX-5 with 25Gbase connection, it works as expected.
>>>>
>>>> On the other hand, although I have not verified it, in an 800Gbps
>>>> environment rx_bits_phy would likely overflow after about 124 days.
>>>> Since I cannot judge whether this is acceptable, I am posting this as an
>>>> RFC first.
>>>>
>>>
>>> Hi,
>>>
>>> This is a 64-bits counter so no overflow is expected.
>>>
>>
>> Sorry, ignore my comment, your numbers make sense.
>> Maybe it's ~248 days, but same idea.
>>
> 
> Hi, thank you for checking.
> 
> Ah, it seems I didn't realize it was unsigned, and I also forgot to
> include the expression. Sorry about that.
> Yes - at 800 Gbps, 0xFFFFFFFFFFFFFFFF / (800 * (2^30) * 86400) = 248.55 days,
> so it will overflow.
> 
> In practice, is it possible to expose this as a statistic via ethtool?
> Or is there some other value that could be exposed for BER calculation - e.g.,
> a register that indicates the elapsed seconds since link-up?
> 
> Thanks.
> 

Hi Kenta,

You will find "FEC histogram" feature useful.
It splits the errors into ranges (bins), and plots a counter for each bin.
There's also a bin for 0-errors, which is what you're looking for.

Example output:

# ./tools/net/ynl/pyynl/cli.py --spec 
Documentation/netlink/specs/ethtool.yaml --do fec-get --json 
'{"header":{"dev-index": 5, "flags": 4}}'
{'active': 50,
'auto': 1,
'header': {'dev-index': 5, 'dev-name': 'eth3'},
'modes': {'bits': {}, 'nomask': True, 'size': 125},
'stats': {'corr-bits': [2810],
            'corrected': [2123],
            'hist': [{'bin-high': 0, 'bin-low': 0, 'bin-val': 235826196705},
                     {'bin-high': 1, 'bin-low': 1, 'bin-val': 1436},
                     {'bin-high': 2, 'bin-low': 2, 'bin-val': 687},
                     {'bin-high': 3, 'bin-low': 3, 'bin-val': 0},
                     {'bin-high': 4, 'bin-low': 4, 'bin-val': 0},
                     {'bin-high': 5, 'bin-low': 5, 'bin-val': 0},
                     {'bin-high': 6, 'bin-low': 6, 'bin-val': 0},
                     {'bin-high': 7, 'bin-low': 7, 'bin-val': 0},
                     {'bin-high': 8, 'bin-low': 8, 'bin-val': 0},
                     {'bin-high': 9, 'bin-low': 9, 'bin-val': 0},
                     {'bin-high': 10, 'bin-low': 10, 'bin-val': 0},
                     {'bin-high': 11, 'bin-low': 11, 'bin-val': 0},
                     {'bin-high': 12, 'bin-low': 12, 'bin-val': 0},
                     {'bin-high': 13, 'bin-low': 13, 'bin-val': 0},
                     {'bin-high': 14, 'bin-low': 14, 'bin-val': 0},
                     {'bin-high': 15, 'bin-low': 15, 'bin-val': 0}],
            'uncorr': [0]}}

