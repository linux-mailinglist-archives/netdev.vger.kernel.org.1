Return-Path: <netdev+bounces-274870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JYP5BPFCz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:32:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C48390E76
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8EA63015FFC
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DB8199FAB;
	Fri,  3 Apr 2026 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqgWPvTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEA1E49F
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190761; cv=none; b=kyzz+C/ctf+tLgdlBkcHukKZ2+UR+LA49tmzsk1ZIcl/ew9LfPnscaKoQ/RsIqhbkJw0UuLWltNR3nWj/ryOqIM98+QZVo/2rr8C8CqjN6ge+t0+YolU7Bee6wtBLgyy0yDA6ZSwFIGlWvSGW7MCgIocCAcAvMgGxBnrCWfQGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190761; c=relaxed/simple;
	bh=ycuB3KMTWi6OTQGME9zvccmnPlPiO3rH3en0YH76VHE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b5qlVXfC8VDrEG2RzcHigkdMYKN3iFeLrUR2yDCFw6Xy0riXtYrsuMVOdAZZEMigPbg6J3jsj1cNeK6VQarHleSjk5t1nXh6wmu06jMccsuejA41oqkDpOG/Sl/ByeOPjmrh/44/RjtvygVui/EnQeAEh3NCdp4q1iOjKSlkB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqgWPvTA; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cfcf23c0e1so410442585a.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190759; x=1775795559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMTEtuAm423nG3M+uXxYLj0sxb1CCJ3cVV2iHAZ/lgI=;
        b=RqgWPvTAsRgptYIb+ocOC494xT9O5moOS87Ddbla6jWyf6xIAbLFEu0MsyFzVl9A87
         gMoiNJj2TJM/+8rE77GLSFMJqBNYDYC+HjIi8uR1+k2vWkgFg+LLiXVjNXQtt5QsIMtI
         tWii46xmrHt35BrBfBZSUYQCozEtJvX7Xt0wjp2fOUcGmGn0wIVZ8/IP07xqZOz4wVy4
         iqEKz8RkJZ2o0HEg3lPPD80D5+3eo12teoiuxR/MI0hoKxXJNHm1S+z8iZK960WMvAKv
         yCWSre06sjqd2cVkA57ORvV+5B8LEh2t6arQZRn84TpZZTLymiG1V7RE+vZp0asi9A73
         72XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190759; x=1775795559;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMTEtuAm423nG3M+uXxYLj0sxb1CCJ3cVV2iHAZ/lgI=;
        b=AzBsJavzbf6p4BMR+lRP3I9dxXSkjokMmVCMW6x5IFo6QVE5e5Zni4kbZ8Xz2H3uBP
         QUcQSzu3afunLGQ7BKnbq/erBcfqctRMFuUFObh3c8gK7StQ6XRbpICHAlepUsyaNvQy
         etOXkCVt5+QKLrQYgGo/yY30Ywvrx3OY+79ztsR3k3TOz38FfFQz45sjNF9gl2T7FvZZ
         gES2NBD8hIPym+Z0gFvclD1FF6fWyopqcm9s5zTQOIGljfMgUV0XRHQYPGos3VT7rvZR
         wlao5XV/lCpkJTWSaUyB5qQrbJIEPPEPd01+IU1yW2Rfg5c1Xjgl62KPVxstIxQmlaPN
         m6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZXrGeoMEjKXMGvz82YhAo8U8eoXKhcqlGRg0Lv4NFdfyYowHQ66K+QgODg8pDoI+hqidyDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOG77BtW0zA13UqCriVNDHY82A5cnRduenmqiKIF7BZ6GMVaND
	3Z9DqV5lcgZ6SQU3zJG24HcKkgfgwajvYeT5KwH7a2MJ3Gv0Ca0sgTIdJ5ftITNLx7d4fHYdEd1
	i8cKZ0jlUhCW9dg==
X-Received: from qkak24-n1.prod.google.com ([2002:a05:620a:a0d8:10b0:8d4:abda:a95])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7084:b0:8cd:97a7:a334 with SMTP id af79cd13be357-8d41b8df04cmr251880085a.4.1775190758996;
 Thu, 02 Apr 2026 21:32:38 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-1-edumazet@google.com>
Subject: [PATCH net-next 0/9] net: safe guard net/core/tso.c users
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274870-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07C48390E76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most net/core/tso.c users assume headers length is smaller than
TSO_HEADER_SIZE. This is because they use pre-allocated and
pre-mapped piece of memory of (N * TSO_HEADER_SIZE) bytes.

Add tso_features_check() helper so that these drivers
can request a fallback to GSO if headers are too big.

We could in the future add more checks in tso_features_check()
against max number of segments per TSO packet, as many
drivers also seem to drop packets if gso_size is too small
relative to their TX ring sizes.

Eric Dumazet (9):
  net: tso: add tso_features_check()
  net: mvneta: use tso_features_check()
  net: thunderx: use tso_features_check()
  dpaa2-eth: use tso_features_check()
  net: enetc: use tso_features_check()
  net: fec: use tso_features_check()
  net: mv643xx_eth: use tso_features_check()
  net: mvpp2: use tso_features_check()
  octeontx2-pf: use tso_features_check()

 drivers/net/ethernet/cavium/thunder/nicvf_main.c     |  2 ++
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c   |  1 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c     |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc.c         |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c     |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc_pf.c      |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc_vf.c      |  2 ++
 drivers/net/ethernet/freescale/fec_main.c            |  2 ++
 drivers/net/ethernet/marvell/mv643xx_eth.c           |  2 ++
 drivers/net/ethernet/marvell/mvneta.c                |  2 ++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c      |  2 ++
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |  2 ++
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c   |  1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c |  2 ++
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c     |  2 ++
 include/net/tso.h                                    | 11 +++++++++++
 net/core/tso.c                                       | 12 ++++++++++++
 17 files changed, 51 insertions(+)

-- 
2.53.0.1213.gd9a14994de-goog


