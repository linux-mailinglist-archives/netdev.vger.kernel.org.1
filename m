Return-Path: <netdev+bounces-297327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nHACEeCQKGpVGQMAu9opvQ
	(envelope-from <netdev+bounces-297327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:17:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977646647E8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:17:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NiPiqv1d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297327-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297327-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1697A3039C90
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E013735203D;
	Tue,  9 Jun 2026 22:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868A376A06
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:14:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043272; cv=none; b=jG61QUvT4iAjZQLbK26ngSLVVgQnBPkHrpL4pewqak7p9ldt+jm5sr6/AhCIIH/S2dhRiSwYB7Yc/tuDmrGxBjjnVnZGh8iPJ4H6RLHSy98fk3RzxM+TtaLfH4MjQtfxhWWCTs/tQShAteR5BEnMWNVeWogAWJyFxWeOd9J31KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043272; c=relaxed/simple;
	bh=LZcwby4Bb4TbDeDCNMBVA4quxqqIh6MKQHqvVIwT790=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XoGPbLSppJWJm+aEhrrEemxlCshC7JldImBz3DWWdIOOAEiAl2lXnoPjd4Md+Y+Rx7LlT8UjmmI9QBO8g01qNuuYkTlbUgQsXhy7/+lOsLrT7YH/vIdCAI3Meug4KooNvdwlDj4ge1vO4gB5CJs3ufIzy8C/510T8meHRe9CbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiPiqv1d; arc=none smtp.client-ip=209.85.222.169
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9158c621ebbso707585585a.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781043270; x=1781648070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kXKq1m53vG14SwgeaJGnhYHB5gI7npB3nTQR+Cx4Mk=;
        b=NiPiqv1dhqn/nToBop9CuV3dk4QxAVppUW2OLSvNQywJ4fuYAKRuwrZPfsVD467VGq
         Evu29cWgrphWcBiQvil0OrOFcxBCJrIshempS0aoSfqe/WjlL71+uWn2sxp6q4yNWyWP
         bHzuWLxLsx8rs4Iy6Nz6Oug30VYoANYoUbaSY4kJYQbyjjIFCoZbjVwebFwxG/TYx6a3
         fbb9rknh0pMtSFWluV0/7vmVoYmme9Aom6DsoHR/18zxQC8K3bmvOpz6PNcpwEUJHvNL
         /+cHfdITLlZV0VHqbLjWLEF1ti8wLB7+j1oTOvGzuWNp8RFOtwkYhnECX528ZpMhNCet
         L16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781043270; x=1781648070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kXKq1m53vG14SwgeaJGnhYHB5gI7npB3nTQR+Cx4Mk=;
        b=mQB6KRyJyMrHriwRsLX04gepRz4sYtoHDfUmoOIh9YzLiqwPlPvC1nbNPiyNCLVMbb
         tlRYfpgOPOXmCzikdkFhQRF9AbR+Vzbcbb68MReUHQ57pmRaYb1tj+I0fbGkASxbgl6S
         WvPhG79m4CyRBkFAFm4bxR4zvE4IKz3QsvPrJYhXm4S4SHOrxWklmqKZ9UFAsUwS6cF/
         6V8pqwDwCvjT8TF7HKgeWgIvkpcY0EY0ehee0JDicjVlPwKTm5tw/2ZBPW81q6wdtS4x
         Zf2D4WR7RpkPcHXS6Z9/hw7D0h6hrq7VNLnxJWktZoT+jGFvk8Eb1szHl+UzauPcgoFw
         OgGA==
X-Gm-Message-State: AOJu0Yw+NsIGs+Bz6YLiJ/16wgx383qw9Mtqv1r96DA7NUi6o0qtdTIN
	aq/ehxpydXNngAUhoLTnHVX7L2jYpruieEottGF24eMktt3INDSzi5sr8q5W4w==
X-Gm-Gg: Acq92OHo5Wl2uScwAB7S2TTJ+qREh6+SHv3BWozN502jOeYNVmEjjra3O9o6hLVrd6H
	qhH+g3HN6VEVcmbF3WYDAvSh/l6tpbUttV5Tac90eGet+Qp+54/7CjJ6VHHCuo/oWyaTH9RHI0Z
	fpjtR2xTiTiaUZAAfHc/9O9Cu+h1Q9Ai4YUMv5urxk/e7WqjiPqovgtXbjnzcJZkvBZeyl3q2pX
	HfUR/0sINoqpIMwSCdy6vhPzfV+EAmqMovOdDW9ejA1VX0avqTYj6i4e8IQ45xP1irC4o6dGaae
	byNBhvSqorQVHsWnw5jayhDfaoeYTng/7FQDfQrrowe/v8THmf2NbS2IUe5zujqzSWO117xQ75y
	eBfba/IFvTgtWivY8oSleshVM9wdVmZktNDpL1hv26nBGbduXZS5Qbvl1H9geRW2KESXGwEJQJL
	TymYV/bUe5FbD8l/5Qu2TfboowXlllp3T1TLBNP3NNjBOXHD+n4QCeMCWGbPFnTaFAD9bNrbMXF
	OPidml5z7vyB/82H94gdGvI3wgntgofzUcC8EM5b8FQ3IHGnvpm5fpRFtcMyyON2RBf0VEK+IZV
X-Received: by 2002:a05:620a:4107:b0:915:98e9:2c1 with SMTP id af79cd13be357-915a9d76317mr3631128985a.32.1781043270404;
        Tue, 09 Jun 2026 15:14:30 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a2465e7sm2275354885a.19.2026.06.09.15.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 15:14:29 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: validate embedded address parameter length
Date: Tue,  9 Jun 2026 18:14:28 -0400
Message-ID: <7838b86b69f52add28808fb59034c8f992e97b2d.1781043268.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297327-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 977646647E8

sctp_verify_asconf() and sctp_verify_param() only validate ADD_IP, DEL_IP,
and SET_PRIMARY parameters against a fixed minimum size of sizeof(struct
sctp_addip_param) + sizeof(struct sctp_paramhdr). This ensures the outer
parameter is large enough to contain an embedded address parameter header,
but does not verify that the embedded address parameter's declared length
fits within the bounds of the outer parameter.

Later, sctp_process_param() and sctp_process_asconf_param() extract the
embedded address parameter and pass it to af->from_addr_param(), which uses
the address parameter length to parse the variable-length address payload.
A malformed peer can therefore advertise an embedded address parameter
length that exceeds the remaining bytes in the enclosing parameter.

Validate that addr_param->p.length does not exceed the space available
after the sctp_addip_param header before processing the embedded address
parameter. Reject malformed parameters when the embedded address length
extends beyond the enclosing parameter bounds.

This prevents out-of-bounds reads when parsing malformed parameters carried
in INIT or ASCONF processing paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: sashiko <sashiko-bot@kernel.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_make_chunk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 85264862fb6b..40ce2cea7b53 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2636,6 +2636,9 @@ static int sctp_process_param(struct sctp_association *asoc,
 			goto fall_through;
 
 		addr_param = param.v + sizeof(struct sctp_addip_param);
+		if (ntohs(addr_param->p.length) >
+		    ntohs(param.p->length) - sizeof(struct sctp_addip_param))
+			break;
 
 		af = sctp_get_af_specific(param_type2af(addr_param->p.type));
 		if (!af)
@@ -3034,13 +3037,16 @@ static __be16 sctp_process_asconf_param(struct sctp_association *asoc,
 	union sctp_addr	addr;
 	struct sctp_af *af;
 
-	addr_param = (void *)asconf_param + sizeof(*asconf_param);
-
 	if (asconf_param->param_hdr.type != SCTP_PARAM_ADD_IP &&
 	    asconf_param->param_hdr.type != SCTP_PARAM_DEL_IP &&
 	    asconf_param->param_hdr.type != SCTP_PARAM_SET_PRIMARY)
 		return SCTP_ERROR_UNKNOWN_PARAM;
 
+	addr_param = (void *)asconf_param + sizeof(*asconf_param);
+	if (ntohs(addr_param->p.length) >
+	    ntohs(asconf_param->param_hdr.length) - sizeof(*asconf_param))
+		return SCTP_ERROR_PROTO_VIOLATION;
+
 	switch (addr_param->p.type) {
 	case SCTP_PARAM_IPV6_ADDRESS:
 		if (!asoc->peer.ipv6_address)
-- 
2.47.1


