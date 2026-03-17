Return-Path: <netdev+bounces-268540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAdtOzAxuWn4uAEAu9opvQ
	(envelope-from <netdev+bounces-268540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:47:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7196F2A833C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B08B3015E3D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1503A6EE5;
	Tue, 17 Mar 2026 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OJ3qrIXv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF532FA2A
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744034; cv=none; b=LjlPfPt8H+t5xRY7wST5g50ZDLb14LYmQAk+rTlnaITEM6GR7ZSq0NId4kcLgwsoVBB4Ki9wCou9inlzRVJvNXnnJF610BvKHY5GXZLVa/DDYiPkXk9lt5yGCIvpUxUiV2f+hOHlQ4qufC2+NhKPk0phhghxJwo+8Pn94Bjq7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744034; c=relaxed/simple;
	bh=aTGdGKIbN78z0HccJeLIaLaLIQQWPHWa0zQSLVb6wio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2uE5TbaipgPwphMrOttBewTlHWyDkK4FpZwFmRA/fU2wJjscACU/KQa9Q3AHUsfuw5pXH9RdIggRrrKWoEga1VAs86yUYbLoMnRwO7YAyikDol4qLnsJXEXskexWXme7X/taClLs0iB40QJl/HHvYcaewcKSf+aKoUqHCiZm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OJ3qrIXv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b9b1900bso3661816f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773744031; x=1774348831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=OJ3qrIXvkpRzOJIXsVUxJtJzTLHNI/d0Y5NpuVdaa38WOgkBdANgje9//Lfb1/ZGCo
         Ul9hlt43u43/24UBofkyIagZby+tL0yqwKomFM6LNdRlocyaW/HWCnVf7iB0acp0V1nB
         v9+nmoSRD//dTy2Cjr4o6m6DQRQ1X3tag0fOZkV0tZB1IPQ478/IrqgzvumPSQTMI7Sl
         rPyP14UPDOh8KEMX/BSzJ21Q7eM0gaC5Se+0iRflwUDUvJ6fNxxqslJJ3PBNbreC6wGW
         VQdgbDZuF3N/fijX9gO7yWNUWZ8YXl3RO363eW0IjcNUKSHydo64J+AlnwtLMfkdERFt
         KSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744031; x=1774348831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=Vk2c0C+6BuZpvzTRw/2To162XmJURbE7YFQClGXzVJ4XjKxyWvD25v77Ob+5Xw1tNJ
         RQaZ8iDmDmWle0ObYg1tGpZN0Yz4lChQsFPkPDWD7wHgzDL5/stSmD8H9xWBt5ftlXqj
         CuTpH+1ZW17Uqbq2zGCSUqFp5gZxdtMPaMYQRde2+0rnf3rPAbaLCbHskZcm8H+dQTZn
         Svl0QvhQVk+qreiqqcp4063UKWC10dB2LAPjRElttCorofOUbc2Lv52xcLZY8skoyCNG
         czSn/YbjUAGUkdvvXxFCKYrD2eZ95+Tvkhnheur44kEcx23rbjP+VFWpggaukvJ4TXYZ
         b0Eg==
X-Gm-Message-State: AOJu0YyYheJSB9SWEjNUyh93IpPJySAQgFHefGyu0+cpkFzAJO/a/tQD
	l2UOFNq6TbCCQLJdxdbLxg54fq0kfcRenVLOUiYSF0FscDLKgS4FRePqnvkCCAg0uugllmjU1t2
	gfd5FhtOkuZtVyE4hXwYEP40zhNcsLlQToNjd00vd4CvPWHUuCcfjsoFGuxJvV6gQ
X-Gm-Gg: ATEYQzx52i2a80VJ49XVzD2IQHX9IglWlctzA3YupkBuLREPvJ5zhppnhYMCLchJVKX
	PXS8Zkif4ZSLtSyszfOSy1nXVtOC9Y61IUPvOmW2YvvwlqW7NbZ9QtpzU8xVYx2NvaOg113cuxq
	GLi88ye7G9uozX3OCFNrHnf8owA9YPs0x2zpTqH9+JM3FxyMBA289jcd+9TrG/WYPgg+BIHtVHy
	WbA3vxES9wqJRZHq5DtHd5Jl5uCQ5VFY5Tt3skgAxTkuXbs2AMZsfGGOE1gnEb+l1wIV3pYKZWb
	v2JuId2iJFezvRIBccwpKvSfnRL/KjcIoF/3eHp5YxV/mexXgx0DEM+bk1Bz6OD1FrB9jEoCyJd
	PFK4+L9JaiSq6UJTAseXjxwUtyCXFKuuqeiUmdvYQEiKyBBVNc/37i/ex6r1Q7u/E+nR4w7u90P
	HlCU+bXuddzmgqVqt1L8cmorEirHA1SPBRVxzVEtfiMIj1Yw==
X-Received: by 2002:a5d:5d86:0:b0:439:b3a3:7239 with SMTP id ffacd0b85a97d-43a04d78189mr28892497f8f.5.1773744030461;
        Tue, 17 Mar 2026 03:40:30 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:4f22:3f9:13dd:cf23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm49948215f8f.31.2026.03.17.03.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:40:30 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/9] ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit
Date: Tue, 17 Mar 2026 11:40:16 +0100
Message-ID: <20260317104023.192548-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317104023.192548-1-antonio@openvpn.net>
References: <20260317104023.192548-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268540-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid]
X-Rspamd-Queue-Id: 7196F2A833C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sabrina Dubroca <sd@queasysnail.net>

In ovpn_nl_key_swap_doit, the attributes array used to parse the
OVPN_A_KEYCONF uses OVPN_A_PEER_MAX instead of
OVPN_A_KEYCONF_MAX. Note that this does not cause any bug, since
currently OVPN_A_KEYCONF_MAX < OVPN_A_PEER_MAX.

The wrong constant was introduced by commit 203e2bf55990
("ovpn: implement key add/get/del/swap via netlink")

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c7f382437630..fed0e46b32a3 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1061,8 +1061,8 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_peer *peer;
 	u32 peer_id;
 	int ret;
-- 
2.52.0


