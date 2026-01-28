Return-Path: <netdev+bounces-254429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIQQFWJkemmB5gEAu9opvQ
	(envelope-from <netdev+bounces-254429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:32:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB6BA82E9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8766301A7E2
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5AB374163;
	Wed, 28 Jan 2026 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNIXpAMm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462B326926
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628767; cv=none; b=qV3/C/ieLP7VZFL+a396NpnjUNW03AQH9qJnM6yeYSeoeiDuI1GW2aGxvZOk2V738QOkqrywokYXn4pyBajakfmB4z/JU4f81dozRIUMJGhgZuavGHgrpujctasx3anXwlNsWZug6XOj4pZAvwF1NYv2qLRvSeILfaAbOHepNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628767; c=relaxed/simple;
	bh=HiiF8oN/JZyzVRZvXlHfT5uyZcuQv5Z1I7+98LRA82w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hTPKh2uesZ5OxdCNpnmRzJFhp2X5kuZXEJs+CTY4WUaVE3v309sW93QIgkcuoMPOWKczwOp9HBvez9lJLJh2HaMz0ya2eQ7BtQI42zpdp+5oZZL0UphZ++uUK6ITTqXWDytR/sBwapt3kdiT3IbeObUs4EfhuZ6Rvx0YuogvJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNIXpAMm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769628764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Syj9xoENklbweTYZxw6IJ7gedxjVxbiF9vjxFzyJ5m0=;
	b=UNIXpAMmoKJkraQbTN9+r9sOEiM97Guv9ffibuH2VXQ0cqsmrSjw8ZozJHP39NNho2Yb/P
	NOlqznBwbZBRIftQOE197WkcizvxbuAwdmhb/zXnjJmMEHs/0r552eH3wR48zFpASfj/LO
	P6Th2/+UbJMnyuflE6QjFmR4Npjt+Bc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-mkKBgdSvPEKEb4AIxGEj4w-1; Wed,
 28 Jan 2026 14:32:43 -0500
X-MC-Unique: mkKBgdSvPEKEb4AIxGEj4w-1
X-Mimecast-MFC-AGG-ID: mkKBgdSvPEKEb4AIxGEj4w_1769628761
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A23218005B8;
	Wed, 28 Jan 2026 19:32:41 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.80.171])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4746830001A2;
	Wed, 28 Jan 2026 19:32:38 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aleksei Oladko <aleksey.oladko@virtuozzo.com>,  "David S . Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  netdev@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,
 ovs-dev@openvswitch.org, Ilya Maximets <imaximet@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>, Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH v2 0/5] selftests: net: fix false failures due to
 missing features and host interference
In-Reply-To: <20260127184448.2976475f@kernel.org> (Jakub Kicinski's message of
	"Tue, 27 Jan 2026 18:44:48 -0800")
References: <20260127225134.304362-1-aleksey.oladko@virtuozzo.com>
	<20260127184448.2976475f@kernel.org>
Date: Wed, 28 Jan 2026 14:32:36 -0500
Message-ID: <f7t1pj9v8h7.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254429-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,centos9:email,pmtu.sh:url]
X-Rspamd-Queue-Id: BDB6BA82E9
X-Rspamd-Action: no action


Also CC'd Stefano, ovs-dev, Ilya, and Eelco

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 27 Jan 2026 22:51:29 +0000 Aleksei Oladko wrote:
>> This series addresses several issues in the networking kselftests
>> that cause false-positive failures depending on the host environment,
>> kernel configuration, or library versions.
>> 
>> The main focus of these changes is to isolate tests from the host
>> environment (using namespaces) and to ensure proper fallback or
>> skipping when dependencies are missing.
>> 
>> Summary of changes:
>> 1. Adds a check for cls_basic module in fib_tests. Without this
>>    module, the test fails when attempting to add tc rules instead
>>    of skipping.
>> 2. Fixes ovs-dpctl.py to return a non-zero exit code when pyroute2
>>    is too old. This allows pmtu.sh to correctly fall back to ovs-vsctl
>>    instead of assuming the configuration was successful.
>> 3,4. Move reuseport and pmtu.sh tests info dedicated network namespaces.
>>    This prevents failures caused by port conflicts with host processes
>>    or interference from host firewall rules.
>> 5. Ensures io_uring is enabled via sysctl before running io_uring_zerocopy
>>    test, preventing failures on systems where kernel.io_uring_disabled
>>    is set.
>
> Something in this series breaks the pmtu test for us in the CI:
>
> # 64.84 [+2.54] TEST: IPv6, bridged geneve6: PMTU exceptions - nexthop objects      [ OK ]
> # 65.73 [+0.89]   ovs_bridge not supported
> # 65.73 [+0.00] TEST: IPv4, OVS vxlan4: PMTU exceptions                             [SKIP]
> # 67.20 [+1.47]   ovs_bridge not supported
> # 67.20 [+0.00] TEST: IPv6, OVS vxlan4: PMTU exceptions                             [SKIP]
> # 68.66 [+1.45]   ovs_bridge not supported
> # 68.66 [+0.00] TEST: IPv4, OVS vxlan6: PMTU exceptions                             [SKIP]
> # 70.11 [+1.45]   ovs_bridge not supported
> # 70.11 [+0.00] TEST: IPv6, OVS vxlan6: PMTU exceptions                             [SKIP]
> # 71.57 [+1.45]   ovs_bridge not supported
> # 71.57 [+0.00] TEST: IPv4, OVS geneve4: PMTU exceptions                            [SKIP]
> # 73.01 [+1.44]   ovs_bridge not supported
> # 73.01 [+0.00] TEST: IPv6, OVS geneve4: PMTU exceptions                            [SKIP]
> # 74.46 [+1.45]   ovs_bridge not supported
> # 74.46 [+0.00] TEST: IPv4, OVS geneve6: PMTU exceptions                            [SKIP]
> # 75.92 [+1.46]   ovs_bridge not supported
> # 75.93 [+0.00] TEST: IPv6, OVS geneve6: PMTU exceptions                            [SKIP]
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/492641/137-pmtu-wrapper-sh/stdout
>
> It was fine before:
>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/492461/6-pmtu-sh/stdout
>
> Since this is a bash test there are of course no logs to go by.. :/

FYI- we can run the script with '-v' and it will include all of the
command output.  That could help understand what is going on if you can
duplicate the [SKIP] behavior in another environment.  I'll try to get
my vmtest environment back up for it.

> I tried running 
>  python tools/testing/selftests/net/openvswitch/ovs-dpctl.py add-dp br0
> in a netns and that works just fine. 

Yes, I tested just changing the ovs-dpctl.py side (no other changes to
pmtu.sh), and then tried with older pyroute2, no pyroute2, and no
ovs-vswitchd userspace to fall back on, and didn't see anything odd on
my end.  I am still nervous that maybe the test is/was passing even in
cases where it shouldn't be.

> No idea what's going on..

+1, the setup_ovs_bridge seems to be returning some kind of error.

NOTE that I was concerned maybe the test would be passing whether or not
the ovs-dpctl was returning '0' (from change 2/5), but I see the
following when I fake out the version check:

========== 8< ===========

[core@centos9 net]$ sudo ./pmtu.sh -v pmtu_ipv4_ovs_vxlan4_exception

##########################################################################

    COMMAND: python3 ./openvswitch/ovs-dpctl.py add-dp ovs_br0
    Need to upgrade the python pyroute2 package to >= 0.6.

    COMMAND: ip link set ovs_br0 up
    Cannot find device "ovs_br0"

    COMMAND: ip netns exec ns_c-VCOwRt ip link add veth_C-A type veth peer name veth_A-C
    COMMAND: ip netns exec ns_c-VCOwRt ip link set veth_A-C netns 1
    COMMAND: ip link set veth_A-C up
    COMMAND: ip netns exec ns_c-VCOwRt ip link set veth_C-A up
    COMMAND: ip netns exec ns_c-VCOwRt ip addr add 192.168.2.10/24 dev veth_C-A
    COMMAND: ip netns exec ns_c-VCOwRt ip addr add fd00:2::c/64 dev veth_C-A
    COMMAND: python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 veth_A-C
    Need to upgrade the python pyroute2 package to >= 0.6.

    COMMAND: ip netns exec ns_a-kmNqnY ip link set veth_A-R1 netns 1
    COMMAND: ip addr add 10.0.1.1/24 dev veth_A-R1
    COMMAND: ip addr add fc00:1::1/64 dev veth_A-R1
    COMMAND: ip link set veth_A-R1 up
    COMMAND: ip route add 10.0.3.1 via 10.0.1.2
    COMMAND: ip route add fc00:3::1 via fc00:1::2
    COMMAND: python3 ./openvswitch/ovs-dpctl.py add-if ovs_br0 vxlan_a -t vxlan
    Need to upgrade the python pyroute2 package to >= 0.6.

    COMMAND: python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 recirc_id(0),in_port(),eth(),eth_type(0x0800),ipv4() set(tunnel(tun_id=1,dst=10.0.3.1,ttl=64,tp_dst=4789,flags(df|csum))),
    Need to upgrade the python pyroute2 package to >= 0.6.

    COMMAND: python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 recirc_id(0),in_port(),eth(),eth_type(0x86dd),ipv6() set(tunnel(tun_id=1,dst=10.0.3.1,ttl=64,tp_dst=4789,flags(df|csum))),
    Need to upgrade the python pyroute2 package to >= 0.6.

    COMMAND: python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 recirc_id(0),tunnel(tun_id=1,src=10.0.3.1,dst=10.0.1.1),in_port(),eth(),eth_type(0x0800),ipv4() 
    Need to upgrade the python pyroute2 package to >= 0.6.

    COMMAND: python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 recirc_id(0),tunnel(tun_id=1,src=10.0.3.1,dst=10.0.1.1),in_port(),eth(),eth_type(0x86dd),ipv6() 
    Need to upgrade the python pyroute2 package to >= 0.6.

    COMMAND: python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 recirc_id(0),tunnel(tun_id=1,src=10.0.3.1,dst=10.0.1.1),in_port(),eth(),eth_type(0x0806),arp() 
    Need to upgrade the python pyroute2 package to >= 0.6.

    COMMAND: python3 ./openvswitch/ovs-dpctl.py add-flow ovs_br0 recirc_id(0),in_port(),eth(),eth_type(0x0806),arp(sip=192.168.2.10,tip=192.168.2.2) set(tunnel(tun_id=1,dst=10.0.3.1,ttl=64,tp_dst=4789,flags(df|csum))),
    Need to upgrade the python pyroute2 package to >= 0.6.

    COMMAND: ip netns exec ns_b-gO9WCK ip link add vxlan_b type vxlan id 1 local 10.0.3.1 remote 10.0.1.1 ttl 64 dstport 4789
    COMMAND: ip netns exec ns_b-gO9WCK ip addr add 192.168.2.2/24 dev vxlan_b
    COMMAND: ip netns exec ns_b-gO9WCK ip addr add fd00:2::b/64 dev vxlan_b
    COMMAND: ip link set vxlan_a up
    Cannot find device "vxlan_a"

    COMMAND: ip netns exec ns_b-gO9WCK ip link set vxlan_b up
Cannot find device "ovs_br0"
    COMMAND: ip netns exec ns_c-VCOwRt ping -q -M want -i 0.1 -c 20 -s 4500 192.168.2.2
    PING 192.168.2.2 (192.168.2.2) 4500(4528) bytes of data.

--- 192.168.2.2 ping statistics ---
20 packets transmitted, 0 received, +20 errors, 100% packet loss, time 12790ms
pipe 4

TEST: IPv4, OVS vxlan4: PMTU exceptions                             [FAIL]


