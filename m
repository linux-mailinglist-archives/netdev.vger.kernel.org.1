Return-Path: <netdev+bounces-264310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CdKExdmqWmc6wAAu9opvQ
	(envelope-from <netdev+bounces-264310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:16:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA616210723
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F793069AD8
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56C384244;
	Thu,  5 Mar 2026 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GibHq6PN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67552379991;
	Thu,  5 Mar 2026 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709065; cv=none; b=DBSDvJsJF6R9g3IzfFXvc+Q7fBsnGHavPKZGAjB3ou0OBwWgV7VD81hqeFnbrvGS3yejfpn4FSVu/yftL55VnncxDWn2Odk8nw8bZQ14xPgN2ChsbhHH2gEqK0sfuxj7fQODxJaVzp/J+djpM6XxKIjYohufrUt4nLFSaSHQDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709065; c=relaxed/simple;
	bh=KF+nerb/kkfSHoQTb1v+tdHzVkMi/sWzcg3R9XOnT24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPKL3G4Ra5ETXDjvbh04U5bF0SpNQHJbfOVpKBeASngtU+H0cAayESvZaJDG4oK00t2DnqyysGXk+0cUggd6UmIOgBfSSBLp4u4TJghXKnLkAFAZFjLwFlQrTRfEUJ94ZwgB11B0X0cplDZMtvTyzvM8rhT/67dToTAJGWEJiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GibHq6PN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069B3C2BC87;
	Thu,  5 Mar 2026 11:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772709065;
	bh=KF+nerb/kkfSHoQTb1v+tdHzVkMi/sWzcg3R9XOnT24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GibHq6PNTSqFVnrNO8+GzigPDCPMR+GMaoHYIyqXw00TkGU3Lkt1fwZHv0il0LSkF
	 7QPblyjrIuJXSpxbHSqxyvsTKCjFyDjMR1cdkkGSECjuccudQfcznWDEQjjDlGKgpq
	 uRiO6YgdFoM1rrgZotx2VzUUDhAp592LwZKZpRXcsIjZtvX9YxUZLkBR9UVG6IlusI
	 k2KtQsWdPd9Qr7G+Cg/7IZCsPU84SJJXOtIs3rD2Ym+huKQb0Xg9H9E3y2nMNuu+Ig
	 smncpE2d8UbLA1zwMfLqxRXVA3T6k0F29sb0Y6u5bl4MiGtWo/wgKrIZK4tgR0gfil
	 VwjLiC7x1sz7Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vy6be-000000004hf-3fs8;
	Thu, 05 Mar 2026 12:11:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] nfc: port100: drop redundant device reference
Date: Thu,  5 Mar 2026 12:10:19 +0100
Message-ID: <20260305111019.18030-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305111019.18030-1-johan@kernel.org>
References: <20260305111019.18030-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA616210723
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264310-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

Drop the redundant device reference to reduce cargo culting, make it
easier to spot drivers where an extra reference is needed, and reduce
the risk of memory leaks when drivers fail to release it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/nfc/port100.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index a922569d7b48..09dcc6f4c4f3 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -1504,7 +1504,7 @@ static int port100_probe(struct usb_interface *interface,
 		return -ENOMEM;
 
 	mutex_init(&dev->out_urb_lock);
-	dev->udev = usb_get_dev(interface_to_usbdev(interface));
+	dev->udev = interface_to_usbdev(interface);
 	dev->interface = interface;
 	usb_set_intfdata(interface, dev);
 
@@ -1616,7 +1616,6 @@ static int port100_probe(struct usb_interface *interface,
 	usb_free_urb(dev->in_urb);
 	usb_kill_urb(dev->out_urb);
 	usb_free_urb(dev->out_urb);
-	usb_put_dev(dev->udev);
 
 	return rc;
 }
@@ -1636,7 +1635,6 @@ static void port100_disconnect(struct usb_interface *interface)
 
 	usb_free_urb(dev->in_urb);
 	usb_free_urb(dev->out_urb);
-	usb_put_dev(dev->udev);
 
 	kfree(dev->cmd);
 
-- 
2.52.0


