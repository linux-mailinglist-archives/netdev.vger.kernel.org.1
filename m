Return-Path: <netdev+bounces-276663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBavMJaP1mmEGQgAu9opvQ
	(envelope-from <netdev+bounces-276663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:25:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFB23BF7CB
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CEA5303C008
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35F83A8744;
	Wed,  8 Apr 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XMMoKewu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZTs2iBh+"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDBC3D6CB4;
	Wed,  8 Apr 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669084; cv=none; b=H9u+Ln9jREyuE3wsrRGuPmMBSV3AJqHGu/yNGu4iAF+0FGir3DobCgOOIvk5UY/LjHwylsqnDmT+rz0X654CVuSmDG4aYHDejQOdvx7C1v10Ixjx4RA1wirexQlykGy9iVB1UkNFaT52EKxytJTGYhIOS6q006MfhOJdzBcLXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669084; c=relaxed/simple;
	bh=o2OPnmblJ0j0eXLZd7P/soJwLdeDIHIZhA+5n/a0POc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNbouPje277dbbm73SpVYLh6q5J0JrRQfBi8QtLCyQnGF5WNvo3hbTakLxBdvDR2OhWWK61AZXbRKdeHU2TnCDZfLYKRfT5CgTAps8XpCNhzpeoEuchXv9+L9U6rvvubeGf9708Y6mDgf1/ip3e20X8CpHorfSkLE9N+zxJbuxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=XMMoKewu; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZTs2iBh+; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frVLB4szwzB151;
	Wed,  8 Apr 2026 19:24:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D1Btw/zx+p6Jb5xjhBRZAHRgFiIdx9r+i3hCH8sIMz0=;
	b=XMMoKewuZEkQCJDvrsau0AcZGhmcAYVFTuCMcKrt+H2ywpy50ItOs3w5iOuvUXG873n2YH
	ja0gKdzvsKx9fokmn1YUV/Rv/lMhs0gcvHtMWfQNzS7IeUCQJT9lT5SXtwp7RmZU2qb8ej
	lV1FwrlLrC6czLRtsXsDgreS5kvE080z5x6Nfbg8ZjrvVti99CQHeDZ+WyopL38Wyqe0Ht
	B8XEz6a6U6vZqIHQ6IgAIC9mCCQPDSl9iex/dW4dVEQ4IVp5STPN4ZY9UOap71XayQmbeT
	X3h1xcW+c2rLSh5aUUpwl6MykKRYKNoru2LFGxCc/QPTIepvOhVDDMNbg2KqnQ==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D1Btw/zx+p6Jb5xjhBRZAHRgFiIdx9r+i3hCH8sIMz0=;
	b=ZTs2iBh+gdBacCV1+AunpRorNSQB6o5tM8f1CfC0RgrHHkgOY0Xq4Llp5K8RlNUNSP8Lwc
	L2wZ9zGkhgaY1x1TtuY/hLxyv14TkAlN2+sR/h6neOcWk1YX+tebJzVqEBQgIxv1rEdZfv
	BKZFHsbaSXVOXa4XuJLcNG2xferx+1P64zHJZJChdTRtu6Rw2bsgrGPxVjm11WxVpUqiQj
	ZOIHxs+/sYJf6cAparxzH2GZZ62zfKW4BB3jGKmVcl8mZTIr4Y76WJsByDwmbb6LDxXE7Q
	BrGa853dD50ljIRaaif5RUqZvNHY7sT3u7fva/Yhr6ZwWXVYNZHDefoZIdfvZw==
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jreuter@yaina.de,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH net 0/2] net: hamradio: fix missing input validation in bpqether and scc
Date: Thu,  9 Apr 2026 01:23:56 +0800
Message-ID: <20260408172358.281186-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1fe9xf4r1kkjbj47t71a54rd6hriocxr
X-MBO-RS-ID: 3cc5e3eac2246861a89
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276663-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EFB23BF7CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two fixes for missing input validation in the hamradio drivers:

- bpqether: bpq_rcv() computes frame length as data[0] + data[1]*256 - 5,
  which can underflow when the length fields encode a value less than 5.
  The resulting negative value is subsequently used as an unsigned length,
  leading to out-of-bounds access.

- scc: the SIOCSCCSMEM ioctl accepts a bufsize of 0 without validation.
  When a receive interrupt fires, dev_alloc_skb(0) allocates an skb with
  an empty data area, and the subsequent skb_put_u8() calls write into
  the adjacent skb_shared_info, corrupting heap memory.

Both fixes are minimal, adding only a bounds check before the dangerous
operation.

Mashiro Chen (2):
  net: hamradio: bpqether: validate frame length in bpq_rcv()
  net: hamradio: scc: validate bufsize in SIOCSCCSMEM ioctl

 drivers/net/hamradio/bpqether.c | 3 +++
 drivers/net/hamradio/scc.c      | 2 ++
 2 files changed, 5 insertions(+)

-- 
2.53.0


