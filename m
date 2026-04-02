Return-Path: <netdev+bounces-274619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGf2H2+TzmkbogYAu9opvQ
	(envelope-from <netdev+bounces-274619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:03:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2B238B9E7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34CDF3012CD6
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D303C2FFF8F;
	Thu,  2 Apr 2026 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE9GK/fn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351F1E0B9C
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145729; cv=none; b=RJLaVccYL43qyZU6dXRhmrNZkbGbdLHxuXd9JbtpHNkixF/paDxiFZRLipZ8kLAFOLfBUWDTBzhrK+50vkMYicekRBzfSqqOIC3VjM0p0fNqCkXPiqWaJS8tZ0rios2OwsbRCBJcINqoB3WAX5wypp+Oh2sWBTF1VqyWAgnLKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145729; c=relaxed/simple;
	bh=RynrkmsPjBrTKAylfOdaBo5j7TR9XNO11d/bf45huAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9cFKXgVPVYyUFtDxtarwIANVf6wmnzYD2dBLOCcCWFaogvg6ax8Y/0iFBpmzz0e9GlXv8yqqxXqYJV9lVj5MvU3d3M+s2sPs2cBGxGNpdDHHBUKbBSIDQYjrDNkEzDAbDp3PwXOn2+wjTAyDpuroJ/1wsIzWESrmRPNOM1OP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE9GK/fn; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6b0500e06so1565837eec.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775145728; x=1775750528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VErXaAocdlc5UgqhS/sNUrt7vWuZgzHMcDW3jehfG04=;
        b=iE9GK/fnyNItTaCDNKiQpRPgDKN37dpBO4uaNpsZ1gGQn53SvUDJTPysGmXq773Vvl
         oEHMqiH5k1+a6buVzzKEV4pQAORlyHOt9rSwf768Rs0FkFG4k8wlgiZuhnxaDnW9xTXV
         AX3SWrwnH73gAk1mU+3WxQtbLOg/hEZy+DEMDMewfBHKOhFKE0jmtu5JazuxUIFMDUKX
         PQHDx7dBA8EgvZbPU+0X/upvIJTC/9xqz+yPTQW2bcTw6luoQU9+/r5K0egCPjufVxcA
         PkgyRQWjnPlI+1m3VNHxFDgqHQ4ULpmSxEEx9p8BbDPSfhHUyBZKfzErQlYQu2mJeljk
         iPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775145728; x=1775750528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VErXaAocdlc5UgqhS/sNUrt7vWuZgzHMcDW3jehfG04=;
        b=XgBejyQPvdRydDXvWe9+wFbwbZjC//cqnso3mrlfWTsTGBWaGy3n9MNIYgleK7GwXv
         7Pz+0mOzdhUPpGXVseNrqlXrrIX894tQ09eM/XQh9E2+EyMw8BaSd5H+lCGxtzRF/qGq
         9ofFW6MKnUQclUw8ZY4USpVXSXoInHQaO9omMzuX5uVYoMVWccFOVIhnVWKS24Y8RSOH
         YgQYiuQQWihEVinDOj03oSnr3OUA0Qroy4Qxp+PighHN3nASvUYepBPeiR1FHFW5/3rV
         6z32ZUoyTTUEksvy8q3g1z90oRN222reNPDCA6OVInvB+FvIm3W+pF90UiqL6XTrJNOj
         1ZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKbAcowpab4ElxPskaw+WUpw17+tCax/h6napRJpHXUVgP6H4RCTm18WKgSVF2r+dF/oyTp80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFA82dz5A1ybx+Pc8Q1IbKmXUu45+UbPs6ozWLx9X5aKdlEuV5
	eDQoX6RakI7/zBm9XpxZTsL470/wUzmqdCs4PwjjfxvTL6ZD2i9rtqkbiFTewvWwKtZgtg==
X-Gm-Gg: AeBDiesBl8u4iQaa8V3qO1YdRwS35SSi2vAFwfK6IG62pkrJ0O6O6AuUgcHXhs9z15h
	SZSJLTt0Pj0A/na25GezRQ2A76qSNkgegfXNGjFpScC6zg8Lk9mUoONYL2SA/MU+2a4FVu9Mrjc
	UZ/UQfq26ndsjClnTwn9tEdbI4ISwlu68AOjHgUktEoPWsC7LnyxWusB8E5t7TW4SR5O49fcGyV
	fjU8xvT0bb1JB5K05z3NvacEIsgGITIsFoQbSB5N/0XaBUf1LljnUijjZRwVmPMbROeLX4KIe0X
	zAIR3nj92ZE9ZBN1vNot8nRgh6Wcr/gBNa7Jxrgc4fWxKAZfkFkr5PDj2nBT/5jQbFPAnTHlpSm
	39dpHDGFw8+8HSrZHPpshIK7Ms/pEdLPAGpVtyJxnYk/WiAFUp5L9wpT9WO28/zsuFhrmJ7YDMl
	an4IOMW2XFJpLXF1Fx+K9gGQJ9y9sTdRPAJBEU9bHVg02fKCYT57eIPCXRzaSK0gbFfKl/iDunf
	aK3yvI+vK419TrSZVuh2sqCip4WmXNONj5UXfYDuPzhL3b3MhPH6rZYUeZPVIoFDRs=
X-Received: by 2002:a05:7300:fd8b:b0:2c0:f15a:ecbc with SMTP id 5a478bee46e88-2ca8fd69069mr1912965eec.33.1775145727172;
        Thu, 02 Apr 2026 09:02:07 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3c11sm2835293eec.4.2026.04.02.09.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:02:06 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf-next v3] bpf: reject short IPv4/IPv6 inputs in bpf_prog_test_run_skb
Date: Fri,  3 Apr 2026 00:01:47 +0800
Message-ID: <20260402160147.215499-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-274619-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: EF2B238B9E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bpf_prog_test_run_skb() calls eth_type_trans() first and then uses
skb->protocol to initialize sk family and address fields for the test
run.

For IPv4 and IPv6 packets, it may access ip_hdr(skb) or ipv6_hdr(skb)
to initialize sk fields. Reject the input earlier if the Ethernet frame
carries IPv4/IPv6 EtherType but the L3 header is too short.

Fold the IPv4/IPv6 header length checks into the existing protocol
switch and return -EINVAL before accessing the network headers.

Also extend empty_skb selftests with ETH_HLEN-sized packets carrying
IPv4/IPv6 EtherType but no L3 header.

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
Changes in v3:
- Rework the fix by moving the checks into the existing protocol switch
  in bpf_prog_test_run_skb() instead of duplicating the switch.
- Add empty_skb selftests for ETH_HLEN-sized packets with IPv4/IPv6
  EtherType but no L3 header.
- Retarget to bpf-next.

Link: https://lore.kernel.org/bpf/20260329161751.1914272-1-sun.jian.kdev@gmail.com/

 net/bpf/test_run.c                            | 20 ++++++++-----
 .../selftests/bpf/prog_tests/empty_skb.c      | 29 +++++++++++++++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..300e2bfc5a62 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1120,19 +1120,23 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		sk->sk_family = AF_INET;
-		if (sizeof(struct iphdr) <= skb_headlen(skb)) {
-			sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
-			sk->sk_daddr = ip_hdr(skb)->daddr;
+		if (skb_headlen(skb) < sizeof(struct iphdr)) {
+			ret = -EINVAL;
+			goto out;
 		}
+		sk->sk_family = AF_INET;
+		sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
+		sk->sk_daddr = ip_hdr(skb)->daddr;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case htons(ETH_P_IPV6):
-		sk->sk_family = AF_INET6;
-		if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
-			sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
-			sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
+		if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
+			ret = -EINVAL;
+			goto out;
 		}
+		sk->sk_family = AF_INET6;
+		sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
+		sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
 		break;
 #endif
 	default:
diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
index 438583e1f2d1..d53567e9cd77 100644
--- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -12,6 +12,8 @@ void test_empty_skb(void)
 	struct bpf_program *prog;
 	char eth_hlen_pp[15];
 	char eth_hlen[14];
+	char ipv4_eth_hlen[14];
+	char ipv6_eth_hlen[14];
 	int veth_ifindex;
 	int ipip_ifindex;
 	int err;
@@ -46,6 +48,24 @@ void test_empty_skb(void)
 			.err = -EINVAL,
 		},
 
+		/* ETH_HLEN-sized packets with IPv4/IPv6 EtherType but
+		 * no L3 header are rejected.
+		 */
+		{
+			.msg = "veth short IPv4 ingress packet",
+			.data_in = ipv4_eth_hlen,
+			.data_size_in = sizeof(ipv4_eth_hlen),
+			.ifindex = &veth_ifindex,
+			.err = -EINVAL,
+		},
+		{
+			.msg = "veth short IPv6 ingress packet",
+			.data_in = ipv6_eth_hlen,
+			.data_size_in = sizeof(ipv6_eth_hlen),
+			.ifindex = &veth_ifindex,
+			.err = -EINVAL,
+		},
+
 		/* ETH_HLEN-sized packets:
 		 * - can not be redirected at LWT_XMIT
 		 * - can be redirected at TC to non-tunneling dest
@@ -108,6 +128,15 @@ void test_empty_skb(void)
 	SYS(out, "ip addr add 192.168.1.1/16 dev ipip0");
 	ipip_ifindex = if_nametoindex("ipip0");
 
+	memset(ipv4_eth_hlen, 0, sizeof(ipv4_eth_hlen));
+	memset(ipv6_eth_hlen, 0, sizeof(ipv6_eth_hlen));
+
+	ipv4_eth_hlen[12] = 0x08;
+	ipv4_eth_hlen[13] = 0x00;
+
+	ipv6_eth_hlen[12] = 0x86;
+	ipv6_eth_hlen[13] = 0xdd;
+
 	bpf_obj = empty_skb__open_and_load();
 	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
 		goto out;
-- 
2.43.0


