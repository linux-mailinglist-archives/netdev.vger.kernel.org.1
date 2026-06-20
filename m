Return-Path: <netdev+bounces-300821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HUhEHYStNmosDAcAu9opvQ
	(envelope-from <netdev+bounces-300821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6A06A90E6
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:11:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KZsm1T2N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300821-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300821-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 237B7301AF74
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7287F395266;
	Sat, 20 Jun 2026 15:10:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E4394499
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 15:10:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968257; cv=none; b=YgWdNPj6A5vlIyGqH8y4I6xFFA2HkoqQM9uf6345qaqfySprsqATltq8lsoNb/00P3R88a3hnxk90xAUc76Gb0o+I2lS4u/7mV9VeJhmQBxh/PXP49835+eDLN+Ltbo4wZ1tDnGiQnzeaz8+E/UFiA4SIbuWUuA04svYrxzl9fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968257; c=relaxed/simple;
	bh=iLIo/tjEYL0HmEvHt6dXj1x8CN+SJIwCDDdQ3S8Iqmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJe6bawkzm8TcG9235F7BUTzWXPh3+GmkIWM/G2HmvW28TJ0CXXj4OdQQg6WHloeFBfwNrMvnTVMmslyQliennqqjICCIs/9BAV/J5Bx1Lsf+R489s3eb+Vo2oYeQXJqYMThRBrxdR75nKHJ19HuqPdt5vIvVK76pFGAtBk0y+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZsm1T2N; arc=none smtp.client-ip=209.85.219.49
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8dcc3f14b93so35621136d6.2
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781968255; x=1782573055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+z958H2+ax1p+a15NR0BL1EZe5dZeTIGdrKHUA8JOU=;
        b=KZsm1T2NgZSKKpPTR4Qv5eMSCLiGxuyWPN1vBNKgxNg5O/Od2KC+ZXboQtpR7g3ej8
         GUiBqpWTX9UqArrDrE+1y8zxnZsIFG916DfRYqmrmF6FXmnaBXU3GUeNCELv5DnVLFiJ
         UWFbfsIFqaKvrN262jebW0EiEqU50msvOU0Pgtjj8vcCa90YL117ouHn3qCg7nF40q+S
         9cr8fKhLVCIuIDZ/2hPVIvAc8MKvpJTB28KEkfTvrqh28VzTRs2IvValDVDGljMbiZdr
         GxAgyZsu7KCSnxo/WxktKu6O9njkViAv98mDg7SeXcJo8rE/XuA9XmM2RPtofKfzjVn7
         O6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781968255; x=1782573055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+z958H2+ax1p+a15NR0BL1EZe5dZeTIGdrKHUA8JOU=;
        b=eRdKcYgjKr6TD9P+QzmH8I6TkGeN5quvSqxCzw+cCl4IOzjo3YjdpGsL/NkOjpXeZ4
         HsZlrwaChJ2ORU9AgrrvANYGgbVgllaeD65oTkTxNztojmSjwgYwPdcwkRiQYnEnVo81
         PrvY5ZoK37mG1Ehfv7VBrUBRC9ij74WoEQVMx0g4UJhapGnRwFlgh0+QbSaItfvmXC8l
         +EUcrCIlljCMYtghxITSJmGmxDhCNAx3B4boD1Bc/ImDvq6XeLK33/Slv4n3c2CRLbeP
         I6tbn8VMOW1iQm6N7c7cqp8YUAzstKLRbkN5fOGUFCayU7A6RcBXAfJwfPMpgvfhD0q8
         Qxcg==
X-Gm-Message-State: AOJu0YxT2VdIy3fpECawqSt0Z0rCLbG1K7o8GG9c9PW46IIWxYhmN7c7
	pwqY1o7QevhsWtQYbLb6mlJ74m/eNaNFn4cHuKd+mH5IHNEDXvXSebXCDmbsTA==
X-Gm-Gg: AfdE7cm6euskmN+hkY0b3koXlZg2tnsvGuAKQKdEDvzkzdsTLMdzqlqifyedphAIHcR
	zMGaB7f8FhbwAVM1pnFZ9jjqHS3FGQlqR/IkUSH5X6xWGmY5PPQL2n1t9ldeKY3WVhGxxyG/ExS
	JKeGtQgEO/LoyNAjpXtA2KD7/h6KkBRuTZeGSr65KhaPP49wgSvvETGbxmFhOxBAq+SVZGK08uG
	qcD2fNf88bTQPaii3Z4wnVzZnHC3nsy9d8TpjOXi5lQbPyrg0nYFPd/dYCtUhJMEBfYVyQOCawE
	a92EOHbj+f7gHXI52SBWya1NI+9JZe8lDP2CWDDn0T5etzR+wNPfThOuHu51iUw77sdXF7cPV9y
	7TlQj64wfYe78jL/RYE+zWpvPMzX4DBhlJQgHKkJJoU4lcmfwExMn4l4umcUBP6e01V4QcuZsqF
	l/+IxdnlbWUY8lzK7Hb8vDvsPTaN1cM3D6UKfVYi5NO7oClrsPYIqdX4cnjevpe6FLrUJ/HBcR/
	fTRLMSXSah6FHzzfol0WtavLkCOa5BGJOz+BeeNsvX1pkWZq0u/aSE=
X-Received: by 2002:ad4:4a6d:0:b0:8b7:4b46:1248 with SMTP id 6a1803df08f44-8de3fd601e4mr90509136d6.24.1781968255249;
        Sat, 20 Jun 2026 08:10:55 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde21csm34402146d6.26.2026.06.20.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:10:53 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net v2 0/2] sctp: validate INIT in COOKIE-ECHO when auth disabled
Date: Sat, 20 Jun 2026 11:09:20 -0400
Message-ID: <cover.1781968162.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300821-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E6A06A90E6

This series fixes a security gap in SCTP's COOKIE-ECHO handling when
cookie authentication is disabled.

Currently, INIT chunks embedded in cookies are not re-verified after
unpacking, creating a vulnerability when cookie_auth_enable=0. This
series first refactors error handling, then adds the missing validation.

Changes in v2: see individual patch changelogs for details.

Xin Long (2):
  sctp: factor out INIT verification failure handling
  sctp: add INIT verification after cookie unpacking

 net/sctp/sm_make_chunk.c |   3 +-
 net/sctp/sm_statefuns.c  | 220 ++++++++++++++++++++-------------------
 2 files changed, 117 insertions(+), 106 deletions(-)

-- 
2.47.1


