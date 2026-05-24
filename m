Return-Path: <netdev+bounces-291142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM93GE17Emom0AYAu9opvQ
	(envelope-from <netdev+bounces-291142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:15:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2F95C15AC
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 06:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFC073007B12
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CCB2EAD15;
	Sun, 24 May 2026 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+AMQ8qo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E02E424F
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779596097; cv=none; b=ePjQngDyyrKWEP+JBzWLzAob/yo6WIfTaY5hUA6yyqP3A+POs3H3CV1fHLKXcoaVORag9oLOIub+xmoezvuGYLeCXrWXLayqpZyEAM2H7g0yLihTPO3PqxMZ6XBROJRan/q1OPnKNi4RGX5PHIsBJCCAIxO9NKjtm90LXcG1wn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779596097; c=relaxed/simple;
	bh=YgI2gPl4MLzP4KQG5NupXPy88QrqCKWuCt4blC6SFFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg3TMHcFutQT3J1r/UayXlEOuQpWw5ejqoaPD4Ga4BgWZNw/aAI3ObCbR1L/2edtx9neeFy96i/LzmRlVTiqgAzn9c91aeyIBI8k6x4v6VUSWCyGBgr5JgrQfHpCmzLsdXpFI/dy/451TPQMcx4QVboviw+hj/hbmpT9KFOTKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+AMQ8qo; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f33ae12f97so4188657eec.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 21:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779596095; x=1780200895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivlok4ndZmHPhqapxzUmhTaSd6mo/gpBV2SOd+qOog4=;
        b=f+AMQ8qo1d0HP1AFYT4yMlDY0II+eVRiHn7DCFfbcxoT/Epz8gB5yoR4PIuYt8Zvvr
         rF45CAGXEXDB2+ExzgghLCZ51YUMOw3W15EGPHMtVTg/JjtDUm3QY+4ppDD73Ce0Atd9
         F87ugUHwe1f8ZCgF13FTGSOcShaEWFh96YpPX5zMfiuG5T3Yo0ARl6YO+P5e4C4hF+rH
         pPWafuucTkfcBrXT23M6jtTjy8a+iS22MB8YsZ6wpKmFA2oq2te6OcbrOFFcieQGcTYB
         Rtw5+2dKCj7M+ea5FVIsfRqO+r2dvHjoEPrqtPYCEsWxPnACbOePdiDfz6ESSkDFdEQ9
         k3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779596095; x=1780200895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ivlok4ndZmHPhqapxzUmhTaSd6mo/gpBV2SOd+qOog4=;
        b=oAB3tN+6e+wERXx1gqfjpnRmaMRJfLihiGAYTzP1lRqGdr9PwHn8g+kmWXmTsN+Eml
         GqZtagijvrsZjXJquZB4K04AjdpYZvV4I6V8uBOisrpbTynRXDEsjHm+8xq5rh/2syen
         2n5eNdDum3ivP+Siu12TARyqPHzkprahcHGA+J3Tb8IKNKkeLBi1jeXQrMwnrFpxfs/a
         y8iXSs3gbm90ASzcCtoMdDjhCTUMyFDaspchz3n2kEwkU2bWQ51+a0vfp2y0vEJEJooi
         Wh1ZJ67VtcgG6jq/yjOcyoEwxLVveeCy31Y+urDil+mDvvIkD5zaBoxymd57ERX2N2sZ
         +EVQ==
X-Gm-Message-State: AOJu0YzNWYOEQIRY44PQ0q1hMqY39rB7E6FifKfz4FdHnLXMWmWhY+/M
	uGMynvfP2u1NLxJSQ4sGt2ldKIJvoXUXmKMAWdRb0tfCSSienCIjzrNR
X-Gm-Gg: Acq92OFNsyUObC/Dh6ELKkrzaaFfovFqbV1n4yF+3ASobfDl3DrhTN+1kgiCw7cBgj2
	oQWsS2Zzah78Imhc9SF1KLzbuTvb5RSqAZa/T0PCEf/3PCUn6n107xuH1RE6YTvEM11zzUNcLQx
	xDdw+L+//GPK+r43rg7ljEIKMYN4Ul53M/TDkGH2T28nSzLPr/b8aANFdJpUjWeRW51JTsdC/oP
	teHXCHf2lXnn80y/+49fbGDHGmYZzVknl2+rTTIKiy+rOJPf/W/DuuBsW6yAIHE3qNB0TGvwhIP
	KG+vk+VBTLOIZtiKmAhlCYCUN2L1jUakEvlH8XKlLKVoIHigg7QQK1KYUT53wMJu2AfP4/iZEVT
	RvXf6FXAPw77LcGJcUfZ/ElTLNIi+L8dalQGIlpnjYfQmMIGLxRwUJohfm0qAyuwuY1ToaJzPhP
	nIveSsl62VaHZ6y5FVBxYdREmvWyu/vDw3VQ==
X-Received: by 2002:a05:7300:b54d:b0:2ea:b7a9:580d with SMTP id 5a478bee46e88-3044902c3damr4686514eec.9.1779596095211;
        Sat, 23 May 2026 21:14:55 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245d6aesm4522133eec.26.2026.05.23.21.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 21:14:54 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	fw@strlen.de,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 1/4] ipv4: validate ip_options length in __ip_options_echo() against skb tail
Date: Sun, 24 May 2026 12:14:35 +0800
Message-ID: <20260524041442.2432071-2-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524041442.2432071-1-tpluszz77@gmail.com>
References: <20260524041442.2432071-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,gmail.com,kernel.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291142-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4B2F95C15AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__ip_options_echo() re-reads each option length byte (RR/TS/SRR/CIPSO)
from skb->data when building the echoed options into a 40-byte
__data[] buffer.  __ip_options_compile() saved only the option offset
into IPCB(skb)->opt, not the length.  An nftables LOCAL_IN payload
write reachable from an unprivileged user namespace can mutate the
length byte between parse and recvmsg, turning a parse-time validated
7-byte option into a 255-byte read.

  unsigned char optbuf[sizeof(struct ip_options) + 40];
  /* in __ip_options_echo: */
  optlen = sptr[sopt->rr + 1];        /* re-read; nft can mutate */
  memcpy(dptr, sptr + sopt->rr, optlen); /* into 40-byte buffer */

The destination is a stack buffer in ip_cmsg_recv_retopts() and a
DEFINE_RAW_FLEX() buffer in icmp.c / ip_output.c sized
IP_OPTIONS_DATA_FIXED_SIZE (40).  KASAN reports a stack-out-of-bounds
write of size 255:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo+0x7fc/0x1310
  Write of size 255 at addr ffff88800a657950
   __asan_memcpy+0x3c/0x60
   __ip_options_echo+0x7fc/0x1310
   ip_cmsg_recv_offset+0x58b/0xd10
   udp_recvmsg+0x8da/0xc20
   ____sys_recvmsg+0x1b1/0x620

Validate that each re-read option length stays within
skb_tail_pointer(skb) before the memcpy.

Cc: stable@vger.kernel.org
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Tong Liu <lyutoon@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 net/ipv4/ip_options.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index be8815ce3ac24..1cc6096e6dd9d 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -91,6 +91,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 
 	if (sopt->rr) {
 		optlen  = sptr[sopt->rr+1];
+		if (sptr + sopt->rr + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		soffset = sptr[sopt->rr+2];
 		dopt->rr = dopt->optlen + sizeof(struct iphdr);
 		memcpy(dptr, sptr+sopt->rr, optlen);
@@ -105,6 +107,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 	}
 	if (sopt->ts) {
 		optlen = sptr[sopt->ts+1];
+		if (sptr + sopt->ts + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		soffset = sptr[sopt->ts+2];
 		dopt->ts = dopt->optlen + sizeof(struct iphdr);
 		memcpy(dptr, sptr+sopt->ts, optlen);
@@ -145,6 +149,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 		__be32 faddr;
 
 		optlen  = start[1];
+		if (start + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		soffset = start[2];
 		doffset = 0;
 		if (soffset > optlen)
@@ -174,6 +180,8 @@ int __ip_options_echo(struct net *net, struct ip_options *dopt,
 	}
 	if (sopt->cipso) {
 		optlen  = sptr[sopt->cipso+1];
+		if (sptr + sopt->cipso + optlen > skb_tail_pointer(skb))
+			return -EINVAL;
 		dopt->cipso = dopt->optlen+sizeof(struct iphdr);
 		memcpy(dptr, sptr+sopt->cipso, optlen);
 		dptr += optlen;
-- 
2.47.3


