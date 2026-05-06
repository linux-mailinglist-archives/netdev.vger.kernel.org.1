Return-Path: <netdev+bounces-284924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECN9Dulg+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:40:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0384DD6EE
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98ED130A105D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6B19B5A3;
	Wed,  6 May 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxkGciZB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E044105E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081774; cv=none; b=UgWjTroFCQPD/IopnIsrzfJxJ3vYGJOQLv3oSODRp/MqsoK0vKsgXMS0N7wgLqhDkUDK7lsS6K7OMRTn1zvWwMUH2BxIO+RYRIq0Y6JSrZh/16kPH/ETnqd34AENSbjWfLJ1bvDIVH/ZAUag9gfOeMjAlDCXsOEgZSIuuWZ7X34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081774; c=relaxed/simple;
	bh=CwP7g+L7tmTM1gOICXchU65OK9ZzlG0f6YkTuUwv3XI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qyujKDtQmzLRWy8KFlcastb2ejHpYyu1o5Oy2czfLslRlma61mevZNABylX1p+01V7U5q+QxX3ckgRgbedJkXz7SA1lnfjKUIUmPkD1IugHYZFdVWBamYEhkNkAcaKdJWJm1TWyX7pnRG/6NzlIyfol+cjPmwIebVZyoW6yy0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxkGciZB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778081770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0UoDCQban7BwMooeGuUu7b8/86Tvw53i5NmMB+ICeI=;
	b=dxkGciZBFOLkdoYszCtG7/yCO2sznZrtI8x9u4P2AVeZSaPAlSyWiBzlh3NjTNcmr46WgR
	FL8Av7hF8jLSBMsUjVRXv6pWKTF0jkgZT2cTt/0SSEmK8LjfcX8FqVkkLhDgMTJOzPta0u
	Hp5TbO1suAbwll8fVyxsTgNeGdoUHh0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-Oj-mcXI6Mm21pizt2v4p5w-1; Wed,
 06 May 2026 11:36:06 -0400
X-MC-Unique: Oj-mcXI6Mm21pizt2v4p5w-1
X-Mimecast-MFC-AGG-ID: Oj-mcXI6Mm21pizt2v4p5w_1778081765
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3E9419560B4;
	Wed,  6 May 2026 15:36:04 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32CC318001CE;
	Wed,  6 May 2026 15:36:02 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] selftests: openvswitch: add pop_vlan test
In-Reply-To: <20260505124957.1239812-3-houminxi@gmail.com> (Minxi Hou's
	message of "Tue, 5 May 2026 20:49:57 +0800")
References: <20260505124957.1239812-1-houminxi@gmail.com>
	<20260505124957.1239812-3-houminxi@gmail.com>
Date: Wed, 06 May 2026 11:36:00 -0400
Message-ID: <f7tjytgtusf.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: CD0384DD6EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284924-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
> Rely on ping success/failure for verification =E2=80=94 no tcpdump or
> pcap files needed.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

Thanks for adding this.  I'm still a little unclear about the explicit
modprobe for 8021q.  Is it really needed?  I thought the request to add
a vlan tagged interface should auto-load that module (unless it is
blacklisted or something).  I guess this is an attempt to short-circuit
the skip, but maybe it would be better to configure an interface and if
that fails, then either fail the test or skip the test.


