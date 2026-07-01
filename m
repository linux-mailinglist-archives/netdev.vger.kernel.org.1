Return-Path: <netdev+bounces-303783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OWDvETFPRWqk+QoAu9opvQ
	(envelope-from <netdev+bounces-303783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:32:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E20F6F05EF
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:32:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=R3aYYBqw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303783-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303783-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D323009CC2
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9984938F947;
	Wed,  1 Jul 2026 17:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B6363C57
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 17:26:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926808; cv=none; b=VZZm4GZx7b3sehu5Wg6k9yC0ovR0Mi9yWGTu/b9+2HwhdVfNzLj1mq8B8rdb1fvCG1Q4Tnm/t9rAxkBOCQDoP7N0QgW7mn1NsUJbT3HADQn6bKTd1tqC7+wqbaw23TiBR7ZOquxUdP0syScdvkW4f7Nw/LHrQeBpVdlL70IWpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926808; c=relaxed/simple;
	bh=7UEHOxjpf1RZfoI3R9qQR6jFUnvNcPN68KSn3tDiX34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kl0GLg9DK+nqQrwS7nKOE2qBjsTwMEr5DghBQSbRLryLUumvfmtulKRMKLMcXfBuERyuMkB7nXBwXuduZISHmABFJ8hx5eOTjXA+uJ8OQBRk6jBuwkAGNuPZVGzeYH/sx92jakaFind31XyzWdKrWg29dgZJ65QsJc/r0jvyVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3aYYBqw; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782926806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NpY/TtcLsNQNp6y7nANvL4cIqjFKgOOo69hrHs2qUsI=;
	b=R3aYYBqw9gSRDukE3oPCpdH5ztqewwT3fSF4b50TVmMqCcGQqUpNB7ETEP959ThSodIgJA
	l3R6dg815fLPWD+fLPMF3QHXpryqNcVhcC9iJ19+AXJj5lWyuJUnS5LDVfQBcAuuz0yXm8
	4ZPKOj6/O23Li/s1OfiYIVFDIO6CHXI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-HqXJenIiPTqWN95tZzp4yw-1; Wed,
 01 Jul 2026 13:26:44 -0400
X-MC-Unique: HqXJenIiPTqWN95tZzp4yw-1
X-Mimecast-MFC-AGG-ID: HqXJenIiPTqWN95tZzp4yw_1782926803
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA4FE184A0B5;
	Wed,  1 Jul 2026 17:26:43 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B45930001BE;
	Wed,  1 Jul 2026 17:26:42 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/net/openvswitch: add output truncation test
In-Reply-To: <20260630102208.29140-1-houminxi@gmail.com> (Minxi Hou's message
	of "Tue, 30 Jun 2026 18:22:08 +0800")
References: <20260630102208.29140-1-houminxi@gmail.com>
Date: Wed, 01 Jul 2026 13:26:41 -0400
Message-ID: <f7tik6y4o4u.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303783-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:echaudro@redhat.com,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E20F6F05EF

Minxi Hou <houminxi@gmail.com> writes:

> Add test_trunc exercising the OVS_ACTION_ATTR_TRUNC action. The test
> verifies truncation in three steps: first confirm normal forwarding
> works, then apply trunc(14) which truncates packets to the Ethernet
> header and verify ping fails, then restore normal forwarding and
> verify connectivity recovers.
>
> The trunc action sets OVS_CB(skb)->cutlen, causing pskb_trim at
> output time. With trunc(14) the IP payload is stripped, so the
> receiver drops the frame and ICMP echo reply is never generated.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

NOTE: The subject should have had net-next I think

>  .../selftests/net/openvswitch/openvswitch.sh  | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 2954245129a2..fef21eb4a129 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -32,6 +32,7 @@ tests="
>  	dec_ttl					ttl: dec_ttl decrements IP TTL
>  	flow_set				flow-set: Flow modify
>  	action_set				set: SET action rewrites fields
> +	trunc					trunc: output truncation
>  	psample					psample: Sampling packets with psample"
>  
>  info() {
> @@ -443,6 +444,71 @@ test_action_set() {
>  	return 0
>  }
>  

Most of the tests have a comment in front of them that does some
description.  I haven't been good about enforcing it, but at least I'd
like to see it here to describe what trunc limits are being tested (in
this case, just limiting to 14).

Perhaps we can also add testing for trunc(1) since that should reject
(or both trunc(1) and trunc(13))

> +test_trunc() {
> +	sbx_add "test_trunc" || return $?
> +	ovs_add_dp "test_trunc" trunctest || return 1
> +
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "test_trunc" "trunctest" "$ns" \
> +			"${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +	ip netns exec client ip addr add 10.0.0.1/24 dev c1
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add 10.0.0.2/24 dev s1
> +	ip netns exec server ip link set s1 up
> +
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
> +
> +	info "verify connectivity without truncation"
> +	ovs_sbx "test_trunc" ip netns exec client ping -c 1 -W 2 \
> +		10.0.0.2 || return 1
> +
> +	ovs_del_flows "test_trunc" trunctest
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +
> +	info "add truncated forwarding flow"
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(1),eth(),eth_type(0x0800),ipv4()' \
> +		'trunc(14),2' || return 1
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
> +
> +	info "verify ping fails with truncation"
> +	ovs_sbx "test_trunc" ip netns exec client ping -c 1 -W 2 \
> +		10.0.0.2 >/dev/null 2>&1 \
> +		&& { info "FAIL: ping should fail with trunc(14)"
> +		     return 1; }
> +
> +	ovs_del_flows "test_trunc" trunctest
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
> +	ovs_add_flow "test_trunc" trunctest \
> +		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
> +
> +	info "verify connectivity restored without truncation"
> +	ovs_sbx "test_trunc" ip netns exec client ping -c 1 -W 2 \
> +		10.0.0.2 || return 1
> +
> +	return 0
> +}
> +
>  # psample test
>  # - use psample to observe packets
>  test_psample() {
>
> base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e


