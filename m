Return-Path: <netdev+bounces-260248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C75FT3bnGkrLwQAu9opvQ
	(envelope-from <netdev+bounces-260248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:57:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC5C17EA26
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1662305562A
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5635137C0E2;
	Mon, 23 Feb 2026 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDRo7c/a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455837C0F2
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887418; cv=none; b=YAWDlVSommESakah+e2SSgC8jDX4v7wP/SvpqQ1u9M5P9IqQpY2UaoErXAlzx9bFATG6ZPBMuFK3k5qQHx5/gzYSh5BPWAgaZG+NuYwieTh+smNPcXjKXLfocaIV6HKOZRwNSkRpFASDrhUE0YseDuzbAJt1U4TqKP7aiBhhESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887418; c=relaxed/simple;
	bh=DUkTyKGB/IVtoxo7Kg6fQV2Tvv1Nrgck4ELGcRPgk+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/KliB/I87px48jP+X4CXkTHy1SZNWcZ5WMY1CQMyN5zLoIp5Pn2gifntSl0R07uYeJGAkymrQtVcoNz4BukcuscuQ6NOUgk7pZXvwydWycSrtAuEt1Vdgm1eG0NQix1756Ud2iW5Gra1YXNVbmbYapAzfUb6ZkkkKkDNqs4IZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDRo7c/a; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732165d1eso5237428c88.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771887416; x=1772492216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SR5HKpzVuRX7Twqj77rCyQFJXiGaeMsH0eCaYIewyPY=;
        b=QDRo7c/aYYB9Fa0KAp2ud4hB68tBSdm/RteIab4THuU53rzHFDj8vLDTfHPy8MshoE
         JTy2cOzvGRDA4FzQmgEAunzRLfTMdZOqYMjnvNNA7kYqKabBMMsjcQdn4JnQj31jijvn
         LKrq/2IiZLv11powlMQGM57CC0BKLMuP6Uyji/sqNb/sCIAvwOmVeTMUKN2HPeJgr/9z
         owdyPCZkwY3b0qJHSRk3tvBwxg+jVW0rJhu5TMlG8KSxCivbsgDv3kYF6ZahY+zEEtSk
         s+MRVVMH1nSccrKLso37IKNJjKKNtwKPCQqryvGY9vz9oF3kMPR/7v0IYuRr7I4XS83v
         c3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771887416; x=1772492216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SR5HKpzVuRX7Twqj77rCyQFJXiGaeMsH0eCaYIewyPY=;
        b=qfh3S3gDvdWqllB/wCxUTiTGDfEaDHtloDaUQZAFHWVSlCyHCvfhrI07H/d2oD6cZN
         DGoYcLEytLqQ5Dh9vjtXnkoTv6oS/2tuC0z8oa3sk5Xd1OHp/czHb3TuMlD8YXMaFFBE
         u60Dbquf92WD7oCvZWMWqIHzKa5gB/UfLT4e66DBNxjQicLqQqAgXA1z3hkLGlhNiJPw
         BGebMOMBaPimP+9c3YJEmUk2EiShXU7Cvc143DwWu2Nicv/I+6HZ3i34/EYpyY6uBWNk
         HHlQQ75w/bEIp1rpr21utAloP2bY+h0p6AIok/E1jmsZrI1eEEXH1WZstn2Xf7/M66QS
         TI7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG6ZNBx7lTxll/L1Vbb3VTq0G//J5as+Gh9RB2YXYcGItKwqDW46ykKjA61D9wNLyOPTTjxKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PurfC9/9ShLv2iuHnJijX0EV3kiIvLi66Y5czZYNgFptQQpE
	89ILyhai94ozbMFgCjFxG3r9MFQ2edPs+fuhbFZXbMbbmfdpIxT0+Wgf/0egyw==
X-Gm-Gg: AZuq6aJPKJiXPGygOJ2f0/YGDEEuyHWZNX4YC8eJ1tMZyVbc6ppiFmJPtxbjDnE3+vh
	6Yb/dlqUsn3+NDafjkhAyeuioLYqFii3VcQvY4ACtj5X5YELKfzh5jAlxfxBn8EYX4qndijGtEf
	fifLcjhPbzVEXiUxrV54cT8doZo+J7OTYNW7S9S5ScZH8/zUGOOPDE3UjpQZKrJQEJ3vtLyAHgk
	WNcO2LcfsLeJXkSyxGBgIlpRv8x2ckA7p8jhK6j3mYlIxW4xYPBei01yvClnnkrQhbtg2TKVuiR
	XbXRhuiydN5LZIxagDqZv+RjrYboDFOJu9fGqThtBFFAkjWiVUOBHTZv+yqpKjK5rOf1kMKtRJW
	B+W3lqJ1OoxZvQ1uOUNStx53xw0aZd1/VA/RA8sBjqBi3YWrC5xU6OJR/m8xaoIjyYZwLJlfxnv
	ur1Lr0xazIXgSr+CV6NSSNXq/GuhgYKZ8D/9el9jbg5XFtIg0F6+tPzg6hD78R3bvqRV+SuekNa
	rZF6APdc02nNJOAWCxeNzbQXY+YHnRPYEgcmuIla4AtzKSsVO/tkJUjOwz7CG5hZWKU41llCFJG
	7QruHUi66w0S30s=
X-Received: by 2002:a05:7022:1601:b0:11b:a892:80a5 with SMTP id a92af1059eb24-1276acfb85dmr3527019c88.13.1771887415982;
        Mon, 23 Feb 2026 14:56:55 -0800 (PST)
Received: from ?IPV6:2a00:79e0:2e7c:8:b343:b0de:3e59:4e65? ([2a00:79e0:2e7c:8:b343:b0de:3e59:4e65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af7b4c7sm8994469c88.9.2026.02.23.14.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 14:56:54 -0800 (PST)
Message-ID: <637edf98-64b2-4a04-8fa9-4a4b791d7d53@gmail.com>
Date: Mon, 23 Feb 2026 14:56:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/62] bnxt_en: Fix bnxt_dl_reload_up()
To: Michael Chan <michael.chan@broadcom.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
References: <20260223214950.2153735-1-bvanassche@acm.org>
 <20260223214950.2153735-19-bvanassche@acm.org>
 <CACKFLimX0PPJGeJMG-nycNMufbFsJ4YUTnGbLHC_20xF2n9OQQ@mail.gmail.com>
 <41c375cd-5c23-407b-9e35-8779f899ad09@gmail.com>
 <CACKFLinqWm7wbdgES_gpYNhQiZJ0cv=w0zpra8rXF=3jMQ+BdA@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <CACKFLinqWm7wbdgES_gpYNhQiZJ0cv=w0zpra8rXF=3jMQ+BdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartvanassche@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: AEC5C17EA26
X-Rspamd-Action: no action

On 2/23/26 2:37 PM, Michael Chan wrote:
> On Mon, Feb 23, 2026 at 2:27 PM Bart Van Assche
> <bart.vanassche@gmail.com> wrote:
> 
>> My understanding is that bnxt_dl_reload_up() is only called if
>> bnxt_dl_reload_down() returns 0 (see also devlink_reload()).
>> bnxt_dl_reload_up() returns an error code (-EOPNOTSUPP) for other
>> actions than DEVLINK_RELOAD_ACTION_DRIVER_REINIT or
>> DEVLINK_RELOAD_ACTION_FW_ACTIVATE. Hence, bnxt_dl_reload_up() is only
>> called if "action" is either DEVLINK_RELOAD_ACTION_DRIVER_REINIT or
>> DEVLINK_RELOAD_ACTION_FW_ACTIVATE. In other words, the code in the
>> "default" clause will never be reached. So I think the above change is
>> correct but also that the patch description should be modified to
>> reflect that this is not a bug fix. Did I perhaps misunderstand
>> something?
>>
> Yes, your description is correct.  So perhaps a better cleanup would
> be to remove the default case in bnxt_dl_reload_up()?  Thanks.

Hmm ... wouldn't that trigger a -Wswitch warning, a warning that is
enabled by default for kernel code? From the gcc documentation:
"Warn whenever a switch statement has an index of enumerated type and
lacks a case for one or more of the named codes of that enumeration.
(The presence of a default label prevents this warning.) case labels
that do not correspond to enumerators also provoke warnings when this
option is used, unless the enumeration is marked with the flag_enum
attribute. This warning is enabled by -Wall."

Changing "default: return -EOPNOTSUPP;" into "default: BUG();" keeps
the Clang thread-sanitizer happy but does not comply with the kernel
coding style. Does the patch below look better?

Thanks,

Bart.

bnxt_en: Suppress thread-safety complaints about bnxt_dl_reload_up()

bnxt_dl_reload_down() returns an error code for actions that are not
supported. Hence, bnxt_dl_reload_up() won't be called for unsupported
actions. Since the compiler doesn't know this, add unlock calls to the
default clause. This patch suppresses a Clang thread-sanitizer
complaint. Compile-tested only.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org
Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c 
b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 15de802bbac4..aa7ebd1426ed 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -562,6 +562,13 @@ static int bnxt_dl_reload_up(struct devlink *dl, 
enum devlink_reload_action acti
  		break;
  	}
  	default:
+		/*
+		 * Other actions have already been rejected by
+		 * bnxt_dl_reload_down().
+		 */
+		WARN_ON_ONCE(true);
+		netdev_unlock(bp->dev);
+		rtnl_unlock();
  		return -EOPNOTSUPP;
  	}



