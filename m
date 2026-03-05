Return-Path: <netdev+bounces-264311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAbOLvxlqWmc6wAAu9opvQ
	(envelope-from <netdev+bounces-264311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:16:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F02106F6
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2F2D307C435
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6AA384248;
	Thu,  5 Mar 2026 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK9O2Xr3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67453345CC9;
	Thu,  5 Mar 2026 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709065; cv=none; b=pR7+8N8CEBOsmE77nz9dIguKYwCkgibZkidaZH6GxS+3IRsy1VgLMyxql/oUlqhCZOaR5NlCamUn813tKZCcMtoXo6edFkFhi1FmNxt9vMNZ7EVz6i9VJqMJgce9UXObv3ByHREURDEpylKVAGTRF+2oT5AQgYgYybAsvqvwIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709065; c=relaxed/simple;
	bh=2ctdIRGtK/pIz7DwbckzKO/e7Kd9XepwmZ1GfS+cY+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNpPoukxYvcxYtT2ctZWDIhzfQx3N8Ru8L5PJG6rL7mMm5kA1qH5RHhnWukOC7qlUYmcL1z5N7gwRwDUxKEi4b+mTAPMaBnnHp4mGQsbNRRFBniUPa27ot0yMKGFDspXPM3dUsUrlUPrtQ2CpkT1Az5ax72dYwgSvnWXaxJKsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK9O2Xr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F61C116C6;
	Thu,  5 Mar 2026 11:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772709065;
	bh=2ctdIRGtK/pIz7DwbckzKO/e7Kd9XepwmZ1GfS+cY+0=;
	h=From:To:Cc:Subject:Date:From;
	b=DK9O2Xr3jjW5JOfShpt9VyYNblwIEjWqurK0zZD1kUXVwsCFfiKLgicyvcmRW0+D2
	 fLnqHCqyhLsqnWnGNBI3AYoTxQnMbOF0NPBFld0SMaKVQ7WSODyzlzHgYps42pzsFR
	 1uRUFECyQ9d7NbHpAaWgn5OKT2OLoYgd9jI3lw55kEPO1TjH8pOTIa8RdSJXJGpVuT
	 jn1RyTVg2uiC2MZnr0IbFuY9mj9EGWLkkCVI+fodt9W1/H0LIkuQ2uff4dUdmkiyBW
	 aomZ5B6+s5h1BBd0aTm4XWK/RVXpERxYMAfgZWn3Jta+rJgEtO/q9Ud7e5ixDtAaEM
	 UXtpMsZXR3DNw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6be-000000004hb-3XBp;
	Thu, 05 Mar 2026 12:11:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] nfc: drop redundant USB device references
Date: Thu,  5 Mar 2026 12:10:17 +0100
Message-ID: <20260305111019.18030-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 796F02106F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264311-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop redundant device references to reduce cargo culting, make it easier
to spot drivers where an extra reference is needed, and reduce the risk
of memory leaks when drivers fail to release them.

Johan


Johan Hovold (2):
  nfc: pn533: drop redundant device reference
  nfc: port100: drop redundant device reference

 drivers/nfc/pn533/usb.c | 4 +---
 drivers/nfc/port100.c   | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.52.0


