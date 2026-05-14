Return-Path: <netdev+bounces-288045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOq/Oq79BWrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:51:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0F544F08
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17AAF300E153
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C0E3370FF;
	Thu, 14 May 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4x7wlSD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68672D238A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777515; cv=none; b=b1qq/14aHPwi+t4fxnEhBD8rHrHJm1ubTEgoCW7I1lQcG4hBrs7+zkKT1PXLH6zS6xhsT40rF2A67qkjs80qOEDYnh0I0TVwbE38PvwDaRN+ILVfTYhFG6QPFfx/VUP4jftTt9VeUt6CSyVJeXMvRsDGO4HyPeUrwl2UFAVqlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777515; c=relaxed/simple;
	bh=xaDJ6AhrGPsK6Co3K1k8EdNzGxNV+cBSK5nP6nfNhss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvAQqTm+4KG+X6cNxCpGzyehphD8ifakOAI0qfhpW4CEo+c2DDKdbDHW4MuMI9awyE/prkzu4MRE/c+LyUAHCCS+xuLwYujAlA9riyhuaHe01NTFvX8uezytfIWBIwPJ9XLO52phyDe2bVMNqaEEYYPb9gJGEYy9lLq+jFvdnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4x7wlSD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2babfd18435so41996505ad.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778777513; x=1779382313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDjribekpIomxI3HWRnZ6Olveu3FkT0qRUsHGP8CKgU=;
        b=F4x7wlSDyeiaJvXQbAP7F9XUi0vBKz9AkN9ORWP5acaXAy/K5ftR7fZo07po4MnkjE
         Wi6Q6vFFm8zW1PvGFPVXD3nDkQ8TiwZ6eZ/bMlpUSRYUviyxUMr0wyqZndIHM4ToaKph
         ONqxwJCnXN8oqY7s4zMN1FmC+3ru68QHZRXh+wz22pAedh73nlEyZqcijivKQiqN9mTh
         3KBjJKpLFMZ5YmYB4DNy8AQ8LcOvz76GyLNe3RHe6LK186fvI5A0RYs+GVVOQUrQvMSy
         wOuGC8MzKPkSeAWX61q5mE9632Mfj4lS8T4n/Kd3jgRb7psOtTn58dC9gZ1AFIGlv28A
         vlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778777513; x=1779382313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDjribekpIomxI3HWRnZ6Olveu3FkT0qRUsHGP8CKgU=;
        b=Ot6a88JEQXOI0tSVY/NAhx1Q9CG2Jq+jQTvrWoNerMRpXjLxoxc2BFjWwNPNe4jdzk
         nTdXcko3+q2SfxdtiPrn4ZVocFEtr92F9pUqwpovTtXriWS2/YeJvOnVHU0laYt3drrP
         MIwLDSGk59q0X7Vz5wVmo0KcJIGEfHNbOKABXwl51tD8arhjIsLtk6/brg34Vlngv/uY
         8exo2EO2YJlojJx4wtOPvAPDO/l/7ygs98KaHQMzRVH98ZFy/Y+GLRYEpvYmsdNQ8GOY
         V9TjOYybOkbhmxifqhvelBe2x8lpX7efXYSSt8Tk661sriieM3diILF+IqR8N0zj8Xb9
         CpXg==
X-Gm-Message-State: AOJu0YxOJMghDLYUdO//0vKY+D+0s91dM03WZ4EL8OETNkIGheqqdgU+
	IH5lkkA1kAswIUxlGNasRu4quZuMUQbqt42JiT6ansJGCRtmtyAz0Qum
X-Gm-Gg: Acq92OHIBc+c3kTzrSbNUA9lI3L6fFsHquPWnfHJHe+bnJ85NTUdXrElY1lF/rcDKeX
	T0Nu19T6yzx++2HZtZ0C59rbf+IhWN5G3tfcVk4ZfgWpNPqsVpaWrIkIxOzY7YqEKId3lUJQmBQ
	Il0LyruGjRuiKSyY4o151ecTXuEEN4YcGqcCtQGyMvbpi83i9PhGP0IGEs6URbsWM75ilN3sA3m
	r+FYPQNSKQV3a8cZ5Rogt9/YcZlxmwbEpMplo/6NPf319fkULlM/LKSXsi0o5wxUmTJz92+atBp
	n0L9aCfE6WY1O0njixg84dqIngypvNULMvA0+xmAjvhkkLLdOIPPXwNKTxVe3i+nS2dW9GGOwMB
	nySuJVKDI6DBk1YPXhSS0XBLWA8kt6C65j5WUts1Tc0Lyu8XjveE1/McSzG+DG/WCHy77CkCuyy
	a0uHYq8/hxUx6h3FvkkYagLNDbEglM2A==
X-Received: by 2002:a17:903:2a87:b0:2ba:4eee:6c1e with SMTP id d9443c01a7336-2bd7e8214d5mr3623325ad.15.1778777513222;
        Thu, 14 May 2026 09:51:53 -0700 (PDT)
Received: from Tplus.localdomain ([114.243.117.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c2631basm27937825ad.34.2026.05.14.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 09:51:52 -0700 (PDT)
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
Subject: [PATCH net 1/4] ipv4: validate ip_options length in __ip_options_echo() against skb tail
Date: Fri, 15 May 2026 00:51:31 +0800
Message-ID: <20260514165139.436961-2-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65C0F544F08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-288045-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


