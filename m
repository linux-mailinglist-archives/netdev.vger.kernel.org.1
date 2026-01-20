Return-Path: <netdev+bounces-251547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DalB+nDb2lsMQAAu9opvQ
	(envelope-from <netdev+bounces-251547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:05:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C349152
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63B4696D7D6
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787024508F2;
	Tue, 20 Jan 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jb4W1RYc"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-56.consmr.mail.ne1.yahoo.com (sonic313-56.consmr.mail.ne1.yahoo.com [66.163.185.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBD45BD4F
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926436; cv=none; b=UlGRPi+Mxs0or9MOqSCI2cXZEtxrUM/X6iTbNpntdmJLo9W53tcCDjvB11YiIO/gIuqjcejUNZ6OmRtGHaVR4LrByQBWm8Jr+VqHWr4ouzjdmtdY30sSLf47W9AD5FKFyHR9Q2g1xUfRAgqYTUpN7i0PX9S5gSNhvv//ufQJRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926436; c=relaxed/simple;
	bh=CuiTJOOmsW+aFYNMJm5VXa6RQE5Ls9xLs9QS3bXmUIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVpZ82bvX3RdeVrn2pZ1F7Acs+7NzMrSSouZrjrKLbGJy+3g//WYzOPJ3TSG4ATCD8bbwOKkwp4FNa/XbpldAzmpfkgxXImbsBerkpHQE2PSQUl/RRN3CLfJgaWCmw8QrlmWMzChVR+3RYWAKQsp6XflyCDOw9i7jlx0V/5R5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jb4W1RYc; arc=none smtp.client-ip=66.163.185.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926433; bh=9m60tMj2busabF/Oy+HOZ18Gf7Iev+cYqYon9NoGSWc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jb4W1RYcV0BmBElfMjEFpkCfuBdYC1PP7fZY3yN3mkT8tnxkeQLuMX1PmfZ0q2XGalttpDe1EHu/arc8sfATSScV2lPa3r2hvsi/ozq9c9YcTaGsY7IPu3WTT8EOv1VKONIFvawAqNezfn1I3rj90rqIA3AigA+ALnx7WGliQZLRYYFe64Nniup0TnzSsdarHIcanodd5D+guSo21NnXo2liuR7yJgNVTKKbvSta0hcStvleUbVHPHKFKaOHpYnFTlBsfhpm5YyAhUVBT47bcz6nLIe8EdCEGzEy5I2IeFD+g6qIeHpMjrLro10OhYcykzX7MGlOn0SrR8fv6XsYQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926433; bh=C1Ef5xXte4HHNI4vBWa2CpV3Y7anq0NXRgw0NI1zQvw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PH2ZXSlcV8yYxC4n8IT3zu9miRUUNnjGOPg4mqnb1Kd5fP0YRBqQ1U5OcC7H+WermVtgBu07rtIZ3E54bXIiCMtgISUQ0/eG1zfRCwkp6zkXPKja39ot74D6rKUy8ARlLC83X9kbd6MiQPrErvqwmr04agdTFdKQw9fXmqW7sy1vJfIU18t4o/snqG+jjMnDK1eNoGOroNGmFzBxDH1hIzG+IVga82ezgkwkufVWas7F0jV2bp91pq7WlKS5ycT9k4iAfbZ5yak7ztR7JitzKzE2LfLy8pxgtYR+NfFFBCUp8+ex64RZ0mJodKZHw1g34uSHEHetIqZER+cRt1CwVw==
X-YMail-OSG: IEZtBCIVM1mXzelPKsNFOpRtrDCpZUuKWSh3keo8veuwoTupvA4wzBVbbcq7nrW
 NFwLKB1I2msdZOLVDuXZQEuYdKFaD5UkyKTvVDo6dGwHv4DTap88zqdM6WDO4hu2A_0diY6kX9zK
 ZFapZ8vlXl7eCH54PWD0eaytw0Nsei6DnTIpm1FJwiSWJMgwr51X3GcUh8tIQO1a384b3BMukHXh
 udgOqmZ80p3hIni2Ank_4HIqpCIWDWor7luD4sPjhQl3ppNG0P4wIU83wcvRSVLF_592.oIYz1wp
 QNV3eRuepWVXu74pZU.h06MxG.Ou9as7qF_7q0NCnhMBuunY6.azBwT7GndV.OEGi.NuGmRVHweo
 soqid8MtS70a_Ibar7zWqYt4aDmDKTqiht73OdkZ6pYhifqnH1Yr9MvjoUn.ORAup2G4ZISjC6CF
 h8TvvAIIhGoRhR_wCkWSuAAa4PGdZuRxIOGh4JBAovof.gSAwWY2hIgSDNI.9uN.oIkKUdMnRdNy
 XwzgkqsGfWawHzK3689YpolqWU_WaFDWSwBk9oxtgYXezUwTdb.NcvWXwdI3IVrid.EuPZehkfzU
 enIIrUq8iw1GqcSMn85udA.wYE5gNrD8s.2RzKgAR3RoapbPLvPb9ezJLu_3zQ9PuyPAL0RmEpvJ
 HMYtWzliXv0FjSZeHfaE40RuMq.PIKK6cpVPnTrr9rpG1vw5_NCxVtpUUTW1.5jOXd7BreNwZZgC
 ifF5XYYnw8h4edgwCPr5uvM4Gu3hsHAQ28so3JVt84Z4iWc5Z_6reTA6pt7Ools7Uw9AhboUhAsv
 Q2qPhZU.QFOKxWRB9CI_AJUmI6.Y3tAFbWMvlz41Q7RpEpnIG204N9WRThybl3.q76HSgKKzFY1w
 wn7lELi1eePCEQ7WDikz6qgTZDK1pFWC8fDAGKKZPCnAULp.fMcGy92Ty6Bv0Edt9SY2IL4VSZbY
 _ZciThfmAL0WDJgxN_HHFVZVAIaWL8a1FsTO4ntuhX4mL9dJ18d0ToB3kHFTheQmJramd4Ln25sa
 KVhgVQoo9QgylpmdFsJSaAdCljgEVyrC_RL1m3EKU4xYUWgs4OwyjSUdu.dBqd2qdwT.kf7r5RB0
 _dLbXnSZOW8zFaBPKUFAAi.Nb9J5AkLcpGYkz5ttf_Hpal1rfUmS9xXXXTR4NRguyajWcBfsR3nN
 29Y7O5TfkG.BHF.1AFIZVghCtgQi2JpaOpZVPhb7THLOBJFlIUMv.NJo10Ys_fHWAFQgHpf6I9h4
 rfkci5b0cx.FQvVSOhPY36jAwEvSDMDCsMefwuj8fZjmYeeNiiYD07fLqrtXMi9H5CUIlIYvO3G0
 KHITrvbPtkCPQnplVSSNMaCLNkNPK2ST1FBgWtoIHRHEJtp7xSaZz9FqiYPP5EJZdWEkheq8PoYL
 XDx5ZB5Pd5rBhbp5EES6PcNyZCW4n4EirhHQnpdHvU1pww4n39sFdmZq3bRxo0CGOX7tbIWRM0qz
 srz3n9svwTyvlVvX0nh7yOW5GpBjdgAh2e4xZ7c9GFbLy0T_XU0eTKD3zvqzTYpBeAGxEtAQGhQH
 sOIXsBknOAkWnzdiCN9.FqFs40QORlG9jf4XrDbJfCYBProYFe3OSQ8noXQ1Jo3mcsd28b.iEe3G
 MgcrIsT6Md6zqkly1G57.Dso6hmJYWV_SaHyMBL9WhKS6MDS_xr0tPE6xcG9AsFWUgmQ0436wxV9
 ghsbNqAsjIlpkUehj5jaRrYVPBB__P7bJmsz0HcbHQg8vHXKZ_7Ibb.AQ896_LRk6VyOSBu3ouvb
 LrSp58NmLNfF3lpNg5nr8OUlBWLRMR_C2etvt_Xfn8bwlPccrxXWUBiHzihRqDzBLsc.HxsMI8Jc
 AHWinHgsas31p.1.03n48ltYdjiMiX3WKBKdo2p_JnLE1jnK_UOoDn3bcKqKCJS3znlVFkOzwBAV
 98cFZ2uEVOkf4weqbs3DdQ4ojtX5c6mLaSSOTshGtf7grUI_LkOgW27uG8q4X7Yl.Nf7Ev8OxXMu
 cikVnCo127jlzSLeDrvcv5LflW8OkKqWyxzOucFHcosWngpvybq4Rq2BnpWC.Ah8jSA8SEvWP793
 rdfxXh6UCCxYEThcpF.dy5.nkR2DdMHbCqgWs.Ch0y39MVBddib29AdoAnb_wqw2TdctXALME74s
 qApIDMAuGT7X7eqUm5Vm3fxt34fzAZadYftq5fWGj5zBGQTg-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: e0729ab3-8450-4459-b92f-0ffa9003c490
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:27:13 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:27:11 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 06/11] wireguard: socket: convert send{4,6} to use a noref dst when possible
Date: Tue, 20 Jan 2026 17:24:46 +0100
Message-ID: <20260120162451.23512-7-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120162451.23512-1-mmietus97@yahoo.com>
References: <20260120162451.23512-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251547-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[yahoo.com,reject];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7E1C349152
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

send{4,6} unnecessarily reference the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This is only possible in flows where the cache is used. Otherwise, we
fall-back to a referenced dst.

These changes are safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for the wireguard send{4,6} functions.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/wireguard/socket.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index ee7d9c675909..b311965269a1 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -46,7 +46,7 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 	fl.fl4_sport = inet_sk(sock)->inet_sport;
 
 	if (cache)
-		rt = dst_cache_get_ip4(cache, &fl.saddr);
+		rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
 
 	if (!rt) {
 		security_sk_classify_flow(sock, flowi4_to_flowi_common(&fl));
@@ -78,14 +78,15 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 			goto err;
 		}
 		if (cache)
-			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+			dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 	}
 
 	skb->ignore_df = 1;
 	udp_tunnel_xmit_skb(rt, sock, skb, fl.saddr, fl.daddr, ds,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, false, 0);
-	ip_rt_put(rt);
+	if (!cache)
+		ip_rt_put(rt);
 	goto out;
 
 err:
@@ -127,7 +128,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	fl.fl6_sport = inet_sk(sock)->inet_sport;
 
 	if (cache)
-		dst = dst_cache_get_ip6(cache, &fl.saddr);
+		dst = dst_cache_get_ip6_rcu(cache, &fl.saddr);
 
 	if (!dst) {
 		security_sk_classify_flow(sock, flowi6_to_flowi_common(&fl));
@@ -146,14 +147,15 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 			goto err;
 		}
 		if (cache)
-			dst_cache_set_ip6(cache, dst, &fl.saddr);
+			dst_cache_steal_ip6(cache, dst, &fl.saddr);
 	}
 
 	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, false, 0);
-	dst_release(dst);
+	if (!cache)
+		dst_release(dst);
 	goto out;
 
 err:
-- 
2.51.0


