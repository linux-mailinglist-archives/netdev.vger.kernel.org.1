Return-Path: <netdev+bounces-94032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 906488BDFFA
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C88B27902
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056614F9ED;
	Tue,  7 May 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qVOqEXLr"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628EC14F118;
	Tue,  7 May 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078686; cv=none; b=mZLhdzUdR2niUrCPnMf9zR4zv7XU7KPq7lP1mxeqq1GWt7hlzBZknqeM42TfdjC/EiEj4dcNxtRTSC1W6rwIGTFOL6M8D4L7/uvFKkpAj5rh6hKxNzaE4ZXLS+MdzcjOOB/m5MYdU19NRSqfcdLS6BEw1xyujzsYUN21g2k77cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078686; c=relaxed/simple;
	bh=zbaNIyKrKMoQ1XFqRlHQyqFViL3R5sD8FLdycEfNc8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UUzWu5f8k6jdG2Bfn8fSUrhDYhDrJV/J1dfye0PI8n9uLY4p0LJgOg4mTZrFALjmRCeZKTBpwVzbzxDzTusQVsx0xy4tZl8lVbd7D5r2gNMVfj4ROfUob7ZKSkD8EAu69dTeHgtWIWoFawFkCD7dM1txJ5csZYjBGuD3ZR3TvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qVOqEXLr; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1B9EB600A7;
	Tue,  7 May 2024 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=zbaNIyKrKMoQ1XFqRlHQyqFViL3R5sD8FLdycEfNc8w=;
	h=From:To:Cc:Subject:Date:From;
	b=qVOqEXLrJsKtTB07rZIRastM82Y3qxWb6lLuNpwPPNCgeNpXD4J/egmc7TnE7dAvH
	 8g5OqxD1tfyUOHxfuwxjO6PibfGHqmnd7Et3sEDc0Vcce6XQwnKZ6eT6RKucPzMuR2
	 61L7NmWKKGJ7IHyFVbFbmWnCsok945vPyhgVZ64ENo1tKqBS7mxPNJJn9tVtZWRoBj
	 8VxaqBe4aI5npHpNj6N27fAGyr3t9BChany0iYsF8/vlyV7kLnokAVugtPIsXZmuyB
	 OS/DkdvZC6bporPlkD7efDuHG/MFvyTungA8F1pLN1HCbNOL+cGHb1aLU8A3qLuJou
	 xeNOv2K4lDmQA==
Received: by x201s (Postfix, from userid 1000)
	id 0A46620314C; Tue, 07 May 2024 10:44:22 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 00/14] net: qede: convert filter code to use extack
Date: Tue,  7 May 2024 10:44:01 +0000
Message-ID: <20240507104421.1628139-1-ast@fiberby.net>
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
in between patch 1-12. If wanted could squash patch 1-12 in a v2, but
I felt that it would be easier to review as 12 more trivial patches.

Patch 13 and 14, finishes up by converting qede_parse_actions(),
and ensures that extack is propagated to it, in both call contexts.

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

 .../net/ethernet/qlogic/qede/qede_filter.c    | 99 ++++++++++---------
 1 file changed, 55 insertions(+), 44 deletions(-)

-- 
2.43.0


