Return-Path: <netdev+bounces-273793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GwxNx9pzGlXSwYAu9opvQ
	(envelope-from <netdev+bounces-273793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:38:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFF3732AE
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 02:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 089523008D3D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8E1A9F87;
	Wed,  1 Apr 2026 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KXqGmZk+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A15654774
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 00:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003928; cv=none; b=hWg+7JtTk0zReqGEXFplsK4cULu36DhVzlTwaBGdxXeprACzddlqe4PsBWcSbR/gTHJvZ51f0ksT8ws/ReAsz9c8iW+AxPF3TFMsg/NhnNLFZwDeBDpWOnnCp/ieVXNPcfIK/NcFdsMFwYQI1oHZFmDz2QzXMcQ0t362j3nAfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003928; c=relaxed/simple;
	bh=8Kc4oE3SHaIhwDJaM3ICrQZFp/2ofgh10Oeasz6SR1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FwMzjP9pkEr3YFHfgyjSoolUuF5NOIxiEpesyLhml/jeY4OqQ3UYRUR+jq4rhQELxUWM4HmEE8ZRYZmRp2gkGSPuFzOvmm9Nt4RnaOSkD37sxwRy9oMVPyAEf7C6dt7YMgXSwWccq0oPumOuNuubwem6j5HhmFDXa7lvn3eYUN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KXqGmZk+; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-64937edbc9eso8296493d50.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003926; x=1775608726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+tm8JvSYTJFLSh8j5yFrep5/YuYO2X2J6QMiwLluOo=;
        b=GoSlZrvTQMzG0HypyM8LV9SGoduurzhJ+0oJayLrgDjUjcFzIDxiezc3UkxiUSEvDO
         FSb7Hw/KTBN1gdJiW+Mn3v9GUsNUhUm+kGr49lLkTD56RAVjWPimm/OKUs6TAfQiB8tF
         Pp/fdptrtdL9Mhyuary+CvqaUmrzI/dOiMQzldsjHTOE4glpNFmLXyQxE5uEpRzql77D
         0vZTtKXT+MPJDnpPvTjtaBRQbzfvnPuB6wfPjvruEKmv8a1sXuM2ImpxsY/3YAUclMQX
         juWtNXQBo0zX9PyN4VIk3MwMhT5EhOELSy8lYGk3NgPuYv5t27Os/mEXU0ukczZs+Pd5
         iU0A==
X-Gm-Message-State: AOJu0YxyY4wR6ZObyRcMU+Otbz+SNDfo6UcEZOLlRHKR8+hjIkZg+Jul
	l3btFFqnkzhb+NzX22q12j/VBl0ctKr1qb1p6gTa/K6lO3CWQO0f4LJYv/YPN086nyRf9jMZMNC
	2g3vZ0pupNm8IvC9PYDjZY8hlg/q3teU70EuO1tafHzCA+Vh2dS0c0KwHJN6RrqZa8Dc0eR91te
	j5LxEA8wYOZgCaIVB9TyCVPjAhOdWEPrfUcngxHnYL9+SQKwykWrADq+00mgL0jwYZ9QT2Qtkw2
	Reh0HJ3ng==
X-Gm-Gg: ATEYQzw45H7iXcs178cD5Yslxu3bQYdVYqwoQAuGlO4VZ4OTAHkEAAabfe0YRWFC6su
	CtUB1OJW1b+q9vCVR4jPxH/OiH3gbGaUT8gowUSDBve5SqqCrZ1etIHYw9LjfDttQ3xfL+WQ9AW
	Qc7D536zdnB02yZ2zoTQLHCFY7sSsbHwYZoWeh4s4PJwClA+c8BU0HtuzBDnznUkzt3zQ5yg4fe
	iwUmO9ATBktwevz0mUsV7KYb24xLLtCYC7TINjXmYTwSuLtVttr+qTuJmqHbMEVDBzZOsvXPHLI
	2xd/oYadhdl+YMloaVhMESDkwMjAFQ02LNgH5yuhlsBhAi9nf3SI9es5TSZO81e+wZ7r0DMijzv
	LU2rQ1WPzPfeE3nx9VAwK5SQr4P+OFBWmTJmjjAY+2nvb4wSXeNJoXPWYGd723HTgM9kwRa99Cj
	Ko8ZXfYMFOfwDvRr3xiwq3mHqOUlv9o4jKPRIgEu5KZHtispqmkZPK/Mw=
X-Received: by 2002:a53:a2c7:0:b0:64c:a59d:b0d1 with SMTP id 956f58d0204a3-6502fe554a5mr1129550d50.39.1775003926387;
        Tue, 31 Mar 2026 17:38:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6500923c4casm1423293d50.4.2026.03.31.17.38.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2026 17:38:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c8ac8e422dso1612640eec.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775003924; x=1775608724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+tm8JvSYTJFLSh8j5yFrep5/YuYO2X2J6QMiwLluOo=;
        b=KXqGmZk+taufpaNCaz+4H72cM5YMYgWyXhtQsUwHp61pfk8uzFeGc1IQYY2ILDOi7y
         9zVd5caH/HcBcvPoWYF9oKxrCCFUb5s8w5GqPbZZ7rzX32jVY7MMt10gY6jDUuA+z4He
         gIckpumHR13cY7yIWLXTIP9fG0I0WSw0xfeiQ=
X-Received: by 2002:a05:7022:2395:b0:11f:2c9e:87f8 with SMTP id a92af1059eb24-12be6535cf9mr1009515c88.34.1775003924291;
        Tue, 31 Mar 2026 17:38:44 -0700 (PDT)
X-Received: by 2002:a05:7022:2395:b0:11f:2c9e:87f8 with SMTP id a92af1059eb24-12be6535cf9mr1009481c88.34.1775003923581;
        Tue, 31 Mar 2026 17:38:43 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm17663190c88.4.2026.03.31.17.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:38:43 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	opendmb@gmail.com,
	nb@tipi-net.de,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v2 0/4] fix queue lock up and reduce timeouts
Date: Tue, 31 Mar 2026 17:38:36 -0700
Message-Id: <20260401003840.3112454-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273793-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E6BFF3732AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We have been seeing reports of logs like this.
# [   39.713199] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 7991 ms
[   41.761198] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 10039 ms
[   43.745198] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 12023 ms
[   45.729198] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 14007 ms

We have two issues. The persistent queue timeouts and the eventual lock up of the entire transmit.

This is due to two issues.
- We have a small queue that is prone to timeouts. We optimize this by relaxing the tx queue stop conditions.
- We have a racing and leaking timeout handler that is also fixed.

v2
- These patches stayed the same.
  net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
  net: bcmgenet: fix leaking free_bds
- New patches that fix a few other slightly related issues.
  net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
  net: bcmgenet: relax the xmit ring full case

Justin Chen (4):
  net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
  net: bcmgenet: fix leaking free_bds
  net: bcmgenet: fix racing timeout handler
  net: bcmgenet: relax the xmit ring full case

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 39 ++++++++-----------
 1 file changed, 17 insertions(+), 22 deletions(-)

-- 
2.34.1


