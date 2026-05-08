Return-Path: <netdev+bounces-285802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJxBKnra/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:43:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1444F6822
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D342303098F
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8213DEAC3;
	Fri,  8 May 2026 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuSviAk5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BA3DCDB8
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244068; cv=none; b=dYx7WQnWpq13BXWHcIu5cjmLqCw27kCoP999+VO0HHIilBsehHrd4S1HUpvnUgHI3oF3FXDzSS8+rVGuXGAuHjXJapWVNzTudMoAFseGJngUN7SheCwJGY31KuUHwJt5VsleLgqE4nWP1Q3M2NH7VnRylLHukoZEKkNoQpvE2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244068; c=relaxed/simple;
	bh=nlSoLnSKPIcLMHgTsk2TjZ6qExBlK3inTuUN51B7onw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Az9jyzZ1NmUcOVNFNfAGG+kR630vElW+fV3B19F85OFN7JHkT26WhnSnlK0q/mIRdeAAZ/UclDulRDY/fSXfgTjwrrLUcKevkHV6kANMWMU17YW8J5ZTvDst4VlTHwbeKhVrfNJmV5GCl6EImk58VRm4Oz5qhUTio/2KmrugUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WuSviAk5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778244065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOQAs0ycqiuZ5ztluw7Eol8hdH6Zm+lywN/xK4ATBJE=;
	b=WuSviAk5NxTE0fhC3ufi7Qv64UxSeZQSxig4UzpY22seQjO+rmrST++mO0VSGz4Q4nUEwE
	TiuwoHo4vofo9Etz+4oup1/p0GYcspOaCbOzrDzXIXGyYiwnphWMnzMRT5HPJpoKd8ITce
	lirncLfR89zjbWBgb3fb9Xd34jXVtdM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-__LpUwA2PWSIeTbZN4yHAA-1; Fri,
 08 May 2026 08:41:02 -0400
X-MC-Unique: __LpUwA2PWSIeTbZN4yHAA-1
X-Mimecast-MFC-AGG-ID: __LpUwA2PWSIeTbZN4yHAA_1778244060
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26F7A18005B6;
	Fri,  8 May 2026 12:41:00 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.142])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D64E300019F;
	Fri,  8 May 2026 12:40:57 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/2] selftests: openvswitch: add pop_vlan test
In-Reply-To: <20260507131541.2331771-3-houminxi@gmail.com> (Minxi Hou's
	message of "Thu, 7 May 2026 21:15:41 +0800")
References: <20260507131541.2331771-1-houminxi@gmail.com>
	<20260507131541.2331771-3-houminxi@gmail.com>
Date: Fri, 08 May 2026 08:40:50 -0400
Message-ID: <f7th5oirs4t.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 6A1444F6822
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285802-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
>  .../selftests/net/openvswitch/openvswitch.sh  | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index b327d3061ed5..6d13ee8c2baf 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -27,6 +27,7 @@ tests="
>  	upcall_interfaces			ovs: test the upcall interfaces
>  	tunnel_metadata				ovs: test extraction of tunnel metadata
>  	drop_reason				drop: test drop reasons are emitted
> +	pop_vlan				vlan: POP_VLAN action strips tag
>  	psample					psample: Sampling packets with psample"
>  
>  info() {
> @@ -830,6 +831,78 @@ test_tunnel_metadata() {
>  	return 0
>  }
>  
> +test_pop_vlan() {
> +	local sbx="test_pop_vlan"
> +	sbx_add "$sbx" || return $?
> +	ovs_add_dp "$sbx" vlandp || return 1
> +
> +	ovs_add_netns_and_veths "$sbx" vlandp \
> +		ns1 veth1 ns1veth 192.0.2.1/24 || return 1
> +	ovs_add_netns_and_veths "$sbx" vlandp \
> +		ns2 veth2 ns2veth 192.0.2.2/24 || return 1
> +
> +	# Baseline: untagged bidirectional forwarding
> +	ovs_add_flow "$sbx" vlandp \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "$sbx" vlandp \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +	ovs_add_flow "$sbx" vlandp \
> +		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
> +	ovs_add_flow "$sbx" vlandp \
> +		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
> +	ovs_sbx "$sbx" ip netns exec ns1 ping -c 3 -W 2 \
> +		192.0.2.2 || return 1
> +
> +	# VLAN topology: ns1 uses VLAN sub-interface, ns2 is plain
> +	ip -n ns1 link add link ns1veth name ns1veth.10 \
> +		type vlan id 10 || return 1
> +	on_exit "ip -n ns1 link del ns1veth.10 2>/dev/null"
> +	ip -n ns1 addr add 198.51.100.1/24 dev ns1veth.10 || return 1
> +	ip -n ns1 link set ns1veth.10 up || return 1
> +	ip -n ns2 addr add 198.51.100.2/24 dev ns2veth || return 1
> +
> +	ovs_del_flows "$sbx" vlandp
> +
> +	# Static ARP: avoids VLAN-tagged ARP complexity
> +	local ns1veth10mac ns2mac
> +	ns1veth10mac=$(ip -n ns1 link show ns1veth.10 \
> +		| awk '/link\/ether/ {print $2}')

We might add a check here (as a just in case):

  [ -z "$ns1veth10mac" ] && \
    { info "failed to get ns1veth10mac"; return 1; }

Same with the ns2mac.   The commands after will fail anyway (because the
empty string will be an issue for the syntax), so it's more like helping
to debug when things go wrong.

With that:

Reviewed-by: Aaron Conole <aconole@redhat.com>

> +	ns2mac=$(ip -n ns2 link show ns2veth \
> +		| awk '/link\/ether/ {print $2}')
> +	ip -n ns1 neigh replace 198.51.100.2 lladdr "$ns2mac" \
> +		dev ns1veth.10 nud permanent || return 1
> +	ip -n ns2 neigh replace 198.51.100.1 \
> +		lladdr "$ns1veth10mac" \
> +		dev ns2veth nud permanent || return 1
> +
> +	local vlan_match='in_port(1),eth(),eth_type(0x8100),'
> +	vlan_match+='vlan(vid=10),'
> +	vlan_match+='encap(eth_type(0x0800),'
> +	vlan_match+='ipv4(src=198.51.100.1,proto=1),icmp())'
> +
> +	# Negative: forward without pop_vlan -- tagged frame
> +	# is invisible to ns2 (no VLAN sub-interface), ping fails
> +	ovs_add_flow "$sbx" vlandp "$vlan_match" '2' || return 1
> +	ovs_sbx "$sbx" ip netns exec ns1 ping -I ns1veth.10 \
> +		-c 3 -W 1 198.51.100.2 >/dev/null 2>&1 \
> +		&& { info "FAIL: ping should fail without pop_vlan"
> +		     return 1; }
> +
> +	ovs_del_flows "$sbx" vlandp
> +
> +	# Positive: pop_vlan strips tag on forward path,
> +	# push_vlan restores tag on return path -- ping succeeds
> +	ovs_add_flow "$sbx" vlandp \
> +		"$vlan_match" 'pop_vlan,2' || return 1
> +	ovs_add_flow "$sbx" vlandp \
> +		'in_port(2),eth(),eth_type(0x0800),ipv4()' \
> +		'push_vlan(vid=10,pcp=0,tpid=0x8100),1' || return 1
> +	ovs_sbx "$sbx" ip netns exec ns1 ping -I ns1veth.10 \
> +		-c 3 -W 2 198.51.100.2 || return 1
> +
> +	return 0
> +}
> +
>  run_test() {
>  	(
>  	tname="$1"


