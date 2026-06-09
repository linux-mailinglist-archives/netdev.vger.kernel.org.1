Return-Path: <netdev+bounces-297063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +iLdD9MfKGpx+QIAu9opvQ
	(envelope-from <netdev+bounces-297063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:14:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F11660E47
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=ht4sr0sS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297063-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297063-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A68D1305509F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D50731E832;
	Tue,  9 Jun 2026 14:05:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBD317153;
	Tue,  9 Jun 2026 14:05:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013954; cv=none; b=llTzVGvyHco+48k/YFGpjsKd7JivevrGjQ1d1fiifoqDCBV73gCwB8p22G0KcGHLefYcIPG2/F26TGkewy3WISFDHwOMzcBDnpJX+U+f1DPvI2MKW0f6hnlxM6vsyagVoynia8u/RU3Pesax309O5i+/HFj6NBMhsj67gsdQyQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013954; c=relaxed/simple;
	bh=p9ceCAe/cxupmbFwPLJqZ8wK4kbl3qLke/+hH+iki1w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nidIgvvRfQFawUUURK6g1U+erGHhsBXwloQ95Xf/BW7+AHygH1KDKoIOvc93ag9lVZdCWy9QaAN2ZPOgs+bpMA+yKPR/gi0P+0yhwvSKzD2x1rx9E7cGF+PeQzHa9kRjxtRFRxTI2LooPMz7XRbUirnxeS9pFYGw8QKwpfEHWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ht4sr0sS; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 259C9205E5;
	Tue,  9 Jun 2026 16:05:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t2WAbfeIgnUF; Tue,  9 Jun 2026 16:05:48 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0C0F32019D;
	Tue,  9 Jun 2026 16:05:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0C0F32019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781013948;
	bh=2Y79YA406WVMDOn1t2thR2Tgqj/FyeSsaBX5XBihyro=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ht4sr0sSSO743VMrOIEVM6+vIjACjb1vnzhB93MdHkaVvH66miSfcJFRulDZZUDVU
	 URraHMl98PCWoXWIErrA59FmTVwRqJ4+sHA+UzJzz/myr9tOH4mrnu6LKOrg3BPkdK
	 xYiFsYcxXs4rbw2gg4QIelOZp3o3E70pmhoc91cJ5OgVqE2N9csO2eWTyUMdVdL/y9
	 KmiZJxzDJwOT992eAK1PzEzxRg5sx9hoAxoVfDKvRqceSPgtwuBl8sO3DFZyZwO7V2
	 ZbkvMNruXanpzu9156Uz85qhpxviteLTMN+5rc+J5QeEspSrN3F+eP3OrapiLGzxDp
	 0Lbg4D9OCv9NA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 16:05:46 +0200
Received: (nullmailer pid 1306013 invoked by uid 1000);
	Tue, 09 Jun 2026 14:05:45 -0000
Date: Tue, 9 Jun 2026 16:05:45 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, David Ahern <dsahern@kernel.org>, Masahide NAKAMURA
	<nakam@linux-ipv6.org>, Paul Moore <paul@paul-moore.com>, Stephen Smalley
	<stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Chiachang Wang <chiachangwang@google.com>, Yan
 Yan <evitayan@google.com>, <devel@linux-ipsec.org>
Subject: Re: [PATCH ipsec-next v9 00/16] xfrm: XFRM_MSG_MIGRATE_STATE new
 netlink message
Message-ID: <aigducMLaXYKn6sa@secunet.com>
References: <migrate-state-v9-0-ad9947e4ae74@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <migrate-state-v9-0-ad9947e4ae74@secunet.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297063-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:antony.antony@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:nakam@linux-ipv6.org,m:paul@paul-moore.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-doc@vger.kernel.org,m:chiachangwang@google.com,m:evitayan@google.com,m:devel@linux-ipsec.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,linux-ipv6.org,paul-moore.com,gmail.com,lwn.net,linuxfoundation.org,queasysnail.net,vger.kernel.org,linux-ipsec.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:dkim,secunet.com:mid,secunet.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6F11660E47

On Tue, May 26, 2026 at 09:05:38PM +0200, Antony Antony wrote:
> The current XFRM_MSG_MIGRATE interface is tightly coupled to policy and
> SA migration, and it lacks the information required to reliably migrate
> individual SAs. This makes it unsuitable for IKEv2 deployments,
> dual-stack setups (IPv4/IPv6), and scenarios where policies are managed
> externally (e.g., by daemons other than the IKE daemon).
> 
> Mandatory SA selector list
> The current API requires a non-empty SA selector list, which does not
> reflect the IKEv2 use case.
> A single Child SA may correspond to multiple policies,
> and SA discovery already occurs via address and reqid matching. With
> dual-stack Child SAs this leads to excessive churn: the current method
> would have to be called up to six times (in/out/fwd × v4/v6) on SA,
> while the new method only requires two calls.
> 
> Selectors lack SPI (and marks)
> XFRM_MSG_MIGRATE cannot uniquely identify an SA when multiple SAs share
> the same policies (per-CPU SAs, SELinux label-based SAs, etc.). Without
> the SPI, the kernel may update the wrong SA instance.
> 
> Reqid cannot be changed
> Some implementations allocate reqids based on traffic selectors. In
> host-to-host or selector-changing scenarios, the reqid must change,
> which the current API cannot express.
> 
> Because strongSwan and other implementations manage policies
> independently of the kernel, an interface that updates only a specific
> SA - with complete and unambiguous identification - is required.
> 
> SA Selector, x->sel, can't be changed, especially Transport mode.
> 
> XFRM_MSG_MIGRATE_STATE provides that interface. It supports migration
> of a single SA via xfrm_usersa_id (including SPI) and we fix
> encap removal in this patch set, reqid updates, address changes,
> and other SA-specific parameters. It avoids the structural limitations
> of XFRM_MSG_MIGRATE and provides a simpler, extensible mechanism for
> precise per-SA migration without involving policies.
> This method also allows migtrating SA selectors typically used with
> host-to-host in Transport mode.
> 
> New migration steps: first install block policy, remove the old policy,
> call XFRM_MSG_MIGRATE_STATE for each state, then re-install the
> policies and remove the block policy.
> 
> If the target SA tuple (daddr, SPI, proto, family) is already
> occupied, the operation returns -EEXIST. In this case the original
> SA is not preserved. Userspace must handle -EEXIST by
> re-establishing the SA at the IKE level and manage policies.
> 
> ---
> v8->v9: address v8 review Sabrina and Steffen
> 	- split const xuo cleanup
> 	- input validation
> 
> Link to v8: https://lore.kernel.org/all/migrate-state-v8-0-4578fb016965@secunet.com/
> v7->v8: - removed the unknown-flags validation block
> 
> Link to v7: https://patch.msgid.link/migrate-state-v7-14-44eb2440b91c@secunet.com
> v6->v7: - add SA selectoor migration
> 	- fixes to commit messages
> 	- white space removal
> 
> Link to v6: https://lore.kernel.org/r/migrate-state-v6-0-9df9764ddb9e@secunet.com
> v5->v6: - add mark to look up SA.
> 	- restrict netlink attributes in new method
> 	- address review feedback from Sabrina
> 	- add new patch to fix existing inter-family address comparison
> 	- add extack xfrm_state_init()
> 	- Feedback from Yan : omit-to-inherit add migrating marks
> 	- Drop missing __rcu annotation on nlsk, Sabrina has a better patch
> 
> Link to v5: https://lore.kernel.org/all/cover.1769509130.git.antony.antony@secunet.com/
> v4->v5: add synchronize after migrate and delete it inside a lock
> 	- split xfrm_state_migrate into create and install functions
> 
> Link to v4: https://lore.kernel.org/all/cover.1768811736.git.antony.antony@secunet.com/
> v3->v4: add patch to fix pre-existing missing __rcu annotation on nlsk
> 
> v2->v3: - fix commit message formatting
> 
> Link to v2: https://lore.kernel.org/all/cover.1768462955.git.antony.antony@secunet.com/
> 
> Lint to v1: https://lore.kernel.org/all/cover.1767964254.git.antony@moon.secunet.de/
> v1->v2: dropped 6/6. That check is already there where the func is called
> 	- merged patch 4/6 and 5/6, to fix use uninitialized value
> 	- fix commit messages
> 
> ---
> Antony Antony (16):
>       xfrm: remove redundant assignments
>       xfrm: add extack to xfrm_init_state
>       xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
>       xfrm: fix NAT-related field inheritance in SA migration
>       xfrm: rename reqid in xfrm_migrate
>       xfrm: split xfrm_state_migrate into create and install functions
>       xfrm: check family before comparing addresses in migrate
>       xfrm: add state synchronization after migration
>       xfrm: add error messages to state migration
>       xfrm: move encap and xuo into struct xfrm_migrate
>       xfrm: refactor XFRMA_MTIMER_THRESH validation into a helper
>       xfrm: extract address family and selector validation helpers
>       xfrm: make xfrm_dev_state_add xuo parameter const
>       xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
>       xfrm: restrict netlink attributes for XFRM_MSG_MIGRATE_STATE
>       xfrm: add documentation for XFRM_MSG_MIGRATE_STATE

Series appled, thanks a lot for your effort Antony!

