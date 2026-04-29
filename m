Return-Path: <netdev+bounces-282364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HmwECDz8WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:01:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC41E493D33
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56926301BF56
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD313F65F2;
	Wed, 29 Apr 2026 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YMCYWhi3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A23F2109
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464089; cv=none; b=F00i41iXFGO8C/L0b12YCuviIvKUfsXvT6TI3wXw2yZeUVd9qELFiXicUs9+uKk0gkziNT4D+lA3MvELsNPXNKiIXxrtmS+VDWC8KqnD28LdZiZbMKIOi+CfEjx20uuHGhn8jIRY9zgwYjOkrYKwKuk6jiB9v5Sujrj1Q/rprYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464089; c=relaxed/simple;
	bh=lUNAPk4yQkclSJEOeI2ulfThiq7TZh+ddWuhb1zsDY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkH2MeZdUXip5AZhUN4Az2bDh8nSp1m8v/dGSa7dp3zdD7oDNV54tTvCBt3/zVmH6vHNVRD0OmQgZbBRrBEeoTmcAsjwCqyirWSELfNMpl/XOQIoNcgM3j45HDrdkAKb8OUDKUwLG9fIfzDF03L16TSry5LFeJaNrF2V/waOW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YMCYWhi3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso176159595e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1777464086; x=1778068886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wThRNerM4oEpmv0fZoVDUfoPDZ6kFbew/z/s2+6g8TE=;
        b=YMCYWhi3xHxIXz8URH/cEjKx8YotLJ+mqENzfzXqZlibkeHmRbdKylU49Hh58CLh5i
         2JFZFOsYB8NFgXMB55JgtUf211A7ZFffQzx6k2NLgO8wLvvr23z9HtdRlUw1xWmpAFI/
         R116ONLvc/o0D1LSAjR0RUJmELClSNRcdSaN1ek1gk3jERvFLl1ELEbvV2/S1pka406E
         Nx4Bvw4rQ4JDY6beW7Z2LBFc2XPFuj07zKEBMAxRS6ySOPkKmzDRvvgMtckb+1GxxYI8
         9Ttf+ictpth9oM0aBq5/3eYtx91xgFpmtFXHrXARIXrTk4K5Nx4N3lgKTu28Cm68YcDQ
         PPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777464086; x=1778068886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wThRNerM4oEpmv0fZoVDUfoPDZ6kFbew/z/s2+6g8TE=;
        b=irPbiOz3G+UQNNYFtzn0D2Db50iTndq5N13muFVMtdFTO7jptC6SD9wVn4N2M6Ndy2
         OLk6SsZh4WpzpkeIM4BoY5MZL6wbtb5Nl/xLawkA9hYKTxMjcw7u9B7TpqcmEsR4UL5S
         SoN2N+Z7SiIfExEBQRTol3XxvSlFal/QwdkkDHZh0LreJ1tGx+a1j7OY38J5Gp+j6B2Z
         IxkdMTmqM2vc2qY36srcifpTwLp4hqdtw1xW2/j022slXG7Wzxnwswm/mMOAlHXs2j0F
         a2zDSxpH6K6Cbj/ipsu0Q2EqUjUj1aUpdOyyuTldyQnea3um26yzj6ZvcBJD0SLozWDR
         VC/A==
X-Gm-Message-State: AOJu0YzPj9IwuJlIVipmYYxFUM/k39HQtzzBRV+p4YssSaBjdWioAd0Y
	x0iHVtdrr4LcHtTYPXHei5zEdpfkObvBGz4ik38qJs0zEdBOMxcWW0CujjIKEL2LEAfNmFu38kp
	ZsOtVRI46xZSLl1kN7xzc2gyxBtdyGuCk/B3Oy8HS7XoETn0ZFZtG389kFHLmj2P0BeA=
X-Gm-Gg: AeBDietYPmwGk1QJiqcSIAosSohd2/0ozoReDP15cxtWs7lb2umvh8vqTGbzFYyhMCI
	q+Z0RVxFfiQ7N8rmXX1Ws2HFSSlnOI7s7dS0Ek8RStqzPY2mMVqFmwacAFjTGkqcUyeAslUD+KQ
	Suk3e9S8W1KWRhIQWYEqYr6sUhbrxA5uuVlJb8dpFzwrh+RDpo6CPgWt73flZOvPkx/ujzzbXC3
	4byENtqXp2Fz8kBeQsHGs+/vPd65kMuPusyhRR9f8UETgWMRgCGPEhORhGqE+Kgq9XGUtxThwxV
	wfHTxdR96WMrnEgRNdXPM2uejpOIRSDEiFElJheoQY63F6my90RJKEdUQOcgeyURiQiwAJHeMAl
	b9fwQcdx+GJwxykr2RYkIuQ0Mc71TGPeN4s8Il1iJcvGCkOklIwaMKROrUau0lQjZmF8jupWmHD
	kDwccZcsTUnL1Tz20qxJIls/0rLiw/iWcfl3Zc0IkwTO5qErc=
X-Received: by 2002:a05:600c:a4f:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-48a7b543796mr73538665e9.23.1777464085884;
        Wed, 29 Apr 2026 05:01:25 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:1b06:3877:bfc9:c6ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c1c2b37sm31361275e9.1.2026.04.29.05.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:01:25 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 0/2] pull request: fixes for ovpn 2026-04-29
Date: Wed, 29 Apr 2026 14:01:18 +0200
Message-ID: <20260429120120.514491-1-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC41E493D33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282364-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:mid]

Hello netdev team,

here are two fixes for ovpn.

Patch 1 fixes the inconsistent call context for gro_cells_receive().
On a TCP connection, we can end up calling gro_cells_receive() from
process context, which is unexpected (and could potentially trigger
deadlocks). For this reason we're wrapping the aforementioned call
within local_bh_disable/enable().

Patch 2 is ensuring that the MAC header offset is reset before
deliering the packet to the upper layer. Not doing so could trick other
parts of the networking stack into wrong calculations.



On a side note, the bug being fixed by patch 1 was also recently reported
by the netdev CI.
We still got some spurious TCP failures that we are tracking down.


Please pull or let me know of any issue.

Thanks,
	Antonio


The following changes since commit 3bc179bc7146c26c9dff75d2943d10528274e301:

  netpoll: fix IPv6 local-address corruption (2026-04-27 19:16:18 -0700)

are available in the Git repository at:

  https://github.com/OpenVPN/ovpn-net-next.git tags/ovpn-net-20260429

for you to fetch changes up to 39b17bb8b1ce3ba488d81db31916aacd5803b18f:

  ovpn: ensure gro_cells_receive() is invoked with BH disabled (2026-04-29 11:33:43 +0200)

----------------------------------------------------------------
Includes changes:
* ensure gro_cells_receive() is called with BH disabled
* ensure MAC header offset is reset before delivering packet

----------------------------------------------------------------
Qingfang Deng (1):
      ovpn: reset MAC header before passing skb up

Ralf Lici (1):
      ovpn: ensure gro_cells_receive() is invoked with BH disabled

 drivers/net/ovpn/io.c | 7 +++++++
 1 file changed, 7 insertions(+)

