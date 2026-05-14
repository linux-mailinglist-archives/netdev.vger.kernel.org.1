Return-Path: <netdev+bounces-288046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OUYBvz9BWrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:53:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F24D544F53
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF94530393B2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7433A007;
	Thu, 14 May 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUu0u3Y9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B83176E0
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777521; cv=none; b=lAIO6XBYdba/n+2D0kF7+gPCF03LPOgi8z6RFkCihtnppR3WBckV6FgY92QghsdB4exutR3y+L0S9F2tB2ELjOuJ7fsQKON+8NRfjBVH6hD7PDFtaxdlgdzALlOyN8ypI8GLIj2MapnWUnEzsD8L8Sd/O4R+g/yCnIW/ak0DgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777521; c=relaxed/simple;
	bh=VWpmt7ZBipt2gqkQ22zGchyfxEm1SG+l/GA+JXxNTFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHmJpKV9dXyS3awVwkR0sExO3TwQkhryK+qzm6UGh/sYquHsEhdZMUOBvwYjwNz/r6nAHhSuNnGBVczsXOOz3+F+Lynsrw8G9IFsoLSS5NjfHkm+uft8dGTqAM93zhYtagEE4dTlJv8xRsUWUWMk3gUSNSiCCh8vDTskx4vHyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUu0u3Y9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bcf48850c4so29762805ad.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777519; x=1779382319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLkhEyS3YOk/ybEPnJJKQINlNol+OlnMGeyHoaMKMO0=;
        b=QUu0u3Y9TYoomQ82R0gBkV9/ncxvxi39Ja03Fjh0kqbItDOH5STrklBxtcdORxiUTI
         WUB+SZDvDtuSPFiLZ4i3EYR4/qwJVQc3yHA1aWdoP+2pwHoaOS+Hse1RG1VPIzmliqJy
         IOXfvJI1AsPCihdzxTRLItQkRCxJ/bkDtWr4l/Ndi/266DF7LCoM0d0vTY9MLNuxSTi8
         lG70Bpb1I1FJHq2vVF/f228i+r6MXza31suupl6EiLzmqzV1S4//FKmagS/uNfCYPXaQ
         U5lD3yBADSLFY3ocS1yrffaosJrCFKAQj1AV4wBdJPfWMq516P1F5JuRx10bU8iSXmqJ
         YMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777519; x=1779382319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLkhEyS3YOk/ybEPnJJKQINlNol+OlnMGeyHoaMKMO0=;
        b=hLWRr2o/sM127xH3fVrshUQDx0vfz9ye0tz826qyRlXbl8v2WPsdAwjH7MszSEXap8
         j7Oyjfkd6kIVohCbCr0jNTNn12/HwAtxUjgtSXd3HQyNWw01uwRQwra9K5/jDTrgH/wg
         au01aDz0lxCcjDPN2pLPKiL5dJoxtsY9ZaFpn1wBf12s0ysUjS6APL5Su29mcyGSNz70
         HG2b29oZCnBzIHffH1/Krdo7ov5F1qj9JdoNCylcoex6AetDdjiWmiiJiLJNPmg4p8Ch
         XQYTnaI+5rl4n7vFmcME9umHxoDMeTAwgwT5kNHLcpJSa8XOWrS0NilVeMbaeHAjtv1k
         hPRA==
X-Gm-Message-State: AOJu0Yy05UW87p67j4C9ICZkxntmFal0wTz6Lwk0kSrGnsmNNwMWb70L
	84DmXCnhbcMAZIdLN92T+guyGDNq0Tw5y3HOvJmBo+xyQ2Jgvu4UgCqIxCIwYjyTDgs=
X-Gm-Gg: Acq92OFwgDtP3CUoWZjh3wfcKYDa3JAAUI1AOK/3/kWpmMqqtPYouykvxJNhtHxo8p3
	FOStzZE7pzaDlMzg+eOnT19UJYM3rYbHD7FxYCVQ3ubaZ+OfX+08Y8+tp+lmAZ9tsCpU41J3J9J
	FQGeKU5wuN8qOZrowR+MjdvgoH+FCoQVbdHx9Fe0xXZ24P0uYripDm4bB+BwWoGpaygjeEs7hRb
	1YrL6kBEuYUvBkbSE7Z9ixX3MephpcEFSg8uk8lTk9xCjF7CQPRT6Z80JFZxyo9GmtpS9EoPrP8
	a+Q87+1TWeVgcG2F5Km/bBWS51eP+ZAvp23IDllv8h0whAzyYZHoHVEUx/cccf4i8pxiWrBlCjz
	ThZPiShFqVwoM0O5htOCpuxUZuXL7m2DfdVBlXMn1XJHjoLsADraARc6g4XTs/3eXybeyxfr3OP
	FtlIw2JZSiuRnZXO4l11ln/XvskFk8NA==
X-Received: by 2002:a17:902:a618:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2bd7e9399f5mr2829825ad.35.1778777519198;
        Thu, 14 May 2026 09:51:59 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:51:58 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/4] ipv4: ipmr: clamp ip_hdrlen against skb_headlen in ipmr_cache_report
Date: Fri, 15 May 2026 00:51:32 +0800
Message-ID: <20260514165139.436961-3-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F24D544F53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-288046-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ipmr_cache_report() copies ip_hdrlen(pkt) bytes from pkt->data into
a freshly allocated 128-byte skb that is delivered to userspace via
the mrouted IGMP raw socket and via igmpmsg_netlink_event:

  const int ihl = ip_hdrlen(pkt);
  ...
  skb_put(skb, ihl);
  skb_copy_to_linear_data(skb, pkt->data, ihl);

ip_rcv_core() validates iph->ihl and pskb_may_pull()s ihl*4 bytes at
parse time.  An nftables PRE_ROUTING payload write reachable from an
unprivileged user namespace can flip the ihl nibble from 5 to 15
between parse and ipmr_cache_report().  When the original skb is
non-linear (received via a NIC driver that uses paged frags), only
the parse-time ihl*4 = 20 bytes are in the linear region; the
consumer copies 60 bytes, and the extra 40 bytes are read from
skb_shared_info or adjacent slab memory and queued back to userspace,
a kernel heap-content infoleak.  PoC observation: recvfrom on the
mroute socket returns 28 bytes without mutation, 68 bytes with
mutation (40 extra bytes leaked).

Clamp ihl against skb_headlen(pkt) so only bytes actually present
in the linear region are copied.

Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/ipv4/ipmr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 2628cd3a93a68..b40f3dd8f650f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1056,7 +1056,7 @@ static void ipmr_cache_resolve(struct net *net, struct mr_table *mrt,
 static int ipmr_cache_report(const struct mr_table *mrt,
 			     struct sk_buff *pkt, vifi_t vifi, int assert)
 {
-	const int ihl = ip_hdrlen(pkt);
+	const int ihl = min_t(int, ip_hdrlen(pkt), skb_headlen(pkt));
 	struct sock *mroute_sk;
 	struct igmphdr *igmp;
 	struct igmpmsg *msg;
-- 
2.47.3


