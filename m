Return-Path: <netdev+bounces-290857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLsFBq9sEGqgXAYAu9opvQ
	(envelope-from <netdev+bounces-290857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:48:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415F5B671D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 947D0311A768
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C646AF39;
	Fri, 22 May 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNdA2MDi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66F46AEEA
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459929; cv=none; b=Guc9iA6OlOMSfu9/AvA/wOLfj5QX2Gh08DhvtDx9nr+ZuB3MySyzXmo7zZUfLFjlA99gwGG6w07b7xbhv6h5WMti31KUiOS1ibjbC9N3zw+dwqmcJ2LxNm1YUIGH/t2vs1YnenwIKyunjkFA3YGZVrzKaq6nL1EzUsg1imRUEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459929; c=relaxed/simple;
	bh=cWSh40/GBkttyPJ/iR24UYVatT/zc5uUkj3jx626xU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIxA5OD+zNJ5VkRAlWNnwEriX3bNpQM3suKasNo2mdHfs6QU+/QDqTm0/SbkFDHJwAf9U8bV68f1wS/xqdH/WMFoHG9rotV58hUZvvx5zIuBpDQst7TRnDpvNP/2TgKXPByMadRz6OF+EbR9FvHVhlam097hn2ZzhkXJHkTO7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNdA2MDi; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-57754ec3462so4978470e0c.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779459927; x=1780064727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PhUPrY9J+tGC6063Eguxk+7GNvzjRZ0H6G2mBc3a4ck=;
        b=XNdA2MDirl4r0ZpG/N6JL08puEgHUY4HPJd2lkruU/L36d1oZVAyp1j8M6/RU0RkpV
         SBcz3NNwEuh88MZg6P4pCIRySWRDdQwkbFct0Hl4GpsA+aA+RWNQuhken8dn85a7+bZw
         apMfV+qnRDoM0Cfh4ocdTyej/iD35iguqSX0UtdcYiAjlu0+zvHPuUU1YpS/inu6TnDc
         rXpzDK59J2PFeom7Z4b4IXUfkyShhbs2jQMAarQUAQLGk1H6qEpgD89CLHSXiyOJsIkJ
         Tx7PYQxi+isap0rTIt/Dq6hmjC+P54O1mfzKN7wl5oWN4C83Rzfhkk0fj9cSV3jwxCiI
         GhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459927; x=1780064727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhUPrY9J+tGC6063Eguxk+7GNvzjRZ0H6G2mBc3a4ck=;
        b=JyhDAGnR08OefqUnevFkjMUjRviTHSZwpHxMSJ9VMuS12nrITtW9q67jim3fo/wOVD
         RlMLfhhpqvpQ6ICBvNtqfkQm3Ox8aEp0h+BIcZqNHD+OcWCpHIft4bSLrdRxLdetkNqA
         AmijEXWISGKHR1ekmIwShsTBXZ9V2FH+LuvgFSVs0rAZFbAuoDhjVqg/VBH7axHAveX7
         C6kUER6Qv6+k7Wb1w0dU7ZY5vRpYzGMvSRfb1rnw2Gixtmz97rrJCL1g1TNmLMXJDAjC
         4n/K4/mo/bfv+SMXLFGb4lH7eXetECwaiLBZ0njMvu4eMHAhciRyLsBDH8nqIks9gYr2
         MWlw==
X-Gm-Message-State: AOJu0Yy50O8XpgLd4WCetxuBfxtbKL3+5XUJdupQawIXjmrevhBdkbwH
	TiRO/WcOvOrt4m/Y45rUkB+4gfojndpG2zBTZGZ5N5o1iUIMWGPgcIzUPxNY1jb6EvFiu3mn
X-Gm-Gg: Acq92OEbovN0MFFJqeFL23K0JyLWPcWCiaRHX7uW8pb662fPTohPhTiJbelcs5J4zRo
	nj8hxjAvNUJALjY8+/jFoHSzbhCdmHRT8kERvcHQXBh9WfnbWTZTvI1gLEHSjAqwwlCUGSce5TQ
	7iIppy4XzrBHYJNOyBq4JQwMRhfj+Afttr7qn9EYePU7Z7kKjdWJlbVE9H36MAk6GYKvg5n41H9
	W7ArGdTZ46EpAbnqEmpT0bBxl03HmCdlYpO8u5mVBw6VUhQmKM/JOoB6FRBehm0bKO97Aotsg84
	uVv2bkUGExQaLl5kRtjVAuVvvBU6D8jgxQ1pprEtsY2ZGHs+JMJ8fVeA4WPNBLQkPek3ujFFnWe
	GJj2Yw8BEbxp/PEl46Q437mOIoLJZqRTfuRIkLpMo16KDLO9sZylguKPo/tBhBIiT3bHtxzo0WH
	WNrwswW16cDtAT6rnR1vOZkwob0v3XjqUe5RdO3X2WAKt+bkG31SKrJogsGxql0VbLBlf1HNkbq
	ut5Z3aW4PCM/BPU25OeT6bwQbsRL7FBQpF6luikBpJJROD6rFcyhxrTpBmY4rGO
X-Received: by 2002:a05:6122:ca3:b0:575:33d4:d101 with SMTP id 71dfb90a1353d-5865e69bf5bmr2257085e0c.2.1779459927094;
        Fri, 22 May 2026 07:25:27 -0700 (PDT)
Received: from sekiura-Standard-PC-i440FX-PIIX-1996.. ([186.122.244.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f8f6cd40sm2403881e0c.16.2026.05.22.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 07:25:26 -0700 (PDT)
From: Takao Sato <takaosato1997@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	w@1wt.eu,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	chopps@chopps.org,
	stable@vger.kernel.org,
	Takao Sato <takaosato1997@gmail.com>
Subject: [PATCH net v3] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
Date: Fri, 22 May 2026 11:25:04 -0300
Message-ID: <20260522142504.1394864-1-takaosato1997@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	FREEMAIL_CC(0.00)[secunet.com,1wt.eu,davemloft.net,gondor.apana.org.au,chopps.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-290857-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takaosato1997@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6415F5B671D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_consume_frags() transfers paged fragments from one socket buffer
to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
the same class of bug that was fixed in skb_try_coalesce() for
CVE-2026-46300: when fragments backed by read-only page-cache pages are
merged, the marker indicating their shared nature must be preserved so
that ESP can decide correctly whether in-place encryption is safe.

Apply the same two-line fix used in skb_try_coalesce() to
iptfs_consume_frags().

Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Takao Sato <takaosato1997@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e5..4db85e158 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
	       sizeof(fromi->frags[0]) * fromi->nr_frags);
	toi->nr_frags += fromi->nr_frags;
+	if (fromi->nr_frags)
+		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
	fromi->nr_frags = 0;
	from->data_len = 0;
	from->len = 0;
-- 
2.43.0

