Return-Path: <netdev+bounces-245445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B94CCDA10
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 22:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C3E6300BEFC
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 21:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3E21772A;
	Thu, 18 Dec 2025 21:04:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA23A946C;
	Thu, 18 Dec 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091883; cv=none; b=Hq5TOQyJ/vc4c1Tp0rsoUg1fsRJOHQUauMfmSpn8NzaPvk9VqjNXSE+yZmeYiD1AjyHRuQmBwqNsJBihHVdKDOXJ80jJCHdPzHFiAQADm5Nx37f4UY8dlx/AOc4JzHR1n0hNjkqsxr+a5CFaZUSJ39G6uRT4x05F8cFPXPrXLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091883; c=relaxed/simple;
	bh=Ftf6V3r3Zip5ge5N9Z7hCqESZ7wtkFQLwDCe4A8VW2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d70LRu0qMQxcfYOQFZUboeRf3LH0//YkRAcbe97D4w0sCRn0bGUP78SRsEsaf7enIMNfNgKvMta9REc69TkTtjKZaY891gJPIUhq6bhwOOg3K/YTJxA9uK3Km0/2grDGTwFmDHWJUNQhIG8JqEjCerJ2zWL+yme+IiGDD/u4zF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4D0958A3F0;
	Thu, 18 Dec 2025 21:04:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 7E6382000D;
	Thu, 18 Dec 2025 21:04:31 +0000 (UTC)
Date: Thu, 18 Dec 2025 16:06:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next v1] ipv6: fix a BUG in rt6_get_pcpu_route()
 under PREEMPT_RT
Message-ID: <20251218160610.788b0bf8@gandalf.local.home>
In-Reply-To: <280b18c6-2348-426f-a1b1-8c17d229c21c@redhat.com>
References: <20251209124805.379112-1-jiayuan.chen@linux.dev>
	<280b18c6-2348-426f-a1b1-8c17d229c21c@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5176k8bcqhqgndosue6ob497dre74ekh
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7E6382000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/JNyIy4Sezb99pwWameEqN+xRHKird9jI=
X-HE-Tag: 1766091871-587984
X-HE-Meta: U2FsdGVkX1/YEVG6Il4gdYatoVu9UEzV9c4VIQR+8tM8qV/ag0rdaZjdJ6ilvyNps+ExLg+sFZW84GuUF6wGyyWVgNjRf7JwH9J2pHSTwzsFz/QAGjCBgyLS3LI8ev9GU3aK+pYgXtK4qG8DTesiNRQNdblcDiTKOx+qrdM8lOSQ0ONfFtEp9b8akqvH7UkCnffShUJIe7LVefltziYZ75xvHmFAP345TIyFZHVzu43mjw5wxB5cqDCkUzq0EgAXpqvG2Ror7KlFXD/cSDAqwEvNKxF615TePWENsQjQgVunpL2MP2eSYXJc6KH9IGyG2huJqOtU/5E0iX5now+qpGVQBKOAKzDx

On Thu, 18 Dec 2025 13:25:31 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> AFAICS, this part is not needed: local_bh_disable() ensures migrating is
> already disabled, if !CONFIG_PREEMPT_RT_NEEDS_BH_LOCK or preemption is
> disabled, when CONFIG_PREEMPT_RT_NEEDS_BH_LOCK==y

As the code has this:

	/* First entry of a task into a BH disabled section? */
	if (!current->softirq_disable_cnt) {
		if (preemptible()) {
			if (IS_ENABLED(CONFIG_PREEMPT_RT_NEEDS_BH_LOCK))
				local_lock(&softirq_ctrl.lock);
			else
				migrate_disable();

			/* Required to meet the RCU bottomhalf requirements. */
			rcu_read_lock();
		} else {
			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
		}
	}

It looks as though migration will always be disabled (local_lock() also
disables migration). It will warn if preemption is disabled.

But yeah, the added migrate_disable() is not needed.

-- Steve

