Return-Path: <netdev+bounces-288198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPgSMhHDBmpdngIAu9opvQ
	(envelope-from <netdev+bounces-288198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:54:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6631054A2A3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AAEE3032D1B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9633D47D4;
	Fri, 15 May 2026 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qt7e4Ztj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D1E3CBE88
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828031; cv=none; b=ZnaikogoW2SgBTetz4EFcx52bAl6df0xDEQspcxL7yDHnl5gtMRl8j3qAgPoM3m+mMK91QEWk4IDps658G3ZKHd765NV91OMJoOCK27OauA4cpAPmyVdOunZVtnTeWZ8BSxLxQMni1gXxPVqvlMks2h627M8QCR2Q1dujkgdpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828031; c=relaxed/simple;
	bh=Sv4xPSqe/Lw3o9sgsUySZxvwXDH5uG9frkm2sFB3IiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h8p9VzTD6PiIkKkEBE6kqoy6/SfrePfsk0c99u8XaFgx42ceUUxVm33MKEYXsuRsmuh35VYHZvF/4RKs7w97LcpVSb991RdjNghSsBp/uisYcY7SF+bEoqqeyhMXglt56gNLc3bHEBG6OwXigO3nqx6KpqTnmqWKdqY9Th9xqKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qt7e4Ztj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778828028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZAeat6OEtCU2HoUDGx/9XhjLgZNjEvUYNHT3F6GC4k=;
	b=Qt7e4ZtjPAjTQngG3H2E6MGcR2mYOsL7jAHY9YfTyy3AYCpaFUTTUtPRm67aMzGJOEKGxE
	jgiYiif6FJUnv0w/fxByhCgLPRdaErRaohHm3aQNMr2OpOqzQ4bkpqCiDVUNNNVe3Pnh/X
	Pg4RMLPlA/WEJHXJlc+hoM4rzFOTq+Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-QnA3Wtb7P5ucKcz0EIOB7A-1; Fri,
 15 May 2026 02:53:45 -0400
X-MC-Unique: QnA3Wtb7P5ucKcz0EIOB7A-1
X-Mimecast-MFC-AGG-ID: QnA3Wtb7P5ucKcz0EIOB7A_1778828023
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D8F31956054;
	Fri, 15 May 2026 06:53:43 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.221])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46C6F19560A2;
	Fri, 15 May 2026 06:53:38 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,
  echaudro@redhat.com,  i.maximets@ovn.org,  i.maximets@redhat.com,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org
Subject: Re: [PATCH net-next 0/5] selftests: openvswitch: pylint cleanup for
 ovs-dpctl.py
In-Reply-To: <20260513121240.2590767-1-houminxi@gmail.com> (Minxi Hou's
	message of "Wed, 13 May 2026 20:12:35 +0800")
References: <20260513121240.2590767-1-houminxi@gmail.com>
Date: Fri, 15 May 2026 02:53:35 -0400
Message-ID: <f7tzf21noy8.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 6631054A2A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288198-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Minxi Hou <houminxi@gmail.com> writes:

> This series cleans up all pylint warnings in ovs-dpctl.py,
> bringing the score from 7.62/10 to 10.00/10.
>
> This series applies on top of:
>   [PATCH net-next v10 1/2] selftests: openvswitch: add vlan() and
>   encap() flow string parsing
>   https://lore.kernel.org/netdev/20260512070841.1183581-2-houminxi@gmail.com/
>
> Patch 1 converts 86 %-format strings to f-strings.
> Patch 2 fixes misc warnings (unused import, bare except, unused
> variables, redundant expressions).
> Patch 3 renames classes to PascalCase and variables to snake_case.
> Patch 4 adds one-line docstrings to all definitions.
> Patch 5 suppresses complexity warnings from pyroute2 constraints.
>
> Tested with vng on x86_64, all OVS selftests pass.
>
> Minxi Hou (5):
>   selftests: openvswitch: convert %-formatting to f-strings
>   selftests: openvswitch: fix misc pylint warnings in ovs-dpctl.py
>   selftests: openvswitch: rename classes and variables in ovs-dpctl.py
>   selftests: openvswitch: add missing docstrings in ovs-dpctl.py
>   selftests: openvswitch: suppress pylint complexity warnings
>
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 794 ++++++++++--------
>  1 file changed, 428 insertions(+), 366 deletions(-)

Thinking about this series, it might be better to go a bit further and
just drop the pyroute2 in favor of using ynl to generate the netlink
encode/decode.  The value that ovs-dpctl.py brings is the ability to
interoperate with the ovs-vswitchd odp encoding.  That we are using
pyroute2 to do the actual 'wire' format of netlink is incidental.

Some of the work would still be needed (I think some of the f-string
adjustments) but that would allow trimming a good chunk of the code and
let us just rely on the in-tree ynl rather than pyroute2 dependency.

WDYT?  Ilya and I can work with you offline if you are interested in
pursuing this approach.  I think it should make the overall code much
better to work with, too.


