Return-Path: <netdev+bounces-280051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMftJfY752no5QEAu9opvQ
	(envelope-from <netdev+bounces-280051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:57:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A0438763
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 047773020A5B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2E38422F;
	Tue, 21 Apr 2026 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQmB7H9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37D739FCC4
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761664; cv=none; b=TQz7UxMtTlU613NV9XnERE7tHTf5SB151aSWdOYPTtf8QghMzynfibwu/xVZhryTHEzu9UES/MdhbleSJ3abfCZcDMkuoK2F2SEv3aYwmp30NGQR2Ez6ij1M3e/xGiVtvtslCbzdFJdxEQr3Xgv0/mHc36KZVnrPCN4Ffj9WTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761664; c=relaxed/simple;
	bh=dU+9BdjF0sSpHUJiYDtB2Gktv8KhihkDTc5ZL19RUS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTRP1ESQC6QaRLyx6FlTe+Y+2cjOCzXl7vHr/T0Lp0HxZNf5rfPdZpLKYaF3nu2DOUlSWOLh51Q8cxARoi2piTyIrjXn0V1pLiAVtM6NzTLsVRwp5Npnm3wdC5RfVy/l77Jk+qqX2S1viwlyF58xg6vxof0fGS35hiMSrEoFnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQmB7H9P; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d64313c39so3101379f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761661; x=1777366461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dU+9BdjF0sSpHUJiYDtB2Gktv8KhihkDTc5ZL19RUS4=;
        b=pQmB7H9PSuVCeV4gvVpOUYrI8dfQSrQXvkgXB94m8YT/mrqlLvy9G1UeC4SKORnoVx
         0Xdg+wlggpl+9vxIg+pTOYaN0t8MXTHj4xwJnwTMhf0Mc+tWU9mcTWjTk3p71IWJr5Vk
         M57UvSSo1OBhV+Qsfqhi6vuaFAylrnYMLjbItZaNe+c9jLmCaz2r9im3BLO24xNYy+BZ
         I9qPLWYfwnomtCXhTfenvaqFeiChZ05+2c9Kok5NP5Dfq2woAqLb8Uu8jla5Qj3FZ2Q/
         xwBdDBexooAf8I6Ns9kTnTt+iUgifxZNEm5qxxnpPt1c9Fn11255eVRip3RuOQfH2D8q
         j4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761661; x=1777366461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dU+9BdjF0sSpHUJiYDtB2Gktv8KhihkDTc5ZL19RUS4=;
        b=JTJWRSb0au8O0mDXvbOa4SHNprdSNpwA83dpO4Ioh0Sq+jMCKOXdboYrBG+IiML7KT
         LefDz/3AflYgvNAnY8wQvxS01NGA24KFNWhHpW+aYap7rClC6oKIvnDmdpAMe+mxFHH+
         xwG0amFj+rTYTgREVknNwWTbF9NGO82OLBz0ClIs1roy1HgqdAaePnv//M1uA3zUOKiP
         z1wu0XwtNcXyAewJIdiG8Pc2rC6HhtHdYCgJBhZObQ3SQ2i5LxWJy3XBxB0xxHXFxt/i
         eFkNSetL65t9FHI0sR1eo90fRvD8e18zHkL5mR3cSI5Nep1yoUN6Uzt66fuyboFz7t60
         n7mA==
X-Forwarded-Encrypted: i=1; AFNElJ+VawpltGt881WWES9FguNrflQIfm6iy4WqKVI6pICBBLOe0bMaVChkF80VbRDcjXKHoatBpvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJiyOw4L6ORnoaHfoO8SRUS3fMWnfRzitVu2cJULha1SY57v7z
	hVQjcUj7UinIgmnL96p892ZCZpeMKDcECj2n/NM1QI4cSSKWgv3sXjnx
X-Gm-Gg: AeBDievxslLE95boH/wRhL+17Vo4Q2uh77z6hhfpjkQ6m+59xrQ9r02dqrfSGgcMof5
	ZbGS6cQFmYbuRTowEL+/z6rA5eCwR6ocq5CnJwKp21N1Ukzl1akhLRvqIGI0oXKitlbATfVyJUW
	Il7Y5iNcu/48gDewSsusPqMS+9QqMO/SFbhthrAnUUTA9utE3J/YqwmHhtOAGRrQ9/yZwDwcX1W
	6tDZ7Q3Ww+YR3BUTPshBk9SsSbxslduQw/RMqRLEGMqlb7Fx1rb5IPbqA+OdveO40Enp1qT6P4B
	kQajgvh/AAVIctmOn2Aa1L+WGYqGycn8CCYuSw7/MyPo66ay1akjr/wTGwd+hilIuBRYKVoq9xq
	7ssXErow7UAH1QnhTvTwRfeYICYp4haJ3b0vFi7GfhBLBkg9g9zv6S2WceesyJT0MkTwfSNzHBC
	k9QMgsYvOKvXPhAtL+HORngGfg7uUy5gNYn8yo
X-Received: by 2002:a05:6000:24c7:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-43fe3dfbe4emr25790843f8f.24.1776761660781;
        Tue, 21 Apr 2026 01:54:20 -0700 (PDT)
Received: from [192.168.1.169] ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1249sm32516285f8f.5.2026.04.21.01.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 01:54:20 -0700 (PDT)
Message-ID: <9ce273bd-6912-4442-8672-4c89bebf32ed@gmail.com>
Date: Tue, 21 Apr 2026 11:54:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdevsim: Initialize all fields of ip header when
 building dummy sk_buff
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260421073738.22110-1-zlatistiv@gmail.com>
 <aecyEArzjx8KRp8-@gmail.com>
Content-Language: en-US
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
In-Reply-To: <aecyEArzjx8KRp8-@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280051-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlatistiv@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B08A0438763
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/21/26 11:19 AM, Breno Leitao wrote:
> On Tue, Apr 21, 2026 at 10:37:38AM +0300, Nikola Z. Ivanov wrote:
>> Syzbot reports a KMSAN uninit-value originating from
>> nsim_dev_trap_skb_build, with the allocation also
>> being performed in the same function.
>>
>> The cause of the KMSAN warning is a missing assignment of
>> the tos and id fields of the ip header.
>>
>> Fix this by calling skb_put_zero instead of skb_put to
>> guarantee null initialization.
>> Additionally remove the now redundant zero assignments
>> and reorder the remaining ones so that they more closely
>> match the order of the fields as they appear in the ip header.
>>
>> Closes: https://syzkaller.appspot.com/bug?extid=23d7fcd204e3837866ff
> How do you check in the report above that the missig un-initialized
> fields are "tos" and "id"?
>
> Thanks for the fix,
> --breno
Hi Breno,

I don't think it is visible here, my guess would
be because the checksum calculator walks the
header in small chunks instead of referencing
its fields.

The whole "KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt"
doesn't really sound quite right.

Thank you!

