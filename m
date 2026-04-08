Return-Path: <netdev+bounces-276590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKlaFNhy1ml2FQgAu9opvQ
	(envelope-from <netdev+bounces-276590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:23:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24723BE217
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44862304046A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E22C3D47B9;
	Wed,  8 Apr 2026 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzIKz+QW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJ1yLHIM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A0386C3A
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661672; cv=none; b=swy6+xVudbyE9tjD8RiCfzSnVr33ElCt+0F0Ejd4jhLJDR/6yguqw2nVLFOLeD1q6C2PcMuJ/tncuiEqB2b4nso+lznkxsWoTbmcbzPASqsZHZx8Blp/PCZm0YONtRbShtZj04UOAu4A/9OwGETzXYc0i7oJdeXaWqElfE5GoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661672; c=relaxed/simple;
	bh=JWryo19XSS+EbbXgCTnUDuve7zD+psGcWk4bJFoTzeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c3TgbP4SRakXlIramUxMx61ah9H3F9PdLXnFY/TSpHe/XSFUG5SP9FqgFxweeI2rK8az7joB8GzW4CpYL752ocIgxdCujRWGj6H5bnQurPnTak2f5CG8nsOGOg1bRfl5pEcAVnk+FuMUIz7CDokwpUyHh3WxW647PcO1X/jP93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzIKz+QW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJ1yLHIM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775661669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bxgs/94flkc5gzjvGkdrpP39nvy7O6M4eR7c4f7iyik=;
	b=HzIKz+QWBdxilopFnr1QrpaVCWSqPDa4MCap4iekECc5TMbIcU13B984iKn7mmqjO+xYl7
	B0FpJHPCJcftVj8vk20OG7jbdJw6gJF6f4eXzcS2f3NN98FvCPidG3QSE0GBvQkC91i/zf
	kl3dbhQZhF2ZjqxqwI10KKACg/v+zSA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-Pg0-BpacN3ubPvqtBHqFWg-1; Wed, 08 Apr 2026 11:21:07 -0400
X-MC-Unique: Pg0-BpacN3ubPvqtBHqFWg-1
X-Mimecast-MFC-AGG-ID: Pg0-BpacN3ubPvqtBHqFWg_1775661667
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cfb72377bso4325553f8f.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775661667; x=1776266467; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bxgs/94flkc5gzjvGkdrpP39nvy7O6M4eR7c4f7iyik=;
        b=TJ1yLHIMsDk1c48l1PvegTK7Jq3jTSgnOT9ssJdYUCXor1Kz6NDUcW8+0dHu6iCPJp
         7uFOIR82ecfIHG5czVgLxNo/ub/cihg9pqVxnb0oZS9hdE5ft1mlbtNIIgrR31xrJgXc
         zERdmheMC36wzhLBixaqrj6Hz7ov2auhCzEAj3u7eKh5SsWlkUg5rVFP1ouEnehJVPHp
         FvMX6BiY6gIFfx5ETTywZrCvR+RlYDhAE8dTu3JDJqsFiQzKiK11jOtfCTrMjWGc7U6m
         0x3yBCAyGrZH87XYfDpxBs3iVbU8cuscSAW9l+492/0OR+JT5hNz0pHRMnlt4jKio404
         MHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661667; x=1776266467;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bxgs/94flkc5gzjvGkdrpP39nvy7O6M4eR7c4f7iyik=;
        b=XZx25lS0jMPlI1KsACeIQLHe8rSXO8cYxB82xjxKxyHoF6CLF5+hYG/ubKgX/RNKE+
         Ha46sAqXk6Xa7x/zTIDiaDewsADqfFNtZ2bSCz369it9AIV6gPlj68QPKCwaVB8fw+Hg
         WrDezZeKjAieZ29Z7cHN10EHz6gksaPhxB0cVflu9b804Zad/WrVKXLbp2Pp6yu+A+Ni
         uQNpk8W+6u0xkXxynsgwtxF9ZE5DmYovwd3QnDm5kh3gYtRRx2HbVr1tKIH8Yz0jcFHi
         hEGxaPc8BPt/mcgpP9OLA0NIt5gJhYrZw/EWCpb2HU/zOUXbGvasUNTb4viNGdVXGa3b
         3m+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1cbjD0frnpo5NWQbD6U7/jzlyp52lu1TouXjD+/npJcYju/12Z9U4R/vZZJMXaz58kdQMWm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAESNlYdXaK5rOpgmDd9eFa6CgImW5EUFLadhs+NmJfr/2/rZ
	Fzoim4GvqdapYR68R1YF19iKQMDBl3zlkOh8ZsFnxrwD1aCLWZg33NRdpq7GiozffONNedpAVuq
	pclqMSTt76VXa1XFstrJW0QNk4zNIPfnRSIrcJD06MRaMFFEW9QoJQ6N8vg==
X-Gm-Gg: AeBDietnbtFDgsxT9jkNZGn43+QTlGad3u87s/zyUvkLKbt/INeOqVfAd58DTD47xOX
	43C22UbuDN4IsMEAGYbG7m3uQzCXtz/7NQxldfyh1C6vC7Qx2YbXA9RGzikZ1Mip4um7ZogdQVc
	YoF5IOja3Jsiv8njpamg8wAlImSQBoLkKlIkE4GrsxPwmsge1Mjz+K3vWWBpDRkgWpyAsToHBBn
	4ByjrcmtDyMVNmxhw8rVqi2g8Pt7PQ9x9/07hX3Rd78IPRQGRUHX0CbAhB/cNtYdBqmp9w/X6bQ
	iYPd3zO2lOXnJcGT0SNQX6JQv8IaNvG0Sxcs4/EDNyWL5RW4mFez1QP3sBPUmjNzYhxnzIR7/6e
	yhtf1kRLPvwr5bqI+DMygOMoS5Gf4vTv/3ef5JCqVxsr4cVifHhR8ZcLMpwbU
X-Received: by 2002:a05:6000:1842:b0:43c:f3c9:3815 with SMTP id ffacd0b85a97d-43d29277055mr30965407f8f.3.1775661666589;
        Wed, 08 Apr 2026 08:21:06 -0700 (PDT)
X-Received: by 2002:a05:6000:1842:b0:43c:f3c9:3815 with SMTP id ffacd0b85a97d-43d29277055mr30965363f8f.3.1775661666078;
        Wed, 08 Apr 2026 08:21:06 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm60446899f8f.21.2026.04.08.08.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:21:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 08 Apr 2026 17:21:02 +0200
Subject: [PATCH net-next v2] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQqDMBQFryJ/3ZQkimJXvYdISfVZszCRnxAsk
 rs3uO9yGN68kwLYItCjOomRbLDeFdC3iqbVuA+EnQuTlrqVjewEY/MJr92w2RDBYmmVqdHIaek
 lldnOWOxxJQdyiMLhiDQWs9oQPX+vr6Qu/z+blFACfaf7upVGv/FkzKuJ98lvNOacfz4Fg2q7A
 AAA
X-Change-ID: 20260407-remove_parameter-f61a3e40cf90
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-276590-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A24723BE217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`virtio_transport_send_pkt_info` gets all the transport information
from the parameter `t_ops`. There is no need to call
`virtio_transport_get_ops()`.

Remove it.

Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Removed Fixes tag.
- Picked up RoBs
- Rebased to latest net-next
- Link to v1: https://lore.kernel.org/r/20260407-remove_parameter-v1-1-e9729360a2be@redhat.com
---
 net/vmw_vsock/virtio_transport_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..a152a9e208d0 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
 		return false;
 
 	/* Check that transport can send data in zerocopy mode. */
-	t_ops = virtio_transport_get_ops(info->vsk);
-
 	if (t_ops->can_msgzerocopy) {
 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
 

---
base-commit: 4c2ffb3ea8a601bb3730754cfaa433e673037cda
change-id: 20260407-remove_parameter-f61a3e40cf90

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


