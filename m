Return-Path: <netdev+bounces-303794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zBKRGJhYRWoc+woAu9opvQ
	(envelope-from <netdev+bounces-303794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:12:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB60E6F0869
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 20:12:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=doyensec.com header.s=google header.b=PvM9YUYK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303794-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303794-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=doyensec.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6F38300D62B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 18:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C24C043A;
	Wed,  1 Jul 2026 18:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9AC4C040A
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 18:12:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929556; cv=none; b=KLcySbXVzMwZ/1vc9xCcgV6RGAi7j/LqRIlkf/BT1Mgx4raVnLz9HlAdD8RNWm76ts65uiuKJ7sZl3wU9aJSoYavEoCysuUnTZ+UXcGGRYNYhNK0TT4mYa73sXOTI1VlHWcQZmmoGFwWjqbyBtz9kcaXVLSaNXsmy7yxkcoQijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929556; c=relaxed/simple;
	bh=/1yAh8GBDR233LTpfBg0ezKT8gqdt2ZcnWPhVi1DUhg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ENu1jYBHDrZF2s5Nk9wZmHvpZXFzJ0pxd8HDH7ii5yCF//S6j7i6LumEF3Xyi14kCtVR9b/ipr4nQRIhm/ly2PsvDG2oHPWusvM9/Yv7NugO+MbErX5+yLLRU3WlTl4Bw0xHX7jGLdyQQ5ijgYCETvqjgZ2Yt36bAj/kZhn210o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=PvM9YUYK; arc=none smtp.client-ip=74.125.228.131
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c12986ea776so38668366b.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1782929554; x=1783534354; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2CFjtKSFMabkMab/8Wra001PVD5OGn/L4VHRmfqhng=;
        b=PvM9YUYKIVwpIC3TwrXMBs2Nx7CmPCh09VZBZ+FSqpClER7OeOg+r8X5HysGdGXDxk
         40MdI3+ieQJnkb5WFKLJ8kLkL+ShczZxL+HvyY7RfuIiOOMHQo791u2f9Fo7mjkhqoXM
         gCv5uUpDmBB3DtOFaWG/QYsK3AEoIxVFXawLMFjIIspoedJCUOYdgk1bp7M43Rd5/vCV
         BRQcRUEVvWRet5vtkBYzIgUrv3ezVyDCEk02ggt4iYb2pZ0x2+1ORlCy2UvW1xkkld6c
         sK79UgI25vLymU7ns2tcqRlSyJYjiCX2v6N8CoQHJ6s2LJ91ahfNfvQO/JfkCG0hMXeO
         0rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782929554; x=1783534354;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p2CFjtKSFMabkMab/8Wra001PVD5OGn/L4VHRmfqhng=;
        b=ZIeSHHJBjJWMNr21w9ZxLU0Q3lTrLvuJwYiKVaFi4N6FEY+aq6+GXHXKPM9vn//XVP
         F0o3jZJY7j9LPyUbp0H3ADlyofd4ievikJ4cPcPGWMwb5JaqbKxP1KHTUTaTOBAfqam9
         cAITLnFJaaLjccZGfrbn88BbHWgOYfxsjLoOqp712CICy2bBbNnM2U9iDdyEorj+SLz1
         IYyDYgF9KviZThVVYbcX8vIXo4qrRwyyGlC9/8/ZVuGx8ot2Xy4vA8oXyUIOtvIug6KP
         fEjwS2x6NvpKAHrIipqvZ1glOLcRIilhXotP/XekfFK2CU+zwbn/YGFkjZciUEwafrHM
         DQcw==
X-Gm-Message-State: AOJu0Yw0uISK/jwrTd3H5tP+Kq8OSKqZGrrcDmOifl5kSXeH5eIGPYUl
	3v7JCG/OuMko/Maf+MG37s+L1GRY6MB8ukiciBT8GzNFHWJMpOtV8xsOgOBOHMZNkslUixmSkBO
	TswlK7pQYdbuNtbw=
X-Gm-Gg: AfdE7cnG5oE/AdGnCUXmFTfBTXYcM39n7wKRphNqTPYe6DMsjsJPP2KtH+nuOsa4jCV
	XDhDOPrlVPE/gRIPvbnmiuKXLUCiPav2u2uuUzRcv9FV7+N/d30hfvelEoYyY+SQHHd6SzDNNu2
	YpLCiS/kUbwgT5XFxglYPuqtiJIFuYO473+BpB5NUsxYt4imziC/2+eVtUdHovSvOlMmTAn4hRP
	17Z+XiuyRKAya9S1XJcnbXufCblH+JLFOzmati3IZTQJmj7VCdAlTW7lMp1w8nrjbAemyH8PCzt
	XPSIcEpLv9YYwCuyJEwJ37VaXsV2G1E7cr/bvo5jLQLjdGa6zX9a2dJjk3eZhpYAEd1/SDVDHTi
	LKiTOnqAIfpm66FilLw2gPVvPYmWvVtOqLpt6E+CSkySa3vi2blxxvY6tJptLiJ+IySpt6DV9RZ
	cw35EasO0Yokh4MRc4a9FKiQ2Df1xT+F3OXZ5zUs4fn//w+21CcaW88hluf1siaNTuYC0ArD8CF
	J2RSUwb5stxlRUkQDt9q4u7wvAe2FsS4qIafE0fAIMoGoEulYIba7g=
X-Received: by 2002:a17:907:e143:b0:c00:de33:a74f with SMTP id a640c23a62f3a-c12a9dbc269mr106926066b.25.1782929553494;
        Wed, 01 Jul 2026 11:12:33 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.68.ipv4.supernova.orange.pl. [83.10.35.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b628efefsm1051666b.32.2026.07.01.11.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:12:33 -0700 (PDT)
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
Subject: [PATCH net v2] ppp: defer channel free to an RCU grace period to fix
 pppol2tp RX UAF
Message-Id: <D9C0245B-608B-4884-8A09-F55BA4A9F948@doyensec.com>
Date: Wed, 1 Jul 2026 20:12:20 +0200
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Qingfang Deng <qingfang.deng@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Breno Leitao <leitao@debian.org>,
 Taegu Ha <hataegu0826@gmail.com>,
 Kees Cook <kees@kernel.org>,
 linux-ppp@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[doyensec.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[doyensec.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,linutronix.de,debian.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303794-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:qingfang.deng@linux.dev,m:bigeasy@linutronix.de,m:leitao@debian.org,m:hataegu0826@gmail.com,m:kees@kernel.org,m:linux-ppp@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[doyensec.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[norbert@doyensec.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB60E6F0869

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
v2:
- Moved skb_queue_purge() to a dedicated RCU callback to prevent leaking
  skbs added by an in-flight ppp_input() during the grace period =
(Sebastian).
- Retained call_rcu() to avoid introducing synchronous multi-millisecond
  latency into the teardown path.
v1: =
https://lore.kernel.org/netdev/C954A7EA-AA98-4E3C-80B5-42C34B3183A3@doyens=
ec.com/

 drivers/net/ppp/ppp_generic.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c =
b/drivers/net/ppp/ppp_generic.c
index 57c68efa5ff8..2d57de77780f 100644
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
--=20
2.54.0=

