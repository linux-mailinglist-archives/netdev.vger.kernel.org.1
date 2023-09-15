Return-Path: <netdev+bounces-34145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7507A2564
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71F51C20A9E
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4872A18E11;
	Fri, 15 Sep 2023 18:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB815EBE
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:12:50 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0D1FD6
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:12:49 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694801567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDVmPfCORO/1Or+oAHB6H3kmDKXMfRRRDUSuxthS2yI=;
	b=ntKL7rntnkteVTwPNgMifB+eDAUyBkkLe91OlgxEkZAy8UalT0EepTrzDB34dlG+KPdTD9
	M6y6LSfN0vVIocOywhE3f46ZP0qwTkobSo/V57RqDpL8Zx6u0tsCYfqjE0nyR5GIlmqA1t
	nMwgpmrVRyKky5V5SvmiRp8sQrThYwE7nUub/rUj0y8kGyxyUSR+vxr1/H/88u/pIT/uX6
	haasSdlxsbRBcEW64/5elQqzaQyfK59FCJKD6r1RIEl2xGJax9lOBoMUxxOQfwqavcTe1L
	QnLSkXDBndnTFigLJiFQnksRlMVXLZMqGqtRmR4OeVEoTqTEQvTCep6DAC7jmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694801567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDVmPfCORO/1Or+oAHB6H3kmDKXMfRRRDUSuxthS2yI=;
	b=GrYff03ElMGvcb2Vd/ZDMn2GLUt1yB6HAsPuj3GUmgFOIRI70ivANlFOo3Y/ksnzxnvKIE
	XKDqIV6JpkWohJCw==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Oetken <ennoerlangen@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net 1/5] net: hsr: Properly parse HSRv1 supervisor frames.
Date: Fri, 15 Sep 2023 20:10:02 +0200
Message-Id: <20230915181006.2086061-2-bigeasy@linutronix.de>
In-Reply-To: <20230915181006.2086061-1-bigeasy@linutronix.de>
References: <20230915181006.2086061-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lukasz Majewski <lukma@denx.de>

While adding support for parsing the redbox supervision frames, the
author added `pull_size' and `total_pull_size' to track the amount of
bytes that were pulled from the skb during while parsing the skb so it
can be reverted/ pushed back at the end.
In the process probably copy&paste error occurred and for the HSRv1 case
the ethhdr was used instead of the hsr_tag. Later the hsr_tag was used
instead of hsr_sup_tag. The later error didn't matter because both
structs have the size so HSRv0 was still working. It broke however HSRv1
parsing because struct ethhdr is larger than struct hsr_tag.

Reinstate the old pulling flow and pull first ethhdr, hsr_tag in v1 case
followed by hsr_sup_tag.

[bigeasy: commit message]

Fixes: eafaa88b3eb7 ("net: hsr: Add support for redbox supervision frames")'
Suggested-by: Tristram.Ha@microchip.com
Signed-off-by: Lukasz Majewski <lukma@denx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_framereg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index b77f1189d19d1..6d14d935ee828 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -288,13 +288,13 @@ void hsr_handle_sup_frame(struct hsr_frame_info *fram=
e)
=20
 	/* And leave the HSR tag. */
 	if (ethhdr->h_proto =3D=3D htons(ETH_P_HSR)) {
-		pull_size =3D sizeof(struct ethhdr);
+		pull_size =3D sizeof(struct hsr_tag);
 		skb_pull(skb, pull_size);
 		total_pull_size +=3D pull_size;
 	}
=20
 	/* And leave the HSR sup tag. */
-	pull_size =3D sizeof(struct hsr_tag);
+	pull_size =3D sizeof(struct hsr_sup_tag);
 	skb_pull(skb, pull_size);
 	total_pull_size +=3D pull_size;
=20
--=20
2.40.1


