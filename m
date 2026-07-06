Return-Path: <netdev+bounces-305225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gz4fKHwaTGqggQEAu9opvQ
	(envelope-from <netdev+bounces-305225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:13:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2B715A7F
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:13:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Pt9tIOJO;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305225-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305225-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 169EE3025C34
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 21:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810742B322;
	Mon,  6 Jul 2026 21:13:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9943F4B4
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 21:13:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372408; cv=none; b=BTcl89BHs8oLK5RsmfQ5/V2cejus3cuaOwXxDZdvxdkP59RJIYZRyJLim3SSZE+c81ei0g2EsZREqZGQNYGmaZOYfnG+Sd/9MriDedQ4am4INTp9Svb1Q5XB2rSz0E/EO7L6A3vzzVphakuEuhOtg7+uVjm/5UvxG5bYbbVb72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372408; c=relaxed/simple;
	bh=S+PkDhZh3t6IN3EjUsWlEzchoPCNlIc+JZiP3q67Xjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wv5LrPieIb7yIni4fKGu6uN59WSuiNNcmGEpkM++cQ1OxgTdG3+aaZoPGTBo7+Crb/iwVN6NAuUemqczDP8o7Mx3nupTXwoIxe6RTgtomD4fHZcusce2aCqJlS4BMFoYBOd4g0VrdZhcBXNrrZquM8eZ6kp890zOGio9B1/Xy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pt9tIOJO; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783372402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K/IiNVEaBSIhPlU7hh3s8hLrT9rD+6NyA4ZJlm2HBq0=;
	b=Pt9tIOJOYWFkAboOQLBqQy1wHXt0Vaoy9+0LkfgI/mVfvFNrbDCh5ntqpTDP3h7iJlo1Su
	wJle+LApFTsRuw81tud9AkuFi7ueCdUcEKkY6Jd//23olRhDPLxHPmVbZ+vK85exyygNye
	Jss5d7jdp5Db5sFx3CCa6pQY7ZRh9cg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-d3cR-lOhO8aQZU2ET1gsFg-1; Mon,
 06 Jul 2026 17:13:19 -0400
X-MC-Unique: d3cR-lOhO8aQZU2ET1gsFg-1
X-Mimecast-MFC-AGG-ID: d3cR-lOhO8aQZU2ET1gsFg_1783372396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 745901955DAF;
	Mon,  6 Jul 2026 21:13:16 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A72D18005AA;
	Mon,  6 Jul 2026 21:13:14 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org,  shuah@kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/net/openvswitch: add SCTP flow key test
In-Reply-To: <20260702090908.1253688-1-houminxi@gmail.com> (Minxi Hou's
	message of "Thu, 2 Jul 2026 05:09:08 -0400")
References: <20260702090908.1253688-1-houminxi@gmail.com>
Date: Mon, 06 Jul 2026 17:13:13 -0400
Message-ID: <f7to6gj255i.fsf@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305225-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
X-Rspamd-Queue-Id: 14E2B715A7F

Hi Minxi,

Minxi Hou <houminxi@gmail.com> writes:

> Register OVS_KEY_ATTR_SCTP in the flow key parser so that sctp()
> can be used in flow specifications. The ovs_key_sctp class already
> exists (with src/dst fields matching the TCP/UDP siblings) but was
> not wired into the parser, so the token was silently dropped and the
> kernel rejected the flow.
>
> Add test_sctp_connect_v4 exercising the SCTP flow key with
> port-specific matching: sctp(dst=4443) for client-to-server and
> sctp(src=4443) for server-to-client, mirroring the SCTP four-way
> handshake direction. The test verifies connectivity with flows
> installed, confirms failure after flow removal, then reinstalls
> and verifies recovery.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

One issue I think will happen with this patch is that the other two
in-flight patches will also collide.  I'm thinking it may require
rebasing.

A better strategy going forward would be to bundle the new test
additions in one series.  That's just for going forward, do not resubmit
the existing patches I've acked unless a maintainer asks for it.

>  .../selftests/net/openvswitch/openvswitch.sh  | 92 +++++++++++++++++++
>  .../selftests/net/openvswitch/ovs-dpctl.py    |  5 +
>  2 files changed, 97 insertions(+)
>
> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index 2954245129a2..dd4d0b3bcc23 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -32,6 +32,7 @@ tests="
>  	dec_ttl					ttl: dec_ttl decrements IP TTL
>  	flow_set				flow-set: Flow modify
>  	action_set				set: SET action rewrites fields
> +	sctp_connect_v4				sctp: SCTP flow key matching
>  	psample					psample: Sampling packets with psample"
>  
>  info() {
> @@ -443,6 +444,97 @@ test_action_set() {
>  	return 0
>  }
>  
> +# sctp_connect_v4 test
> +# - sctp(dst=4443) matches client-to-server INIT
> +# - sctp(src=4443) matches server-to-client INIT-ACK
> +# - remove flows and verify connection fails, reinstall and recover
> +test_sctp_connect_v4() {
> +	local t="test_sctp_connect_v4"
> +	which ncat >/dev/null 2>&1 || return $ksft_skip
> +	modprobe -q sctp 2>/dev/null || return $ksft_skip
> +
> +	sbx_add "$t" || return $?
> +	ovs_add_dp "$t" sctp4 || return 1
> +
> +	info "create namespaces"
> +	for ns in client server; do
> +		ovs_add_netns_and_veths "$t" "sctp4" "$ns" \
> +		    "${ns:0:1}0" "${ns:0:1}1" || return 1
> +	done
> +
> +	ip netns exec client ip addr add 172.31.110.10/24 dev c1
> +	ip netns exec client ip link set c1 up
> +	ip netns exec server ip addr add 172.31.110.20/24 dev s1
> +	ip netns exec server ip link set s1 up
> +
> +	# ARP forwarding
> +	ovs_add_flow "$t" sctp4 \
> +	    'in_port(1),eth(),eth_type(0x0806),arp()' \
> +	    '2' || return 1
> +	ovs_add_flow "$t" sctp4 \
> +	    'in_port(2),eth(),eth_type(0x0806),arp()' \
> +	    '1' || return 1
> +
> +	# SCTP port matching: dst for request, src for reply
> +	ovs_add_flow "$t" sctp4 \
> +	    'in_port(1),eth(),eth_type(0x0800),ipv4(proto=132),sctp(dst=4443)' \
> +	    '2' || return 1
> +	ovs_add_flow "$t" sctp4 \
> +	    'in_port(2),eth(),eth_type(0x0800),ipv4(proto=132),sctp(src=4443)' \
> +	    '1' || return 1
> +
> +	echo "server" | \
> +		ovs_netns_spawn_daemon "$t" "server" \
> +				ncat --sctp -l 172.31.110.20 -vn 4443
> +	sleep 0.1

Instead of this pattern, we can probably do an ovs_wait on the Listening
string.  That way we aren't relying only on the sleep, but on the actual
Ncat output.  Something like

   ovs_wait sh -c
     "[ \$(grep 'Ncat: Listening on ....' ${ovs_dir}/stderr) ]" || \
     return 1

Or you could use a count and do '-ge <number>'

That way if the ncat spawn takes time to start up, it can be ready in
time.

> +	info "verify SCTP association with port-keyed flows"
> +	ovs_sbx "$t" ip netns exec client \
> +	    ncat --sctp -i 1 -zv 172.31.110.20 4443 \
> +	    || return 1
> +
> +	ovs_del_flows "$t" sctp4
> +
> +	info "verify connection fails without flows"
> +	ovs_add_flow "$t" sctp4 \
> +	    'in_port(1),eth(),eth_type(0x0806),arp()' \
> +	    '2' || return 1
> +	ovs_add_flow "$t" sctp4 \
> +	    'in_port(2),eth(),eth_type(0x0806),arp()' \
> +	    '1' || return 1
> +
> +	echo "server2" | \
> +		ovs_netns_spawn_daemon "$t" "server" \
> +				ncat --sctp -l 172.31.110.20 -vn 4443
> +	sleep 0.1
> +
> +	ovs_sbx "$t" ip netns exec client \
> +	    ncat --sctp -w 2 -zv 172.31.110.20 4443 \
> +	    >/dev/null 2>&1 \
> +	    && { info "FAIL: connection should fail without flows"
> +	         return 1; }
> +
> +	info "reinstall flows and verify recovery"
> +	ovs_add_flow "$t" sctp4 \
> +	    'in_port(1),eth(),eth_type(0x0800),ipv4(proto=132),sctp(dst=4443)' \
> +	    '2' || return 1
> +	ovs_add_flow "$t" sctp4 \
> +	    'in_port(2),eth(),eth_type(0x0800),ipv4(proto=132),sctp(src=4443)' \
> +	    '1' || return 1
> +
> +	echo "server3" | \
> +		ovs_netns_spawn_daemon "$t" "server" \
> +				ncat --sctp -l 172.31.110.20 -vn 4443
> +	sleep 0.1
> +
> +	ovs_sbx "$t" ip netns exec client \
> +	    ncat --sctp -i 1 -zv 172.31.110.20 4443 \
> +	    || return 1
> +
> +	return 0
> +}
> +
>  # psample test
>  # - use psample to observe packets
>  test_psample() {
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index e1ecfad2c03e..7cfc29ec7e59 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -1982,6 +1982,11 @@ class ovskey(nla):
>                  "icmp",
>                  ovskey.ovs_key_icmp,
>              ),
> +            (
> +                "OVS_KEY_ATTR_SCTP",
> +                "sctp",
> +                ovskey.ovs_key_sctp,
> +            ),
>              (
>                  "OVS_KEY_ATTR_TCP_FLAGS",
>                  "tcp_flags",


