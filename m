Return-Path: <netdev+bounces-273922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMTfBrDEzGkWWgYAu9opvQ
	(envelope-from <netdev+bounces-273922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:09:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5494A375925
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25439301F9C4
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB709365A11;
	Wed,  1 Apr 2026 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9u+m+mX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058231862A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027143; cv=none; b=k+gaPnSY2R4LYzaKwAJSJhCF1dX86sFEIIHyLRc0bK41R2z60ftUkFA08E2YyfNSME4IJUmk2xJsHgrB60C0i7UpoXjEi1GeVQtNXn81OS0AM00W0oW3F5ibQzSO8HRmsCJedVUVVRw7BDlIihe2M0GWtiMkfwGsR4qzmq8/VVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027143; c=relaxed/simple;
	bh=nkfTSXkHDQALVkJyo9syyUwoes0S5BnMY1bB+MUmhGk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TBmeIvEI5L2TQ1PLHX2AAWqke+Cbr6nMhV7vaNaixw5m9/Very0pB/iCujxObUWBPtjXw7rXGeNLS1hFbnDWTQwRkhiL2WrrUhukMeeVeUiZeoaVhLJXCG6kcjvF98g1avaGhSOp74zjf8bZs7ccRIaL9rxtqd2TkEla4zrtzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9u+m+mX; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12732e6a123so2844401c88.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775027141; x=1775631941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkfTSXkHDQALVkJyo9syyUwoes0S5BnMY1bB+MUmhGk=;
        b=b9u+m+mXpaRi1P5YBCIAu8L3owYub7/5F9B6ucNY5skv0QKtxczeAnkVB2+XbKSkdr
         XtR66J9qQsvU7BUhfAoxWrMmOZ84K3EIPpl0EfIMqQZjLnnG8Wmcbv9XibhsvSjudFVz
         aI19SuCFydsgZ7YmyYmZfK19Ain5O60k8drph0jpK2uOURzER1NLzTFCOi8uBDpNy7qj
         0WAlAMxuLdTTjHhzuGm+M4lcC6VFDIvIHedhp2oT/BynmZxkgQkHtTliucxjTTq2K67f
         dXU0nbcc7g/FiCHCOrT5PyQlIm+mNgjQc6IjwUqhJBIDQsr4VT9hx33841BZozumTPQw
         beqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027141; x=1775631941;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkfTSXkHDQALVkJyo9syyUwoes0S5BnMY1bB+MUmhGk=;
        b=DSzV45yl+gAnG9gRsNGYu6Gvpdr47O2it4ofaZZXfb9AuQzSQ4lcJ/bA9dwNW5leTv
         D4PlxgavGKVhTIsRA5kjcr1qjb09e9Qoqmr3zG+uGrrAVAGmk4FHTihQWc/nBc6ihlsH
         D8kj5BImIffo88nCiD9mTiAjmO+DhjeIG1cf9iXWFTjf16Ex0GEdJgVO/T8pDIfPB203
         g8zLeIcR7rQwRBbwL34W6SyjDoO3wGH42qKjfgJheIG8EhAUks8zzY6H1afjbXKMFrUO
         O2rQgCstKIdY8TVPCKfhxQU4H+V4x+myV7ebya8nu/8TyYhWplEdf5wi2IW8w28Gutan
         +Qvg==
X-Forwarded-Encrypted: i=1; AJvYcCWgqaOUup2nMIS4a9RdXaLHF6sWXoHEdIYASL6NSfQCUBnyO733mLtGXrKv302+j8tCvYpD5OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSbPAdEAnnttcK1owtjmKY8VSZb1/NC5kEqpIuuraiGns7WVOK
	nwp33I4kCiVqrT+eA7E5DSEG4Ys/UXophLK8L2jZ7RuCUWFj//3AO98i
X-Gm-Gg: ATEYQzw9LcC+y1A3Lu7IYzy7TbLu1w5xAgxQ3mGI8+GBAK+uFc6lSxsNhprKgj00lDK
	pcpH9ZpfI6jE7wj96sWrlpDOKY/CUQYsb9jD8bBPTb6tridZ8bZ0ZKmz/jeVEw7H+aQYRTL4xXj
	vXs1MQwXteGTTUktIq7LBD0V9OHtDO1ru0VW2H2MXpPPD04w+/wcfTx1MS0zPCAgAHpnbMlbzKa
	aalBpdR8glh78VYbR0rlzRewjL2qjWCbhrE9q1MePPmbZ5pxvck+Z+z04w5mxFiUEP3GzD1EXbS
	504TfLWk9qvdsdfo7/yseAMT7daf1bAuGX01DrWTEvBmV+yTEaa6Q98OPCxvSglPwVMcPTXkmCn
	LTqGsk+u8PbvENnPudxCuYYYR20hpQAOzN8cIlSGpurfWvyVRVSJCPvChosmJKoc5HKfsn3HamR
	buheczFfcnVpg1IGDYS6Hxf65sBX23Cw5rQwIT
X-Received: by 2002:a05:7022:ea2f:b0:128:ccaf:85d5 with SMTP id a92af1059eb24-12be644a4e6mr1584447c88.15.1775027140833;
        Wed, 01 Apr 2026 00:05:40 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97efb42sm18091471c88.7.2026.04.01.00.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 00:05:40 -0700 (PDT)
Message-ID: <7c26a74d-90c5-4520-a10a-22f06e098b86@gmail.com>
Date: Wed, 1 Apr 2026 00:05:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, security@kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, afaerber@suse.de,
 mani@kernel.org, yoshfuji@linux-ipv6.org, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com,
 zcliangcn@gmail.com, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] net: ipv6: flowlabel: defer exclusive option free
 until RCU teardown
To: Eric Dumazet <edumazet@google.com>, kuniyu@google.com
References: <cover.1774855883.git.zcliangcn@gmail.com>
 <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
 <CANn89iJ+pDwKy0kKKG8PrSWMXEStgsMP9YGLxwvjcmMJP1PwrA@mail.gmail.com>
 <4631f54a-bcc8-454b-9355-15a21f9e1e21@gmail.com>
 <CANn89i+XGF+GheZDO+aWaw5V18mGu2H4OWsCpfs7HriGvCsCRA@mail.gmail.com>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <CANn89i+XGF+GheZDO+aWaw5V18mGu2H4OWsCpfs7HriGvCsCRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,kernel.org,vger.kernel.org,davemloft.net,redhat.com,suse.de,linux-ipv6.org,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-273922-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,get_maintainer.pl:url]
X-Rspamd-Queue-Id: 5494A375925
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/31/2026 6:05 PM, Eric Dumazet wrote:
> On Tue, Mar 31, 2026 at 5:41 PM Yuan Tan <yuantan098@gmail.com> wrote:
>>
>> On 3/31/2026 1:52 AM, Eric Dumazet wrote:
>>> On Tue, Mar 31, 2026 at 1:34 AM Ren Wei <n05ec@lzu.edu.cn> wrote:
>>>> From: Zhengchuan Liang <zcliangcn@gmail.com>
>>>>
>>>> `ip6fl_seq_show()` walks the global flowlabel hash under the seq-file
>>>> RCU read-side lock and prints `fl->opt->opt_nflen` when an option block
>>>> is present.
>>> Some points :
>>>
>>> Please do not CC security@ if you submit a public patch, there is
>>> absolutely no reason for it.
>>>
>>> Please do not resend the same version within 24 hours; this creates noise.
>>> Your patch wasn't lost; we have many patch reviews and similar bugs to address.
>>>
>>> Thank you.
>> We sincerely apologize for the confusion caused by our previous email. Previously, when we sent reports and patches to the security list, we were advised that patches should be submitted to netdev@ for public review. To follow this, we are now sending the full vulnerability details to security@ while additionally submitting the patches to netdev@. Please let us know if this is the correct way to handle such cases.
> When/If an issue and a patch is sent publicly, security@ involvement
> ends. netdev maintainers take over.
>
> Thus there is no point CCing this list of security officers, which is
> currently flooded by many LLM-based findings.
> Please help them by keeping their inbox a bit saner.
We would like to standardize our workflow to ensure it aligns with
community expectations. We've checked the maillist and netdev docs for
these details but found no clear answers. Could you please clarify which of
the following is preferred?

Option 1: Send the security report to security@ and submit the patches
directly to the subsystem mailing list without CC security@.

Option 2: Send both the report and the patches to security@ for an initial
review. After approval, re-send the patches to the subsystem mailing list. 

For Option 1, I have hread that there are bots on the public lists to help
with the review. The Option 2 feels slightly redundant and might cause
confusion. We are open to any other workflow that the community prefers.

We are wondering if it's better to send the PoC and detailed analysis
directly to netdev@ for bugs we deem to have low exploitability, which
would help minimize the burden on the security@ team. However, these bugs
are still triggerable by unprivileged users, we are concerned that posting
full PoC to a public mailing list might be inappropriate or risky.
>> Regarding the CC list, could you provide further guidance on who we should include? Currently, we are CCing everyone suggested by get_maintainer.pl because we previously received feedback about missing relevant maintainers. For public mailing lists, we should only including netdev@. Should we be more selective?
> Yes, folks that are interesting into following netdev changes are
> subscribed to netdev@ mailing list.
>
> Unless a patch touches non-networking parts and requires approval from
> other branch maintainers, there is no
> point CCing other lists.
Thank you for your advice. We will no longer CC individual maintainers on
patches sent to netdev.

Regarding security reports, however, we had previously been advised to CC
more people to avoid manual forwarding.

To be honest, we are a bit confused by the conflicting guidance we've
received. We sincerely want to establish a standardized process for our
future contributions to make everyone happy.

>> Finally, regarding our tags, our team has a clear division of labor—some focus on finding vulnerabilities, others on fixing them, followed by an internal review and testing before a dedicated member handles community outreach.
>>
> You included 8 tags, this seems a bit too much for such a small patch.
CC Greg here, as he knows a bit about our team's background.

Our team has developed a tool that found hundreds of non-root bugs with
PoCs. We want to ensure these are fixed properly and quickly rather than
dumping reports onto the mailing list and hoping for others to find the
time to fix. So we have organized a group of promising students. As some of
them are new to kernel development, we have been providing hands-on
mentorship to guide them through the process.

Regarding credit attribution: Yuan, Yifan, Jufei, and Xin were all
instrumental in the tool's design and implementation, so we listed them
with Reported-by tags. Xin provided the funding and led the fixing team, so
we included a Suggested-by tag for him (though this could be changed to
Reported-by as well). Then after including the patch author, this naturally
results in five tags. 


As for using a designated sender to submit these patches, it's because
using Gmail with git send-email is difficult in China and the university
email servers prohibit the use of the SMTP protocol. Therefore, we had to
apply for a separate account specifically with SMTP permissions to submit
patches.

We fully respect the maintainers' discretion in this matter. If the current
tags are still considered unacceptable, we will make the necessary internal
adjustments.

>> We welcome any guidance and will improve our upcoming patches accordingly. To be honest, we are currently a bit uncertain about the exact workflow the community prefers, and we are eager to align our process with your expectations.
>>

