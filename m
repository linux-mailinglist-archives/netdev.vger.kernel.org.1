Return-Path: <netdev+bounces-244884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE0CC0E92
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 05:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6FEB30FEAB7
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00AD33DED1;
	Tue, 16 Dec 2025 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5n4gzbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049783090FB
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765857655; cv=none; b=Y3bnJvLGBz5ogjpkOJ7bxna7/EIyp5wD48kua1qxcghq2GJnzXXVfI0fGqXG5QMsg08hisQtMyyt9lwQNG1qBU10zaqaCk9Q1Qg60sLnOZOhTGoezGj6BZOz1BzeaxIHRXk/YGfoFGauxNm5edFIrNC9ZQl/iN0mo0ezZ3+OtAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765857655; c=relaxed/simple;
	bh=ITo4f1ye+3ONUsUTYHIV9+vq45fgxRSCb5RTsvRpKEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg0NLDuIT+9p5IFEf9wnf7yygQzDqMDYNIpbgHErmL9cMjMBfQZ+TPsEQ2V0TrkeJddILTGsFK159UVnBjV9EET4Hc3NJi6CORi3knzReHmWKI02n79swGRtSPAfwjTcPSVLp6xCE6cm5Zr9zFHA/HLM9wZnRKyh52Qc+DxVvoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5n4gzbj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29efd139227so51002375ad.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 20:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765857639; x=1766462439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLKyDg7KGa0B81T7SZGWL6KI4wf1AUYvxVh+ahhXSkw=;
        b=N5n4gzbjncynyYA0w2JSsdTM20zwfhf2xcyQR/q4NbOOFfLSBWd5CNKJzM6BPg/zO7
         UpaTBtiN/y5lYmK5s+crof4t4SlYZ5pOIBb9pAxwwFxS0WKQwu45ktJZbPimdgXfv3xf
         HLmm6mpVQ/hqZHUY5bmkyUphRc50XgrHAH5vR+n6352eRSZYocW9Xph+8qDFXlz+cSfd
         3ghRi9q0POZGSgo0AFBCHD4A/k8ehwmzqAr5THjMsjACCy//qrAhkFLWo6I23sXRoMyf
         vc9IjjtU7kiHgAXwNxa+diPtlz24zWDsx/LKuoMpZF1qsNfoaRaIsIwOyHMmA1dkym9F
         UCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765857639; x=1766462439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tLKyDg7KGa0B81T7SZGWL6KI4wf1AUYvxVh+ahhXSkw=;
        b=sYQPrzWPCS6q3gDE394FD7mS0tkfmvWtQYI1GjvEwcHSebO7lHsDcCgtAqhMNN+N3P
         g4UJeqbSdEPiA+S/diG17Br0QJLgFjelxyQeDapPnMR+RghrqYYh3rGQrZoeq7PSttkb
         83Hejvjh6KdkZ8pNnR9yLBn7pqq55IrLvnlC4ZVy/u6Hn6+2yRPWNhRnURtAJvRyk+Fh
         PfOhfN1m25GfezjKbcnpaCwnC9jI5vFtOekCy2RC6+VqWozR0tNE0wIaZdy956wlfUmK
         gMau/g2RI/z1zJT6G/aTqoAjWQ0XyOe7IR1tJxrPjfbpI60xhuo47+lcZR191+tuSLwn
         KCsw==
X-Forwarded-Encrypted: i=1; AJvYcCWj9wChNHQiqd1FuerdGdXTraRtRFv6qQ3GbMXyoMRAXz55J6+aVVMbkUwd6g/ATc/AhHGxfRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiJHOaW95kB6mK08VlPF/xixPdLYLDZ3crTtQHv2v9YwK7+rh
	wWag+Yuhm2TLMiGaPeqykRfJCT9bNIMe4lOqabx19svQF9rw26A1bu7y
X-Gm-Gg: AY/fxX4U5eHAu1SzhOnJGc6EwJOGHxGTFvVuCuU2wzvvH07+wOcUwJQNCcSiRFNn3jX
	WwAtfbdCuqWnIAV5gODdEt2nquSoFA2h9KLNcAAXBdnHsv9D4LZNGDIkQFUorz/MQd8OOJdXL/7
	ZyweEalflFBsgw8ycz/FlszAiLvvStldQfR0qBBb6bEO8FRlifZPzFneFy28uACJKOWz3o1P9Aw
	uW9iv4qV1O7t9pw321Vdjoxt/ZoH+1QvvSWUUfZT/OAgesdcTYpAkmTksRkJrw4I4mfkQmKDGbd
	VBmYxEf083SIK0Zz04QxZ5ChgD+a04t6FezeoPwDZBo2m7l2IhZMgLg+9HC7W/z1igAqJA3HaXT
	9UlEubbksT0qwKkl7TnF1XYvqCwMXO5olT1KsP9MSXy2z77izCUOw3IO/b0i8Q8rkKZ/zHO/zhj
	KQ62Tft7UBnyZ4zc5oYHUrEHXxWDcYogCs9CaP0gUShqlkk0gYi+firFPUu+Ogo7yt
X-Google-Smtp-Source: AGHT+IEEhzEnRHF5lq+yL/BRtzeP7AhvEd4LTzPt9a719vVEkCoMqCzaOFQDfNuqe4rQ5yUe38aR0w==
X-Received: by 2002:a17:903:3808:b0:29e:fb50:5bd2 with SMTP id d9443c01a7336-29f23d29df9mr117486945ad.58.1765857639374;
        Mon, 15 Dec 2025 20:00:39 -0800 (PST)
Received: from work-kernel.moonhee.lan (d75-156-73-135.bchsia.telus.net. [75.156.73.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2c1664sm10289995a91.17.2025.12.15.20.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 20:00:38 -0800 (PST)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] mac80211: ocb: skip rx_no_sta when interface is not joined
Date: Mon, 15 Dec 2025 19:59:32 -0800
Message-ID: <20251216035932.18332-1-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6940d2ef.a70a0220.33cd7b.012f.GAE@google.com>
References: <6940d2ef.a70a0220.33cd7b.012f.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_ocb_rx_no_sta() assumes a valid channel context, which is only
present after JOIN_OCB.

RX may run before JOIN_OCB is executed, in which case the OCB interface
is not operational. Skip RX peer handling when the interface is not
joined to avoid warnings in the RX path.

Reported-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b364457b2d1d4e4a3054
Tested-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 net/mac80211/ocb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index a5d4358f122a..ebb4f4d88c23 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -47,6 +47,9 @@ void ieee80211_ocb_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	struct sta_info *sta;
 	int band;
 
+	if (!ifocb->joined)
+		return;
+
 	/* XXX: Consider removing the least recently used entry and
 	 *      allow new one to be added.
 	 */
-- 
2.43.0


