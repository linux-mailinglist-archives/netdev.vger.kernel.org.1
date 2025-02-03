Return-Path: <netdev+bounces-162220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D211AA263D7
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5953188316D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB713212A;
	Mon,  3 Feb 2025 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vpkqs0+l"
X-Original-To: netdev@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34925A656
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611518; cv=none; b=c+kpO2K0J7ditUgTcOvB5RYrgo/3kiKedJtxE7CB5lhkofaMmkFRH3fAdQ3P353cn8ltKWJg3car9B8mqwXIfDWLoekB1ktDoOuHy2LupscSoat3HaO3u/EAWJzwi8dGpUM+ezmfdyE0HLRuGTlnvcTfifbTH6Lnm1kMwfxrUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611518; c=relaxed/simple;
	bh=GB8U3AhZ+GbQoohdTDDABlMCbBq8ilqvcQeYsPHBvR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xn9oJ1uhlQlzZyJXi6eGSlg2ciriGIUjqQit5ilGtWt4BPaFRdgaiN1lVBfBCNI5P+iHHS2rKFvwBsIZkCiVLVgfdOkB3scF6MROrG6ijNnCjML0QsM+dO/oexADjvUcQ1oAIHjsUt+Wqha9F9IvaTnixLmmCeyAfLPn0ZjTNE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=vpkqs0+l; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:188a:0:640:98b0:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id D91EC6129C;
	Mon,  3 Feb 2025 22:30:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NUpgJxSOdmI0-G7M4GAEx;
	Mon, 03 Feb 2025 22:30:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1738611024; bh=GB8U3AhZ+GbQoohdTDDABlMCbBq8ilqvcQeYsPHBvR0=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=vpkqs0+laBlBmdxpgZ5Zr3JJ51i+gKMGb9ghoACW2U88xuyszo/PwBUUXkZ0t78e7
	 B1AZmWfUhPRDR0GKc/gDfr4qflqtHWujfte9kTg2u+HkRnGYDptZu1ES2Tqj5S1Yr6
	 Gm8E3XXZEP7sJHGKT/+1nKVuom+iPCBMYOk0K604=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <efceaa29-93d0-482a-95d9-28b176c1ffbc@yandex.ru>
Date: Mon, 3 Feb 2025 22:30:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun: revert fix group permission check
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jasowang@redhat.com, Willem de Bruijn
 <willemb@google.com>, Ondrej Mosnacek <omosnace@redhat.com>
References: <20250203150615.96810-1-willemdebruijn.kernel@gmail.com>
 <48edf7d4-0c1f-4980-b22f-967d203a403d@yandex.ru>
 <67a114574eee7_2f0e52948e@willemb.c.googlers.com.notmuch>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <67a114574eee7_2f0e52948e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

03.02.2025 22:09, Willem de Bruijn пишет:
> stsp wrote:
>> 03.02.2025 18:05, Willem de Bruijn пишет:
>>> From: Willem de Bruijn <willemb@google.com>
>>>
>>> This reverts commit 3ca459eaba1bf96a8c7878de84fa8872259a01e3.
>>>
>>> The blamed commit caused a regression when neither tun->owner nor
>>> tun->group is set. This is intended to be allowed, but now requires
>>> CAP_NET_ADMIN.
>>>
>>> Discussion in the referenced thread pointed out that the original
>>> issue that prompted this patch can be resolved in userspace.
>> The point of the patch was
>> not to fix userspace, but this
>> bug: when you have owner set,
>> then adding group either changes
>> nothing at all, or removes all
>> access. I.e. there is no valid case
>> for adding group when owner
>> already set.
> As long as no existing users are affected, no need to relax this after
> all these years.

I only mean the wording.
My patch initially says what
exactly does it fix, so the fact
that the problem can be fixed
in user-space, was likely obvious
from the very beginning.

>> During the discussion it became
>> obvious that simpler fixes may
>> exist (like eg either-or semantic),
>> so why not to revert based on
>> that?
> We did not define either-or in detail. Do you mean failing the
> TUNSETOWNER or TUNSETGROUP ioctl if the other is already set?

I mean, auto-removing group when
the owner is being set, for example.
Its not a functionality change: the
behaviour is essentially as before,
except no such case when no one
can access the device.

>>> The relaxed access control may now make a device accessible when it
>>> previously wasn't, while existing users may depend on it to not be.
>>>
>>> Since the fix is not critical and introduces security risk, revert,
>> Well, I don't agree with that justification.
>> My patch introduced the usability
>> problem, but not a security risk.
>> I don't want to be attributed with
>> the security risk when this wasn't
>> the case (to the very least, you
>> still need the perms to open /dev/net/tun),
>> so could you please remove that part?
>> I don't think you need to exaggerate
>> anything: it introduces the usability
>> regression, which should be enough
>> for any instant revert.
> This is not intended to cast blame, of course.
>
> That said, I can adjust the wording.

Would be good.

> The access control that we relaxed is when a process is not allowed
> to access a device until the administrator adds it to the right group.

No-no, adding doesn't help.
The process have to die and
re-login. Besides, not only the
"process" can't access the device,
no. Everyone can't. And by the
mere fact of adding a group...


