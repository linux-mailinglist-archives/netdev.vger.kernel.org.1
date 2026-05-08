Return-Path: <netdev+bounces-285930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHQ1KSkT/mnZmgAAu9opvQ
	(envelope-from <netdev+bounces-285930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:45:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3784F98D7
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431A23011C69
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E0440FD8F;
	Fri,  8 May 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf8kGTBx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hK7ds4ln"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E940DFDF
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258664; cv=none; b=YiojYUziKx+FgWujrlKiJmXBnJsx/AFWpBXp3EFkVpIbCLlsWdhCqoQ0lXjQWqzI680lY1HX+qoD4HMaKGV6oTS4djAsGw1pN64C7YKLKh14ct/U/aD/E4AQmsyXvtvOhaEMsFTAIsg2NjN1kX4C3ONmFYZ3DQuggkTEPT6mlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258664; c=relaxed/simple;
	bh=GmB8OB8MBui7lDml76JA2BxvhthP+WnYVp2rivY7tPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK4ln3NTFybrX++4XNRCzwqu9WRUDkPp9Nfkn8A/C/TDji5QF00GwVzWNqTaQDEB4kntBp3cChtJA1fjhmondpDysBcxDfaHtVx9a3IJJQGWKs8r6vv/HTi6P+voGNoCapG+fPOoFt+8SHNnZOsTXRwzFJwmlaNudhUl0t2s51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hf8kGTBx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hK7ds4ln; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRysknO3j16TQFAanFHTedpULbyeYuuxZEHDUwxrXrA=;
	b=Hf8kGTBxSBGAod/OuB2/Yh54v28UunnecbnGj4YWh9nIy3xeTWB6PzI7upuifG9KmtUwXO
	mLp6jm3E4//wwIZmA29cjvhJlcYqClmit9F5IsGOTa8aKs1YAeZYcb9KuafSt++VnPedAs
	Ve49LEPrXYQsM7pV4FTCe8duRMeE0gY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-RztaC-jyMUmPZzRoNWMvPA-1; Fri, 08 May 2026 12:44:21 -0400
X-MC-Unique: RztaC-jyMUmPZzRoNWMvPA-1
X-Mimecast-MFC-AGG-ID: RztaC-jyMUmPZzRoNWMvPA_1778258660
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44ffa15dc8cso1419167f8f.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778258659; x=1778863459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRysknO3j16TQFAanFHTedpULbyeYuuxZEHDUwxrXrA=;
        b=hK7ds4lnX3OcvmzD2Vkc4iPHJHNCMQ2lktxIgk/GOgqWz5HciWmwyOm+AQc51eWDKe
         20lwObNhGzMoYDD1MrIWfaAkEIwksrFsaRq3LAFAJNUXuef0Ph6P7gie5lM+hGrxDtKc
         z9M8GTicYeVGv2zcy1+Jpc1UGdJXxCSY9axnWEeHqBzVyYete2vccG0o5lsCz45Vuw4U
         T2JU6fnY92nTARSv4KZ6xuWuS/YJIERJNznC9/gl8TBQCUdKfW0jfsSswWlprNxwiJ5t
         h6SuJyEkKhA4AyTK4DpmLkGOk0nbtCu/cGmC7q7WadDlYuf5zAmVShvO6RYjWHpphSDb
         elCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258659; x=1778863459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRysknO3j16TQFAanFHTedpULbyeYuuxZEHDUwxrXrA=;
        b=A26GS04gEA6PABo+J0nEyx7qRxMJZEw2XstoiBU+u6BVPI0zEcyPirya1Jt2EgHF4g
         wk4x3/JdLjkoZRzCEcfXJI5GfLw0mUMlX0UxRjaNRMVXhiA3WbvLQfssAKsIHrM8/x2B
         pXs+OB5qGB8MV56jPujHmEwWglPDI/yu2xXoYZz0g6iRoqey+9M94wZ+bxYwW/GZp/dS
         kRIK1yPSO7cdrWcr50RI5DVrg+63Tdaul+K8V6o0KlpP+uiXMjkL3eK99Ar7N5Qn/A5K
         eksFQkvtfJPg+sy6CITy5QU5mHekgtK2tL/QKappeH7i44QCj9xNsmeBg+RZ/13w8F7Z
         t1kA==
X-Gm-Message-State: AOJu0YxgvTYuff4IVlVSxQtOusAZCmE3LebnIAdQ2DdVL7Td2B+j9qdu
	1HzKazboyQCF5b9aQZBVRvHEp9WOicxdivdrz3DVy71se33A7QicblTtTkXkSpDdeAWL9EoCgod
	0iNIEMs8e9pOBwGQPp/8WmSReanAUu/0C9GlmsF08BbeDcv2KxHRQnFeTYvHJ/xvEyO+33F3AQg
	hWe6EpECLjst4gsftkPMcZL9aYq/bW0u95IquQUFuuOA==
X-Gm-Gg: Acq92OFvMTq2GfvAmeSe60ITr8gVBGySn5sy7l6vkq2YL5ARsx+drIb/51ntZ9mzc2Q
	8Pv0moC3OAJQ+u2kSHQNXYSQlNS/S+jyb3n7KhgnODxR/9W8R/ZchR/t8aFdcVUJU1PW86OglEj
	O9vsCXbLZd3bUAHvxs8jTXEDdG61e29IaKHZepL8ARYC3U14kJPObpg6lSyPAD7uC05fhZtowM3
	yu+QwMwVRRUato5kOaDF40ciqJ9g1kpJ+mWrQd8SForikAwsM3Szij17GFCFu81S2SjtFXPz8we
	SkVONresbmsyV92M6laikT3v7rsiPo4gJzWSxcOtgv4E30pOpOv+N0OxVlVbV90B+NvNw3X/CAk
	Uf2NMoS6JbRncIbDBfyjF3N4VXb3GrVV2VUPt3eTrrWtIpf8spkpQRD0NSRyQIMalaFHh5L1be5
	9B
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr21832394f8f.27.1778258659326;
        Fri, 08 May 2026 09:44:19 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr21832302f8f.27.1778258658503;
        Fri, 08 May 2026 09:44:18 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454916df968sm5477523f8f.25.2026.05.08.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:44:17 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Yiqi Sun <sunyiqixm@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net 1/2] vsock/virtio: fix length and offset in tap skb for split packets
Date: Fri,  8 May 2026 18:44:10 +0200
Message-ID: <20260508164411.261440-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1F3784F98D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,linux.alibaba.com,kernel.org,meta.com,davemloft.net,lists.linux.dev,google.com,salutedevices.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-285930-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

virtio_transport_build_skb() builds a new skb to be delivered to the
vsockmon tap device. To build the new skb, it uses the original skb
data length as payload length, but as the comment notes, the original
packet stored in the skb may have been split in multiple packets, so we
need to use the length in the header, which is correctly updated before
the packet is delivered to the tap, and the offset for the data.

This was also similar to what we did before commit 71dc9ec9ac7d
("virtio/vsock: replace virtio_vsock_pkt with sk_buff") where we probably
missed something during the skb conversion.

Also update the comment above, which was left stale by the skb
conversion and still mentioned a buffer pointer that no longer exists.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b8014516f4f..a678d5d75704 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -166,12 +166,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	struct sk_buff *skb;
 	size_t payload_len;
 
-	/* A packet could be split to fit the RX buffer, so we can retrieve
-	 * the payload length from the header and the buffer pointer taking
-	 * care of the offset in the original packet.
+	/* A packet could be split to fit the RX buffer, so we use
+	 * the payload length from the header, which has been updated
+	 * by the sender to reflect the fragment size.
 	 */
 	pkt_hdr = virtio_vsock_hdr(pkt);
-	payload_len = pkt->len;
+	payload_len = le32_to_cpu(pkt_hdr->len);
 
 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
 			GFP_ATOMIC);
@@ -219,7 +219,8 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 
 			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
 		} else {
-			skb_put_data(skb, pkt->data, payload_len);
+			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
+				     payload_len);
 		}
 	}
 
-- 
2.54.0


