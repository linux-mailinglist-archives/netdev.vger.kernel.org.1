Return-Path: <netdev+bounces-281396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OD/CHWB72moBwEAu9opvQ
	(envelope-from <netdev+bounces-281396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:32:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE544753AC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3F9D304E32D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D7433372D;
	Mon, 27 Apr 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWOMyz9o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0871317165;
	Mon, 27 Apr 2026 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303479; cv=none; b=fgHxRSUkeln8ThU3vgQoxdC+dkw+7YoD8WDAX5q8JS9hUNZgkOqFUqnEVtFFQ4z6OCNKxy8r0S4r2EBQGVZc92wxq0dujIAd11SKc+hZgH6uYr3zCPJb4s1gNRgX9y264izRO5Jv6XbjYcRNwleAJ66ap6QyY3d4/bQPU7nD3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303479; c=relaxed/simple;
	bh=R5DLnmIxW2S4tSZP6THD6UB5dpyAV7DU4ODVzkQz070=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/Dapjt811E3D8Bq4eybMOeVPdPyTz0NxjKZqPgZhZyiPfx6BUQMz7e5DIh11nZC4OvYa+SndT0bINuWd/4zp0/pXUJfpobRk7dYCwVOqbXBrrYJ9krvTIOuktSAsn5lWoimQqv8hNnT6C+/os8xkth5eBKlAE5kWBhG4NyF7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWOMyz9o; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303478; x=1808839478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R5DLnmIxW2S4tSZP6THD6UB5dpyAV7DU4ODVzkQz070=;
  b=PWOMyz9od8dZl5eFNiMQVG7Y9X6cpZNqkg5Ani30+Ae4Tdgq6Bj3gOAt
   2/oO4ETXgnUgHxqP4rS3nvUUzZK34tszuj+JZs9LEOMncdMY2HUcfDJ4F
   PlcIhxDVTCXf0hIzHqf/R9tE0gUBIul4OmdCoBfQiRWIiBxXV4qD1VEww
   42frVP7AUdeAsnQm4px8v6sj4xVEyrunxzlgfysh+BJc5u9h0TIkCI+ji
   x0q1s17gnDmTwIpHg18600bV4j4hCcLV7uSH3J5c3cGz+8tAXhWmEt5iq
   Lhk+UWKQSipmzlPTFWAN0o7FQc/km4BSaTLkuppn6xbil3dvZGFMIe2el
   Q==;
X-CSE-ConnectionGUID: ITWC6WHtQIiN76owQy97ug==
X-CSE-MsgGUID: pWSkZpWGS+aVC6B9she2EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78383764"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78383764"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:24:37 -0700
X-CSE-ConnectionGUID: PwEIYR3NQcS8qjf/f3QjSw==
X-CSE-MsgGUID: hAM213QHTt2xPLJ5JbvL1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="233500399"
Received: from arjan-box.jf.intel.com ([10.88.27.153])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:24:37 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jreuter@yaina.de,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot+9c8999af06ca7df15fc6@syzkaller.appspotmail.com
Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in ax25_send_frame (3)
Date: Mon, 27 Apr 2026 08:25:26 -0700
Message-ID: <20260427152555.500903-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69ef2847.170a0220.11de9.001a.GAE@google.com>
References: <69ef2847.170a0220.11de9.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BDE544753AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid,fenrus.org:url,intel.com:dkim];
	FROM_NEQ_ENVFROM(0.00)[arjan@linux.intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-281396-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev,9c8999af06ca7df15fc6];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUBJECT_HAS_QUESTION(0.00)[]

This email is created by automation to help kernel developers
deal with a large volume of AI generated bug reports by decoding
oopses into more actionable information.

Decoded Backtrace

net/ax25/ax25_out.c (crash site, UAF read)

  32  ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen,
  32      const ax25_address *src, ax25_address *dest,
  32      ax25_digi *digi, struct net_device *dev)
  33  {
  34      ax25_dev *ax25_dev;
  35      ax25_cb *ax25;
       ...
  77      if (digi != NULL) {
->78          ax25->digipeat = kmemdup(digi, sizeof(*digi), GFP_ATOMIC);
              // <- digi = neigh->digipeat; freed ax25_digi; 66-byte UAF read
  79          if (ax25->digipeat == NULL) {
       ...
 115      return ax25;
 116  }

net/rose/rose_link.c (caller, t0timer callback)

  79  static void rose_t0timer_expiry(struct timer_list *t)
  80  {
  81      struct rose_neigh *neigh = timer_container_of(neigh, t, t0timer);
  82
->83      rose_transmit_restart_request(neigh);
         // <- inlined; calls rose_send_frame -> ax25_send_frame
         //    with neigh->digipeat as the digi argument
  84
  85      neigh->dce_mode = 0;
  86
  87      rose_start_t0timer(neigh);
  88  }

rose_send_frame() inlined at rose_link.c:106:

  95  static int rose_send_frame(struct sk_buff *skb, struct rose_neigh *neigh)
  96  {
       ...
 105      ax25s = neigh->ax25;
->106     neigh->ax25 = ax25_send_frame(skb, 260, rose_call,
             &neigh->callsign, neigh->digipeat, neigh->dev);
         // <- neigh->digipeat passed as digi; freed by rose_timer_expiry
 107      if (ax25s)
 108          ax25_cb_put(ax25s);
 109      return neigh->ax25 != NULL;
 110  }

net/rose/rose_timer.c (free site)

 164  static void rose_timer_expiry(struct timer_list *t)
 165  {
 166      struct rose_sock *rose = timer_container_of(rose, t, timer);
 167      struct sock *sk = &rose->sock;
       ...
 174      switch (rose->state) {
       ...
 182      case ROSE_STATE_2:  /* T3 */
->183          rose_neigh_put(rose->neighbour);
              // <- drops refcount to 0; frees neigh->digipeat (ax25_digi)
              //    and neigh itself; t0timer still pending
 184          rose_disconnect(sk, ETIMEDOUT, -1, -1);
 185          break;
       ...
 197  }

include/net/rose.h (rose_neigh_put, inline free function)

 160  static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
 161  {
 162      if (refcount_dec_and_test(&rose_neigh->use)) {
 163          if (rose_neigh->ax25)
 164              ax25_cb_put(rose_neigh->ax25);
->165          kfree(rose_neigh->digipeat);
              // <- frees the ax25_digi (66 bytes); t0timer not cancelled
 166          kfree(rose_neigh);
 167      }
 168  }

net/rose/rose_route.c (allocation site)

  84      if (rose_neigh == NULL) {
  85          rose_neigh = kmalloc_obj(*rose_neigh, GFP_ATOMIC);
       ...
 100          refcount_set(&rose_neigh->use, 1);
       ...
 107          if (rose_route->ndigis != 0) {
 108              rose_neigh->digipeat =
->109                  kmalloc_obj(ax25_digi, GFP_ATOMIC);
                  // <- allocates the 66-byte ax25_digi later freed and read
       ...
 124          }
 125      }


Tentative Analysis

The crash is a KASAN slab-use-after-free: rose_t0timer_expiry() reads
the freed rose_neigh->digipeat (an ax25_digi struct, 66 bytes) via
ax25_send_frame() -> kmemdup().

Commit d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
changed rose_timer_expiry() from merely decrementing the plain 'use'
counter to calling rose_neigh_put(), which now frees rose_neigh (and
its digipeat) when the refcount hits zero. The new rose_neigh_put()
omits timer cancellation, so after it returns the t0timer embedded in
the (now-freed) rose_neigh can still fire in the same TIMER_SOFTIRQ
batch.

The race on a single-CPU machine (the syzbot scenario) is purely
sequential: rose_timer_expiry() fires first, frees the neigh; then
rose_t0timer_expiry() fires next in the same run_timer_base batch with
a dangling neigh pointer, passes neigh->digipeat to ax25_send_frame,
and kmemdup triggers the KASAN report.

Before d860d1faa6b2, rose_timer_expiry() never freed the neigh; the
free was always performed by rose_remove_neigh() which called
timer_delete_sync() on both timers before freeing. The refcount
conversion introduced a new free path that missed this cancellation.


Potential Solution

Add timer_delete() calls for both ftimer and t0timer inside
rose_neigh_put() before the kfree calls, mirroring what
rose_remove_neigh() already does via timer_delete_sync(). The
non-synchronous variant is required because rose_neigh_put() may be
called from softirq context.

   static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
   {
       if (refcount_dec_and_test(&rose_neigh->use)) {
           timer_delete(&rose_neigh->ftimer);
           timer_delete(&rose_neigh->t0timer);
           if (rose_neigh->ax25)
               ax25_cb_put(rose_neigh->ax25);
           kfree(rose_neigh->digipeat);
           kfree(rose_neigh);
       }
   }


More information

Oops-Analysis: http://oops.fenrus.org/reports/lkml/69ef2847.170a0220.11de9.001a.GAE_google.com/
Assisted-by: Copilot:claude-sonnet-4.6 linux-kernel-oops-x86.

