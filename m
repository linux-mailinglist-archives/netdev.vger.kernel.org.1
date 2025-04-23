Return-Path: <netdev+bounces-185131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A560A98A0C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F977A6421
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD42426E165;
	Wed, 23 Apr 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="BUDQl2Qb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b="CwuyHExE"
X-Original-To: netdev@vger.kernel.org
Received: from mx.wizmail.org (smtp.wizmail.org [85.158.153.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03464267F6B
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.153.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412230; cv=none; b=aqvNbl0XgSqQIKhS7R/LOuerFeaKjPWE69DVD2m4qtIkCtBrDliiLeF94S7iE58cYxqreGnBsefnDtnDn4iXh9RzBIybEMFaytQjvMjjfAGkgEZ1Y8pvWc1aQNG9C4AImm98NSl9j6ciEBq4RfaxGkrNjQ8hH+MWiaxIklfIc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412230; c=relaxed/simple;
	bh=2iIPDqu8EBFzoyBbexgffrCCzviKE1Fu+mMI0QK1a8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alYXpYnFRkI1nDqtiCtVqHWrHpbLD+bscmZx6TLZi1W98UtLXpW4z1jbDA94W/5xN3+3wtpD3FT0vt3e3VJjPFqKdq/avaWmRU6PV0fyhFVW1Fjdpl07e3sG1rsD95ijl1seoVlm9dKx0Y4E6/0p4RfIpIWk+O01DTAHGDOY0J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org; spf=fail smtp.mailfrom=exim.org; dkim=permerror (0-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=BUDQl2Qb; dkim=pass (2048-bit key) header.d=wizmail.org header.i=@wizmail.org header.b=CwuyHExE; arc=none smtp.client-ip=85.158.153.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exim.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=exim.org
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=wizmail.org; s=e202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID
	:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive:Autocrypt;
	bh=e5dXMBvu2JVJoR1Ptqi++yejDEBnNKQQZTo1hh+ipko=; b=BUDQl2Qb3VjcWq9ssSu9lfTITB
	6s+9G2zmj9dMuq5z7CWtcVeC75GtkuB9mQFfIRSwBXYeAyffUbEdF6q87NAQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizmail.org
	; s=r202001; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:Autocrypt;
	bh=e5dXMBvu2JVJoR1Ptqi++yejDEBnNKQQZTo1hh+ipko=; b=CwuyHExELSrtJv2SG/JdULAyo9
	elly8MIG0snrZGcbZV+SCIvWahcL4jZDILlgbbR7zVOWHrVvGweVdrg2V8wc9MctgFFJfmVGtCljV
	qLD5fLrfk/QAC3h8rqU4AVt22Gj7gUnHgU6cTaVY2kxG2gdCjbHRJeYZFcA0KOBtOpsAc5TSIJiAl
	0ags0+TGnGpNMBI/qPQEFAeLshDan5Zf0+QnUaz5PN/QHxdr5e2Z1BF6COCJ6Ss3z5wcysyufd180
	Q19uayRoAprKOLaRYCe6cweoiXqoJSAv/Q3QcCf92xE24k6Si9+EhvOl+uowp6UixfnRgWN5x9YTm
	+hFiPErA==;
Authentication-Results: wizmail.org;
	iprev=pass (hellmouth.gulag.org.uk) smtp.remote-ip=85.158.153.62;
	auth=pass (PLAIN) smtp.auth=jgh@wizmail.org
Received: from hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain)
	by www.wizmail.org (Exim 4.98.115)
	(TLS1.3) tls TLS_AES_256_GCM_SHA384
	with esmtpsa
	id 1u7ZS4-00000001iTg-3Zii
	(return-path <jgh@exim.org>);
	Wed, 23 Apr 2025 12:43:44 +0000
From: Jeremy Harris <jgh@exim.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	Jeremy Harris <jgh@exim.org>
Subject: [PATCH v2 0/2] tcp: fastopen: observability
Date: Wed, 23 Apr 2025 13:43:32 +0100
Message-ID: <20250423124334.4916-1-jgh@exim.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Pcms-Received-Sender: hellmouth.gulag.org.uk ([85.158.153.62] helo=macbook.dom.ain) with esmtpsa

Whether TCP Fast Open was used for a connection is not reliably
observable by an accepting application when the SYN passed no data.

Fix this by noting during SYN receive processing that an acceptable Fast
Open option was used, and provide this to userland via getsockopt TCP_INFO.

Jeremy Harris (2):
  tcp: fastopen: note that a child socket was created
  tcp: fastopen: pass TFO child indication through getsockopt

 include/linux/tcp.h      | 3 ++-
 include/uapi/linux/tcp.h | 1 +
 net/ipv4/tcp.c           | 3 +++
 net/ipv4/tcp_fastopen.c  | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)


base-commit: 0e0a7e3719bc8cbe6d6e30b3e81f21472ecba5bc
-- 
2.49.0


