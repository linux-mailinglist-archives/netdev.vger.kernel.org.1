Return-Path: <netdev+bounces-303786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id goULGmlRRWry+QoAu9opvQ
	(envelope-from <netdev+bounces-303786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:42:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B7C6F0676
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:42:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZEi8YnYI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303786-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303786-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 974633028805
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5604BCAAE;
	Wed,  1 Jul 2026 17:40:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4D4BC03C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 17:40:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927617; cv=none; b=LTPj5VqW+OKG3haX/E7+99Dt++meTt2hKLmzh5IPxJ//cJsDIl617UQcPpNzmTCGCNzKIjZzll5fdcSNQVfDQpILYUArX3pIpcyg8gHZHhllnrKdBzj6EPl9yHb+39TN66YaijJEOcCM1fcsElFicuzWN/TnSsVGyaE81P13JzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927617; c=relaxed/simple;
	bh=HtEoO8puJDn1x+DdOZFVc1EwtFYgvDtjIjaPkFBTH7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V4aFgTDkeUplhEHNdUyNzqdMBvD/v5OiqnAm8frZlkejyTkMZzJUugduWV2XthRTPavp/UHylx7eL5169gzqhYY/qE8jl0EM2DKLjxufp8a59beNa9i63xkFvJDxSXuZ+eZjjPbFWo+RtEbN83K7w6UTS5+JiilS7Gi5ZgzppAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEi8YnYI; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782927615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ePpki7oPuPpClYdSE3/Mi/uFeMHFSZG0G7HVQhPQ0BU=;
	b=ZEi8YnYIWnzCQQX/cVxdrF/SaU++BI349tWB8L4ewjkbW2owIJO1VXkweUKqET4maT7iax
	8gGg7vi05f1IT6SjSSZZBCGPMuIl25jieQREmvbKxddckApLZJwE9cNb7T0Z9VY/yJ1C0y
	x4iQlUTvM01/Zjz06QOninUd3Byl21w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-SEeXv8pTP4SHtbcypUlXXA-1; Wed,
 01 Jul 2026 13:40:11 -0400
X-MC-Unique: SEeXv8pTP4SHtbcypUlXXA-1
X-Mimecast-MFC-AGG-ID: SEeXv8pTP4SHtbcypUlXXA_1782927611
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9FBF1926B55;
	Wed,  1 Jul 2026 17:40:10 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3823F1800592;
	Wed,  1 Jul 2026 17:40:10 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] selftests/net/openvswitch: add ICMPv6 echo type
 match test
In-Reply-To: <20260630102225.29733-1-houminxi@gmail.com> (Minxi Hou's message
	of "Tue, 30 Jun 2026 18:22:25 +0800")
References: <20260630102225.29733-1-houminxi@gmail.com>
Date: Wed, 01 Jul 2026 13:40:08 -0400
Message-ID: <f7techm4nif.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303786-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:echaudro@redhat.com,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: F3B7C6F0676

Minxi Hou <houminxi@gmail.com> writes:

> Register OVS_KEY_ATTR_ICMPV6 in the flow key parser so that
> icmpv6(type=...) can be used in flow specifications. Without this
> registration the parser silently drops the token and the kernel
> rejects the flow with EINVAL because the expected ICMPv6 key
> attribute is missing.
>
> While here, add convert_int() to the ovs_key_ipv6 and ovs_key_icmp
> fields_map entries so that specifying a field value produces the
> correct wildcard mask. The IPv6 flow label uses convert_int(20) to
> produce a 20-bit mask (0x000FFFFF), matching the kernel constraint in
> flow_netlink.c that rejects masks with bits 20-31 set; byte-wide
> fields use convert_int(8). The ipv4 counterpart already does this via
> convert_int(); the ipv6 and icmp classes were simply missing the fifth
> tuple element. Existing callers that pass empty parentheses are
> unaffected because convert_int("") returns (0, 0).
>
> Add test_icmpv6 exercising the ICMPv6 echo flow key. The test uses
> static neighbour entries to bypass NDP, then verifies in three steps:
> install icmpv6(type=128) and icmpv6(type=129) flows and confirm ping
> works, remove the flows and confirm ping fails, reinstall and confirm
> recovery.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

Same as other, I think this should have had the 'net-next' specifier.

Also, I see that dev@openvswitch.org and Ilya weren't CC'd.  Next
version should do that.

>  .../selftests/net/openvswitch/openvswitch.sh  | 63 +++++++++++++++++++
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 26 +++++---
>  2 files changed, 82 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 2954245129a2..2de01137bb50 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -32,6 +32,7 @@ tests="
>  	dec_ttl					ttl: dec_ttl decrements IP TTL
>  	flow_set				flow-set: Flow modify
>  	action_set				set: SET action rewrites fields
> +	icmpv6					icmpv6: ICMPv6 echo type match
>  	psample					psample: Sampling packets with psample"
>  
>  info() {
> @@ -443,6 +444,68 @@ test_action_set() {
>  	return 0
>  }
>  

Please document this test case

> +test_icmpv6() {
> +	sbx_add "test_icmpv6" || return $?
> +	ovs_add_dp "test_icmpv6" icmpv6 || return 1
> +
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "test_icmpv6" "icmpv6" \
> +			"$ns" "${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +

===

> +	ip netns exec client ip addr add fd00::1/64 dev c1 nodad
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add fd00::2/64 dev s1 nodad
> +	ip netns exec server ip link set s1 up
> +
> +	local cl_mac sl_mac
> +	cl_mac=$(ip netns exec client \
> +		ip link show c1 | awk '/link\/ether/ {print $2}')
> +	[ -z "$cl_mac" ] && \
> +		{ info "failed to get c1 hwaddr"; return 1; }
> +	sl_mac=$(ip netns exec server \
> +		ip link show s1 | awk '/link\/ether/ {print $2}')
> +	[ -z "$sl_mac" ] && \
> +		{ info "failed to get s1 hwaddr"; return 1; }
> +	ip netns exec client \
> +		ip -6 neigh add fd00::2 lladdr "$sl_mac" dev c1
> +	ip netns exec server \
> +		ip -6 neigh add fd00::1 lladdr "$cl_mac" dev s1

===

Should there be some error detection / bailing here?  I think we should
do the same as in the vlan case and set the unreachability detection to
'permanent' to prevent possible issues with racy neighbor discovery.

> +
> +	ovs_add_flow "test_icmpv6" icmpv6 \
> +	  'in_port(1),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6(type=128)' \
> +	  '2' || return 1
> +	ovs_add_flow "test_icmpv6" icmpv6 \
> +	  'in_port(2),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6(type=129)' \
> +	  '1' || return 1
> +
> +	info "verify ICMPv6 echo with type-specific flows"
> +	ovs_sbx "test_icmpv6" ip netns exec client \
> +		ping -6 -c 1 -W 2 fd00::2 || return 1
> +
> +	ovs_del_flows "test_icmpv6" icmpv6
> +
> +	info "verify ping fails without echo flows"
> +	ovs_sbx "test_icmpv6" ip netns exec client \
> +		ping -6 -c 1 -W 2 fd00::2 >/dev/null 2>&1 \
> +		&& { info "FAIL: ping should fail without flows"
> +		     return 1; }
> +
> +	ovs_add_flow "test_icmpv6" icmpv6 \
> +	  'in_port(1),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6(type=128)' \
> +	  '2' || return 1
> +	ovs_add_flow "test_icmpv6" icmpv6 \
> +	  'in_port(2),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6(type=129)' \
> +	  '1' || return 1
> +
> +	info "verify connectivity restored"
> +	ovs_sbx "test_icmpv6" ip netns exec client \
> +		ping -6 -c 1 -W 2 fd00::2 || return 1
> +
> +	return 0
> +}
> +
>  # psample test
>  # - use psample to observe packets
>  test_psample() {
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index e1ecfad2c03e..f3edd198223f 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -1255,11 +1255,16 @@ class ovskey(nla):
>                  lambda x: ipaddress.IPv6Address(x).packed if x else 0,
>                  convert_ipv6,
>              ),
> -            ("label", "label", "%d", lambda x: int(x) if x else 0),
> -            ("proto", "proto", "%d", lambda x: int(x) if x else 0),
> -            ("tclass", "tclass", "%d", lambda x: int(x) if x else 0),
> -            ("hlimit", "hlimit", "%d", lambda x: int(x) if x else 0),
> -            ("frag", "frag", "%d", lambda x: int(x) if x else 0),
> +            ("label", "label", "%d", lambda x: int(x) if x else 0,
> +                convert_int(20)),
> +            ("proto", "proto", "%d", lambda x: int(x) if x else 0,
> +                convert_int(8)),
> +            ("tclass", "tclass", "%d", lambda x: int(x) if x else 0,
> +                convert_int(8)),
> +            ("hlimit", "hlimit", "%d", lambda x: int(x) if x else 0,
> +                convert_int(8)),
> +            ("frag", "frag", "%d", lambda x: int(x) if x else 0,
> +                convert_int(8)),
>          )
>  
>          def __init__(
> @@ -1344,8 +1349,10 @@ class ovskey(nla):
>          )
>  
>          fields_map = (
> -            ("type", "type", "%d", lambda x: int(x) if x else 0),
> -            ("code", "code", "%d", lambda x: int(x) if x else 0),
> +            ("type", "type", "%d", lambda x: int(x) if x else 0,
> +                convert_int(8)),
> +            ("code", "code", "%d", lambda x: int(x) if x else 0,
> +                convert_int(8)),
>          )
>  
>          def __init__(
> @@ -1982,6 +1989,11 @@ class ovskey(nla):
>                  "icmp",
>                  ovskey.ovs_key_icmp,
>              ),
> +            (
> +                "OVS_KEY_ATTR_ICMPV6",
> +                "icmpv6",
> +                ovskey.ovs_key_icmpv6,
> +            ),
>              (
>                  "OVS_KEY_ATTR_TCP_FLAGS",
>                  "tcp_flags",
>
> base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e


