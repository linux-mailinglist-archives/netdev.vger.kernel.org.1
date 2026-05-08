Return-Path: <netdev+bounces-285867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH0IETT1/Wn5lAAAu9opvQ
	(envelope-from <netdev+bounces-285867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:37:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED14F7DAF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC14B3017BC0
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553F3F2117;
	Fri,  8 May 2026 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuSv6TJj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E1E3ED5A3
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251055; cv=none; b=Hg4myjTBeyU9DdbuAaCX/9FFKeMRtRdpC4wwn57XBHjI7pNdQiyDxTROycJ5BqcgkRn6dPTPDRCBWxnZ3VFEDKlaPoa9Rhyg3Qo3tBndGHwYgylPgEkHQoWoGXJtX2zwN89To+pZnpGDBj8+oYkN7ff5ihNJZHFNkSUyoj87aSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251055; c=relaxed/simple;
	bh=Mbc6RyQAJ135g/HwpgFncUzGBqFAua5oLCLfqRuGKsw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ndZ3V1k1fsAkrpmAcUOL7QImzUaFg8CUwzvean0Gcknky8uRM/oyfiQDsW8hdD2ShBmTuK/k7dpnABGbVc7Zto5yOveDT2YNLxRDZ8AksIztXZ2yWLAoOe3Z+89YHnHVyc0kcy/+jRtg1qbXaz00mLWbxeBzXJiHGJvxMwWALiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuSv6TJj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778251052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yVkKNgHxig7M46X9NYBxZb338TZpmf1fuqe4XUbcFJw=;
	b=iuSv6TJjvcfTnWpyY3ZTKEHolkkMmanvOzsjumx7hvIy/fDrr3PSohgLWbY4dqBy4yybD2
	uY8vZoPJ5H9kKwCIKO11RTKIZc3QLd0BZgliu3XDLHaco7cl8Ydifg9oKWgRhUaWLTmFZp
	frmierHy5op7Jmc+2JeNLgzlhqUhBKo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-jBZh-RDlMV-Cj9rTjJjAVw-1; Fri,
 08 May 2026 10:37:27 -0400
X-MC-Unique: jBZh-RDlMV-Cj9rTjJjAVw-1
X-Mimecast-MFC-AGG-ID: jBZh-RDlMV-Cj9rTjJjAVw_1778251046
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF8711956094;
	Fri,  8 May 2026 14:37:25 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DB411803A8E;
	Fri,  8 May 2026 14:37:23 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/2] selftests: openvswitch: add pop_vlan test
In-Reply-To: <20260508134308.2857449-3-houminxi@gmail.com> (Minxi Hou's
	message of "Fri, 8 May 2026 21:43:08 +0800")
References: <20260508134308.2857449-1-houminxi@gmail.com>
	<20260508134308.2857449-3-houminxi@gmail.com>
Date: Fri, 08 May 2026 10:37:21 -0400
Message-ID: <f7tzf2aq866.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: C9ED14F7DAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285867-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Minxi Hou <houminxi@gmail.com> writes:

> Add test_pop_vlan() to verify OVS kernel datapath pop_vlan action
> correctly strips 802.1Q VLAN tags from frames.
>
> Test structure:
> - Baseline: untagged forwarding validates basic connectivity.
> - Negative: forward without pop_vlan, tagged frame is invisible
>   to ns2 (no VLAN sub-interface), ping fails.
> - Positive: pop_vlan strips tag on forward path, push_vlan
>   restores tag on return path, ping succeeds.
>
> Use static ARP entries to avoid VLAN-tagged ARP complexity.
> Rely on ping success/failure for verification -- no tcpdump or
> pcap files needed.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

There is an issue applying to net-next, so this will need to be rebased
on net-next - likely a conflict from 05416ada37aa4 ("selftests:
openvswitch: add tests for tunnel vport refcounting").  Please wait 24h
before reposting and you can include my review tags in 1/2 and 2/2

Reviewed-by: Aaron Conole <aconole@redhat.com>


