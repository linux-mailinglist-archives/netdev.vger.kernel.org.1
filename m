Return-Path: <netdev+bounces-292451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGJuFoVeF2qpCggAu9opvQ
	(envelope-from <netdev+bounces-292451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:13:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D296C5EA5CE
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24AC308DF38
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB3D3C585B;
	Wed, 27 May 2026 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCqmunMg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE643C583B
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916377; cv=none; b=GibBENrF0qQJUKiYyCD3hZmUDWVN7vL4v77mmSwLucaTkmnofdesJGpA6+DZJ8oLVRx+tJU1prbfiIw3Qyjya1FeWSLCdpLGqEIMJOJ+DajQC3vwCl9YLkbj7sqld1TxIpU6xRSAX9nsfc5YcPBIAaosl/WJ318YDNHnefr6kco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916377; c=relaxed/simple;
	bh=TKx75lfRzQwMpPduPdt8DhlbT+gkRwHbPfqxMVyUC7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE9/McXQuzFg1s6dcTz5YC4ViAhCZ1yzl6cCZQgW3vVxhofoMteAcZfiACjkR1R+C1uce5JSWWhLaFdT7DPriNeFguqe9fcJgKfw4cSuZfNysW0YxKEekEKSQE6of0M5aeQF0h42u01s7iL7CN9qJyfJumP3yRtrXsI2frZb9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCqmunMg; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-96387efc30aso481511241.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779916374; x=1780521174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyDzNPQ5trU74hgcl42/wUnjfkx6JjWoigwqCMHOUnE=;
        b=eCqmunMgsI7clBi5UABnSHS9GVz5y6GoHfkBEGn/z0gsWNYuCUyxiLbzauO6B63n8h
         +OFl8+eykFgjstdfeA99bq+iJj1KrJvsWy+OJrWPAnyYh1yssICd/58mrBMRf3DJIU56
         UFHB+n6Dvp9L4ZDKylg4zA+I3XisgVeeWiBeErezsLmCshOiRxfX/+VpI+8113/9qgVY
         EzfzR9rFz1JwAkQ/4wHzZiZ3yyGTPEujRir+AURHsDULJED4OGQG0DJCQjv9ph/wBz2M
         LoKyhD5VlBrehQq2X5xUsQoJ23ZVUYB8tZBFEhJBRP33f59BGGJlIwQvtTAmvKKpaHSm
         vyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779916374; x=1780521174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyDzNPQ5trU74hgcl42/wUnjfkx6JjWoigwqCMHOUnE=;
        b=C5lVoEobMlA3wtqsBK2ng5iBoHdfwXXkwsWFZaN5Z3wTJJ9w5hMAQTMWzcFJO+heLM
         XJRI3dmOgB0UXLsLBeag4dIYDO+6mVgD3cR1V+CV5aerimybY9uDTaYyVVHDh5aJACOz
         9fsWJbVGX3pZPTYm5sqHahVfiQWCf1dFK1Ov1jF3vF8pJPKap3OqEYCznqovSvCFTMZf
         eiew3pt6HCZgDjg4pZz410u6rnHtbhWY5kIH0BibeAHspKMfyRcm3wVOdxUKRW7qnt1Q
         L8zENlRz7W6pr6B+PREZ4MCXIDIDOvtJg9xs3z7aWQAJR2Mvzj2ail/i7fqMwTGYPQhB
         xLAA==
X-Forwarded-Encrypted: i=1; AFNElJ+KqiW3DbcOyvyXV7b7WTpA/EPkOLWKghJGbQwVMrL5k3PfjEMn5AHUOOnZ3OdKfLrFxahLd4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdieX+jXwxhDCmUBOloY7nYOPYcSJ6LzpzXTQQERhO0s67uYo
	QI8R2UGx7KBNtKRaubkOK+MbR6SoEUU44dnVr8l8pgRrGtzd1qDKuEdmb7IaGw==
X-Gm-Gg: Acq92OGlotnFyuAABL7dg7xxR4+yee6sRejUMua36MGk7LfMCR/jDbTAxNwwOQii1Ue
	ZzQqLHV0QKH/ztdYNbyOkuXA9042X2QjBv21lG8gP2m6yL4GQoDFZL6tO0KgkDvQrezUAmrMxZQ
	NR8P2EgBeDAJQsj8c6+Y/bwQyrKrknQTSV8XZZMwNhYcFw4pFWVb7x3TVGqhsavU26/o5iIpIp7
	v99y7SUfcXc40Tx2cTMyug/vfAOXWEr8cwg/+DYXv3NHhsN4J3jXRHcakxC2w2/kXQ/1rh6CRNH
	yE2WRnf1+HL6NNrvVBkVp5TvFXmdUK9Pb0ilSr5rZ1HfCRvr6+/6Hh95aE8EyTMszL608ivbV/o
	MPAPEZXAdAOs4ZZcTsEoLJ+U/SEB09E9XxhwWdq0eH9LXw5nfcL5RMjGUCLbBYAnmDYJK2Z5yB7
	OSxOZ9M/zu4dbTzqY/mQjiyEBzvh6IXNXGipkwPmmUiBQD7PSYN4gopipZCF+Z3ewhG3yxU3UeP
	OWnmM03w90WN8yPLdprykkwHWl3
X-Received: by 2002:a05:6102:5e88:b0:631:8665:350c with SMTP id ada2fe7eead31-67c8a823e5fmr12979477137.25.1779916374516;
        Wed, 27 May 2026 14:12:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-961737bc13fsm18631182241.3.2026.05.27.14.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 14:12:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-27
Date: Wed, 27 May 2026 17:12:46 -0400
Message-ID: <20260527211246.371451-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-292451-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D296C5EA5CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:

  Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-27

for you to fetch changes up to df35e8e0c8c4160c881bb673e3c7ee010824fbd5:

  Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-27 16:44:02 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_core: Rework hci_dev_do_reset() to use hci_sync functions
 - hci_conn: Fix memory leak in hci_le_big_terminate()
 - hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
 - hci_sync: Reset device counters in hci_dev_close_sync()
 - hci_sync: fix UAF in hci_le_create_cis_sync
 - L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
 - L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
 - L2CAP: use chan timer to close channels in cleanup_listen()
 - L2CAP: clear chan->ident on ECRED reconfiguration success
 - ISO: fix UAF in iso_recv_frame
 - ISO: serialize iso_sock_clear_timer with socket lock
 - HIDP: fix missing length checks in hidp_input_report()
 - 6lowpan: check skb_clone() return value in send_mcast_pkt()
 - btusb: Allow firmware re-download when version matches
 - hci_qca: Use 100 ms SSR delay for rampatch and NVM loading

----------------------------------------------------------------
Doruk Tan Ozturk (1):
      Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync

Heitor Alves de Siqueira (3):
      Bluetooth: hci_core: Rework hci_dev_do_reset() to use hci_sync functions
      Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
      Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync()

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp

Muhammad Bilal (3):
      Bluetooth: HIDP: fix missing length checks in hidp_input_report()
      Bluetooth: ISO: fix UAF in iso_recv_frame
      Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock

Pavitra Jha (1):
      Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()

Shuai Zhang (2):
      Bluetooth: btusb: Allow firmware re-download when version matches
      Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch and NVM loading

Siwei Zhang (2):
      Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
      Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()

Zhao Dongdong (1):
      Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()

Zhenghang Xiao (1):
      Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success

 drivers/bluetooth/btusb.c   |  8 +++++++-
 drivers/bluetooth/hci_qca.c |  4 ++--
 net/bluetooth/6lowpan.c     |  2 ++
 net/bluetooth/hci_conn.c    |  4 +++-
 net/bluetooth/hci_core.c    | 43 +++----------------------------------------
 net/bluetooth/hci_sync.c    | 16 +++++++++++++++-
 net/bluetooth/hidp/core.c   | 23 ++++++++++++++++++-----
 net/bluetooth/iso.c         | 12 ++++++++----
 net/bluetooth/l2cap_core.c  | 41 +++++++++++++++++++++++++++++++++--------
 net/bluetooth/l2cap_sock.c  | 16 +++++++++-------
 10 files changed, 100 insertions(+), 69 deletions(-)

