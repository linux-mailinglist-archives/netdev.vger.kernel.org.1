Return-Path: <netdev+bounces-290560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEsFAIw9D2o1IQYAu9opvQ
	(envelope-from <netdev+bounces-290560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:14:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9954D5A9FDD
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 206B93062C14
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D19437C90A;
	Thu, 21 May 2026 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipsbWf5E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F532B105
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381187; cv=none; b=qPWnnrOPMqzYHhNeBeJKM7j9yBlsEGb3KTikTMx9I5T48zgu8SyVeIJ4FlV9HR/mppSwAfCufxt8wKikqiMskhErp3HjS0zi70hve58YJJP7cLDbnTiLzXwu//ay7/dgxMm7GkyUXgk0ShRZ3mniZAZAQw4AO6O3eyhdJMkSVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381187; c=relaxed/simple;
	bh=wzqew7g6CT9dlDsf+TrWejqdUCW50+VVAcpXKutM9V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kap0s7dZ9OMdNA8o2ltjVv8+5hzvgW/YEWKUyq+ruQhmaXznbbDdL8j8NUIbYFOuDBAKtwRsMteHu2oP/2jj2CIq+jqsIFtCrU0k1cm15K5OFVpZDDsoGVMDOPNIcrsKj+sAbk6VoVLSaLhJTT93Ul4VBXUATs6guxMkkWv9Ip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipsbWf5E; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f00a567cfaso3826566eec.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779381185; x=1779985985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5R98YEASOuZ8Uxpfr/WLsgAsOAjnGS8bXv+DgQs1RHY=;
        b=ipsbWf5EwJgJ2zEPKqfDA3X4GbhGgl3PNhpdCMzSc+dfjXKLbkJlPQu+nHEdmf9d/9
         F7KHGjN6ubSqxQ/uawRM8bgf1ht5ur5HlS2mreyrpT01d5oU1cvv+5+/QoNwI6JlHTUj
         2DjSdpkmxAlyN1dQRG5i3ADuD20c13gRFIPgQkF0aADBwLUg3clecZP1l+/1MuITAjE9
         o0oWE/7IKoPtA4P5iyg2t+ePRP7AZ096IdpfMNyGufYFeuI9pT1d8nUg+OdhYmh28/Qn
         2OxuvhItqMXys4v22cax9d4whdB1V2ZUEBHOr83qbZbj2LsFAMZjqF6YHXQcDS+LlMlp
         AA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779381185; x=1779985985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R98YEASOuZ8Uxpfr/WLsgAsOAjnGS8bXv+DgQs1RHY=;
        b=M5mfI4I88aAwiomIbhSxNwzWOh1YaMpZyuLOOnpe3T3lc1Fcv+eBPMS72HhDskfoB/
         /sCBkRp9HpjUfRHnvJZoZfTBziflC5gEmnVBVeJXuX5Rq7EfJqk6VEBXYDg7kuI87tEk
         mfc9077wMLMFOkjn6FgWr5TggQpCtDn34eL861mhpry1BwuaT5r2ApwyLrKyUe1MLIM5
         EBo51W0dPU0Smf7bkX1k+DsYTZL7oI4iixu6XfKmISuMViL6cOAmWInAwjw64SUoelk2
         Xxi0dS7sqL+rjgvfgbNvnbk7v3wQSIt5hW7pz5DOIvkFPdDoO3FcF9XXJb9krxGXZf8K
         jZgg==
X-Gm-Message-State: AOJu0YwvP4p3Z3l8cSWV6P8hZijb0dtoaXS7MRIdDwSE+zfEUWFrOroo
	+UvYnOVjG3gNCfQNsmsQLUaPd8DknmxiI9ZY8G2fz77rDFz4qFi2OLw2EKHIFtp0UT0=
X-Gm-Gg: Acq92OGXJsJgxUbL8918zTtR5x0PRQ1DSc+XjFsLMKjTLRj0MtFaN3oBqKhdLkFS4Hq
	BpSsd98HyswfxfNcRcIsqFu/ewi4MvRT22sZN2XYN0AcDMdas1vRdwm9ty1+XD0k+HOtupCElrT
	8a5hCqag+QlLZid0HhYBEZrYch3KdBhlDMuuhyy7Ww70syA7KNxWY8+BqkE2S3rU0+OCyp0Y40j
	inexVdwJbiWNOYzY8LS6g+OV1x0BnzHJkh/CFtBxfQ26scgDw+1p2XwoatgJsaMfpmPB3z83qJU
	RZ0TLOPQo3AaDGaJwHJQtb1GMHG+f6GmK2SZ1YmTFVa0f/OyAALDANQP2PbrN9f8L9cXYnbFbC+
	4VJN2P3aetZxlVWSR67awU2bXoC87KdT7zQn+zOGE0EQd0lRhQ1RzebTIcqanWhD42I1fQQfZCz
	IFJNk9NMUFMV/tURNCO/lo/2SEQ3/TcMgmytQ2ONBwG8AsKJbiRc/DAhsY8nB1XohYY6Mo
X-Received: by 2002:a05:7300:7c16:b0:2d3:9c91:6c45 with SMTP id 5a478bee46e88-3043203edeamr1945367eec.6.1779381184998;
        Thu, 21 May 2026 09:33:04 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044330cd9csm834851eec.11.2026.05.21.09.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:33:04 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	dongli.zhang@oracle.com,
	xmei5@asu.edu,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] tap: free page on error paths in tap_get_user_xdp()
Date: Thu, 21 May 2026 09:32:31 -0700
Message-ID: <20260521163230.1478627-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org,google.com,oracle.com,asu.edu,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290560-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:email]
X-Rspamd-Queue-Id: 9954D5A9FDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tap_get_user_xdp() rejects a frame shorter than ETH_HLEN with -EINVAL,
and returns -ENOMEM when build_skb() fails. Both paths jump to the err
label without freeing the page that vhost_net_build_xdp() allocated for
the frame. tap_sendmsg() discards the per-buffer return value and always
returns 0, so vhost_tx_batch() takes the success path and never frees
the page; each rejected frame in a batch leaks one page-frag chunk.

Free the page on both error paths, before the skb is built. This is the
tap counterpart of the same leak in tun_xdp_one().

Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
Fixes: ed7f2afdd0e0 ("tap: add missing verification for short frame")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/tap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index b8240737dc51..2e75846d1072 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1052,6 +1052,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	int err, depth;
 
 	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -EINVAL;
 		goto err;
 	}
@@ -1061,6 +1062,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto err;
 	}
-- 
2.43.0


