Return-Path: <netdev+bounces-257547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHo0FtzqhWk0IQQAu9opvQ
	(envelope-from <netdev+bounces-257547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:21:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0A0FE054
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C23D63008D6F
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C43B95F9;
	Fri,  6 Feb 2026 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="O/gIVeAz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-108-mta96.mxroute.com (mail-108-mta96.mxroute.com [136.175.108.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842D36C0C1
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383693; cv=none; b=QbGerVTMLw09Xy9n0y2OZtXvI8qk7zOjnon9SqbIz//D/PkU05T4aQRYoqReSS6YgIbelywoiChH406PCt0Q/KNqajZ29hryMm56IkSNbCxBlpZujnoeD/7dQQL9e7VG2cSRnmeqxuga2+PYBfKYZ870d12b4ZYdNaLvCh4k8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383693; c=relaxed/simple;
	bh=t0vYzrvIMcywn2E9XCt62MQKvy2nRCDraKw8g+zPvoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GNS3nSa35VRfBqc66ei2/tPJedwnq8tFK7raJ+zDo/ObKNLznaM0p7Ga5EayQfJDCh9yfb9MVg72Xs+p92FHASJfPLHfwOq324V0UAjewLdbBrlVJcC3ZU9zbzd1XCSh9AOje3SgtpmkQ03kmqwBgbj3YqMv+MKjVWXaqxr/wPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=O/gIVeAz; arc=none smtp.client-ip=136.175.108.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta96.mxroute.com (ZoneMTA) with ESMTPSA id 19c3312a0e20009140.00e
 for <netdev@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 06 Feb 2026 13:09:44 +0000
X-Zone-Loop: 99bf7b63838be582d6fb6ee04614f4b45cb38e97bd99
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To
	:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=p80ahRy0ymtITam/dWdoQZcYiEdqSxcp8bSLjrHjHPU=; b=O
	/gIVeAzzAEqczdw2uIeTWW5yUC7Z0iBRC6/Oq52yrZvkddhqim0k3jvgAvAr939YimHsp1KljFKe+
	ySaf5uMi14wIsRhv1RuruFWpCW+KfhXEG1o1h+xeMTTuY1Oy4/7a/9ak630T+YnwzdMWxoOIDDzLi
	PFlVgYx8xZurIhRViM54tVCCFSZRbAU6SW4vW+YzSfTwsiKTSaEkk6zSr8kfEs8CZ7str4j17BHf+
	r6dLfL591BPZC8wbx0cjSZRIxuDrv50D4WJGPFpFiiBv+svikWPElMzvbA/g9CNXeZbTohFljZPVG
	ZgIz/WsruLp9iIY7ru6GGP10CDLmShVug==;
From: Bo Sun <bo@mboxify.com>
To: kuba@kernel.org,
	pabeni@redhat.com
Cc: gakula@marvell.com,
	sgoutham@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	horms@kernel.org,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	sumang@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>
Subject: [PATCH net v2 0/2] octeontx2-af: CGX: fix bitmap leaks
Date: Fri,  6 Feb 2026 21:09:23 +0800
Message-Id: <20260206130925.1087588-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[mboxify.com : SPF not aligned (strict),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[mboxify.com:s=x];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257547-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bo@mboxify.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.907];
	DKIM_TRACE(0.00)[mboxify.com:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mboxify.com:mid];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[]
X-Rspamd-Queue-Id: 3F0A0FE054
X-Rspamd-Action: no action

Patch 1 fixes the RX/TX flow-control bitmap leaks in cgx_lmac_exit().
The leak was introduced in commit e740003874ed ("octeontx2-af: Flow
control resource management").
Patch 2 converts the existing kfree() for mac_to_index_bmap to
rvu_free_bitmap() for consistency with the alloc/free API pairing.

Changes in v2:
- Update patch 1 to use rvu_free_bitmap() instead of open-coding kfree()
- Add patch 2 to keep the alloc/free API pairing consistent


Bo Sun (2):
  octeontx2-af: CGX: fix bitmap leaks
  octeontx2-af: CGX: replace kfree() with rvu_free_bitmap()

 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


