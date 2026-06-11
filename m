Return-Path: <netdev+bounces-297891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kepKMWcaKmpIiwMAu9opvQ
	(envelope-from <netdev+bounces-297891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:16:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3857A66DC9B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:16:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QbjYHXEP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297891-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297891-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEC26300F544
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA82DCC13;
	Thu, 11 Jun 2026 02:13:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3ED2F7EF5
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:13:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144021; cv=none; b=LkaDud6g/1x2pkIoC3A3TAaP1/HpTFCulVe4YgKVXWofgBH3HKUAKo4LjnuebfhTd8q/hj4VrQDhSdQX2uZGVUXN3HDYZFmexL3DHzZEKfegiCJ4nTB4Leen7GHZdxW85zE3M+Rh44RAWkPHUdbLTz3Vl1yuOZaXPKGVFRA/u84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144021; c=relaxed/simple;
	bh=QVnhuMzdUwNHmvsxo1WC+MtfAlAGVAzmGjI+6rh1pko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2IhPneKspY+A89XC2X9QOD5+rqnTyJJ9010BMZ/7SvEBUmJEZ+aUCliv8tV+6I7hz1/la/l0PMQ5cEuBixgmawku6WuobcMgkWt7rLZUayt6yyv8E15JhhJkxZHMCHYFR/CI71Yh4BIcYtRKZC6SlJ44s60UDq+Xup6lsjoA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbjYHXEP; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so5004451a91.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781144015; x=1781748815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GZGIg+TSBMH1y+DPOSnGtaBlpfe4SMWXOyP2aITu4mo=;
        b=QbjYHXEPBoPHc8V2XhthP+atEU3uh+Y7pQ5mjTKkLSexVVaw9soKcM0zYq89wBIySH
         sjIP7jA6r84ZCKQFAE44vYrzRLrUeSRmzSLUHDKHdnAb2GKMiRvC6W4j54xmG+dxNpoS
         Oo2W3zF6LtqfeGPmoZdKYu+YjYFs+wDSOkZXZAgOGcd34yzzpf03f2YVtpXG0KvKl0Ad
         yXSsd5GQT+0qcgpXMw1Cql5vxy62oS8E3sV8WEdzMSYhWhoY/BaJHgXR15ymCHG3enbK
         7K4iZcsPDr009Mp4kZqwUj9L+RefDBDAigN5GPbdASIJdHjwpF6KQHkyVLN17HKpMyp1
         bvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781144015; x=1781748815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZGIg+TSBMH1y+DPOSnGtaBlpfe4SMWXOyP2aITu4mo=;
        b=X41RutcEgidFgzwkMt5SBPtLyYIrYjx1/lDSkTNT16z0Oe/DnVBp/GtvSnby43LCd3
         m2RK3Xy/mKqRiGExhdeoAOWJxqOiZ1c0uEV/IY8WBfYbbvR9LPUOjl8KSrtLxD8zSzbC
         v/uXkV3O1+dPMcwS73DKgckNZVaQN089HS170VRswc0iw7SFCAyVudXObBwKH+7yfAAH
         LzryviIDPUB+MG2RGizqL0ANk/0u2j+j6+GD+9jIID+qC4nLVMGuXr1n+b70LYBP6MKh
         UXzbEwyqSew0yyosELmqiL5+emn95Q7bH8qqv4nwEt1qy9YDbHCYJ7Dlt/EFROr7rbGX
         zx4A==
X-Gm-Message-State: AOJu0YwUkJd6qwWX7EFd4ZJXEsLqfvSRLDf0sez0Jr+njXSXxtarL/zR
	Io3clKiTTcau5BzKPK7NsRkfLEqUKh6Fa9lZI0oTNyc7F002dMiaON/MjMTLM5s0+g==
X-Gm-Gg: Acq92OGB5I/EbSbC30UggVdJqnyXex8UtL4rqsDUa+AuBEw2PfhBKQjF21IQIsnae6V
	Erp3Q53nPXKDMuCqSz6rF3Cc7cpdk9/+hR+eY65eMSw+LkMOSzQImbMOtLXgnxsd7fVOtNRgEJu
	yMyHWo7GfKJWFlZrOTmlabZBAJ3O17AiXxSQgqHsRX2wZ/MYNKN8TPLx3b1J4BByxgA2XUKZGF9
	VFcRMZvljYDRUoDkgi/1+5PhnzJS4t8wUvQYcpP16J0GEpF4k8lxTkgMZ9LCjC7WwN1PDV6/5M9
	mx+eqixyntAavKa7vupuh7oGprpe+5tgk6Sgar3P1XkZy3qwonntpbipwjltcnFxapGHnCIaiaB
	2JN+vBcS3D8ikNqYYXd/0LV5N6vvtrNS46EEvkAdA+WyjbqVGaCR/4JLY9UeFT4w1+Q2KcYJehl
	kLn3svnTejjTNJftgEMWvLAM9diJvzv5kyJHGw9TCZjXqp/GJ6gs+LOkAC2Wj5WBGchF/CxpQlH
	erNCA==
X-Received: by 2002:a17:90b:390a:b0:36d:b818:f848 with SMTP id 98e67ed59e1d1-3779bade6f1mr972308a91.5.1781144015048;
        Wed, 10 Jun 2026 19:13:35 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-377522a0eb9sm732006a91.4.2026.06.10.19.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:13:34 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v2 0/2] vsock: fold acceptq accounting into core helpers
Date: Thu, 11 Jun 2026 02:13:15 +0000
Message-ID: <20260611021317.69362-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297891-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:rafdog35@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3857A66DC9B

These two patches follow up on commit c05fa14db43e
("vsock/vmci: fix sk_ack_backlog leak on failed handshake")
by folding sk_acceptq_added() and sk_acceptq_removed() into
vsock_enqueue_accept() and vsock_remove_pending() respectively,
as suggested by Paolo Abeni and Stefano Garzarella.

Changes since v1:
  - Keep sk_acceptq_added() explicit in vmci, where it pairs with
    vsock_add_pending() rather than vsock_enqueue_accept() (Bobby Eshleman)

Link: https://lore.kernel.org/netdev/20260610091121.213324-1-rafdog35@gmail.com/


Raf Dickson (2):
  vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
  vsock: fold sk_acceptq_removed() into vsock_remove_pending()

 net/vmw_vsock/af_vsock.c                | 4 ++--
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 net/vmw_vsock/vmci_transport.c          | 5 +----
 4 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.54.0


