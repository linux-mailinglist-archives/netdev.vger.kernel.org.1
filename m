Return-Path: <netdev+bounces-283614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gZTHIhxq92mhhQIAu9opvQ
	(envelope-from <netdev+bounces-283614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:30:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FC04B640A
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FB943001843
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512CE34B1AD;
	Sun,  3 May 2026 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJkgdQL2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F9349AF3
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822231; cv=none; b=ROJOyedvjW+qxbQwk5dlSMvUnRQlLkZkwcOLinQzZ0nU/hylkWLl55hba9ltOE7nPxdv0vsEns8AaAXmobkXLDolXHmMdiivLAxf5pGdVDGvGP2OaSaMgZinSQharE8hsmfN5UbGG1Tg6AgKu4pK8MMhKM/Wv20Mq3frQOLt2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822231; c=relaxed/simple;
	bh=CaMKkMANofvnBLXeDs9+XT1DBekDSV7aUJqdERMMQS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0SdNr4QaT7GZ8npvjBg8UWDio4s+6qoLBR7hPxx5UQ641R3L1We9L22ZTN4w4SkFCRclmW8kihWr2e23WLA7CAxdVnLapprnUDYt+YyEaqELDEbjGvRCOgUZEaKGZRHVpKwi4rHyb/y1/n8waSgxWv53TPgDAKkXqxO623Iw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJkgdQL2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f8bf96b46so1445191b3a.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822229; x=1778427029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bCnUgQUkYcHM/3ZVdVYXTNXTP37ikuy9bFg9QUtBhyU=;
        b=DJkgdQL27XJu23qBc7EKvWOIN+E9QYUhGCgF2N8qR+CDLd7LevJpzZqzXpHi49owXS
         EI7p9X8qOLcQVE3HR46y2T1OIr34WAb1CUQQinory3MtGJoMaFdY1hGXIiCnkeJZsspk
         oDRgIfqT3IDR/jT1VpO+zXmVgreKWD2qFpW7LDGXbVV9oO5ESPTCBszxzISHyrg/SmZK
         5i3CQid4ZNBhrHvWRXUx5BnmxYnf3W2e8AlrIj3m2ahxw3VCni/FdeQxaUJeL2E5aniP
         m0wdW6VCT2aoJpSonFR+vVuZPrO5f/UaTuD9FHYWlfhOjgVFkRsYDfe6rfs7AYvrdYLO
         JKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822229; x=1778427029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCnUgQUkYcHM/3ZVdVYXTNXTP37ikuy9bFg9QUtBhyU=;
        b=tVhNcj7EF8ock5ZwxEdib93soWUondTRaGaPFp9+Ra85O+qomWVtgK0HWjluzcNjce
         LLH2CEm4k5c49wXBJOaDL42jM3Q5dgxkkWkR13wS7isAfPxTOjqwg0Mfeu3tRmovti6m
         ZKyjz38U48alqFQAyO2wyMFINQJaMicX73cq+FszMsFNtcDf3TnIjR8Pg+nNTohWeNZE
         1LqPT1lBKW9aw0QgRHRMJ4YVvhN01JHADPMb9WHAV9K8RrFGecbp4C/EtGIxFlT8gC3p
         6HB+fyBXxgafX+V+ZjoUYJv/C/Cq9GpKzk1KaZy52BgU5Loo6UTQz90BRSBP348NT78Z
         RDNQ==
X-Gm-Message-State: AOJu0YwpSJntLCs0xE0/4JNbM16n4Sjj5sLcxwN7rhk9xEtOaoVGTEJ+
	EfaYHgjf5oQ/AS+8K+Hs9aTnpuFX+pS2LFsGrj9V8ohJRLBANb5TLtv10Mza3A==
X-Gm-Gg: AeBDieuOOYsrAwYFUFYp8poFV5R6Rt2YmsbmTQwf/EOiy8rqM4qe3vYdX3OWd2uBJ1b
	PSGwvAaKx274GNUmt7bXMJJs/9qTsuhzPiVjMpN8yL0PrB0xu4Nsp5Ye1ExRLzARZUjnbu29R4X
	LJ8r5gfwl5rR5XV1SddQcas3fdd1xrTv4py8wHqQYzvaNyR6xMnAMQZgk75cG42Bi4fRE3lduFE
	uT8iV0/N0uASuropdxv8IWqk2ZcnM9ddMshyEjb9pSg0zGY98sXIAwdrI6sG3qFhwq7RZZa7MUn
	7Dgmp2dNKK3O6jqG9gxJxLBj1X+6L9Pd/ldNPTT/6sBCaRdXBCB7Rl6hxXZM6dYm2aLvQHayox6
	ancQkgUcCGqvKDUI0IKNUu41KGJZ4knTO/GhF9e3aUWcUo9cECVXnQNKJlj5dIGE64hpOXu5Bso
	Lqsv78IVrxcr/akhZaglondS1HWSs=
X-Received: by 2002:aa7:8b48:0:b0:835:6bdf:c88a with SMTP id d2e1a72fcca58-8356bdfd5b1mr1598187b3a.8.1777822229144;
        Sun, 03 May 2026 08:30:29 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8352bfe7a49sm5589667b3a.46.2026.05.03.08.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:30:28 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Google-Original-From: Yuya Kusakabe <y-kusakabe@bbsakura.net>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next 0/6] seg6: SRv6 Mobile User Plane (RFC 9433)
Date: Mon,  4 May 2026 00:30:00 +0900
Message-ID: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78FC04B640A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283614-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.985];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ietf.org:url,bbsakura.net:mid]

From: Yuya Kusakabe <yuya.kusakabe@gmail.com>

This series adds the iproute2 frontend for the SRv6 Mobile User Plane
(MUP) endpoint behaviors of RFC 9433.  It is sent in parallel with the
matching kernel net-next series; each commit here is self-contained
and brings in the seg6local UAPI bits it needs from the in-progress
kernel UAPI header (include/uapi/linux/seg6_local.h):

  Section 6.2  End.MAP
  Section 6.3  End.M.GTP6.D
  Section 6.4  End.M.GTP6.D.Di
  Section 6.5  End.M.GTP6.E
  Section 6.6  End.M.GTP4.E
  Section 6.7  H.M.GTP4.D

The series adds these seg6local CLI keywords:

  src                  IPv6 source-address template
  v4_mask_len          length of the IPv4 DA portion of the SID, in
                       bits (1..32)
  sr_prefix_len        locator length of the egress End.M.GTP*.E SID,
                       in bits (1..88, leaving 40 bits for the
                       Args.Mob.Session field)
  v6_src_prefix_len    Source UPF Prefix length P in the IPv6 SA
                       template (1..127, defaults to 64); requires
                       P + v4_mask_len <= 128
  pdu_type             GTP-U PDU Session Container PDU Type (3GPP
                       TS 38.415 Section 5.5.2): downlink|dl|uplink|ul
                       or 0..15.  When omitted, the egress emits a
                       short GTPv1-U header (no PDU Session Container)
                       regardless of the QFI in the SID; 5G N3
                       deployments must set pdu_type explicitly.

A small per-action attribute validator (introduced in patch 1 and
extended by each subsequent behavior) rejects obvious typos in the
seg6local block at the userspace layer instead of leaving the
operator with an opaque kernel EINVAL.

Link: https://datatracker.ietf.org/doc/html/rfc9433

Yuya Kusakabe (6):
  seg6: add support for the End.MAP behavior
  seg6: add support for the End.M.GTP4.E behavior
  seg6: add support for the End.M.GTP6.E behavior
  seg6: add support for the End.M.GTP6.D behavior
  seg6: add support for the End.M.GTP6.D.Di behavior
  seg6: add support for the H.M.GTP4.D behavior

 include/uapi/linux/seg6_local.h |  17 +++
 ip/ip_common.h                  |   2 +-
 ip/ipnexthop.c                  |   2 +-
 ip/iproute.c                    |  14 +-
 ip/iproute_lwtunnel.c           | 263 +++++++++++++++++++++++++++++++-
 man/man8/ip-route.8.in          | 154 +++++++++++++++++++
 6 files changed, 442 insertions(+), 10 deletions(-)


base-commit: 4f5de57e2ff11a5925dacdf3deeeabee7ba9502a
-- 
2.50.1


