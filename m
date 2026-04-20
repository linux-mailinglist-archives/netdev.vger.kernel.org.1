Return-Path: <netdev+bounces-279619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLtvFSWI5WkzlAEAu9opvQ
	(envelope-from <netdev+bounces-279619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 03:57:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39074261EE
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 03:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CF3D30128FF
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 01:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2018377006;
	Mon, 20 Apr 2026 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltfWM9Nx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E945377007
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776650270; cv=none; b=beeTS3qS9jdJV4TdgVClsHI4VuJ1Xv257Rjvi14ocDV/2QlIBeabzilkRu93YUsIHMCfLImQPz3Ts00G4jjVv0EejDfp1+RfKZIkuZBjYWS/vz0ipHGLjGNhO+lY8ZYPMZ30w8E3sN1QK2/G/X8Rb1aYbhY53mlz5Fpj/5Ip78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776650270; c=relaxed/simple;
	bh=nDOO/QVVxqLEgHoPDQz6EwQRY3Od75nFCAbkfCou6bY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0tdRuj05k9WKCbapxPSa3ogR7y+ZEJz6w9c+u6373R/HeAiBMUJQNJpibvemRNfrEniR9KV7hCskKrqy/mzQ76qW1PSlJjRtRsrY8kx6ZEgSvqw1l7jEHbD5n1hgiWZY8mz5c+usRiU8XwZe7QWnGJcMmK5HWy/yQ2z3hXIyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltfWM9Nx; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a093c784b0so34250486d6.3
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776650268; x=1777255068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tGxkhVLfHZjK8520beBJO1JbPMJ7IBle55iVGcEnGWs=;
        b=ltfWM9NxzQI6xg8W+qC8xfe2z+j0zYF2phPpwxjcKPYO4hYX3Ji01bNVpHe+Y6aheO
         avnOD+UbwJFJZ5BQzYyMTroAHn1slKiz/Ds1dmJDW9xxiOU37Clk71JUo7vm301pqYH9
         qEKJcpZrWsNjmtXIm3tNcUm4MYSYcdQQ905qz/VPvtlnwKXNAjt+Us5nUoh96M3meUg7
         6dUE0xsaayUzuwG1zF0hxM9E4OP4n2fIU8mmUASjvbPxKEjTUilLRFPlTdDmxUqCFFlI
         Bbx40GtAtMN6ynFjB4afDaP5awRY+CLyv9QVJkJOwBZzFBjP7TNGIRgS6E2uo4sshJ1B
         Y6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776650268; x=1777255068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGxkhVLfHZjK8520beBJO1JbPMJ7IBle55iVGcEnGWs=;
        b=e9kLqGGDpTt1keX/apuZ4LqcSGoPtmdOI9xOCzCnZoHUJUkCgg6nx9FJqiwKELK2W7
         elRMiGPmziee1MfGVh9K6mcHsgqUkYYUYaGWtFafqAUNcbRa6Zqz9X7kQd6PFPsgukHY
         ZOZlGWA43B7lJg2nX3mAOAf4N8XDnF+BuuYOSgQyP5koLPp9JQbNdELsHJoRD0/O/loe
         MX0XIIDDRpTfCPdJOLCT1/yVS8bLaDXFcHt8QcaeA7r8/BMMLqvcKA2MJuYcwRDL+G8q
         0hyovOvJvTzzR9H+7D1ccHX/IxTAhQLnQgN6i+9zjr9XeDeTEfo5GY2zD6pOVJe+09Lx
         eaTw==
X-Gm-Message-State: AOJu0Yyi2Hs3Tvgb/w45Ok1rJ3J7X58/4YhUi/JgMhelruKlsoRPdZ5+
	CjfOKD8i+tQzcPI/WrxeoOnc8fqEr+KeT8C1Z7DClqQSgTaocnyMkWDe0ZblJxfVdOEL2g==
X-Gm-Gg: AeBDievV4YoxMMwou2RRNvpoOY3mu+OLMaMAbU6zT5Z/sIdSWM3QXQEwbEwzlHz9iiu
	/cikIT9AiZWooQ/DvRePCXFGyGr9uIIsgrA7k2rTCmLuA/4gQnS66GTT9WAWrqUy/3sERl9phO1
	0S5uGXSwAhfV3Vnq6FtgwhAAskpbxa2SUy5s9IIUWa9qE5ScOYGReVhHgwAV3PalYapxDAEjuNd
	nFnBHb5Gny7teqV02LnOBMUSbPiP3jz917QW/09jguRAeEmisTVi8+0XZZUqdKKJ3GSs8UTIUl0
	2IBx+Y9N1UuvjDP+mQ6jPEMt0u2Fp43I4coAwCwE+sGreUh95Xbken1K1sjMAkDz2WrG8KmKIDd
	pAH+iQz4fk0G5c7dfdC2PKWCSTACe/Oia6HZkrwv//FLhx87dQGNfxNPo0oZCyr3j15DDp1Kiqs
	0Npbz/YWP1n/eTXlgLFMnNy4APfhocTSLNr/0xAyE2ZESaPsSNvUXON0k+GbnDieOqlo9qU5enI
	ZNpt6Is/D7DHs6+2KLXZEnmF1sFbkeVRGQEpbQ=
X-Received: by 2002:ad4:5ecb:0:b0:8ae:64c0:c922 with SMTP id 6a1803df08f44-8b02817684fmr194814596d6.46.1776650268394;
        Sun, 19 Apr 2026 18:57:48 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae79733sm65963546d6.33.2026.04.19.18.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 18:57:48 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] net: rose: use pskb_may_pull() in CLEAR_REQUEST length check
Date: Mon, 20 Apr 2026 01:57:23 +0000
Message-Id: <20260420015723.462479-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-279619-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C39074261EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 2835750dd647 ("net: rose: reject truncated CLEAR_REQUEST frames
in state machines") guards against short CLEAR_REQUEST frames using a
plain skb->len comparison. Use pskb_may_pull() instead, which both
enforces the length requirement and ensures the bytes are in the linear
part of the skb, making the subsequent accesses to skb->data[3] and
skb->data[4] safe for non-linear buffers.

Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 net/rose/rose_in.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index ca4f217ef3d3..48183363d3f9 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -274,7 +274,7 @@ int rose_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 	 * ROSE_CLEAR_REQUEST carries cause and diagnostic in bytes 3..4.
 	 * Reject a malformed frame that is too short to contain them.
 	 */
-	if (frametype == ROSE_CLEAR_REQUEST && skb->len < 5)
+	if (frametype == ROSE_CLEAR_REQUEST && !pskb_may_pull(skb, 5))
 		return 0;
 
 	switch (rose->state) {
-- 
2.34.1


