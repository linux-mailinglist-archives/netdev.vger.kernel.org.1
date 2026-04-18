Return-Path: <netdev+bounces-279468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPcML1AP42kuBwEAu9opvQ
	(envelope-from <netdev+bounces-279468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD7441FFBC
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 269CD300B5BD
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321F33970F;
	Sat, 18 Apr 2026 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf7Pxihm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF91C84BC
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488252; cv=none; b=ulwqfdeRzLQ4EdrU/XDF+dYfIVMdve56LAcCCAnBfkMmOrPAMuAO4MnQ89sNLH27a+3KcjdZcYRYIMguXFWjYo1SMQyRGpcTucRdbJdlZOOBct87q6tvyLgxiIrVpwDSFhXXcUxvAwKD8pUJka4UW+G1953OGoG7SsvUCIC58AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488252; c=relaxed/simple;
	bh=3DIIIIQ8qtWzRzN1t+hW53HRIAOPy5kzr//rkIeFXPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hASdB15dNPLzKsFm+4JhdUGJQZSQ8GS0xdZC8NKhOCnTJlMLLKVcSYxNB/H4U2NJwLyc3V5Jq3yynCAAw6eHmawbpfcEK0DOS+eebrppwQ+lGmNz0Ht8raCsvqfxy13PqNQ6/oyjWfd6sKecmHPh5FrG5zQGNFcINFAOoG4kBHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf7Pxihm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so906199a91.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488251; x=1777093051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPVULVHS7ZbCg3hexureS08Z0+NT0ceqMqy/MCX2QIg=;
        b=Qf7Pxihm3gWvvXowugsFy3j3ndO59ZAtG98rG/eDoZrYiJJ5aySxLyio/hRjLb+D6M
         05m07HJbSPJz/cxavpdWOddbNIUQyVvvyv7B6gy51M5E0A0itefXSkx2JI0bd/90lW2P
         vZr3eQkKmUqgGnVhR4QKReli/R4PFvh1U0DZLjrZrF96NiE2iw44Rn/rP0j1jcWt01Lb
         LjF8QAxfPOJ0K0cyiBugBwpdNoxO17gAew+FKbROrpbkesp+dayDPwcQjS91NfYAHFTr
         bjYNbtqqEWSMIMyShKgjtFGI/J5HxGVRkF/n/cxLrzPfPZWSqTfchV0p1EjX1E/goGIb
         J92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488251; x=1777093051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPVULVHS7ZbCg3hexureS08Z0+NT0ceqMqy/MCX2QIg=;
        b=E92glz/He4dIBqI5cPZxR3qv5eORxC3XwQpQJs6LASA8Ut/xo08UGY9G3vP7AHBPXK
         WfTlEB38NHnqejy0guZvRHJ1Km48KN0VEXpe7K+FW6/JSKwp2arrMciBSNVStzz+1Xw1
         Uo55BJ1451Ctuq7nrgFBFdxgw4YhSHazKe13ahzAm5xI5QgtZEDqJ4ydbsgjTEvzPNnP
         Ro2NTtbUxxtPsrxZQfw9E0E7DNsOZHOHWqPR4hPIpqwq27cLIuM/MwUcFLvHMgdk4JmT
         /e4ZzHnYqOFXTGBH+OYv3tb44B/WhH7U7IdjLS/5r4EJTCpkJmtzajf57dR8WFbOyVu3
         5g+A==
X-Forwarded-Encrypted: i=1; AFNElJ+cHI/L/JJS5qWY0IDFhp3B4b+L9tN/KFQWjTS8BLTDn6+eTHShs6wBNX22OQHnZtzF3gNvJp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8RUcatwEFfs0mt4wunXbHmWyA1sz7wvuHSqARJ+kwnFOH3bfx
	EasBFRcPDe1ge0xh2g0Me/8Zz3UmmCkuRimsX+t9Dxa5yfW7GNGUUwKT
X-Gm-Gg: AeBDieuk0sDfUCR3/2+Ahl28jy/GvAP1YifXTuNjmF5EewuWFTjB61o9kGImdIPGCFo
	zY3N87D9dWuk7SwjvyilsUOB1owTiJ7CW8+YEBrzeelndIUYWsvXfzy5gpoHt66hvCeovmi3sPp
	5JQOelLn0xhGypY1ukNDb5QfeghDk5Df+/TcdDtqICnE8EUCNHbvh2phXQpy7e+4Y1wYkjdcH1s
	k4U82+Q6+sznBBwh/KB7lRy5Q+t6PKPx6SoyEVyYE1kUWBAU10Ou4SyGEFlQtB7mU5fLcr7D3TR
	wU1L0F5CASFAGsgdW1TWoXbjHq4wpAw378llBNiJThQoYK7ErKbYsnBbjEajaOJoqoHRVGdwNjv
	Crm13OlzfOFKOOqr9zM3Cr6ViXwAVGHwsbikokRUIZyUzt9svTfOEZs0AGF2lnF9/cK7ojKYszP
	ofQBGbvja+AiIAP7jH2a+7Uwc7kLTPAUHz+CX0oZ98ytxH3hv6hClNh6Ng8HAKIXCLXgwPlbBAd
	WcDyrIcRA==
X-Received: by 2002:a17:90b:52cf:b0:35f:ba3f:e04e with SMTP id 98e67ed59e1d1-361403f1165mr5993151a91.11.1776488250835;
        Fri, 17 Apr 2026 21:57:30 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:30 -0700 (PDT)
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
Subject: [PATCH net 4/4] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Sat, 18 Apr 2026 12:56:44 +0800
Message-Id: <20260418045644.28612-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260418045644.28612-1-kerneljasonxing@gmail.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279468-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.970];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 9CD7441FFBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() processes multi-buffer packets in copy mode, the
first descriptor stores data into the skb linear area without adding
any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
to accumulate subsequent descriptors.

If a continuation descriptor fails (e.g. alloc_page returns NULL with
-EAGAIN), we jump to free_err where the condition:

  if (skb && !skb_shinfo(skb)->nr_frags)
      kfree_skb(skb);

evaluates to true because nr_frags is still 0 (the first descriptor
used the linear area, not frags). This frees the skb while xs->skb
still points to it, creating a dangling pointer. On the next transmit
attempt or socket close, xs->skb is dereferenced, causing a
use-after-free or double-free.

Fix by adding a !xs->skb check to the condition, ensuring we only free
skbs that were freshly allocated in this call (xs->skb is NULL) and
never free an in-progress multi-buffer skb that the caller still
references.

Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 2918b773aa84..22c7a92e0734 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -894,7 +894,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3


