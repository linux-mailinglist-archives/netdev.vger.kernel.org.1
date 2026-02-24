Return-Path: <netdev+bounces-260305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAwdJjcHnWk7MgQAu9opvQ
	(envelope-from <netdev+bounces-260305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:04:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B40E180CF6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 03:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C93D7309B4DC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C8223DE7;
	Tue, 24 Feb 2026 02:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvKXRBEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08E1DB356
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898626; cv=none; b=IgkPe5WIuC1K10XcnGSCNAvfoQq7/UHKER2OhZkCjAkzXGZG3PDAOa5SdG0s8px9GceHak260MRDan3Y3uQzq7J/YN/hRL6iUHCmifJxWZwm5mCxrryeJw0uwtdfx44R/hm26+xpisfr3xOTnL6U+/eRXaW2mzAy6Zdm2RuMN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898626; c=relaxed/simple;
	bh=TKAynUsDa0pnQZal2qOyqmI9x6RBTolrQrFDfPI9WLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MngyCp4ncg4eLEpgDIvCWFwogJcOu4vRNXQXFjPOpXrEBtxV/p0gg7g50pXRJiVhQebDuqXvyBWsWw7usSu7FCjsX6c3AWpHcsMwHUKwDnhHFQhJHFUtQIW958iwSdLdDTAuv2V1Fnne9Gl5jjSMHZzXr9EVb5H6bHB1Z3vRmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvKXRBEN; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7927261a3acso44508327b3.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771898623; x=1772503423; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TrYAc39sTLZZ9Y3u2dhcPCilxry9QSJbAenHU8ouVoA=;
        b=jvKXRBENuyNIfC1BtgOyyfPT8ep6XJH30KQzl8YQPMln+oiV/KCdVkj7e3mLKcXPDQ
         wr1yVTbQhg4JfWeuH5dfT2M67cFQQjxYL2NgircXFnx3Z6ciYcNcBVqtjMpmPtW74JPA
         eJzf6iNsTvCXvLiAEI/Rnk2MzPTiT+FVMhvfYkThJX83coSJx+XtbkaIc8KqnXeel9Vr
         8hHq9C0rcRnb6N4MUgexxAh3Lk6HZ7Kw2V/pFDnwGlrZGHbf3BD/UlU34rdnkQCn9S0+
         Gj9X8vcwuksyHxZ/3vjHYCZV3iVAsF7Jolvvz/+2XkJnOLvwc9ZdJVD7gxS16RwbmcqO
         Rt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771898623; x=1772503423;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrYAc39sTLZZ9Y3u2dhcPCilxry9QSJbAenHU8ouVoA=;
        b=ha4+EIKA5r3aUIs9nOqOeC1FlnahlNla3HTT0H49Te2W89kvPETIl8s/fPu7rPTSjO
         zKLiTQHOnipxFIE0rm7Vqh5rGeLwUoYdPoMEE5cH4d9zloG+hCQsUeQ4Y3mwzbl3pUfU
         CVvna7UqfDE3RHG1D7kWfSKh20cTfyr+/bTkQtuBJI2wlAib4nWvZ5JAR/agejEivhsB
         kWgvDDQqoHgA+jsWNuXYqnGp9xf8hdXSHPsxN9hrAYPoSNeQwxEcnZLfklXqgwZ88yYR
         PSwMtBYhohg1+aGpQRQtGhbup4UksSjMfGonzZKJiJiSqFwLXT999INl3UZtd8QKU/dd
         Kzvw==
X-Gm-Message-State: AOJu0YyoiEGoArD4R5Pf9EvuTP3BkjsnQRtLsGffhdCw7mygOqYRmL9C
	Ljg1TZkoiolhaiUPoyjpqoLgqkUMONqtUtdqI05HhwP8h83HiaOe0GY0
X-Gm-Gg: ATEYQzxtrZefWZhk4aE6hVtCcosaHIuLjI9oSEV4T6rrU1D4rsYqB9SfNOAyr7hAv8H
	649ldbULXf3m5kEU2qaHWQA97pGNOGSygKjX6A1/SB8br7ADnAT6ZpE4wMLPxDRWUpnrGPGxDIw
	/GXShtYZmTneWYHLwpuMrWpQORoNBAAlI5R0jxdfhUWDuZU8cJBe9uQ5zUR9BjMKyFtXIVmaW8/
	Nf3Qh44UF6Asuo2zaMFq2P+xM32yDLCmru8vF8ZI58lAoVQbF2zWca/ucQRAHQzQ2mE3glOKBK3
	13kil4upkaUn7H1XRcZWouIaSPKziC0VvUukC7pIWgMGTCmgRltCiURIrNE+nKUCEUtfOgM+OfB
	m5+I7unQK5OD2v0YC1osHZJvPSJcTyr25uC6YhHgWFphq7Ir63S1C3jYs0vgXjFwktHM9EShVBW
	8hBOhTybnA7zOrKEgm0kYO
X-Received: by 2002:a05:690c:4d84:b0:795:1d73:4d7d with SMTP id 00721157ae682-79828cf8430mr99001887b3.12.1771898622979;
        Mon, 23 Feb 2026 18:03:42 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd8207sm39043487b3.19.2026.02.23.18.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 18:03:42 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 23 Feb 2026 18:03:36 -0800
Subject: [PATCH net] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-devmem-membar-fix-v1-1-37dcae1e49f8@meta.com>
X-B4-Tracking: v=1; b=H4sIAPgGnWkC/x3MQQqDMBAF0KsMf+2ARio2VyldpOZHZ5G0JEUE8
 e6FvgO8E43V2ODlROVuzd4FXoZOsGyhrFSL8ALXu6l3btTIPTNrZn6FqskOHcNtifdpmNMc0Ak
 +lcmO//lA4RfP6/oBrMYTtGgAAAA=
X-Change-ID: 20260223-devmem-membar-fix-3a5cd9618f8a
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260305-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B40E180CF6
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

binding->dev is protected on the write-side in
mp_dmabuf_devmem_uninstall() against concurrent writes, but due to the
concurrent bare read in net_devmem_get_binding() it should be wrapped in
a READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations play
with the underlying register in unforeseen ways.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Note1: This didn't crop up in a discrete error, but just something that
didn't seem to quite follow my understanding of memory-barriers.txt, as
frail and feeble as that understanding may be.

Note2: the "Fixes" commit I referenced is the first one to introduce
binding->dev bare accesses, but the later patch '6a2108c78069 ("net:
devmem: refresh devmem TX dst in case of route invalidation")' carried
that forward. I wasn't sure which was the ideal one to select for the
"Fixes" label.
---
 net/core/devmem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 63f093f7d2b2..cb989949d43c 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -398,7 +398,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	 * net_device.
 	 */
 	dst_dev = dst_dev_rcu(dst);
-	if (unlikely(!dst_dev) || unlikely(dst_dev != binding->dev)) {
+	if (unlikely(!dst_dev) ||
+	    unlikely(dst_dev != READ_ONCE(binding->dev))) {
 		err = -ENODEV;
 		goto out_unlock;
 	}
@@ -515,7 +516,7 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 			xa_erase(&binding->bound_rxqs, xa_idx);
 			if (xa_empty(&binding->bound_rxqs)) {
 				mutex_lock(&binding->lock);
-				binding->dev = NULL;
+				WRITE_ONCE(binding->dev, NULL);
 				mutex_unlock(&binding->lock);
 			}
 			break;

---
base-commit: d4f687fbbce45b5e88438e89b5e26c0c15847992
change-id: 20260223-devmem-membar-fix-3a5cd9618f8a

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


