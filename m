Return-Path: <netdev+bounces-257466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKPnFKt3hWngBwQAu9opvQ
	(envelope-from <netdev+bounces-257466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:10:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD872FA4B8
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 06:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCA663063B80
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 05:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97A33A9CF;
	Fri,  6 Feb 2026 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EdSBbsax"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA32459C9
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770354158; cv=none; b=cCnCpAd87qAIUH/dwpj4IfBF7SFG8xMwt8hZ0Kj2Ltgc6ZGM+WcuksT8/rl/t6qy0t2Kb6ZAoDgW5bmagCUB2LMod0CF5c+HR3j+4Gd/nRLThzutsQ7FYOv96yFWZ7YWAbYeKGHiUr81y22wE5vOeaD/xI66XQ4XA/LIBdRUXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770354158; c=relaxed/simple;
	bh=/3VHPhMfZjxQuCHW+zNeXKxUhTZMH3vDhteY8WCQL+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2Um9RIw8ZU+dEhkEvFknGFtHChk5FL6y/ynx+s3n81G3IpU9PgZRfeS6dx2v930dzilGYwtlOpqwSR0hrxLuw4rkPnYrgX/ik+wz11CDuGQ1A99Tq0EgWtOhWxtwpURw0qJxkUtawzSky8/BLK/GBWwqgU7S9aXJzD/8nbHmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EdSBbsax; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770354155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/E9bYcTpTNhHUI5bPdqFh/Okn31mO0JEye2h6D2+XOI=;
	b=EdSBbsaxhkYLrz+y/e4RhJVzjVP+8O6m6WcpdUD4DwgNxw23qInxCulh/UIxlNUUFhfGkC
	V+jFZpJAoig4Asebh9N6AYNxDwnOvUgMMzPcUzMEheToQTnP8bAO7lffrZDZL5ScsFSZdz
	+luQHmDTKOojH0plvvsGpsSEWy6eibo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] xfrm: fix ip_rt_bug race in icmp_route_lookup reverse path
Date: Fri,  6 Feb 2026 13:02:19 +0800
Message-ID: <20260206050220.59642-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-257466-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,e738404dcd14b620923c];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: BD872FA4B8
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

icmp_route_lookup() performs multiple route lookups to find a suitable
route for sending ICMP error messages, with special handling for XFRM
(IPsec) policies.

The lookup sequence is:
1. First, lookup output route for ICMP reply (dst = original src)
2. Pass through xfrm_lookup() for policy check
3. If blocked (-EPERM) or dst is not local, enter "reverse path"
4. In reverse path, call xfrm_decode_session_reverse() to get fl4_dec
   which reverses the original packet's flow (saddr<->daddr swapped)
5. If fl4_dec.saddr is local (we are the original destination), use
   __ip_route_output_key() for output route lookup
6. If fl4_dec.saddr is NOT local (we are a forwarding node), use
   ip_route_input() to simulate the reverse packet's input path
7. Finally, pass rt2 through xfrm_lookup() with XFRM_LOOKUP_ICMP flag

The bug occurs in step 6: ip_route_input() is called with fl4_dec.daddr
(original packet's source) as destination. If this address becomes local
between the initial check and ip_route_input() call (e.g., due to
concurrent "ip addr add"), ip_route_input() returns a LOCAL route with
dst.output set to ip_rt_bug.

This route is then used for ICMP output, causing dst_output() to call
ip_rt_bug(), triggering a WARN_ON:

 ------------[ cut here ]------------
 WARNING: net/ipv4/route.c:1275 at ip_rt_bug+0x21/0x30, CPU#1
 Call Trace:
  <TASK>
  ip_push_pending_frames+0x202/0x240
  icmp_push_reply+0x30d/0x430
  __icmp_send+0x1149/0x24f0
  ip_options_compile+0xa2/0xd0
  ip_rcv_finish_core+0x829/0x1950
  ip_rcv+0x2d7/0x420
  __netif_receive_skb_one_core+0x185/0x1f0
  netif_receive_skb+0x90/0x450
  tun_get_user+0x3413/0x3fb0
  tun_chr_write_iter+0xe4/0x220
  ...

Fix this by checking rt2->rt_type after ip_route_input(). If it's
RTN_LOCAL, the route cannot be used for output, so treat it as an error.

The reproducer requires kernel modification to widen the race window,
making it unsuitable as a selftest. It is available at:

  https://gist.github.com/mrpre/eae853b72ac6a750f5d45d64ddac1e81

Reported-by: syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000b1060905eada8881@google.com/T/
Closes: https://lore.kernel.org/r/20260128090523.356953-1-jiayuan.chen@linux.dev
Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
v3 -> v4:
    Don't break string literals across lines to fit 80 columns
    v3: https://lore.kernel.org/netdev/20260205070203.61560-1-jiayuan.chen@linux.dev/
v1 -> v3:
    Suggested by Paolo Abeni:
      - Resend it using net tree and using xfrm prefix
      - Fix text string over 80 chars limit.
      - Simplify commit message.
    v1: https://lore.kernel.org/r/20260128090523.356953-1-jiayuan.chen@linux.dev
    v2: https://lore.kernel.org/netdev/20260203063449.44737-1-jiayuan.chen@linux.dev/
---
 net/ipv4/icmp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 4abbec2f47ef..5559b9ae379a 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -554,6 +554,21 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		/* steal dst entry from skb_in, don't drop refcnt */
 		skb_dstref_steal(skb_in);
 		skb_dstref_restore(skb_in, orefdst);
+
+		/*
+		 * At this point, fl4_dec.daddr should NOT be local (we
+		 * checked fl4_dec.saddr above). However, a race condition
+		 * may occur if the address is added to the interface
+		 * concurrently. In that case, ip_route_input() returns a
+		 * LOCAL route with dst.output=ip_rt_bug, which must not
+		 * be used for output.
+		 */
+		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
+			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
+					     &fl4_dec.daddr, &fl4_dec.saddr);
+			dst_release(&rt2->dst);
+			err = -EINVAL;
+		}
 	}
 
 	if (err)
-- 
2.43.0


