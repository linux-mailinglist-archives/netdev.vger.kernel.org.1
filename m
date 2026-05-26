Return-Path: <netdev+bounces-291651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDawFtZ3FWrHVAcAu9opvQ
	(envelope-from <netdev+bounces-291651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:37:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BD95D443B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 674FF3007537
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A393DD85A;
	Tue, 26 May 2026 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqe4oZev"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EA3DD84D
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791828; cv=none; b=lnAcKO6uCGU6WZvlIsigvuLga2xOUMDclAlI+W7AM8ktdQWCeRsk/VgVfITYAhNVhtUGzYqZbvRcqAwqfflPgEwz16GLfCjJsdiheNA5q9Jq6aWgeupJ/Z4+c1khLL0/xR5eFyseMex8qFjdSb48caFUo1/DRibo37hUz0Fe1cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791828; c=relaxed/simple;
	bh=CsiTsv/1l7mggcdwLKUqnxbE09kijSqhz0bUK0ua0d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pgP2Ge11wZpYVV5jYSX+IWJeowRuI794w4ZUeu0B2Si275yDNIlQFJuq/xh0FVyiWXe3GSI1csFLJMv36suXSze1DVn0LLKbTzhNZN7Vdy8yaRHBRR6iG8QQRuLN496uE0ucRxtKWaNLYkhoPvUSS6GCF0LCAg/v7MV2TmU8AdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqe4oZev; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bd80b3aa13so68651735ad.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 03:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779791826; x=1780396626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/yaOwsGJNkYNFjCd20VjnVBfxpqW7YKrgDY1p1A7srg=;
        b=fqe4oZevWFNJWaE5X/WcjQ64mq3zpmnsWjStyVi+IiCx1F9rr/gx6CN14liDmEQzWT
         PRiaK1bkpjcTpzzF1nDLwczAAKGDTse4+qqSlmomjAqQxVD9gryVs9EplEknr/G+a3Bw
         iLKJ+xzOIm6Etn4G0BvvoUAzKgqZoXHAH5WEOCiGLvPZ0UYpLLcHqd6bs2QShh+7nciK
         1D1GGGL8EwXqbdajxZUaOQ1Esq23ly1FKYSih5JU2mThnl0S3gGp+Fk6wcQxFBQQJVZN
         OFCmXeb2KeF+SzvBYThsX9AOACiYLVBTZv/B5kueanT+P/joKCM0gbnRUG0zBK0wZ4o9
         HIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779791826; x=1780396626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yaOwsGJNkYNFjCd20VjnVBfxpqW7YKrgDY1p1A7srg=;
        b=klh+52mGrGOXpMNkCsHp6wQdVnV5ZoIcY6EJuJroHKFRU25vGpn9RXuMFiuxJhmjRl
         QwJ+AFsTnq/cQVJE4eSIuIIoaPVp1TaieAPWq8WAfRvGG+n+E1IlPj3xbHdbZ6rlFgXs
         jR3BOBkkb9S5ww8vMrXwuQnkjpsGjr5ICDki/pgC5Vmfn2ohisA3KPeI+BsP6onkT4GL
         w/+Hg6mudmYzCwv99N1EOPUKoOmu69REUXYaNRMHMQsCo+K/BSQroGiVuvpanB0Ng+Uu
         xfQ5brIUT9WByQ16py8t1+G5rUXaFaa8b8RsNE0RFZXCnyc4iHpP6wCPc1ZZChQmLEUk
         0MsQ==
X-Gm-Message-State: AOJu0Ywqr8jGPACYTcc4BrgwA5AU9hcLdcOTBGZeNzJBpnpMsUtXGoZn
	l5seykWm2/CoWpxR3dPFHis+j+J18e0NSuHEG0EzVxFsMIU3bpEGlsOv
X-Gm-Gg: Acq92OF6JemYR+3EgkqOQ2dBb9Ju2W6Ucu7ZXv+ePO+QbID/qF/B7BZjMfRgrZ0IgtZ
	MBT93kJRMwvm1zg2VbEyBZH5SLwWwn2XRQV60heURJMK1Mg23wxiDXz+vCp0/K+mQs+eASdNOop
	T1wGUA/TLgAVH5YYbrKIh7PIx9aDwVMdB4NvBAz4fmikTWFkaD1TBHBO7L1XmCu3Xhz4qeO82ul
	GhljYN6VBjLcWUU+5TglGumHIkqla/o0lxhdwt9It9UvEsO98LkPGwttaqYmchN5RS58okuq5NK
	8lpSAiyIiHSK//A5oUXK9Pn2FNqOFPoig4k56mEC+3XP0mgvaDnH7qSdckUi60VfCDIwfq496bn
	juLJBVfWVzN/cZDSulKVwZxLFy5y09Kj4k+xBiQAILqQl2nLYANy7hRFiEEx3Q7Rs742ZaBlwD0
	RiSslKLW3x2bSzDSb8yOxjg6DW8HCO1TUsg0ixPzWZhZYlePTKK6VOUn3aSLNC
X-Received: by 2002:a17:903:3c2d:b0:2bd:d4dc:a4f9 with SMTP id d9443c01a7336-2beb07dbdf2mr204784605ad.26.1779791826529;
        Tue, 26 May 2026 03:37:06 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56b7920sm124202275ad.21.2026.05.26.03.37.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:37:05 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: 3chas3@gmail.com
Cc: netdev@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH net] atm: skip driver close callback when device is already removed
Date: Tue, 26 May 2026 18:36:59 +0800
Message-ID: <20260526103659.86519-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291651-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kipreyyy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E6BD95D443B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After atm_dev_deregister() returns, the ATM device driver frees its
private resources. Any socket that was connected to the device at the
time of deregistration still holds a valid vcc->dev pointer (struct
atm_dev is kept alive by the VCC's refcount). When that socket is
subsequently closed, vcc_destroy_socket() calls dev->ops->close(vcc)
which dereferences the already-freed driver private data — a
deterministic use-after-free.

Skip the driver close callback when ATM_DF_REMOVED is set on the
device, matching the existing guard in __vcc_connect() that rejects
new connections to removed devices.

Fixes: 64bf69ddff76 ("[ATM]: deregistration removes device from atm_devs list immediately")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 net/atm/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/atm/common.c b/net/atm/common.c
index fe77f51f6ce1..cbb87b9c10d2 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -177,7 +177,8 @@ static void vcc_destroy_socket(struct sock *sk)
 
 	set_bit(ATM_VF_CLOSE, &vcc->flags);
 	clear_bit(ATM_VF_READY, &vcc->flags);
-	if (vcc->dev && vcc->dev->ops->close)
+	if (vcc->dev && vcc->dev->ops->close &&
+	    !test_bit(ATM_DF_REMOVED, &vcc->dev->flags))
 		vcc->dev->ops->close(vcc);
 	if (vcc->push)
 		vcc->push(vcc, NULL); /* atmarpd has no push */
-- 
2.50.1 (Apple Git-155)


