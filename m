Return-Path: <netdev+bounces-306470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mJbfCQa6UGpM4AIAu9opvQ
	(envelope-from <netdev+bounces-306470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:23:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ACB738FE6
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:23:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=fd7FmsaO;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306470-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306470-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2834B309ED07
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4013D3334;
	Fri, 10 Jul 2026 09:04:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF543C5823
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674246; cv=none; b=aaBcIeu7GaJAnBgrRQoAhlXm//C+/RX9pOIPwDYayxHyc98CkWI2/KKOIAoAcg18nRALlFNCQUSLiTsw3CS3njQjJovMyEISEsa4diLqWEuQhiICYj4V1xN8EBsCAAbVgYqj+FyrbXZUjRg554ca4Q28e0l/wYSrxsemTt5GApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674246; c=relaxed/simple;
	bh=afyM7o3bBX28sWsSBnBtE5BzAaBnhYZf7X5xp2kQmPQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P395yd9VPxf7TVAfEYRFIvhYp7+ou9DZemsh4Aunq1TGcD4vKjm2kXoHlyBoWO98eRjeDhkuSBQxltEhD+ev/9A+CQzhean+VFx8PXnt+3Rw7JhvgYPmA+HlzEZvm+aO3nO9HJxaVIqBj/FpXA1ObUr8SqIeJdraTkj732jq8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fd7FmsaO; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 217E1206D0;
	Fri, 10 Jul 2026 11:03:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2X4dpc2G8Gcw; Fri, 10 Jul 2026 11:03:54 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6ACA6205E5;
	Fri, 10 Jul 2026 11:03:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6ACA6205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674234;
	bh=dcxZK3EEuN+ibtZF0LCKRGhcpZzTNhr7iwcLYQyfniA=;
	h=From:To:CC:Subject:Date:From;
	b=fd7FmsaO18fOHhTSPOdzTnRdIMW5b0WWWtRMM6BkG9pMbOV0Hv5paXXMOt0KZ9a8X
	 0ZWz8dHbIP8S5zgUc5ixu3KfsJrgJ4avYFF+W94Mw1qskFWHm9hz96EyU73agy5LAs
	 xYkzJOt/aTazabBH7MzvnXkTEac8XhWjngAZHDL/3jGt0rOfjoKcCrj6cOnm0sTKPm
	 IW9NdmGObWaUkKt6/5MiJLKC4WFC2cHJzVF7o/Za/kMJvWloL4Fn87Euc5Oso030Op
	 L/yEUMCu9Oti9FPxgQZqVEmu0KqocOHi7RlTjQCA3MLUa0E0BZ/8wNjDd8ngaQWGDx
	 qdLmGc7vLsjrw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:03:53 +0200
Received: (nullmailer pid 343832 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/10] pull request (net): ipsec 2026-07-10
Date: Fri, 10 Jul 2026 11:03:13 +0200
Message-ID: <20260710090349.343389-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306470-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:from_mime,secunet.com:dkim,secunet.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dst.dev:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97ACB738FE6

1) xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
   Return -EINPROGRESS from xfrm_output_one when validate_xmit_xfrm
   requeues the packet asynchronously, so the caller doesn't treat it
   as a real error and free the skb.

2) xfrm: fix stale skb->prev after async crypto steals a GSO segment
   Re-derive skb->prev from the fragment list after async crypto splits
   a GSO skb, keeping the linked-list pointers validi.

3) xfrm: nat_keepalive: avoid double free on send error
   Hold a state ref while the nat_keepalive timer is active and drop the
   timer before freeing the state, preventing a re-entered free on send
   error.

4) xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
   Null the skb dst cache before freeing the policy so a later skb
   destructor doesn't double-free it.

5) xfrm: cache the offload ifindex for netlink dumps
   Cache the device ifindex at state-add time and use it for netlink
   dumps instead of dereferencing dst->dev, which may have changed by
   the time the dump runs.

6) xfrm: reject optional IPTFS templates in outbound policies
   Reject outbound policies with an optional IPTFS template,
   IPTFS must always be used if configured.

7) xfrm: clear mode callbacks after failed mode setup
   Clear the mode->init_flags and init_state callbacks on the error path
   after xfrm_init_mode fails, so a partially-initialised mode isn't
   reused in xfrm_state_construct.

8) xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()
   Propagate SKBFL_SHARED_FRAG from the original skb to fragments
   allocated by iptfs_skb_add_frags, keeping shared-fragment accounting
   correct after IPTFS reassembly.

9) xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
   Clear dst->dev on the error path of xfrm6_fill_dst() so the caller
   doesn't release the netdev reference twice via dst_release.

10) xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert
    Preallocate all inexact hash bins before existing entries are
    reinserted during xfrm_hash_rebuild, so reinsertion always hits an
    existing bin.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 805185b7c7a1069e407b6f7b3bc98e44d415f484:

  Merge tag 'net-7.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-06-25 12:25:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-07-10

for you to fetch changes up to f38f8cce2f7e79775b3db7e8a5eacda04ac908e4:

  xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert (2026-07-06 08:30:02 +0200)

----------------------------------------------------------------
ipsec-2026-07-10

----------------------------------------------------------------
Antony Antony (1):
      xfrm: reject optional IPTFS templates in outbound policies

Cen Zhang (2):
      xfrm: cache the offload ifindex for netlink dumps
      xfrm: clear mode callbacks after failed mode setup

Chen YanJun (1):
      xfrm: iptfs: propagate SKBFL_SHARED_FRAG in iptfs_skb_add_frags()

Petr Wozniak (2):
      xfrm: propagate -EINPROGRESS from validate_xmit_xfrm()
      xfrm: fix stale skb->prev after async crypto steals a GSO segment

Qianyu Luo (1):
      xfrm: nat_keepalive: avoid double free on send error

Xiang Mei (Microsoft) (3):
      xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
      xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
      xfrm: policy: preallocate inexact bins before xfrm_hash_rebuild reinsert

 include/net/xfrm.h            |  2 ++
 net/core/dev.c                | 10 ++++++++--
 net/ipv6/xfrm6_policy.c       |  1 +
 net/xfrm/xfrm_device.c        | 13 +++++++++++--
 net/xfrm/xfrm_iptfs.c         |  1 +
 net/xfrm/xfrm_nat_keepalive.c | 15 +++++++++------
 net/xfrm/xfrm_policy.c        |  4 ++--
 net/xfrm/xfrm_state.c         | 12 +++++++++---
 net/xfrm/xfrm_user.c          | 41 ++++++++++++++++++++++++++++++-----------
 9 files changed, 73 insertions(+), 26 deletions(-)

