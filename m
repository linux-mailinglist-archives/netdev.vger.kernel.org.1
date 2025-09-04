Return-Path: <netdev+bounces-220157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A4FB44922
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5380A587CD5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C52F5306;
	Thu,  4 Sep 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="p6gks5LY"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E32E9EC1;
	Thu,  4 Sep 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023415; cv=none; b=J5u1HisWEf/VthIDfr8HZ6SfJKgPdA8Lov47nwYnu9ij1CmulyvVDRNA5BirMZR7G/eS6WVWr00DM8eiJ30L/0XCRSF9WWAspJ3/RVx4vQ3HgZVTH5Tdwb69TnWseOSZ/SYtEx67eC4yRNwftdx1sdAZVTAKqXXYnIYHGgfdNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023415; c=relaxed/simple;
	bh=jFLTdQ0cGKkgHRD4y4SQu258pzqgYDTrDQqFmjeFWTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HZBh8I7a0EIzri7SBC853kiZuw7fdT0xc9xClgaAMn/IgTkeRxLWzFu9AGD/aaC1++eM6TFbYDFR08B1bGaxcN5iiP2jqHU7UEvdhckTCRBoCD8hiUpnseLQiYXcOmUVn9icdClRrHuXROaT0e5AhZLWg79aHdfS2FE19sK0f4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=p6gks5LY; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023398;
	bh=jFLTdQ0cGKkgHRD4y4SQu258pzqgYDTrDQqFmjeFWTg=;
	h=From:To:Cc:Subject:Date:From;
	b=p6gks5LYm1fRkaP9FgEE4fMc2O5qO7+vv+jsjsAOQFofN0NNO+IySsN+IS3mseRJk
	 ZA4Jlgv8nr4oaQaSdXvnq4ETmW4FBzcj7vJ11kO5PHIJ5fyVl3y65teurWRAJG1ETw
	 zzOpwg6I6TXz5B/gFhTyO3b5fYqDnpN6eGEjW3iM2438REMLsyJ86z5w6+00nO/0/S
	 ATOfw6cKkGcV60lPd8LsbZ5anWn+ATsb08C67mvRCx43Rl28JlfqXPDPAKKT0RA09r
	 BEsGzTH5VRoWGUWxPDL4TqJtlLUUSpS8CRZ3CgYwOmTzERZMkayyZ3Xv0kqBsMRJWq
	 b6C5yGMS8Nhsg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id B80F06039C;
	Thu,  4 Sep 2025 22:03:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 278C2202849; Thu, 04 Sep 2025 22:02:55 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 00/14] wireguard: netlink: ynl conversion
Date: Thu,  4 Sep 2025 22:02:34 +0000
Message-ID: <20250904-wg-ynl-rfc@fiberby.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains the wireguard changes needed to adopt
an YNL-based generated netlink code.

This RFC series is posted for reference, as it is referenced
from the current v1 series of ynl preparations, which has to
go in before this series can be submitted for net-next.

This series applies on top of this series:
https://lore.kernel.org/netdev/20250904-wg-ynl-prep@fiberby.net/

Asbjørn Sloth Tønnesen (14):
  wireguard: netlink: use WG_KEY_LEN in policies
  wireguard: netlink: validate nested arrays in policy
  netlink: specs: add specification for wireguard
  netlink: specs: wireguard: add remaining checks
  uapi: wireguard: use __*_A_MAX in enums
  uapi: wireguard: move enum wg_cmd
  uapi: wireguard: move flag enums
  uapi: wireguard: generate header with ynl-gen
  wireguard: netlink: convert to split ops
  wireguard: netlink: rename netlink handlers
  wireguard: netlink: generate netlink code
  netlink: specs: wireguard: alternative to wireguard_params.h
  wireguard: netlink: enable strict genetlink validation
  tools: ynl: add sample for wireguard

 Documentation/netlink/specs/wireguard.yaml | 289 +++++++++++++++++++++
 MAINTAINERS                                |   3 +
 drivers/net/wireguard/Makefile             |   1 +
 drivers/net/wireguard/netlink.c            |  73 ++----
 drivers/net/wireguard/netlink_gen.c        |  77 ++++++
 drivers/net/wireguard/netlink_gen.h        |  29 +++
 include/uapi/linux/wireguard.h             | 202 +++-----------
 tools/net/ynl/samples/.gitignore           |   1 +
 tools/net/ynl/samples/wireguard.c          | 104 ++++++++
 9 files changed, 559 insertions(+), 220 deletions(-)
 create mode 100644 Documentation/netlink/specs/wireguard.yaml
 create mode 100644 drivers/net/wireguard/netlink_gen.c
 create mode 100644 drivers/net/wireguard/netlink_gen.h
 create mode 100644 tools/net/ynl/samples/wireguard.c

-- 
2.51.0


