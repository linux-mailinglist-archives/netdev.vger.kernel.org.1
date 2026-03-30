Return-Path: <netdev+bounces-273120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAlzEt1SymkQ7wUAu9opvQ
	(envelope-from <netdev+bounces-273120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:39:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AC359837
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D61F30233CD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7839F3BE14D;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om1yCdWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C0C3BD63D;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867036; cv=none; b=QnccX7QL/Brr0yh23xLlZyCNBjKfxQ3PM09XYpk5xrrz2LLzlZyOJtZoluQGXDhUFcTuyBqTlgxhs8SmmWDnFZNAu80f+nVR256dkEB7cgEulFbVSyfLPU6TWXUZkebPy9lj6UjFy6qrF/f+ioDGMUb6X3goIidOKSkvJzhIlDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867036; c=relaxed/simple;
	bh=Wuj9wzQSeaoI1UP2Rxw8a3jZFk0scJPGzVBIPzjE0QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJuO2qKrkpqwEr38FU08wQ613Q/+kF1cQtzL1VNNvMumrxDpXXFxEAVHW6TxNwymdghsGrNsQC5pJRgxK+tTCMb9KGlHENWCA5On5z5p3PBvNg+tFVdCDjL30TjFS3NvcPil9Oli/gTuynkagMP+/A0TLG1mLsSTTXK2YFGdT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om1yCdWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F97CC2BCB1;
	Mon, 30 Mar 2026 10:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774867036;
	bh=Wuj9wzQSeaoI1UP2Rxw8a3jZFk0scJPGzVBIPzjE0QU=;
	h=From:To:Cc:Subject:Date:From;
	b=Om1yCdWumupyfTwxfn5X4O4pb5fvrpiG1KZ888DXxkLgqhqHq7wgJwrOp9ZQLmlHR
	 Opt/wW1bRxnMvFElfkLhKXqS8cPQ95+qjQHz+//+gDG+UJzlkvDpIyW70hBrpQvS5w
	 l6B6V88VBofN5dKEnePbZC9vtQ3slRk/72rHQJbJfYL9VeArIHJ+aesybdzeROtpw4
	 0brdFhaRlXHUVjU99Jqt1h3082Jsg3MsJ6d00kpUv3Tjfg3B7S6CvIwCOnaZyMjhOp
	 V73t0MgY0J1EFRDuOOtgCV8RGzuI6/gng/JRvgx+VmM+i3Cz0nw5QgN00is0Zl740y
	 ApFWEKrUL0nHw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79zd-0000000713S-48Lw;
	Mon, 30 Mar 2026 12:37:14 +0200
From: Johan Hovold <johan@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] nfc: refactor USB endpoint lookups
Date: Mon, 30 Mar 2026 12:36:52 +0200
Message-ID: <20260330103655.1672331-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273120-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E99AC359837
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the common USB helper for looking up bulk and interrupt endpoints
instead of open coding.

Johan


Johan Hovold (3):
  nfc: nfcmrvl: refactor endpoint lookup
  nfc: pn533: refactor endpoint lookup
  nfc: port100: refactor endpoint lookup

 drivers/nfc/nfcmrvl/usb.c | 20 ++++----------------
 drivers/nfc/pn533/usb.c   | 34 +++++++++++-----------------------
 drivers/nfc/port100.c     | 27 ++++++---------------------
 3 files changed, 21 insertions(+), 60 deletions(-)

-- 
2.52.0


