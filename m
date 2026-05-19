Return-Path: <netdev+bounces-289494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN1vID2BDGpPigUAu9opvQ
	(envelope-from <netdev+bounces-289494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:26:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D79F45816D5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E728E3046069
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A7B3F1AAA;
	Tue, 19 May 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aya43SRk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9802BCF46
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203572; cv=none; b=FTu9YwB2t1bZx/m1dB+/I68ZUR0AElA7ByPk1f9+YOGbTX2OE/N5iZJPT+zQYY7bDGKrvWYVarguH15wBp9u47xC/LXqdgbU9FBPEgY+6Hzl58ukK1yx8rtIZIoGsPjUL/RuQNFA0t6JPJPbfroSQFAgwEhB07pJC/oHy+PpD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203572; c=relaxed/simple;
	bh=k2Gys1WSXj9cUNZuoppth6MBxRzei5WQ8ljX2QfZ/sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DNe5u42o+w0/Z26K+ier72NlRSlxouhpMB7qZOfclme1QCOBkgN9sFH76kHgfaJjw8fadRs9SArEZIG/xQkMQE6BYAvALnrmdo2MtcHfdtNaCGE8yVXUW8dJXlODDZ3hD3wVbL5DUwqRqR3mF0kCmNsoRqXnisz18vwAkOYGBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aya43SRk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779203569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NlRK7WHE5X+HRUb6MZqDZLmc/NWUl9fce+uDFFEwApM=;
	b=Aya43SRkejDBPfFJtlCIi0yRQ7uoy3XM+9Tbnu73VGzUJQ1UfeM3olw2VkmmQV1qDq1heX
	dnSEe2/xbZcilaSEVQHOUKhxxdr3DmixEe1PdDw97uLR76h2Dimb/iCme6qemAhrm7Xbyr
	kutB0eHyQLil9ZE3kKpxis0fISuujtc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-VmvgSFy9N6m4u2ZaC8bb4Q-1; Tue,
 19 May 2026 11:12:46 -0400
X-MC-Unique: VmvgSFy9N6m4u2ZaC8bb4Q-1
X-Mimecast-MFC-AGG-ID: VmvgSFy9N6m4u2ZaC8bb4Q_1779203563
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 754D318002C7;
	Tue, 19 May 2026 15:12:43 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.89.15])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D5E030001A2;
	Tue, 19 May 2026 15:12:38 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Eelco Chaudron <echaudro@redhat.com>,  David
 Ahern <dsahern@kernel.org>,  Ido Schimmel <idosch@nvidia.com>,  Shuah Khan
 <shuah@kernel.org>,  Nikolay Aleksandrov <razor@blackwall.org>,  Kuniyuki
 Iwashima <kuniyu@google.com>,  Petr Machata <petrm@nvidia.com>,  Fernando
 Fernandez Mancera <fmancera@suse.de>,  Antoine Tenart
 <atenart@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,
  linux-kernel@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [RFC net-next 0/6] openvswitch: remove support for legacy
 tunnel ports
In-Reply-To: <20260513183559.2141010-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Wed, 13 May 2026 20:35:20 +0200")
References: <20260513183559.2141010-1-i.maximets@ovn.org>
Date: Tue, 19 May 2026 11:12:37 -0400
Message-ID: <f7tse7n8mca.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289494-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ovn.org:email]
X-Rspamd-Queue-Id: D79F45816D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ilya Maximets <i.maximets@ovn.org> writes:

> ovs-vswitchd doesn't use OVS_VPORT_TYPE_GRE/VXLAN/GENEVE with upstream
> Linux kernel module since adding support for standard tunnel devices
> with COLLECT_METADATA back in 2017.  The code to use them is still
> present, but it is only activated as a fallback for old kernels, so
> not used in practice.  And it is marked for removal in the next OVS
> release this summer.  Modern way to use tunnels with OVS is to create
> standard tunnel ports with RTM_NEWLINK + COLLECT_METADATA and add them
> as OVS_VPORT_TYPE_NETDEV.
>
> Device reference management and the netlink options parsing for these
> legacy port types is complicated and was a CVE magnet recently.  Since
> there are no actual users for these port types for a very long time,
> let's just remove the support entirely.
>
>
> There are 3 parts to this set:
>
> 1. The first patch does the tunnel port removal, which is the primary
>    goal here.
>
> 2. Patches 2 and 3 remove extra infrastructure that is no longer in
>    use by anything inside the openvswitch module.  It may technically
>    be used by some out-of-tree module, but it is unlikely, so the
>    proposal here is to also just remove it.  Or we can consider
>    deprecation.  It's not really a user API, it's an API for modules.
>    Which can be considered as users, I guess.  Not sure.
>
> 3. Patches 4-6 remove functions from gre/vxlan/geneve modules that
>    were added for openvswitch in the past to support the tunnel types.
>    And openvswitch is the only in-tree consumer of these functions,
>    so we could remove them.  But they are also exported symbols, so
>    can in theory be used by some out-of-tree modules, though I doubt
>    that.  Not sure what the process should be here.  Removal seems
>    reasonable, but we may consider deprecation first.
>
> Thoughts?

I guess the only question is whether we would consider this some kind of
userspacce ABI break.  BUT, I'm not sure that it is.  After all, users
could still create some kind of tunnel ports (but they would no long get
to do INADDR_ANY type ports) and add them as regular netdev ports.  This
only changes how they would have to do this.  And as you note, there
aren't any known users for a long time.

I think it's nice to remove them since they create confusion for anyone
trying to debug what is going on.

> Ilya Maximets (6):
>   openvswitch: remove support for legacy tunnel types
>   openvswitch: vport: remove infrastructure for vport options
>   openvswitch: vport: remove infrastructure for separate modules
>   net: geneve: remove unused geneve_dev_create_fb
>   net: gre: remove unused gretap_fb_dev_create
>   net: vxlan: remove unused vxlan_dev_create
>
>  drivers/net/geneve.c                          |  48 -----
>  drivers/net/vxlan/vxlan_core.c                |  42 +----
>  include/net/geneve.h                          |   5 -
>  include/net/gre.h                             |   2 -
>  include/net/vxlan.h                           |   3 -
>  include/uapi/linux/openvswitch.h              |  31 +++-
>  net/ipv4/ip_gre.c                             |  47 -----
>  net/openvswitch/Kconfig                       |  35 ----
>  net/openvswitch/Makefile                      |   4 -
>  net/openvswitch/datapath.c                    |  22 +--
>  net/openvswitch/vport-geneve.c                | 143 ---------------
>  net/openvswitch/vport-gre.c                   | 106 -----------
>  net/openvswitch/vport-netdev.c                |  28 +--
>  net/openvswitch/vport-netdev.h                |   3 +-
>  net/openvswitch/vport-vxlan.c                 | 172 ------------------
>  net/openvswitch/vport.c                       |  76 +-------
>  net/openvswitch/vport.h                       |  23 +--
>  tools/testing/selftests/net/config            |   3 -
>  .../selftests/net/openvswitch/openvswitch.sh  |  37 ----
>  .../selftests/net/openvswitch/ovs-dpctl.py    |  93 +++-------
>  20 files changed, 59 insertions(+), 864 deletions(-)
>  delete mode 100644 net/openvswitch/vport-geneve.c
>  delete mode 100644 net/openvswitch/vport-gre.c
>  delete mode 100644 net/openvswitch/vport-vxlan.c


