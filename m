Return-Path: <netdev+bounces-277048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO9BIKrE12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:24:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F23553CC972
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82C1830156D2
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B7D3DF019;
	Thu,  9 Apr 2026 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYYCzbVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B83DF002
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748244; cv=none; b=GHD5twLjpbW/DtSSeR3y38eQq8cM8KnCahp0aKcD2TzymZEFMlI9nBJz/IktEoVqC7yp2LM0kda3ebTifGeHOTS1ypy94s45txkKNtpWhRS7DMle6ZsKSSUULt+qs19BCsAQN7eyhOjOrrn0GDZyuQ0HdW9/buaRHTQgrheIg7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748244; c=relaxed/simple;
	bh=2neZ3Cba/z6x9Y8TtkiogWJSDFaSYQusxUMlV6UD0Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JEdUjlSBGsAxIl1UFtAOsopHlqnCXThQ4Ms6/MzekNdvQEJEJFlhjWF0SyvXhXRYChE4b+tz2HJy3xxQ3eoKQS4yaFvqqbqMJcfgyFPkOPWuuH9inmqiLfJc2st+0V2W2yfklgm1dE3XnVCIToV859I3ByxWDsKxmuwIjOS/2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYYCzbVr; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a151012558so11398076d6.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775748242; x=1776353042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoVMgFSg7TgoUkOzz8poiLNf0wihCgPQFidePPKr930=;
        b=CYYCzbVrtm1xTziVup297Rmp3zw/sHVKzTVObORC9IisocqZYjq9W+1BatWcyHW34r
         uloOZrl2Vs65A0chxFdwaJDEnjp9xrgedATnbbM6WurjOm4lrvpmF1G/Yy/ggsNUFQMo
         /SSr7FW6SqYa7dvyQTAATy9gh4+KteE3R0K1g2tE0VQV6zCXINhxggjMvblbzIdJw3uv
         B11nik8OTh4Q23ObqIzRqMlOycGp68ScytSSVFTd6nXPlpk4Kin0txywAwljwRhorYtz
         v6pLz1DissAzLzcw/+dDvnykQ7Dbkb6lTJCDpVR0s+3tngFsbAOfiUKg2MPUjsqq8MtU
         T61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748242; x=1776353042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BoVMgFSg7TgoUkOzz8poiLNf0wihCgPQFidePPKr930=;
        b=jT+xckWXnO3ZC7Kbg6t6p1lvb7/WUHZoDO35JwTWCthfonIAFvegbL8kc185tXuON5
         OyZKJlV6KWtOuKJT4qLe5IiZ18PBnQCTg3jec4HaCfhhPx9OsSPaA4w4hVZ1A2+toMo8
         KadJc9pPkG/N1V/QuDu6Or399fvlrslNckRPa3l+r/fvCbQ7Ct2C/5ycpZ/8Zd88r4k4
         uCPNKymlZECa86JMdxjpKaKCn5/tbhhQ4o6RaIaLNFMM2IQsKl6MuaZsybVP0EbGa3mw
         XD0znuVFbg7diaUtcVsn8Do2j0k5076QmKj6EwWDqRGrMNR5VADZTjaqKSe1gIwfkVVr
         4CSQ==
X-Gm-Message-State: AOJu0YxU1Gf219ExY+DEzt7j5Z9f8hBTPU2M6oGU7NwTiuynOXOPOWCv
	SjpVmLBDyZ9lKcqNhD2J2QLbCoal/oGoXEEB+hY/SZ5A1tV1pq5AP0FrkxvcvYiXBDzd5g==
X-Gm-Gg: AeBDieu5980wP1yC1rUvlFwxLzlIXDL+p1hUge38wXRyofSKYqCLawGeFbMClcS2jE5
	85Qsp8RCnEcgvUw3ZbVVwWx6E8A0DR0zGE+GlR2NBl6OZBZv/2hXE83fhyHIHmLtCRZv8P8NxcA
	txfH0jfoyK9HF4oJEth7HvFCFylrprMSPERWFVZzRhzbnIZY/X8G1zuTiH9/GB2nczZdDGlnG9e
	4CprYFYhAl5t60mCbTJ2HznUT+ZezsvzX1TmPRhdiQPDYdDt8zL+wTMH4+ICSQliNGeQn88wajo
	pHYm6Tn/8QiZCOgUwbBsldZCrHd6RoHxgvd0S5MJd6QoChNz3phBS4paO5f1cevxppigu+RqEGt
	S/XUNoilgUrIBbYKjgPBE9Pe6S20GW5QxTQ0b2Jn25z5UN+ko6sxyH2+f378EdtBjwwQHpdq5w3
	H3e4mV0cmX5y34qEEc9D1IVmVaSoq+/ssaPOKuQ+KnTu6sy09OKSZoZ87h1pko4s+eqsFb1H3UI
	/JqajcCtu29TPfSEujLZ1+dlr9d
X-Received: by 2002:a05:6214:4c8b:b0:896:cc24:138e with SMTP id 6a1803df08f44-8ac74287bfamr58007166d6.54.1775748241840;
        Thu, 09 Apr 2026 08:24:01 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac56e3a898sm72809956d6.38.2026.04.09.08.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:24:01 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	linux-hams@vger.kernel.org,
	jreuter@yaina.de,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] ax25: fix OOB read after address header strip in ax25_rcv().
Date: Thu,  9 Apr 2026 15:23:59 +0000
Message-Id: <20260409152400.2219716-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iK7bzV0VpPsP5nu0mV3GCsN5MOZJgc_s8a3B2X6Ui6mxg@mail.gmail.com>
References: <CANn89iK7bzV0VpPsP5nu0mV3GCsN5MOZJgc_s8a3B2X6Ui6mxg@mail.gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,yaina.de,davemloft.net,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-277048-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F23553CC972
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ax25_rcv() calls skb_pull(skb, ax25_addr_size(&dp)) to strip the
address header, then reads skb->data[0] (control byte) and skb->data[1]
(PID byte) without verifying those bytes are in the linear sk_buff area.

The original fix checked skb->len < 2, but as Eric Dumazet pointed out,
skb->len counts bytes across the linear head and any non-linear
fragments. If the two bytes needed sit in a fragment, the check passes
but the direct skb->data access is still out of bounds.

Use pskb_may_pull(skb, 2) instead, which ensures both bytes are present
and pulls them into the linear area if needed before we read them.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 net/ax25/ax25_in.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index d75b3e9ed..6a71dea87 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -217,6 +217,11 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	skb_pull(skb, ax25_addr_size(&dp));
 
+	if (!pskb_may_pull(skb, 2)) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	/* For our port addresses ? */
 	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
 		mine = 1;
-- 
2.34.1


