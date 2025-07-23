Return-Path: <netdev+bounces-209354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84236B0F556
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8505819D8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4F2E9EB0;
	Wed, 23 Jul 2025 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spIgWFqq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DE2E3373;
	Wed, 23 Jul 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281160; cv=none; b=WGaEFjNdaRl26PaRCuqpKhRn71NC1z11UyEpfpETDHoH4NAs5pzty8Q9yDlR6PaaiMZXIkSG8SU4WWnvt2iDMjgqgRglXa9cYjjQkmDZCwCswrDJ1A0koA0FecOzOwotqkKbsZO5e9PffL1FDKU+LRAQ0yM3UlGFBRRoI72iskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281160; c=relaxed/simple;
	bh=pcCl3uxF1AXpA2BapN3mpRSBrlmiXI1Mo1E8yltePqg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m7VIXYhZejGbnpzVW5f4edVTO8On31t6kHatnrdnqeZfBRGr8dnsWqBajLGpq6mbDq0x1JddM/npJcJg5zp9eBzArNdrYgMnD/dI+462c8EkL/WjeZ3l09x2Cunv826Zr8X84rUX8YSXQ8cblyVavSdlh6wWzlGA4Qr+IHGuF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spIgWFqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63245C4CEE7;
	Wed, 23 Jul 2025 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753281160;
	bh=pcCl3uxF1AXpA2BapN3mpRSBrlmiXI1Mo1E8yltePqg=;
	h=From:Subject:Date:To:Cc:From;
	b=spIgWFqqsfEAXGBxX7SaK0mvW6qu/Rd4xuJtvk78PfW5IzhdTNjBtVn7UaSBbEDsR
	 MvcjXsE0/CZiOPlWX6feawWqz5GteUPCo4AaHqm27h21aQCQyZR9yOCg+1N2/JQSg2
	 skcHs/0iisfQ5hZ662cR7MQqcS0LAeVsdQczFIu9hEdrlCha4/bYVj7QPaU5z4oc7l
	 02wcq3tN+8NkEg7dNxQl3aL0devoLXnuZX1HacSpYea2XnV53ZmjmyOSPZP6cenDq7
	 md/Ve/wT8NBHW9EAWcmpSNS4FNFG92WwcC6OBDKmi2fEPaoxUjp/333xGdvDP5zT9/
	 KmKEFdY4WO8cw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/2] mptcp: track more fallback cases
Date: Wed, 23 Jul 2025 16:32:22 +0200
Message-Id: <20250723-net-next-mptcp-track-fallbacks-v1-0-a83cce08f2d5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbygGgC/zWNwQqDMBBEf0X27IJdrFJ/RTzEZNMu1TQkQQTx3
 7sIHgbmHd7MAZmTcIahOiDxJll+QeFRV2A/JrwZxSkDNfRseiIMXDR7wTUWG7EkY7/ozbLMWjK
 23nUvdj25lkFHYmIv+3Uwwu3CdJ5/fHYxpnoAAAA=
X-Change-ID: 20250722-net-next-mptcp-track-fallbacks-4fd69ed72d4e
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pcCl3uxF1AXpA2BapN3mpRSBrlmiXI1Mo1E8yltePqg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIaPjXxK/o61cyRitzenKn/SDzi6Y/qzPK0Fa8nT9jVG
 JddKPCwo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCInlBj+x9ZGuYfM4z4SfEZf
 +cTBJZO6fnYcfMC4845E5bIc+4cuKowMa26kHWJa8HYnQ4ycdNz21BwzMalPa1YE1UwTXZV1JXM
 pOwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series has two patches linked to fallback to TCP:

- Patch 1: additional MIB counters for remaining error code paths around
  fallback

- Patch 2: remove dedicated pr_debug() linked to fallback now that
  everything should be covered by dedicated MIB counters.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (2):
      mptcp: track fallbacks accurately via mibs
      mptcp: remove pr_fallback()

 net/mptcp/ctrl.c     |  4 ++--
 net/mptcp/mib.c      |  5 +++++
 net/mptcp/mib.h      |  7 +++++++
 net/mptcp/options.c  |  5 +++--
 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h | 34 ++++++++--------------------------
 net/mptcp/subflow.c  | 16 +++++++---------
 7 files changed, 62 insertions(+), 54 deletions(-)
---
base-commit: 56613001dfc9b2e35e2d6ba857cbc2eb0bac4272
change-id: 20250722-net-next-mptcp-track-fallbacks-4fd69ed72d4e

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


