Return-Path: <netdev+bounces-278533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIYzOZFn3mmxDgAAu9opvQ
	(envelope-from <netdev+bounces-278533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:13:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8101B3FC68F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 016C03069BB0
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366103ED10D;
	Tue, 14 Apr 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMzKIUBo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1bfUYR3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15173EAC68
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183032; cv=none; b=J8z7mGBIYDAJrGuk9TtqwWK6U7d0sBHlAuctSeO+SmSnKr0MMsAWhqtoEdFjm/C/xM3Z7MSg5dOMJqYF+km+W16NPXQ8rWbHfKCg+R9gxJnvkfhAl5J+fkwEigKZQJVSdvot9zsAzNH3LDFfyJ4LYqRDj0ghdtNNoAMs6NI2u34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183032; c=relaxed/simple;
	bh=8KxSLwY587LR57aGsCLpqgDw1kJidOt4vFYe6TGecyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZVGoP5lKz3GWcZb+/Kjq/Q+jOeLEe85Ty5Ow9FO50NZ55AyNFkT81kLPXRZ1wNnqS2+/uH6QenmQoyspIOemGcR9T0u9vF+TsnCh3pVCVcWsylEE2sOS0iL7f2JRKIBMlSwA6wNFFsarOygboPCD3f96Oh5X9REfFvrmaPz+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMzKIUBo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1bfUYR3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
	b=MMzKIUBoEDSROwAa381QSUT3xNo7/Gz/GZ7x1g2Crr/miHummwPM/3s+nQGOr/w7maZllm
	fVQ5O9M3k1aiZfvWam6ZG12AhlKVzqcFs0MBMPXchqf0Q2iNoD+QtNmi1Aau6UjN6MiWwQ
	iCRmkyB1S4ssDAyuV1+IJAIuR5ok81w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-oIwuJYKZOHe7XVKluiQRZQ-1; Tue, 14 Apr 2026 12:10:27 -0400
X-MC-Unique: oIwuJYKZOHe7XVKluiQRZQ-1
X-Mimecast-MFC-AGG-ID: oIwuJYKZOHe7XVKluiQRZQ_1776183026
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d705eaa64so3043478f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776183026; x=1776787826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=a1bfUYR3Z8jsK6ngfE5aV6nn4igFxI236y4VbJXay7vQrMsiH6r5dYiBZY4Sy96sGY
         tfdNGMKD3ESwrGm+mdtON02U0KStduVbPdcRwF6RPiY1il0ZOzV7dB9wJMGCBoTYllXB
         sC0Q3r2r2a3lTzUjXeQtqoi0BGsTv2ogjeBR4uJ/QLIelTB6MPfDvqQsa4HWSJ1HzTTf
         2IMOrH9SB9p6ARIQ1WSkeDOJE9hfHoYyF+jP/8Z+B9M/EpjFmCcifOSpVnD+LcwpBWSr
         WhVsl8aYfcWhdqaVxpqcdFX6ua7qsMesqiYj+JChIpjW/QUfSLhZViSxQexmtVxF3RHE
         raOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183026; x=1776787826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=PSd4RKCZerLB6OcnfimxKZwg6w4tn4Qln4cjk0Xpgthab9H70I6Xh54bQfh1VDE6oI
         RSmqxexix0ozHHhEhI8mTxLKmYOA1/oVjjiL4BxPiiKUsEL14Z4EjMnx97EZxERr6pfD
         hecHfh8qZo/3wwWCgWF/7C9/ZH1653srmy2glxrjRdylNmVxHkNpe/NwdMDrf6QQcCbd
         f20V4tIEGDWu89pjIoyNgIVvl7w2lFmWcgfXfWF1zbih/0ZNAu5+l9ESpXIv1kRfYTit
         4O19CMmXTqw1q6R+M+AS4WXIKD4TVh55rHua63jEFBcx6CjjFXj+YhrEGuZoF4BGH3co
         g/zA==
X-Forwarded-Encrypted: i=1; AFNElJ/90P3mhx7gCyQbaaV0la2CxJc8MOVYbY1zAiSDxcmQ0xYauOqqjIISYcBONls9mKtToN5TVZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qw/cJozFDR2g/AwPKnJKGiaW9Rn3qWMq/FrzdQuCVG8tbkLe
	4T3khGqbW851Cihy0xA541FAR2RhICHAsUkiLmMpzWXKhdLDe8u9ALDmu9agPrat9M5/xUzqUEn
	9XtWePSsjRe7fXVaiebPw1ZLnLjUT0S2vFoCLoI/CE7kvn5Z4hL4vwf3zow==
X-Gm-Gg: AeBDies09+bsD5hRFGF3mOmAXEjtLtIBfOPR35r/O37MmjqI5WGZ77Kmi4L6Rkf74uL
	1ZwRcS+1P0F4IM3npoaAJR/GbornX8S1ccXAKxI8pqIhOqNkG8+e6oxhpfSbRzCguKjsCeKSbbx
	oU4lBIRoMrcqQ8fOLAkLPUSxUjheWpOwxmlasghO33OUfiWfGgRUZJvoko/H6JAyxIsAst+EeK6
	PPWW6TwnbSQRPPTMA2a8OlebEAHLg15lJ32JHIjgO030bfB31RmUbxd1atE7H64EI0y+j56BWaP
	tz2wjoebVtoy4hz4Q824s5B0WCB1APGGdBEJLaaLrNx1Yjy2beT9FT+Kar9kupydLtuDv/Mpy/p
	JOasbBfwA2C5qt0M/T87E1vHyhE+Qe4xN9pT8MxKhJ4G9kQ/HtK3cNDPub0oR
X-Received: by 2002:a05:6000:4284:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-43d762e777dmr15595055f8f.17.1776183026413;
        Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
X-Received: by 2002:a05:6000:4284:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-43d762e777dmr15594975f8f.17.1776183025862;
        Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 14 Apr 2026 18:10:21 +0200
Subject: [PATCH net v3 1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix_peek-v3-1-e7daead49f83@redhat.com>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
In-Reply-To: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-278533-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,salutedevices.com:email]
X-Rspamd-Queue-Id: 8101B3FC68F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in
a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a152a9e208d0..b5015ab2ee1e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -545,9 +545,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
 	skb_queue_walk(&vvs->rx_queue, skb) {
 		size_t bytes;
 
-		bytes = len - total;
-		if (bytes > skb->len)
-			bytes = skb->len;
+		bytes = min_t(size_t, len - total,
+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);
 
 		spin_unlock_bh(&vvs->rx_lock);
 

-- 
2.53.0


