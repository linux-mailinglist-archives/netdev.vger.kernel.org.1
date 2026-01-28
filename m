Return-Path: <netdev+bounces-254149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHKJC5jMeWmOzgEAu9opvQ
	(envelope-from <netdev+bounces-254149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:45:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 920999E4FC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 829B13009F39
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FBC29992A;
	Wed, 28 Jan 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SZIbsb4u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36263337BAA
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589909; cv=none; b=Alz55b549FiCQUQ8aWjx77G+fWgmEirrNAxf1sFO6gV1APsiDaGLDP2fWc/YbWgc0FdvcYkXHfo9cURXfuvCvjNZm0DAq/bxXTOSjAG5PEETMzBlX8bincoNfPvBo3iEDjS0CeXOyogRVmUVufd/1nFhPEtlv5tkq7P+/QLDgxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589909; c=relaxed/simple;
	bh=RmjPdOoSLN83hdmAOBaQ60Ic1/65Z53zJZ8NP4f3+Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNmyCVXlsrKxweUql6H9b5y2Z6hQKsxu9dt/K3DXJioyu8Dd41oi4l/v/3TsfdaVnb+LRKCRXPgc667mGP08BEkAcXF6D5qsqso1ZZc13Btyz7VfzswTdFUBTIuIOPrCAruAX0x7tYP/+pfr9hdcjppG4C516FmQRQkTtjRRyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SZIbsb4u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so74144815e9.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 00:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769589905; x=1770194705; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yzZ5aaJur2cGbo3tv1Z3AlCZuGpqhSu9RlDH7L/IIPI=;
        b=SZIbsb4uqLo2GtuIKPa3bbLA7N6dH7jjl6viB/R0/10DmYtuzJlEe7d0Lgh3AsecRy
         Jb04vA7E9/uLgkJZj1z+cgSxI3Pw1kEmK8VTCRIPmIz0NhYj96oATGrLZoy7Q77sTuDw
         mGjKnzWQTVqorHggE4D4U6/8Mf1kmcypiioWs0sIzDr+ORIOuLY1V6G4ENM7uvS7yfSs
         ZNvihc9rHZx9imvV17/9Oe01/vYcd1kY83/3Hw76N9KkKngapUjdwLQYcCYYynsVx+y9
         1Jbevjw8z6Hb9P7DLqp8t2bANC8o9Q00TSBYdZxWguV1RtcG2SS3gAKfvOKvJZxcgBXk
         4HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769589905; x=1770194705;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzZ5aaJur2cGbo3tv1Z3AlCZuGpqhSu9RlDH7L/IIPI=;
        b=VPwOF8n/aM8WQiitIFfcbUe2QfHqXgc5EhMqqCOHP8wXX3onwVtU7NXvpvPCI8K9Yp
         62Y0opDHnZal1lGlADRYQ6biMFcQ7+JqA2WjLNaXB0E9y8LcbKNRA2By0cxSyYY1o6wk
         QZnJQ4Q8x9nAKpugO1clHadDWcDlCU0oAJYUcaCupyyzjB+IGz4BsPvBggvwsF4b26ea
         +VgmdVS/WNqXIH0Xgx+91F/+v/en6/NGYiD4GyHg5cYUU92/KS+BRtK/of8fhrElWivd
         k8qM3L+m6o+piyfFy4ZBOgL4tLXYBqGQ2TrCtX2lO8k6aQ/6FHXty4kPnIxpa+5sgnZb
         QuUw==
X-Forwarded-Encrypted: i=1; AJvYcCUWrN6rKYFp+lQb7Iv+FE6wU/XpXQuTp6QEntqcsThcDv3S+q5McUUuqLJNWp0MxpVAcS4Dk5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFj6ohuwwrb+8NWFx8G7jK7CodkkYm4x/lInQWMFx2QhJ/7LHv
	5MX1Fx0hxryeexYxxvNhabUng07gbJgXueVM7jkBjAkLq4JQc01mj8b2Z8asfXJZEpQ=
X-Gm-Gg: AZuq6aIxohbAvdZGb+SBSnXTMVlJyDDY5ahsdrUb9NWXj6vobG7Hd6m8FjMS81pIDGG
	B/Ar9e0n8ge+n15ODRGqf+WUV7K7oTaj+O1gUCkKa/jTTHatDh8oroKgVa6G1IN7Ihp3Vk4HVE2
	HCGFStmphvlnvqBUKBaTR20lEcpiwL5higRdIOVhkl608wyzEv1OH6mW5aPaZv3VLR5LG4yDu4d
	Nys4x9ZZo2ncFUOLLeiyrzveSS6aAZv4rrjE35eeBK7kUbAv4/4wHPAJHhsW3xdEZmL4+KW01F2
	L63GBko9Vrr5lDwey2FtbzpI+YHEOff5Riee7qvXskfgWrmBWFcwe4ZpvQSNpNHaqzDZqCv2zPt
	DasIrLm/vqywOO/VeRZwI7fpy4UPI/yYFrekDAtrOrgOoSv9G56IhL+YdonqUx5+s4toelsr/jv
	OLC0vLgAheU6o7JNVxkJ2xVfuQ
X-Received: by 2002:a05:600c:4e12:b0:480:6873:b2f6 with SMTP id 5b1f17b1804b1-48069c557d0mr54819185e9.20.1769589905328;
        Wed, 28 Jan 2026 00:45:05 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm121124905e9.4.2026.01.28.00.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:45:04 -0800 (PST)
Date: Wed, 28 Jan 2026 09:45:03 +0100
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 03/33] memcg: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aXnMj1phN3TJZkNz@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-4-frederic@kernel.org>
 <aXeZQoSHJ9QX7B6W@tiehlicka>
 <aXizUsfywjtIIN50@localhost.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXizUsfywjtIIN50@localhost.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254149-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,kernel.org,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,lists.infradead.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 920999E4FC
X-Rspamd-Action: no action

On Tue 27-01-26 13:45:06, Frederic Weisbecker wrote:
> Le Mon, Jan 26, 2026 at 05:41:38PM +0100, Michal Hocko a écrit :
> > On Sun 25-01-26 23:45:10, Frederic Weisbecker wrote:
> > > The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> > > runtime. In order to synchronize against memcg workqueue to make sure
> > > that no asynchronous draining is pending or executing on a newly made
> > > isolated CPU, target and queue a drain work under the same RCU critical
> > > section.
> > > 
> > > Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
> > > workqueue flush will also be issued in a further change to make sure
> > > that no work remains pending after a CPU has been made isolated.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  mm/memcontrol.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index be810c1fbfc3..2289a0299331 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2003,6 +2003,19 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
> > >  	return flush;
> > >  }
> > >  
> > > +static void schedule_drain_work(int cpu, struct work_struct *work)
> > > +{
> > > +	/*
> > > +	 * Protect housekeeping cpumask read and work enqueue together
> > > +	 * in the same RCU critical section so that later cpuset isolated
> > > +	 * partition update only need to wait for an RCU GP and flush the
> > > +	 * pending work on newly isolated CPUs.
> > > +	 */
> > > +	guard(rcu)();
> > > +	if (!cpu_is_isolated(cpu))
> > > +		schedule_work_on(cpu, work);
> > 
> > Shouldn't this in the guarded rcu section?
> 
> This is what guard(rcu)() does, right?
> Or am I missing something?

I am probably misreading the patch. But I've had the following in mind

	scoped_guard(rcu) {
		if (!cpu_is_isolated(cpu))
			schedule_work_on(cpu, work);
	}
-- 
Michal Hocko
SUSE Labs

