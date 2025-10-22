Return-Path: <netdev+bounces-231832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACD4BFDD57
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67C3934E5B8
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C534F27C;
	Wed, 22 Oct 2025 18:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="TcZ7Fiof"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2691348475;
	Wed, 22 Oct 2025 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157644; cv=none; b=Z/7NNct56DYQlXz4TTptUIftCYqVCasH3w4tjGdBPP8SAy9rww9/C9KWaFjgFx8LyEBQtOpQGqCngBeyFl3diuYNldMA1vtCHwTm3qJFoZto8MdG88WC7R0WtVQD83FIedz/R6rqsfgG5nJXIgiafYbxlLjDBFbfZItV2jPdceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157644; c=relaxed/simple;
	bh=2Q7fGungSbCuzo7lrq7jUELHiNWxvsuz10waRosXiH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bES8JNXYqYgbg2nVhAn5rR4kYNJhy0a5sTS7pDtXxgpgMRvDhfdUQg1+2ZL/pwG/GPMrjRQ8msw1zpH/3BT+q+j5D6NZ2zWpkU6EgfDQv0IAY3Egu6XRLqxkQ36A5vucygJe+eenUdBx153RduLZ+PRG+W//lLJ6UmE8mvwwc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=TcZ7Fiof; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761157634;
	bh=2Q7fGungSbCuzo7lrq7jUELHiNWxvsuz10waRosXiH0=;
	h=From:To:Cc:Subject:Date:From;
	b=TcZ7FiofIy0Lb2SX5186glIMDrFN9mv6AX9SsG4XyqIqJxVb7+GUS0cIG8qYDfjZz
	 VIQLN+oliJjkBAprlU9Rwea8MEjW3/4zSHhl+Pcvxdmqgv8thGdHQYnXCMCr7bw6j3
	 ToHuK4kQJsH+Hxs298x0X73lZrhgDGjysY4DuZuoeyapWJ+0JnRctEIxxqqEgTA+3c
	 qUDqUBHm+aNPUtGwOXj4OZfVTq7RB/T4lxqBLzZFZTgVsEAJeD6ibPtMsS3GhqU6qK
	 9RLupzuMFUAlKg2JN3LDBoG4XB7h56jpK/FdSSh0TLt7NdAYlFbVd3WC3GnTWlnHII
	 r3xmVnuaA1sfQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D437960107;
	Wed, 22 Oct 2025 18:27:14 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 7B7DD201BEC; Wed, 22 Oct 2025 18:27:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/7] ynl: add ignore-index flag for indexed-array
Date: Wed, 22 Oct 2025 18:26:53 +0000
Message-ID: <20251022182701.250897-1-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset adds a way to mark if an indedex array is just an
array, and the index is uninteresting, as previously discussed[1].

Which is the case in most of the indexed-arrays in the current specs.

As the name indexed-array kinda implies that the index is interesting,
then I am using `ignore-index` to mark if the index is unused.

This adds some noise to YNL, and as it's only few indexed-arrays which
actually use the index, then if we can come up with some good naming,
it may be better to reverse it so it's the default behaviour.

[1]
https://lore.kernel.org/r/7fff6b2f-f17e-4179-8507-397b76ea24bb@intel.com/

Asbjørn Sloth Tønnesen (7):
  netlink: specs: add ignore-index flag for indexed-array
  tools: ynl: support ignore-index in indexed-array decoding
  tools: ynl: support ignore-index in indexed-array encoding
  netlink: specs: nl80211: set ignore-index on indexed-arrays
  netlink: specs: nlctrl: set ignore-index on indexed-arrays
  netlink: specs: rt-link: set ignore-index on indexed-arrays
  netlink: specs: tc: set ignore-index on indexed-arrays

 Documentation/netlink/genetlink-c.yaml         |  6 ++++++
 Documentation/netlink/genetlink-legacy.yaml    |  6 ++++++
 Documentation/netlink/netlink-raw.yaml         |  6 ++++++
 Documentation/netlink/specs/nl80211.yaml       |  8 ++++++++
 Documentation/netlink/specs/nlctrl.yaml        |  2 ++
 Documentation/netlink/specs/rt-link.yaml       |  2 ++
 Documentation/netlink/specs/tc.yaml            |  1 +
 .../userspace-api/netlink/genetlink-legacy.rst |  3 +++
 tools/net/ynl/pyynl/lib/ynl.py                 | 18 ++++++++++++------
 9 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.51.0


