Return-Path: <netdev+bounces-305519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aeEnG1UcTWoEvQEAu9opvQ
	(envelope-from <netdev+bounces-305519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 057BE71D51F
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:33:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=EC1CHNHE;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305519-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305519-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EBEF301E00F
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C5C42F70E;
	Tue,  7 Jul 2026 15:32:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3E42E8C1
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 15:32:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438337; cv=none; b=BiVpBy1P3cBUYBFCXiEZVkhjC6n87tuuKpxo91E8PetG1CE65686BRpAb0JyAw+iB028ly6R04cYL5v8RdzZcqRAqNfMsLe+ZW1ULZ+nFhc/g+CR4hJzBjuLqYG8z+Yu4cz3PUUl+at1vlxuAI1BcPEq5p0m1seMbr24dYBUSxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438337; c=relaxed/simple;
	bh=+pVfGy+q5xijHnzCvygCiL8Dx41ukdWBcc4R5yitQSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCFwVqXQBHvcRgOcIXUZQV9AElHfxrQyOs+fVKcjNs413O4J2xYGh2s3U6OpI5QEtVZFu+bXuQwt/bu+7GhAXB1YaK+n8EeJTe8afoHzkcXTrOyn+Zqgj2vIcr5Yw1uvsFDZ3xnRsig3yxyg6m+YXEsx0YNn17PzlIuBHoQ271s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EC1CHNHE; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so2791515f8f.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438333; x=1784043133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQ+Ftv/1fNBSyhcVrkQAR5aks0BMvykec1ekhSkuJMI=;
        b=EC1CHNHEwehItqCXht7Y4f5TsH+qbt9eM78rGmFfKITAYW2nNRhQv+/Zbv+WNQ55dM
         fUZQbTWUxI6tiiTCQD5GPOj1HYN5L1pYa3xT9dI/e/CIV//6XIiqE35HVADHIKYKKJiu
         tPPcnAaHtzRMbBWUuQgPX1pvojM5Ov6wdieFJ5Z2W4VBWgbFOIB1w4J1DiPOYi5huCit
         fDVg64vfSQx5kAzu3Flcq4CazioDIKZq9D4cmnHF/jaE+92+c92Y9MbzXusDdw6kEJP3
         BsEFX54/YkWoAyJbvSwvLFCmgvfEZvrjxohS2fAvy7fq7dKD1z3mZc5mRAZesKpqV9xZ
         0JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438333; x=1784043133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ+Ftv/1fNBSyhcVrkQAR5aks0BMvykec1ekhSkuJMI=;
        b=W30tQ56l+3GF+z92oZ0zml9+U15gde9d6IJ2aRkdZaZu3gf6ZoMpwIqiYeweqT5vBh
         tOvDK/uCChghrWThse39U8se8d0Cp4LDUJW4uglthYmMJTjtEZ0YaH0XfNeSDVuvnIbZ
         ZnAMWs2AO770QpD1QWPgPNMWuGjb8U7qSzeFcKMsp2qjqkgE3zQOf9Yy7R0rjiUnnpVZ
         z0Ds982jbU50BJe0aM5tz1W+x9NAC2imMaDWiLt6K36Sz9zZMvXbLlazH4zvR1esGKSE
         iUoRIUGvTzMKJ4Ey4FfzR0zgrFtYNTprbFRcvyCIxvoj6HRjKE40GiaKxvFM8sV4fUxs
         3psQ==
X-Forwarded-Encrypted: i=1; AHgh+RoW6AHHTND0Q7m2jfgwM3qoCISIfNGrM7R62RTSjn1Q/SadY0FyYnpn16VV88xi9RE/CrxBLJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OitkiGjuTJCXqRHUMfefaMCBmBwJLTh62JF550oliUS0Zff2
	snU/6cRoYiGc6cFW2uEVuaLMe2qq18VVIG3RvY7CZY+zTaxa66mQh8/MWlMaDz2u2r4=
X-Gm-Gg: AfdE7cnV8o0WR/XOwEmaLimuzM+PwF94xsojNZK6CYixrTIVS7Bd7sLtvcF1wMT9vbX
	lG0T4sNibUZbL4UEkv6QJTacQyBTMq71CNdpQjZ5kcUdhlSM6sLg6voTZbbAHry0xT13Yz+Fhzx
	rTebbd/B7W7ZpToa8dPrLNO0VIIPM4A8DDNf1Z7dNEOTqVgw/xB6K9V8fy4hOpS9gDzfXbRuXtP
	1JL64jI5NdqpDkc0YW7IZFizVsvTHfV6iQd/50E9lWiSeYUlTdcZHIIQ+kcVcWVlM+NK5zE3nPc
	WNjv3kamtab84MXPPDR21+k5BMgbj1tFjNMkciY7HTstE173Y52+tkGkZ3YMUTbOGz/cFIDYTa7
	FQlYNTyrq6ssKMytLO4zQE2BqTGtqhsaOcQLjIyEFWl8UND2doP6vxVV/KNZboEGsKR4iyJ08Oq
	JrRflU7y0LU+Lu2vdpG3vmUc+YMdkD+X5oBFsWLDcnsnVLo6i5gQ8TCcCjPwPrnxoshg3tTp2wx
	HdUw5RHlCKS7924rpTCdjOnl1RzYQOuhzgDHqbTUFy/nqG6/Z+ISmJQPJc=
X-Received: by 2002:a5d:6543:0:b0:475:3a97:8e2c with SMTP id ffacd0b85a97d-47de66a4be0mr5128126f8f.16.1783438332496;
        Tue, 07 Jul 2026 08:32:12 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm40509231f8f.17.2026.07.07.08.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 08:32:12 -0700 (PDT)
Message-ID: <0dfe59c2-bf60-40fe-90e6-d6e1003709d0@suse.com>
Date: Tue, 7 Jul 2026 17:32:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ppp: defer channel free to an RCU grace period to
 fix pppol2tp RX UAF
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Qingfang Deng <qingfang.deng@linux.dev>, Breno Leitao
 <leitao@debian.org>, Norbert Szetei <norbert@doyensec.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Taegu Ha <hataegu0826@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
References: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
 <de2616b3-6edf-4255-ba77-0674e225ab27@linux.dev> <akfjpBVML_1RFF91@gmail.com>
 <87111f02-5b7a-4185-8364-2faba650578b@linux.dev>
 <20260706092926.PIlrhRKz@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260706092926.PIlrhRKz@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-305519-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:qingfang.deng@linux.dev,m:leitao@debian.org,m:norbert@doyensec.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hataegu0826@gmail.com,m:kees@kernel.org,m:linux-ppp@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gnault@redhat.com,m:netdev@vger.kernel.org,m:mcgrof@kernel.org,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:linux-modules@vger.kernel.org,m:paulmck@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[petr.pavlu@suse.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,debian.org,doyensec.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,atomlin.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:dkim,suse.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 057BE71D51F

On 7/6/26 11:29 AM, Sebastian Andrzej Siewior wrote:
> + MODULE maintainer

+ Paul E. McKenney

> 
> On 2026-07-05 10:57:44 [+0800], Qingfang Deng wrote:
>> On 7/4/2026 at 12:32 AM, Breno Leitao wrote:
>>> On Fri, Jul 03, 2026 at 03:27:00PM +0800, Qingfang Deng wrote:
>>>> AI-review found an issue: https://sashiko.dev/#/patchset/D9C0245B-608B-4884-8A09-F55BA4A9F948%40doyensec.com
>>>>
>>>> An rcu_barrier() call is needed at the end of ppp_cleanup().
>>>
>>> I was initially unclear why rcu_barrier() would be necessary on a kfree path,
>>> but it appears to be required during module unload to ensure that
>>> ppp_release_channel_free() completes before the module's struct rcu_head is
>>> destroyed. Is that the correct understanding?
>>
>> It's required to ensure that all ppp_release_channel_free() callback
>> complete before the text segment of the module is unloaded.
> 
> So either a rcu_barrier() in ppp's module_exit() callback or a
> synchronize_rcu() instead of the call_rcu(). And all this because the
> module RCU callbacks pending which can be invoked after the module has
> been removed. There is a synchronize_rcu() during module exit but this
> is after the module code is gone.
> 
> I'm curious how many modules have a call_rcu() within their code but
> don't have anything to enforce its completion before module removal is
> complete? Wouldn't something like
> 
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a6058..8eae1ea2d6eb4 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -858,6 +858,9 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>  		goto out;
>  
>  	mutex_unlock(&module_mutex);
> +
> +	/* Ensure all rcu callbacks issued by the module have completed */
> +	rcu_barrier();
>  	/* Final destruction now no one is using it. */
>  	if (mod->exit != NULL)
>  		mod->exit();
> 
> make sense?

This is discussed in Documentation/RCU/rcubarrier.rst and
Documentation/RCU/Design/Requirements/Requirements.rst. The latter
contains:

| Loadable Modules
| ~~~~~~~~~~~~~~~~
| 
| The Linux kernel has loadable modules, and these modules can also be
| unloaded. After a given module has been unloaded, any attempt to call
| one of its functions results in a segmentation fault. The module-unload
| functions must therefore cancel any delayed calls to loadable-module
| functions, for example, any outstanding mod_timer() must be dealt
| with via timer_shutdown_sync() or similar.
| 
| Unfortunately, there is no way to cancel an RCU callback; once you
| invoke call_rcu(), the callback function is eventually going to be
| invoked, unless the system goes down first. Because it is normally
| considered socially irresponsible to crash the system in response to a
| module unload request, we need some other way to deal with in-flight RCU
| callbacks.
| 
| RCU therefore provides rcu_barrier(), which waits until all
| in-flight RCU callbacks have been invoked. If a module uses
| call_rcu(), its exit function should therefore prevent any future
| invocation of call_rcu(), then invoke rcu_barrier(). In theory,
| the underlying module-unload code could invoke rcu_barrier()
| unconditionally, but in practice this would incur unacceptable
| latencies.

I don't know if the last part about unacceptable latencies is still
relevant. I haven't done any measurements myself.

-- 
Thanks,
Petr

