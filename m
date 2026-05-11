Return-Path: <netdev+bounces-286792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKwYM5EiAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3775E5148B8
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5E03027950
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B54A2E0C;
	Mon, 11 May 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej7mvvfd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F349691A
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524765; cv=none; b=sLasGA2/URa2RwxdB+e08g4rrcwQZIYKU3td976q8N/ZWkTMTk37wRmpNE4QCyUFn3QY0ivZA0bBc+yVRfHLorEp7tumc6pDslF1CebiupSXzcOoGjgu6WJEAsQCd8Zr8O+6lKbyUJL50+Mm3OFjpJIHjrFx0M2enB9gmPOKrsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524765; c=relaxed/simple;
	bh=3s3ANw+SQ/am5T2BSAI2/weNVVLUxcD1RZIz5+peerU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pu3bc+Eknzy1z73K17OOcejF00WewajvJQyzMHXjt1JYc/WcChvHAXPMixvCtvdaPut/+W2LUZEV8VZaJUgJaS1YSWtgPBUG/XSD2RfNSiOLRormrxu4HHQ/DsF0EyQeuPY6JrgcRECGIts+P9dAbG/v3muc3JkdJKchK37M7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej7mvvfd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e82c23840so11930325e9.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778524758; x=1779129558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21bMfzkg1fG+ixFlxGu72FOuEM2Z67Eu4nv+vp2BRdY=;
        b=Ej7mvvfdLJ/QjbZwU8eygFrCVxUVbNI/uESUE6dKIQD4zSRYebOnSEHHoqn+gnFB8U
         pf1TsQueK1rIerHZiAQWmCUmbEVA7jBCSaxc7ij6uYWfTtVHxpeb8TtqXYMSUF+S+vQO
         dwFJtRBd4B567WU6T8N3X08Y8Ft+booXfGQTYBVSbdm6WbCLDFPEKKG7/acPkadmpMoy
         YVBOLhlIRFSMpTPU+EYiq97Oq0cI3f7XG2wxJEMrPuUkMRrYcZDCt7O01doCNx6GbtdF
         y21IsvwGNJ9Pi40G95+UKi56s1MK2cmc1uUAkXKPFCYLUJTiBt5h1yi5ao3GCkVV/KvJ
         Bh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524758; x=1779129558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21bMfzkg1fG+ixFlxGu72FOuEM2Z67Eu4nv+vp2BRdY=;
        b=cQ60saGCsYs5Fk/Gn9f675uuZBrp5CzyL6AoPJ2U3tQax6lZyF6awFca9QeOmrabf/
         x6u7Kp1QTMP8I5XBmHxCR2HIgPa/WbPyO71A727oSlnwyLznSlWItTslr4bVDnu5NJgg
         Mdgy4vNE5lDKS07dY9iF2PI+7o/qCi5jvJmHP0tX5Knf1LwWQub4QqF2ejBbcyXLJfnc
         FS/CaCEOJZM+N11dr0nu5zSlQH/B2v0QJNIae9nurVphFcZ+oqdIFDA1M9h3v2tbH0fV
         OMkzGMPX00/hRniMgDM0KXxYbwWAezYNZG8HXPHdy/MvAxc5nJz9xxuz5q8Nj35+i5mN
         hJMA==
X-Gm-Message-State: AOJu0YxISOo/Yk9ukDMPfH+wlYB49zmbKZtqPT14/c0JgrHYNvoP9X+g
	o/XIIC/efComQEHlekpyqVkhx5WqJOoMSshT4dYZE2lzc1z+LB/jLXTn1LHIKw==
X-Gm-Gg: Acq92OFlk+wIZ0WR7/4JX4iERgzbbY3fS2S4xf3c5b+J5MAxgWU9J0K29VdBA7WORuN
	2YE3XlTP5sAs6WnfBIDFxx+dolNEEovFyzN7zDHBk1nyM0yB7QH8t4FKfcP3R6/i5ajYGGWnvKP
	HONIdpYQ9migJIQ/m2smqu/5bmTAAFOVbS5HcMHPLD/L+59Skw6sJI0/nUyGM11hc4TpucFulYV
	cqOmTyKRO0oGp/CgOWnZBKbUE0143TNaQb8bLUAaC4kkmV11pjCqtptjn+4uoEQtEMoAExsjn/F
	nEk02KfAzZ4qJENN0d+veoo0Pdq3k/uvdjDwFyf35ZotMDsvICb5QMxgwOzUPgJy14iHJey7wyf
	tlP/sbFfUb23zn5cq6LEBmFHA1XiBVkVPBU7er1QXc5gS6neDaDRDyBjDsqTrptYwnhQMJZXO16
	LFPb0V1snUuM5pzbUb7I9Q
X-Received: by 2002:a05:600c:8011:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-48e51f3bbabmr390037605e9.22.1778524758318;
        Mon, 11 May 2026 11:39:18 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:23::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702ec51fsm180282655e9.12.2026.05.11.11.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:39:17 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com,
	alexanderduyck@gmail.com
Subject: [PATCH iproute2-next v3 0/6] netshaper: Extend netshaper support
Date: Mon, 11 May 2026 11:39:09 -0700
Message-ID: <20260511183915.797792-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3775E5148B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-286792-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Changelog:
  Patch 5:
  - Fix JSON output corruption by replacing printf() with fprintf()

V2: https://lore.kernel.org/netdev/20260509022353.3470738-1-mohsin.bashr@gmail.com/ 
V1: https://lore.kernel.org/netdev/20260501011611.3533573-1-mohsin.bashr@gmail.com/

Mohsin Bashir (6):
  netshaper: Extract parse_scope() and parse_rate() helpers
  netshaper: Add bw-min and weight parameter support
  netshaper: Extend show output with parent, bw-min and weight
  netshaper: Extract struct shaper_args and parse_shaper_arg() helper
  netshaper: Add group command for creating scheduling hierarchies
  netshaper: Update man page for new parameters and group command

 include/utils.h       |   1 +
 man/man8/netshaper.8  | 140 ++++++++++--
 netshaper/netshaper.c | 487 ++++++++++++++++++++++++++++++++++--------
 3 files changed, 523 insertions(+), 105 deletions(-)

-- 
2.53.0-Meta


