Return-Path: <netdev+bounces-287524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC6kD29YBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:54:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C415531B19
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAEA03027B73
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEC33FA5D6;
	Wed, 13 May 2026 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQst75dz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO/B9P8K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63243F7A86
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669667; cv=none; b=VCC3IwFv4aRr1H7RTa224jXwuIMaojPGi3tohnzZ5lumExKaBTJukwyzLtJwy5Gg5v5+f6Lw4f02Bs10YHhglhnT3PxVS5OvvCnVz7/ETDuzz5VEuMScdug+TdJo+Ugn0JvHdd/KKl02abF+YEn7Vr6w3an70WXkvdkbQGaP90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669667; c=relaxed/simple;
	bh=7yTfwJVH7KQt1qPTBB2JpVv7SoanftpfAUK/i+v825o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IegSi0l5x/qsaYSLuOXjUZi30yA0Nw6xaBEgBcmfyI6HF/wRIzB3Ym5Fh6cMJcMW+A7kxo5EJawxwNPsXz5NuycAt6pA+AvNVrVMKkHvJ90/4qtCN4sAiBNQzg1S0mt3wUOIt0pBbiKtgZN81ED3TD3PTwvQBqNiGg8D/0N9kYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQst75dz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO/B9P8K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778669663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j46NWqxlvtt9B8j2CsxWNzaR6FQyGRn7VT2uSJN4uKw=;
	b=QQst75dzs1Xpr3SXNzKbfnnX+Pt4uZkNDIAIu9vLu3h4nkUBMMinifitViN+XnK8DSQXfN
	izei8/lIhfm4Zmu2pO0LneJ0E8x+vRvJHcQ3SSC+FnWQBD7bW12pb/TYlTZuIb6bL9Itot
	TkzXC8v6FONxXp93AJLvYoSw2muoNH0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-IBZkwcAdOQGxqHKUfp3ptA-1; Wed, 13 May 2026 06:54:22 -0400
X-MC-Unique: IBZkwcAdOQGxqHKUfp3ptA-1
X-Mimecast-MFC-AGG-ID: IBZkwcAdOQGxqHKUfp3ptA_1778669662
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so5260986f8f.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778669661; x=1779274461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j46NWqxlvtt9B8j2CsxWNzaR6FQyGRn7VT2uSJN4uKw=;
        b=CO/B9P8Kq9c0l9p86/CKNKCUxvMtSYhpyMKVNIS5ddb6rgidg1Te2NIhb0/V4TlnWo
         BtpDH625dKw1w1MIRHIQqnYEH1erPX2tplHI+4KIUIB6W7vA76NPW7d39PMibMrv1U2G
         Le3JBS9eeucbEJ549kQL4RMQPE8QOVYwZXoXVN26Ix37Rl5V4nt9x0MBnSfmkUFnVUoq
         ZSR0v+OUHZFULJaFeUv0BLTJol0z622anQeJzRLyDjyh0a/BpWnggQq19mEtOZhHBrDp
         mBaUxpH9dv39s8ceqTemU67b5h6pdCRrxv5J+1DxlyRzUMSHPY10qsjNj4qAs7/jWI1Q
         NzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669661; x=1779274461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j46NWqxlvtt9B8j2CsxWNzaR6FQyGRn7VT2uSJN4uKw=;
        b=f6DjlezUMoSw1DRL6ST9L7/fsQdFmGTKiLgx0qft6dlUbQMPN9f5NGNm6dXDfnnBLL
         Oub8Ddvu7jkz3KzWVynzvItx0d/yfs/nR9S9fcaXO1wKQaiFlpNPRtvc1EBArIX+r+VV
         PteFOP/+SYuq4ahoVXw8/zCbJfGpVUOcbkMsp9ZvYNIrxVP8Sa5Zvtl2vptmRJnCrJZv
         ckFNR73qgse+034Cicw5wpD2Zu10ZvqvWMf6pfw06OQWLrkacLcRDVh7UsRDZMumTSVg
         1YthMBO6QlrWnJyIHezWrG33mfOXoQDyQmJ6EinQX7p05C1yG9ycDMBeHCEh5ZUKs4D7
         VZaA==
X-Gm-Message-State: AOJu0Ywtj/JK99qVWg2EHsvEJ1G4Z3QVSE+Li951riBQNnKYn2UcGRbT
	UwxQUMdqR8YrRlPc6riM0uZU+p0H3UFA6vwRGohMQPpPdwBXPIn8YfecuEz9bjOPqFo5A3Q1Ixe
	XmfCMLqwIWRrHV8Jel6kaIaeoRO0Qyr72znuJDL4uGFWEgvZz2k71OwNwXKYEX+77/VSF1vUHvU
	jPOiuf5ClOaKWwU1gELq693W2AjW1xw2Jd/1/rY4mDUA==
X-Gm-Gg: Acq92OF8MtNtSI2rjFtELL6LJoAi/a7ePKt61vuk9OZsrmyUOKN0uFNK60ua9vFX3yl
	V/xjgIddWVa4vzhOeZCkSBCVn/jnTwxA9hBCppjtynWRLb7yYTMegsjJ3tKIpFr3ocDhy8snjmY
	7Oah3IYoBrR4y+Q7KRK4D6wFi0rUGGRTGQcrGmvKQGYYpnkEXiHeGrYTBlWS+pQQGtg1V2kmKuK
	zicrCsUxegHCmjUStjwpEXu7E5nwY9OWVK43FFJ19VNnXG2pzhYASmDtWl5QeOMjF20sZmn/tp0
	TUC0LNmKFwMZaQ6lBOb5x+NxlgpMsap2Y6bFbkZPN/DNsYMeyd4a9FBAZSYbjW3o2pf8IOszgiM
	nLPA0BeAE4BcXSCigl67stbRF//WIDRe5hDgmr5XY/MQDCCEaI8Az/S1Sioys
X-Received: by 2002:a05:6000:1a52:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-45d4c308261mr10970f8f.5.1778669660939;
        Wed, 13 May 2026 03:54:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1a52:b0:45d:4c30:81a6 with SMTP id ffacd0b85a97d-45d4c308261mr10918f8f.5.1778669660370;
        Wed, 13 May 2026 03:54:20 -0700 (PDT)
Received: from stex1 (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm41002672f8f.18.2026.05.13.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:54:19 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net v3 0/2] vsock/virtio: fix skb overhead accounting to preserve full buf_alloc
Date: Wed, 13 May 2026 12:54:15 +0200
Message-ID: <20260513105417.56761-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C415531B19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287524-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The code is exactly the same as in v2, but split into two patches as
Michael suggested in v2:
- Patch 1 resets the connection when we can no longer queue packets,
  this prevents silent data loss, and both peers are notified.
- Patch 2 increases the total budget to `buf_alloc * 2` for payload
  plus skb overhead similar to how SO_RCVBUF is doubled to reserve
  space for sk_buff metadata. This preserves the full buf_alloc for
  payload under normal operation, while still bounding the skb queue
  growth.

v3:
- Split in 2 patches [MST]

v2: https://lore.kernel.org/netdev/20260512080737.36787-1-sgarzare@redhat.com/
- Close the connection when we can no longer queue new packets instead
  of losing data.
- No longer announce the reduced buf_alloc to avoid violating the
  spec. [MST]

v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/

Stefano Garzarella (2):
  vsock/virtio: reset connection on receiving queue overflow
  vsock/virtio: fix skb overhead accounting to preserve full buf_alloc

 net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.54.0


