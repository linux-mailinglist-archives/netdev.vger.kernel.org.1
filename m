Return-Path: <netdev+bounces-285866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLGLDs/1/Wn5lAAAu9opvQ
	(envelope-from <netdev+bounces-285866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:40:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA684F7E7C
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B00C3097794
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383B3EDADB;
	Fri,  8 May 2026 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fr222XLB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9478737647E
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251026; cv=none; b=chYrzdoXEsiGvwuEOJmUcdVJb9UK3wOyWBy+rjERfZ/9KWoHui260g9IpRG9oWVfaUgL+Npk3PbxXA78KpKfxEYTvFeMj2FPZpBw8Z1aoBpga4Q7ZEeUhd4B9locCcxHIRLH9cvzY/NkCdOHwdVfVjPg4d5qR6e2SByjY7xkRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251026; c=relaxed/simple;
	bh=ClTQqUmRk/1fRiNwe+lU3BOEqno44Z4ivoEQTdaDn8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ReQV6WQ0EWl4KbkiCdS5/ae8NurOuXl6k6lkKTMtoh/rt0AaV+tr1BylivPDpShCdv2OqVVHZ1wKceEfHi8eh6lipV0/fBK7Aa+qS3dc+mBdHZqchBivgGMUAuuYrDHp++vbajS2fKVFGsTeNxJzKhZmKK8SSu0h+7nxrW4fhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fr222XLB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778251024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jN9d8X3Cgq30OgxBEoKonpvu/xXGPBaIJxtjI3YZcmE=;
	b=fr222XLBf+7UlpJ9dJ2zTjneqwNBMYoot7HaSwB3MhoYFFVro0A955V95CwhRs2uNqmFzv
	06Ywf5JfFnFDYocmnufkOedOy9EMBK3T1bLibbxy7kKrKK7ibGUl+zEC6WJhV5nYIDO37p
	ySrfFZ7QqdsFsnQ1dtvDMZpKvR5K9Vs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-hjtVq5rlMrWn7wVsOJGmkQ-1; Fri,
 08 May 2026 10:36:58 -0400
X-MC-Unique: hjtVq5rlMrWn7wVsOJGmkQ-1
X-Mimecast-MFC-AGG-ID: hjtVq5rlMrWn7wVsOJGmkQ_1778251016
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FC75195607B;
	Fri,  8 May 2026 14:36:56 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7584318004A3;
	Fri,  8 May 2026 14:36:53 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/2] selftests: openvswitch: add vlan() and
 encap() flow string parsing
In-Reply-To: <20260508134308.2857449-2-houminxi@gmail.com> (Minxi Hou's
	message of "Fri, 8 May 2026 21:43:07 +0800")
References: <20260508134308.2857449-1-houminxi@gmail.com>
	<20260508134308.2857449-2-houminxi@gmail.com>
Date: Fri, 08 May 2026 10:36:51 -0400
Message-ID: <f7t4ikirmrg.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: CEA684F7E7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285866-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Minxi Hou <houminxi@gmail.com> writes:

> Add VLAN TCI formatting and parsing support to ovs-dpctl.py:
>
> - Add _vlan_dpstr() to decompose TCI into vid/pcp/cfi fields,
>   with raw tci=0x%04x fallback when cfi=0 for round-trip safety.
> - Add _parse_vlan_from_flowstr() boundary check for missing ')'.
> - Add encap_ovskey subclass restricting nla_map to L2-L4 attributes
>   (slots 0-21) that appear inside 802.1Q ENCAP, with metadata
>   attributes set to "none".
> - Check parse() return value for unrecognized trailing content.
> - Support callable format functions in dpstr() output.
> - Change OVS_KEY_ATTR_VLAN type from uint16 to be16 to match the
>   kernel __be16 wire format; uint16 decodes in host byte order,
>   which gives wrong values on little-endian architectures.
> - Change OVS_KEY_ATTR_ENCAP type from none to encap_ovskey to
>   enable recursive parsing of 802.1Q encapsulated flow keys.
> - Add push_vlan action class with fields matching kernel struct
>   ovs_action_push_vlan (vlan_tpid, vlan_tci as network-order u16).
> - Add push_vlan dpstr format and parse with range validation
>   (vid 0-4095, pcp 0-7, tpid 0-0xFFFF) and CFI forced to 1.
> - Remove MAX_ENCAP_DEPTH constant and depth tracking -- the
>   bracket-depth counter in the encap parser already handles
>   nesting; the global depth limit was unnecessary.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

There are probably some pylint flags in this patch, but as stated before
it is okay because they are keeping the coding style in this file
consistent.

Reviewed-by: Aaron Conole <aconole@redhat.com>


