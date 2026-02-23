Return-Path: <netdev+bounces-260218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLnoCr7MnGllKQQAu9opvQ
	(envelope-from <netdev+bounces-260218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:55:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF67117DD5C
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B20DC305C08F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8CB37AA98;
	Mon, 23 Feb 2026 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="d6AhoEDM"
X-Original-To: netdev@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530037BE92;
	Mon, 23 Feb 2026 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883584; cv=none; b=ncYnpGQc8cuYbYp7QJWGDWmqwzH5/l+bUPGk0e83ri+nP8kq51j6CPe5ojfjxOGHp+CZxwhdflDNRrobMyxYbY0Z5FbBiUtxc75kfaoIb07kA4G8pjbIcp7lUDL0GBIXjZqtSrlFEFnUCmIBtyJzk2EfkwD+yth6jHDRjNdQHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883584; c=relaxed/simple;
	bh=urs7LFEFzoIA8YPfdWzwjXPvYvVkNZEMfiFNbQSTi58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWtXUO7d2erbqLFYJOoDpCAJnFYoy9cBU03P0xw6mbnVpHaprNIBrSwVaLM1Y5VoBHP9nF3MqqRAwKkVlJ7Xh4z0/r3rtu8z9MTDSL6yAuVcuYJjpdwPdJwYrRjUWrK3rSO6NsfVA8vc9qSJp5CkFFesNdh/cmKR/PEaStL0YUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=d6AhoEDM; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZNG6fqgzlh2fQ;
	Mon, 23 Feb 2026 21:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883579; x=1774475580; bh=nnFa9
	8OY9ljH31aKjq4xyU/FDPBwt+RV3CAa4GqfTp4=; b=d6AhoEDMnAXvDHVZhnhln
	QFik8kfKHW6bLWUrpqG2ed5ABXpF9d8QvVk2efW/SnidyNmq/D9fDVIHMKeN7y1J
	yVSA369NwJRus52NTDTEMASQ72mwQ28BQJjQ5XQ2kYUV3NfrmyaisbIRx5b3zlFe
	XsILCP/r1A0uC2u2kNPGfz0wp/PxKU38hZtbNz0GhU/3KYXYptnFuUXBUqpvf7hA
	HjmwDLzSBF9GJ6UjY5L+x/FbnDTd5UHZ/aryHRJod6VOrrgw8x85Xr3w2hp+t0uo
	+OjmJu1ab3n9cbEtKUEJ76TPGeEdN83gn5QI111FDfCLNiRCS3XaPtl3tHPnosA3
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ikK2jfedaS9S; Mon, 23 Feb 2026 21:52:59 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZN673nWzlh2fJ;
	Mon, 23 Feb 2026 21:52:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org
Subject: [PATCH 18/62] bnxt_en: Fix bnxt_dl_reload_up()
Date: Mon, 23 Feb 2026 13:50:33 -0800
Message-ID: <20260223215118.2154194-19-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223215118.2154194-1-bvanassche@acm.org>
References: <20260223215118.2154194-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-260218-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim,acm.org:email,fomichev.me:email]
X-Rspamd-Queue-Id: DF67117DD5C
X-Rspamd-Action: no action

bnxt_dl_reload_down() calls rtnl_lock() and netdev_lock() if it returns
0. Hence, bnxt_dl_reload_up() should invoke the corresponding unlock
calls. This issue has been detected by the clang thread-sanitizer.
Compile-tested only.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shantiprasad Shettar <shantiprasad.shettar@broadcom.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org
Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/=
net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 15de802bbac4..1e9a3454bb29 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -562,6 +562,8 @@ static int bnxt_dl_reload_up(struct devlink *dl, enum=
 devlink_reload_action acti
 		break;
 	}
 	default:
+		netdev_unlock(bp->dev);
+		rtnl_unlock();
 		return -EOPNOTSUPP;
 	}
=20

