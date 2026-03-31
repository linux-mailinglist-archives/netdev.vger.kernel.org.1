Return-Path: <netdev+bounces-273741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAHEDJk0zGlRRQYAu9opvQ
	(envelope-from <netdev+bounces-273741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:54:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5C3714A2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0041F3046010
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4E38F937;
	Tue, 31 Mar 2026 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AVi788HZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8838A709
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990312; cv=none; b=FyvzPLa3MIB7Awwvw83D3qMYZ+efHeHgpH1AGaqHL39u85hFvOred8R53bZ/Uv2iBwsNWngqpN40cQaUcA1PX4ZZPVVtXsl3vMBCMPipu9OLHYwNH4GS1smOq4vLuEN6fFOEbuXWBxJgKefk8dQJjl7JMPRsefwUygtMNhieIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990312; c=relaxed/simple;
	bh=BCBKSZPgsnAvDjCkRqWar0h4C1Ove21C+k5VGe7NiAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InchDpvlItnDNHE0qRB0CJGQ6O8KWlFM/r7iD5g0sNfEDbw+e8257i6w1A/BrqwbJD4FnI7PcyqEfapYO19oYf0wSf9Giv4EyTEhvpe43oItcVXN394j+G1y2v3K65ghAg02bn9k80Om9eiUKhR1RczwJTkvhepboYCMcQJF1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AVi788HZ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4152698e745so2275657fac.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774990310; x=1775595110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPxujRuDJNBuq85g1+QT32s/1EHULkgoYUEENR2udqE=;
        b=AVi788HZmEjtpsq1GAzi+q7nB8LFJHTAAFPe1QmA89KPzlVLXcwBRfKM6ZVzuuOMe+
         L2BrWiNfeVV5m+qmhjnC+stDrArbDAs299HrSLeT3AkcLzeo6qRyuLv1X5eB8Eu7HhI+
         TBWvi2C5O/ICnFWqlN+4EzU9ZM0tFKpX6VDBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774990310; x=1775595110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPxujRuDJNBuq85g1+QT32s/1EHULkgoYUEENR2udqE=;
        b=lnmPJBz5qlkq/Otb7dN4WYNw3D9CDSxlG5inb6ZcLS00pCPso1FOoShGMDcklbv9MV
         BiO4XofisLpXmdw9IIqYHty3wlC4G0+wUHDHVfH30ZT6DRsY6btKYd3iVB+3HPdahtGA
         WoR/QnmB9Mm7FP0eVTceiRs3M22SHaz8qOvJPhq92bRtw6LOM8WvUTDyd5bz2GhiBLpw
         nqWc3A+fVSVosb7JlqPrEXX0mfmRQD4Vq3Bh86VrMLJDDc4X6xEVtjaIcYjUFq4Imu+2
         2UFhOhAtgLNeoq/IhRQAAb0tUYWuQ03rouL3A7QktAQ6WHgE3+e2JSOLPO8oG+70CPDc
         wYmA==
X-Forwarded-Encrypted: i=1; AJvYcCUl/mp3qPVU4DLsYiZ0KnBNNt14F4FaahQomF/Kfao/RduwrB57hUac7qCT5zjRHJBR2WRS40w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0LTbL+cttFEvmKJofIf1kZj3nh9S/sslfeZr3NmByd4ewSqL
	ZqswtQTdSWKupw0B+u98b4IHNOGAfe/C7IuNFo30Z4htxqFwbryI/a1YcEjC0a/+/Lg=
X-Gm-Gg: ATEYQzxwpKcro0T0oDrU3IsXbF25SNgZJCuxvwaG7LODMIdCnNcER6NUGTBLKswvTJK
	21IXDz2CB2poWYwF/DyVzHVZKv+7CXFwTrRKFh8QQH6SuyWeism/eSlOpQX45SQieaIVyo6rNgm
	GmmUel/N/Q2i9ru9GiZtgXrRfrgZBX4ul6UfDLYWP/5vsk/x0VrNrj1BvnkdomSEMrNbolx8HTn
	GPFsez+1Sxyxm6/5coOpWwN9HgytfO/flH/MvZAm+sHz6N+iWYVD9iAWLaWA3AC4AoI4ZJPHL3s
	leHh/Jcp4MBkIx+Ix4sXrLcoE8AvUMUhhA5vasgXH1YW+D5OBwQrK4cgdTz9bmJybCFUWMHDRF6
	cVpWs6y8rBpRQtxEeVsY+B43URUyHnEnEtb9O2v15rCkrSxiXuACkyi1kXe/OjjIhX8mNerud8X
	nMSMuoW3FZeHsjAzV1O4FTmnzeJZKKWv6M5e4=
X-Received: by 2002:a05:6870:9e85:b0:417:2a17:285 with SMTP id 586e51a60fabf-422cfeb90d6mr707537fac.30.1774990309601;
        Tue, 31 Mar 2026 13:51:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04c88da4sm7412825fac.12.2026.03.31.13.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 13:51:49 -0700 (PDT)
Message-ID: <014b54f0-c4a6-40f2-afd0-0ea3e2f796e4@linuxfoundation.org>
Date: Tue, 31 Mar 2026 14:51:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] selftests: Use ktap helpers for runner.sh
To: Hangbin Liu <liuhangbin@gmail.com>, linux-kselftest@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, Brendan Jackman <jackmanb@google.com>,
 netdev@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260225010833.11301-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260225010833.11301-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273741-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,run_kselftest.sh:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 88A5C3714A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2/24/26 18:08, Hangbin Liu wrote:
> Instead of manually writing ktap messages, we should use the formal
> ktap helpers in runner.sh. Brendan did some work in d9e6269e3303
> ("selftests/run_kselftest.sh: exit with error if tests fail") to make
> run_kselftest.sh exit with the correct return value. However, the output
> does not include the total results, such as how many tests passed or failed.
> 
> Let’s convert all manually printed messages in runner.sh to use the
> formal ktap helpers. Here are what I changed:
> 
>    1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselftest.sh
>       is the only caller of run_many().
>    2. In run_kselftest.sh, call run_many() in main process to count the
>       pass/fail numbers.
>    3. In run_kselftest.sh, do not generate kselftest_failures_file. Just
>       use ktap_print_totals to report the result.
>    4. In runner.sh run_one(), get the return value and use ktap helpers for
>       all pass/fail reporting. This allows counting pass/fail numbers in the
>       main process.
>    5. In runner.sh run_in_netns(), also return the correct rc, so we can
>       count results during wait.
> 
> After the change, the printed result looks like:
> 
>    not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1
>    # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
>    ]# echo $?
>    1
> 
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> 

Applied to linux-kselftest next for Linux 7.1-rc1

I had to fix commit description and long lines in change log.
In the future make sure to run checkpatch to catch errors
related to commit descriptions.

thanks,
-- Shuah

