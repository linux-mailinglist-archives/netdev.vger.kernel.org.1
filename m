Return-Path: <netdev+bounces-302058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n11ZOylrPWrI2wgAu9opvQ
	(envelope-from <netdev+bounces-302058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:53:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5309C6C808C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 19:53:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=phenome.org header.s=oak1 header.b=k6ubPquj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302058-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302058-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=phenome.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942AD30D8FC5
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879F3EB0FC;
	Thu, 25 Jun 2026 17:43:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902C1684B0
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 17:43:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409437; cv=none; b=pvXF2lyxUwUSIDm9kf+s8U9UyOgzv9wLnJMpzDc4MgdY0Z3K9zj93iepOzZV2DR5iFiCABLgLLglfnHXB+KytdaXBXZb/E+ZJ0wxwarfRqZ1Dx3ebRwO5K3FfQjkMMPdVBgqcZ+DZFpdTBT1w4Jb5+NswntY43+yj6lIzLQnJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409437; c=relaxed/simple;
	bh=fea3ohHdie/L+zImwKQNsGutZYTSPDT5wQXrCTomoRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDcFE6iktIcPd9vVG9IkGash41onuJvMueDatniJVKQzBYVj9Z4M0C7MemZ+M7yog90hRBlMHfqEPB9VwiJVh7hjFu7xd5G2IzhEu8faTRnUL8QVMq6DWDTPmwfVxkCUta3vsxFDwziU6V/s8bMLwvULWjJg4lReXrwEvtsbAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=k6ubPquj; arc=none smtp.client-ip=193.110.157.52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1782409424; x=1783273425; bh=fea3
	ohHdie/L+zImwKQNsGutZYTSPDT5wQXrCTomoRE=; b=k6ubPquj7wWVyr16Fgwm
	Xd7tg9ml/dDJ5dvzbkBgbAhDj1clQLQzl4rDyHCd1gQitXGam8+EBlemZ8SYLnH6
	TUC6NspkRoPshg9MkNfeq38DHsO5wLTjS8ZoA5ocD6n43+X2c4/yCGp8Q9vml4MR
	ox2IIGyHhDBkE3QelVGbUx4i/05j2Q64L9MPO/gvT+yVOro0xOb5PySi24MxlDBt
	InzQoTxhEx/cr0g3u+IG2ZnVFLNAXWVvKUqCZ2H5rqk4Crcc8NQp/dISRFoB0BAp
	TFBEe7sCUnn05neS98HCoU1vA7Gt7VbYBcYBn3ZyoZSLuNd7ql2/uhm5C/0CT4jd
	VQ==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Thu, 25 Jun 2026 19:43:43 +0200 (CEST)
Date: Thu, 25 Jun 2026 19:43:41 +0200
From: Antony Antony <antony@phenome.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+0ac4d84afe1066a1f3e9@syzkaller.appspotmail.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Tobias Brunner <tobias@strongswan.org>,
	Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH net] xfrm: fix stack-out-of-bounds in
 xfrm_tmpl_resolve_one
Message-ID: <aj1ozZ8VCwno_myC@Antony2201.local>
References: <20260625092417.890245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625092417.890245-1-edumazet@google.com>
X-Mutt-References: <20260625092417.890245-1-edumazet@google.com>
X-Mutt-Fcc: ~/sent
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phenome.org,none];
	R_DKIM_ALLOW(-0.20)[phenome.org:s=oak1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+0ac4d84afe1066a1f3e9@syzkaller.appspotmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:tobias@strongswan.org,m:chopps@labn.net,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302058-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[phenome.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony@phenome.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,secunet.com,gondor.apana.org.au,strongswan.org,labn.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,0ac4d84afe1066a1f3e9];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5309C6C808C

Hi Eric,

On Thu, Jun 25, 2026 at 09:24:17AM +0000, Eric Dumazet wrote:
> syzbot reported a stack-out-of-bounds read in xfrm_state_find()
> which flows from xfrm_tmpl_resolve_one().
> 
> The issue occurs when a policy has a mix of family-changing templates
> (e.g. BEET or IPTFS) and transport templates. If an optional
> family-changing template is skipped because no state is found, the
> current family of the flow (`family`) is not updated. The subsequent
> transport template is then evaluated using the unchanged family (e.g.
> AF_INET), but it uses the template's `encap_family` (e.g. AF_INET6)
> to perform the state lookup.

Thank you for the quick fix. I would like to look at it from a
different angle.

The commit message mentions BEET as a trigger, but I notice BEET
optional templates in outbound policies are already rejected since:

commit 3d776e31c841 ("xfrm: Reject optional tunnel/BEET mode templates in outbound policies")

Here is the effect of blocker for BEET mode. 

ip netns exec ns_a ip link add dummy0 type dummy
ip netns exec ns_a ip link set dummy0 up
ip netns exec ns_a ip addr add 10.1.1.1/24 dev dummy0
ip xfrm policy add src 10.1.1.1/32 dst 10.1.1.2/32 dir out tmpl \
  src fc00::dead:1 dst fc00::dead:2 proto esp reqid 1 mode beet \
  level use tmpl src fc00::dead:1 dst fc00::dead:2 proto esp reqid 2 \
  mode transport
Error: Mode in optional template not allowed in outbound policy.

However, IPTF is allowed. I think fix should include this.
Does syzbot give a clue which mode was used? I am new syzbot postmartum!
Any way look cordump or so tsee the which mode was actually used?
I suspect it is IPTFS, other mode would not tirgger this code path.

In practice, only IPTFS can still reach xfrm_tmpl_resolve_one() with
the family-mismatch condition, since xfrm_user.c has no equivalent
guard for XFRM_MODE_IPTFS.

ip link add dummy0 type dummy
ip link set dummy0 up
ip addr add 10.1.1.1/24 dev dummy0
ip xfrm policy add src 10.1.1.1/32 dst 10.1.1.2/32 dir out tmpl  \
 src fc00::dead:1 dst fc00::dead:2 proto esp reqid 1 mode iptfs \ 
 level use tmpl src fc00::dead:1 dst fc00::dead:2 proto esp reqid 2 \
 mode transport

ping -W 1 -c 1 10.1.1.2
PING 10.1.1.2 (10.1.1.2) 56(84) bytes of data.

[    3.477151] Adding 998396k swap on /dev/vda5.  Priority:-1 extents:1 across:998396k
[   17.565672] ==================================================================
[   17.567270] BUG: KASAN: stack-out-of-bounds in __xfrm6_addr_hash+0x11e/0x170
[   17.567270] Read of size 4 at addr ffff88800f79fd20 by task ping/2777

[   17.567270] CPU: 1 UID: 0 PID: 2777 Comm: ping Not tainted 7.1.0-rc7-02029-gfb92cc029b34-dirty #94 PREEMPT(full)
[   17.567270] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   17.567270] Call Trace:
[   17.567270]  <TASK>
[   17.567270]  dump_stack_lvl+0x47/0x70
[   17.567270]  ? __xfrm6_addr_hash+0x11e/0x170
[   17.567270]  print_report+0x152/0x4b0
[   17.567270]  ? ksys_mmap_pgoff+0x6d/0xa0
[   17.567270]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.567270]  ? rcu_read_unlock_sched+0xa/0x20
[   17.567270]  ? __virt_addr_valid+0x21b/0x230
[   17.567270]  ? __xfrm6_addr_hash+0x11e/0x170
[   17.567270]  kasan_report+0xa8/0xd0
[   17.567270]  ? __xfrm6_addr_hash+0x11e/0x170
[   17.567270]  __xfrm6_addr_hash+0x11e/0x170
[   17.567270]  __xfrm_dst_hash+0x24/0xc0
[   17.567270]  xfrm_state_find+0xa2d/0x2f90
[   17.567270]  ? __pfx_xfrm_state_find+0x10/0x10
[   17.567270]  ? __pfx_ftrace_graph_ret_addr+0x10/0x10
[   17.567270]  ? __pfx_ftrace_graph_ret_addr+0x10/0x10
[   17.567270]  xfrm_tmpl_resolve_one+0x210/0x570
[   17.567270]  ? __pfx_xfrm_tmpl_resolve_one+0x10/0x10
[   17.567270]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   17.567270]  ? kernel_text_address+0x5b/0x80
[   17.567270]  ? __kernel_text_address+0xe/0x30
[   17.567270]  ? unwind_get_return_address+0x5e/0x90
[   17.567270]  ? arch_stack_walk+0x8c/0xe0
[   17.567270]  xfrm_tmpl_resolve+0x130/0x200
[   17.567270]  ? __pfx_xfrm_tmpl_resolve+0x10/0x10
[   17.567270]  ? __pfx_xfrm_policy_inexact_lookup_rcu+0x10/0x10
[   17.567270]  ? __refcount_add_not_zero.constprop.0+0xb2/0x110
[   17.567270]  ? __pfx___refcount_add_not_zero.constprop.0+0x10/0x10
[   17.567270]  xfrm_resolve_and_create_bundle+0xd5/0x310
[   17.567270]  ? __pfx_xfrm_resolve_and_create_bundle+0x10/0x10
[   17.567270]  ? __pfx_xfrm_policy_lookup_bytype+0x10/0x10
[   17.567270]  ? __pfx_xfrm_policy_lookup_bytype+0x10/0x10
[   17.567270]  xfrm_lookup_with_ifid+0x3d7/0xb80
[   17.567270]  ? __pfx_xfrm_lookup_with_ifid+0x10/0x10
[   17.567270]  ? ip_route_output_key_hash+0xc6/0x110
[   17.567270]  ? kasan_save_track+0x10/0x30
[   17.567270]  xfrm_lookup_route+0x18/0xe0
[   17.567270]  ip4_datagram_release_cb+0x4c9/0x530
[   17.567270]  ? __pfx_ip4_datagram_release_cb+0x10/0x10
[   17.567270]  ? do_raw_spin_lock+0x71/0xc0
[   17.567270]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   17.567270]  release_sock+0xb0/0x170
[   17.567270]  udp_connect+0x43/0x50
[   17.567270]  __sys_connect+0xa6/0x100
[   17.567270]  ? alloc_fd+0x2e9/0x300
[   17.567270]  ? __pfx___sys_connect+0x10/0x10
[   17.567270]  ? preempt_latency_start+0x1f/0x70
[   17.567270]  ? fd_install+0x7e/0x150
[   17.567270]  ? rcu_read_unlock_sched+0xa/0x20
[   17.567270]  ? __sys_socket+0xdf/0x130
[   17.567270]  ? __pfx___sys_socket+0x10/0x10
[   17.567270]  ? vma_refcount_put+0x43/0xa0
[   17.567270]  __x64_sys_connect+0x7e/0x90
[   17.567270]  do_syscall_64+0x11b/0x2b0
[   17.567270]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.567270] RIP: 0033:0x7f6604eb0570
[   17.567270] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d f9 ca 0d 00 00 74 17 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 54
[   17.567270] RSP: 002b:00007ffd02bdf658 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
[   17.567270] RAX: ffffffffffffffda RBX: 00007ffd02bdf690 RCX: 00007f6604eb0570
[   17.567270] RDX: 0000000000000010 RSI: 00007ffd02bdf690 RDI: 0000000000000005
[   17.567270] RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
[   17.567270] R10: 0000000000000006 R11: 0000000000000202 R12: 0000000000000005
[   17.567270] R13: 0000000000000000 R14: 0000557fb777a340 R15: 0000000000000000
[   17.567270]  </TASK>

[   17.567270] The buggy address belongs to stack of task ping/2777
[   17.567270]  and is located at offset 88 in frame:
[   17.567270]  ip4_datagram_release_cb+0x0/0x530

[   17.567270] This frame has 1 object:
[   17.567270]  [32, 88) 'fl4'

[   17.567270] The buggy address belongs to the physical page:
[   17.567270] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xf79f
[   17.567270] flags: 0x4000000000000000(zone=1)
[   17.567270] raw: 4000000000000000 0000000000000000 ffffea00003de7c8 0000000000000000
[   17.567270] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   17.567270] page dumped because: kasan: bad access detected

[   17.567270] Memory state around the buggy address:
[   17.567270]  ffff88800f79fc00: f2 f2 00 00 f3 f3 00 00 00 00 00 00 00 00 00 00
[   17.567270]  ffff88800f79fc80: 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00
[   17.567270] >ffff88800f79fd00: 00 00 00 00 f3 f3 f3 f3 f3 00 00 00 00 00 00 00
[   17.567270]                                ^
[   17.567270]  ffff88800f79fd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1
[   17.567270]  ffff88800f79fe00: f1 f1 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   17.567270] ==================================================================
[   17.658376] Disabling lock debugging due to kernel taint


I have another proposed fix:
https://lore.kernel.org/all/20260625-xfrm-pol-out-tmpl-iptfs-reject-fix-v1-1-814861129086@secunet.com/

After this IPTF wouldn't be allowed.

ip xfrm policy add src 10.1.1.1/32 dst 10.1.1.2/32 dir out tmpl \
 src fc00::dead:1 dst fc00::dead:2 proto esp reqid 1 mode iptfs \
 level use tmpl src fc00::dead:1 dst fc00::dead:2 proto esp reqid 2 mode transport

  Error: Mode in optional template not allowed in outbound policy.

> 
> This causes `xfrm_state_find()` to interpret the IPv4 flow addresses
> (allocated on the stack as `struct flowi4` in `raw_sendmsg` or
> `udp_sendmsg`) as IPv6 addresses (`xfrm_address_t`), leading to a
> 16-byte read from the 4-byte stack variables, triggering KASAN.
> 
> Fix this by tracking the active family of the flow (`cur_family`)
> during template resolution:
> 1. Initialize `cur_family` to the flow's original family.
> 2. For transport templates, verify that `tmpl->encap_family` matches
>    `cur_family`. If they mismatch, abort with -EINVAL.
> 3. When a template that can change the family (tunnel, beet, iptfs) is
>    successfully resolved, update `cur_family` to `tmpl->encap_family`.
> 4. If a template is skipped (optional), `cur_family` remains unchanged.
> 
> This prevents mismatched transport lookups and makes the resolution
> robust against any family-transition gaps.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+0ac4d84afe1066a1f3e9@syzkaller.appspotmail.com
> Closes: https://www.spinics.net/lists/netdev/msg1200923.html
> Assisted-by: Jetski:gemini-3.1-pro-preview
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> ---


