Return-Path: <netdev+bounces-278000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJMiJSqw3GldVQkAu9opvQ
	(envelope-from <netdev+bounces-278000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:58:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 296583E96D7
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CCC6303C42D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C663AB29F;
	Mon, 13 Apr 2026 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQbpvoog"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE0237C93A
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070437; cv=none; b=SVc0RPY1sbBzrJN8ASVYBkf9RQiUx4/WTuGJpzXKA42EceYN73dEaFDnotnDZg5l3QoEsRCTGgfYrkNM01lUEN0mCOH9cwJsMeu8QFDKWwZT6dhD8na2lj6KXp8t1AiKoNJ2vorm7Fy0/B7A32YIy6l3PTxS+eS0Y2G92ZLlhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070437; c=relaxed/simple;
	bh=C//yhEIRoJiFdsx1+W17+34vH8sRBccRPBTlG/dfsJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZupqGgQM1BGtbY2lKkaZjk/ONKJ1p/CKBDbxAsOKjUUAjGbs0rTrwkn4cm/Ka1jeHsHNXqYtns0yP+ZvMaP2K3dHLpAwioiQuDkDA1tKemZ7DRC8sPgQf544hUTX47OFguxBywr/L3lEh+6P1EufoIES1vGyrp9sr/nfsqETp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQbpvoog; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adbfab4501so16932625ad.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070435; x=1776675235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Or/djqSd9t+k327sTGOHBISljhD0r/2+k7/piAbLga4=;
        b=LQbpvoogJ8CpGC4R45ryfZr/N6HjZAwGnNIjMYadPVoZMu48fE8ehwsl+ydWQ5Mol5
         9Q4VLu7W+iunddm9CMo382U1jc5PrEcQmib0SEumcn/2MdMaBjzKysbt2myxoUU79QR2
         5b5yf2EeiE2BAvVS/ULjtuP1xH9TfhYWgK0SS0kzALD3M9SynUKYR9J6tHTbU9iYvHWb
         wITWGKJYlDY0TPWwtAepB9XX11+0HMkghU61d3tdYyazBQJa5ISg8HeKcz+62o5m+T1A
         KCraThw4UHqWJBw4XkcTrQ+FQ0xVhn8pVJ8wwfU3TrVNhYJXw1QIBrWHwbDGDsbYUnFF
         0iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070435; x=1776675235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or/djqSd9t+k327sTGOHBISljhD0r/2+k7/piAbLga4=;
        b=ZgOMcGYpFsDDdEQT2Z+XFBMdY7JQ7RABKpcRTZcUesGkAHRRf6c3n10rt4YciEsL2s
         cSJBKFibcpLGFtrtkrj3/Y5OrV5VdIcRg9VaJGM3Mv49D/uLu7oLBts/jXmFzGdn+ehY
         tUI4aJ9rpNE2rGTYmmXghh8r8AwdytYXIVxpwNyPeIRYQB6siduS1ngNLbgLx7b80KQu
         vqV3H86ZZb1KB0aJtubBkBIPiU28glDSx5g8n+jjOqza/PqR0lJT+6oUJZsfgDFSkw8S
         zHFYSW5AM+7SYwYBvf6p4U/0DkUwP5lAvFXbRv0XkpQKDR9exKGH56ii2Jv4cjMmr7y/
         7fow==
X-Gm-Message-State: AOJu0YxzBc4l7BhUgxbjmBuIt/C2L0FzgWxlW2rO9J51n+nGLSdMT6F1
	A+m48keEh4+aF5OIm3QjvPLkh/rFWoSHU0J05auZ54+oLowBjUcAVXQDEfoX4A==
X-Gm-Gg: AeBDieuUdIHk0jrDAKx/QWQRAYzWlxnU4Vrh8DmGdpFTX3GFGJkbiFfldh984gZDsxr
	z4GY0j8PavydlDHuYpVvfDDlxxQ6i7p59hu1J3/SnKAKyoU/QgrE/QyIAfB6gG52GxV0UiaPTBy
	CGvPJ8HNSy/ZK7Cwxur9uTNi9+Fz2ipS/92jzsX+Xg+R0KxqIs718SRVJoJ6PCZufpD4DgK9/q8
	sofTUv4TvcCa2i/dTybXxREThla9yqnY5qvsER1dBHgoYm2W+FH+PigiqJjgsQqe0K9HLWRxaZl
	TA4ued08b+WLo2ZcM7vGvdqNTUwU0V5yKQx9fZ0rcOS0+02bbTjshuCnKj4jeJSmLLX9GfBGne+
	GNwMyJJszFG4cx+1gFxzyXSKSBjF9o6SsV7im7S+FMSvaO6aIkwp2XusUuA7Ns1r5eAYWa218j6
	PUhpD1Q4K3yIGgY8hOoFXGDJix0u5Rldr0SkOOXjDdq4W0WPesE6HsLW+eF5YmPY39
X-Received: by 2002:a17:903:1250:b0:2ae:59a9:639d with SMTP id d9443c01a7336-2b2d59764eemr126498945ad.4.1776070435166;
        Mon, 13 Apr 2026 01:53:55 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0ada5sm115843715ad.42.2026.04.13.01.53.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:53:54 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] macvlan: fix macvlan_get_size() not reserving space for IFLA_MACVLAN_BC_CUTOFF
Date: Mon, 13 Apr 2026 16:53:49 +0800
Message-Id: <20260413085349.73977-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278000-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 296583E96D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

macvlan_get_size() does not account for IFLA_MACVLAN_BC_CUTOFF, but
macvlan_fill_info() conditionally includes it when port->bc_cutoff != 1.
This causes nla_put_s32() to fail with -EMSGSIZE when the netlink skb
runs out of space, triggering a WARN_ON in rtnetlink and preventing the
interface from being dumped.

The bug can be reproduced with:

  ip link add macvlan0 link eth0 type macvlan mode bridge
  ip link set macvlan0 type macvlan bc_cutoff 0
  ip -d link show macvlan0   # fails with -EMSGSIZE

The bc_cutoff feature was added in commit 954d1fa1ac93 ("macvlan: Add
netlink attribute for broadcast cutoff"), which added the nla_put_s32()
call in macvlan_fill_info() but missed adding the corresponding
nla_total_size(4) in macvlan_get_size(). A follow-up commit
55cef78c244d ("macvlan: add forgotten nla_policy for
IFLA_MACVLAN_BC_CUTOFF") fixed the missing nla_policy entry but still
did not fix the size calculation.

Fixes: 954d1fa1ac93 ("macvlan: Add netlink attribute for broadcast cutoff")
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 drivers/net/macvlan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index a71f058eceef..80f87599a503 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1681,6 +1681,7 @@ static size_t macvlan_get_size(const struct net_device *dev)
 		+ macvlan_get_size_mac(vlan) /* IFLA_MACVLAN_MACADDR */
 		+ nla_total_size(4) /* IFLA_MACVLAN_BC_QUEUE_LEN */
 		+ nla_total_size(4) /* IFLA_MACVLAN_BC_QUEUE_LEN_USED */
+		+ nla_total_size(4) /* IFLA_MACVLAN_BC_CUTOFF */
 		);
 }
 
-- 
2.39.3 (Apple Git-145)


