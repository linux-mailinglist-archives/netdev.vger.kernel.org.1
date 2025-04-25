Return-Path: <netdev+bounces-186019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E56A9CBC1
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1B73B822B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 14:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663184E1C;
	Fri, 25 Apr 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="g6jSaLqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFO9WRgv"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F62701A3
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591588; cv=none; b=ob0ZzQKS8PMIwibZPH53pzoICwUqgxK/3qP8WWPsURCS88bn0I6m+0vwFlDK0KCNI4MK8ZDCYbNjynPcRZJyQyzVDbDwKKxlmoRAmDAkqaMiolxBnCEsNqdSBHI5VHjd1LOcFDmZ2DV9g2G5HsU1pyiOSZ6e0/Tmco6/1RlM+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591588; c=relaxed/simple;
	bh=D2/N8wlsHr8nBd292weYc//wfk8KTCnW9rM0vDdKSPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ausIZLGRR750jPgTABSrhGPzQeKA1U2ZDl+1F76jp68dw6JPvSlNwbNiL28Ap9xdCDkDBGJ74UWT84YRRgIOs3V5XwmjE3f+X63dS/x7QaiHs7pDMTp+37rddCwKe15XyKYA1YCEEd2UwstmZHlVBZEtgfaYf6nsdcRezE8KzIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=g6jSaLqi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kFO9WRgv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F626114019C;
	Fri, 25 Apr 2025 10:33:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 25 Apr 2025 10:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1745591583; x=1745677983; bh=4QmanPJE1c
	ZCsYBLWlI7Du+ZJZkX6L2IaPHFCY4xMqo=; b=g6jSaLqiUMUKzFtbetYzrscibj
	5NVc41PXjCBqf8gzq3j0AJsK6uuoZw635r1QSY+4QkI+JX4dsvIWkjhykJkfAAlb
	pCi4zVsfVaVnZHZPd1CWFqMJZVk8/HIqHW6m4LKOJZ2XJyyvN4arSmQuC2l9ZeOs
	mTY2S8YJ5Kkfa/9XaC5cCEhYpj9FaWiTbiuyIEyKGaZraGX2lktq9LZmouuAQDB9
	yOBbwZhRNa1a06AJm8GB6/jKjuAZm9wsL6yFZVmrSJHN7GvsbPZa/pCrXSpkj2MM
	1x470ZIy1tCuWR7ZvBs6KHr8eMnEyeu+f+Y0arFqyK/UqDBqVhVWIZmpjEDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745591583; x=1745677983; bh=4QmanPJE1cZCsYBLWlI7Du+ZJZkX6L2IaPH
	FCY4xMqo=; b=kFO9WRgvI8w6LbnyJMqTq/IjkE8Pmm2OeIfsipxfQH/UVs7Ef8r
	artxw14eq47pEvtilRZGKJc4P+fIbFcqW4NoJKpUwIOlZ5D3KbaMohlYnZpDTWQK
	gvnoV4x3ZC6iRudFsHaweHrriX9scqL/GLcvT1s69hVU++X/9PDKnR+Iv8Il6GUa
	8YVi+LTiEmh4cJHwFvLjqo1QpVJCoJKiPhM9J5KQHJ0FemYjVvqIfoaS8NyuWBsn
	2bW1UWXffTLC9izh2Jp0koCme8f3qEW75nkExexPX7R02CWXoPbcKLj91jOiF9RL
	ycnlpC2nYCY/WMG/FWjvDj7zw/0U3BTuHNg==
X-ME-Sender: <xms:HZ0LaB-XmEo_rqnUoDLkLrUJZDw4AW4YUhZorJdtYYJrXqFo3Y8_GA>
    <xme:HZ0LaFtOSFWOKA8ZQhRMLmGPAsGj7rIvX_XRPi8ZvxGqTJrYFsiPQ_Hw5kSY8yjee
    gQ3BAmvIGLVMULft5Y>
X-ME-Received: <xmr:HZ0LaPB2c2PY9_ngWKofgt-hq-d_gr3EnIONfxrHgKrQX_5grnwdqIv6OrvN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
    ucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrg
    hilhdrnhgvtheqnecuggftrfgrthhtvghrnhepjedtuefgffekjeefheekieeivdejhedv
    udffveefteeuffehgeettedvhfffveffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrg
    drohhrghdrrghupdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggt
    uhhnvghtrdgtohhm
X-ME-Proxy: <xmx:HZ0LaFewKB9iy1JDhY-qIz8bdUC-UkeaAfcObL5Dm45lTxDdWruKmg>
    <xmx:HZ0LaGMDORH-mOYgfRWkeBcHS_8raaTpogOMlfO49-1L-tNcm9c3RA>
    <xmx:HZ0LaHn_ewjm44-3-XUenB7-uNEkpLGi9WxQ5BBF0AWt_K0eAJ5i9g>
    <xmx:HZ0LaAsOfOh1Ji18JykKpXP5qTHPEpGNdE02u2owkmOD2XM8qUPi0g>
    <xmx:H50LaCSxhLjMr6uapK-diUJtC6c5HYY5aw5M8U7g06HezPw-mj20ReDB>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 10:33:01 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec] xfrm: ipcomp: fix truesize computation on receive
Date: Fri, 25 Apr 2025 16:32:55 +0200
Message-ID: <f507d25958589ed4e6f62cdc4b8df64865865818.1745591479.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipcomp_post_acomp currently drops all frags (via pskb_trim_unique(skb,
0)), and then subtracts the old skb->data_len from truesize. This
adjustment has already be done during trimming (in skb_condense), so
we don't need to do it again.

This shows up for example when running fragmented traffic over ipcomp,
we end up hitting the WARN_ON_ONCE in skb_try_coalesce.

Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/xfrm/xfrm_ipcomp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 0c1420534394..907c3ccb440d 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -48,7 +48,6 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 {
 	struct acomp_req *req = ipcomp_cb(skb)->req;
 	struct ipcomp_req_extra *extra;
-	const int plen = skb->data_len;
 	struct scatterlist *dsg;
 	int len, dlen;
 
@@ -64,7 +63,7 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 
 	/* Only update truesize on input. */
 	if (!hlen)
-		skb->truesize += dlen - plen;
+		skb->truesize += dlen;
 	skb->data_len = dlen;
 	skb->len += dlen;
 
-- 
2.49.0


