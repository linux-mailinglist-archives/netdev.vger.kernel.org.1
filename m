Return-Path: <netdev+bounces-37543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79687B5DCA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 01:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D2CFF1C20829
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 23:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595E7208D9;
	Mon,  2 Oct 2023 23:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749E1E521
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 23:40:22 +0000 (UTC)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E33B4
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 16:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1696290018; x=1696549218;
	bh=DpHnaHAijT4d4KiioJpkmarggtLbGhDHnkNuc1o3f/E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=epe6D07shF2IKgkogFyig7ZBdeACCWSnRHv+vnRQuFl5aNbLvCdxuk4XrcoVi8yog
	 qFwZTCsMw+tpu57fXb1g7zRHTM3VXTWsF+1Re9OjOqt59vYEcq26RInlM1K3+rNtOt
	 +CI2ZYPCXH1V1YaYSt0JrZn+0ua1axr2CqAMoQQq7p9YveHe1DkRdg/XqWlOweuczB
	 g6tqLJ5vA0RTZriRyMRS97SRL6nJBtVGL1phVs0v9NZXgZKNML/3TiG+BLGguSaa8L
	 oZSCd0cUwGu1AuPLTUEWxtLw6mtpwuZ1/Ff2/c/cVf6bFri9/u5ZtS03sfXMuCYvpd
	 S9NwqeX1uiesQ==
Date: Mon, 02 Oct 2023 23:40:02 +0000
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Michael Pratt <mcpratt@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rafal Milecki <zajec5@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Michael Pratt <mcpratt@pm.me>
Subject: [PATCH 1/2] mac_pton: support MAC addresses with other delimiters
Message-ID: <20231002233946.16703-2-mcpratt@protonmail.com>
In-Reply-To: <20231002233946.16703-1-mcpratt@protonmail.com>
References: <20231002233946.16703-1-mcpratt@protonmail.com>
Feedback-ID: 27397386:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michael Pratt <mcpratt@pm.me>

Some network hardware vendors may do something unique
when storing the MAC address into hardware in ASCII,
like using hyphens as the delimiter.

Allow parsing of MAC addresses with a non-standard
delimiter (punctuation other than a colon).

e.g. aa-bb-cc-dd-ee-ff

Signed-off-by: Michael Pratt <mcpratt@pm.me>
---
 lib/net_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/net_utils.c b/lib/net_utils.c
index 42bb0473fb22..ecb7625e1dec 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -18,7 +18,7 @@ bool mac_pton(const char *s, u8 *mac)
 =09for (i =3D 0; i < ETH_ALEN; i++) {
 =09=09if (!isxdigit(s[i * 3]) || !isxdigit(s[i * 3 + 1]))
 =09=09=09return false;
-=09=09if (i !=3D ETH_ALEN - 1 && s[i * 3 + 2] !=3D ':')
+=09=09if (i !=3D ETH_ALEN - 1 && !ispunct(s[i * 3 + 2]))
 =09=09=09return false;
 =09}
 =09for (i =3D 0; i < ETH_ALEN; i++) {
--=20
2.30.2



