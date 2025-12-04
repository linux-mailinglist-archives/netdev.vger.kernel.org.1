Return-Path: <netdev+bounces-243656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C50CA55CD
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 21:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F03430FF005
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 20:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B95D346792;
	Thu,  4 Dec 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpTw5AUI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715843451B0
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870126; cv=none; b=YgoD8uF14F+7ctZa4dcJYrNwT6EKQ5PWbW/ZYRMED6i6SX+ZNIiCjIe3APFGyNIpxULQoHFLLd47xMSVCFWQElnt6Tc6nYxhcDYUQT4bBf2ZkwQCJpyUMi1JHNynl4EHKpHvywjsiSoqbcHGVabW6bhqT6ZeEXQmrw4B3cdg4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870126; c=relaxed/simple;
	bh=YA1zVtYoHoQFO6p4Cvq9dMcyaOWkB6No/GRyROO3B0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pMTm63r5GQxd6Zt4nGDxL1YQkfPLxDRZt520CTtnh63flGfXyUS6qq4tmyeyWmt+PmCIAScn8jKjpVEJb6lw2TXYpG+VXbC9+IhJKBKndm2YHJj+80lxCRG4j9Bdr0OvT/9PuU2Z2NA31y94QQtZnBns/2yPX8M5EqN/wbSvx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpTw5AUI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764870123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri00rxjoOFGWjAtyncp0oYw/MKV8HGO39TvOr0ZEjCA=;
	b=YpTw5AUI2nzhTGTWS4CbKeVtElvd/B0LX5dn3HFIrIue/3SDxQVcECcCySXCrQg8IarrgB
	j2842pSg05i42aq4k8t/YOZ23OJlkfEpH9NU75wAzjZdd4xdiHz6lMUG4ZDCoYIF6DPscw
	6sU6xvi6GQ0aKh3WU20jcDb8oWsvPdU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-xALFqEBrMwezUVSuSa71Ug-1; Thu,
 04 Dec 2025 12:41:59 -0500
X-MC-Unique: xALFqEBrMwezUVSuSa71Ug-1
X-Mimecast-MFC-AGG-ID: xALFqEBrMwezUVSuSa71Ug_1764870117
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C26291956095;
	Thu,  4 Dec 2025 17:41:56 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6A0C19560B4;
	Thu,  4 Dec 2025 17:41:53 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  linux-kernel@vger.kernel.org,  dev@openvswitch.org,  Eelco Chaudron
 <echaudro@redhat.com>,  Willy Tarreau <w@1wt.eu>,  LePremierHomme
 <kwqcheii@proton.me>,  Junvy Yang <zhuque@tencent.com>
Subject: Re: [PATCH net] net: openvswitch: fix middle attribute validation
 in push_nsh() action
In-Reply-To: <20251204105334.900379-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Thu, 4 Dec 2025 11:53:32 +0100")
References: <20251204105334.900379-1-i.maximets@ovn.org>
Date: Thu, 04 Dec 2025 12:41:51 -0500
Message-ID: <f7ttsy6cffk.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Ilya Maximets <i.maximets@ovn.org> writes:

> The push_nsh() action structure looks like this:
>
>  OVS_ACTION_ATTR_PUSH_NSH(OVS_KEY_ATTR_NSH(OVS_NSH_KEY_ATTR_BASE,...))
>
> The outermost OVS_ACTION_ATTR_PUSH_NSH attribute is OK'ed by the
> nla_for_each_nested() inside __ovs_nla_copy_actions().  The innermost
> OVS_NSH_KEY_ATTR_BASE/MD1/MD2 are OK'ed by the nla_for_each_nested()
> inside nsh_key_put_from_nlattr().  But nothing checks if the attribute
> in the middle is OK.  We don't even check that this attribute is the
> OVS_KEY_ATTR_NSH.  We just do a double unwrap with a pair of nla_data()
> calls - first time directly while calling validate_push_nsh() and the
> second time as part of the nla_for_each_nested() macro, which isn't
> safe, potentially causing invalid memory access if the size of this
> attribute is incorrect.  The failure may not be noticed during
> validation due to larger netlink buffer, but cause trouble later during
> action execution where the buffer is allocated exactly to the size:
>
>  BUG: KASAN: slab-out-of-bounds in nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
>  Read of size 184 at addr ffff88816459a634 by task a.out/22624
>
>  CPU: 8 UID: 0 PID: 22624 6.18.0-rc7+ #115 PREEMPT(voluntary)
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x51/0x70
>   print_address_description.constprop.0+0x2c/0x390
>   kasan_report+0xdd/0x110
>   kasan_check_range+0x35/0x1b0
>   __asan_memcpy+0x20/0x60
>   nsh_hdr_from_nlattr+0x1dd/0x6a0 [openvswitch]
>   push_nsh+0x82/0x120 [openvswitch]
>   do_execute_actions+0x1405/0x2840 [openvswitch]
>   ovs_execute_actions+0xd5/0x3b0 [openvswitch]
>   ovs_packet_cmd_execute+0x949/0xdb0 [openvswitch]
>   genl_family_rcv_msg_doit+0x1d6/0x2b0
>   genl_family_rcv_msg+0x336/0x580
>   genl_rcv_msg+0x9f/0x130
>   netlink_rcv_skb+0x11f/0x370
>   genl_rcv+0x24/0x40
>   netlink_unicast+0x73e/0xaa0
>   netlink_sendmsg+0x744/0xbf0
>   __sys_sendto+0x3d6/0x450
>   do_syscall_64+0x79/0x2c0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>
> Let's add some checks that the attribute is properly sized and it's
> the only one attribute inside the action.  Technically, there is no
> real reason for OVS_KEY_ATTR_NSH to be there, as we know that we're
> pushing an NSH header already, it just creates extra nesting, but
> that's how uAPI works today.  So, keeping as it is.
>
> Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
> Reported-by: Junvy Yang <zhuque@tencent.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Checked it out using also the userspace kmod test suite, and the
kernel selftest scripts.  Change makes sense to me.

Reviewed-by: Aaron Conole <aconole@redhat.com>


