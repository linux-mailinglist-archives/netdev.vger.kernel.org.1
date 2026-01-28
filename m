Return-Path: <netdev+bounces-254464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO7+MjJ9emlN7AEAu9opvQ
	(envelope-from <netdev+bounces-254464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:18:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F793A90AF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 795293030B2E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605323385B6;
	Wed, 28 Jan 2026 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QGEzAbN/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3C23A984
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635118; cv=none; b=mpYU3aRKZIdbJDleUM+UKRA8JUqzuaRQu9qEVVlVqUkr9pbxv6sBEK1ZU1fTMtzyzxpId2uM5AXYBJImcFzUPj8ELQ7sbpAn458tPXd+gANG+oXohdSo9YAvrRFnkzngH1E1B75GXyldqDjgyKgTEyObaf+7NBD5jtK+3ZCCFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635118; c=relaxed/simple;
	bh=4kYgZEqqo+Pmcqz03RJxSk4QVGQCPTN00vY5Iav8aA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPdZvYi8R/g4rpWIyXhJiBPideDWid9JohKr9Hi04QbpBnF8fGkIb7v7EIeG6k2/Qh8q3LHvQMRZDG2bzhfA4YR66dgANuEd+NQ8Trp+nD7QzQLp7a8AwvNsfkF5uuo95HVw30F5b4yx3FQmiECEDUXP3B+iZYwqlHrwBND9MZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QGEzAbN/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so10166605e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769635115; x=1770239915; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xp9Fgd2RIw247dmeHBhZGyViCdcfCoSm8F9wNiqAlQI=;
        b=QGEzAbN/eEMk5A/rTxwKJRDVCttq3I7NJpXff+rpekFVtH3sO2QZSZPnD5uT9DQPgR
         Gnu8mpf1dqnDbRPhMVvDtwOV8yFq91IxfE8GOXWJkneW1Tjd7MTBCGFcuzYrFB2deRbM
         xoo5L/Jltg6IiewSP8AESHjqjNlKl8N3DwJ6ABMy5Rg/Iw6GNWp77ZOU5Jdi5sEqOJmc
         W3SERxPYyj04hbNVpcDgYCuO2e4ZVU7JZKoU7frE6saJFdrUNIXOhVCpjvqixV8sMmMz
         IFFqLdwr+UvQUWFkM8+a9oa0OsbtLf3CbdfK7ckkOTfZkf4CSe4GU/N8pIDo4N36cAgs
         csRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635115; x=1770239915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xp9Fgd2RIw247dmeHBhZGyViCdcfCoSm8F9wNiqAlQI=;
        b=nFU0sKYY50nIERAmg/UZiTYiygZf0bAJSqtG9/PG1ccAaa3ixnVEEVauRw655qko3x
         OeZFKRVibzGD8BuZ7MoXrKqkCw5zSpHdoKEm/n3LZKp2Mr+5WgB+uA3LzIioHt9UHptE
         YZHKpQNPjpBh3BE7GGaI3/3ZHljhL1PghOKbHL97jERGmbxDPegNZOCSxajzFAxc7QqY
         6DvW99flGbJpQyVizDL3ZHqqZWBmpBZ3kniTh1fcZxb2myROnYcCIm8UjwPga+dbIaXL
         rvDp1yRQ5pnfH31fwdGZqlJqJS1bYI843oynvAY7d3MqV7/+/TvShe8XzSC34SZNxb7z
         z6lg==
X-Forwarded-Encrypted: i=1; AJvYcCU4DPoTg8AU1Ic6PFYQXBRKsy/glazGIV71ChWB3Ggfxjx7daFseL0dFohSIFSbBndrLKd79mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/x5Q9jazzK5pJc7hgUCBW5Frahmihemr8cw8dNxSbGLe69nQ
	ISMdFWV9r9zHqOS3l+EK4YhU+bnsokT2bQhWGaSm3PUzZZ8AIxfvFH+xClfcLX5bVfI=
X-Gm-Gg: AZuq6aJlvJut7vVZ7v5UA7zJCfaSSSxmCVkKfYPdzkWJ9g1X/u8YLCx4Abe6tXa8vSn
	j5S/DReJwjAnpiC6azGUO+UkBH6bF4ou4pg0bfB/IO2+hKVAYJWn/r+HrSZHIDp4fEgWxpYUXYZ
	PyXsdDFx55xGC+SPGol33J57/M1em53CznvRuJql0HJC2hEiBNC8Uf1Vb4Avie6d0RSmiFlMOmw
	xH9rgMO6roSjQoFSI3mJXOW63xZXOVpAXDh+GXX9OgVlxgltamlD+xHdQ0xzTwo+tIhQ/eySUR+
	yBEO/l8FWj5FhG5IcO8LdO8mNiMWrq4/ybnfHuFo9r68H99JRmOxJwLA6+dGmiroPcD7RBS6thP
	gXeKewHC2V1EyAHl7f2avsNteeuLbBQZDeCWekBTKs1WvJIed99qHwO7sBWZM40fjXMFAFwj8kf
	d4X9NW67d6/x+mRRfAc56F8Hh3
X-Received: by 2002:a7b:ca47:0:b0:47e:e38b:a83 with SMTP id 5b1f17b1804b1-480828828dcmr6056415e9.7.1769635114891;
        Wed, 28 Jan 2026 13:18:34 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce64sm9991967f8f.26.2026.01.28.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:18:34 -0800 (PST)
Date: Wed, 28 Jan 2026 22:18:33 +0100
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
Message-ID: <aXp9KWl3VaNDMKPp@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-4-frederic@kernel.org>
 <aXeZQoSHJ9QX7B6W@tiehlicka>
 <aXizUsfywjtIIN50@localhost.localdomain>
 <aXnMj1phN3TJZkNz@tiehlicka>
 <aXnymtIZSc-fw1b8@localhost.localdomain>
 <aXp9CzgCTBEhlDqM@tiehlicka>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXp9CzgCTBEhlDqM@tiehlicka>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254464-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F793A90AF
X-Rspamd-Action: no action

On Wed 28-01-26 22:18:04, Michal Hocko wrote:
> On Wed 28-01-26 12:27:22, Frederic Weisbecker wrote:
> > Le Wed, Jan 28, 2026 at 09:45:03AM +0100, Michal Hocko a écrit :
> > > On Tue 27-01-26 13:45:06, Frederic Weisbecker wrote:
> > > > Le Mon, Jan 26, 2026 at 05:41:38PM +0100, Michal Hocko a écrit :
> > > > > On Sun 25-01-26 23:45:10, Frederic Weisbecker wrote:
> > > > > > The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> > > > > > runtime. In order to synchronize against memcg workqueue to make sure
> > > > > > that no asynchronous draining is pending or executing on a newly made
> > > > > > isolated CPU, target and queue a drain work under the same RCU critical
> > > > > > section.
> > > > > > 
> > > > > > Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
> > > > > > workqueue flush will also be issued in a further change to make sure
> > > > > > that no work remains pending after a CPU has been made isolated.
> > > > > > 
> > > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > > ---
> > > > > >  mm/memcontrol.c | 21 +++++++++++++++++----
> > > > > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > index be810c1fbfc3..2289a0299331 100644
> > > > > > --- a/mm/memcontrol.c
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -2003,6 +2003,19 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
> > > > > >  	return flush;
> > > > > >  }
> > > > > >  
> > > > > > +static void schedule_drain_work(int cpu, struct work_struct *work)
> > > > > > +{
> > > > > > +	/*
> > > > > > +	 * Protect housekeeping cpumask read and work enqueue together
> > > > > > +	 * in the same RCU critical section so that later cpuset isolated
> > > > > > +	 * partition update only need to wait for an RCU GP and flush the
> > > > > > +	 * pending work on newly isolated CPUs.
> > > > > > +	 */
> > > > > > +	guard(rcu)();
> > > > > > +	if (!cpu_is_isolated(cpu))
> > > > > > +		schedule_work_on(cpu, work);
> > > > > 
> > > > > Shouldn't this in the guarded rcu section?
> > > > 
> > > > This is what guard(rcu)() does, right?
> > > > Or am I missing something?
> > > 
> > > I am probably misreading the patch. But I've had the following in mind
> > > 
> > > 	scoped_guard(rcu) {
> > > 		if (!cpu_is_isolated(cpu))
> > > 			schedule_work_on(cpu, work);
> > > 	}
> > 
> > guard(...)() protects everything that follows within the same block
> > (here the whole function) whereas scoped_guard only applies to the
> > following scope (here what is inside the {} in your example).
> > 
> > So both work.
> 
> I see. Thanks for the clarification. I would probably prefer a more
> explicit call convention but no strong opinion on that.

Forgot to add
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!
-- 
Michal Hocko
SUSE Labs

