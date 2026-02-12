Return-Path: <netdev+bounces-258393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TPGGEoEmjWlOzgAAu9opvQ
	(envelope-from <netdev+bounces-258393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:01:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E88B128BE6
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 02:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2400330A92FC
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 01:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BE81547EE;
	Thu, 12 Feb 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLiqsZFx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C733EC
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858110; cv=none; b=o17ubE4bv/Pj+Q7AwC713NvKL0SQX8wu+L5rsq33i3vSIC2hPvJvL9S2JUgRDW6NqixKZxMpgJui+iSIp06xfWVVuR87RRKaRbTZnBUn9gsN6e3Vzq+rHRQTcJeAP4JETULCh4Y3NmV4Gv23l2Bgsfkp+JHwOWQ3N4oD/XFzaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858110; c=relaxed/simple;
	bh=NNigq33vVJIbcoGBYh+URUoEg1c2javLVb9mFublwzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fUGq/mcS7MW8QTQGsKwQxNoYlUDguUF7++xYkTH7rFyKlZr1SEnnGcbbHeej37ddYRLWIMJtX4SriW9MFaps3ZnbDfs0KCL1DUFuappLvVONQWLzylh8du5LaEyWb/B7Steqko8gfU1Jj9NltvIqdP8jaausfSh5jx6DfGmEAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLiqsZFx; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-649db2b6cdcso5519817d50.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770858108; x=1771462908; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LHpONSdJI596ZCuRsuiRBi+ORL1P4Wx9UbBWVB59mE=;
        b=GLiqsZFxx9x/nv0aHRNYK/wic7FNHwBcyOnUOzjEzoo8fRPmKK9mE75mzxhV86SWXJ
         xQ+AKAyVQqmdnPddcIC8GaCbsVBQEKw7tr7A0ei/3qfmfWw5XeUVmrrBjyJr5fz9Tzpm
         HrQpjRDccZUCIrmPTWWgv2OJp33mqaJwjolS/dW57eVTM1eD6U+EkkAsnnV9159Mj5tQ
         /S5bjpDQ8J+TQKB2ifdnOP2lAyywfdO7ZXQC8cCW/wu9k1HDkmyqjMISOGJbaR1AQw2+
         xAhX0LSQAdNWNbbsnwEidqZXd8v+3cjQ0NG2wydDRuQ+gymbGgOu4WTvBn4oeh7DgfM2
         va4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770858108; x=1771462908;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LHpONSdJI596ZCuRsuiRBi+ORL1P4Wx9UbBWVB59mE=;
        b=Z/L/G+H3t6qqSJdnpUL0MUMPnDhTFSxgA7yLZbiocy/rSPboNwAVPaFKkjDubC/OC4
         FzS7EypldflNuWEJ8Eliv//lW3fyQg7YOPT14PcFEaauWUEjbQraVotovBZvPjobjGM2
         JVm1ahKgDuRy1j4IqeIgBGgdX+7TK8Z+RFbtfv72t9LsI55UluKRIPiMh56Nn07Jtt7T
         d8YiSYrju4+mH07AZIRqfLkd33NPQ5jJLh6mlhBQfUc0F3lCq9Ct67jb/Siu8TqC+Uf8
         A6KV80YkPZJNnML1+UuSU4eCkMU6hRg2xvJdpf0Q2kU/5bgxXFhZgx4B35UvG5G6D0NX
         kooA==
X-Gm-Message-State: AOJu0YzSamVG7TRdZrrFw1OQRsbvN1V63IYfSRxUxBj7OulkqjMmaDfo
	e9W9hA6lNCWxLnBecsD9XPQHMum7hnIVgYRzqlRnjmaR/6w42A4mkq2n
X-Gm-Gg: AZuq6aJZXnCtmne5A8uI7D6k3A1/Q9wzAYKYOoNkLoyntkRB12DWXHj0PMXKUsKu7s7
	Ni+HERR1rY6H9F81vVqjtFbRBbxHQErmICxPBIv+PZrkl3Ja0gySGx9T7OfmULcwuB7Z1vT9FPK
	7O7lWoc01VC7ab5ryudlZAykvWB8lwX8PD/WIN1AUuz1yC0kd3PfAzA/iFnpqLcojIGGyE92dpo
	Z3khApe9D4hc+sdgU/Mw5e9ME7j/7S0W4zVbjZdWxT1HJXzJN8/NT6yJ7HJgd09x8Jm8WTWWxTU
	MnUrdkjp4JkOk0MSIizewZthYNTJ5rLcw+ydUOzy6BVwP4uzyctSOMLKaSlMwruVW7rW6s7ayfB
	4Y7DHn0ZhvUtjcbmaeDJcjIrHlJGOw3C9v3mTDPegohNUxy4NhtqGN0ier0MkUNQGAkYD7oxv9M
	pNNH+S9t6IzOWUtsSmM3mXXw==
X-Received: by 2002:a05:690e:18f:b0:64a:d605:dbd0 with SMTP id 956f58d0204a3-64bbab62feemr790973d50.92.1770858107959;
        Wed, 11 Feb 2026 17:01:47 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc83ff82sm3573234d50.2.2026.02.11.17.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:01:47 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net 0/4] eth: fbnic: fix and improve header/data split
 configuration
Date: Wed, 11 Feb 2026 17:00:40 -0800
Message-Id: <20260211-fbnic-tcp-hds-fixes-v1-0-55d050e6f606@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADkmjWkC/x3JQQqEMAwF0KuEvzZgq4j2KoOLtkbNpiONyIB49
 wHf9t0wqSqGQDeqXGr6LQjkGkLeY9mEdUEg+NYPrXeO11Q085kP3hfjVX9iLN3o+inGFNOIhnB
 UeQOBPihyYn6eP5gCKWZqAAAA
X-Change-ID: 20260211-fbnic-tcp-hds-fixes-e38149aabab8
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258393-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 8E88B128BE6
X-Rspamd-Action: no action

This series fixes TCP HDS configuration in the fbnic driver and adds a
devmem selftest for the intended behavior.

The issues fixed include setting the correct CSR for EN_HDR_SPLIT,
adjusting the hds threshold clamp to avoid long headers overflowing into
the payload page, and configuring the device to use L4/L3/L2 header
boundaries when present by programming the DMA hint bit unconditionally
for all steering rule types.

Prior to these fixes, small payloads fail devmem.check_rx_hds().

Testing:

IFC0=enp1s0
IFC1=eth0

export REMOTE_TYPE=netns
export REMOTE_ARGS=ns-remote
export NETIF=$IFC0
export LOCAL_V4=192.0.3.1
export REMOTE_V4=192.0.3.2
sysctl -w net.ipv6.conf.$IFC0.keep_addr_on_down=1

./tools/testing/selftests/drivers/net/hw/devmem.py

TAP version 13
1..4
ok 1 devmem.check_rx
ok 2 devmem.check_tx
ok 3 devmem.check_tx_chunks
ok 4 devmem.check_rx_hds

To: Alexander Duyck <alexanderduyck@fb.com>
To: Jakub Kicinski <kuba@kernel.org>
To: kernel-team@meta.com
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Paolo Abeni <pabeni@redhat.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (4):
      eth: fbnic: set FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT on RDE_CTL0
      eth: fbnic: increase FBNIC_HDR_BYTES_MIN from 128 to 256 bytes
      eth: fbnic: set DMA_HINT_L4 for all flows
      selftests: drv-net: add HDS payload sweep test for devmem TCP

 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c   |  3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c       |  5 ++---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c      | 25 +++++++++++++----------
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h      |  2 +-
 tools/testing/selftests/drivers/net/hw/devmem.py  | 19 ++++++++++++++++-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 11 +++++++++-
 6 files changed, 48 insertions(+), 17 deletions(-)
---
base-commit: bf9cf80cab81e39701861a42877a28295ade266f
change-id: 20260211-fbnic-tcp-hds-fixes-e38149aabab8

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


