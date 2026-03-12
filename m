Return-Path: <netdev+bounces-267143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HOcH+3lsmktQwAAu9opvQ
	(envelope-from <netdev+bounces-267143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:12:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB33275496
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2852F30A63A5
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774C3F54B5;
	Thu, 12 Mar 2026 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hw+ktrKM"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-21.consmr.mail.ne1.yahoo.com (sonic306-21.consmr.mail.ne1.yahoo.com [66.163.189.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352C3F54B6
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331152; cv=none; b=JeDcQzJ5NSvqX/OFLwJEs/4XiTnw+GUULTcZEwMPH8BqrTCJ3OravThbJqjIK9kRbKBMJ/GrRtpS/SXMdvcAGrh0SR7gMEE0i/w+2qHfJ3DGcjsp8EXvSdNcBT7CQ4nr6/vzTL5y72AlK/fmqwEyieLZ35b8A+y1XS+mGFc+4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331152; c=relaxed/simple;
	bh=CuiTJOOmsW+aFYNMJm5VXa6RQE5Ls9xLs9QS3bXmUIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Je+FAbKgeClY7hujZ2RhE6ZhLw4jGyioch6mAYLQ3FzvjTDkCqFJPD740WoLLTb8x/ANxMZHS1ETXloWH3x4KjCB2MZfCbeQZVZ4dZSjsD5PoXEMBreHJzV8g6BvrAaTXnGg7wkUXaIFOugRSwuADPYNueVae0bLCkPk9piZpCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hw+ktrKM; arc=none smtp.client-ip=66.163.189.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331149; bh=9m60tMj2busabF/Oy+HOZ18Gf7Iev+cYqYon9NoGSWc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hw+ktrKM3RBX0deKl0gV8RCHQxlm78bO5yKroNsPSSilCN41A17FoQxHL8iosFdP6M7xizA+IELQG+4YGkiogrtNLk5pG4MmJpvWZRY7qhgpMRVBFfnn6HC1km3GwqRS3MTg0Iparekh/4EeO1AHQBh4H3JZ+kqrUQrmqqa7kbzKi0mELVsykfZ1sPpw9puVeWs/ZBdvhcLvtOJls/ueZomKQeDr8f44HPNHhuu4sbNArfPul7I4/kBOUT6o+t+ioy2dspBQOPCxo50R9wWJzh4lJ3aoK+vrc+A7MmtkCeHOlPSiCy5Jc5wOLInJgg9gialhuZzwmfOyXIjjaF/kng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331149; bh=7/chMDbJxzZlJ3LI80uYOdu2foD5RCLLWYL8VbIEQs5=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tK4ZEDhQ3rY/VzeSfi6bLjlW57+nSMKqJyGTT5ojrAvMdElGRFhBYQXyXMHiJn2saWPxr40DcV5uH4zuzG08JU+u1wYLzfYFbMcuByDVH0ZNiOeOBAcewFqjwkvTUINaubVRqlm4Mhpl94GjLd4WAAqhxEQg4AxV5klTVmh8J+H+1yLGdfhODAJQzpl7EK6ZH0Sqb/gYp4WtwhzPTh6w3IuUCawX0MdbWmmqS3gXKUiDNdwuUmsf+XTumyf9HUhXUuybUFP9tDeK175fZzDEGUkv6kR8QpI/rlY8wJsLwrjaM9uxvDbucDVh3WAM5n49p+j/U2KQWbUvTolx+FCvCA==
X-YMail-OSG: .rMjvh4VM1keQkH63ePQiFJNiwtO4nYa8jm1.kCTLkkdA6jbPyd7kZRM9ihOskZ
 GEnv3KHacq6DJv5SLAbh.QEau0yfRDI_fECuKOpe_3UZBnRHQ.760Trwhpe2A9PsevIPaVP1sNY.
 ed.Sj6HTdc943gE0_gahxRGy8N9DtrDS2PC9QR1KzwPsIWBabC3xShjFQVxlnoGU_8Xe3Km03OcY
 ODkouejP1Iw0kPNinMYdMUip1omydX5eN4xTNfgIw6QrrYL6aoyrYT4LaAEAalMqjXErV4Ehp58V
 QRdPDsWMcZ9JkrmbyaEqlo2D_DScLonKJ2FE5mOGlgPAIiCR6p6BlFGgsJyoT0n2COCYGjZwskM4
 VaejVOm095Pcg55XSUFC3LR7HoZUtfgxh8bNrRhlDdC10jcKdsRdwBWkHmGFAA2qr1YQYPfSZ8lv
 p8CBJWEwrAS.fPL6bS4yxdCVQObwPUlNnCZPUNiSvrvt0N3Colze0dW90l6C3dy5Ps20L4ENcAaM
 ZhT2v2ucQVgb2n28UE2aiAeFCEBBciJNxJskz8OCNRUKKbCqiepIHbz5t6zzaSQpYSvsiC1XsIvu
 qZ_Dqa_M5XE7EA1J_QakiVcVXmukcPrc7APw.NyNOXjpR0hMv_IB55ulzxOsCNoPz9q3TxAPiRrt
 CeWzmBobFJ036nBHAroI4VC9kqs7R996K24c1wzXXsNIIfF52SduA7ssUjArHnsIV_qqe_DsMlSk
 N39ZG7ozGArm4VWbhEEjWUHWwSDKQAwiwoR_oG1Yfmlp4lEnp4gDS6ydggS.5O9BeBTBWjJHK5.C
 AHRBnm2stlBoFD6yGOfw9XO0AVDXf1ItEShzPjHq54oGkizma_.dKmO40SWm2AqSXMomnvptBdwi
 f275hPUYKD8.XwEH0BBrLacmcKNBaoA_Nv.cZafetR25vmZIlIahxe3_ZAzAJw52ytsHQSF_Sxl5
 GANbraTNdcnuQjmk2FDQo4oOPbUiQ7c0RErgAIMxC7k.rTy5MtgS6Go5kCppITtdIopFKYZekXIW
 Ze0v9.A3lpuh3IyHRpSuyQPfnpk8HIGDLOIhssif5w20iGtNzfrLYj9n9igkkbW0RNtUn8bxs6R3
 L3g7X6vdiiMH99ZzSiJMBRi8pZE27_xy4O.UizgcqE31PCJ9gio_3vsG2oiWECSkXNRMN2PkF7C.
 wDCGNFhyxkCF_.vLpBwPmv9q1xycdm.2HPgSumatv5WUOTquT3W1NfrX7NSfiih2lGI23xqLqptJ
 MgQ9lkdIYZ6J0sCMwXvV6GpcQqOCI6IrKFQVYnovehgpAVZWGP4nZEhZ9kM0sagCRFTozDCpIW75
 Fsgkpga3QoXwWy_By.5AZJEjpUmxRV5sXsnSvyyPQQ65Kgbf6hWZLSZTJe4Z_NX1IhhMd22b6k6.
 Jcc.9hwjkkI5IvidsDf5Rb8S8daOtotm.57ijRpfyXuX_Ih_PRREJt6BWHeYqbXfzXYY5m3rQqsA
 y5arsCD3n4k0ijBmFfngDiOqoBxiJCFu9h.xTGcaxXV_qlizPnMr3CoXS00b2oZs9POd29QtxpR5
 ZT9xGNQHOEWweyZjwYXA9v1x8HW5ZYcFRO41.GvGZy0DsP7UB177hJTte.h5uHouO6k9q5ylWKGx
 cXrLqSrFNmdsRS1EhWPKIPXF9mDVcz58gg8rjWzotUr0d4oMKVLrj8n4HcYbZgXhnt1Vif6Ko58_
 ZUwc.HUmNNT92qKZV72mf7wW0ze90_EUruC2h.q8H0scUfg2g4D43eK1aAmG5wXjgIIDsiuVtfiv
 iB.jQZqLyKIqGr6iWYc6fxHG5I0oqeEBc9iRiLJ62fV5t11oGQJbwv4ymEg6VmQT.B8LSqSRRoEQ
 IZQ3po3HgWMkHw9k1xNSe5DwNtSNnqnV0jjI37VzDFjrwXKk.ct_mlpjNqxMd8vAr.XUyQ_xTKsm
 1A3zPP2e1jiWg9QVjsxZBh0Sw_JQRCBMjlvMvwibOhQLCJED5wvgi_LsEJxV24iVcHamYe1WNVt3
 kaXZN3d1D0mDCQy8ZxGVJQHX1TVnsBMXXKyZGCYRjMNpCUaWiqFUmh3hpDPAtzxCnTMmI80a3NUJ
 .VvfXtQ4v8eOEX8Y9MYmkXrroPJUP6ibwUh0H.OWMJen_TVNCLSz8dI0i2yx8cRu7yUv8oOvH0p1
 mb7WxIusRaBN5nliV8_6_xWx4TSzqwmIbpGYihNjV.BPNOJKbq5UYyUAdPA--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: f69b7460-c55e-44b1-9b07-b8f2e874936d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 15:59:09 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:59:03 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 06/11] wireguard: socket: convert send{4,6} to use a noref dst when possible
Date: Thu, 12 Mar 2026 16:56:52 +0100
Message-ID: <20260312155657.25676-7-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312155657.25676-1-mmietus97@yahoo.com>
References: <20260312155657.25676-1-mmietus97@yahoo.com>
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
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267143-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7DB33275496
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


