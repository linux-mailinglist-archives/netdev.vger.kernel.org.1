Return-Path: <netdev+bounces-182268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FD6A88685
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62CB56197A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DECD27585F;
	Mon, 14 Apr 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR35RARg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C1018DF8D;
	Mon, 14 Apr 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641956; cv=none; b=QP8RfG0ube6gmSxF/TuwtLfVwWKUUxoMCq64BHeyFRlpn8mHcUkHkGu369OWkTEH1u4udEPx5gISmASeSgw37kNuGNe3luL/2M/5/I4oEI2vKcowHqxDtjUMjpSNA/DDLhYjjjJkSoy5Fw5sWiSLMM/pLrB/hks7daAJn4vjO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641956; c=relaxed/simple;
	bh=G1Rfo59lIcmgxlV/FcZQX3VT2H7a7D1+qS9qITl6KS0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gtfnWViW+tCNHNBO8wjwb2n8gmudP28ClNG3UHZ9UrhmU07RH9LDIkOaE0ilmxQimJX/W+e7tNvcX9vXNsagMdFSill8XcAhWlIkGGa/J7zgjWtyQMWdVartpUZxcPk/RrwOxxMvCuncaW9hrXfWiOAo4PIJsWThI3iErmcZq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR35RARg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB60C4CEE2;
	Mon, 14 Apr 2025 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641955;
	bh=G1Rfo59lIcmgxlV/FcZQX3VT2H7a7D1+qS9qITl6KS0=;
	h=From:Subject:Date:To:Cc:From;
	b=dR35RARgl3lQtxaTwdiuI+U5g+AMQPYMvbPIgh9gYGE9L3uuYNE5FrS0qqLzO64Dt
	 px/mhK4HqdkQgcrOGplPJR5sjBx7u+KWCiLm93z//puKh+EdHIzAlSGN1fPR71Ghu+
	 J5qwsKPTqeWv8Z/UpxmjWv4e5LCySE+q7qOUhlLFgQJjUOqunQq5rdLDKXYYRMdjC5
	 pfWEclNdUVP9PoZBJfYc8aWRl0yDlSxoTJvvCBipHiaH8bO6PYK7i2UdHOHv2jITUG
	 5MBWY0WbXvW4x7mbjZ/5/6aE6yH99lvtt9SySTDEuK+6LOlkR6n5G7vQbPnmWUp4k4
	 Jwpqk5yNuSSuA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/4] ref_tracker: register debugfs files for each
 ref_tracker_dir
Date: Mon, 14 Apr 2025 10:45:45 -0400
Message-Id: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJof/WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0Nj3aLUtJKixORs3ZSk9LRiXWNzM/MkYwPjVKO0RCWgpgKgfGYF2MD
 o2NpaABAUGs9gAAAA
X-Change-ID: 20250413-reftrack-dbgfs-3767b303e2fa
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=G1Rfo59lIcmgxlV/FcZQX3VT2H7a7D1+qS9qITl6KS0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/R+d/lGondyBSN5HmQOIATCeysTU0XUjOAbi0
 jNpXubQElGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/0fnQAKCRAADmhBGVaC
 FRCdD/oDoSl0OorBSNTCjYBLcEfbh3oq7wuwX1tVkyrtMSTiEq9sUopoAvtriArCduKGXKHKL7j
 h3Zaf1oWyTUN9ycpApfaZGqgYS9BHKU+NczB8oykJPrxb3RpIx1+78xXO7tTtI5Bx94ep8bQvyb
 EptyCZj8oq7gyZn0EsyFPhAnssxlORYKrIwg7YUTeWo5fpGBwlR4nqX97P0ILfghLlTJlg9CB0E
 p7Cs552sKnRl6KQSybQ4pLVMbPRQ9+NEWhtvotXVh34Eab353HTtrWrZLDQbIlHjN8C9CtTRqFy
 fPDMgBhdAp4msDNQAH1CblV62aVwIOiOmF4itbJDLxefbgh1z2goYoopkoyOkbABs9DMjW7xy6j
 1BMRijGuh1P2gke8Q7FeeqbZhQ+1rrdJc76scNJSN2D1dp013VZAskeD9lZqHGtDs4bbvRvlj9z
 fsn7ykab3QrcEmy10RYwcQTLFuBSOIw9+2FggmeGhLnrtm6elNly/7jz0UjvgsUUXTEmCbBMhL2
 OwHGkvQLvI2s4T1cleAHQJe+/mdhRL8MpQ+VTljvJcw2zPbB82v8Br+SCQvMWJASa7yjcvjqPFF
 VpEsQw21kpPKbkZVmSLXVI9MZLm557qEk7ozsSPPl6HIIX7EOO0F+k+X2hLmdsRolVXgFXxojec
 SeoY/RoTzZrLpTA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I had previously sent some patches to add debugfs files for the net
namespace refcount trackers, but Andrew convinced me to make this more
generic and better-integrated into the ref_tracker infrastructure.

This adds a new ref_tracker_dir_debugfs() call that subsystems can call
to finalize the name of their dir and register a debugfs file for it.
The last two patches add these calls for the netns and netdev
ref_trackers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (4):
      ref_tracker: add a top level debugfs directory for ref_tracker
      ref_tracker: add ability to register a file in debugfs for a ref_tracker_dir
      net: add ref_tracker_dir_debugfs() calls for netns refcount tracking
      net: register debugfs file for net_device refcnt tracker

 include/linux/ref_tracker.h | 13 ++++++
 lib/ref_tracker.c           | 98 ++++++++++++++++++++++++++++++++++++++++++++-
 net/core/dev.c              |  2 +
 net/core/net_namespace.c    | 34 +++++++++++++++-
 4 files changed, 145 insertions(+), 2 deletions(-)
---
base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
change-id: 20250413-reftrack-dbgfs-3767b303e2fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


