Return-Path: <netdev+bounces-182475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B3A88DA4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A3817567E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB64017555;
	Mon, 14 Apr 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRjKNr87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870802DFA4E
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665599; cv=none; b=FM6uOeiNXdt8B7/O99uadLj+V6odUCi+BFHeaBRwQt83Wn8hMqCGHxnFEAk6H8L6/oxkADf39+niHkYtoxzRgx9TpIurfj4PqZzv9HtK1wnt0aqcJ/G1yhaMZAfytjG2TFwA6JiKfAWwlrzVQcWxTbppGxP0H48jispg/aMkoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665599; c=relaxed/simple;
	bh=o3rimf1C5bPDOpd5GmGRhNVWE5MkJj/boIhtUM7Mojg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sH8K/OGUvfqpqkWKpuAKgAKMjlbRxk5NHGVXRA+zVp6mDYH8CY1R4HBuDKCBuhULfXCag0B7W31k0021Ca5XF27W6ZGfBvt4Wk2D6trg+CIhwAJGOeHSHVeoUfjZS6CXWPiFLt/P+MNOqpKiJCTEK0Ard1kbpqLHIyPSez5yAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRjKNr87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB67C4CEE2;
	Mon, 14 Apr 2025 21:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665599;
	bh=o3rimf1C5bPDOpd5GmGRhNVWE5MkJj/boIhtUM7Mojg=;
	h=From:To:Cc:Subject:Date:From;
	b=NRjKNr87KWZF1XnmjM/n71TNbPM00y/lz53vC69Rr30g2uUCiW5FdCzyQqaBb9YeT
	 /FPksQkpiIgnaPeqZySR7HrKYfWnEOiURrnJ8AO8LV99v4LmYFtQRQaTLFNL+c1Phl
	 3nmrCaR+c+QyTw1YvHA7SrMNxTcnuWTA8p9O/iLatYUhV0AlQ5admzMChWL0OVwW64
	 y8Z9hSUfSWHQ9RoGcpc39BF8gkUyhR3oQYBbdhGHk36tE0u78Um3u1DsMZsD8sYrXw
	 wWK5JxFsTvhDHtQ9H4sSn2JEC9D2gcyd7DuQYOn27ZlDCNxEaDN/PrbRHlkuBJ/gz4
	 42DysSYmJnC8w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/8] ynl: avoid leaks in attr override and spec fixes for C
Date: Mon, 14 Apr 2025 14:18:43 -0700
Message-ID: <20250414211851.602096-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The C rt-link work revealed more problems in existing codegen
and classic netlink specs.

Patches 1 - 4 fix issues with the codegen. Patches 1 and 2 are
pre-requisites for patch 3. Patch 3 fixes leaking memory if user
tries to override already set attr. Patch 4 validates attrs in case
kernel sends something we don't expect.

Remaining patches fix and align the specs. Patch 5 changes nesting,
the rest are naming adjustments.

Jakub Kicinski (8):
  tools: ynl-gen: don't declare loop iterator in place
  tools: ynl-gen: move local vars after the opening bracket
  tools: ynl-gen: individually free previous values on double set
  tools: ynl-gen: make sure we validate subtype of array-nest
  netlink: specs: rt-link: add an attr layer around alt-ifname
  netlink: specs: rtnetlink: attribute naming corrections
  netlink: specs: rt-link: adjust mctp attribute naming
  netlink: specs: rt-neigh: prefix struct nfmsg members with ndm

 Documentation/netlink/specs/rt_link.yaml  | 20 +++--
 Documentation/netlink/specs/rt_neigh.yaml | 14 ++--
 tools/net/ynl/pyynl/ynl_gen_c.py          | 96 +++++++++++++++++------
 3 files changed, 92 insertions(+), 38 deletions(-)

-- 
2.49.0


