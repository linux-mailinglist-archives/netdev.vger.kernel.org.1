Return-Path: <netdev+bounces-260099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TNeSKYt7nGm6IQQAu9opvQ
	(envelope-from <netdev+bounces-260099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:08:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE1E17961E
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6307E316AAC2
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F330ACFB;
	Mon, 23 Feb 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PqHtQ0ke"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1F2BDC1B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862469; cv=none; b=ULik6Ut89W25SRq1usPRJ6ZX/ZCqp0s/QV5RPrj+XOoy88EltTche/LWQoElQz1NxyVvnK06YWN8LJ4JuIZCxetckBU9clTfoduvU+/+2sgphvynZoLWjZs89R2RjxdukAZEDKFWmBTmzSE59jQISilvIRmrBMAgjNDoe+0QGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862469; c=relaxed/simple;
	bh=RBDa0jIO4VbsfMCQSIREc9cffsT7gvfxFla9G/UD7gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJB259nsy79sCeC4Kpe1Q8yT8PdtBjQ2SRFe0A9xfOZtW8K4+99p75YMxonJQLbSEplR4B91cBYXvMnQUfQfs8BzkUZ9Doudf6jhJPm6NLfgefyfISysOZaoKJtbVE8YjXbSSG29PbnXoDkfhPcvepxyt6bMahiOIVcf5S/R+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PqHtQ0ke; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d195166b2cso3128916a34.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771862466; x=1772467266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HX29uEwlmShEjfFqkdwl8Eb5l/ZDj+DL2kVuvz05S4k=;
        b=PqHtQ0kegO9Jus8W4cxNJI34/48vONyAjPHsLA84w3xhcTH+ehRGLWMutcJXZ2RAc/
         sIIW38BVXjib20Hzzie5/NskGtknX8AWizrrYqFC+cHd9PikB2egS7JaNbi54oMe6P/4
         ddf9EB7qZxkwqk3fcPIUygOni6aWtkYOvu4jDSCBwwynMsMsONTgNsrQ6SoIaPGchix5
         apan0c7Jll92fM9SkRm6Fx8tqeLhj2uls5bV+0bT0tWyuhs39yMoF4q2AatkXEkfO9jQ
         WZmQcIv6TmU8UxJu44cTa6JGtGGdPs47Tmw+CdciuwJYkd046huqr3OenbIXyacOEqFB
         SY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862466; x=1772467266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX29uEwlmShEjfFqkdwl8Eb5l/ZDj+DL2kVuvz05S4k=;
        b=v2fmJVMwzVOeEfUuRFUYzrE1GsCnGVMtC40BscMn68y/dHrLfNZjdmwxsnVaLCt2t0
         aFgL73sHB4fj8qHIpSka8IqvNCCBQs+L09wOI8MPNDTHzD/5SVV0lmcWxibucJCNWo9w
         WUTuMB5vYrOYRrus6pZMR/MHF6FlxMpzdFKsDuKxJWh3BooThk1RTZNhQo+arUuY15jm
         Rt26z55kUArN+8C3CN8vYKE+NFehZNix2WnBgquAIt6K8ENBcGPPdMMuRVordngyOfoA
         tISW8SulDL0AXRusdr180vdZLROIfPKl/oN0o5vgvDxsWMC0vOrwi5kOYGO4BZhnh/3p
         Jeaw==
X-Forwarded-Encrypted: i=1; AJvYcCWxHe3HuIgoK3pRsEhfyKOYiMGqRxFSv5JS7Gm3WJOvKlFUjlpjsX8rmToX/xdnjohbQnmCvIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLgnfidAk+7CsW8ooJPiK1d450+0lfMqWUSyKuk0xnaviDQut
	7/3zZTZCKnKY65jWGOgPNAJWfnKCVlE3q+Jhhzk3phae8zFEuDklujlHVZsZQtgB8M4=
X-Gm-Gg: AZuq6aI+/hBIxeYfz6qOAH3MghsQvCe+5ZGYwTgtFUxHnqptmqntFIP4OQGfCD2Swh0
	YsSaYsJPHpnXbaymUJihhJ1fqA8WcvMC2r8pvsNfjoZZ3PIhB3eoGzg2q1TXVBeuK/3NyJwbUx9
	a4MaIDwwllyyW4tfqegCy1qlMXtdaiv79TGLZ4jI1CfF2xhYvARqNFUyzDg0FliDVahanixwqDW
	OTogs5jSjcc7tKjuObxiuKOm4RTt8M1VHIhkeHz3pV0sDZ7LeAkfkZ+5rcePilbXtpmYfSVlppo
	vQbt08ZVFT6kMENY4cHLMPkcDcoTb3qfwFIwRApmheOc+F08chN/GWMqmZVSlgMZhmWJouT2FPU
	78dTQgOdyQgZbRHlDQDyFmxkzUmxIWmZbJITyvZ6J8xtLxnpBx6zgJW57k2c4/sYD7hjGdD1Qx0
	/7xpStggNw8skSpDySi5SYNQdMlgu4Sau6l4DeSBgNCTK+zIc+HJjnwu/kyISK1P0Fx6l+eFl30
	mGri5V1Gg==
X-Received: by 2002:a05:6830:3153:b0:7d1:853c:83e3 with SMTP id 46e09a7af769-7d52bdf416bmr6177467a34.2.1771862465520;
        Mon, 23 Feb 2026 08:01:05 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e37:2309:3937:4469? ([2600:8803:e7e4:500:e37:2309:3937:4469])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d55b9a8498sm1062950a34.28.2026.02.23.08.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:01:05 -0800 (PST)
Message-ID: <47be2ff3-c25a-4aab-89fc-53921af8b0a9@baylibre.com>
Date: Mon, 23 Feb 2026 10:01:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] mm: vmstat: Prepare to protect against concurrent
 isolated cpuset change
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-5-frederic@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260101221359.22298-5-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,linux-foundation.org,google.com,arm.com,huawei.com,kernel.org,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,vger.kernel.org,lists.infradead.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-260099-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5CE1E17961E
X-Rspamd-Action: no action

On 1/1/26 4:13 PM, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> runtime. In order to synchronize against vmstat workqueue to make sure
> that no asynchronous vmstat work is pending or executing on a newly made
> isolated CPU, target and queue a vmstat work under the same RCU read
> side critical section.
> 
> Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a vmstat
> workqueue flush will also be issued in a further change to make sure
> that no work remains pending after a CPU has been made isolated.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  mm/vmstat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 65de88cdf40e..ed19c0d42de6 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2144,11 +2144,13 @@ static void vmstat_shepherd(struct work_struct *w)
>  		 * infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
>  		 * for all isolated CPUs to avoid interference with the isolated workload.
>  		 */
> -		if (cpu_is_isolated(cpu))
> -			continue;
> +		scoped_guard(rcu) {
> +			if (cpu_is_isolated(cpu))
> +				continue;

I think this might have introduced a bug - or at least an unintentional change
in the program flow.

scoped_guard() is implemented using a for loop. Now this continue statement will
only exit the scoped_guard() scope rather than continuing the outer for loop. This
means that cond_resched() will be called when it previously was not.

>  
> -		if (!delayed_work_pending(dw) && need_update(cpu))
> -			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +			if (!delayed_work_pending(dw) && need_update(cpu))
> +				queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +		}
>  
>  		cond_resched();
>  	}


