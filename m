Return-Path: <netdev+bounces-297045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ST6UFmMOKGrR9AIAu9opvQ
	(envelope-from <netdev+bounces-297045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:00:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B4E660537
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 15:00:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=VJx9IlZr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297045-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297045-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35E3D304F9BC
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA54192F3;
	Tue,  9 Jun 2026 12:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1F19CC0C
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 12:54:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009699; cv=none; b=ajAgRYbu2TfqIC0xDIeJU7DbY6a84wbqD2vS6xR+hYau4QWRxhmyL5EsK+ucMU8qS+hRkCSFLBMx/WqZliaGM58fP8lVxgMr8vHX8m07kzfnp9fqDO48mF3TGFpAEnk9C5P3da60j2jIkmTPY9irumNQJ+2cb9kKS+OmKnUTEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009699; c=relaxed/simple;
	bh=FbmqELwkZE15Mwc2UsyKsCGlGrQeI7HFMN12yDJtqbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rbtOm40Q3HAV7JDcJQnSLkW6wlCBXWZFzBg7WjlSrO7IOjgZCZqp7BGmGfJ6gChtQEs4PnRYFXWMOGpKJx37ZbvzHCuRcvAchBraHsh9InQ7pUCRGwScyAjZOEjGApgv+y53RPRj88H+Ewcx6bnrFeHJfH8jh376oDFE7bW4pWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJx9IlZr; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781009694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jSwQh1BOvnch4QBcgj6oKXjw4gnvSRB144OhFDs5fPs=;
	b=VJx9IlZrmD2TVGZYr/nv5pn3UfU4tcs6TAZ9G1BQ6FJ2mCK1jMywHQchLnnig9drpKYYAK
	cDA97Km852FgEBnOuL9bT8xfemjQAYcVJ1f82wW+sbRqNBbkChj0eQYSTffAVzhurftPyY
	ytL8lGiAX6RNx2wGsoWho9Sp+cGVKBg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-6IMNcjKDMfaDbJohaQ0mjw-1; Tue,
 09 Jun 2026 08:54:50 -0400
X-MC-Unique: 6IMNcjKDMfaDbJohaQ0mjw-1
X-Mimecast-MFC-AGG-ID: 6IMNcjKDMfaDbJohaQ0mjw_1781009688
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A4941955F25;
	Tue,  9 Jun 2026 12:54:48 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CE1119541B0;
	Tue,  9 Jun 2026 12:54:46 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Minxi Hou <houminxi@gmail.com>,  netdev@vger.kernel.org,
  davem@davemloft.net,  echaudro@redhat.com,  edumazet@google.com,
  horms@kernel.org,  i.maximets@ovn.org,  kuba@kernel.org,
  shuah@kernel.org,  dev@openvswitch.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/openvswitch: guard command substitutions
 against empty output
In-Reply-To: <c530d07f-5841-4bfb-b296-b47fc0ce0614@redhat.com> (Paolo Abeni's
	message of "Tue, 9 Jun 2026 12:56:17 +0200")
References: <20260601115307.1411211-1-houminxi@gmail.com>
	<c530d07f-5841-4bfb-b296-b47fc0ce0614@redhat.com>
Date: Tue, 09 Jun 2026 08:54:45 -0400
Message-ID: <f7tbjdjg9gq.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297045-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,redhat.com,google.com,kernel.org,ovn.org,openvswitch.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:echaudro@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:i.maximets@ovn.org,m:kuba@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22B4E660537

Paolo Abeni <pabeni@redhat.com> writes:

> On 6/1/26 1:53 PM, Minxi Hou wrote:
>> When ip-link output is unavailable, when the upcall daemon log has not
>> been written yet, or when pahole does not know the OVS drop subsystem
>> ID, the affected command substitutions silently produce empty strings.
>> The caller then passes empty sha= or pid= arguments to ovs_add_flow,
>> or matches against wrong drop reason codes, all without a diagnostic.
>> 
>> Add [ -z ] guards immediately after each assignment. For test_arp_ping,
>> also align the MAC extraction to use awk '/link\/ether/' as in
>> test_pop_vlan. The drop_reason guard returns ksft_skip because an
>> absent subsystem ID is an environment issue, not a test failure.
>> 
>> Signed-off-by: Minxi Hou <houminxi@gmail.com>
>
> IMHO this is net-next material.
>
> @Aaron, @Eelco, @Ilya: WDYT?

Agreed.

> /P


