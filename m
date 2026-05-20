Return-Path: <netdev+bounces-289774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLnaLdlWDWr9wAUAu9opvQ
	(envelope-from <netdev+bounces-289774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:38:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C475883D2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C93B33020107
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2771E51E0;
	Wed, 20 May 2026 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5pBkHij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E923090E8
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258837; cv=none; b=h0Opowa45gaw3WZlEjlq+4Z2dWuCfBSLwObQ690eAUMEY79Jr4Lc0yrm3w1lsDflHCJZ8jLOLep4KX2GBk5ApVUfiZax1PSBUOYdZYDzBgZFs6Cu+XTISVzfvscY9/y6MFQgOhsn7T4dHZUisf1TJ2kAqBfmV6SxhD87fYhINzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258837; c=relaxed/simple;
	bh=ON3SUb+gNUTfgSpjpQjmWG1OEoPnQ0ovZgTB4b7XyyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MW8xrCBFRNVB503u22GxvhmDqFHNIp4jVKavDH6Wox+eJ1MXxSGBMp1zbXc5bfvscwJtuFtLeT9WVlgUl7xaTMM+IKTTglUolZ5TSPb6iixUp95iQ13ubW4Sw868oBPEHEz3kFKbqAuPjD6W3qJKixT9xh7SBPTL70Ur4W8rWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5pBkHij; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso28180155e9.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779258834; x=1779863634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tp5tdf3jytSCtJBDtAwpk7+X6KgfNlO4Ji/lJX85F0=;
        b=N5pBkHijI5FI+tUKR1P53RzJW/tcNYi2Flq41Q62Sym6GnqzgxQCihGg+CFNLn6Ghr
         dJFIkJVnAOJR0aKsTT1X0tvzaVmeORa7zVq1yrxd2mTP58sWqhV4V7ngezB5kwDoTxei
         72jxFhKTJGSTRQz+sCM2UCYE/Guvk1VZZ4aU9EAXtfCkDiBQHDVW7yQblQlXzWOFsMo1
         am/5hSZ4ryacRkvgNbQv4nUdXhrAvB2JuZef049/3OOVDHUcUcYE5Rxxw9u7LUaX9kJT
         E97uAIdd5SO9B80+6SrYiLEnxPw06zDzi7FKkJ220aAWAFrHJoOzNKvbg40jr89woWX/
         /8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779258834; x=1779863634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tp5tdf3jytSCtJBDtAwpk7+X6KgfNlO4Ji/lJX85F0=;
        b=LUOUY0zNV3dPBUm1RU6e2v8VgNWTUcNvTg4VpnOZJPGqMxzTW5i49541Nf5zfPXlJQ
         0oiUf9IKKj7xdRAK6yzLZn90litnZycXJeQ3bTL7CNT2wcTBakMJeRSETBLpw4weszYK
         yp4DiCwRvULWy1Jx26qKYDJtSCbbwzwhGPEkdmLzbxYJ6QXI8pu29mzFQ0YwoOM7PIUK
         BfEqAsOQUxYEXq46IyFS+0dnnEuUNYxyMj9Pm3ej98/uVuiQkVThT5X8moy2134Zn4pz
         pq7cC7z+72Qu4bmJAKBdAbFyKgQKNlCnHKBHs0046IuPP8zhq5NYkJALENa0UF/9Fj5q
         ccdg==
X-Gm-Message-State: AOJu0YzOkAAtMXWy4i1luWpGVChE5Q0ltLnhNRreQMpdU4lzEBJ2A9GP
	oLCYf77owibRA0H+7iIEwV4WLtckowhSzYHG/x9TsPbxAJGkWtnWT0yFbdl1JMRm
X-Gm-Gg: Acq92OGDzHWzuB4tmAtS4eD1j1tcEaKtNVaq6gnKT89a1rUUVFtfolB7xN1B1BPbEvk
	4Cc/QpCCbgARA+sqaIn9LoCvkz2m/GV3LXZ/thytCbot+aM5oDcKYTRssye39ScXK/IWUjil/3G
	fDdgeXETIOavnI5sqdwdphZRgpYY5sBVzs8maYP2Z75K/Dzqr/RwGas8MfT6eYfiE35KL8DyyyQ
	0kuWPeYjbl5N1s9Ls53Ib5l1h3xkI59/JPXmaVdxmzVVXxTjRzIRGzTKkwvPACq/JyVNTonic4M
	CDEUyeS5x7boFInDiCp2soKPSHec9MwuKj26r58FR2xW+gwlestc1EE4OrU/6PNYr2dAoVDI8K0
	xw2Kt0QkfeZxh04VjIodEIm6pFDlbeq//a9qjozOWqQ3P7WlyoxNy2T2xS/lTfWZ9HBv9JbefMY
	583FOJVytbzktv9/xsU6lv
X-Received: by 2002:a05:600c:a11c:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48fe5fd536amr260148165e9.5.1779258833899;
        Tue, 19 May 2026 23:33:53 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm374290485e9.2.2026.05.19.23.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:33:53 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next 1/2] pcnet32: stop holding device spin lock during napi_complete_done
Date: Wed, 20 May 2026 08:33:28 +0200
Message-Id: <20260520063329.6387-2-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260520063329.6387-1-oscmaes92@gmail.com>
References: <20260520063329.6387-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-289774-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35C475883D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

napi_complete_done may call gro_flush_normal (though not currently, as GRO
is unsupported at the moment), which may result in packet TX. This will
eventually result in calling pcnet32_start_xmit - resulting in a deadlock
while trying to re-acquire the already locked spin lock.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 drivers/net/ethernet/amd/pcnet32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 911808ab13a7..4f3076d4ea34 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -1407,8 +1407,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 		pcnet32_restart(dev, CSR0_START);
 		netif_wake_queue(dev);
 	}
+	spin_unlock_irqrestore(&lp->lock, flags);
 
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		spin_lock_irqsave(&lp->lock, flags);
 		/* clear interrupt masks */
 		val = lp->a->read_csr(ioaddr, CSR3);
 		val &= 0x00ff;
@@ -1416,9 +1418,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
 
 		/* Set interrupt enable. */
 		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
+		spin_unlock_irqrestore(&lp->lock, flags);
 	}
 
-	spin_unlock_irqrestore(&lp->lock, flags);
 	return work_done;
 }
 
-- 
2.39.5


