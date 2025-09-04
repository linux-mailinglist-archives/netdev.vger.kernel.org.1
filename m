Return-Path: <netdev+bounces-220162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF775B44928
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A737BBDEA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3666D2FC881;
	Thu,  4 Sep 2025 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="a53Olmkq"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B42D97BD;
	Thu,  4 Sep 2025 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023417; cv=none; b=CnNK5u4InamCDfpirBrxk3AHax3fnBNoYnIMWKUxgZzW5cJfIbkf4y3iMUSzTguMlhEZ8PN9AaXquUsNfAGd2rH4e3uKvJtHpZsOwMVko97zr/JZnnsthPlDpxQKixRDb3Rq558IMZnndnE500vBgkOA1BHOtgNnganbYL9vJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023417; c=relaxed/simple;
	bh=ONNek9e9XXLRrSnQiiYpvkro4XvZ25Cp3066DjpUKos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MZA2f/K57ia7CrG+Rv6wG8kmLAPsnZNOz/vLd/4veU74dM5HVmT/T0zstcEPvBsBzLWXpwJvVPnxNji8mkgUhh8z/1bwkAxMWunGZg6v+0twOfjhqVBjNAEhXxnDj+dKURRp9Ne82WG8iMYYMaIPJdpEmR7+P75fFdADpAUQ6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=a53Olmkq; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023399;
	bh=ONNek9e9XXLRrSnQiiYpvkro4XvZ25Cp3066DjpUKos=;
	h=From:To:Cc:Subject:Date:From;
	b=a53Olmkqz4aRkLa/ZKdGhn7GnrBtXxsyRrkfDNYG1d/FdeeYyRthcvMvE9EjS2BFw
	 gbKS4QeYgBxlk8RJFgutfGRq8144lRRUpo61hyhNdCyrBxcfdUnTb4mvZMT4fl2J0r
	 808iPYKXYKXarcAHLVTwoI6uO/FZ35Qdy3o0iCStTGmbJGf+nzjhWUKoxooW1dz8Sr
	 raTBQTP5Dj8lUfFp8V6ibFSkr8En1gkkKP2mGnTH+FwKg5SoHsl+8v6U/GQwEg45Yr
	 qbmVfMOP1x61QVTFGUrU/iJGzkLiqM5If9LgntOKm51b5WddhaOWiPOrlarVDGTPV1
	 bQxVFP+Xsia2Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1DBA56058A;
	Thu,  4 Sep 2025 22:03:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 6F0AC201EBF; Thu, 04 Sep 2025 22:01:56 +0000 (UTC)
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
Subject: [PATCH net-next 00/11] tools: ynl: prepare for wireguard
Date: Thu,  4 Sep 2025 22:01:23 +0000
Message-ID: <20250904-wg-ynl-prep@fiberby.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains the last batch of YNL changes to support
the wireguard YNL conversion.

The next batch has been posted as an RFC series here:
https://lore.kernel.org/netdev/20250904-wg-ynl-rfc@fiberby.net/

Asbjørn Sloth Tønnesen (11):
  tools: ynl-gen: allow overriding name-prefix for constants
  tools: ynl-gen: generate nested array policies
  tools: ynl-gen: add sub-type check
  tools: ynl-gen: define count iterator in print_dump()
  tools: ynl-gen: define nlattr *array in a block scope
  tools: ynl-gen: don't validate nested array attribute types
  tools: ynl-gen: rename TypeArrayNest to TypeIndexedArray
  tools: ynl: move nest packing to a helper function
  tools: ynl: encode indexed-array
  tools: ynl: decode hex input
  tools: ynl: add ipv4-or-v6 display hint

 Documentation/netlink/genetlink-legacy.yaml |  2 +-
 tools/net/ynl/pyynl/lib/ynl.py              | 36 +++++++++++++++---
 tools/net/ynl/pyynl/ynl_gen_c.py            | 42 ++++++++++++++-------
 3 files changed, 59 insertions(+), 21 deletions(-)

-- 
2.51.0


