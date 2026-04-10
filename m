Return-Path: <netdev+bounces-277525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIEkHrJJ2WmkoAgAu9opvQ
	(envelope-from <netdev+bounces-277525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 380683DBC44
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F0EC3043AE4
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620A43446C0;
	Fri, 10 Apr 2026 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pn82iTrJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFA2D3EC1
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847837; cv=none; b=a+w8zKqXMsH8HoKW5VT03PvxtIT/Dy2RbzIZJsoNRRA5Qv16WkHak99J8Fl9yC0h+Z1/rpPnhW6B+pwp4M/TVN/C9tIOnmGxj5e+nK/Y79atH9btrE26/3QhIaka5dYcuIFmwbdqBXVInSnSLqjw6wL+iVp6F+m02v9etFPa4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847837; c=relaxed/simple;
	bh=A0fojv7pXOhmyXaSwDORGhPki46B9qck8V2QJFu+E9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNBW5egr7kFtqxteulTp0HdhB2cgZPUzDfBTPJ8mSIc+ZPxTNwx0p2Y/wG99VankWdgSv3g53f2sa1LZYEnFuCLZKokGhJ2787y6JSAmdRgQp0C3sSm/+xkw6a72cJJ1sqCAVOnEOAygVft55cuAhtANumtb7Z2PWnxImOJxOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pn82iTrJ; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-604f834349cso872988137.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775847835; x=1776452635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOF2ctLto8Cga4gZZCbhmetTXKvSPuUuwNvxhc3GL68=;
        b=pn82iTrJ25XuynqdHN7Si1VGgk7a1zPTJtNFddCcsmm5MMYgm4Hrtf2/fdOC6jOsIq
         7AncFIPcwZuhwl95Xafk7Q5O12xfJmoRtpP3mfJaXCib8RtG02/DPzRQweWEU55x6Z7B
         8r+xIkqgq+iW5g9nNi5U3MCEN1ZukUoU1FTIBwqyuAJH3HpZ0LREnVAHFxUZNASucUXV
         cbxAx8BOHPhhqvLHAZbwz2ZUKZSqy8tU4MGzL2lBUb4wY9IxnyvSJdJy7K7738hWbXmg
         Xa/KoGVpWjBb3JHGAj/N2AlwpOEbV9JreH9rVeI2fj9OUJ4GLRn13aTXdp1yrVfoY8k+
         7wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775847835; x=1776452635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOF2ctLto8Cga4gZZCbhmetTXKvSPuUuwNvxhc3GL68=;
        b=kqHWdSnMS0NBBXZVQs1ajZHvDx8ikxuFasSk7a/bFSeynyb/HmNNxs5RNDe6HAb9ON
         ZEQUvJRCu1mUbtk8M73Dq1axU3IuP+u1kqYjVQgoYkcYdXklvKux8sxF16gv+XWiFGcW
         hng9rq3X8PXpaViBVZI6jFEPrQsEuNwVjovaPv17XSmM8OGCRtph8ETB5yLiSFrMJb2k
         CsNDTRR8yr5g4CdaWxztkC9lSqokmcdzyWzkMwvKa8gpWtCuPKNR4oMi3seCB89229ib
         UjD6mc2WYlP7k3aYDkkaHOp8RYH5oGNbxCkWFio4OfuHKk8e/jobOrWStcu5LoDRsClu
         lOwA==
X-Gm-Message-State: AOJu0YwnYlYCxhzGh0qyFQBR3o+PFVWsd6D+TvS/wtVXHrDYLIcwjvFS
	g+7aDcuqH73wtxdYRJIOCPgRrNe52V9Jk5PjcgD9ozm0Mq8/TwLGmniijewdmLuE
X-Gm-Gg: AeBDiespVAq4cTer+Xk4iNqoQfCIdZMGW2Eb7W2nuFNNegPZktA0soSbdy6Sv+qOF1z
	qBxhzDC7rKNs6Qv4mvccd8Ehfay/faiouWb9nCOh1qEMdALbh0oNqpz4rl4xGaE9kM5EvZY6mc8
	rv8NDSdEsolurPwtTrLOGQpsO/t5Wo4mCJpW+yoI3B+JbkZPjESAbGEr3NJYy/RH1bt4cInHHeS
	YHjbRE4dpVyL0Zte5ES46pYbtC+61dLksOQn6jMO7z5rUdz7w91TitkkhSReuezkkxHUMALC6MP
	T/4ZU44kHyGCyMl8niAe3CjZ8PJX9GQO9JnRj3CFwdKeMQ6oBZD/Ydz8aR/V+2gGjdwkVPUv+C9
	MDYTudJZlukoFY+tgV0xkuMV4trL1txUswLL9Snc8saEUDT+Y1wkk+mYQ/TGk2ekjS9vN7UIYNY
	QQEMqn4KbWS+IG2vT+n65cSLv04ghOCu+vzF0jg7/w2G94yDnM9sNMsmRxWHcNhqP8o25Jxt2FY
	YkMi00UGcYieTbadflUosBGA4ZJasVpf5zhoRm61fPwXb71UndGzegIC4HzamKXFSuY2afy6tg=
X-Received: by 2002:a05:6102:1621:b0:608:6d10:e415 with SMTP id ada2fe7eead31-609fe9b1602mr2080445137.8.1775847834660;
        Fri, 10 Apr 2026 12:03:54 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a47a0dsm30598726d6.22.2026.04.10.12.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:03:53 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Yi Chen <yiche@redhat.com>
Subject: [PATCH net 2/2] sctp: discard stale INIT after handshake completion
Date: Fri, 10 Apr 2026 14:59:17 -0400
Message-ID: <bea8a0dfcc56b9980cb914b54cffa9dd9948ba75.1775847557.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1775847557.git.lucien.xin@gmail.com>
References: <cover.1775847557.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,strlen.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277525-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 380683DBC44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After an association reaches ESTABLISHED, the peer’s init_tag is already
known from the handshake. Any subsequent INIT with the same init_tag is
not a valid restart, but a delayed or duplicate INIT.

Drop such INIT chunks in sctp_sf_do_unexpected_init() instead of
processing them as new association attempts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_statefuns.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 7b823d759141..3bec026ecbc0 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1556,6 +1556,12 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	/* Tag the variable length parameters.  */
 	chunk->param_hdr.v = skb_pull(chunk->skb, sizeof(struct sctp_inithdr));
 
+	if (asoc->state >= SCTP_STATE_ESTABLISHED) {
+		/* Discard INIT matching peer vtag after handshake completion (stale INIT). */
+		if (chunk->subh.init_hdr->init_tag == asoc->peer.i.init_tag)
+			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+	}
+
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
 	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
-- 
2.47.1


