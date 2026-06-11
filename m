Return-Path: <netdev+bounces-297977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KHqeNMdgKmrKoQMAu9opvQ
	(envelope-from <netdev+bounces-297977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:16:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5612066F4E9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:16:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="mz4olM/Y";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297977-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297977-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7C131F406B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218233B6C14;
	Thu, 11 Jun 2026 07:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657443B47F0
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:13:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161987; cv=none; b=MRrXPHVmdpDvPn55VfVNwseW4Qy7ZgTZdHclU8+VKTUeeOvGQ5FjCbOWg8nwphl6MYEwYsjZnCXgy8tqcS5IlM1uU5abiuQTy4cGW4T/RC/ygy73/lQIQpwuCVMo3dQ/fKgjlpZSNaItVzzhCh3dSo7wCb+LvU+JU243tKVqG3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161987; c=relaxed/simple;
	bh=5Fmuk1WPgZ6FNiG4XsMRoLQLg665mOSxeBLCg1WHEJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDMvO/+1n5kDxbkfSrA6S7l+aVDIv7K9H6CengMUm65ToV7jalUAB5lK2fJdz+em/gPDXSPPQ4xe1Zm8A9j7WLaaBrXKeUxvSreLcwDZSxvKSnLtS/VInxH1jm8UkGyZRrlOAoc+L1U6OFkv2Aw4k4JsaTGR11/V6mA/ynAwrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz4olM/Y; arc=none smtp.client-ip=209.85.128.196
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7e8833c99fcso85356267b3.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161983; x=1781766783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RBX/SP+Br7VLRns9PD3V50R59mUWLcgOroTlWmFsbRo=;
        b=mz4olM/YfkHNqwH6OTFi9mfIi5e0Ovqa4xUXyuDtlrLB8Sf5RhW9tN48zAMPJ6+gDg
         k6iaiaUkc4ZkgisKao4QVy8f7qPMkOp7mZIuYk5fnsaZwOT052GmpNAnIyPqkiLRILDz
         9w6wEgnjuWvbsOvRrOkN0yNa0dvMEke2aAYF46HGnSwk1SLjys3RfUsyeyTrNGEhcZGh
         624lcj7vi3Ngyaqao308A+ay6k07jKiWOXMTZ1gGfqafAYGZsviI/D5qThS0p2IO7txq
         dGGWzHQflj61zuzj9QUru4x5TjtssUC7xpniURoAjauPkk26U8PEv0/OtXk3v0jfSHIM
         fi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161983; x=1781766783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBX/SP+Br7VLRns9PD3V50R59mUWLcgOroTlWmFsbRo=;
        b=N8KyO/7x4Z4ABw7zvYzKNMBCecd0uO9JKATGoJ4s3UEI+7P63/ty6Ik+iXT1aMQTm7
         CoEleZZYJigpY08b+I+shtGV8hVSmUlmriebTP71k5UdU/ArGtfwYZtiUm9iZKxNfXbo
         MV/0rzcx2hRoTpy9hMdUgApElC/lz0j3ZCv4m5rEa/Ssk6KyBxLehaLU20GVFOdD4fbn
         X7hqDHdI1TdgYpGgbjO7vRC/SWCiTuLA+YXj42Ma02jyLe+CMvuj1b0aleMXBIISD7Z/
         +qk5vyX7M8X3Lwh34Y3BuihuWIwldJezola6gQBbpW39DnGZgfcbUHFtcnpPnZUO3Tmr
         fkaw==
X-Forwarded-Encrypted: i=1; AFNElJ9DyQOf/KmBjmfcdRpON/dfKykZlr9if3HYvv+8XegN2UjxHGlIxPAbUZhJPhmBQ+N4f+XlKps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7LjYqzBsN37olS7nxeJuO8Sq+rBdAUiq3JF0S62YBLNQPxxz
	VC4JoNwUfCiCQBU7JFEPJBfXFiW7Nwg6QwAjMOheEYbnl5v4tpfNu0Z4
X-Gm-Gg: Acq92OGJ/lHu/eqfQV/Y6LfCUhcj9gXRMr5lche+3RDUm04IxDKzCFkHyDk/n8N7fjo
	pVabKtx0HSmZhrSnHu6mXaVH67picIlYlTLVfOs+9KjYYSRyU5pfLkafO5AtsZHyM45kHj9khSx
	oT1CwIfejfCd3feOZCjC4BysNclpYK3fQHArKRtZxuqYMwWr2P0mvOTvH7+6DvduYu6JZUJTCRt
	fpVPBJ0+oIRa0X6kNcLjTdBxzOieYL58yBbniIsjnFOmb9YQJiVuHpT2g/hmTucpQEC0//6s750
	PuFxUh8ZBvv7ivyisZripcua87CZjVKBU53JK7lf51krZAah2jUwqJLJpVrUA9b2V2Hk/AEY+tp
	F8ZOYU0qVK1TDMy8PmtrRyZ4Dv2rkNX4BdkOP+YkvqqJ+TOjuku0NK85wCU1bQT96MU4q8hAa9u
	hy5GnVGyw8TXFNViAKwBAWec7mVxrqvCgEs2cg/mzhhr6dSuFjmeg=
X-Received: by 2002:a05:690c:6c13:b0:7db:f8b1:cd80 with SMTP id 00721157ae682-7f654f04a6fmr17001257b3.2.1781161983511;
        Thu, 11 Jun 2026 00:13:03 -0700 (PDT)
Received: from localhost.localdomain ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f693504701sm2551487b3.15.2026.06.11.00.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:13:03 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: dongml2@chinatelecom.cn
To: jasowang@redhat.com
Cc: mst@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/3] xsk: support tx napi busy_poll
Date: Thu, 11 Jun 2026 15:12:39 +0800
Message-ID: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297977-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,intel.com,fomichev.me,iogearbox.net,gmail.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5612066F4E9

From: Menglong Dong <dongml2@chinatelecom.cn>

For now, we use sk_busy_loop() in __xsk_sendmsg() to send the data in tx
ring. The sk_busy_loop() will poll on the target NAPI. However, for the
nic driver that support the tx napi, such as virtio-net, it can't schedule
the tx NAPI, but only the rx NAPI. If we enable the busy_poll for xsk and
use virtio-net, we can't send data, as the rx NAPI in virtio-net doesn't
handle the packet sending.

Fix this by introduce the sk_tx_busy_loop(), which will poll on the tx
NAPI if available. To get the tx NAPI from the napi_id, we add the
"tx_napi" field to napi_struct, which is ugly :/

Another choice is to call virtnet_xsk_xmit() in virtnet_poll() too. But
this a little contradict the design of tx NAPI.

Menglong Dong (3):
  net: busy-poll: introduce sk_tx_busy_loop()
  virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
  xsk: replace sk_busy_loop with sk_tx_busy_loop in __xsk_sendmsg()

 drivers/net/virtio_net.c  |  1 +
 include/linux/netdevice.h |  1 +
 include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
 net/core/dev.c            | 23 +++++-----------------
 net/xdp/xsk.c             |  2 +-
 5 files changed, 46 insertions(+), 22 deletions(-)

-- 
2.54.0


