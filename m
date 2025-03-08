Return-Path: <netdev+bounces-173203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A7A57DF1
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 21:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF703B278A
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 20:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9231552FD;
	Sat,  8 Mar 2025 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOUhwStM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D1ECF
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741464253; cv=none; b=XCwwaNoexDLHqFkQKBsXg3bHgR9ZsnsxKEZSf/L9WWJ3OpkXzfioyTi84Vs03/D9CvX+Sy1PuUxB9g9wf3WGo2Hq1OjlEcgCGiWBTRNb/KGKtspua8yFZ6JlM2EcvRprhGYTqXVl5Fnp3KVjELi9MHV3xdJx4e7M3yXQGzSJ4mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741464253; c=relaxed/simple;
	bh=ryLPmpCSdVMe0M26o/lxW0KDr0KYblyjS78RXZj7cjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jSdoiQ+LqJnU2gl3DOHqPMdcL+UIiMj1F6DdjZ+fg6cQgux7DRtvzbyxYXeBcGZPxCpyoJz4D9J3uEU+R5kujHhkAO08OspolOfwLAXtRo/soag1riumoG1Aur6SAY+cAk8TEhKwu+aGa1gcW5ogbhoBpBHIxLDu/YQeL8RYDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOUhwStM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741464249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ1ng78giZpgZ1pkR/H9sfY5f+t35cP7au54QDB9oqk=;
	b=GOUhwStMPdZ2LdABQiN//0PTHjcp+MI25FffkdWEnVLIe53gTQ9WzRMrhifRRq18KRPcl2
	g7h9AI99selThbqwBsphPKuX4kIZXYsG1QhBZusznLxM2O/glNaJs1tS1fV3C58cGtowap
	1XeTQMWfjwrqeIDsDLN7ARd6vLmi848=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-MbNUwnKLPu2TqG3zxzVckQ-1; Sat,
 08 Mar 2025 15:04:05 -0500
X-MC-Unique: MbNUwnKLPu2TqG3zxzVckQ-1
X-Mimecast-MFC-AGG-ID: MbNUwnKLPu2TqG3zxzVckQ_1741464243
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D2CA195608A;
	Sat,  8 Mar 2025 20:04:03 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.152])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7507E19560AD;
	Sat,  8 Mar 2025 20:04:00 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  dev@openvswitch.org,  linux-kernel@vger.kernel.org,  Pravin B Shelar
 <pshelar@ovn.org>,  Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [PATCH net] net: openvswitch: remove misbehaving actions length
 check
In-Reply-To: <20250308004609.2881861-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Sat, 8 Mar 2025 01:45:59 +0100")
References: <20250308004609.2881861-1-i.maximets@ovn.org>
Date: Sat, 08 Mar 2025 15:03:58 -0500
Message-ID: <f7tmsdv2ssx.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Ilya Maximets <i.maximets@ovn.org> writes:

> The actions length check is unreliable and produces different results
> depending on the initial length of the provided netlink attribute and
> the composition of the actual actions inside of it.  For example, a
> user can add 4088 empty clone() actions without triggering -EMSGSIZE,
> on attempt to add 4089 such actions the operation will fail with the
> -EMSGSIZE verdict.  However, if another 16 KB of other actions will
> be *appended* to the previous 4089 clone() actions, the check passes
> and the flow is successfully installed into the openvswitch datapath.
>
> The reason for a such a weird behavior is the way memory is allocated.
> When ovs_flow_cmd_new() is invoked, it calls ovs_nla_copy_actions(),
> that in turn calls nla_alloc_flow_actions() with either the actual
> length of the user-provided actions or the MAX_ACTIONS_BUFSIZE.  The
> function adds the size of the sw_flow_actions structure and then the
> actually allocated memory is rounded up to the closest power of two.
>
> So, if the user-provided actions are larger than MAX_ACTIONS_BUFSIZE,
> then MAX_ACTIONS_BUFSIZE + sizeof(*sfa) rounded up is 32K + 24 -> 64K.
> Later, while copying individual actions, we look at ksize(), which is
> 64K, so this way the MAX_ACTIONS_BUFSIZE check is not actually
> triggered and the user can easily allocate almost 64 KB of actions.
>
> However, when the initial size is less than MAX_ACTIONS_BUFSIZE, but
> the actions contain ones that require size increase while copying
> (such as clone() or sample()), then the limit check will be performed
> during the reserve_sfa_size() and the user will not be allowed to
> create actions that yield more than 32 KB internally.
>
> This is one part of the problem.  The other part is that it's not
> actually possible for the userspace application to know beforehand
> if the particular set of actions will be rejected or not.
>
> Certain actions require more space in the internal representation,
> e.g. an empty clone() takes 4 bytes in the action list passed in by
> the user, but it takes 12 bytes in the internal representation due
> to an extra nested attribute, and some actions require less space in
> the internal representations, e.g. set(tunnel(..)) normally takes
> 64+ bytes in the action list provided by the user, but only needs to
> store a single pointer in the internal implementation, since all the
> data is stored in the tunnel_info structure instead.
>
> And the action size limit is applied to the internal representation,
> not to the action list passed by the user.  So, it's not possible for
> the userpsace application to predict if the certain combination of
> actions will be rejected or not, because it is not possible for it to
> calculate how much space these actions will take in the internal
> representation without knowing kernel internals.
>
> All that is causing random failures in ovs-vswitchd in userspace and
> inability to handle certain traffic patterns as a result.  For example,
> it is reported that adding a bit more than a 1100 VMs in an OpenStack
> setup breaks the network due to OVS not being able to handle ARP
> traffic anymore in some cases (it tries to install a proper datapath
> flow, but the kernel rejects it with -EMSGSIZE, even though the action
> list isn't actually that large.)
>
> Kernel behavior must be consistent and predictable in order for the
> userspace application to use it in a reasonable way.  ovs-vswitchd has
> a mechanism to re-direct parts of the traffic and partially handle it
> in userspace if the required action list is oversized, but that doesn't
> work properly if we can't actually tell if the action list is oversized
> or not.
>
> Solution for this is to check the size of the user-provided actions
> instead of the internal representation.  This commit just removes the
> check from the internal part because there is already an implicit size
> check imposed by the netlink protocol.  The attribute can't be larger
> than 64 KB.  Realistically, we could reduce the limit to 32 KB, but
> we'll be risking to break some existing setups that rely on the fact
> that it's possible to create nearly 64 KB action lists today.
>
> Vast majority of flows in real setups are below 100-ish bytes.  So
> removal of the limit will not change real memory consumption on the
> system.  The absolutely worst case scenario is if someone adds a flow
> with 64 KB of empty clone() actions.  That will yield a 192 KB in the
> internal representation consuming 256 KB block of memory.  However,
> that list of actions is not meaningful and also a no-op.  Real world
> very large action lists (that can occur for a rare cases of BUM
> traffic handling) are unlikely to contain a large number of clones and
> will likely have a lot of tunnel attributes making the internal
> representation comparable in size to the original action list.
> So, it should be fine to just remove the limit.
>
> Commit in the 'Fixes' tag is the first one that introduced the
> difference between internal representation and the user-provided action
> lists, but there were many more afterwards that lead to the situation
> we have today.
>
> Fixes: 7d5437c709de ("openvswitch: Add tunneling interface.")
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Thanks for the detailed explanation.  Do you think it's useful to
check with selftest:

   # python3 ./ovs-dpctl.py add-dp flbr
   # python3 ./ovs-dpctl.py add-flow flbr \
     "in_port(0),eth(),eth_type(0x806),arp()" \
     $(echo 'print("clone(),"*4089)' | python3)

I think a limit test is probably a good thing to have anyway (although
after this commit we will rely on netlink limits).


Reviewed-by: Aaron Conole <aconole@redhat.com>


