Return-Path: <netdev+bounces-288104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMl7OqlXBmqhiwIAu9opvQ
	(envelope-from <netdev+bounces-288104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:15:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4A4547B42
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 362C43015A5D
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A591F0E34;
	Thu, 14 May 2026 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BsiQELl8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B13F412A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778800551; cv=none; b=IJporBckeFUA+4vGDtWbUNbcD1lvJ8nIPE3YBiw83CumESu3xmOOPkfs7OVYV8anyeeHCqhd5fnOpfSZUWcYLYyt7SygdWpG/UCyCBgbaLcvFJ0wKOFRmbAR6sBZBU8IuELHoRAKheRsnCTM5tfX1Bzes8VHDF2xtPC4hWtvzj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778800551; c=relaxed/simple;
	bh=xuV7oMBwpQNICf7ypffjb3A6oSPDRmw6SqWhdxSYP6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+r5D37JtONs6QHfFm+K0J0jL8KPhQT1nS5BYYBR+iOqaA5IM5Jt1d35mH53P5N9JUshY+1rEcyBdbbAP1tgLIiLEAwwjEZW6ngk5t4fM+xa82H5QWo3PBBlNLb50fHYY1I7nAQ+aKJKaSKWix5EpikxDHUMQ7Jb2MlSSQpG3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BsiQELl8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so73859595e9.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 16:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778800547; x=1779405347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZKElj0kEL0YEHL3WJfdeYYaJhFprPYfcLNJbvBp48k=;
        b=BsiQELl8hfSQX3Hi6pYs1oscX1F+6GrPTA/VU9R/g5GOhDr1RXjUcyM59IfwJGF2oP
         Ovl2h2630d8CEmaPTa7yN4o1I0e+qcr5/9GSGddeM/RNaBNiKm/C7HmqpiaHiUCNGpMw
         xHOdZK9VAcqRG7uYY6Reg3r9T3MSkc9SmNYQRDzTLPt25GtXw1Wz8wZoGi9s+5xBPwgW
         zOHdp8qM2mABVBrq1IHMySVVuiDnguE/KSAMnv/clEsYeM51SY0XbLyk2Y4Ot4ENmsEU
         QyOVgEdyeBh8wqiHeLEtJqu1wHyWjE4ik23KG3j4k09HPKRWWP+IRuUE/4ECszXVvEnF
         TyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778800548; x=1779405348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZKElj0kEL0YEHL3WJfdeYYaJhFprPYfcLNJbvBp48k=;
        b=Mcvg6DUWWKspgB3THmKJmW13n5VE2kBc23WNsZiKBRWOFw+nP6eh1YpvIt6CS6jNQs
         AZF9VcGUMlb558dAXo/4j33ofYyWqQ/XpWAivNKBopWpetWa0Vh0Q7dYmCN8ZVZp54Q8
         lYajn19/TZp4woIkNQAxoMCYd5x1/ET8or4liEXQ7Cl5hBBTkZc/KbjDeAcsil2cWIiU
         irfHOvs/Y2jkkDiNKUjrRTFdF2smrSNicFDTUj+vmMfpjitRDhzJ9LTaXK0vumCgrvrM
         7W3kODhZO1l7hbKK71ATA46vAwD3+zcSC2387O7pDeZ4L96MiHLaJw/wByDxw1en/SUs
         oAIg==
X-Gm-Message-State: AOJu0YylbZJ6gAuokqWjoXv14MZOtKOzMUdTYQ8NBzuKbcNf0jxKh/7n
	+kdS98mqyBypTBSgkNB4hXOZa9QPf3bEdPonOo+n92lT5VgeeO835YdWBAlt7C7KSHKm4A+N9Kq
	3e2UTodVvAvPOfhBOlNb42T3E3Gs8a/5Nh1JI9JhBmc3CsKBYOEroMCBYFboZ6XBCO98=
X-Gm-Gg: Acq92OFgLQC7YNueuTg+TnscMekG1xlepQGAKahZhvUbYUOJTKioMjvRxtz7onx3vbO
	J+crZTvxprlDOlTLbi5E216z9oAGt1nXKh24tvGgTLmPPYgi2ikM81VQu78pBrgfrzrllsLbEoQ
	FOgQQJgT39d89xz+V2FsqNaTpyySDfg6mQ5bBV+CKjUmZwPsCYlsIImFnKZYd2x5YUxfHI/Ajyu
	St9l7ouwPO3b/4tBz4dcYhkkXFrz0s9RuMdOa/JqClp+UkSDlOMihEsb2ZNkchwA/TRy9VaWobJ
	FcOkdYmzx5RGWHmzmEk6Vsnt7dXF44wa0SNXNE/PNTH7BzQMkju4Lj/7CAvU+Gvlts5d5eGbBcH
	Nqz0mdeXrvCfqpybPKQfBFHv+L0X2JeJODI3CU5j1/iACe0dfv68Rzc+/Yw+jA/fq90DBSe9kwV
	3Yzss5ksPlNyNvu8jjr8T+6jZpvAkDrxLNaSYct8tJKLgzwA==
X-Received: by 2002:a05:600c:3506:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48fe60e13d1mr17435085e9.3.1778800547554;
        Thu, 14 May 2026 16:15:47 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:a628:d33e:601:ebb9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm39155855e9.1.2026.05.14.16.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 16:15:47 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 0/5] pull request: fixes for ovpn 2026-05-14
Date: Fri, 15 May 2026 01:15:39 +0200
Message-ID: <20260514231544.795993-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A4A4547B42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288104-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello netdev team,

This batch includes a few fixes for net. Specifically:

Patch 1 fixes the remaining of the selftests in order to avoid
TCP failures on slow kernels, where pings cannot be always
delivered on time.

Patch 2 fixes a RCU deref outside of the RCU read critical area.

Patch 3 fixes a potential UAF in case of a TCP peer that fails
to be added to the hash table, while being fully initialized.
In this scenario, potentially ongoing TCP socket syscalls would
attempt accessing a free'd peer.

Patch 4 fixes a race condition betwen interface teardown and a
new peer being added via netlink. The race condition would lead
to the "ghost peer" endlessly holding the netdev while the core
is waiting for it to be released.

Patch 5 fixes dev dstats updates by ensuring they are always
performed with BH disabled, to avoid concurrent updates on the
same CPU.

Please pull or let me know of any issue.

Thanks a lot,
	Antonio


The following changes since commit 93d809adc13001e9d3a3ceb8d1e60fae2fb740d6:

  Merge branch 'vsock-virtio-fix-vsockmon-tap-skb-construction' (2026-05-12 12:52:18 +0200)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260514

for you to fetch changes up to 0c0dddc07d272a8d25922e48041e8e4d2434df7e:

  ovpn: disable BHs when updating device stats (2026-05-15 00:43:55 +0200)

----------------------------------------------------------------
Included fixes:
* fix TCP selftest failures by reducing number of attempted pings
* fix RCU ptr deref outside of RCU read section
* fix UAF in case of TCP peer failed to be added to hashtable
* fix race condition between iface teardown and new peer being added
* ensure dstats are updated with BH disabled to avoid concurrency

----------------------------------------------------------------
Antonio Quartulli (1):
      ovpn: fix race between deleting interface and adding new peer

David Carlier (2):
      ovpn: tcp - use cached peer pointer in ovpn_tcp_close()
      ovpn: respect peer refcount in CMD_NEW_PEER error path

Ralf Lici (2):
      selftests: ovpn: reduce remaining ping flood counts
      ovpn: disable BHs when updating device stats

 drivers/net/ovpn/io.c                              | 12 +++++------
 drivers/net/ovpn/main.c                            | 12 ++---------
 drivers/net/ovpn/netlink.c                         |  8 +++++---
 drivers/net/ovpn/peer.c                            | 23 ++++++++++++++++++----
 drivers/net/ovpn/peer.h                            |  1 -
 drivers/net/ovpn/stats.h                           | 16 +++++++++++++++
 drivers/net/ovpn/tcp.c                             | 19 +++++++++++-------
 drivers/net/ovpn/udp.c                             |  2 +-
 .../selftests/net/ovpn/test-close-socket.sh        |  2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh      |  6 +++---
 tools/testing/selftests/net/ovpn/test.sh           |  4 ++--
 11 files changed, 67 insertions(+), 38 deletions(-)

