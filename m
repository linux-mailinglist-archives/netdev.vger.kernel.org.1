Return-Path: <netdev+bounces-270836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF6KLv/rwWkgYAQAu9opvQ
	(envelope-from <netdev+bounces-270836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:42:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98B300A67
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64363026A9E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F00372EEA;
	Tue, 24 Mar 2026 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCIZXT/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B5129BDAB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316307; cv=none; b=qTTTjr+zdpo0EBBh07v8H5o2Kbo0GOSS8dha6cPmcsWtX7dEodJi6muz9ZrH38qmtwNCG/Rx4uQFLU+4QtMNyHaAUsRwBJn8asRwWufJ8r0CLL8Wt64FKNsm+brAxzriKnUrYVbTYRT7ojtsrmAb8q13Q0vbhP6uhnAhiiUSC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316307; c=relaxed/simple;
	bh=wmlnVGh79dj21yiyeZHZ4DBJkXFrqKrjGjcWsje7c5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC7CqxZH+PeWptvCMwzVj0xqM6B3zenOcnh/rTfgldkQR9Q+s8901k0gBDSSbfvgu00SOo+DUuKOwWa1t80HvE7aZvwkXSzosm4kG5t/FFU69tunoMfOWykM2aNSnAIdj/3/SRokh+HNeqE0cM2rXskD/Abfyabxi8IAyxMjaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCIZXT/R; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8296dabef74so4086490b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316305; x=1774921105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmsfLC1kFsbxmPW2aQul9mBcQdNDbnf2m49KLC9+wKA=;
        b=LCIZXT/ROIrHyfkTYRwOaYfUeDvPjRlRWEdUC9thVJQSMiGvpwvDlQybujNa07CSMs
         FwOl3xoJApVZ/ObkgiEcqsr/HbOcb+nTi60Xu6CnFH+htYwQbPM5cwkvPF4HVijYfoWA
         r0Dt04HnJK05sqquVOIr8WHoCBNcJSS92h+98/MjkquEBSqaF5k76bMQSx/T+nbwyM91
         elpVQ7GE8SxY7x4m3DL6rUKtWn/1KCsAjaNHYLBY/4HuWofvPrs6pzZHqp80QEn5DJ4D
         lZEMtPyGBLjFPIrVokvI95OQ7aZUxvYMApWID1r0h6Mlw3hxKFB8Qc9hKVXfVfRfitla
         uMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316305; x=1774921105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GmsfLC1kFsbxmPW2aQul9mBcQdNDbnf2m49KLC9+wKA=;
        b=DMZmELoxwNElWHjgBLV1Wnz6mmRnzo8u9QsRa399XVTj2+xdtM8bPzguXX0zC8mUxL
         dSILOhit5KIOsPxLmn79sqsS/xZ7PpC9CJjtsznQHd7zYo/W1z+CUVxZU3u1ExVaSYZ5
         bIBYqJw8/Nfpw4F/qEf0391R4bhN6wHkK23mNvcTfmvXgVa1xeIpoiuPSMV7lCcfyJNS
         x3+IJcXF6NP3ZJE6D/vOvlio/FkGqeKPFRSvstOAMgTH+LtscsWI003LkTM3Us6Fs/Vg
         Nupzg+P8RlXp5+thjk9WTq0r9/awyBUdrOscrYmvWTZkq1DrQ2MES4chb90AM1qVh/S+
         Udtg==
X-Gm-Message-State: AOJu0YwFUgfH4DTCBgCIAY0tHVaKJ7nmy59J6wqREizXijTWkcCr70hL
	Txphr8pKZwBrcufDRMQfPO1nYMLAksklUb4XwA4Ddr5dSTINJ8ShZBPcHceOw85rJg4=
X-Gm-Gg: ATEYQzzl8bvHwyr++6iW9TXkKr1GZlwbZrgaTt5SOnOaWWvGlWCImegWVVpx43DUHZI
	G/OBOld3Ran18n4SqApvzX2njX5LFsPMsMFt20CdMuCVfYL5Wzml6AmIc4uTiaSM1FMHrWswDw5
	d/y/BsesNu853IX0R5PwAyMoSfAXFQcodG33jtGo5aeokszPiEzPhG/XqIW9xHZDpImCQeKWbvR
	V1huQxWA7AY5SGwW8tC5mRxt4JYRMwJwT32k0bRpG4KtvnEmC1meyTpEiTTBuPBQXC86XpBAx/f
	yDdlOod5zK6hF04UOiCUKkUfZ3PbTc0Tt56viYoy+IpcMNnIvl6hZASgYKpen7WvQSkCGPsisF5
	wKUGNw5lzRmPzdcO/2hOUNlltuAwVWMf/loqJvicfplwd5rSaz1wM6V+1ezhfzouJeCu1yHyfrF
	YUIAa0D6cIF/5tY3buZc0CTbezbykSmkemstv3zcLgd6rSul+N9yUWLVQGQQ==
X-Received: by 2002:a05:6a00:4148:b0:829:8942:2c85 with SMTP id d2e1a72fcca58-82a8c22d29cmr11162422b3a.17.1774316304785;
        Mon, 23 Mar 2026 18:38:24 -0700 (PDT)
Received: from nixos (om126208151001.22.openmobile.ne.jp. [126.208.151.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410a3c9sm12788696b3a.56.2026.03.23.18.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 18:38:24 -0700 (PDT)
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Subject: [PATCH v2] xfrm: clear trailing padding in build_polexpire()
Date: Tue, 24 Mar 2026 10:37:42 +0900
Message-ID: <20260324013742.939533-1-yasuakitorimaru@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260321210421.2504711-1-yasuakitorimaru@gmail.com>
References: <20260321210421.2504711-1-yasuakitorimaru@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-270836-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B98B300A67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

build_expire() clears the trailing padding bytes of struct
xfrm_user_expire after setting the hard field via memset_after(),
but the analogous function build_polexpire() does not do this for
struct xfrm_user_polexpire.

The padding bytes after the __u8 hard field are left
uninitialized from the heap allocation, and are then sent to
userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
leaking kernel heap memory contents.

Add the missing memset_after() call, matching build_expire().

Fixes: e3e5fc1698ae ("xfrm_user: fix info leak in build_expire()")
Cc: stable@vger.kernel.org
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
---
Verified with pahole (struct xfrm_user_polexpire):
- x86_64:       sizeof=176, padding=7
- i386:         sizeof=168, padding=3
- aarch64:      sizeof=176, padding=7
- armv7l (hf):  sizeof=176, padding=7
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..ee31ef482be4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3948,6 +3948,8 @@ static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
 		return err;
 	}
 	upe->hard = !!hard;
+	/* clear the padding bytes */
+	memset_after(upe, 0, hard);
 
 	nlmsg_end(skb, nlh);
 	return 0;
-- 
2.50.1


