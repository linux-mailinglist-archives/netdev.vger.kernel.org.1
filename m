Return-Path: <netdev+bounces-214002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F106B27ADB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBA11C87999
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C361FAC4D;
	Fri, 15 Aug 2025 08:24:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030CDF71;
	Fri, 15 Aug 2025 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246242; cv=none; b=CiZH52GobooZO4z43SR1ZZkvdidDvqtn5LH/ZpzhkNz4YXacSswoGwTwBC6Rwn1UUk4RqORuVsYaNE5hPajavYDxKFIus5z6by0QAvxSmp6S8YfzFmVuWBIM73dD664pR9xoKqIFOegwevM15Fd1P4PtX1iLdVaJf04WdGtiuhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246242; c=relaxed/simple;
	bh=ER2ukscimwht73kLfrM+khgx7sIqkTSSbc7PrTo4M84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbdQLtonhWvpmYJ6oM5Ie8JL9mHWWKvcOvE+euxB/65nk9gkABtvvCLXarokDaeH8N0TmRR6xvmsoL5Bmw8r1tZ4EwCo8SJ2Je7QGEHGdz5FaIzWRdAM3A01zspD3eludfkZkR522xDKLDO667cQa4/a0qd8l5Sn35C89S/LtIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4717593371so151245a12.3;
        Fri, 15 Aug 2025 01:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755246240; x=1755851040;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnUmDGFjkvK6EGBJSNFaT5dG2DK3adFiwRq2/pRAI/Q=;
        b=C3It6XfZtidcdhG/iF35hXCg/OHkqgcUOUt3fcWvsept36y766Xqsskj9zTK62E+RF
         i9aWLViVAqV5Y/BYAKeOCu2fD0VTqy7Ws5uIQVgwV3djWIo41Il2ZFYUE2OsfNCgimlF
         k7beWuy7vEQ/vXEG9tfmTWFGUZ9H0+Zdfi+Dfuwz4umaUICI1cRst1pp52H2QzDDBXzZ
         EX5DH75TIA6TgrGc1UW7T7rjfW8C+ii42JofiFbqTnIrcSlef4Xwx1SUCvr0bRWyEcFy
         6BsbtyqYbJH0SRHpRZSbGNROIdMW615nSzETNeJ11g1y+UrGE0bpo6xyOkCD4TFNCyM8
         /mKg==
X-Forwarded-Encrypted: i=1; AJvYcCVdiDf2H+xebXabSv68V07SvZ13rU8Ra52wb6W4phSsOcMB47NdZ+Hs0biDvvETmborIF9cl19qRZYdQcg=@vger.kernel.org, AJvYcCWAzBXVkLw6BnNcvFZlkNgU55DwOd61r1oJSmCpzGFJ8hByU9TDFBf41OnKoZeU2DdtmDSchd9q@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFIpWeXpnQQTOnAYiiXzoGdOoRuhwfOPiW7Aad/pY0F4TZpA/
	Lh8q171ihkB58DvIzgax4TMtAq36lsMaNiD66aROq/x0bXK/QVtnWt1o
X-Gm-Gg: ASbGncs7zpXNPnOuuVlPjaaqYvjEWG3RQIa/tpT0d3md/Cw1MsduvrnICFKFk+DpgCn
	UiZj2M+zOhEpKZvywTSv0lZ/1zzv/xbIlAt+hZCojbiZlOFCeuE881rPE4x3EG4FomKh/hW2lRD
	BFO2o0LdJBv1C3TZC5zzF9kcNdbuLrPtRkkdOurk8MJBqLkG/ydt/2xiXxXMDHEfAxai+aFP3Ic
	K/z0Jeuba4luKAHoAad4ohYm5xdcOkLMxcgzkdgSFCTEmZr8x4jshx80HE814s2s0F9dal8aGZu
	SBo15Rnmn1L357OlzP47G5ojtLHi1AhsYN2+gMA+F6JM5VXiicGd+zcQtnV2IkpbUud6gsYlK4q
	UipImutlFy/5/lXIUooRAZuewq5KH8U+RZ18Uq9ttnSg=
X-Google-Smtp-Source: AGHT+IHWD+Bnk4L4dHnIDVIbG+ye0U5qD7F8KoEHkzFkyW+DMqlCF7IQBAkML14BDtGWdpU+Jz8cug==
X-Received: by 2002:a17:903:1a70:b0:240:11be:4dbe with SMTP id d9443c01a7336-2446d95b26cmr8476295ad.8.1755246240203;
        Fri, 15 Aug 2025 01:24:00 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cae0278sm9064575ad.43.2025.08.15.01.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 01:23:59 -0700 (PDT)
Message-ID: <b8dc1074-725f-4048-9af5-6b62bd2150a3@kzalloc.com>
Date: Fri, 15 Aug 2025 17:23:53 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/nfc: Fix A-B/B-A deadlock between
 nfc_unregister_device and rfkill_fop_write
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>,
 Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
 yeoreum.yun@arm.com, ppbuk5246@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <20250814173142.632749-2-ysk@kzalloc.com>
 <e3cfdd98-6c51-479d-8d99-857316dcd64b@kernel.org>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <e3cfdd98-6c51-479d-8d99-857316dcd64b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for your review.

On 8/15/25 2:55 PM, Krzysztof Kozlowski wrote:
> On 14/08/2025 19:31, Yunseong Kim wrote:
>> A potential deadlock due to A-B/B-A deadlock exists between the NFC core
>> and the RFKill subsystem, involving the NFC device lock and the
>> rfkill_global_mutex.
>>
>> This issue is particularly visible on PREEMPT_RT kernels, which can
>> report the following warning:
> 
> Why are not you crediting syzbot and its report?
> 
> there is clear INSTRUCTION in that email from Syzbot.

I wanted to clarify that this report did not originate from syzbot.

I found this issue by building and running syzkaller locally on my own
Arm64 RADXA Orion6 board.

This is reproduction series on my local syzkaller.

WARNING in __rt_mutex_slowlock

#	Log	Report	Time	Tag
7	log	report	2025/08/14 20:01	
6	log	report	2025/08/14 05:55	
5	log	report	2025/08/14 02:31	
4	log	report	2025/08/12 09:38	
3	log	report	2025/07/30 07:09	
2	log	report	2025/07/27 23:29	
1	log	report	2025/07/26 04:18	
0	log	report	2025/07/26 04:17

The reason this is coming from syzbot recently is that I worked with Sebastian,
the RT maintainer, to fix KCOV to be PREEMPT_RT-aware. This was merged recently:
Link: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-linus&id=9528d32873b38281ae105f2f5799e79ae9d086c2

So, syszbot now report it:
https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3

>> | rtmutex deadlock detected
>> | WARNING: CPU: 0 PID: 22729 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1
>> | Modules linked in:
>> | CPU: 0 UID: 0 PID: 22729 Comm: syz.7.2187 Kdump: loaded Not tainted 6.17.0-rc1-00001-g1149a5db27c8-dirty #55 PREEMPT_RT
>> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025

As you might notice from the logs (e.g., "BIOS 2025.02-8ubuntu1"),
the environment is Ubuntu image on my machine, which, syzbot does not use.

>> | pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>> | pc : rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1
>> | lr : rt_mutex_handle_deadlock+0x40/0xec kernel/locking/rtmutex.c:1674
>> | sp : ffff8000967c7720
>> | x29: ffff8000967c7720 x28: 1fffe0001946d182 x27: dfff800000000000
>> | x26: 0000000000000001 x25: 0000000000000003 x24: 1fffe0001946d00b
>> | x23: 1fffe0001946d182 x22: ffff80008aec8940 x21: dfff800000000000
>> | x20: ffff0000ca368058 x19: ffff0000ca368c10 x18: ffff80008af6b6e0
>> | x17: 1fffe000590b8088 x16: ffff80008046cc08 x15: 0000000000000001
>> | x14: 1fffe000590ba990 x13: 0000000000000000 x12: 0000000000000000
>> | x11: ffff6000590ba991 x10: 0000000000000002 x9 : 0fe446e029bcfe00
>> | x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
>> | x5 : 0000000000000001 x4 : 0000000000001000 x3 : ffff800080503efc
>> | x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000001
> 
> This all is irrelevant, really. Trim the log.

My apologies if the formatting and the log length were not appropriate. I
will trim the log significantly and review the subsystem's git history to
ensure the commit message format aligns with the expected style for
the next version.

>> | Call trace:
>> |  rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1 (P)
>> |  __rt_mutex_slowlock+0x1cc/0x480 kernel/locking/rtmutex.c:1734
>> |  __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
>> |  rt_mutex_slowlock+0x140/0x21c kernel/locking/rtmutex.c:1800
> Best regards,
> Krzysztof

I’ve added the syzkaller mailing list to Cc.

Thank you!

Yunseong Kim

