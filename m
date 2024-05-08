Return-Path: <netdev+bounces-94632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F26F18C004F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82ACBB26A67
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0236786657;
	Wed,  8 May 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="BXzV0qZj"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0686270;
	Wed,  8 May 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179393; cv=none; b=cCf903GUHGnc8mJsfPEpI935KfHqmpxHC43m8voYVGIZQobkbcCAe9cF3cw18X0NWV/yEDMDavgzT0LReQHr3HBS0QmAsQTUMjImV2qCvUVWvNWG5pfzu7Fht6Dj0O/Gfrr+c7NmWFU+eaIjmmMGnIwY8ZKrrEsOwMcptcToWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179393; c=relaxed/simple;
	bh=de6mABlly2eNPPMWPujcomvFv6/tsClXC1FbKAjjl5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dsjxlwzjhwNugEzwCEs2w7cQtnpzf2ylBUVNtJ8/gfsEdhYdNge7e90RWLGS8eeUlfKBjDFIL1t5Auzd+LX4rjWR7xSYRSNZ2wwGuJ911LoDf/p4cipJt2g6ofKJiBcoFpc300iD3evYDcz6N1BxTZm2/vLOj86RNe+xo4gqKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=BXzV0qZj; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 02F34600A7;
	Wed,  8 May 2024 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178867;
	bh=de6mABlly2eNPPMWPujcomvFv6/tsClXC1FbKAjjl5Q=;
	h=From:To:Cc:Subject:Date:From;
	b=BXzV0qZj6tkNEHDeBAFX/giRSXuh45KplIjcKJC0gkTBaEpc2sXKBGxxnQZ5bOjBD
	 nYtFa+FKtLBsz1KWD/n72PbXJVqgjbRAWzuMQZygUTCFFiTyu/ZOGnspyjyoErbV8Z
	 5R1xUywDHps7WCCshkb+ML/+6wMhNbW2HRhdaDI2Dn3Fi56qnDFdS06yoOxWv2Lefu
	 7AzCQRr+20ufISuKu90LJfNTn/qkERENqQg42fUjojYpJDig5i6X1zXVdHJ2JAVoz9
	 +XQsQETf/fyFAmHS9WHrOIMKo2fEk1K9Kz89fFGc6/jUx6R3BZVzmMcYkm4NFg3LUB
	 2aQveYZ9pHdKQ==
Received: by x201s (Postfix, from userid 1000)
	id E8119203455; Wed, 08 May 2024 14:34:04 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 00/14] net: qede: convert filter code to use extack
Date: Wed,  8 May 2024 14:33:48 +0000
Message-ID: <20240508143404.95901-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series converts the filter code in the qede driver
to use NL_SET_ERR_MSG_*(extack, ...) for error handling.

Patch 1-12 converts qede_parse_flow_attr() to use extack,
along with all it's static helper functions.

qede_parse_flow_attr() is used in two places:
- qede_add_tc_flower_fltr()
- qede_flow_spec_to_rule()

In the latter call site extack is faked in the same way as
is done in mlxsw (patch 12).

While the conversion is going on, some error messages are silenced
in between patch 1-12. If wanted could squash patch 1-12 in a v3, but
I felt that it would be easier to review as 12 more trivial patches.

Patch 13 and 14, finishes up by converting qede_parse_actions(),
and ensures that extack is propagated to it, in both call contexts.

---
Changelog:

v2:
- Reworked to always add extack as last argument. (Requested by Przemek)

v1: https://lore.kernel.org/netdev/20240507104421.1628139-1-ast@fiberby.net/

Asbjørn Sloth Tønnesen (14):
  net: qede: use extack in qede_flow_parse_ports()
  net: qede: use extack in qede_set_v6_tuple_to_profile()
  net: qede: use extack in qede_set_v4_tuple_to_profile()
  net: qede: use extack in qede_flow_parse_v6_common()
  net: qede: use extack in qede_flow_parse_v4_common()
  net: qede: use extack in qede_flow_parse_tcp_v6()
  net: qede: use extack in qede_flow_parse_tcp_v4()
  net: qede: use extack in qede_flow_parse_udp_v6()
  net: qede: use extack in qede_flow_parse_udp_v4()
  net: qede: add extack in qede_add_tc_flower_fltr()
  net: qede: use extack in qede_parse_flow_attr()
  net: qede: use faked extack in qede_flow_spec_to_rule()
  net: qede: propagate extack through qede_flow_spec_validate()
  net: qede: use extack in qede_parse_actions()

 .../net/ethernet/qlogic/qede/qede_filter.c    | 114 ++++++++++--------
 1 file changed, 63 insertions(+), 51 deletions(-)

-- 
2.43.0


