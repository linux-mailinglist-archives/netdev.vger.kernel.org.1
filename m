Return-Path: <netdev+bounces-295949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6SctCzUbI2pOigEAu9opvQ
	(envelope-from <netdev+bounces-295949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:53:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F1564AC29
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:53:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GnEwSK7g;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295949-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295949-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0F513045B10
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC043D564D;
	Fri,  5 Jun 2026 18:51:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4C29AAF3
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:51:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685515; cv=none; b=EXdHXOoOnvNMEh7vjJsSLV2bxzlzyg/tZTROA7ahTV6yAg6BIbWyJoaabgJrk/o0Z1InkIKQAn5709bGBedU3XkTPxLe+YIon4pnbhws9kmaHe/rb0ad3f396w5j1EgcplyMw4Kayi28BaNOovJnCXleinFzUgFdBC93qK2NWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685515; c=relaxed/simple;
	bh=WwyzoUFGghEi4lwn9ar9eD5MS67tyqWtpTaGMQuQSu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hRUUsHLKWEIAnwUy5jRAti33AOymGJDe6y5fW2sTbDWt2B6ZYvJV2cYyIT1gf6vhWyUadeOE4sBqyJvdhcG3+lhnaYQNxnHXcECiv0DoK2CxQW5xaelql7srQ5a1xVzRfytBekyCoZSpZIfNYCCrq6I2Qgb/s2nphUWjlrr+4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnEwSK7g; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780685511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/8+/pf30WAbPBX0MSXVhri10fbYoRgaJ6KeAOF/Zuk=;
	b=GnEwSK7g9HuJYZ2tFsLNLCt3XetUUe7KvVWw3AU4dfdAU5RS0/jcK6xeOTIKm/AWCagI80
	TUvD2Od+xUpf0SVAYsOopKMwfEkcLG3A1zYBTV46YRoel3zJvSxY8m+xUJ6KjJ5f426kLA
	4+wCl6CYM+t3iZ8CGVLksmuT11IwJqI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-ODwdrsXXPEyB01Z8MrXazQ-1; Fri,
 05 Jun 2026 14:51:48 -0400
X-MC-Unique: ODwdrsXXPEyB01Z8MrXazQ-1
X-Mimecast-MFC-AGG-ID: ODwdrsXXPEyB01Z8MrXazQ_1780685506
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CC5D1956052;
	Fri,  5 Jun 2026 18:51:46 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DE233000210;
	Fri,  5 Jun 2026 18:51:44 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: echaudro@redhat.com,  i.maximets@ovn.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  shuah@kernel.org,  netdev@vger.kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  amorenoz@redhat.com
Subject: Re: [PATCH net-next] selftests/net/openvswitch: add flow modify test
In-Reply-To: <20260605124222.963815-1-houminxi@gmail.com> (Minxi Hou's message
	of "Fri, 5 Jun 2026 20:42:22 +0800")
References: <20260605124222.963815-1-houminxi@gmail.com>
Date: Fri, 05 Jun 2026 14:51:43 -0400
Message-ID: <f7tv7bwhlc0.fsf@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295949-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:amorenoz@redhat.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7F1564AC29

Minxi Hou <houminxi@gmail.com> writes:

> Add mod_flow() and the mod-flow CLI command to ovs-dpctl.py, exercising
> OVS_FLOW_CMD_SET. Add test_flow_set which first modifies an existing
> flow with new actions and verifies the change via traffic, then modifies
> the same flow without actions and verifies the kernel handles the
> no-actions case gracefully.
>
> The no-actions path is unreachable from userspace OVS tools (dpctl
> mod-flow requires actions) but reachable via raw netlink. This is the
> code path where Adrian Moreno found a possible kfree_skb of ERR_PTR
> when reply allocation fails after locking.
>
> Make parse() skip OVS_FLOW_ATTR_ACTIONS when actstr is None so the
> kernel enters the post-lock allocation branch in ovs_flow_cmd_set().
>
> Suggested-by: Aaron Conole <aconole@redhat.com>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

Thanks for the really quick turnaround.  I'll do a deeper review of the
code on Monday; I wanted to reply though because I was expecting to see
a splat in the selftest, but instead it passed.  This confused me at
first, because I didn't realize that the net- targeted patches were also
applied in the net-next test run:

https://github.com/linux-netdev/testing/commit/30e78e3cb99d9abb5182c387abdf5ede29fb9589  ("net: openvswitch: fix possible kfree_skb of ERR_PTR")

But we will want to make sure that whenever this selftest would finally
get applied the above kfree_skb fix is also applied.

>  .../selftests/net/openvswitch/openvswitch.sh  | 72 +++++++++++++++++++
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 39 +++++++++-
>  2 files changed, 108 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index a415e9dec8cd..71190bc662f9 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -30,6 +30,7 @@ tests="
>  	drop_reason				drop: test drop reasons are emitted
>  	pop_vlan				vlan: POP_VLAN action strips tag
>  	dec_ttl					ttl: dec_ttl decrements IP TTL
> +	flow_set				flow-set: Flow modify
>  	psample					psample: Sampling packets with psample"
>  
>  info() {
> @@ -193,6 +194,23 @@ ovs_add_flow () {
>  	return 0
>  }
>  
> +ovs_mod_flow () {
> +	if [ -n "$4" ]; then
> +		info "Modifying flow: sbx:$1 br:$2 flow:$3 act:$4"
> +		ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py \
> +			mod-flow "$2" "$3" "$4"
> +	else
> +		info "Modifying flow (no actions): sbx:$1 br:$2 flow:$3"
> +		ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py \
> +			mod-flow "$2" "$3"
> +	fi
> +	if [ $? -ne 0 ]; then
> +		info "Flow modify [ $3 ] failed"
> +		return 1
> +	fi
> +	return 0
> +}
> +
>  ovs_del_flows () {
>  	info "Deleting all flows from DP: sbx:$1 br:$2"
>  	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py del-flows "$2"
> @@ -300,6 +318,60 @@ test_dec_ttl() {
>  	return 0
>  }
>  
> +test_flow_set() {
> +	sbx_add "test_flow_set" || return $?
> +	ovs_add_dp "test_flow_set" flowset || return 1
> +
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "test_flow_set" "flowset" "$ns" \
> +			"${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +	ip netns exec client ip addr add 10.0.0.1/24 dev c1
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add 10.0.0.2/24 dev s1
> +	ip netns exec server ip link set s1 up
> +
> +	ovs_add_flow "test_flow_set" flowset \
> +		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
> +	ovs_add_flow "test_flow_set" flowset \
> +		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
> +
> +	local fwd_flow="ufid:00000001-0002-0003-0004-000500060007"
> +	fwd_flow="$fwd_flow,in_port(1),eth(),eth_type(0x0800),ipv4()"
> +
> +	ovs_add_flow "test_flow_set" flowset "$fwd_flow" '2' \
> +		|| return 1
> +	ovs_add_flow "test_flow_set" flowset \
> +		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
> +
> +	info "verify initial forwarding"
> +	ovs_sbx "test_flow_set" ip netns exec client ping -c 1 -W 2 \
> +		10.0.0.2 || return 1
> +
> +	info "mod-flow with new actions (change to drop)"
> +	ovs_mod_flow "test_flow_set" flowset "$fwd_flow" 'drop' \
> +		|| return 1
> +
> +	info "verify traffic is now dropped"
> +	ovs_sbx "test_flow_set" ip netns exec client ping -c 1 -W 2 \
> +		10.0.0.2 >/dev/null 2>&1 \
> +		&& { info "FAIL: ping should fail after mod-flow to drop"
> +		     return 1; }
> +
> +	info "mod-flow without actions"
> +	ovs_mod_flow "test_flow_set" flowset "$fwd_flow" || return 1
> +
> +	info "verify drop actions unchanged"
> +	ovs_sbx "test_flow_set" ip netns exec client ping -c 1 -W 2 \
> +		10.0.0.2 >/dev/null 2>&1 \
> +		&& { info "FAIL: ping should still fail after no-actions set"
> +		     return 1; }
> +
> +	return 0
> +}
> +
>  # psample test
>  # - use psample to observe packets
>  test_psample() {
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 3342e295293d..9113473d425f 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -2702,9 +2702,10 @@ class OvsFlow(GenericNetlinkSocket):
>              self["attrs"].append(["OVS_FLOW_ATTR_KEY", k])
>              self["attrs"].append(["OVS_FLOW_ATTR_MASK", m])
>  
> -            a = ovsactions()
> -            a.parse(actstr)
> -            self["attrs"].append(["OVS_FLOW_ATTR_ACTIONS", a])
> +            if actstr is not None:
> +                a = ovsactions()
> +                a.parse(actstr)
> +                self["attrs"].append(["OVS_FLOW_ATTR_ACTIONS", a])
>  
>      def __init__(self):
>          GenericNetlinkSocket.__init__(self)
> @@ -2738,6 +2739,24 @@ class OvsFlow(GenericNetlinkSocket):
>              raise ne
>          return reply
>  
> +    def mod_flow(self, dpifindex, flowmsg):
> +        flowmsg["cmd"] = OVS_FLOW_CMD_SET
> +        flowmsg["version"] = OVS_DATAPATH_VERSION
> +        flowmsg["reserved"] = 0
> +        flowmsg["dpifindex"] = dpifindex
> +
> +        try:
> +            reply = self.nlm_request(
> +                flowmsg,
> +                msg_type=self.prid,
> +                msg_flags=NLM_F_REQUEST | NLM_F_ACK,
> +            )
> +            reply = reply[0]
> +        except NetlinkError as ne:
> +            print(flowmsg)
> +            raise ne
> +        return reply
> +
>      def del_flows(self, dpifindex):
>          """
>          Send a del message to the kernel that will drop all flows.
> @@ -3013,6 +3032,12 @@ def main(argv):
>      addflcmd.add_argument("flow", help="Flow specification")
>      addflcmd.add_argument("acts", help="Flow actions")
>  
> +    modflcmd = subparsers.add_parser("mod-flow")
> +    modflcmd.add_argument("modbr", help="Datapath name")
> +    modflcmd.add_argument("modflow", help="Flow specification")
> +    modflcmd.add_argument("modacts", help="Flow actions",
> +                          nargs="?", default=None)
> +
>      delfscmd = subparsers.add_parser("del-flows")
>      delfscmd.add_argument("flsbr", help="Datapath name")
>  
> @@ -3110,6 +3135,14 @@ def main(argv):
>          flow = OvsFlow.ovs_flow_msg()
>          flow.parse(args.flow, args.acts, rep["dpifindex"])
>          ovsflow.add_flow(rep["dpifindex"], flow)
> +    elif hasattr(args, "modbr"):
> +        rep = ovsdp.info(args.modbr, 0)
> +        if rep is None:
> +            print("DP '%s' not found." % args.modbr)
> +            return 1
> +        flow = OvsFlow.ovs_flow_msg()
> +        flow.parse(args.modflow, args.modacts, rep["dpifindex"])
> +        ovsflow.mod_flow(rep["dpifindex"], flow)
>      elif hasattr(args, "flsbr"):
>          rep = ovsdp.info(args.flsbr, 0)
>          if rep is None:


