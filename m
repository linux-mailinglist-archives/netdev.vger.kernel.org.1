Return-Path: <netdev+bounces-288471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIyLFUGbB2r/9wIAu9opvQ
	(envelope-from <netdev+bounces-288471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:16:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5CC558B14
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D74C3301BA4B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1BF305693;
	Fri, 15 May 2026 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqJJ/Uqn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADD405C41
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883208; cv=none; b=GW4SlV6AUYv8xNgjr5ypo3TJP478JJUrndttHowQh9dkUu6ocF5me6v6O7+if/HP8BpdSCiyeMtZ/Fhf453zQtQDWMtbDA7Us8fQqER024EnFIshItKTZG2U3iIQPt7MGx6hQZCp+n1xDxYZmLYKW+ihiAIiYuJ25buyllKA3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883208; c=relaxed/simple;
	bh=cIb5g4nC9A36098Sd9s2sQ9vGPOHLl0+hJKdaFPrjIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRZ8zK/1S/8dXSGtM8KNliXUEI0dtq9AdPH5n5FjM2dqTQz81pZ5YNH9ZG+8yMWL6RFJloJHq5shGElyX115h1ELaPOYgtnSBW/P8A9c9ydxjAlHSWnqwms1dD8izHyt200DmhnNTAazTWLkcAlcDaGu92pO4wElGXyMaeev2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqJJ/Uqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43535C2BCB0;
	Fri, 15 May 2026 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778883207;
	bh=cIb5g4nC9A36098Sd9s2sQ9vGPOHLl0+hJKdaFPrjIw=;
	h=From:To:Cc:Subject:Date:From;
	b=MqJJ/UqnVi21W74z4Y/7nci+S9rBEnLBJXgseMN+2trEfXKq5Djx2Pr3bWmZYTXNp
	 rXkLAvymigTR4faRyiBIgFmi0FEXkR5aCM8oi9520ONKBaKc/4Ct3bxbTRMA1DkuSq
	 rqk/D4HjuzlQnx9azzsLYNo8Z33DRkOS/9BPck394PCAmxAceztMp2gM6hqjQeXmsE
	 QoZUTPtAmm+lieJDqGGCLpBpXx62Jajp0Sl0pJD0GcDVoq+4RbcdyJU36FqZ53fo4+
	 IxABhVKatmQfxrJs4eA7PO0vIBhBqsewaDWkIk/zwwcg97hTLXXc2EINOdaEwPTY9o
	 WwuJNXXv5PVjw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	hmohsin@meta.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/2] net: shaper: fix VALID confusion even more
Date: Fri, 15 May 2026 15:13:23 -0700
Message-ID: <20260515221325.1685455-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE5CC558B14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288471-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

Sashiko reported another pre-exising issue in the previous
batch of fixes:
https://sashiko.dev/#/patchset/20260510192904.3987113-7-kuba@kernel.org

Turns out I over-esitmated the guarantees of the XArray flags.
Stop using them completely.

Jakub Kicinski (2):
  net: shaper: annotate the data races
  net: shaper: rework the VALID marking (again)

 include/net/net_shaper.h |  1 +
 net/shaper/shaper.c      | 98 +++++++++++++++++++++++-----------------
 2 files changed, 57 insertions(+), 42 deletions(-)

-- 
2.54.0


