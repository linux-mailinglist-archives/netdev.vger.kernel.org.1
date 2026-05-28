Return-Path: <netdev+bounces-292675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OECCNxozGGpwfggAu9opvQ
	(envelope-from <netdev+bounces-292675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:20:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 411485F1FE5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3374630ABEAB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA63C1995;
	Thu, 28 May 2026 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NY3SDf4a"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC913E7BDC
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970564; cv=none; b=oeUWgNtnm+Z73w+tM7vQDfyFghCutWHZMh1ghOb/bvT3eu3kteO9+G8IpAdk6aZX5IToFfSWnGkdPn6HAOTivJSD7NQYziYbi7GvhnVtRdMFEnOmSRSWi7z79pu7/Ol/EepLFiKK2WibJ56pzPwNGxFmjvqOrzluxwPR47rO2qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970564; c=relaxed/simple;
	bh=CamgIaj00t7/u1s8NBaExqKh1wc1jw2lnLYIAPBePjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MFqIZjuG9/YhIe66O8hdN4RAZWZIUNmEO06p4aGjBhrOPXJ8UzdSfMPgbJCgkD7olyXmBIesVUqmFZ3c0tHc0cWmxBHHLxqe+zS2xGWubTqS9IntLsILKapZc3tbfFpZo0iDoskdIl2nqZw/STXtbg3FZq9Vzq3wudM/Q7y3koY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NY3SDf4a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779970561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PaXUneZhU8CQ9NF6Ce2ctH/nbBN3Z+dK2XdtCVXD+cc=;
	b=NY3SDf4awyNdhPcH+u0HAgfnjXrc4dMyfn7GVgvwfH/0ZtqNn1k7Fy2ZR7/1ySaBVceZFX
	i92BOTqOu1Sf+X3N5ZkDgVt1UTY0pcYZ8j/AcP5oo25ompETIYbMMhYbWyr4FZc/7tc497
	AmvKrlYqBnrQDDc3h15UHC+o2LLF7ig=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-TiH_A2_uNYeWVzpTg7Yksg-1; Thu,
 28 May 2026 08:15:58 -0400
X-MC-Unique: TiH_A2_uNYeWVzpTg7Yksg-1
X-Mimecast-MFC-AGG-ID: TiH_A2_uNYeWVzpTg7Yksg_1779970556
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CD3C1956094;
	Thu, 28 May 2026 12:15:56 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.73])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 613901771;
	Thu, 28 May 2026 12:15:54 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  echaudro@redhat.com,
  edumazet@google.com,  horms@kernel.org,  i.maximets@ovn.org,
  kuba@kernel.org,  pabeni@redhat.com,  shuah@kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3] selftests: openvswitch: add dec_ttl action
 support and test
In-Reply-To: <20260527080601.615607-1-houminxi@gmail.com> (Minxi Hou's message
	of "Wed, 27 May 2026 16:06:01 +0800")
References: <20260527080601.615607-1-houminxi@gmail.com>
Date: Thu, 28 May 2026 08:15:52 -0400
Message-ID: <f7ttsrrpw5j.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292675-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ovs-dpctl.py:url]
X-Rspamd-Queue-Id: 411485F1FE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Minxi Hou <houminxi@gmail.com> writes:

> Add dec_ttl action support to the OVS kernel datapath selftest
> framework:
>
>   - Add dec_ttl nested NLA class to ovs-dpctl.py with proper
>     OVS_DEC_TTL_ATTR_ACTION sub-attribute handling
>   - Add parse support for dec_ttl(le_1(<inner_actions>)) action
>     string, consistent with the odp-util.c format where le_1()
>     holds the actions taken when TTL reaches 1
>   - Add dpstr output formatting for dec_ttl actions
>   - Add test_dec_ttl() to openvswitch.sh that verifies:
>     * Normal TTL packets are forwarded after decrement
>     * TTL=1 packets are dropped (TTL expiry)
>     * Graceful skip via ksft_skip if kernel lacks dec_ttl support
>
> The dec_ttl class uses late-binding type resolution to reference
> ovsactions for its inner action list, avoiding circular references
> at class definition time.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

Thanks Minxi - this case will be very helpful.

Reviewed-by: Aaron Conole <aconole@redhat.com>


