Return-Path: <netdev+bounces-287971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DPaBLzSBWpUbwIAu9opvQ
	(envelope-from <netdev+bounces-287971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:48:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D95427C4
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 382AC301B4DE
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E23EDE77;
	Thu, 14 May 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYqdXWcc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164B223707
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766519; cv=none; b=VIdcLQLlU2QhjTtXiHV6+MdhYGWA13I6qoBOYMqjtUtM2Z3iPsaegfiMHeZULKp5odfn1JEX7mgQTyOV+E679zytEncgcA9AEJKs5c4fGyhiookFFSYM9OmUL8q3B/dJ3Efwqsfm9uJbw5RkzO2c0aoTREab8lMTJoTwJ3sYvbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766519; c=relaxed/simple;
	bh=/Jwmlr4yNkQzDVzsjm77kRSpBCNy/sGPCwGbJXpn7pc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+cDpbewLK2WdPPs4wx8pJt0L4cJHd+xoTF51jeMmWRtTbB8+RZqcLkXjcTI/mR4HJGBIuwQ+Y+cj0jX0no2d1Zfj6wdonKJTL0m+ZwFuwtLGp0v/RP+plUReytrbUfO8O2YbypUMGnjgJQls8o0ZrlqdjhXGztwB+zj1NLt1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYqdXWcc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778766517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Py2NBwAszrXeeyrlxYBxDuq+1AsGYDGoJTLIquOAmDw=;
	b=UYqdXWccjR5aeNxOcWheUGo94S/A8DwcbLvZ5nerHASjJFqMCcyTu4NGIU22ub/ClMdjo6
	OmD1rtz31fu35dbGu+RBSVtLRnCOc0AwuHTzmFYsCDcKXwn/9OBD0876/VV4RB883dtvjM
	Ki+VF48VKm8pUnYzTDIWpe/NMpurCt4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-iaQh7iIVPQS4nnorD1EDzw-1; Thu,
 14 May 2026 09:48:32 -0400
X-MC-Unique: iaQh7iIVPQS4nnorD1EDzw-1
X-Mimecast-MFC-AGG-ID: iaQh7iIVPQS4nnorD1EDzw_1778766509
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC0E5197752D;
	Thu, 14 May 2026 13:48:22 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.221])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5128B1956053;
	Thu, 14 May 2026 13:48:18 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  davem@davemloft.net,  echaudro@redhat.com,
  edumazet@google.com,  horms@kernel.org,  i.maximets@ovn.org,
  kuba@kernel.org,  pabeni@redhat.com,  shuah@kernel.org,
  dev@openvswitch.org,  i.maximets@redhat.com,
  linux-kselftest@vger.kernel.org, Eric Garver <eric@garver.life>
Subject: Re: [PATCH net-next] selftests: openvswitch: add dec_ttl action
 support and test
In-Reply-To: <20260514092747.3653656-1-houminxi@gmail.com> (Minxi Hou's
	message of "Thu, 14 May 2026 17:27:47 +0800")
References: <20260514092747.3653656-1-houminxi@gmail.com>
Date: Thu, 14 May 2026 09:48:15 -0400
Message-ID: <f7tecjeqezk.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 5E2D95427C4
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
	TAGGED_FROM(0.00)[bounces-287971-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvswitch.sh:url,ovs-dpctl.py:url]
X-Rspamd-Action: no action

Minxi Hou <houminxi@gmail.com> writes:

> Add dec_ttl action support to the OVS kernel datapath selftest
> framework:
>
>   - Add DecTtl nested NLA class to ovs-dpctl.py with proper
>     OVS_DEC_TTL_ATTR_ACTION sub-attribute handling
>   - Add parse support for dec_ttl(<inner_actions>) action string
>     following the same pattern as clone()
>   - Add dpstr output formatting for dec_ttl actions
>   - Add test_dec_ttl() to openvswitch.sh that verifies:
>     * Normal TTL packets are forwarded after decrement
>     * TTL=1 packets are dropped (TTL expiry)
>     * Graceful skip via ksft_skip if kernel lacks dec_ttl support
>
> The DecTtl class uses late-binding type resolution to reference
> ovsactions for its inner action list, avoiding circular references
> at class definition time.
>
> Tested with vng on x86_64, all OVS selftests pass.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---
>  .../selftests/net/openvswitch/openvswitch.sh  | 55 +++++++++++++++++++
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 39 ++++++++++++-
>  2 files changed, 92 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 3cdd953f6813..200c36c4d7bf 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -28,6 +28,7 @@ tests="
>  	tunnel_metadata				ovs: test extraction of tunnel metadata
>  	tunnel_refcount				ovs: test tunnel vport reference cleanup
>  	drop_reason				drop: test drop reasons are emitted
> +	dec_ttl					ttl: dec_ttl action decrements IP TTL
>  	psample					psample: Sampling packets with psample"
>  
>  info() {
> @@ -244,6 +245,60 @@ usage() {
>  }
>  
>  
> +test_dec_ttl() {
> +	sbx_add "test_dec_ttl" || return $?
> +	ovs_add_dp "test_dec_ttl" decttl || return 1
> +
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "test_dec_ttl" "decttl" "$ns" \
> +			"${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +	ip netns exec client ip addr add 10.0.0.1/24 dev c1
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add 10.0.0.2/24 dev s1
> +	ip netns exec server ip link set s1 up
> +
> +	# Probe: check if kernel supports dec_ttl action.
> +	ovs_add_flow "test_dec_ttl" decttl \
> +		'in_port(1),eth(),eth_type(0x0800),ipv4()' \
> +		'dec_ttl()' &>/dev/null
> +	if [ $? == 1 ]; then
> +		info "no support for dec_ttl - skipping"
> +		ovs_exit_sig
> +		return $ksft_skip
> +	fi
> +
> +	ovs_del_flows "test_dec_ttl" decttl
> +
> +	# ARP flows (bidirectional)
> +	ovs_add_flow "test_dec_ttl" decttl \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_dec_ttl" decttl \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +
> +	# IP flows with dec_ttl action
> +	ovs_add_flow "test_dec_ttl" decttl \
> +		'in_port(1),eth(),eth_type(0x0800),ipv4()' \
> +		'dec_ttl(),2' || return 1
> +	ovs_add_flow "test_dec_ttl" decttl \
> +		'in_port(2),eth(),eth_type(0x0800),ipv4()' \
> +		'dec_ttl(),1' || return 1
> +
> +	info "verify connectivity with dec_ttl"
> +	ovs_sbx "test_dec_ttl" ip netns exec client ping -c 1 -W 2 \
> +		10.0.0.2 || return 1
> +
> +	info "verify TTL=1 is dropped by dec_ttl"
> +	ovs_sbx "test_dec_ttl" ip netns exec client ping -c 1 -W 2 \
> +		-t 1 10.0.0.2 >/dev/null 2>&1 \
> +		&& { info "FAIL: ping should fail with TTL=1 and dec_ttl"
> +		     return 1; }
> +
> +	return 0
> +}
> +
>  # psample test
>  # - use psample to observe packets
>  test_psample() {
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index bbe35e2718d2..a73ca98d7aef 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -388,11 +388,19 @@ class ovsactions(nla):
>          ("OVS_ACTION_ATTR_CLONE", "recursive"),
>          ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
>          ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
> -        ("OVS_ACTION_ATTR_DEC_TTL", "none"),
> +        ("OVS_ACTION_ATTR_DEC_TTL", "DecTtl"),
>          ("OVS_ACTION_ATTR_DROP", "uint32"),
>          ("OVS_ACTION_ATTR_PSAMPLE", "psample"),
>      )
>  
> +    class DecTtl(nla):
> +        nla_flags = NLA_F_NESTED
> +
> +        nla_map = (
> +            ("OVS_DEC_TTL_ATTR_UNSPEC", "none"),
> +            ("OVS_DEC_TTL_ATTR_ACTION", "actions"),
> +        )
> +
>      class psample(nla):
>          nla_flags = NLA_F_NESTED
>  
> @@ -632,6 +640,13 @@ class ovsactions(nla):
>                  print_str += "ct_clear"
>              elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
>                  print_str += "pop_vlan"
> +            elif field[0] == "OVS_ACTION_ATTR_DEC_TTL":
> +                datum = self.get_attr(field[0])
> +                print_str += "dec_ttl("
> +                subacts = datum.get_attr("OVS_DEC_TTL_ATTR_ACTION")
> +                if subacts and subacts.get("attrs"):
> +                    print_str += subacts.dpstr(more)
> +                print_str += ")"
>              elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
>                  print_str += "pop_eth"
>              elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
> @@ -725,7 +740,21 @@ class ovsactions(nla):
>                      actstr = actstr[strspn(actstr, ", ") :]
>                      parsed = True
>  
> -            if parse_starts_block(actstr, "clone(", False):
> +            if parse_starts_block(actstr, "dec_ttl(", False):
> +                parencount += 1
> +                subacts = ovsactions()
> +                actstr = actstr[len("dec_ttl("):]

It looks like in odp-util.c the dec_ttl block has a defined le_1(...)
format for the TTL value being less-than-or-equal-to-1.  I've CC'd Eric
since he added that parsing block.

I think it makes sense to keep that consistent with the existing ODP
utils.

> +                parsedLen = subacts.parse(actstr)
> +                decttl = ovsactions.DecTtl()
> +                decttl["attrs"].append(
> +                    ("OVS_DEC_TTL_ATTR_ACTION", subacts)
> +                )
> +                self["attrs"].append(
> +                    ("OVS_ACTION_ATTR_DEC_TTL", decttl)
> +                )
> +                actstr = actstr[parsedLen:]
> +                parsed = True
> +            elif parse_starts_block(actstr, "clone(", False):
>                  parencount += 1
>                  subacts = ovsactions()
>                  actstr = actstr[len("clone("):]
> @@ -896,6 +925,12 @@ class ovsactions(nla):
>          return (totallen - len(actstr))
>  
>  
> +# pyroute2 resolves nla_map types via getattr(self, name).
> +# DecTtl needs "actions" to resolve to ovsactions, but
> +# ovsactions is not defined when DecTtl class body runs.
> +ovsactions.DecTtl.actions = ovsactions
> +
> +
>  class ovskey(nla):
>      nla_flags = NLA_F_NESTED
>      nla_map = (


