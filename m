Return-Path: <netdev+bounces-300115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SqrcAO9yMmqQ0AUAu9opvQ
	(envelope-from <netdev+bounces-300115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:11:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A981698524
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:11:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=KLGHlWWI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300115-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300115-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9573F3198E63
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45903DA7E6;
	Wed, 17 Jun 2026 10:06:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C03D7D7E
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:06:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690764; cv=none; b=lKjcAvMhRKPP7YmCBeAC+5TCPRS1M3A0J06D+jqrd34Ufb8eK3rJcryNcfrCZHw9A/C4zKYOHD/pMx9wqjZWhK9QvAk/5niY2MHOyGR3v4okcwbpF6rIhwuhruPkRj+HMG/L7quA78H9fOASoLq1vuEgzS+0Ls5AV4wdqmtOcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690764; c=relaxed/simple;
	bh=+lUniz+q8lUs9BYGcRRkAl9bdd2QYzCYyRz+e0Nv9cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tT7jb9biu1nG1uCe9hzUD0vyrWG+UYATnfvvLaz6KNh0XB2044aMDtoErrMMWRBWdr6jR5M4h8j1LqPKaEU4fZ0EGJ9JMprI7+qk6qoNnaaSyO4Z0e0mA+wEDo92oqb+HFU9m379+hOa4syhzPkuIQyzwKD3X+Es58GEvdU/A80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=KLGHlWWI; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso6258435e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781690761; x=1782295561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUCt6L8NGGOm3y2JBJxNOs5/dk/YzppXFeUdkifdqiU=;
        b=KLGHlWWIQWV95gRGvYrlg8zMuKKgIvOP+3By4nnVx1YX+fVHJ8QQffgBV4ciqjmmyd
         L1tscgyFu5SU9qqpxN7FikREOjy5cIIQvKLggUoLSxK5xdKvO2E44Uitvor6nSHnaXw5
         n4sbCnw+8OWpwJtSI3wVs8pjrMgN7PW2xIiIktnsAVoBwMY9/7Gr4Bwd3NRL1vpVtrLt
         VAaSKz+t5AcrJ2yICYjx96c8LCWjrxS7a/LzQGkwq97Z1W82wDHIl5Fm7+kPE1Q5JcVx
         JjLuQVhYdZasdESO+aCLKFiO648xfECbjYiTcHV6zUisBV9oMNtp2o7lRYvgWP8419lL
         dWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690761; x=1782295561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUCt6L8NGGOm3y2JBJxNOs5/dk/YzppXFeUdkifdqiU=;
        b=buVIzwdkZgaxk+CWDQRDzQBjtw0dbxDMHf9JNFqEHZCrWc498+fiWWchf6knhPgLj+
         nK7KcrEdbsQ+oztM9kifaoAeQI4xYq58SdD5Q0XuxnSn6cIVOObpDag6JIN8m01zQHme
         tt9jyEtAqCwAmouxipHxma38RT9GKsfujmqdAMXQz4GMEfJbT7FsAnWBAahp7EcjMgVg
         nf6BkxWYm+KBj9sqPtz/PM24Nw/clitcm6qYtlJKiVOA+OKt6IKFMuSeMYIVqEeXO6bj
         K3RUWDv6RsS0G2w+W/pP4ERHQSdfFSKD1PeXsVuHX/dKR0Iyl4zmL1fdzl2IoBfuJgMi
         LHRg==
X-Forwarded-Encrypted: i=1; AFNElJ9UDwjynwXxSnxNwKWHxcdeOLhhg7DysexspNWUuuZSSGEX3CZGr5V5IsiR7+9YLs5JYltaoiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5vR6PgGpy9rR5xCYyvWaWWarUg3YB0x2+LOZUYp6GlOQ1Vea
	g5iOK/zYolQXtP3wx37j6/lUpCEwiP22nDkPzci/VCe1IAast7pZvbS1cEAMpqU7wCd3
X-Gm-Gg: Acq92OFJztbMF7bcTockA8OLkWyr84geNr2cPbclcJFE2Y3a9CLpstuzwQmop2AJ/tB
	QW6W7lFBVMIdMq/5WPpSTcArhYOJlJoUoWVyuDnmelhBez9UkOSLpQpNz8olsGGHhN6q9oYCqvV
	0hiKs3dQd36XMgtK4varBzheJmTrn5tHorVxkWsA+cQGyHvO25R8OEEqUYzGYy1d0HirudvR+tz
	tZt6tUHba9/jSvfuis56jRhEX3jKlg1aGHIF+4cazkyeRS0bNabAaLsfIj+FZv0jPNJFmqukpaf
	+2jHKtwaEIJ4YAVsH+md6W697igiQmeXLsP7QTR4bTw5rIfcMzDKf5qrSkyWeWa18KuXW4r8AQi
	CfBw17sfElXH1orDjA+KAhWimk2LmpRZ/EfaG85aMashe5MG3NGumN+xveWDFyUU0lRRz8Ty/8B
	GetLodVi/l+oSq75ovXjpxiW9X9hxjrL1sTlI1KwMLJeaPTUlTFZdP15jfgVq9F581PidluZ8fZ
	Y5mSGGZ19jQ4BO3GImB+Rj3xaQowSqVYWQ=
X-Received: by 2002:a05:600c:a45:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-492340f6f3emr34524455e9.16.1781690761127;
        Wed, 17 Jun 2026 03:06:01 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4fd31sm142422875e9.4.2026.06.17.03.05.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Jun 2026 03:06:00 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: borisp@nvidia.com,
	raeds@nvidia.com,
	ehakim@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete
Date: Wed, 17 Jun 2026 12:05:58 +0200
Message-ID: <20260617100558.83654-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-300115-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:borisp@nvidia.com,m:raeds@nvidia.com,m:ehakim@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DMARC_NA(0.00)[0sec.ai];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:dkim,0sec.ai:email,0sec.ai:mid,0sec.ai:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A981698524

When an offloaded MACsec RX SC is deleted, macsec_del_rxsc_ctx() released
the per-SC metadata_dst with metadata_dst_free(), which calls kfree()
unconditionally and ignores the dst reference count. The RX datapath in
mlx5e_macsec_offload_handle_rx_skb() looks up the SC under rcu_read_lock()
via xa_load() and, while still holding only the RCU read lock, takes a
reference with dst_hold() and attaches the dst to the skb with
skb_dst_set().

A reader that has already obtained the rx_sc pointer can therefore race
with the delete path:

  CPU0 (del_rxsc)                 CPU1 (rx datapath)
  --------------                  ------------------
                                  rcu_read_lock();
                                  rx_sc = xa_load(...)->rx_sc;
  xa_erase(...);
  metadata_dst_free(rx_sc->md_dst); /* kfree(), ignores refcount */
                                  dst_hold(&rx_sc->md_dst->dst); /* UAF */
                                  skb_dst_set(skb, &rx_sc->md_dst->dst);

metadata_dst_free() frees the object even though the datapath still holds
(or is about to take) a reference, so the subsequent dst_hold() /
skb_dst_set() and the later skb free operate on freed memory.

Fix the owner side by dropping the reference with dst_release() instead of
freeing unconditionally. dst_release() only schedules the RCU-deferred
dst_destroy() once the reference count reaches zero, so a concurrent reader
that still holds a reference keeps the object alive.

Dropping the owner reference is not sufficient on its own: once the owner
reference is the last one, dst_release() drops the count to zero and the
destroy is merely RCU-deferred. A racing reader that runs plain dst_hold()
on that already-dead dst gets rcuref_get() == false but dst_hold() only
WARNs and attaches the dying dst to the skb anyway; the later skb free then
calls dst_release() on an object whose destroy is already
scheduled, again a use-after-free.

Convert the RX datapath to dst_hold_safe(), which returns false
(without warning) when the dst is already dead, and only attach it to
the skb when a reference was successfully taken. When the SC is being
deleted the in-flight packet simply proceeds without the offload
metadata_dst: skb_metadata_dst() returns NULL, the MACsec core sees
!is_macsec_md_dst and skips this secy (rx_uses_md_dst path), which is
the correct behaviour for a packet whose SC is going away.

Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: also convert the RX datapath dst_hold() to dst_hold_safe() so a reader
    racing the SC delete cannot attach a dst whose last reference was just
    dropped (per the automated review forwarded by Simon Horman).

v1: https://lore.kernel.org/netdev/20260615140534.52691-1-doruk@0sec.ai/

 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 71b3a059c964..e5d9a14c92b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -829,7 +829,7 @@ static void macsec_del_rxsc_ctx(struct mlx5e_macsec *macsec, struct mlx5e_macsec
 	 */
 	list_del_rcu(&rx_sc->rx_sc_list_element);
 	xa_erase(&macsec->sc_xarray, rx_sc->sc_xarray_element->fs_id);
-	metadata_dst_free(rx_sc->md_dst);
+	dst_release(&rx_sc->md_dst->dst);
 	kfree(rx_sc->sc_xarray_element);
 	kfree_rcu_mightsleep(rx_sc);
 }
@@ -1697,8 +1697,8 @@ void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
 	sc_xarray_element = xa_load(&macsec->sc_xarray, fs_id);
 	rx_sc = sc_xarray_element->rx_sc;
 	if (rx_sc) {
-		dst_hold(&rx_sc->md_dst->dst);
-		skb_dst_set(skb, &rx_sc->md_dst->dst);
+		if (dst_hold_safe(&rx_sc->md_dst->dst))
+			skb_dst_set(skb, &rx_sc->md_dst->dst);
 	}
 
 	rcu_read_unlock();
-- 
2.43.0


