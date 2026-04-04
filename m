Return-Path: <netdev+bounces-275311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHuXAvdb0GkA7AYAu9opvQ
	(envelope-from <netdev+bounces-275311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:31:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1A39957E
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31C84302C323
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D4B22652D;
	Sat,  4 Apr 2026 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="EqqCgflY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C61F099C
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262708; cv=none; b=RN7PNSLAyAUyepYdrk6AsHdFY0e7AnrRPMJxxEXHvGU4b+PHFWXB1ygcTqzPREe/q9PQf74ncrP9SWU5AKWkZgI8MaUU0wehC+q+nw8X7xZg+3dnZWBitsWg9YR38z82SoNY30JXdgUyFIgSp5yWhH0U09VPSfGiaDSCkgzUheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262708; c=relaxed/simple;
	bh=l/B0K4b/Ci0D5UNKWH9tcH6Wj18mUZWCi/vbU1/znLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwW5JD630vuMFFg1hUQksvW4F9Pvh1qohQrkc3LO3Oj+9u2Vo4j7f7Q9L/jE7XG/AGeaMtVON2NNEEmhJm/uhdvJXW+IDCwXrxOZEf5NEE9F7XGLr2LeQYnuP0dcQxDZ73W/60/9kmzKbSpGRPssI4Y34n0SmJMtIbhwUW9hYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=EqqCgflY; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c18af885c0so802251eec.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775262706; x=1775867506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PizuDW6eX0LEcIB7Va2kka7Ym4sd3SvAd0XyjOtDdMM=;
        b=EqqCgflYDbeVmvI/sdJtPzbNLePT2unTMBzot09evfNtkzEAbeKmxEg/c/WhHINmn+
         2k6laMjxg/C1uv/jS0UwULCB7QBG72Zhl+v1mFpZxdIrwZm1YS1WyyHM6YGelvu0eSBC
         m3VF+zRF4Ku1RtykxNbMv/nhvdzgarRpGrYRoWXIpa+6icUDgUuSHjtZoI8IRN+2GZd3
         r0W1fD4zaPBRl0Zywlvt6ZZvNrsfTdQyIYEFPaJGxovQWJ7RpaaI3v/kUYx5+NqtD1c5
         zAlXaAm7qLoVfC7ZcHQqR2hejnyDk3miTzuQV/QLILH1tYWKcYQjyP46LI4uEnrGJ/qV
         PyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775262706; x=1775867506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PizuDW6eX0LEcIB7Va2kka7Ym4sd3SvAd0XyjOtDdMM=;
        b=B3XgHHzH9+A0lMCRVcvqovDjXnwia/4fFBbzjHZJXcUkpkEwvMz7j/XeTy3fsNdTRq
         aJ6UAsBOzmnz2vJnm6VQ3WEI698ixVyA1jooFs6wW3rZmVguDutzd4DezEl92lbMUGrV
         td2zevbLQ4wCvFxN9eqKu5LzkdBLQgy0z51NjX7Oca6riW1JJOKnH5R2yynkNaDnMKUY
         1g3eqO90N7nKz3OPsuyY0EeICTAjJiiNqtgFVUg7PaMCC0ym0p5CzODYOPPBiWvHIBx/
         IS8RfZi/U9ZdjCIaHyFJlRolz2wd92WYL91+VSOvsh30jhmI/iatOQY7zmQDk9f/Ggtm
         yYIw==
X-Forwarded-Encrypted: i=1; AJvYcCXpqu1RCyBkGGPQNqUUktveOzPUZr7m52vvJDhiD1940D8GYI9aHEwl60iM/Q+9OXEEWePSW8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvra0GCwWEZxJWeXRSyCRMVczcBqi2PG36Utqqr7Divi2VucWu
	uqPiXMi/qcNh4OIKW7vxxnIHEY/4flrZ1el2ixxjJZoV9P60FRcHdb3cdbeH3r6etg==
X-Gm-Gg: AeBDieu+Ea1WBmlC+kNmfb1vB+fqMY4MuhgtnyV5MGLyp8jFEWFuy2KcTfqUo08Eh4L
	OI2Xabwyxw+aZNINR/1SOlnQFV0jAe8sbCmBBpibQWFQANxZPM0UapThWIr6K8O1XstHvv0cxV1
	f8jMwzQjgMYeHWjqQ31VEyUqw/wkKTmjxB2TaJIgK8L/oKaTdRkd7y36Mw2SxQeaRxR81HJPU92
	yrltnLh5VQBBiO933D98In/AA8QJckM7AtVChdzELHpqjSIv7hBH7mFiWzx8PgtbxETw8H8SgmH
	8WJDJQKqr4QdHeAbPWlyCK5kztkNDIOKCFBlzD1Yw9CezNf6JCjANzXGTwfOOqnTtMLRjE9bU9B
	6Hc0zK2WG2nWYgd/XEhXS3KWVGfGedu9eywPyJRa+qxbHZFs1N9ZXewRQU9uYa060PTZtZWBmuz
	mSxtbyO1wOxGTp2JuFq0U39f4wHx57nQ==
X-Received: by 2002:a05:693c:3005:b0:2c5:60d0:7031 with SMTP id 5a478bee46e88-2cbf97f57d8mr2610760eec.4.1775262706220;
        Fri, 03 Apr 2026 17:31:46 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb7ec57f9dsm4423861eec.11.2026.04.03.17.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 17:31:45 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:31:44 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Simon Horman <horms@kernel.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <7khxzrtdbjwz3wzvfhfuczi6i7vlq54atrspehj2yurbocagck@3m37lgh7xh4z>
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
 <20260403083415.GC11973@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403083415.GC11973@horms.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	FREEMAIL_CC(0.00)[blackwall.org,vger.kernel.org,lists.linux.dev,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275311-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 72F1A39957E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 09:34:15AM +0100, Simon Horman wrote:
> On Fri, Mar 27, 2026 at 01:46:39PM +0200, Nikolay Aleksandrov wrote:
> > On 27/03/2026 13:34, Simon Horman wrote:
> > > On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> > > > br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> > > > interval value from netlink without validation. When interval is 0,
> > > > usecs_to_jiffies(0) yields 0, causing the delayed work
> > > > (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> > > > itself with zero delay. This creates a tight loop on system_percpu_wq
> > > > that allocates and transmits MRP test frames at maximum rate, exhausting
> > > > all system memory and causing a kernel panic via OOM deadlock.
> > > 
> > > I would suspect the primary outcome of this problem is high CPU consumption
> > > rather than memory exhaustion. Is there a reason to expect that
> > > the transmitted fames can't be consumed as fast as they are created?
> > > 
> > 
> > +1
> > More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
> > conditions. This is a configuration error and OOM doesn't lead to panic unless
> > instructed to. I don't think this is worth changing at all.
> 
> Right, I was getting to think that too.
> 
> ...


Thank you for the review.

Regarding the privilege argument: this path is reachable from an
unprivileged user namespace, which checks CAP_NET_ADMIN against the
network namespace's user_ns. An unprivileged user can create a 
user+net namespace, obtain CAP_NET_ADMIN within it, set up a bridge
with MRP, and trigger the zero-interval loop. So this crosses a 
security boundary.

Regarding the OOM behavior: this does lead to a kernel panic without
panic_on_oom or oops=panic. The zero-delay workqueue loop allocates
memory from kernel context continuously. The OOM killer fires and kills
all related userspace processes, but the memory pressure originates 
from a kernel workqueue which the OOM killer cannot target. Once no 
killable processes remain, the kernel hits "System is deadlocked on 
memory" and panics. Below is the relevant dmesg from a test without
oops=panic:

[    5.254108] Kernel panic - not syncing: System is deadlocked on memory
[    5.254470] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.0.0-rc4+ #6
[    5.255524] Call Trace:
[    5.255796]  vpanic+0x694/0x780
[    5.256607]  out_of_memory+0x124e/0x1350
[    5.257281]  __alloc_pages_slowpath.constprop.0+0x2325/0x2dd0
[    5.258777]  __alloc_frozen_pages_noprof+0x4f8/0x800     

Best,
Xiang



