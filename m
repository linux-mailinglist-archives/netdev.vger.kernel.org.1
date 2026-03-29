Return-Path: <netdev+bounces-272977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JPjkAIx4yWkiyQUAu9opvQ
	(envelope-from <netdev+bounces-272977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A3353B69
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ECFE300614F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12A337AA7D;
	Sun, 29 Mar 2026 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH4q9LzE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BC282F16
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774811042; cv=none; b=IzjGWH9cGgbbpc2B1yGZxDOZp20dh4A7SJdeFumhrCzidcjYp7LP89xPBXadIv2/XdDW74ZRaLU8Dsdvw0ydFdIEtsEfx7BzKN2K1SNVXWtt1WT25HO9LX+WYjf4nAQgymwpRfR1os+RPiW/56K6ApqEFU2HCUxwVp+jPN4PaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774811042; c=relaxed/simple;
	bh=70pqPdPbl7uQp20iWj8a4rOSRU/Egok3eSzupS/bzfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNkKdz4xtyP0BmIAE1OHkj+4WEEr1ELk5sBhW6AXuDzw7rKWzCbq7q+JY6H5X6apjV+r3KF8yrrrkAE898BiO91XRHYCPLx+TTbZ4M3xdKNgmjBDIvsONgk6GUYofwcTCY0Pz+81b8D0vmN02/F1Tj8XLX5QPj4wKzImI8wYy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH4q9LzE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso2716326b3a.3
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774811041; x=1775415841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mU/h+l86Dxfj+U7yKBkezYMTKfac40N2oWD7yA0Gpk=;
        b=TH4q9LzE0klnG22PCBXOp3Zx5pzMHYShhLuAit3bUOR/0fwIReGIKcGfks7mrqlVJ8
         KKFUHyTFRcOW9lxQrJneS7ySRuNGLXUzgnJaFYJbysE6S/zcmUidQ4fH4oOrHvcFodpp
         OC3Ityh30QM4AtwDyEQa7QDWXZbJil9xcuscOS/pgxxI2yIlET1OOi35WhPIJqDg9xIG
         TOzjBixuDo8x9u9BOKxrGL60snxUrPW06ap1b4740zSbvA2McO748doTHpAEss9hlvsL
         y+F+YsLeCprj+qLy0mkIF1+tvf0vDakoZpZnI/1hAUADW1Eu/O0UOdBEypUIPcnTOH5K
         nf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774811041; x=1775415841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mU/h+l86Dxfj+U7yKBkezYMTKfac40N2oWD7yA0Gpk=;
        b=PYmi+XAS1yDmOymlsKadHujyXhz20kAn09Sds2OhHV3RQit29jbMm1kBZc/290llR/
         ZTUNTGG8frQd2z4RqQw69WFC3+pw9RKzWy2p4yYWIMFUMf3Uv1wHuVZV4kVCZ7b0dKRf
         WEfYLfByzdLSo0RPSBjIAgyYrNR7pLGvoN+tbJ4wOLxC0hV30na0w0z71BsmfwVVM4jd
         9n3tBCPmfW1g+s5LXMin8HhjPJqVGQU8+8Co3dMJOeNOBW2HGObYZK4REtYBxw4erJ63
         8QoBJ7eV0+4YZFlDRwTy0Gzgo04MKFVZGFxG71FCzCza9aBVQAHPHShzRBhyE9tnsA91
         81VQ==
X-Gm-Message-State: AOJu0Ywojj+IZBmhTJoCdDtmqyh3F9iLRdUIlke6VCiILEDWgfqY2IlB
	LU5t5vVJPCHPPbHJ4kd6HPU0jrv+P7QhWK/RuabGr741RLVQ24NjpKoU
X-Gm-Gg: ATEYQzwcz5eriJzXP0zR9XBBeuYhBmvOXBjyD5lTQsEW8wK/uVcBvws1PP7kgB5cR0W
	S/G3KyZeje2uzitgXHVFFbrT9MQCXqCn3kSClE9r4+fhRd+Y9TaFz+Xv3Z6kPcRaM6x26G6+wyc
	bt9gtuZOBmZVUs1hu548rShDccpOPXr1i0yKSsRAEwG31Pzu16BQ/PRLWRmyv4zo0FH/m6M1yEH
	gzXa3Uq1nbWe+uayV/N2OSMpbbeP4ZQMMBSkiaTIKwNNniZ5C4F9epkD7uFvFljwLa7Ul14WXCC
	LY7RsWKXQQIBVbe3H1eC4xVEmx1W0DCAMfhiBxJB2gSvdPABu/071/FM84oqJcfUvJIWTRQdY92
	UYAwic4pDcwAXfVUVLyS4gKh347H0+oRulMwBcgKdn4FQfCzXtQ5s1FY/qPbpogPLxcW6gYD5WM
	Qrk1+YTKK1Zhtap0beJw==
X-Received: by 2002:a05:6a00:1acb:b0:829:bd4d:3817 with SMTP id d2e1a72fcca58-82c95ed4749mr9205453b3a.28.1774811040776;
        Sun, 29 Mar 2026 12:04:00 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843b818sm5866178b3a.6.2026.03.29.12.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 12:04:00 -0700 (PDT)
From: Kangzheng Gu <xiaoguai0992@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	thorsten.blum@linux.dev,
	arnd@arndb.de,
	sjur.brandeland@stericsson.com,
	xiaoguai0992@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
Date: Sun, 29 Mar 2026 19:03:50 +0000
Message-ID: <20260329190350.19065-1-xiaoguai0992@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAKvcANP6ihR9ZJpm73ep6aTPqzcpVhTHsVSgGBd28HwwfdBcxw@mail.gmail.com>
References: <CAKvcANP6ihR9ZJpm73ep6aTPqzcpVhTHsVSgGBd28HwwfdBcxw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-272977-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.dev,arndb.de,stericsson.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F4A3353B69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cfctrl_link_setup() copies the RFM volume name from a received control
packet into linkparam.u.rfm.volume until a '\0' is found. A malformed
packet can omit the terminator and make the copy run past the 20-byte
stack buffer.

Stop copying once the buffer is full and mark the frame as failed by
setting CFCTRL_ERR_BIT so the link setup is rejected.

Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
Cc: stable@vger.kernel.org
Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
---
 v3:
 - remove the Reported-by.
 - print a warn message and reject link setup by setting CFCTRL_ERR_BIT.

 net/caif/cfctrl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index c6cc2bfed65d..373ab1dc67a7 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -416,8 +416,16 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
 		cp = (u8 *) linkparam.u.rfm.volume;
 		for (tmp = cfpkt_extr_head_u8(pkt);
 		     cfpkt_more(pkt) && tmp != '\0';
-		     tmp = cfpkt_extr_head_u8(pkt))
+		     tmp = cfpkt_extr_head_u8(pkt)) {
+			if (cp >= (u8 *)linkparam.u.rfm.volume +
+			    sizeof(linkparam.u.rfm.volume) - 1) {
+				pr_warn("Request reject, volume name length exceeds %lu\n",
+					sizeof(linkparam.u.rfm.volume));
+				cmdrsp |= CFCTRL_ERR_BIT;
+				break;
+			}
 			*cp++ = tmp;
+		}
 		*cp = '\0';
 
 		if (CFCTRL_ERR_BIT & cmdrsp)
-- 
2.50.1


