Return-Path: <netdev+bounces-288305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANOkBc0VB2rgrQIAu9opvQ
	(envelope-from <netdev+bounces-288305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:47:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641854FE06
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF6E31481DD
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AEC385D60;
	Fri, 15 May 2026 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQH49pwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903B47ECF8
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848260; cv=none; b=TmH/MaRsS5p18ovmHNE+E6ksrJ1bw5XEFPd4qjWpa9VLBOMHG0AgIJ29G7A4EhTvi36VpGRn8IbGpYinVTJDmKOYw4nKvXT9eCa3ftvI46bjE/OCeaLbvuinHfhxueTHxYPoMuHT7GZ5VtOzAc+kBm2gZbBbeQWjumJl1JJINXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848260; c=relaxed/simple;
	bh=9SqdKDQGx21ETaJhqKRTVsLbBcKWXoFJC0PyhaYrgCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmKSGsifT8L5g385F7wabK2LL3PWhymzQEPWNQZvAaPbEKEG1CM9fdc4UJAwAqqeL6pJaBuF5gp+/ipNLjjugEZ32WIPEDh3ZymGysv4t4jZVjrCSQO7mDNxyRw7Sz8ye1AjjFplY0dVbDYVBsG2vke/XRmSqGVRuWD0d/7CSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQH49pwU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bccb978bd9so5271815ad.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 05:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778848258; x=1779453058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QkSwi0tog8aJVBoGokTiFwWgsOPVBliCydrrha64Rk=;
        b=VQH49pwUEdDm5Ra7yh2TZNVFgFuhrfYUMewAmp6KgIjTm3Wkz492cgFNC4HKtNMY9u
         6pzjIrE+KRObvDqO8L7qPlzSYswBl/mZl8drhaaNGq9fcOn2DLD95Qb0zoajJjsrrelr
         2uRzpmjClmIk6A7EtMgXd/0oVO5FRpyNRAcdNAxUs6UNNsgBVTvxg2S7THMJnLQFAPqd
         hZmUoxBvofFOHM84ADigAgmjRP9c3tmy2dWDDYh8njZBybyS7NHA83wezOmmqTO2Mv4C
         MhD+lEA1W2o+fhu/nIfgUbZhcahnpyOQcHWxDZgJCkdYJ88L31PbsJL6opgkiw/jkRZw
         KdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778848258; x=1779453058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1QkSwi0tog8aJVBoGokTiFwWgsOPVBliCydrrha64Rk=;
        b=UfeUJMoQFQKDEzkYBu5EmpfjuL1mpEvbQVO0KyQCPbTWvYTazwxoprX8op2dPx9m2U
         a6DL2xk8NWmGaaX9Ev5AB5cvvaSJkbF5HbwuKoeTCWvCJxOAbb9va0NkLUK6Dvna94b5
         q9dzUrO3JA5jITg4BjLtcAysSaCiHdNOT2hEXeMAWpNc51YYjPe6O++EnlLKvyWA+4su
         3BZb40QbLTBS5Wvl36GtvJ7A3LHIgsK/nf7j0Gchpl7vkhhgzNeqYCAvXYmBxzQbVuTt
         xpbOJp/w+UN8CJDwjdaOMugrntWBo6mdpLWViza0Bd3rHuwcliVj8pM6kY8SjMSO9Elv
         j4+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/7zsO1d7tMcdvaxEyvG5pnS2rJVZC4/4OcfHz89v2soLx4ccV03fyykmLY7nB3RFF7agiK0eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkVIb6e+ST/3Ew6C+EgtsD5Yru+0fPVVir2Zq/rlb9Vki2cXJ
	APKJ2u85wjDsFKTWuhckP0W75AjrE5HgWtg/9FNqYC0K3n/DH+ctlPZnGYoCVsfsFLXMNmPT
X-Gm-Gg: Acq92OEV+QKUbRYMOwctqSZdRQ9H/a3liUfoj7Y8UbByIr3VmevR+8rCamc+8cp6F2f
	f4prorBuzBTSPmfkFXhJWN3cbEeuxeEymQ/clLAcs7XVFV2X/+Ok3EmQGjTn3LayS25e2gL5krC
	jYkR139+zcFafQK5dLU80oFMWBm+v/Kfc6oetSynZRKurvdqJaLYcFnBoykC8/+mGFAD05l/gJ2
	NmJrSWY/NMhAwpk+9hnFm3SjVDxywsLuC+z24jXkX0najDcF07uehazn/FlzZhyiNnyCqenNtgG
	Jx1x4Tso6EkaaRgDcvQV1zb9IieQIfW+LhrZLftybaJAQSaMV9oWfwyVKCjDAIBTo5qpt9kcJtH
	mAyXfCexNFNBaFveYB/gJVdcoF1JELMK+5fiVL15gjLROMEXMivpdTyCU94Pwcu9fuqK/RXPop3
	wb+rjixh5RxQ83JN5w763cUxMQyjVX6BDJFZ1jB6blU43T4hvAHn4vvlv/LjsKqX7CYB5xkHg6M
	/q9m+8s189C6IHq+j3I21GPMfuKaCC73EfXgb9KQQ==
X-Received: by 2002:a17:903:943:b0:2ba:5e99:93e8 with SMTP id d9443c01a7336-2bd52b6d778mr74236205ad.29.1778848257915;
        Fri, 15 May 2026 05:30:57 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:a48a:1116:aa2d:1122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm60348885ad.48.2026.05.15.05.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:30:57 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 4/5] xsk: drain continuation descs on invalid descriptor in __xsk_generic_xmit()
Date: Fri, 15 May 2026 20:30:17 +0800
Message-Id: <20260515123018.80147-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260515123018.80147-1-kerneljasonxing@gmail.com>
References: <20260515123018.80147-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8641854FE06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288305-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

When the TX loop in __xsk_generic_xmit() encounters an invalid
descriptor mid-packet (e.g. an out-of-bounds address), the partial
skb is dropped and the offending descriptor is released. However,
remaining continuation descriptors belonging to the same multi-buffer
packet still sit in the TX ring. Since xs->skb becomes NULL after the
drop, the next iteration treats the leftover continuation fragment as
a brand-new packet, corrupting the packet stream.

Fix this by setting the drain_cont flag when the released descriptor
has XDP_PKT_CONTD set. On the next call to __xsk_generic_xmit(), the
drain logic introduced in the previous patch handles the remaining
fragments with normal CQ backpressure.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f98a9553e536..3b604776f09f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1045,6 +1045,8 @@ static int __xsk_generic_xmit(struct sock *sk)
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
 		xskq_cons_release(xs->tx);
+		if (xp_mb_desc(&desc))
+			xs->drain_cont = true;
 	}
 
 out:
-- 
2.41.3


