Return-Path: <netdev+bounces-296181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id egF/NUYFJWpbCwIAu9opvQ
	(envelope-from <netdev+bounces-296181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:44:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 339BA64EE3E
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:44:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b="SLJL5/Mp";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296181-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296181-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4055301428E
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 05:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9C2D47E6;
	Sun,  7 Jun 2026 05:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC22C15AC
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 05:44:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780811076; cv=none; b=qSzB1qm2AMvdoa9ina4FMyNMmRL5j1CELmjBZOIDp+zCaYvtYurhjpQVPbIcHN2PvXTmiNcb3hksW5X9IkTTJ2ldDVUAcmYe/4fkdHnQnIgbq1H+Vn2+5pgoXwNQsmvSxuSI7O54XVCeLv1hNtfIcSL6Ba26sEGNToX/Q2kZ054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780811076; c=relaxed/simple;
	bh=2UELu7gvuIr9kkHpk+aVeTnV8oUcTbCHEgcBdJFGsrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olgzyrK4Cc9j0ZsQrxXZdIv9Ix39NNqO6K7iGH12ann7MniaPXp6LNWFG5wR+B/UhuMWROWPoOPZBfRumFY5gibi9HojkkgRdbysfncmJfKRFV7VqUYdGHufd2DpL5YxhFPJIIhW5JGam9gKGOmnGku5bX+2ifYg6DG88mCbqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=SLJL5/Mp; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84275887a3fso2699139b3a.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 22:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780811074; x=1781415874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mii9tWUWAgh3jK4igiPajRvEG9cgppMUa8Il1NbU1E=;
        b=SLJL5/MpGzo8A6nYhnvwKrEQV7BGP6e7VSaN7ii5hyE+wCzWwQC9QikcsbhhrAEoAW
         IwKpHph9kOWNJM0dBxqC4LjCMe+DzyyiGI4R1iIeTfKdFSWJnam45hB5Fc2eGnQyKgpq
         V+qLkjTIesvmQKgCqAcgTM2a2Pt9rzW/71p3cSe4DAM6zeN+EF2IWUJgLBE+l59wyBJI
         RR/AoaLkCAzAlQL3cyqpl8TdTJEY8thyF5CgSYinRAtCXWJQAEpAMwY2+zgIVU4kdCaF
         yBGVRbY21YrIpJATBM1rQFHAwnI2LTfz3tNG+duiW/F7fwyoDkDpNFzOaCxxfQv+4Kp5
         4tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780811074; x=1781415874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mii9tWUWAgh3jK4igiPajRvEG9cgppMUa8Il1NbU1E=;
        b=brLImm7FLjTsrXMbuvOwaUCTgkKCzyW0QwrF4q116V/9vUxR/aFj2ho52IA3lIzyrB
         WlfGW5d73zOrg7Gyjr4OtYi3XcSdyIdMNYVCW6WJ9JdurLomiNreekQ44IE25CtQ2BQ3
         9Na7T1pSyRyCXgKnfxGirzlHv8anPBnOIu9qyZlyEQFOM2asRNs8MWoo7xaPFsj+z7jK
         46lrRI8K57i4IRFEEY9jXSnx+2DwnHPfivo3u8bT2EqKbvDxJ/ZWRGpulndlYGKuB4xJ
         iT2oGU4AtIgz/GAUBp9L4O4CvX0W4XFRuXDykwiv5UNCwnm0e85eW81fx1mGGSyyypoE
         8f+w==
X-Gm-Message-State: AOJu0YzqV0145wZfiqcjQD1k5tdQUX39qcEsjhc4TIFB4RPLwUthITjM
	CRictSh3LEX3HelMYbLuPGokqcZsTv8WtmTz9SIBeQUoDQ/LyvbfmLLNT5tnQC49FcYU/06F+J0
	wmjpGxg==
X-Gm-Gg: Acq92OGwAlXarRDqoutc+VLd/+kA4umCIvvGpgyIV2TLf//SfvRprdgHswc4G/x2s8g
	iYZkGDTICawWQhZCOAcDz+/H6P4vfL1YoU6z0C2OSDakINBMFslmsfqXXkmP4CHjncSAxIJM1ch
	OuuYoA1Cvelbf69LdQTorf0xaBTIqFcqjfF9cRnl5tAZA9iHukUE3OmtapRCx/Zuy6INzenpHGP
	NVskhJt5cGKBLYRtgxqdPuqyUefw9l4TPeMIuTbWW0YVnc41u5KY7xKaySG4WlVvRnjdQT3K6Zm
	DfgVpeVn07WnkyzrTv4qYrPmZ+RSiemMW1d//IZFT0azcaLUl1/nfpSRtIfTvLw3aJF25HiI37c
	cC5+TbibftlNU2wp86KENCoc0Q6VfCEiuBiJtePBOgM5Bp506QLZFZJKKt2F6rc0kaiO4VE8Dhs
	aRX0ndII9Irvzas7Q=
X-Received: by 2002:a05:6a00:a83:b0:842:4a8e:2698 with SMTP id d2e1a72fcca58-842b66955c9mr7306586b3a.9.1780811074352;
        Sat, 06 Jun 2026 22:44:34 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282379db0sm13277684b3a.24.2026.06.06.22.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 22:44:34 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] tun: zero the whole vnet header in tun_put_user()
Date: Sat,  6 Jun 2026 22:44:28 -0700
Message-ID: <20260607054428.3050243-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,google.com,kernel.org,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296181-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:mid,asu.edu:dkim,asu.edu:from_mime,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 339BA64EE3E

tun_put_user() declares an on-stack struct virtio_net_hdr_v1_hash_tunnel
without zeroing it. For a non-tunnel skb, virtio_net_hdr_tnl_from_skb()
only initializes the first 10 bytes (sizeof(struct virtio_net_hdr)),
leaving bytes 10..23 (num_buffers and the hash/tunnel fields) as stack
garbage.

An unprivileged user can set the vnet header size to 24 with
TUNSETVNETHDRSZ, so __tun_vnet_hdr_put() copies all 24 bytes of the
partially-initialized struct to userspace, leaking 14 bytes of kernel
stack on every read of a non-tunnel packet.

Fix it the same way tun_get_user() already does by zeroing the whole
header right after declaration.

Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9e7744eb57a3..fed9dfdfcc3b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2070,6 +2070,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 		struct virtio_net_hdr_v1_hash_tunnel hdr;
 		struct virtio_net_hdr *gso;
 
+		memset(&hdr, 0, sizeof(hdr));
 		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
 						&hdr);
 		if (ret)
-- 
2.43.0


