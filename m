Return-Path: <netdev+bounces-267779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL97E8CUtWnL2AAAu9opvQ
	(envelope-from <netdev+bounces-267779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:02:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E2D28E0A0
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C4F303FDC0
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD6D326938;
	Sat, 14 Mar 2026 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTknxAkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683C30C637
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773507735; cv=none; b=buKfYergm1NybYdfetaNXqJ7P23ZLbsazgY1WlyFnVPkE8fhm05RqZ5Bt5fSHF1M88GRcKW2OAIamuiXqAKtq5VU2ARp5qy1r3Sv8x/ucowhizR60evcMO6EP4RIu+d601UkB/bi3ujwCMUZUyF23D8C0YdCBQlaWmtCJDRjP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773507735; c=relaxed/simple;
	bh=vcYZcmK1SNHK+w4vEgXAc8yOAqQ1NV6C2SFZZA0rxXU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YBPBWDsLvrCKGb5BKUYGWjJFsgQBirRaLUtiF3zih8Tfhr7TfjuIOndP6ZkeEVJxjJiEDY9WH/qvCoDz/fCiAnr+VHF2ycI3cvmW+bIa6vAt28YQvkzSmht6/FlwLAgMFSiduUbebj1RFaJ0OfwEGUQJ6nTlXLsVVblM5MkFYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTknxAkJ; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb6291d95aso3342642585a.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773507733; x=1774112533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w0pRUeXmka/EZR/LZMHy1e5MuVSB3zTKKcAMNnhgtqw=;
        b=MTknxAkJlS3jYUvm/Yy57ti69CFyCv7Z6IOJHtuivCZjtaWQUtpLhRdtr3dnGiMHp5
         GL+Btjqu37dLZk0Q64Cs2mSrhEr4yJrEpbj/G+EYOwseqeNVTAmzQ3Ogrgg002Ty6Ih3
         yYbXQeGcHpeDh5Ee6nj+o4AUnjDiWPyijekW5Lyv7H/AgjH9gOaMH+fJHlkKFxdZQsjx
         nMYp7OKJqF1b8W5uZq5yAb0XeSK7Hp6NR8iM71PvxFhudhvDYs0xsemWOE0x5Uo6xaqT
         Rn1Qxmf7Zz6kVmHG1HRFWAXttrtZjvnm4qrFlygr1+K8bwm2Hzv3Zc8LajLW200sao/m
         xQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773507733; x=1774112533;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0pRUeXmka/EZR/LZMHy1e5MuVSB3zTKKcAMNnhgtqw=;
        b=kuJmEUYwLQSmkEmVwZoz1Os++F1RuOfmIKn+36JVNcvjQl/TD7i5GU4b1EG8tMYwZ2
         EH1Sc67KV0hE1re6kz+weONczK4KzwZ5h49C9Cqgg6xRT7VaySu2wfDcnCtv59hUa+qH
         zMBYky73IWGvkuyUjJLEU9ceGD6WkN1X43b7PeogYpyscCfbRwy+qeST1yHxRA56Sc1O
         Knfn6qvTAnSE7+S2h6cU9EpsurlDfBUiQNF+odaZHQvk5ec9GRx+aHEmPbZ2wONG2gNB
         tFdzJpGBCAuWhBf0pXlAj8B1i9GD5VzKia6jBF/HAfbCD2gWbrrRVaj6QxCI1G4BmfCz
         akFg==
X-Forwarded-Encrypted: i=1; AJvYcCVNxHAK7cKke6zV2HIeh9+2eJ93oHBSbhJIxc6vWM6T4j/+Ao4Tulq/k8OGKUhljRJGc0O7zvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Z2/j3bNwjcmUYNtQErXZ43XNO2UBXEFxRG9J0XKsnRwN3/6j
	MCkXdrm2Qh9r5aGP1lrcQp/Th9t0T/gwFwQQhR8N0OyplQxO7fbLvC0jH7r6+HZZR5LrPrR5eqS
	gUBzC8RDSimS7lw==
X-Received: from qvb17.prod.google.com ([2002:a05:6214:6011:b0:89a:ce:d6be])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4443:b0:8cd:8fc7:831f with SMTP id af79cd13be357-8cdb5ba779bmr871927285a.56.1773507732891;
 Sat, 14 Mar 2026 10:02:12 -0700 (PDT)
Date: Sat, 14 Mar 2026 17:02:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260314170210.4039941-1-edumazet@google.com>
Subject: [PATCH net] af_key: validate families in pfkey_send_migrate()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+b518dfc8e021988fbd55@syzkaller.appspotmail.com, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com,secunet.com,gondor.apana.org.au];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267779-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,b518dfc8e021988fbd55];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B2E2D28E0A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot was able to trigger a crash in skb_put() [1]

Issue is that pfkey_send_migrate() does not check old/new families,
and that set_ipsecrequest() @family argument was truncated,
thus possibly overfilling the skb.

Validate families early, do not wait set_ipsecrequest().

[1]

skbuff: skb_over_panic: text:ffffffff8a752120 len:392 put:16 head:ffff88802a4ad040 data:ffff88802a4ad040 tail:0x188 end:0x180 dev:<NULL>
 kernel BUG at net/core/skbuff.c:214 !
Call Trace:
 <TASK>
  skb_over_panic net/core/skbuff.c:219 [inline]
  skb_put+0x159/0x210 net/core/skbuff.c:2655
  skb_put_zero include/linux/skbuff.h:2788 [inline]
  set_ipsecrequest net/key/af_key.c:3532 [inline]
  pfkey_send_migrate+0x1270/0x2e50 net/key/af_key.c:3636
  km_migrate+0x155/0x260 net/xfrm/xfrm_state.c:2848
  xfrm_migrate+0x2140/0x2450 net/xfrm/xfrm_policy.c:4705
  xfrm_do_migrate+0x8ff/0xaa0 net/xfrm/xfrm_user.c:3150

Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
Reported-by: syzbot+b518dfc8e021988fbd55@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69b5933c.050a0220.248e02.00f2.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 net/key/af_key.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 0756bac62f7c042851636badf0a5e961c4e673c1..72ac2ace419de4ae2e4b70c647d8cb2c0781a149 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff *skb, const struct xfrm_kmaddress *
 
 static int set_ipsecrequest(struct sk_buff *skb,
 			    uint8_t proto, uint8_t mode, int level,
-			    uint32_t reqid, uint8_t family,
+			    uint32_t reqid, sa_family_t family,
 			    const xfrm_address_t *src, const xfrm_address_t *dst)
 {
 	struct sadb_x_ipsecrequest *rq;
@@ -3583,12 +3583,17 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 
 	/* ipsecrequests */
 	for (i = 0, mp = m; i < num_bundles; i++, mp++) {
-		/* old locator pair */
-		size_pol += sizeof(struct sadb_x_ipsecrequest) +
-			    pfkey_sockaddr_pair_size(mp->old_family);
-		/* new locator pair */
-		size_pol += sizeof(struct sadb_x_ipsecrequest) +
-			    pfkey_sockaddr_pair_size(mp->new_family);
+		int pair_size;
+
+		pair_size = pfkey_sockaddr_pair_size(mp->old_family);
+		if (!pair_size)
+			return -EINVAL;
+		size_pol += sizeof(struct sadb_x_ipsecrequest) + pair_size;
+
+		pair_size = pfkey_sockaddr_pair_size(mp->new_family);
+		if (!pair_size)
+			return -EINVAL;
+		size_pol += sizeof(struct sadb_x_ipsecrequest) + pair_size;
 	}
 
 	size += sizeof(struct sadb_msg) + size_pol;
-- 
2.53.0.851.ga537e3e6e9-goog


