Return-Path: <netdev+bounces-266639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DtaNcBksWnsugIAu9opvQ
	(envelope-from <netdev+bounces-266639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:49:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E07C2263D90
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20BE13006D44
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2F7282F21;
	Wed, 11 Mar 2026 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/iAbvT8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34A253F05
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233340; cv=none; b=nxM+nh530MiEI1Lna7ve/YrLziHQPzQZbr48a2dNdwlmDVysHpMiywH7kFfhC4QvNaeQuU5zukSrO5WagpCymuTi2Iai1cSWISt2TJugFs1D5BRrl2cmxob/zr8Z+PV+h7cYKg6WOuJ3PLki3sUZ7EBqIGtojD7TaJ93RMEymV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233340; c=relaxed/simple;
	bh=xcZpsPLRj4+t91HOPhvrSX6TCcutsqBZTrGwFvx+E0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zukm9rBZhBRHkghLbrWMDlJ8MeouTWvFCix3RR0zZUhF5QVsf1FNsa32eso54df7LRBWf1nrVRrhvINIueCC61Wn/xHi9mOfbqHrSCPyuQhY/2fTpAQjD7cACsRglaBOBt/mHAlk1eyUJrMwsQripFfUQmaI+z4Nhm3GJRd0V+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/iAbvT8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773233337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8EogtX9KqkwlCTtPWzX2zysM9V7W8qju+U/TiK9m24=;
	b=B/iAbvT8l1afwDj+npGTrnV1OQLynDSKdDnV4zz564lmjtVrl6mPEk6bPyfwxGRrG/cdXg
	nKIsf2tg5nDguVtUM2FNoSHQE7w4RGapaSpYRIEN0rV87v3VE/8g8Aeutr2HmJ4oGHcdl7
	JK3r/UNYwCcyGeIwk4gZgq6V3iTFolc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-eeoS19fpM2eiU-KewMbZQw-1; Wed,
 11 Mar 2026 08:48:53 -0400
X-MC-Unique: eeoS19fpM2eiU-KewMbZQw-1
X-Mimecast-MFC-AGG-ID: eeoS19fpM2eiU-KewMbZQw_1773233331
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A86119560A3;
	Wed, 11 Mar 2026 12:48:51 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.168])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBCD13000223;
	Wed, 11 Mar 2026 12:48:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Ilya Maximets <imaximet@redhat.com>,  Eelco Chaudron
 <echaudro@redhat.com>,  Stefano Brivio <sbrivio@redhat.com>,
  netdev@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  dev@openvswitch.org
Subject: Re: [PATCH net v4 1/5] selftests: net: make ovs-dpctl.py fail when
 pyroute2 is unsupported
In-Reply-To: <20260309152013.565216-2-aleksey.oladko@virtuozzo.com> (Aleksei
	Oladko's message of "Mon, 9 Mar 2026 15:20:09 +0000")
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
	<20260309152013.565216-2-aleksey.oladko@virtuozzo.com>
Date: Wed, 11 Mar 2026 08:48:47 -0400
Message-ID: <f7t7brir0pc.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: E07C2263D90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,pmtu.sh:url,ovs-dpctl.py:url]
X-Rspamd-Action: no action

Aleksei Oladko <aleksey.oladko@virtuozzo.com> writes:

> The pmtu.sh kselftest configures OVS using ovs-dpctl.py and falls back
> to ovs-vsctl only when ovs-dpctl.py fails. However, ovs-dpctl.py exits
> with a success status when the installed pyroute2 package version is
> lower than 0.6, even though the OVS datapath is not configured.
>
> As a result, pmtu.sh assumes that the setup was successful and
> continues running the test, which later fails due to the missing
> OVS configuration.
>
> Fix the exit code handling in ovs-dpctl.py so that pmtu.sh can detect
> that the setup did not complete successfully and fall back to
> ovs-vsctl.
>
> Fixes: 962e8a01eab9 ("selftests: openvswitch: Add version check for pyroute2")
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
> ---

Still LGTM (but this is already in net-next as 0bcac7b11262 so does it
need to be included still?  Actually I think it should be in 'net')

(including tag just in case)
Reviewed-by: Aaron Conole <aconole@redhat.com>


