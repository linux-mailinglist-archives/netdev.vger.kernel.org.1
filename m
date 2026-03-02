Return-Path: <netdev+bounces-262560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IyuNsNPpWll8gUAu9opvQ
	(envelope-from <netdev+bounces-262560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:52:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E657B1D4F3F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83CAE300B9E6
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB16F38BF6E;
	Mon,  2 Mar 2026 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp9Obh7n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORYhLeps"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4E38B7D2
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441516; cv=none; b=USC9t5Q0u/RBOA6AFmVhaaN6KfcgH3QFGOHZi6qKSIOsPX5HIkcVGhPdamI99MVtC7GRIGx9CNh2QmVbqu/LZ5KiZyK2/OlnIhnao+OoNjL2rRUmcX/UCwWQDIQ2JkuB6MyxAm0SsV1SzDSux/XRMESDD6i/wuBLMELNWgtYRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441516; c=relaxed/simple;
	bh=ejoxH+LGsx0lf40D7kcEz2BR8ZKftH4l7JfUa0+NqoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ja6Wvlw53HQl57SCsZXmkttrxfUPL8YAi1UtWJ4Aiqtu8tQZz8HIZjbx8vQ3Src7M6/cJwnBmZTr5AXFSCRb3RgpHH1rTg3i2fWnyWKmmXxznuR25cEmjAeOS655qwWu5ku0FDLA8ouC/zZLjC4WFvImZ2iVQVI2/WLvU9ardAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bp9Obh7n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORYhLeps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772441514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Z9WT3KJPKaJS7kZ732QoTptenX1xk5GVKXR5OHJOtrk=;
	b=bp9Obh7nfrHbjYjVYv0f970o+ITLfuFKNDREhM4a2PiM4zMEC2sJWNn6/GDcV+Xx6GRPH6
	UY8mCi5PZoSYAG3TXEt6YqN1hId5G5ZvCfJ2BxesIN2OCWMQcoCc6LpV8UBpco1K4K8gUs
	anpl0QXLZmjlcWX13YpDl2konnofQt4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-yqH4aNoYOT-lleL3W0_31g-1; Mon, 02 Mar 2026 03:51:53 -0500
X-MC-Unique: yqH4aNoYOT-lleL3W0_31g-1
X-Mimecast-MFC-AGG-ID: yqH4aNoYOT-lleL3W0_31g_1772441512
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837b9913c9so29955325e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 00:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772441512; x=1773046312; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9WT3KJPKaJS7kZ732QoTptenX1xk5GVKXR5OHJOtrk=;
        b=ORYhLepsLZhmUY8NiCMWZzli7YpKTEQFZ+FYkAqOscemomwxu0+96eJBFtJ33Lx6Pn
         FCpj+u210l1JleaxCFb9u81b97+oy0nxuzjtOVPiSaqqVfXMWwx8ITWyWcx1Aj0P3Vzb
         wiWw2DD7TM2RCKA6oK1+ZYN3eMnaDSktzGuSlD1lSrJTmN5yPK+gf2KLu5HQ54NG6pxK
         8NNq/W6fA/13MBGOgRoybFqof3Rjx8g5GywwDnm96nvNWGmwVp1Q0XKdxEyShorz/rbx
         /ZAsqwAPlG1YqVWT6XeDttkH/6J54cTrsGAugvYuQUxmW03oCMv5NK6Xxll4jGM61DM8
         8nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441512; x=1773046312;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9WT3KJPKaJS7kZ732QoTptenX1xk5GVKXR5OHJOtrk=;
        b=J979vSOM7OIxlNbW20/3iJ2wFm3Hn0WBDTty3wsTPJUPygRdDo3waWAo8DPXhrj0rk
         weJHjfZ8524wPmuUMygSusX2XnUSV66tpfioot1Lpxb5QJXXj2Be6/uWB9C1LgC4UocN
         1vLrMPEeDB17InG/5oGbDxWCo6TZkzvxe0TT6gPXCv2WOgaLjNY3ygngWyp+ig9FSles
         gVqnFxLbjqY8iNkNbeqJxyAg/RlUFRHmvuYNiQ4mtFRyhhE+vldTBfkCF2kPXzwHRSjz
         05t1nOs/lW60FW3xv2Qziwu56I4jm/TMYmsBCH1+Pnzjgf5F1b5KR4PuEe2V2gEV8Zow
         fXFg==
X-Forwarded-Encrypted: i=1; AJvYcCUO/nUB5nb+KTXjplj+63dsYYaUrArxZqv80p28m66SkED8PKKJ6Ba6F0epcLgbtldf+k0XokA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TV8EQi0rcRPTBw6T9TZsB5KBb6EZfRVvvHG/wbAmKPrb77H2
	Mk9hcz2+q+S7FP9z+oyhJOrDZvasOgFh/LMiFe9BnU8OIIxrYpTMFfrOkenfZ4SxjLqm1H+d2fJ
	7PAtr1wTcOi7WJX0RHY05I3u15Fx8NKkWRq6b3pjGVjVG8/y3erJJcYTjdA==
X-Gm-Gg: ATEYQzxfNFxIR3pMdmqLjc+31kuq3ApPd5JVVjUnseByerRoVY7u9nusF6bkrl/holT
	MjubuRFodirdY73Jym6nnee6xi8Hw7+CvGEuW1MThXfb0nwu78W2Bc4O3fU2glEWouJ/jN1txp+
	Z9CSV9QZJW9OZ/N7CWoIeXI7Nx8oX0+QIAliQyBUOE1zU5ZkZqWm+eEgMr0SX8J195B8Gan4SD0
	PA0XTjWRSFaK9r11Wx/QPhzdgXjz5c0BBZFKxLwKHma8N7PfI6+5JPy78pbq8qKet+DyaDu/k5B
	IgW+/DzXff143bxmkE8ioifHiEkWQ9kybeLDIDXDwUtRMUxRtuEVo41J1E0CYl0pBxe5Tb3jRvP
	SKeOJNFIsdx1wFCtFyeUA8+xI/xpccXh6+cCULBJ5sLMM/A==
X-Received: by 2002:a05:600c:4fc8:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-483c9bedb07mr228267895e9.23.1772441512160;
        Mon, 02 Mar 2026 00:51:52 -0800 (PST)
X-Received: by 2002:a05:600c:4fc8:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-483c9bedb07mr228267415e9.23.1772441511572;
        Mon, 02 Mar 2026 00:51:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbd781sm233836855e9.8.2026.03.02.00.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:51:51 -0800 (PST)
Date: Mon, 2 Mar 2026 03:51:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ShuangYu <shuangyu@yunyoo.cc>, Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty ring
Message-ID: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262560-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E657B1D4F3F
X-Rspamd-Action: no action

vhost_get_avail_idx is supposed to report whether it has updated
vq->avail_idx. Instead, it returns whether all entries have been
consumed, which is usually the same. But not always - in
drivers/vhost/net.c and when mergeable buffers have been enabled, the
driver checks whether the combined entries are big enough to store an
incoming packet. If not, the driver re-enables notifications with
available entries still in the ring. The incorrect return value from
vhost_get_avail_idx propagates through vhost_enable_notify and causes
the host to livelock if the guest is not making progress, as vhost will
immediately disable notifications and retry using the available entries.

The obvious fix is to make vhost_get_avail_idx do what the comment
says it does and report whether new entries have been added.

Reported-by: ShuangYu <shuangyu@yunyoo.cc>
Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested, posting early to simplify testing for the reporter.

 drivers/vhost/vhost.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2f2c45d20883..db329a6f6145 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
 static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 {
 	__virtio16 idx;
+	u16 avail_idx;
 	int r;
 
 	r = vhost_get_avail(vq, idx, &vq->avail->idx);
@@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 	}
 
 	/* Check it isn't doing very strange thing with available indexes */
-	vq->avail_idx = vhost16_to_cpu(vq, idx);
-	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
+	avail_idx = vhost16_to_cpu(vq, idx);
+	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
 		vq_err(vq, "Invalid available index change from %u to %u",
-		       vq->last_avail_idx, vq->avail_idx);
+		       vq->last_avail_idx, avail_idx);
 		return -EINVAL;
 	}
 
 	/* We're done if there is nothing new */
-	if (vq->avail_idx == vq->last_avail_idx)
+	if (avail_idx == vq->avail_idx)
 		return 0;
 
+	vq->avail_idx = avail_idx;
+
 	/*
 	 * We updated vq->avail_idx so we need a memory barrier between
 	 * the index read above and the caller reading avail ring entries.
-- 
MST


