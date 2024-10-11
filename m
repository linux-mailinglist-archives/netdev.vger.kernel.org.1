Return-Path: <netdev+bounces-134616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6BF99A75D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753421F23863
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BEE1946A4;
	Fri, 11 Oct 2024 15:18:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C32199BC
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659886; cv=none; b=f5UsHnrjSFQ6wIYSjZ7go9wSl0UMG1nzQoX5CaoV7lf3BPfZCEI9OP+T1I9U+nwcOItGj05VptuKubqy3/OXzfPpjYP4FwXvSBkLKsTCGyQFL+itM3ZSpvv3eB2nW5IpEgdB9aI2G5P/P64fy10iJxCFceQwm49a4o4IByBDlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659886; c=relaxed/simple;
	bh=/T0vz9pNA377MabzuhfPLDUNHA9Dhcgvz6myWnbb9Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cj7BwrE9Mj0Er16w8EiTariP4queyA/0Q8kszy46j2JLI5QvzwOQ5kHYeeFTxG/C70f7OohBtXfnOvIY5icfuNlfLk5Kqw6I3UAOEos8mU81Sz2uE2v81r2ybJaMgRC/1pMYl4ygo7FmspkVNeC0ZFVIdKT/6Z4poEM84Kmyn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-uHOzPtwIP_Ce8hrQ_lK8Ow-1; Fri,
 11 Oct 2024 11:16:47 -0400
X-MC-Unique: uHOzPtwIP_Ce8hrQ_lK8Ow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B161919560B5;
	Fri, 11 Oct 2024 15:16:46 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D471519560A2;
	Fri, 11 Oct 2024 15:16:44 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Clayton Yager <Clayton_Yager@selinc.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] macsec: don't increment counters for an unrelated SA
Date: Fri, 11 Oct 2024 17:16:37 +0200
Message-ID: <f5ac92aaa5b89343232615f4c03f9f95042c6aa0.1728657709.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

On RX, we shouldn't be incrementing the stats for an arbitrary SA in
case the actual SA hasn't been set up. Those counters are intended to
track packets for their respective AN when the SA isn't currently
configured. Due to the way MACsec is implemented, we don't keep
counters unless the SA is configured, so we can't track those packets,
and those counters will remain at 0.

The RXSC's stats keeps track of those packets without telling us which
AN they belonged to. We could add counters for non-existent SAs, and
then find a way to integrate them in the dump to userspace, but I
don't think it's worth the effort.

Fixes: 91ec9bd57f35 ("macsec: Fix traffic counters/statistics")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 12d1b205f6d1..26034f80d4a4 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -154,19 +154,6 @@ static struct macsec_rx_sa *macsec_rxsa_get(struct mac=
sec_rx_sa __rcu *ptr)
 =09return sa;
 }
=20
-static struct macsec_rx_sa *macsec_active_rxsa_get(struct macsec_rx_sc *rx=
_sc)
-{
-=09struct macsec_rx_sa *sa =3D NULL;
-=09int an;
-
-=09for (an =3D 0; an < MACSEC_NUM_AN; an++)=09{
-=09=09sa =3D macsec_rxsa_get(rx_sc->sa[an]);
-=09=09if (sa)
-=09=09=09break;
-=09}
-=09return sa;
-}
-
 static void free_rx_sc_rcu(struct rcu_head *head)
 {
 =09struct macsec_rx_sc *rx_sc =3D container_of(head, struct macsec_rx_sc, =
rcu_head);
@@ -1208,15 +1195,12 @@ static rx_handler_result_t macsec_handle_frame(stru=
ct sk_buff **pskb)
 =09=09/* If validateFrames is Strict or the C bit in the
 =09=09 * SecTAG is set, discard
 =09=09 */
-=09=09struct macsec_rx_sa *active_rx_sa =3D macsec_active_rxsa_get(rx_sc);
 =09=09if (hdr->tci_an & MACSEC_TCI_C ||
 =09=09    secy->validate_frames =3D=3D MACSEC_VALIDATE_STRICT) {
 =09=09=09u64_stats_update_begin(&rxsc_stats->syncp);
 =09=09=09rxsc_stats->stats.InPktsNotUsingSA++;
 =09=09=09u64_stats_update_end(&rxsc_stats->syncp);
 =09=09=09DEV_STATS_INC(secy->netdev, rx_errors);
-=09=09=09if (active_rx_sa)
-=09=09=09=09this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 =09=09=09goto drop_nosa;
 =09=09}
=20
@@ -1226,8 +1210,6 @@ static rx_handler_result_t macsec_handle_frame(struct=
 sk_buff **pskb)
 =09=09u64_stats_update_begin(&rxsc_stats->syncp);
 =09=09rxsc_stats->stats.InPktsUnusedSA++;
 =09=09u64_stats_update_end(&rxsc_stats->syncp);
-=09=09if (active_rx_sa)
-=09=09=09this_cpu_inc(active_rx_sa->stats->InPktsUnusedSA);
 =09=09goto deliver;
 =09}
=20
--=20
2.47.0


