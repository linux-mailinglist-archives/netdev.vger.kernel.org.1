Return-Path: <netdev+bounces-282676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN8uGIYB82lswgEAu9opvQ
	(envelope-from <netdev+bounces-282676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:15:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC449E7CD
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E0C3029E73
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0039A07B;
	Thu, 30 Apr 2026 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnWnp9RC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C529CE1
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533118; cv=none; b=uSb2Vt9FUqWeSpS9Zx1qiGgvzoysW9XS2egx7HpTWjmZAjTS86PyKK/ZbLBntwwzKpJTtfA/PfrqpuJJyhPEJhoIzavDlsIgntDpneXOWqG5mBHQoHHnW1TSmg+uxAJtqIp/cRZsesGpq8hjpcfq07v7YkSilQVdSghyi8Jvh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533118; c=relaxed/simple;
	bh=WHf7SDMWeGDMepkYHsY68ydsCu4X3ZfH1ZKR959neqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXAdj3CRyssGwe4bHF7o0Q18cRtsWLIrGjuIwUl3QfrAGm7zSmV8PBIq9EbzfBSecn4e+oRVVYSU7tm3vvSc1EN3foB3Fx6pfXrfUFdQkEVexycRq4G3M8Bt1QkQk+2+vwc6PFiTuqeNKpPYjOvDwRxqVBZ1f7lMbEZetfjlyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnWnp9RC; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8244105fa96so21424b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777533116; x=1778137916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFvNVNkRh7BzI+OzIKJ5kBHa8BAxHSA7m55h3BL2rQs=;
        b=YnWnp9RCggRjEd1Tp728h4tXn6aq+rDoBV3L0sPx/93PFdq6nNMYNoit4r+v9vlozK
         /UuY+Qlys+AU3QwKYKeV/33VUEM48+oIKEQ0iOvXDfJi4U0Gl/L5i5WRw8D8FfW6Jk2p
         SXMuQGVVnHT8zYiWDi27xH5VSlhNZJ3hpUIjhcgo6a22wYELgkGJmpR8XZ7iTWleYwOQ
         aIOpIqjqP8JDvcyOdjkAzxrgazxgOQmHWWC1cC0hhxNGEL7HvcR9xFBCOfuUKIOrFTTG
         1a1He56B5Qeu6h/CWxXzbod3s3GLvUv7mvBmGByw5LqCDzG8th5UxpYT/d4Usx3K8w++
         1v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533116; x=1778137916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFvNVNkRh7BzI+OzIKJ5kBHa8BAxHSA7m55h3BL2rQs=;
        b=XtHwjMQhNlOPjL3XZu4UXn+aZBNmpsSuuwqE22evCPvJWLxYZNaHVLNHBd2SvcGeaR
         7BTIPPNFm8uzMzkwtInBwaoe8umUWTxdSTf7xnMfTQN7qzGcCkaYyOWzcsuUbHn7kKLq
         8V7/Jb0g2uK4KwZC2QyZJCf0E9ya5qYfVc04BJThmqqyulUEYmTchx3IjBgBMmlkz/7i
         /TRw/7yXw4GSDyfz86iSf/NfXMQ6XqBJ4B+2xiiezYgzL8hDHSM/+eoWUeUIBahRcXO5
         nxlhoejatAipZXt+Zs4IxfVPwnfssSjnDUe2NeHsSjJE8xIPhAmtnYDsfevV6gn8EAsR
         OsoA==
X-Gm-Message-State: AOJu0YwujtP+RBHqtNq4km6RMuNX6mJsFuke6pwmtSf0OrjX+HM+qqC2
	vvVgSlXo3MrtcYuHCxoinzSJN0XgyR9K5HqSexaFYDgdflScNM5jWfyG
X-Gm-Gg: AeBDievj6dhjiMH8cuPAlbwEd8ILirr3uGRHOdnn8jqXihAxsTWBf9k8yV+fRfMskUA
	PHQtSCq4MG7hqMpVJ0t0juSgP1od1F99wDID3llM9Lp78+YEuKs+uyXWLV8hC9f6nLVkdKkJtQp
	N98OuRIrJ4oZ/ZiXyx4o0wAouk/r2C/IJ83kYOxl+nivjpZj811bbgv94zNRnwFWUUbmnW0khgk
	Dk7ITFEgjzWm0mRyxekd/K5y8f056YqQk034edlHoR/7IWroR9v5DcIfC4FJmKSXGW7h58IJg0Z
	0F0MSlk6Fy8NMhYJE2mirqYp//dOc5Hp3roY/he5AxyMUrh/tDJd5WC/FPT4cb97aSQz81dB6iC
	hXOZZFZEVhtj1xsRa19uCGCBuTW6khFSWXEPFHWxOSAg6q5h6JnRNoJUX/GZasMiUqsGmrwKNQh
	EJsE2+FQAYX41FFS0FIa+oRTrNiiGFxIWJ5cKDAeT73NE=
X-Received: by 2002:a05:6300:2208:b0:3a3:18d4:2590 with SMTP id adf61e73a8af0-3a3cf70d02dmr1041632637.3.1777533116186;
        Thu, 30 Apr 2026 00:11:56 -0700 (PDT)
Received: from localhost.localdomain ([189.1.242.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed7ecf57sm4049605b3a.50.2026.04.30.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:11:55 -0700 (PDT)
From: Yiqi Sun <sunyiqixm@gmail.com>
To: kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yiqi Sun <sunyiqixm@gmail.com>
Subject: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap copy
Date: Thu, 30 Apr 2026 15:11:10 +0800
Message-Id: <20260430071110.380509-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B7CC449E7CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282676-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunyiqixm@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

vsockmon mirrors packets through virtio_transport_build_skb(), which
builds a new skb and copies the payload into it. For non-linear skbs,
this goes through virtio_transport_copy_nonlinear_skb().

Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
As a result, skb_copy_datagram_iter() sees zero writable bytes
in the destination iterator and copies no payload data.

This becomes an info leak because virtio_transport_build_skb() has
already reserved payload_len bytes in the new skb with skb_put(). The
skb is then returned to the tap path with that payload area still
uninitialized, so userspace reading from a vsockmon device can observe
heap contents and potentially kernel address.

Fix it by initializing iov_iter.count to the number of bytes to copy.

Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 416d533f493d..6b26ee57ccab 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
 	iov_iter.nr_segs = 1;
 
 	to_copy = min_t(size_t, len, skb->len);
-
+	iov_iter.count = to_copy;
 	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
 			       &iov_iter, to_copy);
 }
-- 
2.34.1


