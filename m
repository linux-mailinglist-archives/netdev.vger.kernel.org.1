Return-Path: <netdev+bounces-304908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E3cLJ1d8S2rPSAEAu9opvQ
	(envelope-from <netdev+bounces-304908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:58:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C070ED59
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:58:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=doyensec.com header.s=google header.b=U7p+OBTS;
	dmarc=pass (policy=none) header.from=doyensec.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304908-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304908-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 005B33443FCA
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB674252B9;
	Mon,  6 Jul 2026 09:02:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664F48034A
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:02:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328543; cv=none; b=Dk1dTQtVzHuIecCH3/hDeW8obV9FdwkW11DzLBPuIeDKgPMvlmuE7v0jyJTHuRvnssvsUilZH20OXhJwWTesm7kulxFDgV2sorkqRKNKjesNMrv7+ZCYn7EpXtIbuUMuUTOUSrK544l7GguWvCXjTKX1ESZRKugn7DHzV/V9ThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328543; c=relaxed/simple;
	bh=FPDS8SzxMDN7BC+VZirCfNYEJEl/Cp+LwW+o/iirn5Y=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=qtBGOZmls3lezLdf2S56/m1Q/ysX4dRfYPmyPkVKacxeBC/unW9L1rMbb3KzVHMdxKAe8jwXFZxDJUosxS3Ukuuy4NiBTb2kMKUFTsBG8mLHObkPChMJ4ntv9zVVOBeX2E9AoVcvYFH5zr4E+kw5IXZMITi7kWmFqQZFrTLTMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=U7p+OBTS; arc=none smtp.client-ip=209.85.218.66
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-c1268d56234so344125466b.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1783328532; x=1783933332; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vlg5/CIMTARyHAvCyfNYVePTfJJIQJU+BNy2ERr/7DU=;
        b=U7p+OBTSbTMT6y2J0pHAT4/Q4ZuWK9vpYlWAU2u1KHzntmArItrsmLEkqFu0/LdcR2
         hin3ESthrADJXSgykdwS2R5C/0OUz+PMPow1t/TnlWrKB73sSUCiynKYCUnRDYPHn/W3
         u+NrClEe1+XFqgKs3qYKhUUHB62dQ6W4+v35rc2+fiEMSEzQQ5JkLZSrRLfK9tz5OiTa
         0el3MjfHNsOaI2v18B+deEsvnWuSIwJY5bh380vzZfioTkwnSywPxke7UfvqooXOX/MM
         3BOxTY8GJOJ7uYPb2ztwDF0q/xEE2cYtdYLAPhki68oM2pr7ABav4rV99nYW+42OBy8u
         U07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783328532; x=1783933332;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vlg5/CIMTARyHAvCyfNYVePTfJJIQJU+BNy2ERr/7DU=;
        b=NLtQa96V9dwgpCxfjT4zXimGQt7OosPS7kZj0GaAPu+gqeV+irH973mkyuIXJRB0y4
         GeRPvE0ZH3s7jBf6Cbd2e0pDfy+Lkyw2+WdDPVgiOjj51hGi1Xa93NCWG85hr3B2ZJmo
         WWkYUJ6avUHn+hrh7IEse88mgSAVwvTV482QzzMk+Rx9uj/l7O8j6ZspCPaNDb/t/uZ9
         rYxVzTPEFA49CfR37XtyZMHnZj0XVrvgf/W3mVjbMo7xXjUeJ1gns18k7dX0kB5Q4Ld6
         75zLlAv49dZZtxwaEwhLV2mgJ0mh0PPI39OwKgDOFmrRG1xKNsm2NUMmgHujpyDqZnfw
         Je2Q==
X-Gm-Message-State: AOJu0YznB19Roa/SUOCvzAHqCM9TOiFcI7y8kSExdBrR2nZqkFFkY5Ay
	wKPvd9bBJbyH66YuDb+td6r0Yjdxqqr7dfSeXhF0mFEYmE9haOvsFTrDeaKVmOoorygO3rB3veZ
	btgiBj0/iKHBQcao=
X-Gm-Gg: AfdE7cmuzA+ERB0fIRWq+0fpZpr5c8LwUCjCuzNVV8zLqoYjWk4cW2N2uCQNDPhmdW5
	l0iUjKM+hF8ihsVNugP33s7hjqebv5hvhFAGaZSjC/OKfQBfm5Kw4Z6vHmDZWV42ctSVZRJ9hU0
	XZubmjVU95D2+imzwudpWtDZOb/S8oYIu2X9lc08R15h8DyzIy47BMjKnUTb0m+eRKGFgHJ9fnF
	PNMEt6Z+00lvKxPXl42yl8DSFvEz0Bs7zvw35OUU9+BIL9f+0ZIo/nN6EYrl2+QyatsHyBOvO5z
	NDhDEFV6PJLxJYwfKD96KFjHO/+TlHILnC1b6LPgtNU+USxgz2Q6WpzbctcjKyPpo9rB3yAeLS1
	Qowu3BvznKnWVvKommEsQFaSTXCnxJaLXWzmtlxQd1gFJvSW+Go+oJ4N4XT24Gua9ecfx5YaFuK
	AW8RXw2q7MT3zdS8bT36g1G9vvaEAX6G3v98WLWzyz7eMUl2sPyxWrTIN/TXzvkdz9YErfAaXsN
	nbL39KzVsl3AP1LFR5TKCGcX31xj5oBjsqcxz3aadaykjIeP3YjxX0=
X-Received: by 2002:a17:907:3f9f:b0:bf1:a59e:653f with SMTP id a640c23a62f3a-c12e6a88ac3mr383827666b.28.1783328531357;
        Mon, 06 Jul 2026 02:02:11 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.57.ipv4.supernova.orange.pl. [83.10.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c779dsm684272366b.53.2026.07.06.02.02.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:02:10 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v3] ppp: defer channel free to an RCU grace period to fix
 pppol2tp RX UAF
Message-Id: <E793FCF2-58DE-4387-A983-C7B4BC3158BD@doyensec.com>
Date: Mon, 6 Jul 2026 11:01:59 +0200
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Qingfang Deng <qingfang.deng@linux.dev>,
 Yue Haibing <yuehaibing@huawei.com>,
 Guillaume Nault <gnault@redhat.com>,
 Kees Cook <kees@kernel.org>,
 Taegu Ha <hataegu0826@gmail.com>,
 linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 gnault@redhat.com
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[doyensec.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[doyensec.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304908-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:qingfang.deng@linux.dev,m:yuehaibing@huawei.com,m:gnault@redhat.com,m:kees@kernel.org,m:hataegu0826@gmail.com,m:linux-ppp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,huawei.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[doyensec.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,doyensec.com:from_mime,doyensec.com:email,doyensec.com:mid,doyensec.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB5C070ED59

pppol2tp_recv() runs in the L2TP UDP-encap softirq RX path:

 l2tp_udp_encap_recv() -> l2tp_recv_common() -> pppol2tp_recv()
   -> ppp_input(&po->chan)

It runs under rcu_read_lock() holding only an l2tp_session reference and
takes NO reference on the internal PPP channel (struct channel,
chan->ppp) that ppp_input() dereferences.

The pppox socket is SOCK_RCU_FREE, so 'po' and the embedded ppp_channel
are RCU-safe.  But the internal struct channel is a separate allocation
that ppp_release_channel() frees with a plain kfree():

 close(data socket) -> pppol2tp_release() -> pppox_unbind_sock()
   -> ppp_unregister_channel() -> ppp_release_channel() -> kfree(pch)

For a channel that is bound (PPPIOCGCHAN) but not attached to a ppp unit
(no PPPIOCCONNECT, pch->ppp =3D=3D NULL) and not bridged, teardown skips
both ppp_disconnect_channel()'s synchronize_net() and
ppp_unbridge_channels()'s synchronize_rcu(), so the kfree() has no grace
period.  rcu_read_lock() in pppol2tp_recv() does not protect against a
plain kfree(), so an in-flight ppp_input() on one CPU can dereference
the channel just freed by close() on another CPU.

The bug is reachable by an unprivileged user.

Defer the channel free to an RCU callback via call_rcu() so the grace
period fences any in-flight ppp_input(). The disconnect and unbridge
teardown paths already fence with synchronize_net()/synchronize_rcu();
call_rcu() does the same here without stalling the close() path.

Fixes: ee40fb2e1eb5 ("l2tp: protect sock pointer of struct =
pppol2tp_session with RCU")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
v3:=20
- Added rcu_barrier() at the end of ppp_cleanup() to ensure all
  ppp_release_channel_free() callbacks complete before the module's
  text segment is unloaded (Documentation/RCU/rcubarrier.rst).
v2: =
https://lore.kernel.org/linux-ppp/D9C0245B-608B-4884-8A09-F55BA4A9F948@doy=
ensec.com/
- Moved skb_queue_purge() to a dedicated RCU callback to prevent leaking
  skbs added by an in-flight ppp_input() during the grace period =
(Sebastian).
- Retained call_rcu() to avoid introducing synchronous multi-millisecond
  latency into the teardown path.
v1: =
https://lore.kernel.org/netdev/C954A7EA-AA98-4E3C-80B5-42C34B3183A3@doyens=
ec.com/

 drivers/net/ppp/ppp_generic.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c =
b/drivers/net/ppp/ppp_generic.c
index 57c68efa5ff8..717c1d3aa953 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -184,6 +184,7 @@ struct channel {
 	struct list_head clist;		/* link in list of channels per =
unit */
 	spinlock_t	upl;		/* protects `ppp' and 'bridge' =
*/
 	struct channel __rcu *bridge;	/* "bridged" ppp channel */
+	struct rcu_head rcu;		/* for RCU-deferred free of the =
channel */
 #ifdef CONFIG_PPP_MULTILINK
 	u8		avail;		/* flag used in multilink stuff =
*/
 	u8		had_frag;	/* >=3D 1 fragments have been =
sent */
@@ -3562,6 +3563,18 @@ ppp_disconnect_channel(struct channel *pch)
 	return err;
 }
=20
+/* Purge after the grace period: a late ppp_input() may still queue an
+ * skb on pch->file.rq before the last RCU reader drains.
+ */
+static void ppp_release_channel_free(struct rcu_head *rcu)
+{
+	struct channel *pch =3D container_of(rcu, struct channel, rcu);
+
+	skb_queue_purge(&pch->file.xq);
+	skb_queue_purge(&pch->file.rq);
+	kfree(pch);
+}
+
 /*
  * Drop a reference to a ppp channel and free its memory if the =
refcount reaches
  * zero.
@@ -3581,9 +3594,7 @@ static void ppp_release_channel(struct channel =
*pch)
 		pr_err("ppp: destroying undead channel %p !\n", pch);
 		return;
 	}
-	skb_queue_purge(&pch->file.xq);
-	skb_queue_purge(&pch->file.rq);
-	kfree(pch);
+	call_rcu(&pch->rcu, ppp_release_channel_free);
 }
=20
 static void __exit ppp_cleanup(void)
@@ -3596,6 +3607,7 @@ static void __exit ppp_cleanup(void)
 	device_destroy(&ppp_class, MKDEV(PPP_MAJOR, 0));
 	class_unregister(&ppp_class);
 	unregister_pernet_device(&ppp_net_ops);
+	rcu_barrier(); /* wait for RCU callbacks before module unload */
 }
=20
 /*
--=20
2.55.0=

