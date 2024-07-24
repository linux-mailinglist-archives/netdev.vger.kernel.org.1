Return-Path: <netdev+bounces-112883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBB293B996
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 01:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F47CB23969
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600AA1428E8;
	Wed, 24 Jul 2024 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shTgJ3f+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D134A39
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864577; cv=none; b=PaCoiClIb5u3FZ5qddGmSk5H6PthlSFFP6hh7KEB4Dc3NFwkdxA7q6y2hKDY05P0x7dSr9e2FvO/92MZ6DUyCMS8S1Q32d7jr11tLfVgA4tKf/Kxss7QFE9uLzoXDmhYSvnpddl88+ATo9EUNIHaTd6KKSPvd4wR33whYUpYPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864577; c=relaxed/simple;
	bh=pyRESUi7Ud09v/5KnVYoDc2iLmAlGf3CK/bHxY+y8g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpdfNYiFGnqamMyNgdFHqyjhf0jPAPobriESPie/lGu/DDClykyzSt6FTt4Pu+dDDC8BaWQqAoOIcWqePVZT7m1g7W91XTEjFcCbWVSQwmi3ce99N3hf1AvSk/XdVUgpZfPdD2wadFx3itF7AnqA+Fqj4SwC3860A1TSNFBHJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shTgJ3f+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2ACC32781;
	Wed, 24 Jul 2024 23:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721864576;
	bh=pyRESUi7Ud09v/5KnVYoDc2iLmAlGf3CK/bHxY+y8g8=;
	h=From:To:Cc:Subject:Date:From;
	b=shTgJ3f+IA+BHy2T+ABbVgCw8RkjsvhQmFAgg/avQuXzosADeBIpdCs8UYUyHib/D
	 Gn0As+MpUAwTQRuSMDUHgy9pqiO791dNlQSiAGPGfs66rMO0ociojIGXDoV4li6unz
	 q6q9YHtv6T0P/w07e4lRe2dPF3xudKoZFzBv02E+86yGT2116Z1lZ23fvV+yVAjzND
	 +6qjFsdeE/WI4Rz2uLH0BOwGhAP2DM6Maj3hfWRCn70DvyukLf4i7nevxPh3mHVOk8
	 aKsd7f3bwc5EwtQbj8vm9SwwtlPiIh2PIfLjnrI/4W4tTcFl+Sg8dINfQfPJ1Uj4So
	 k8GsXn+VphpiQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/2] ethtool: rss: small fixes to spec and GET
Date: Wed, 24 Jul 2024 16:42:47 -0700
Message-ID: <20240724234249.2621109-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small fixes to the ethtool RSS_GET over Netlink.
Spec is a bit inaccurate and responses miss an identifier.

Jakub Kicinski (2):
  netlink: specs: correct the spec of ethtool
  ethtool: rss: echo the context number back

 Documentation/netlink/specs/ethtool.yaml     | 2 +-
 Documentation/networking/ethtool-netlink.rst | 1 +
 net/ethtool/rss.c                            | 8 +++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.45.2


