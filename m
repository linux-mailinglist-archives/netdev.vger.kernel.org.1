Return-Path: <netdev+bounces-272588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFifJjiQxmlLLwUAu9opvQ
	(envelope-from <netdev+bounces-272588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:12:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09603345D33
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B50F130E83EB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB2D3F167E;
	Fri, 27 Mar 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Q+WaB8r0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377923F164F
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620436; cv=none; b=DdpbfXbDX/4PqKF41ihSb1z6QmRSulCA3uLzyKQm8ykFNEnzvPwX1ZlQGMRfS1n9WwBoq6+EMkp+C83h+ODP89GuDbzGOB0s20OsKQiY9f1NRXFOR8E93xhzPkH9oOzmxNjOnZ2zwi4WNcnW5KTi/C/HO7GG3KjaLf9S8vt0eQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620436; c=relaxed/simple;
	bh=/VZQSIIaDVDScyigIuO+P2vctNItqItPdPR6Fq+p+/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+1GDUoEr2E30h/3kEvK4q3Jmpy6taNc95jPmXPtu8cKYHqRp5olrFpovmOO1QMj6DbYohN8K24xhyX0uyWemLBWBMY0fx+DKFhBOBy9kgfcM8p0200zlCrPmnXduCumGuCaIqFmSPcCxQJClvVtlOp6Mn6UrEvvE+hIgJGpzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Q+WaB8r0; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4853a5ffc05so4207705e9.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774620433; x=1775225233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9s9Zv/q1okmHKomfEnO1RcQXEaBG17T9jlNGEWVyYo=;
        b=Q+WaB8r0fY59pf4VzYfgREXLrAzpRq/+qXrE5d3i5nQNO8KdkUuPH+lS4YIymLwEG0
         k+2F87bzCKC6jpN5DqkozOYzDjiNg9US6icsoaJt7+x+Ou/67CfmWUEV2EZkLPOr4yCk
         AbMLw+/XesdAq5W0GaLPGH9TE0R+ky+Ja1yh9PzsEzUAbxepkw0CGGnd+2GAYZSAh5AJ
         zMvd/TJPOvOUsWXo4AKSRlBnsB5z9WSegqI8FtjioRZJNr0cQ7Py/HoQsXDY8EApeE69
         qaDgzNL3RvHmd04SXxxxSSCRAd3JjwOUxafZfYgR0x4ziFA88j/MyPzKuAxAweFl0fx9
         nFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620433; x=1775225233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9s9Zv/q1okmHKomfEnO1RcQXEaBG17T9jlNGEWVyYo=;
        b=pkRUpLbINgwXz3qFwnewUmRaqYtXciindLCcZYLj7laKJ2g5a0JyUJQ8Wv4fvy/aeI
         fNJextCLzVCyleL4hQ8PwKP9p1fvSzJHEiCMKIt/ht7R6Ya8yp7/FyaPifJ3jvFSenAu
         8Sc7Vqsi3h2Isv6/2iPqTwVP7vnmjPs61GH10S4KiXa62EWB8z38Dq7gE25SVn1ChvNL
         yYXwvlw/EBGRwENVAEHHZKvrUdsE65PUwb5SHvKCsqGp1tkvECU1WVz1NGRqTp8UgMR1
         u0soA5FUqwo/4qK1Xcb4H0bxjLlgfswZ+bPLDSCk365gAzYRd2dpPiN8069rUx4E+Dqg
         vN3w==
X-Gm-Message-State: AOJu0YyWJVL5Bu/6sw27WT9X7JHuisNgzXylQURJm248DlWHk1+S+i4O
	CDFgXw7whkRtETZb6k9L3gbGiSha0CbWKH6MFiCM2MNuAiVkNU8hM/o+0eRDyVP8JYtDjK/gV7K
	nBuF/iKyARjfizAzU99YsyNUgawWfurXIQVWs
X-Gm-Gg: ATEYQzx+ojt//fMoE3Vj7d+uduLvgaJZoQpuhFHDhuZ8Zq0TE7dGx0QsffvCW+NZBYC
	9wAJDzOcDn7yekZ3p5dOtrCLNlF581TUU0KMo7sASX9Q1gCBSPWfKX9GEmqk1bZB706BG0gnTem
	mbcII8UdaToZifmfdAJVna1NRvcqZGDMcRGOK8FKidy0p3JYTLyPJ093CI6q9qngHiJmCD2VVde
	ApWZ7r7GWr68hnerRLpF8db0RMT077QraqpDIZEpDp0kV/TCE2WwAzX9HECYrotUfyit8P85cwv
	lPJiZvV+4GQuKVYskPaCI78LbbdP3iEdYNDO7lV8KTtTz4rw9VBN3e1n93wkEyfIhD4C9pTNDgM
	x3BqKX+NAGUVI86Kt6pqE9uSMbF9CX14+5HRBnzJmSwbxUb9XaZ4SLBZ8VYh8j3kPrdTh0WtZ+K
	sc
X-Received: by 2002:a05:600c:1f8d:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-48727d6fc1cmr28004735e9.1.1774620432548;
        Fri, 27 Mar 2026 07:07:12 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-48722cc2803sm3917925e9.14.2026.03.27.07.07.12;
        Fri, 27 Mar 2026 07:07:12 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 64407205D2;
	Fri, 27 Mar 2026 15:07:12 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1w67qC-0041gD-4D; Fri, 27 Mar 2026 15:07:12 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v2] seg6: enable route leak for encap routes
Date: Fri, 27 Mar 2026 15:06:24 +0100
Message-ID: <20260327140709.959636-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272588-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[6wind.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 09603345D33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The goal is to support x-vrf route. To avoid breaking existing setup, a new
flag is introduced: nh-vrf.

The dev parameter is mandatory when a seg6 encap route is configured, but
before this commit, it is ignored/not used. After the srv6 encapsulation, a
second route lookup in the same vrf is performed.

The new nh-vrf flag specifies to use the vrf associated with the dev
parameter to perform this second route lookup.

The l3vpn tests show the inconsistency: the specified nexthop dev is
ignored and a second route is added in the same vrf for the segment address
(before the commit, the route to 'fc00:21:100::6046' was put in the vrf-100
table while the encap route was pointing to veth0, which is not associated
with a vrf).

The tests are updated to use the nh-vrf flag when available.

Before:
> $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] dev veth0 metric 1024 pref medium
> fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium

After:
> $ ip -n rt_2-Rh5GP7 -6 r list vrf vrf-100 | grep fc00:21:100::6046
> cafe::1  encap seg6 mode encap segs 1 [ fc00:21:100::6046 ] nh-vrf dev veth0 metric 1024 pref medium
> $ ip -n rt_2-Rh5GP7 -6 r list | grep fc00:21:100::6046
> fc00:21:100::6046 via fd00::1 dev veth0 metric 1024 pref medium

Fixes: 6c8702c60b88 ("ipv6: sr: add support for SRH encapsulation and injection with lwtunnels")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---

v1 -> v2:
 - target net-next instead of net
 - add a new attribute to avoid breaking the legacy behavior
 - use dst_dev_rcu()

 include/uapi/linux/seg6_iptunnel.h            |  1 +
 net/ipv6/seg6_iptunnel.c                      | 23 ++++++++++--
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh | 35 +++++++++++++++++--
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh  | 33 +++++++++++++++--
 .../selftests/net/srv6_end_dt6_l3vpn_test.sh  | 33 +++++++++++++++--
 5 files changed, 116 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
index 485889b19900..d7d6aa2f72c5 100644
--- a/include/uapi/linux/seg6_iptunnel.h
+++ b/include/uapi/linux/seg6_iptunnel.h
@@ -21,6 +21,7 @@ enum {
 	SEG6_IPTUNNEL_UNSPEC,
 	SEG6_IPTUNNEL_SRH,
 	SEG6_IPTUNNEL_SRC,	/* struct in6_addr */
+	SEG6_IPTUNNEL_NH_VRF,
 	__SEG6_IPTUNNEL_MAX,
 };
 #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index e76cc0cc481e..f8c6f0d719be 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -50,6 +50,7 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
 struct seg6_lwt {
 	struct dst_cache cache;
 	struct in6_addr tunsrc;
+	bool nh_vrf;
 	struct seg6_iptunnel_encap tuninfo[];
 };
 
@@ -67,6 +68,7 @@ seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
 static const struct nla_policy seg6_iptunnel_policy[SEG6_IPTUNNEL_MAX + 1] = {
 	[SEG6_IPTUNNEL_SRH]	= { .type = NLA_BINARY },
 	[SEG6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[SEG6_IPTUNNEL_NH_VRF]	= { .type = NLA_FLAG },
 };
 
 static int nla_put_srh(struct sk_buff *skb, int attrtype,
@@ -499,9 +501,15 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	 * now and use it later as a comparison.
 	 */
 	lwtst = orig_dst->lwtstate;
-
 	slwt = seg6_lwt_lwtunnel(lwtst);
 
+	if (slwt->nh_vrf) {
+		rcu_read_lock();
+		skb->dev = l3mdev_master_dev_rcu(dst_dev_rcu(orig_dst)) ?:
+			dev_net(skb->dev)->loopback_dev;
+		rcu_read_unlock();
+	}
+
 	local_bh_disable();
 	dst = dst_cache_get(&slwt->cache);
 	local_bh_enable();
@@ -724,6 +732,7 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	if (err)
 		goto free_lwt_state;
 
+	slwt->nh_vrf = !!tb[SEG6_IPTUNNEL_NH_VRF];
 	memcpy(&slwt->tuninfo, tuninfo, tuninfo_len);
 
 	if (tb[SEG6_IPTUNNEL_SRC]) {
@@ -775,6 +784,10 @@ static int seg6_fill_encap_info(struct sk_buff *skb,
 	    nla_put_in6_addr(skb, SEG6_IPTUNNEL_SRC, &slwt->tunsrc))
 		return -EMSGSIZE;
 
+	if (slwt->nh_vrf &&
+	    nla_put_flag(skb, SEG6_IPTUNNEL_NH_VRF))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -786,9 +799,14 @@ static int seg6_encap_nlsize(struct lwtunnel_state *lwtstate)
 
 	nlsize = nla_total_size(SEG6_IPTUN_ENCAP_SIZE(tuninfo));
 
+	/* SEG6_IPTUNNEL_SRC */
 	if (!ipv6_addr_any(&slwt->tunsrc))
 		nlsize += nla_total_size(sizeof(slwt->tunsrc));
 
+	/* SEG6_IPTUNNEL_NH_VRF */
+	if (slwt->nh_vrf)
+		nlsize += nla_total_size(0);
+
 	return nlsize;
 }
 
@@ -803,7 +821,8 @@ static int seg6_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
 	if (len != SEG6_IPTUN_ENCAP_SIZE(b_hdr))
 		return 1;
 
-	if (!ipv6_addr_equal(&a_slwt->tunsrc, &b_slwt->tunsrc))
+	if (!ipv6_addr_equal(&a_slwt->tunsrc, &b_slwt->tunsrc) ||
+	    a_slwt->nh_vrf != b_slwt->nh_vrf)
 		return 1;
 
 	return memcmp(a_hdr, b_hdr, len);
diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
index a5e959a080bb..abf0a523518a 100755
--- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
@@ -201,6 +201,7 @@ readonly IPv6_HS_NETWORK=cafe
 readonly IPv4_HS_NETWORK=10.0.0
 readonly VPN_LOCATOR_SERVICE=fc00
 PING_TIMEOUT_SEC=4
+NH_VRF_FLAG=
 
 ret=0
 
@@ -319,6 +320,7 @@ setup_vpn_config()
 	local hsdst=$3
 	local rtdst=$4
 	local tid=$5
+	local vrf=
 
 	eval local rtsrc_name=\${rt_${rtsrc}}
 	eval local rtdst_name=\${rt_${rtdst}}
@@ -330,10 +332,11 @@ setup_vpn_config()
 	# set the encap route for encapsulating packets which arrive from the
 	# host hssrc and destined to the access router rtsrc.
 	ip -netns ${rtsrc_name} -6 route add ${IPv6_HS_NETWORK}::${hsdst}/128 vrf vrf-${tid} \
-		encap seg6 mode encap segs ${vpn_sid} dev veth0
+		encap seg6 mode encap segs ${vpn_sid} ${NH_VRF_FLAG} dev veth0
 	ip -netns ${rtsrc_name} -4 route add ${IPv4_HS_NETWORK}.${hsdst}/32 vrf vrf-${tid} \
-		encap seg6 mode encap segs ${vpn_sid} dev veth0
-	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 vrf vrf-${tid} \
+		encap seg6 mode encap segs ${vpn_sid} ${NH_VRF_FLAG} dev veth0
+	[ -z ${NH_VRF_FLAG} ] && vrf="vrf vrf-${tid}"
+	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 ${vrf} \
 		via fd00::${rtdst} dev veth0
 
 	# set the decap route for decapsulating packets which arrive from
@@ -536,6 +539,26 @@ host_vpn_isolation_tests()
 	done
 }
 
+# check if the nh-vrf flag is supported
+check_nh_vrf_support()
+{
+	setup_ns nh_vrf_ns
+
+	if ! ip -netns "${nh_vrf_ns}" nexthop add id 1235 encap seg6 \
+			mode encap nh-vrf segs 2001:db8:1:1:1::2 dev lo &>/dev/null; then
+		cleanup_ns "${nh_vrf_ns}"
+		return
+	fi
+
+	if ! ip -netns "${nh_vrf_ns}" nexthop get id 1235 &>/dev/null; then
+		cleanup_ns "${nh_vrf_ns}"
+		return
+	fi
+
+	cleanup_ns "${nh_vrf_ns}"
+	NH_VRF_FLAG="nh-vrf"
+}
+
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
 	exit $ksft_skip
@@ -554,6 +577,12 @@ fi
 
 cleanup &>/dev/null
 
+check_nh_vrf_support
+if [ -z ${NH_VRF_FLAG} ]; then
+	echo "nh-vrf support: no"
+else
+	echo "nh-vrf support: yes"
+fi
 setup
 
 router_tests
diff --git a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
index a649dba3cb77..e1ae80bcb86d 100755
--- a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
@@ -170,6 +170,7 @@ readonly IPv6_RT_NETWORK=fd00
 readonly IPv4_HS_NETWORK=10.0.0
 readonly VPN_LOCATOR_SERVICE=fc00
 PING_TIMEOUT_SEC=4
+NH_VRF_FLAG=
 
 ret=0
 
@@ -278,6 +279,7 @@ setup_vpn_config()
 	local hsdst=$3
 	local rtdst=$4
 	local tid=$5
+	local vrf=
 
 	eval local rtsrc_name=\${rt_${rtsrc}}
 	eval local rtdst_name=\${rt_${rtdst}}
@@ -286,8 +288,9 @@ setup_vpn_config()
 	# set the encap route for encapsulating packets which arrive from the
 	# host hssrc and destined to the access router rtsrc.
 	ip -netns ${rtsrc_name} -4 route add ${IPv4_HS_NETWORK}.${hsdst}/32 vrf vrf-${tid} \
-		encap seg6 mode encap segs ${vpn_sid} dev veth0
-	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 vrf vrf-${tid} \
+		encap seg6 mode encap segs ${vpn_sid} ${NH_VRF_FLAG} dev veth0
+	[ -z ${NH_VRF_FLAG} ] && vrf="vrf vrf-${tid}"
+	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 ${vrf} \
 		via fd00::${rtdst} dev veth0
 
 	# set the decap route for decapsulating packets which arrive from
@@ -459,6 +462,26 @@ host_vpn_isolation_tests()
 	done
 }
 
+# check if the nh-vrf flag is supported
+check_nh_vrf_support()
+{
+	setup_ns nh_vrf_ns
+
+	if ! ip -netns "${nh_vrf_ns}" nexthop add id 1235 encap seg6 \
+			mode encap nh-vrf segs 2001:db8:1:1:1::2 dev lo &>/dev/null; then
+		cleanup_ns "${nh_vrf_ns}"
+		return
+	fi
+
+	if ! ip -netns "${nh_vrf_ns}" nexthop get id 1235 &>/dev/null; then
+		cleanup_ns "${nh_vrf_ns}"
+		return
+	fi
+
+	cleanup_ns "${nh_vrf_ns}"
+	NH_VRF_FLAG="nh-vrf"
+}
+
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
 	exit $ksft_skip
@@ -477,6 +500,12 @@ fi
 
 cleanup &>/dev/null
 
+check_nh_vrf_support
+if [ -z ${NH_VRF_FLAG} ]; then
+	echo "nh-vrf support: no"
+else
+	echo "nh-vrf support: yes"
+fi
 setup
 
 router_tests
diff --git a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
index e408406d8489..3a8ff96a78ef 100755
--- a/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt6_l3vpn_test.sh
@@ -171,6 +171,7 @@ readonly IPv6_RT_NETWORK=fd00
 readonly IPv6_HS_NETWORK=cafe
 readonly VPN_LOCATOR_SERVICE=fc00
 PING_TIMEOUT_SEC=4
+NH_VRF_FLAG=
 
 ret=0
 
@@ -285,6 +286,7 @@ setup_vpn_config()
 	local hsdst=$3
 	local rtdst=$4
 	local tid=$5
+	local vrf=
 
 	eval local rtsrc_name=\${rt_${rtsrc}}
 	eval local rtdst_name=\${rt_${rtdst}}
@@ -296,8 +298,9 @@ setup_vpn_config()
 	# set the encap route for encapsulating packets which arrive from the
 	# host hssrc and destined to the access router rtsrc.
 	ip -netns ${rtsrc_name} -6 route add ${IPv6_HS_NETWORK}::${hsdst}/128 vrf vrf-${tid} \
-		encap seg6 mode encap segs ${vpn_sid} dev veth0
-	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 vrf vrf-${tid} \
+		encap seg6 mode encap segs ${vpn_sid} ${NH_VRF_FLAG} dev veth0
+	[ -z ${NH_VRF_FLAG} ] && vrf="vrf vrf-${tid}"
+	ip -netns ${rtsrc_name} -6 route add ${vpn_sid}/128 ${vrf} \
 		via fd00::${rtdst} dev veth0
 
 	# set the decap route for decapsulating packets which arrive from
@@ -469,6 +472,26 @@ host_vpn_isolation_tests()
 	done
 }
 
+# check if the nh-vrf flag is supported
+check_nh_vrf_support()
+{
+	setup_ns nh_vrf_ns
+
+	if ! ip -netns "${nh_vrf_ns}" nexthop add id 1235 encap seg6 \
+			mode encap nh-vrf segs 2001:db8:1:1:1::2 dev lo &>/dev/null; then
+		cleanup_ns "${nh_vrf_ns}"
+		return
+	fi
+
+	if ! ip -netns "${nh_vrf_ns}" nexthop get id 1235 &>/dev/null; then
+		cleanup_ns "${nh_vrf_ns}"
+		return
+	fi
+
+	cleanup_ns "${nh_vrf_ns}"
+	NH_VRF_FLAG="nh-vrf"
+}
+
 if [ "$(id -u)" -ne 0 ];then
 	echo "SKIP: Need root privileges"
 	exit $ksft_skip
@@ -487,6 +510,12 @@ fi
 
 cleanup &>/dev/null
 
+check_nh_vrf_support
+if [ -z ${NH_VRF_FLAG} ]; then
+	echo "nh-vrf support: no"
+else
+	echo "nh-vrf support: yes"
+fi
 setup
 
 router_tests
-- 
2.52.0


