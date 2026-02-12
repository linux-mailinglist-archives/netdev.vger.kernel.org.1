Return-Path: <netdev+bounces-258508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDTXHWBAjmlTBQEAu9opvQ
	(envelope-from <netdev+bounces-258508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:04:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E92471311D9
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D704F305F6F7
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A6220F5C;
	Thu, 12 Feb 2026 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cJoK/Dji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B3F9D9
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930268; cv=none; b=eKEolMq5aNezaj3sOsdETIW4ZbCevhQlb0Y5U4NhUsYDF5/OB8AYWziABDDopnmNs4Y+ALRyKljpj/NJXFZ+A1ZNkUPJBT4MkAAnypUCDynR24muOaxl26DcAln4bCXdWR7CTLn25HHZzQgZCsrjrcmtdvnH/QZpZT9Pt2VFaqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930268; c=relaxed/simple;
	bh=fcsxawDDrMlRssNqYY8L3iuEy5x5ENnGuTQekf/hye8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMb4kemUEWE0k3d5TssnAlk3DSsMxjQSPlkbjdl0Y7arIVDKq9O2rv7pq/bbze1P6lsCCwKIjORdSsv3JjEcZMJkbDyO9IXLhAen5dNAR303wLK5FSSlCc0iVX89E8BOPeFwXs+OixmFuJII2QTZEVnZITgwgwc/JY98XCkOg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cJoK/Dji; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4807068eacbso1979725e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 13:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770930264; x=1771535064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sX4ZbsJoG8VdaNZW0CouV/hUaPw8SefLGWjtgBRc7xg=;
        b=cJoK/DjilhV1yP53QjQYufhCMnWoXiwXFDOYAf2WhXSVI3qUAKA2WZKispasMLM+gC
         fDq2gANf5b7DEEtCR/gDwtdGmIxLjKlx95MrDN3vTXBhRBu0YfBF8qXZBCTiHjx5qw24
         /RR14SMnLT11TzdgI+OP3JGiPscNXZOrfemNAcR5MqBnR7+mX9xOkAlju2TziO8d5Xr1
         dnY+NZbvWtN9d6ilmhQWVc7LJq16+x3Q/CdfN3gCqiLhvMJHuxVmxO46XjFesbXgoWW5
         RjSZceke4/c8ekWOJvUZTmKCwOzxal1AA4XX5er3EjX9mrVjhih6Luy93Aws+UDmMtIk
         Wh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770930264; x=1771535064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX4ZbsJoG8VdaNZW0CouV/hUaPw8SefLGWjtgBRc7xg=;
        b=XeJfMTl7wVHUhp0gmeA11Xene5j/LSohjj7bPVnALRUCij0mXAl48UmYuH/CTBnsAy
         Pm4S2AIp18sKG9AdTku4kx1ikU3yIPHAnRjR2x/7rTYmpWmt1vgrqT4kUfy6x4OZRgGq
         7QyS4Nj0tPoiltGyFG6PygO4tFN+SW9IVcXEpsb/VzcbA/weSNVapP/nXhD5Dw3yAKuO
         oMIpIyxEXHHzxJzxjVtUIydJboDU2+6ag+rW8COfQqliNM6rFbsV3ykkIJACyy6FiKzr
         6125NzwCpFPQU17W99TnTjrj+aCCCmit4TDLBlAWuCI8d/FKBA1IYtEW9kYF4N1dRziC
         lg6Q==
X-Gm-Message-State: AOJu0YybtOhniwdTHb+VovH0vTyitCqWNhONzVHLb7zueA4LLwL1hdp4
	Z5BCJXyg+LrbghLMpJxFfpQpehQybAoXlzfFqrldOf7R2PGBSHTGAbHVTAVo8h7kTxTZnjakvYv
	VyGlgQv7roFukM1bLz6DJGBiXH111kLcUvGT9pXURIWcUkuL8bQTJVVeL3bRLE8/F
X-Gm-Gg: AZuq6aIeiZC/DTBWj/PWoCD1xqW7Uataug9R7cHpdHvqFpermek0v+XP9aevEiVu8mz
	bSwYbf8IW6crGRdPVEPFtPcquuNH5s38VQoNZhM6XefIW8O+59Bq4Mud6SjOr4OKd329Y4JP0NF
	ASGSIdcJi9fu6vMjc9ge3NOwOI3tA5gS2Sv8SsHn0fe8GX2gypQ88h4cEOX/jlm/8nYk0hWJc/z
	bizZa7AkVUeYPKFiQ5idx69gs2fqQUuU03Z+HVEcg/ibM2v3FnTZSsRf1TWtBD2YWyioWHO1o5X
	1NIYSIIhGwcey7nY0QHxoyivYAz/IrnhOjZTi0Zn1dZ5h9AJmDlm2TZRbcSakOGublNnW+XQmmO
	7jc2DzBuC/umusoRS1ZEKwkvwfpSkEP+f7zdW95Lts3wnjCli0MXXI9HKeFEdJN2N5KdAGnp5by
	54kRd1OGdCDEhvTxGQnNYBVp0oIg+pGznR5aHm
X-Received: by 2002:a05:600c:a00c:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-4837103832fmr8143775e9.24.1770930264370;
        Thu, 12 Feb 2026 13:04:24 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:af2a:8088:67a4:6046])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483719b8e71sm5170925e9.2.2026.02.12.13.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:04:23 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 0/3] pull request: ovpn for net 2026-02-12
Date: Thu, 12 Feb 2026 22:03:26 +0100
Message-ID: <20260212210340.11260-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258508-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Queue-Id: E92471311D9
X-Rspamd-Action: no action

Hi netdev-team,

In this batch you can three fixes:

1) ensure that sk_user_data is set before configuring socket callbacks.
This way we avoid dropping early packets received by the CB when the
ovpn data is not yet configured.

2) fix use-after-free in ovpn_net_xmit by not blindly assuming that the
first skb segment will always be valid. It may actually be released by
skb_share_check.

3) properly increase TX stats, by counting bytes of all segments that
have been properly processed, instead of just counting the first segment
only.

Please pull or let me know of any issue!

Thanks a lot.
Antonio,

The following changes since commit bf9cf80cab81e39701861a42877a28295ade266f:

  net: macb: Fix tx/rx malfunction after phy link down and up (2026-02-11 13:13:41 +0100)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260212

for you to fetch changes up to b660b13d4c6379ca6360f24aaef8c5807fefd237:

  ovpn: fix VPN TX bytes counting (2026-02-12 15:28:59 +0100)

----------------------------------------------------------------
This batch includes the following fixes:
* set sk_user_data before installing callbacks, to avoid dropping early
  packets
* fix use-after-free in ovpn_net_xmit when accessing shared skbs that
  got released
* fix TX bytes stats by adding-up every positively processed GSO
  segment

----------------------------------------------------------------
Ralf Lici (3):
      ovpn: set sk_user_data before overriding callbacks
      ovpn: fix possible use-after-free in ovpn_net_xmit
      ovpn: fix VPN TX bytes counting

 drivers/net/ovpn/io.c     | 55 +++++++++++++++++++++++++++++------------------
 drivers/net/ovpn/socket.c | 39 +++++++++++++++++----------------
 drivers/net/ovpn/tcp.c    |  9 ++++++--
 drivers/net/ovpn/udp.c    |  1 +
 4 files changed, 63 insertions(+), 41 deletions(-)

