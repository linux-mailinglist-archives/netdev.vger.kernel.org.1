Return-Path: <netdev+bounces-279006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAFvNKHG4GmjlwAAu9opvQ
	(envelope-from <netdev+bounces-279006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:23:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589140D517
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376F93067064
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BD392C4A;
	Thu, 16 Apr 2026 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QPsa6x4S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2FE3909B0
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338315; cv=none; b=JSmsNDbnefL+b8ei3iN/hUEr/BzGhDOghhk1h0ER9wphylbAhYguV68b3WtqKcXKhWO3MN2uDSM0p2pTfegapBY+zCGLwThEtB4r//MLQfx6UJW1/hroleEqe+bZAXjFT9nuLvuExL+IWasDFBf305uZUGr7iuJZniOdvDhnnAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338315; c=relaxed/simple;
	bh=0I1hQQOfuGn7nbMyH5rccfAqTH9pDQIfcJ5oxQD7bhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4EQYIpPDKe6SMSFkykYL4inXo5iFGk6ONGzGfTU4zmaVZleSi+2IblQ+qqhVhnXr5OSHJaokh7yvRRcqR0pQQuptZl4yJ3tAG61uWuZibW7vtI/R6mFJpR/BWrTIQdjr3+rvlQ5/Zmh4dO8UpNePrvHJwNe6LoZkKufGWCjhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QPsa6x4S; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b8efed61so5957565e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776338312; x=1776943112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qd1VopekJz5FiTxyx67UMNjXFF9UUIXLsOl680XCCf0=;
        b=QPsa6x4SOVHFIcDZBLBIeYk2JTeQWGgH1I/3lTPPEg1m3CfUzXMuqkg1W7krRJmT8j
         9PXwgbaKw1ChOtXp26dqLlViRMzLu2DIJH1nHlwCGOHuo0AorVSeI1xTup0gRAjK2bQq
         h2BSS8KanKLcEwhgMrGj/RBly7Hb6Evel3xOgFrrlH8ZgdGbtI87vgHZknkFSC6QYc0y
         d55RgDHO4PWB//XwatZe0m+EOVhgp3plLy2baygOj2HBXeeG0OwHFIqcV8WGnHEDVEXZ
         v1AnAsdtZ6KLTgLiH/Fejvk9cpuu1fdVQ3GsqGpmBMFw9AxIVSFKWzwDj2V/vREOJjHz
         /XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338312; x=1776943112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qd1VopekJz5FiTxyx67UMNjXFF9UUIXLsOl680XCCf0=;
        b=XFfrpji/aPjAWvFjPmsjYBwutM1DslJ84daozozAyboeaDE19U1eTLEUP8QzoPb2xo
         xwx4FNPjJj7OqsXS8h4FJxTVXFdnMj2dpp3M4cagRmX6vPaFXi59/X8TRzTz1yBss9C7
         RKUElvzAqvzvfZDxYgWsyQlYGnqN3RSiy222X/+ikQkFpYUgcEi3NBiWhcf8XQr0+0ra
         CSFdm6r2KjMZHmq94wl1CScS5wg316AZlinzKnzkhP4nOqOmY4CA2lu/ar+wdG/aMPlT
         x6oW+yWgl3ZKy7InzgkU8diw5LX6UZVEHRH8M6S2Ny88UsQ8+XHs0oGofM1xkLSHpAOw
         SwDw==
X-Forwarded-Encrypted: i=1; AFNElJ/b/tymuaqbkGbDv+Wfkxtqjm7vq+f3TzdXI9Z7S3/68djTMkaq5yrIx6q1hjhSQKKH3381Pic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NI/qlQ8IehSdCi3YyXbmqwu0OkAt7kkgMnljM+dwfxYlkXBT
	MCayDb6gkWIe97BjDbuLi+vAbJEnU4aJIdx/NNWfEvUiqexxfEXKTrYVatUuRI+WDk0=
X-Gm-Gg: AeBDiesswM5HusVqmcxSdrxhcUwl57jE0c64uMX78vKDOcPkKK39n11nDQ9/10qobPy
	7dxvVZfgSeRF+j3vpDBrqO5mXWBIQsp1+vQuLMIYPj+zWB1TRP702FGcAU8TZ+E8nmADbXksOhn
	+iRatQEVUPkXlDqO+kmw7Qa1coWh87KykM1BO/6l5Wzsxpdgp3stYlelwiSHDVUsdA9d5tHivS+
	QwGnv+Nphk0lr8gOxbdV3l/nOcHRWR1A6ZjWRq7cQGMTNsL8aYxHfulQcSg8+UhJaZ+pkaQBgij
	ZYXM50kaOypy2RARtCzDVTAZaFGWyh1Q2cn6vI4AE0gADSJvKORXCMyUOOv9sBGL2pZRF1hAysN
	IQdsT9Kbs8xF4OTtVoky4NJPoHHtqQSV6OJM+utyzUlJPQhx/4yHEJ6mgvYbwiW801SGF9GisX+
	OmOxdmtQnk4kMurRWk+b0OYizKtqkha25afrYracCZw9dEek1aqAhVWwwO/2VfVEHzg0SvWLazu
	PJQcSQOFf8asgyEoRrnMg5cd1G2EC3h4yndqevx6Cj6RLoAA+u1XpiieARZg6LkDOoK+S1w+GjU
	TYxZ
X-Received: by 2002:a05:600c:31a9:b0:485:3038:72c2 with SMTP id 5b1f17b1804b1-488f4804d19mr27439205e9.17.1776338312207;
        Thu, 16 Apr 2026 04:18:32 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5ea9sm13089525f8f.21.2026.04.16.04.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:18:31 -0700 (PDT)
Message-ID: <1db425bf-58a9-4768-8c38-3ae25d7662a5@suse.com>
Date: Thu, 16 Apr 2026 13:18:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] kernel/module: Decouple klp and ftrace from
 load_module
To: Song Chen <chensong_2000@189.cn>
Cc: rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, viresh.kumar@linaro.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, bmarzins@redhat.com,
 song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
 jason.wessel@windriver.com, danielt@kernel.org, dianders@chromium.org,
 horms@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, paulmck@kernel.org, frederic@kernel.org,
 mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz,
 pmladek@suse.com, joe.lawrence@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 netdev@vger.kernel.org
References: <20260413080701.180976-1-chensong_2000@189.cn>
 <1191caf5-6a61-4622-a15e-854d3701f4fc@suse.com>
 <a35f5f94-7d5a-4347-974b-b270c89ef241@189.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <a35f5f94-7d5a-4347-974b-b270c89ef241@189.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[189.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[189.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 4589140D517
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 8:43 AM, Song Chen wrote:
> On 4/14/26 22:33, Petr Pavlu wrote:
>> On 4/13/26 10:07 AM, chensong_2000@189.cn wrote:
>>> diff --git a/include/linux/module.h b/include/linux/module.h
>>> index 14f391b186c6..0bdd56f9defd 100644
>>> --- a/include/linux/module.h
>>> +++ b/include/linux/module.h
>>> @@ -308,6 +308,14 @@ enum module_state {
>>>       MODULE_STATE_COMING,    /* Full formed, running module_init. */
>>>       MODULE_STATE_GOING,    /* Going away. */
>>>       MODULE_STATE_UNFORMED,    /* Still setting it up. */
>>> +    MODULE_STATE_FORMED,
>>
>> I don't see a reason to add a new module state. Why is it necessary and
>> how does it fit with the existing states?
>>
> because once notifier fails in state MODULE_STATE_UNFORMED (now only ftrace has someting to do in this state), notifier chain will roll back by calling blocking_notifier_call_chain_robust, i'm afraid MODULE_STATE_GOING is going to jeopardise the notifers which don't handle it appropriately, like:
> 
> case MODULE_STATE_COMING:
>      kmalloc();
> case MODULE_STATE_GOING:
>      kfree();

My understanding is that the current module "state machine" operates as
follows. Transitions marked with an asterisk (*) are announced via the
module notifier.

---> UNFORMED --*> COMING --*> LIVE --*> GOING -.
        ^            |                     ^    |
        |            '---------------------*    |
        '---------------------------------------'

The new code aims to replace the current ftrace_module_init() call in
load_module(). To achieve this, it adds a notification for the UNFORMED
state (only when loading a module) and introduces a new FORMED state for
rollback. FORMED is purely a fake state because it never appears in
module::state. The new structure is as follows:

        ,--*> (FORMED)
        |
--*> UNFORMED --*> COMING --*> LIVE --*> GOING -.
        ^            |                     ^    |
        |            '---------------------*    |
        '---------------------------------------'

I'm afraid this is quite complex and inconsistent. Unless it can be kept
simple, we would be just replacing one special handling with a different
complexity, which is not worth it.

>>
>>> +    if (err)
>>> +        goto ddebug_cleanup;
>>>         /* Finally it's fully formed, ready to start executing. */
>>>       err = complete_formation(mod, info);
>>> -    if (err)
>>> +    if (err) {
>>> +        blocking_notifier_call_chain_reverse(&module_notify_list,
>>> +                MODULE_STATE_FORMED, mod);
>>>           goto ddebug_cleanup;
>>> +    }
>>>   -    err = prepare_coming_module(mod);
>>> +    err = prepare_module_state_transaction(mod,
>>> +                MODULE_STATE_COMING, MODULE_STATE_GOING);
>>>       if (err)
>>>           goto bug_cleanup;
>>>   @@ -3522,7 +3519,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>>       destroy_params(mod->kp, mod->num_kp);
>>>       blocking_notifier_call_chain(&module_notify_list,
>>>                        MODULE_STATE_GOING, mod);
>>
>> My understanding is that all notifier chains for MODULE_STATE_GOING
>> should be reversed.
> yes, all, from lowest priority notifier to highest.
> I will resend patch 1 which was failed due to my proxy setting.

What I meant here is that the call:

blocking_notifier_call_chain(&module_notify_list, MODULE_STATE_GOING, mod);

should be replaced with:

blocking_notifier_call_chain_reverse(&module_notify_list, MODULE_STATE_GOING, mod);

> 
>>
>>> -    klp_module_going(mod);
>>>    bug_cleanup:
>>>       mod->state = MODULE_STATE_GOING;
>>>       /* module_bug_cleanup needs module_mutex protection */
>>
>> The patch removes the klp_module_going() cleanup call in load_module().
>> Similarly, the ftrace_release_mod() call under the ddebug_cleanup label
>> should be removed and appropriately replaced with a cleanup via
>> a notifier.
>>
>     err = prepare_module_state_transaction(mod,
>                 MODULE_STATE_UNFORMED, MODULE_STATE_FORMED);
>     if (err)
>         goto ddebug_cleanup;
> 
> ftrace will be cleanup in blocking_notifier_call_chain_robust rolling back.
> 
>     err = prepare_module_state_transaction(mod,
>                 MODULE_STATE_COMING, MODULE_STATE_GOING);
> 
> each notifier including ftrace and klp will be cleanup in blocking_notifier_call_chain_robust rolling back.
> 
> if all notifiers are successful in MODULE_STATE_COMING, they all will be clean up in
>  coming_cleanup:
>     mod->state = MODULE_STATE_GOING;
>     destroy_params(mod->kp, mod->num_kp);
>     blocking_notifier_call_chain(&module_notify_list,
>                      MODULE_STATE_GOING, mod);
> 
> if  something wrong underneath.

My point is that the patch leaves a call to ftrace_release_mod() in
load_module(), which I expected to be handled via a notifier.

-- 
Thanks,
Petr

