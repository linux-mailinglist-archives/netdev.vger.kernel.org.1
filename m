Return-Path: <netdev+bounces-298452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VjBWNpOQK2o5/wMAu9opvQ
	(envelope-from <netdev+bounces-298452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:52:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3194D676A9A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 06:52:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qeWgIbdP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298452-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298452-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B34B63141E66
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC893955E3;
	Fri, 12 Jun 2026 04:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CE125A2BB
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:52:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239953; cv=none; b=JYH9QXzArT4564Yd9+oHR0WjbmgElkCvOti7nPaWqWFSyfE+sjMk8zHvoo/WzRjnjxTggAqb122uCpBlirEZMOSYyOPAIKYfD6ajhZepZXB135JZSR0+un0QDTEJN0wLrIzvRRIF4NFTs54AyJOXNUYq2M9fjHY9xaO7SCiugbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239953; c=relaxed/simple;
	bh=cbDh3+Ett4EFXrSYF+MJAdUmc1MZBb2RkAYnqpX/M8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cph8xcCj2W0zlzRp9bN+NDrq7Ra3jDinTT8DEtznQyCNmdR+yMY3CK3Wxm0MFZNDvq6XrtpfHRA8gI2rEtN8ptD2bnKOdz3Cn+ykXZ/MXIt4QL3sgHSJj6BzqxzOgFvl9yl8lg86XvwsYMiAlnEXqEtI4imLRVpl1NQhTCHtGRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qeWgIbdP; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c858961a8efso232494a12.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 21:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781239951; x=1781844751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oa0NGe5E4LAL8RcdBAbNfYk6ilQOe1pmPOc/Xo2zQts=;
        b=qeWgIbdPxp9oS7SKMxADfsydsDHkkVakiuUqws7QbNmPIVPHkMoyEYBA5B/je2p3C4
         ARyTZ/hFv8SJspTSwTeDB9uwrYXbuMOTvNue88HvDaZ1q6WpeLiampz1qFVIJJ7zn9Zd
         QycUBTRrFaXiuaRwPQFimycFmNWgxYZCnXHhb+KIVOUAvVzg/pBAVHHGVFDYejwx+Ulh
         mqH4PYsoQBmvDZVOaVvgWMYR73IC1vjO5xXa4Ts2ImC3JywPwfQxr5Ohg7B78sNz5hRp
         bo6owvjpR83EKdF3QstqijTGFyJNxYunls7SxGgv131tbxPfd6N7T1Ng6BI9Tx9a+Nu/
         reag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781239951; x=1781844751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oa0NGe5E4LAL8RcdBAbNfYk6ilQOe1pmPOc/Xo2zQts=;
        b=pDkmV9ny0vJGqgDrGdr5b+qUOQ8X39LbBLxkjwZuPuyrD33LR2eDjREY/DPtpveGu/
         E0yl5PQfvvquplh2gSbesayZYVPf1VpuRQ5t9ivmG4poPqbzdg2l4UtGUPpBiOXwwddH
         ysFaByMgGgdETNVqclnrfKqec4nEFq+yeAU/3mpC8GKWdbNHggMXkIld6du60jmukk+7
         Q5QernuXzvkZpTPnFsfrJ/is+ON3IQPWeCL4FwU0TE7CVWjad2HLuspJ9VanCkn9Nl6z
         yiM2mFHh2DCCucAQbluagPcYrrz425rAlVU8IVMLICeb5uNSAIcR1ZfdI1zYRa4yU0mz
         mj9A==
X-Gm-Message-State: AOJu0Yw1Xy9P1ZsNPeiIim4p8Si/0kfEkIVh/fa9We+npyYNh+uu/QJb
	VTDwHyfu6p0TIECy/7rhIe5cKBjbJObMEIshzidxxxtvNa17ePxgd3aqh8OqyXL8Dw==
X-Gm-Gg: Acq92OH023/POv66fi80S2SxhaqITWtNjoBhU5o82gxZ2EGoANHrenJkViqtKln0SCt
	krvrDC/4qSzVFA3TdTc/VUcfbh4zQrHC+KVgqfjBHDpupKbRAEYSBHJrVADgHocJF0Zj89eZgTN
	S7vOtvIx1IOUleUx+Dfr/cKA0vz+TiVyjg6hfyjUtgvn5kL+ucloYi/Kw05hOsThK1E9U6f0pq/
	FUilRnTi/f4OhA/X5f1IPtHMVo6oZBqdZXoJCwHnQmJLD7zalNp3lsleawjoWuK7IGK/n3moxhl
	kgEzjAqS7by93pSyVogpzNf09xBXGP582zzVRqzXb92e7DCjSl3wSa/kvEmy69y4lItg72ZhYFZ
	7cjMg2+HIodsjffy1yRbjb2CnwCM1HlBN0Zi7midG/6Z3na9UAp/HNYol0MbpiBtnJnrdnsevfj
	+DaJRn9Vu8Zy/fiTD+P7B0TsYlAh4mPFmEY1R36uJX/M4MepL106PQYrKzFQrnnZjqJJs=
X-Received: by 2002:a17:903:1acb:b0:2c2:245a:3364 with SMTP id d9443c01a7336-2c41217016cmr17829695ad.32.1781239951370;
        Thu, 11 Jun 2026 21:52:31 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5b207sm827558a12.5.2026.06.11.21.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:52:30 -0700 (PDT)
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
	leonardi@redhat.com,
	horms@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next v3 0/4] vsock: consolidate acceptq accounting into core helpers
Date: Fri, 12 Jun 2026 04:52:12 +0000
Message-ID: <20260612045216.105796-1-rafdog35@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298452-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:leonardi@redhat.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:rafdog35@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3194D676A9A

These patches follow up on commit c05fa14db43e
("vsock/vmci: fix sk_ack_backlog leak on failed handshake")
by consolidating sk_acceptq_added() and sk_acceptq_removed() into
the core vsock helpers so transports cannot forget them.

Changes since v2:
  - Add vsock_pending_to_accept() helper for the vmci pending->accept
    transition, avoiding a double sk_acceptq_added() (Stefano Garzarella)
  - Split into 4 patches for bisectability (Stefano Garzarella)
  - Fold sk_acceptq_added() into vsock_add_pending() as a separate patch

Link: https://lore.kernel.org/netdev/20260611021317.69362-1-rafdog35@gmail.com/

Raf Dickson (4):
  vsock: introduce vsock_pending_to_accept() helper
  vsock: fold sk_acceptq_added() into vsock_add_pending()
  vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
  vsock: fold sk_acceptq_removed() into vsock_remove_pending()

 include/net/af_vsock.h                  |  1 +
 net/vmw_vsock/af_vsock.c                | 14 +++++++++++++-
 net/vmw_vsock/hyperv_transport.c        |  1 -
 net/vmw_vsock/virtio_transport_common.c |  1 -
 net/vmw_vsock/vmci_transport.c          |  8 ++------
 5 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.54.0


