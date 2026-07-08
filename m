Return-Path: <netdev+bounces-305757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E4WAMnEoTmoZEQIAu9opvQ
	(envelope-from <netdev+bounces-305757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:37:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CCC72466C
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 12:37:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NKWL9nLv;
	dkim=pass header.d=redhat.com header.s=google header.b=SEjAzWqw;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305757-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305757-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4722C301D32E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C5C414A05;
	Wed,  8 Jul 2026 10:29:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3C422526
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:29:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783506565; cv=none; b=tO5JLqyFLAW1Zdm3Pk9hunskaNUZ6MAl7nQI3S9qgFmp9J4rBbHkh/gxQUxhA8LH3CoYpgf8AWyG4MNz52aYk9R42ZmdqY8RtqAePp1VkCA+2QxbeI23is0qfMplM0FWDwMujOAo37sSGpGGRfwlopHJzclAb/UsBq6dPO77y/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783506565; c=relaxed/simple;
	bh=5P3Ch4NcxEeqmveBzaLX+zkEGpQ11ii8Z8OoJFfzhLA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dCCFpUWgsu0xJ+kDGWyfErvrSfatN0HdehxBInKtosmA1J5IcFrMwfoWIvKmraUGlEwwy71EvlnEcJNLkocDHEM9bxRmw+weEXhvL0cxpKKM0ipEPXPTPU2uixE5K1YWZye+q9dnfAcQkXJZHg4R8/hcET9mBA1BBhlxPRDwYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKWL9nLv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEjAzWqw; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783506553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VKbeenKshINiNwrwcYYrN7tTsXlZGXZFYsepVeLpk40=;
	b=NKWL9nLvY5HJGIze7tRblV46zn5vvjUs3vZn8OJEoB4iYOnt+fclcK9mS7N2W1rCAPhmEM
	IgUWnQ9GjSwgZzBdX8KjZGCI9fjGyfRg3uiwBkFxpWq7rJ5T7wXJB7/72Lph7iOn2S6G4a
	8ZlZUFXq62KWtkXPCcRuW6XSZldoNd4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-s8Wny_R0O7u7KEgigQIjMA-1; Wed, 08 Jul 2026 06:29:08 -0400
X-MC-Unique: s8Wny_R0O7u7KEgigQIjMA-1
X-Mimecast-MFC-AGG-ID: s8Wny_R0O7u7KEgigQIjMA_1783506548
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bf840a69so4278265e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783506547; x=1784111347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VKbeenKshINiNwrwcYYrN7tTsXlZGXZFYsepVeLpk40=;
        b=SEjAzWqwOK8G5rxOGN2R5pLijuYMcr/c+SEWjJ28pwAlI47Etd+lnCT2SxFZAPwgCX
         OOpatT43NToL3n7h3emdpEjjvLmniC+HuoNWIpzoU1SoZHdNLzmetYEM11pgmLcD0BGp
         pvsaIdBsJAUnHARNUqg1BOHttU2BP9lyXUBETGK3ISHXAfBEqHGl+LbmjdStPrnLnA+0
         vwiHVzi67TkhtRjdOd4AAg2Am0p8oYLvwTwUWD383X91fBn9/9sDQH8GzWPJ7jKacBXx
         /OQosDD7WSWYH+1/+gX/qwUHRh3VN8hdWOnG1n2Fem2RdPTZHZQuWvZ30SaQYFtKcuJZ
         I2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783506547; x=1784111347;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VKbeenKshINiNwrwcYYrN7tTsXlZGXZFYsepVeLpk40=;
        b=R0mWe0I3mZBY4ynz4gKZPgkwGsOsoSNzcS1FeLx1gJKZQrBHEpgvXmymFMXQs1J7tc
         RSE87Q8p9ALAthC+n9DjDwI+nWQ5A3PYGQAllnVmIFC3Ksc1kONXfEmin1D15nZhrG4g
         OFWNBMAImaVE7UWMhOvLsskQd3esmeyAdghEAiRIIfxornQnUeMGXVL7uGMQgsySurjY
         JH2QnGOXLIBQgLAhlz9kaSqBN7D/xrSBI44j0A4IgOvjMqfpKoT1Pcr2vjcQqFARDalE
         9byzTtlVK5Aks5uo2L/TYR2v/5IIpJXKFDAjLSstEdN+y4a3epZfxuN+UjTBztDLq6qJ
         DV9w==
X-Gm-Message-State: AOJu0YwwMUp2aQ50+7qHcjY1it6D23MfUYMUjF0umx6FzjfC2zotOrWx
	qqKLJklK/0CHr+xf3mQK9x0Hl2ri0w2APUhAXjyN9vAcNXtWVlEZtxbR8VYayIF5I960Uq9Ckkq
	qRZOO7cHz3Ej/lHcvZMMgMHJ3pvbM/wPxfw3omaAhJilAaP9H+EpCL3U/qB2UkCtaaPGbJVRcIi
	tQolU/DBaJp1e/J8p83BjgPR73ymcUzdbV+qPeO77R/g==
X-Gm-Gg: AfdE7clkH0QT8TRMC/bHqlT8SbCFqvPE95HkzuHVRHYULZPuGhO8RUCz4dPqz+6PUzu
	LxFL00JwBJQmeXlxO8Foewxra0H4hF4Jqt/E5+gJZwRQkZCe17QhkQFXLeT/KT2pWf/1csVbcQ1
	jP/twO451tW+yV2+A+si0j1kPJ3CWxtqKQRoFAd305cPxA+iaVSvQXwwBiGn4zjN/gk8FqG5oU1
	Buz2o/dlANL9hlgr4w4fGA/BnR3fIjlIJ4cD5K64GXCFhrkXN9CNOB/gquM2Uy1T9Iq2r8Zuor1
	Y4pLGvztueikRQ0cKZ5q+FSSAFnc37GBvU9uNqxwznp10TdLyNkODw2g35Ha5/lFOQSizo0lTLT
	YXvyv5VtZbqyG0SHECM/ijUimdf58oxx3+RhUXc3nOEn1o3s=
X-Received: by 2002:a05:600c:628e:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-493e68cfbbcmr20997275e9.17.1783506547644;
        Wed, 08 Jul 2026 03:29:07 -0700 (PDT)
X-Received: by 2002:a05:600c:628e:b0:492:6113:d4fc with SMTP id 5b1f17b1804b1-493e68cfbbcmr20996675e9.17.1783506547139;
        Wed, 08 Jul 2026 03:29:07 -0700 (PDT)
Received: from stex1 (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0ebf593sm135475255e9.0.2026.07.08.03.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:29:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH net v2 0/2] vsock/virtio: collapse receive queue under memory pressure
Date: Wed,  8 Jul 2026 12:29:02 +0200
Message-ID: <20260708102904.50732-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,linux.alibaba.com,google.com,kernel.org,davemloft.net,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-305757-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jasowangio@gmail.com,m:sgarzare@redhat.com,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:eperezma@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:kvm@vger.kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:kuba@kernel.org,m:jasowang@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33CCC72466C

This series contains a patch (the first one) that is part of work I'm
doing to improve the tracking of memory used by AF_VSOCK sockets.
The second patch is a test for our suite that highlights the issue.

Since Brien reported an issue with his environment (based on Linux 6.12.y)
related to the work I’m doing, I extracted this patch and tried to make it
as easy as possible to backport. Brien tested it by backporting it to
6.12.y, which now contains the backport of the 059b7dbd20a6
("vsock/virtio: fix potential unbounded skb queue").

This patch primarily fixes STREAM sockets, but also partially fixes
SEQPACKET (with the exception of EOMs, which are kept in separate skbs to
avoid overcomplicating the code).

The rest of the work, I feel, is more net-next material and still needs
some work to be completed.

Changelog
---------

v2:
- defined MAX_COLLAPSE_LEN macro instead of using a variable [Paolo]
- added a threshold to avoid walking all the queue while collapsing
  [Paolo]
- collapsed the queue before calling virtio_transport_inc_rx_pkt().
  While working on the threshold, I figured out that the check I was
  introducing can also be used to proactively trigger the collapse, so I
  moved the call to virtio_transport_collapse_rx_queue() before acquiring
  the rx_lock to have also a better diff to simplify backports
- improved code readability (removed `out` label, `keep` initialization,
  etc.) [Paolo + other small stuff]
- Brien kindly retested this version as well (thank you so much)

v1: https://lore.kernel.org/netdev/20260626134823.206676-1-sgarzare@redhat.com/

Thanks,
Stefano

Stefano Garzarella (2):
  vsock/virtio: collapse receive queue under memory pressure
  vsock/test: add test for small packets under pressure

 net/vmw_vsock/virtio_transport_common.c | 165 +++++++++++++++++++++++-
 tools/testing/vsock/vsock_test.c        |  87 +++++++++++++
 2 files changed, 251 insertions(+), 1 deletion(-)

-- 
2.55.0


