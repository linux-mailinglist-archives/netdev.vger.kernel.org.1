Return-Path: <netdev+bounces-219231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C19B40986
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04431B24B1C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D565432ED4E;
	Tue,  2 Sep 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="B9FSUsAy"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E0322C63;
	Tue,  2 Sep 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828026; cv=none; b=SsHMBoDRU5BJJHPHc8liy9zAu4UgR+aQDUSHzIoqPGqoFrp4N3CJTGuD4of1c1kSAGAUPNF49laGOxx002k5H+VvXlwa714fZb1UKKGgm87NcOs0nu1QhfASbszC1eHLs2h0LDuBtXAis/jKAliFluhxszUjdKAobRWQXt810tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828026; c=relaxed/simple;
	bh=twE4laRUCmSJZyNrpq6rbKdacOzsbDwc1WIu8kLnCe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QYQq/0fN9FtOQD8fmx852tXkaJM1b9/f48Wwm1BRnvCzQ++RK74aT8RKzPyMKE6PmfDA64Sj8n+HuBu+isjSwkwsPowZcoxQMTwJ6ktlzZTWJF2ZPDUdKuXva6zjJjONAF0uCVf8WbznnCxHwNU4RsjELTzQij+Z2/lc6vYA/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=B9FSUsAy; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756828014;
	bh=twE4laRUCmSJZyNrpq6rbKdacOzsbDwc1WIu8kLnCe8=;
	h=From:To:Cc:Subject:Date:From;
	b=B9FSUsAyN/FMziKaefy5d7n28oy0pz03hirxqY7G+zYdakTS2Wdj/kNdfMXfE+NlE
	 hn7xIvA++7EhD6eyhXgfi6ZljAUj6sRyxfZbEUiH3KmcsltOb8nyDLYnWTaggPEhDp
	 cR/+h50APjB35LDuhrYpsvVoqro6wmNgHaDVak3lvffnULWW1j1Y+DH7ZMk/+knxvk
	 KSS2kQMquIBvsNf6k3CBpn+GCNU2XgfmbkEDrovuv4qJ460v4xQ96qgtW9aclEhkfA
	 +BpIy/3pNgeAOQy08VIeZk2KBrl670pUilxqziB+27OkKoKVnI5liBEXMtwhkWc8L3
	 /yPzge1XMnnsA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3C0D460078;
	Tue,  2 Sep 2025 15:46:53 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 305DC2021C5; Tue, 02 Sep 2025 15:46:42 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] tools: ynl-gen: misc changes
Date: Tue,  2 Sep 2025 15:46:34 +0000
Message-ID: <20250902154640.759815-1-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Misc changes to ahead of wireguard ynl conversion, as
announced in v1.

---
v2:
  - Rewrite commit messages for net-next
v1: https://lore.kernel.org/netdev/20250901145034.525518-1-ast@fiberby.net

Asbjørn Sloth Tønnesen (3):
  netlink: specs: fou: change local-v6/peer-v6 check
  tools: ynl-gen: use macro for binary min-len check
  genetlink: fix typo in comment

 Documentation/netlink/specs/fou.yaml | 4 ++--
 include/net/genetlink.h              | 2 +-
 net/ipv4/fou_nl.c                    | 4 ++--
 tools/net/ynl/pyynl/ynl_gen_c.py     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.50.1


