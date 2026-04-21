Return-Path: <netdev+bounces-280164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLajABST52lE+AEAu9opvQ
	(envelope-from <netdev+bounces-280164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:09:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 532C843C8BC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2241630DEA76
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC93DB626;
	Tue, 21 Apr 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX7IFuO9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935E3D905D
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783515; cv=none; b=GChdeu6slmGZVuIev2tr6Zpl0GuMfgKuG9nziaa9oNEXJBRMnEYfQt0vsUtRax5sWeMH7QOrl0ZNxWsxrVJmL6U3KbWoMEZsCwJi2nkyzMeOnXmG80WvFcY8oJuOsxIn4JVgtYOTQZJ+AhaUnP0h2hYdtLYMzzcvJmhGK48hKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783515; c=relaxed/simple;
	bh=oMkPWBQsIyoDnS+6ID/6raP7oGgOgpzWjkT5mVWy8yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=de4LmjkKzIEdz1qAtczj9dB4GxPRGjxD5Tjvr3fhB6Z+Ha8Esb8Hck82nVXXxZjW6VJHJar9UEuyWBqPFd7+sYFU6DZeSH6s6rHCqpOWOvr46RMvzMRjWJiPQPBSgP0qjaSF8w/peSpLq0ZgR5GHrTNGFYcnej41Cy9GCX43AMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sX7IFuO9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso22002705e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776783512; x=1777388312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ35oSVSI4KSh+xmtYFc6UscETFGPvX8289l7HgBZZY=;
        b=sX7IFuO9Lry8AJxT66mZzoFtzq76iRkJrtiR5o5lF13RDCw/vYkJaaEFTflld3Kgd/
         U2g92QwLkrUlN93eJ5o4M1DfovBS/FLCrM/0lSU7s12KKKCFOwUFTXKl9fMCemF1x5qG
         C4L5aUgvGEWz8wtZYN9PbtbnnnvcYTWTzpP3t1Bd5bnUe9LufzfyL6qR62SJJjF3F7wQ
         dbt1KBIH0+hF8qjijuyJW7hd4g3NaUjUwBWckYf0N/h73HuLhJTtYYpda3NBta/NNmHn
         fmHGYzsgZyesHP0FP3Sweg8aqmxNuAjNtVgYE/49Y1flO7uzzeWanJI6nUY6y4HG461I
         sgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776783512; x=1777388312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQ35oSVSI4KSh+xmtYFc6UscETFGPvX8289l7HgBZZY=;
        b=Y0ARKIT5EzPNm1YSMA7KZGL6cYo2NR1ZGNfGni4YZN5BRs/9tbuiFweJMUwDqGvTs9
         TNcb8stD80BcMevz4r3q1gWgoGQQpYl50G8YzP8SzloFBKWVMKptvUYqsbkWcgYWZjem
         aTwQ5yqC2+jOIaYs9HsngGaCzokbt3ug+xD06eE84O1UCO76/2zpj8EZy4qYiT99YZlT
         OiT43BDnXgj6Y4C3T7AJY7O4CnWrLa1fmsYv80GszkLB+QBbJ7DsgF6MECmKVU90TlG7
         nffOgd1ZxKkrsbJn7U+OGSop5mU/qItU0VbNXpQf4JWFZPxI9xo+Od6YH1j22cVdOh6x
         Pj8A==
X-Gm-Message-State: AOJu0YxjifNr5t03Nq2IO6H/6zHTDYX51idIjEh2O6Be418YyJvGAQd8
	Us/bO3LZdz263M54xNnLZUXyKVH8PN8lVsCs/xe33QXsy5TQljhHX9q9FjGFu/9wb7U=
X-Gm-Gg: AeBDietMEvc+hDiSpnSA+NBAnA879J3POGLBXzMevyxqIaLYnRn3Un22sJ+BLhJihyo
	jmcMC+SsVckEml/vtIQ2XHXLp6hu04fwv4hWVFM47qwz2YQn7o3qtaVn+7wd/pybIZVJ6F94Y+N
	sX0Y84gtvpxOClCfTLPKeby/NLnOjF2UPdqXC/JaBH0HXkepIKXdWxOVhK4UanKyQFSG7bFzaSk
	i2BX5KT+5ZNM1NxZFzO7NKMJrnKTAMXBqwyz1d8pdedQfDerUt3n284DoKkyfdpGX+BtxhAtNME
	VkSDeDTtSfh4xvHafmSuVpkcHcmz4eAUO9vI5jqS3V3ikqa/enMZ6Yk2RLO+lejkhs50sp2R8X8
	A7+3fSiHDx8eVQ+t2gpiQEb7uVuzyeFPEtwMhDdafOgXmD+33lo46CMcQv2BmLQh5rSJDe0IzfY
	cTV2W4ajlFMHsPWYQSF3khVArUQ/ZN2mgOmnSpnEEkbBXHllQL2w==
X-Received: by 2002:a05:600c:c085:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-488fb784948mr194444645e9.25.1776783512142;
        Tue, 21 Apr 2026 07:58:32 -0700 (PDT)
Received: from nixos.int.ionis-it.com ([163.5.3.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a0b60sm110771715e9.17.2026.04.21.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:58:31 -0700 (PDT)
From: Titouan Ameline de Cadeville <titouan.ameline@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Titouan Ameline de Cadeville <titouan.ameline@gmail.com>
Subject: [PATCH] net: ne2k-pci: fix missing residual byte in block output for 32-bit IO
Date: Tue, 21 Apr 2026 16:57:36 +0200
Message-ID: <20260421145736.15949-1-titouan.ameline@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280164-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[titouanameline@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 532C843C8BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ne2k_pci_block_output() handles residual bytes after the main outsl()
loop when the transfer count is not a multiple of 4. It correctly
handles the 2-byte residual case with outw(),  but is missingg the
1 byte residual case. This means for packets where count % 4 == 1 or
count % 4 == 3,  the final byte is never written to the NIC's data
port.

In practice, this is masked by the count being rounded up to a 4-byte
boundary earlier in the function for ONLY_32BIT_IO cards, but that
rounding itself causes a little information leak by sending
uninitialized kernel buffer bytes on the wire

Add the missing outb() call for the odd byte case, mirroring what
ne2k_pci_block_input() already does correctly.

Signed-off-by: Titouan Ameline de Cadeville <titouan.ameline@gmail.com>
---
 drivers/net/ethernet/8390/ne2k-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/8390/ne2k-pci.c b/drivers/net/ethernet/8390/ne2k-pci.c
index 1a34da07c0db..1bd5b94b5d22 100644
--- a/drivers/net/ethernet/8390/ne2k-pci.c
+++ b/drivers/net/ethernet/8390/ne2k-pci.c
@@ -632,6 +632,8 @@ static void ne2k_pci_block_output(struct net_device *dev, int count,
 				outw(le16_to_cpu(*b++), NE_BASE + NE_DATAPORT);
 				buf = (char *)b;
 			}
+			if (count & 1)
+				outb(*buf, NE_BASE + NE_DATAPORT);
 		}
 	}
 
-- 
2.44.2


