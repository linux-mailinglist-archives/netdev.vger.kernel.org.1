Return-Path: <netdev+bounces-41360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A117CAAF9
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625B128128A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8B28DA4;
	Mon, 16 Oct 2023 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="g9ekjkro"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908A27EEE
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:09:08 +0000 (UTC)
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6FB9F;
	Mon, 16 Oct 2023 07:09:04 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 2E58610D45E4;
	Mon, 16 Oct 2023 17:09:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 2E58610D45E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1697465340; bh=+ZC8GtdyCkRDxzr5JIpKd7VwUl5MmIl1Af5SMfJNu+M=;
	h=From:To:CC:Subject:Date:From;
	b=g9ekjkro5OTpLaHHhJsqrXI7Zv+df7nSf73SdJugv1btmf57bBwDj2ao952WWQxU/
	 O8GftW08kqj6+7TO1EUBUiIksrGEEzHoa+liB9EDw0TiDg3Bem9G137a4oAj/JecXw
	 SZpQrvrvUmf0dk1Jv/or0ZiulZf4YXDxkQI/Lloo=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 2ACAE309B5EE;
	Mon, 16 Oct 2023 17:09:00 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, Kees Cook <keescook@chromium.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net] net: pktgen: Fix interface flags printing
Thread-Topic: [PATCH net] net: pktgen: Fix interface flags printing
Thread-Index: AQHaADpPvpSeWfXDTUmbVpNurCN1KQ==
Date: Mon, 16 Oct 2023 14:08:59 +0000
Message-ID: <20231016140631.1245318-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/10/16 11:09:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/10/16 12:06:00 #22200180
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Device flags are displayed incorrectly:
1) The comparison (i =3D=3D F_FLOW_SEQ) is always false, because F_FLOW_SEQ
is equal to (1 << FLOW_SEQ_SHIFT) =3D=3D 2048, and the maximum value
of the 'i' variable is (NR_PKT_FLAG - 1) =3D=3D 17. It should be compared
with FLOW_SEQ_SHIFT.

2) Similarly to the F_IPSEC flag.

3) Also add spaces to the print end of the string literal "spi:%u"
to prevent the output from merging with the flag that follows.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 99c6d3d20d62 ("pktgen: Remove brute-force printing of flags")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 net/core/pktgen.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index f56b8d697014..4d1696677c48 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -669,19 +669,19 @@ static int pktgen_if_show(struct seq_file *seq, void =
*v)
 	seq_puts(seq, "     Flags: ");
=20
 	for (i =3D 0; i < NR_PKT_FLAGS; i++) {
-		if (i =3D=3D F_FLOW_SEQ)
+		if (i =3D=3D FLOW_SEQ_SHIFT)
 			if (!pkt_dev->cflows)
 				continue;
=20
-		if (pkt_dev->flags & (1 << i))
+		if (pkt_dev->flags & (1 << i)) {
 			seq_printf(seq, "%s  ", pkt_flag_names[i]);
-		else if (i =3D=3D F_FLOW_SEQ)
-			seq_puts(seq, "FLOW_RND  ");
-
 #ifdef CONFIG_XFRM
-		if (i =3D=3D F_IPSEC && pkt_dev->spi)
-			seq_printf(seq, "spi:%u", pkt_dev->spi);
+			if (i =3D=3D IPSEC_SHIFT && pkt_dev->spi)
+				seq_printf(seq, "spi:%u  ", pkt_dev->spi);
 #endif
+		} else if (i =3D=3D FLOW_SEQ_SHIFT) {
+			seq_puts(seq, "FLOW_RND  ");
+		}
 	}
=20
 	seq_puts(seq, "\n");
--=20
2.39.2

