Return-Path: <netdev+bounces-291482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDbVCSvGFGptQAcAu9opvQ
	(envelope-from <netdev+bounces-291482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6945CEF42
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1772D3009F56
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B923932E5;
	Mon, 25 May 2026 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYhwx7AA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7A315793
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779746340; cv=none; b=WEQguv7FymLpWdN8I7Il3RGafTTuQ/ubcMYJTQz4ieIfcGjZmLFYFsDPGq178+8xC+fcW6i4h/oslvSAcGJ0jY9PidZM43gcTjYnVv34ocS/4MONeTkeBbtXk5/vwF7VCSS5VLscq7+QWEB7akqLWEO9zvkROsRrdnlUnfecANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779746340; c=relaxed/simple;
	bh=CrEqzrWNX5i9EDnlY0vi2gqf/6FcRMTl54dk6duo848=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bQTo4ixVXOCeyBwztXJV7zP/BWQLX1EhjmjdSqYcYFy4u3KOq3WsajRTblMYuCEtgK66A3lJFsVM55dYtDsy4W4q/xpJRy/wWI9YvtnNXWa6MYJeRDn8feuvgFwqsF6pS7X3hoQpIUF6W8uR4Qudbgj0aMsS8QtBupyTzZzxKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYhwx7AA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2be1dd4af34so87751605ad.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779746338; x=1780351138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3K1QSVKO4xxnbI4UIG0vqZ1FFpQ1DWBA52T8EZUsAFE=;
        b=RYhwx7AAWTMK1flituky02TvetZupOX2fByR8+cIoa36cF2i6ozHKSfQtmDVer4NPd
         FeOsw0rvrx+xsKy6OtUS2jgY40VYq0eP5hiOqeJTAVPtsddls6ItKDWMeEc9UCM0MWAw
         A7VUOud/hUrm0U+tA8ZXTfga+xASs+94mjWGCmiDh3NnT0fg+uhHxxT7Fmw4iPSVTZUH
         Ahl2Fhm0iWyFR6qy0F3BSO75hEdVEjm+5d+gZWvBJmjLBuN9e/w/GVehYrKEgMrbK6uK
         jJOWjMuuAA/LHRd/t11d/7MIL+m/8zUv2z8BnCNeBR5MClnXd+TAyBjV75th9iDEw0ZG
         EPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779746338; x=1780351138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K1QSVKO4xxnbI4UIG0vqZ1FFpQ1DWBA52T8EZUsAFE=;
        b=SSQctShNnp3qdpTQ/Szo7sYFXdlkp+fi8+G2wUGZA1/SMUDvd5j36A3d4o2bXY9AtA
         vfdV6SNA2V7lMpd4NC0leZrJGX0imdNvlRCk6mmH1Mrpq3W/NCncuF4ebWELmufuiulo
         22V18SazZ2Pyd2Lk0EVju+JpYYG1LTbWGv1wT8ozYIItTAVPse1ztfz7pQPKRgRS9NBh
         jFOfxOHZm/UAhnm7gtSFnIM/eMJs3tUvi6sGzOyBzwkNEyWv5yWAodIsos2cPUl9pvsF
         O2zr5DeLmJM13n/0gGM7X+TWML69d1h4PlH69x77aky8jBYgM8XZVSdRf1hrrKZk/m+U
         8UtA==
X-Forwarded-Encrypted: i=1; AFNElJ+KoHxqMl1HTYZYW33JzSPjxnNR+o8/fBX5VCuEh3isUM389uWQtq8nWv42lUVsMKTxhhrfEJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5VLUU4/AsDwD6tapUth3k1u39fGQEOHEK5gvs2KzkQ5LfyT8
	jDr7PIM5uU5djx7Mn0Z3fTY1ukVwep/zm7GGWgfY94O7fMZxuYY1IgS9
X-Gm-Gg: Acq92OFkHjNnFF8FfwJItqGmx2rQ2wykSSVKUcgYtHblLS4XeHKNbbvkqkwQLDq7hSf
	wC4x8StnOkIyPKl7F1wG2PMRIqsCxBBJ2ooxN2UY6snVaJP1bx2FyUo1P+/Yt2+Fo+k/Es2+WlC
	LfsxfzbaK+PKyM5USVlVrqpOGwRs++s8NawR4i0TPFERv/3acwO+7g7nzMPPyO1eTKp0MhJJKMD
	dsMbg7d9IHFiRNz+gSuzw0SjVJDlMSqNcI9QnrAab1q+5+U1DqoXjoxx0QgoaWHQAzIJRswvDDZ
	LNBYMykchAQ5ybz/LEFJWQIUiGFtbF4rmQDTuoqie+qCl1jKTjtcbuPqjGMdTQPRrJFIFovWWrZ
	Bh2L3SqlWmnAUlPlAcsz1IELWE7Fkh9PW/QL/Y3Q+pSqasTtCTyR5jo3/axMpg9tJYSPrVlYYJN
	hwc24Yw8X2BE5upnSkH7jeDcyugk+a72gA+WUT9sTRURyy+BHn2o3/pB1uVvzFpWr5K5/IVRnP7
	+C5G3BCszoxZ4qhwCqppyqQiB5nvLxCvaq8+z09O0JIXQ==
X-Received: by 2002:a17:903:15cf:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2beb06920femr168393165ad.41.1779746338054;
        Mon, 25 May 2026 14:58:58 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56b9fabsm131699335ad.23.2026.05.25.14.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 14:58:57 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	linusw@kernel.org,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	coreteam@netfilter.org (open list:NETFILTER),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] netfilter: nf_conntrack: use get_unaligned_be32() in tcp_sack()
Date: Mon, 25 May 2026 14:58:40 -0700
Message-ID: <20260525215840.93217-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-291482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0D6945CEF42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The timestamp-only fast path dereferences the option stream as
*(__be32 *)ptr, which assumes 4-byte alignment that the TCP option
stream does not guarantee. Use get_unaligned_be32() instead, which
reads the value safely and already returns host byte order, so the
htonl() on the comparison constant can be dropped.

This matches the existing get_unaligned_be32() use later in the same
function.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index b67426c2189b..8993374c9df2 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -405,11 +405,11 @@ static void tcp_sack(const struct sk_buff *skb, unsigned int dataoff,
 		return;
 
 	/* Fast path for timestamp-only option */
-	if (length == TCPOLEN_TSTAMP_ALIGNED
-	    && *(__be32 *)ptr == htonl((TCPOPT_NOP << 24)
-				       | (TCPOPT_NOP << 16)
-				       | (TCPOPT_TIMESTAMP << 8)
-				       | TCPOLEN_TIMESTAMP))
+	if (length == TCPOLEN_TSTAMP_ALIGNED &&
+	    get_unaligned_be32(ptr) == ((TCPOPT_NOP << 24) |
+					(TCPOPT_NOP << 16) |
+					(TCPOPT_TIMESTAMP << 8) |
+					TCPOLEN_TIMESTAMP))
 		return;
 
 	while (length > 0) {
-- 
2.54.0


