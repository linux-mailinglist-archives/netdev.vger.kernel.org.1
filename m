Return-Path: <netdev+bounces-258665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOe/FLF6j2mWRAEAu9opvQ
	(envelope-from <netdev+bounces-258665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:25:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A11392EB
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3813F30601AC
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2101288510;
	Fri, 13 Feb 2026 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FWAN02l7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17327FB18
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010714; cv=none; b=proMGTLG74JbGdirYUYWwXufn+WbLswqKUJuRvhFhYiW1lNeNZ2MhAG1AI3016Lnw7dTaIyPPBDecY8xb8SgsrSmkxHlczGzjXKPZCKm6irOi7nV9niRHa2v1RFzZO8DUy2wTZoK0PGuNjjXqZw/JaaLGeN4bou/X0QuJe0GQXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010714; c=relaxed/simple;
	bh=HxJrMbeqXcLJ7jwAcnLvGHnKT/8SD5w7KYtlEzmthjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfWV15NjYtlItG+pdhoR1a6vo46fc1PsdCPVmAarQEASdBiPldGMTy7YhJWWT0YSnJwL9u79EiwJJqiSNqraNwtY99wcR9Y5/GvQd688tAP2Hv9hpn2Aq+hwSK4tPmRSM8eNT1cfd+G0SbPDxT1111OzbggDJHU0R4zNeLU7BMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FWAN02l7; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f171cb842so442633b6e.1
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 11:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771010711; x=1771615511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aoOSJwVyB9J1Umbf/jB9a0J8hI2uhGyBuTDAcDO9GA0=;
        b=FWAN02l7RW1EhC+6NVWRdMTquVC4hc/U0UV7RJFD2gJpaxX9s+GfYlOUuNYjODOamy
         Of5rvi8F2kmwoQkV+ol8xogdOD5PuBDUBOg19gmQjiuRJy8rRtx6T3ENms2hoiOo3obJ
         Qs8ra5R6/qVLiBDjJPwPRzNZsG88637hSesSGf9ic5Pj9c3ejzi3QfmLxqvcsFUhP/ZJ
         9MNa+k0zNTUH7XWM3aZDGJXZ2x26c3mOiTMJGUvaC3A9HHPWACGRuToCMZIKBTxVW2wf
         P+6hpjlxZUzxVfjLG/y58QdC6wtBYywkmzsCfpDYxifSsg0aEEwmlkVFFVWIb0VRvn89
         KtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771010711; x=1771615511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoOSJwVyB9J1Umbf/jB9a0J8hI2uhGyBuTDAcDO9GA0=;
        b=P3ds+D3sXJbdxP6D6vP4U/vxwHZB0v9YtwEllf3rB7UabUzNdFxlVVrxh8TOMn13Lq
         7ezOn5IJoNppN+HnzJJ1MoeLJNDSX+H7iCb2CSQad9khUyCmn/FtIl7Y+bGVqhYHwjR/
         R2QzCN7Y8CKOfjXs+LEtzJq/Yy2lQb23lKwohXfQuYQ0sXsdDRJBBMofo8UbkkZw0s9C
         58hAiXnc4iZc5usgrJDt1X38am00A+gDqsoXjqN2An5tpuUyXBJfvIxjjbuNSu/0O6YH
         7fSsjcIDUdhJHM40XTCJ24xJNwvRo8Rm2TyarYeXJHvq+QzeqC996Br42Sy3mvVV+fTS
         gLcg==
X-Forwarded-Encrypted: i=1; AJvYcCXjVI8e2/2vdDcjdI9cfB7t86VOCVQRDJ2FR7PAxYYDFlDrerYQkRtZiWc4WYusVqTN5dOLdYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEyBmIe4bj4HXBkA6Hhba+CnIuF0NVvKrTEm5pvlxlp0KxvgKo
	EQETqmkrIp1Rfv+bTOPS/Au+s1CLqAlWKWbXb98F//xn3DE8NAHONL383Ar3zqI72Rw=
X-Gm-Gg: AZuq6aJUaBtk0d2hNzxra6nTC/4W0VommtncGB3Unx0Ak+8vSw769Cjqdo8/mlMMlIk
	U+6wYyBUTg559kkQ7kbNulrafdrVFvvFGGacl5n7sChomDE8vcrDux4qGLQMEoe5rkrUlZIfOP7
	mpSTi5d3+trLpDeLYmRkei794KgkAeVJl+w6mn7XYFbYreuDm4/CsArAZjNOeoqBGa4MexrrSiq
	+qmKbdQed9rmbVTtk2eLMB8aKh96RctCb1tO9+7e1fRDSMDcXwYl7N6uiRjBtFyVn2lWbBv5Sz7
	qKANG0W6LvbIPkn2ExYDW4v/MyKeZHmtN15unGxDA9+im3WDVDNNZjnAPK9IQlcFPbuzc45BJJU
	j8+gzHYyNwULvM9CEYz4hFnJMZT/fZkkkMRDi7jfK+d5qLyR5neFOGt9wZ+EEKzrXbn1iZe99pA
	9J+NCXsrUK
X-Received: by 2002:a05:6808:1991:b0:45f:103c:2483 with SMTP id 5614622812f47-463b05c9dd5mr799401b6e.23.1771010711349;
        Fri, 13 Feb 2026 11:25:11 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::499:50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76f96b8sm6591407a34.21.2026.02.13.11.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:25:10 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	jbrandeburg@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 0/2] bnxt_en: Add XDP RSS hash metadata
Date: Fri, 13 Feb 2026 13:24:26 -0600
Message-ID: <20260213192449.1294830-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[broadcom.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258665-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Queue-Id: E70A11392EB
X-Rspamd-Action: no action

This patchset adds the ability to use an XDP program to extract the RSS
hash of a given an xdp_md context.

For example this XDP program extracts hash and rss_type:
```
        ret = bpf_xdp_metadata_rx_hash(ctx, &hash, &rss_type);
        if (ret == 0) {
                bpf_printk("XDP: RX hash=0x%x type=%02x", hash, rss_type);
        }
```

I was able to test this with a Broadcom BCM57414 NIC and verify that the
rss_type and hash were correct for IPv4/6 TCP/UDP and ICMP traffic.

Chris J Arges (2):
  bnxt_en: use bnxt_xdp_buff for xdp context
  bnxt_en: Implement XDP RSS hash metadata extraction

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 29 ++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  9 ++++
 4 files changed, 77 insertions(+), 10 deletions(-)

-- 
2.43.0

