Return-Path: <netdev+bounces-289425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hPd2CxVODGqxeQUAu9opvQ
	(envelope-from <netdev+bounces-289425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:48:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE01B57DFC5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D93A30A1B88
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AC54ADD92;
	Tue, 19 May 2026 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2P5/vW4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6904ADD87
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191088; cv=none; b=oqNAnXub7mLtjrNWfw/qT7AStII0xwI6pZHbjZ+5T+Puh6HMlV7h9fubmLs4gP/xU5x0YLSkUwQDWLsaO3VaiCImSeMAOqyXRsQZVoaCUxmn/M9qPBy6JYg2/UykuHryLZ1yM4vPEEq+MjjWfuZC8Lpb0ixn2WJZucF2av5ffnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191088; c=relaxed/simple;
	bh=nrbYpBy868OO21naSXq+nQrVgcpPLfu559sT9xboaIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bm9sSlK+GrwhgFpuFzhUHUmlm48Xio+wVmd0WcZLZgRi7EvKnTiyIPPRpWquN75dSXoO4oFO/xVNjKgn4MQ5ED0syL67Gy7C+rub+h5ZXuXAF9YcGC+FCBLPh1pGEAyCpNnUeIrAicG2JeICRGKIKXmsX5tVjp6nYOSJAqjn6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2P5/vW4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so28423045e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779191085; x=1779795885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqqYqVafM0zolYsrVGJ5kVgLp6hSHmtv8+xcU2f3T4k=;
        b=T2P5/vW4CNRNkdbJ561HoBqtlwh2mIv8TvOeIBlprvLwXSOBP0hMItu9kVIidoIm0S
         E8hj9jKqt9jdE8tIljjCe33RhiJfPkHGhWXhJue+LPt1I2Pld3et64lPX+7fOZict/DR
         kUdMnJKrbqyqeLGgjlFlOpEFoJCwie+e7+r8ljnJgj6MKJ6ExL2bZvhpcpZapnG3NKe2
         AvVWuciCfAS0nRaVep02jrAJWQdNP2Au0MWOvrI2ZPJzUE6Maj+h7Ilz1YOFT4w9p52l
         wnu3zJrhnMfpSXkAZR3t3fJNmZK32Yck5WsBkIQmHbz++nMrhIcE/+9+MFidriZrNHm9
         jhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191085; x=1779795885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FqqYqVafM0zolYsrVGJ5kVgLp6hSHmtv8+xcU2f3T4k=;
        b=YUMXFKAlNl0BsiJs6wP0+ACZ3T3ar+d7IJ+8WceFutn5GxZc5tZSak3cq5aqclND2s
         AHw6Yi8ZJPeYhrOnDUnKnLrh485YU/SE4klKqR1r4CcG9Kk+ymZcASI65LYpcDxJTb5m
         Zt5PlTaGps9i/G4AKvHMA6bM6Xck8wGXhQa83VwH4hHLFXpFqn8OGY6KLSksjta6f4l3
         0FWv/BAHJipHeH68o/wkyJHHc7Gzgp/a7wdtkyr9ONNHZ+4vUEh3KzaXtgRPIZxUqNbC
         3VbkER3aqMM9Y3UDDU+sVsDjFKodrN1ZAh2b2cmzYf5NpcRyxveg0gGTjBwkINi0MP2F
         h7Hg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ccz36q6TNGRqZCPotLuxaAMxkv6cL0MkT2lDTk/0w7k3RmcAfmeiZDFhFCZXcNoFflHq0x84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJ64kbsj+wDUqlkNEdGxiCsChMImYgpckLDlqgi8fjgqe/hLK
	vl+0OxhEMNdNEISxkOEYMmmsUCP8qUO3gWoYYalUPv3mBZA778tNFcEx
X-Gm-Gg: Acq92OE20H1itxd8jF1+WKtU+e3dYVUI/lY4O2tLOn4Brr0k9pI/BPf20zCRgYYfNUi
	v+oy4QSzltSqBWJB7G/ixLRhJ2hF5v5tHaSzdCYUKfkcYXdG/aWH9oExTfsefndctK38wiR8Dkt
	NyCMnxiARfqRFb7R7QtnTnXYrB/3U9AuOv867fd1OAFfXxHtVOeyxEkuNLwYAMPk25P4SMXW3lb
	876vXYvq0Ox4Jx86PaLvhkAfxTcs+UNQzo75iKI81CeNc2Wxowi03yCfd217WyrNtRaMJM05Rpg
	CRpzIW29Cm2HdH4sbAle4YjIjjW1q0ZpVxU2JDQcxZqFqn+YUH8mwkd5myVZii6hCKbk74IJK+Q
	4GtN4FIs4Ondu4Zbgj3OcStiMGaLycivRktb6HxzPPsalBCh7vCxqrY8I7YIliL3Uu6omqB4hzE
	UTw6pk3XB6WCUBbbIRNBSGX7Z15Zly8jTULgAV1+uQireDkPyCuBcLwG8esJvz2nCzyp+aRlC/x
	kaVu6fiJELQDH5mxQlyBarltb0mfg==
X-Received: by 2002:a05:600c:a406:b0:48a:599a:3716 with SMTP id 5b1f17b1804b1-48fe651487emr233632465e9.23.1779191085040;
        Tue, 19 May 2026 04:44:45 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694f2csm323392445e9.4.2026.05.19.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:44:44 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 3/8] io_uring/zcrx: remove extra ifq close
Date: Tue, 19 May 2026 12:44:29 +0100
Message-ID: <be6c4a283a5bab5440e22fbccafe7b885acb7abc.1779189667.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779189667.git.asml.silence@gmail.com>
References: <cover.1779189667.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289425-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE01B57DFC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By the time io_zcrx_ifq_free() is called the interface queue should
already be closed, so io_close_queue() will be a no-op. Remove the call
and add a couple of warnings.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 4bf6635c222f..f4440881960f 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -575,7 +575,10 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 
 static void io_zcrx_ifq_free(struct io_zcrx_ifq *ifq)
 {
-	io_close_queue(ifq);
+	if (WARN_ON_ONCE(ifq->if_rxq != -1))
+		return;
+	if (WARN_ON_ONCE(ifq->netdev != NULL))
+		return;
 
 	if (ifq->area)
 		io_zcrx_free_area(ifq, ifq->area);
-- 
2.54.0


