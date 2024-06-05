Return-Path: <netdev+bounces-100806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB728FC1AC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E85A1C2326D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF361FC9;
	Wed,  5 Jun 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp4vdK6G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E912744E;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554032; cv=none; b=hJGAspW788u2YfRO3lIhDmgo33CLCkgTIbWeW9+90ccDqkHvtfp9ldCf/hi4OmctS+sLC7K7PqZ+PW7fI3yT5OLgVYLz1mAzcmbOYlq6DXPrxfEGjRIKGPKJUgQ+1eN2mjoDCr8BdGBqnkaPUgdtUjXiSMkET72ntuPMA1ArpN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554032; c=relaxed/simple;
	bh=08b//uzEqLqk0Nl2SSIOHmj2RvoFoSkpZUV6ZyaQgQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IaRazvz6OfSTBDNf815cLbeAz5ct2qIkJgs6kvAL00aQmBejbZfXYhAcS9WVA74hfOLKkKEY3kD2mnQkuHuixdPmlQiN4Tdb8chl+yuqHn/L6i3cHhnCMpW2he47JrJsF3Mool2R+uwsvtV84wbGs9X17ClMpsYJ44TOtjn8Cic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp4vdK6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91474C2BBFC;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717554031;
	bh=08b//uzEqLqk0Nl2SSIOHmj2RvoFoSkpZUV6ZyaQgQY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Tp4vdK6G85uxI6PeMLSbifQinw4Acp0/UMmlwvW/KeOTaIq7EcVqymnnYa9MgS4q5
	 cEeF4yYTXx91EGHK+dzkrnjl/XznapKRxMxH2GDXZITF5vMLReRB9nUwrvYr8/12oL
	 Kx7mf1XT3f1xubgxAJimOjboTiq8k6lLabppB9GAhoU9YhXhj7NYSq6llH5phJEkdR
	 LaC9D9sx5xSNdavQiviDzn4lV0acVPc6qb2dnkr7yhn57rW0h01jzSnQN/C/b4qAK4
	 cjea4FunarRHQ0R5X02XsKqYXpLxyfsv24wyw3ifjdt8qUcVroGbdolraN1yCppdCn
	 yLdjUr1RfvdlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF0C25B78;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Subject: [PATCH net-next v2 0/6] net/tcp: TCP-AO and TCP-MD5 tracepoints
Date: Wed, 05 Jun 2024 03:20:01 +0100
Message-Id: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHLX2YC/12OwQqDMBBEf0X23G2TqAg99T+KlDVuag4mkgSxi
 P/eGOilx2GY92aHyMFyhHu1Q+DVRutdDupSgZ7IvRntmDMooRrR1hKTXl7kMQXSvHjrUkRDimX
 D0ohxhDxcAhu7FegTHCd0vCXoczNQZBwCOT2d0F93m8m6cznZmHz4lDerLPsiVqo5xfgnXiUKl
 K2p5dCZWlD3oJAJdNV+hv44ji81NbuC3wAAAA==
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717554029; l=1682;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=08b//uzEqLqk0Nl2SSIOHmj2RvoFoSkpZUV6ZyaQgQY=;
 b=udDy88sE7uRWWaTJ4YsZBsDtpsCY2MWcWS33lc++xo+jeEiE4cCGOkwYZUnFrEZaR9TvdCDN9TXr
 16ekEXZLCdDL19+LuYWiuXoXItVyhUUo6sBV3bGBA+GvGXA0r9nM
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
Changes in v2:
- Fix the build with CONFIG_IPV6=m (Eric Dumazet)
- Move unused keyid/rnext/maclen later in the series to the patch
  that uses them (Simon Horman)
- Reworked tcp_ao selftest lib to allow async tracing non-tcp events
  (was working on a stress-test that needs trace_kfree_skb() event,
   not in this series).
- Separated selftest changes from kernel, as they now have a couple
  of unrelated to tracepoints changes
- Wrote a few lines of Documentation/
- Link to v1: https://lore.kernel.org/r/20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com

---
Dmitry Safonov (6):
      net/tcp: Use static_branch_tcp_{md5,ao} to drop ifdefs
      net/tcp: Add a helper tcp_ao_hdr_maclen()
      net/tcp: Move tcp_inbound_hash() from headers
      net/tcp: Add tcp-md5 and tcp-ao tracepoints
      net/tcp: Remove tcp_hash_fail()
      Documentation/tcp-ao: Add a few lines on tracepoints

 Documentation/networking/tcp_ao.rst |   9 +
 include/net/tcp.h                   |  79 +--------
 include/net/tcp_ao.h                |  42 +----
 include/trace/events/tcp.h          | 317 ++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp.c                      |  87 ++++++++--
 net/ipv4/tcp_ao.c                   |  24 +--
 net/ipv4/tcp_input.c                |   8 +-
 net/ipv4/tcp_ipv4.c                 |   8 +-
 net/ipv4/tcp_output.c               |   2 +
 9 files changed, 434 insertions(+), 142 deletions(-)
---
base-commit: a6ba5125f10bd7307e775e585ad21a8f7eda1b59
change-id: 20240531-tcp_ao-tracepoints-fa2e14e1f0dd

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



