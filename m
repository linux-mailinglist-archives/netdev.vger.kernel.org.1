Return-Path: <netdev+bounces-277864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X9wkJebg22ngIAkAu9opvQ
	(envelope-from <netdev+bounces-277864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:13:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0BE3E5591
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D02630022FF
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F803624D7;
	Sun, 12 Apr 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+IoMKxO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7635C193
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017635; cv=none; b=Tp4ctKvPKD4w38LladNvgPNpKMNgLu2C2+6DlLJsaGovstE6G8ugEqx5dOKI2yHTwKYN9tcSO4DWfppVwQZKX3SxCxc9srecb+0dg+Pfh337Kj5LKDEylEnA6VCpbxcGKRRg1Wizhh8XmXBV3fC9Eo2notuOYCRRDE035WYrN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017635; c=relaxed/simple;
	bh=NhZM8bs3RhTPz673fFJW80axbNGRWxEwHZSZjykdlLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eo9pneKTH4KM7n9AGL3/2/GIinYKb0PmhrYsRguzug+4Qoa+NYvuyGlT6avNIE46LjUTV7jEXO52LDtzkAlwgUJhwOu9FGYVId5N594176aBWO/5X5aJOYNMcA/7K8CjFn1y1pByaNDyRP9Gj6BIzBWCWH+PnTKB6Vymau6n7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+IoMKxO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cfd44fa075so440775485a.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776017633; x=1776622433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUvMH4jKlGMfrlBo9fO9WI9tZfaDnciCa8LXMEtn274=;
        b=R+IoMKxOk3l4PcsB99+AUq9BrC5WktRbK/lTyoE5TcJw/6GyU9QCcKeKOyPByw+bvl
         sgI9Izs+r1cO8kV/AMepbK1iTHHwZLFFSczrk6W+iS5Vhkz9LELsintlXBjgaaYHV2tF
         YB8HBaOPs6b/zbMFTTgISHEx6waOOPlTKCqiQNgVh/cJ35yE6u1zmuU9H25WBupKR4xl
         J4oejynawbn4YWk4ZSFTCkGuLdQbC1QHWAxTvlVqrcfs4R40OmkNdy9To78NnANeKhhT
         arnae0CPynk43CPSQXX6vK77co701uOZHQ6Oke+/9/IHoFpPrMrzaYCDqj3rDGitaUqH
         ftCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776017633; x=1776622433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUvMH4jKlGMfrlBo9fO9WI9tZfaDnciCa8LXMEtn274=;
        b=e1coqUEGb2NOSgjGnk0yQOI6VGGwgrDpvwlYw9Gz/avEVehBl8D4cBRUtdWFyH2qsj
         Tw8izMMUmSUwC7a0d/6gKvLQDxs1uO7graATBdWoqbvvA1twm2VSyqvE6Qr6xCSa0zl8
         YtlHY/vt+5U5ZQZYgvvybwVRmBmMtwDJZd3aDdzMVdSHyKziyMhcvjkEzdugu00XEam5
         dehOrN4lfX8nXFEH5YbQ0qFZIMgLQNZxj4vSna9Ib6TwMT28gRm4G+INPTpftiU0+AHJ
         KdMaisFqf6BpQTT1Fyi0X5T9TcG5C2hrEe6JXpyJT+F8UnXJpse0RPs5yVVO6y6hveYn
         pCXQ==
X-Gm-Message-State: AOJu0YySCB9MigO6O4pCEt4t71hvslVbsQZZR1d4f56Bz2tY5A0tx2wa
	5PbyqHwjSS18lEyy375YdzUKGusUk4pVt45ZLxwYruyC2SZdJ2V2+SOBC0knxOtR
X-Gm-Gg: AeBDietS8wr+9V+nniv6b6gM6zXVnQ1j+K8yXxEkRwH3We82jsIqEfr73EfiqUp59Gc
	Tl+tHMULRoZy415NTGcplOUldfyqvaxE4+7GAu2P1CDdQidCjAEciKelycRy6gdKHRViKfdwaR6
	LhzpaCaX1hXCdoTS+9YFP3I7Wo/tNU6EKK11Fex2HlHY1B6hygaxgcNKwBxejP9rY63gyFZPh8X
	rxMhnYya7nMYv0vcRyEUlGuSjAvRKP6x4G8X/W3qMwHnr+kUjRwQM2eioJNTTDl2oRUtxxhppiD
	5efWRSnsP1mhQb986QJo0y4CvPJsoDEVyTFHb+5/1z5Kzaa6kDEgHBdbnLJ+uCxsihCMozPvi3Z
	qbn8Jhi3HeqWZvb0UFNVh4bcAGaFzAcboFpH18SiIuE0OpesKAC12H6aRAhGdIBe9iPoLIzUGHQ
	Kz0s4KL6Ix9HPt7lCNgV9gOIFhE8z+g7YzM/wQlI0we8SaM8LCQknVOe09dhftbTo0k+vLXgkvQ
	3a6+ByZOzJJrOGIRYG3lWzSTZkK4GiW0OKMdM1ItqZfdHgTCu+sP3eXLApvL6yA
X-Received: by 2002:a05:620a:4722:b0:8db:de3:92a1 with SMTP id af79cd13be357-8ddcf6b5bedmr1591752085a.48.1776017632893;
        Sun, 12 Apr 2026 11:13:52 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6b895sm700538685a.31.2026.04.12.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 11:13:52 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: fix missing encap_port propagation for GSO fragments
Date: Sun, 12 Apr 2026 14:13:51 -0400
Message-ID: <ea65ed61b3598d8b4940f0170b9aa1762307e6c3.1776017631.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277864-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2D0BE3E5591
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

encap_port in SCTP_INPUT_CB(skb) is used by sctp_vtag_verify() for
SCTP-over-UDP processing. In the GSO case, it is only set on the head
skb, while fragment skbs leave it 0.

This results in fragment skbs seeing encap_port == 0, breaking
SCTP-over-UDP connections.

Fix it by propagating encap_port from the head skb cb when initializing
fragment skbs in sctp_inq_pop().

Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/inqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index f5a7d5a38755..a024c0843247 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -201,6 +201,7 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 
 			cb->chunk = head_cb->chunk;
 			cb->af = head_cb->af;
+			cb->encap_port = head_cb->encap_port;
 		}
 	}
 
-- 
2.47.1


