Return-Path: <netdev+bounces-218781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4026B3E7E8
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B62D441B5A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42902F1FFE;
	Mon,  1 Sep 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="FYQO9LIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57A276027;
	Mon,  1 Sep 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738340; cv=none; b=SoTgow3p7HXWSPPy2S7np5eH64beb/jPP9t2bn12jnth2riY7rlNIk4X1N4zhLmWy3M37AGXzigXw3ykuhs9uGEbl1GyF86+ovB1dmCH5Dgc1A6QQWiDkEKFCFwu+q3xDAH81ZENlHbBJl8FEp8qXfl2KZn/q1ndhugm1P3rT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738340; c=relaxed/simple;
	bh=7AacMuB4EgHFQr+FzPApSSfG+3ILvt7xvDy7ny/dTcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MwHO/iw6EPCj1YnKJ9I+Ct/iR2IGW/2PUv4gaNsuA2u4kvSzeUo4rxz+0DY+bLhPZMJx44kYhn9a4EC6vAOWQMjzcKjaWamyxG7736ZTlQ0mf3tQ224pgWG5xEDRHe2lY7jz36JPqeqd3KuqlyqJ7hJX415j95H9SODDl0n7YY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=FYQO9LIn; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756738334;
	bh=7AacMuB4EgHFQr+FzPApSSfG+3ILvt7xvDy7ny/dTcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FYQO9LInj2Drr2C3M+KIi06JA41U6vM9JUR40TOJWho7B2AeYnz7RZxmGZbAUqUSG
	 sU37L4eemwbf1FchcHgGX20FbYduuUq1UfI3F4d+LwSVbF25BVvOv9RcovUe72T43b
	 oo527N/ARmvGk741WIqxHwmJD5/r+4DLKiWyUlKRicN3mZPDBLnjW+tNygdx5748OQ
	 XT3ulUn69NZN2rIgOC6/SthA2rX1GfpaiZjaoFz+WArEAnTSTyViFUgwJ/7pRHeTEh
	 f9ZfRTR8Hg1W8Pln9HbCCnUASXgbHby7cwGDDn5UA88UyIer0htMK3z1lGLWrCJ9C1
	 be3VGoGijfYPA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id DF0BD600C4;
	Mon,  1 Sep 2025 14:51:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 9360D2021C5; Mon, 01 Sep 2025 14:50:52 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] tools: ynl-gen: misc fixes + wireguard ynl plan
Date: Mon,  1 Sep 2025 14:50:19 +0000
Message-ID: <20250901145034.525518-1-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is the first batch of changes related to converting
the netlink around wireguard, to be based on an YNL spec,
with the focus on making it a 1-to-1 replacement.

I will post these 28 patches in 3 batches.

This 1st series with some misc fixes for net.

Once this 1st series makes its way to net-next, then I plan
to post the 2nd series with YNL improvements for net-next,
and the 3rd series with the wireguard changes as RFC at
the same time, as many of the patches in the 2nd series is
using the 3rd series for justification, so they should be
available for reviewers.

Once the 2nd series is accepted into net-next, then
I will post the 3rd series in v1 for net-next.

Below are the diff stats for each series:

1st series (this) - misc fixes (4 patches):
 Documentation/netlink/specs/fou.yaml     | 4 ++--
 include/net/genetlink.h                  | 2 +-
 net/ipv4/fou_nl.c                        | 4 ++--
 tools/net/ynl/pyynl/ynl_gen_c.py         | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

2nd series - ynl improvements (10 patches):
 Doc../netlink/genetlink-legacy.yaml      |  2 +-
 tools/net/ynl/pyynl/lib/ynl.py           | 36 ++++++++++++---
 tools/net/ynl/pyynl/ynl_gen_c.py         | 34 ++++++++------
 3 files changed, 52 insertions(+), 20 deletions(-)

3rd series - wireguard changes (14 patches):
 Doc../netlink/specs/wireguard.yaml       | 321 ++++++++++++++
 MAINTAINERS                              |   3 +
 drivers/net/wireguard/Makefile           |   1 +
 drivers/net/wireguard/netlink.c          |  73 +--
 drivers/net/wireguard/netlink_gen.c      |  72 +++
 drivers/net/wireguard/netlink_gen.h      |  30 ++
 include/uapi/linux/wireguard.h           | 202 ++-------
 include/uapi/linux/wireguard_params.h    |  18 +
 tools/net/ynl/samples/.gitignore         |   1 +
 tools/net/ynl/samples/wireguard.c        | 104 +++++
 10 files changed, 605 insertions(+), 220 deletions(-)

Asbjørn Sloth Tønnesen (4):
  netlink: specs: fou: change local-v6/peer-v6 check
  tools: ynl-gen: use macro for binary min-len check
  tools: ynl-gen: fix nested array counting
  genetlink: fix typo in comment

 Documentation/netlink/specs/fou.yaml | 4 ++--
 include/net/genetlink.h              | 2 +-
 net/ipv4/fou_nl.c                    | 4 ++--
 tools/net/ynl/pyynl/ynl_gen_c.py     | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.50.1


