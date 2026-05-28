Return-Path: <netdev+bounces-292691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OBZCNBAGGrIhwgAu9opvQ
	(envelope-from <netdev+bounces-292691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:19:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C4D5F29BB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17E6B3040948
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B443F2109;
	Thu, 28 May 2026 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYmIINXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A623E63AA
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974333; cv=none; b=kQqZE0b6BSRgV08aqgKX1OL5+daeHz28vK4bdWhDyWUdDUkSVJ8TOdtGUGRnH7KhtNFHLAp/AkpXFF5gJ4EFmHinWXObTp85SFECr1R3HT6iMLPkqUvet3DRegkOb+GUJ+XIeHW2agxovxHpOh+zwdoUhLGMub1xq9JLGRzX6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974333; c=relaxed/simple;
	bh=zIvM24MXse+lon+ZHsE1rKlGq4W5y+fx8+rHjDMA/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBlbf+SclH9MUFa+Am9bB4Jcl3U0sFxVo87xAAWt4BUFabwep50UN1yat+AB6t7iZPsjoIDBL4TbeFHS9XCOKg/4h3k5EucaTZWlPnQezr0QIGG+kdppke2mz0GMN7GZhADF3rfuiiDnO3serEAv99g7/8LlcYptdZoopjNI0Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYmIINXd; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9618b8bdc51so1720393241.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779974330; x=1780579130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsL91HmF9kKGrU3q0nx9KAZTzS34MDYjzDPYUtVrxFw=;
        b=GYmIINXdYI2Now+oRqK2bUsapHGAA06bM9kvBCGW5y+BOjdK++6jDNwbQFdcWs7xwF
         qGUst1a+Q2vxlp4+1fiMgUdtbD1lakRERJgyWPDydRaaMkcmDBu1VUd3fgozy3oBoxP0
         WbJEXyYCrdcKhTXc8ZSb01H8LOo1j4xmNV6+DoFI9O/G06Y7XPZKWqUnSLMYFZxXCmbF
         i3BLH1dxVyl/6wiXbwlBz3nPyrKGG4zq97B/1sAC9BOdRGoHZDrcWoUcDU0NSQKvyzYZ
         QqWq4xBrmzresxOrAeXLSFMkCscMS5r77O+9AQ5PibuE6lfYYC59U4wjQ0ICnSjPP/xd
         YrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974330; x=1780579130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsL91HmF9kKGrU3q0nx9KAZTzS34MDYjzDPYUtVrxFw=;
        b=R3tn44v5zwdoHpH1jCRLnIhLY/+2FZ3UfP9/4qJuHIgtJkvHS6r7pdx4iyEF/g6ume
         QX0l/6hL8ACWjj8Cyo+TsU6FXqG/EdRCyBoatsIz9HOI4Jn8uf0bDaJA14wkditKyU4a
         uLaSVKXealRijLErF4G69OcZyMqZ7Lb/2Ee+Z6BAosK7vMDAOqKIgGcwHPIh0IcBfyg+
         WIFsbDmgEVzwnzNkCP5RAQB+GVMAnIH3H+5p2a/N/C+EGBsv3S9NWCEomllVNbO2+5X2
         n0J/I9ncZPconiYTP2fXL8qyaaOyjHqwF4MUI+qjBpGsh+DyQdBLrJDvMkiHKxGFOf5e
         ZYdg==
X-Forwarded-Encrypted: i=1; AFNElJ85WsK/ksy5uOjSprJljUddnIFGCe7gLbrM/6/y9xnRC4LBf/7ZecE69n9lOW0zUupTor8YQyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZ3mlTz8Ir4CQNgEEQncsKKwbWahFxAmFo41iMphAaTFBYAJ8
	+AoNHgzL8cxXzINlPGUQuivawXLkhHSCAdz1YIs1kyj7hQ7kcMBS1+SZ
X-Gm-Gg: Acq92OGmQQyAGLmOIygg48ednpMqM8W5CWXkwdFMOugQmg1FW+oI/MtzQqjMelo5A99
	f5GHVX0cvHbufgoOyyGsO3TiEenN70rVCvCwbTRbAust4u/s2JD6bS6o+eWvnTjgVhzYWIL1MEH
	g+x3a8PfoT5XIHP6H/ibiE/5PtpQk33Ll8S+SUMGjzOhTLIBCaCsuAd3GAZIszLh6msq9UEPp6y
	zrNcYxi8VEfivA+aBfXdIBuy1M1ATC/NT9C7eTG/ylKm/8ZT8eL5a5Ar/5qDNHQyX/+rv9kK1xM
	3S/PuIvsv0ArajACrPNX52DoAiuGhrAkV9LwQ9bmS90D+GBFdtr0PsrjMKkcva6Csq60iNIFdGv
	+SmSR59ajx9YRHtEAZOzM4gZq9LsFKDRDtr2naMMINjuAW7hkiGzhRtKnixho93OCNzj5tiLfBp
	R1wGP3hQR2CLOcOWRUPxCBUEl+uuZOoCkfMIhlNJ1jDBWPtBXUPLqyD2v4el474dXlGCb3eLIH5
	ug3KwXFH2RUiO87Npx3OSgknQ5Qzdvrm9azSb4=
X-Received: by 2002:a05:6122:289b:b0:56e:f071:d4ef with SMTP id 71dfb90a1353d-586608aba88mr12888889e0c.8.1779974329598;
        Thu, 28 May 2026 06:18:49 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-963909241d3sm1871940241.2.2026.05.28.06.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:18:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-28
Date: Thu, 28 May 2026 09:18:39 -0400
Message-ID: <20260528131839.462344-1-luiz.dentz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292691-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D6C4D5F29BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:

  Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-28

for you to fetch changes up to cdf88b35e06f1b385f7f6228060ae541d44fbb72:

  Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)

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

