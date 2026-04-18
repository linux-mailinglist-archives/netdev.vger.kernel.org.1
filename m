Return-Path: <netdev+bounces-279492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OU++NfR142ndHAEAu9opvQ
	(envelope-from <netdev+bounces-279492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:15:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C942110B
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCA1302268C
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 12:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3195C223339;
	Sat, 18 Apr 2026 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VDo7tMu+"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CAC1DA23
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776514545; cv=none; b=IIwU9wjRe7+AZ0jfqlwMkM/NlC+yyJNHokcUW7SLuZCkaBcMddz0bk0f33ohzS3S+3geBihZJZQIRmpEMxZf9HveLWdzb2zjVAeGenFGmdfN8qdayWD6sW+PXWIlO76enLxN7L8vS14bEXviKp6f2kOPi/H+1LRjb+w8H8GJqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776514545; c=relaxed/simple;
	bh=JwwCzTX3TOOsUVMnPMu3rRbQHlUYi1+DCOGExEHy3ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nv3qMfSd8BCR/rKZgqt0yCwgwIOK/kwNtArBNxJvt7QpUT2Amy8fxjKq24tDV03RYERlGl0TNnZ7ssb4ft4M1812wfdy7MjMoIRHrjfhXjEzWumamLBPYoqLslDdmSaGAfrDHGT9W3kQLrDTVDGcfDF1YtpoCBkIAlfejkZLSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VDo7tMu+; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=vQNWbTYN4lTFAygcYFGbtOCc7bmiyhHMjAZv1nfhzeg=; b=VDo7tMu+Lui213NFTqyz8tZbUI
	T3jok9FnzZAwQGTLv0Z5RQ3fsqrPffBF9qMd2Nwz+9iFtIRz+QX4iwHz95DQ0bBj40QVL1uPAy9l5
	VapVUAOuu6EezSP3K4JezHo3wFFNal5MXcjnLyQgL9O4SPP7dbS+T3SgFlTn/SWChoq3rUREgez0T
	yXpLAzqdA+KyhQMwyMJ0ZyrpjQmOQX0xr/VuVThedJuYoWOJT+SkPVP/+V1jFEpL7V8C5C7IugaZ7
	X2By9Hm6V/RtR+2dvnpP++NtA3391EeAbb9eah0AQkXOBxv8ej7ltA0NZeNvZo4NbSIeoKpqo+/Wv
	vbtFWDKg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wE4aJ-00077V-2l;
	Sat, 18 Apr 2026 14:15:39 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: edumazet@google.com,
	dsahern@kernel.org,
	tom@herbertland.com,
	willemdebruijn.kernel@gmail.com,
	idosch@nvidia.com,
	pabeni@redhat.com,
	justin.iurman@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v2] ipv6: Apply max_dst_opts_cnt to ip6_tnl_parse_tlv_enc_lim
Date: Sat, 18 Apr 2026 14:15:38 +0200
Message-ID: <20260418121538.706095-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27975/Sat Apr 18 08:26:10 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279492-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email,iogearbox.net:dkim,iogearbox.net:mid]
X-Rspamd-Queue-Id: 2E3C942110B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and
Destination options") added net.ipv6.max_{hbh,dst}_opts_{cnt,len}
and applied them in ip6_parse_tlv(), the generic TLV walker
invoked from ipv6_destopt_rcv() and ipv6_parse_hopopts().

ip6_tnl_parse_tlv_enc_lim() does not go through ip6_parse_tlv();
it has its own hand-rolled TLV scanner inside its NEXTHDR_DEST
branch which looks for IPV6_TLV_TNL_ENCAP_LIMIT. That inner
loop is bounded only by optlen, which can be up to 2048 bytes.
Stuffing the Destination Options header with 2046 Pad1 (type=0)
entries advances the scanner a single byte at a time, yielding
~2000 TLV iterations per extension header.

Reuse max_dst_opts_cnt to bound the TLV iterations, matching
the semantics from 47d3d7ac656a.

Fixes: 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination options")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1->v2:
   - Remove unlikely (Justin)
   - Use abs() given max_dst_opts_cnt's negative meaning (Justin)

 net/ipv6/ip6_tunnel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 907c6a2af331..0f50b7fcb24e 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -430,11 +430,16 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
 				break;
 		}
 		if (nexthdr == NEXTHDR_DEST) {
+			int tlv_max = abs(READ_ONCE(init_net.ipv6.sysctl.max_dst_opts_cnt));
+			int tlv_cnt = 0;
 			u16 i = 2;
 
 			while (1) {
 				struct ipv6_tlv_tnl_enc_lim *tel;
 
+				if (tlv_cnt++ >= tlv_max)
+					break;
+
 				/* No more room for encapsulation limit */
 				if (i + sizeof(*tel) > optlen)
 					break;
-- 
2.43.0


