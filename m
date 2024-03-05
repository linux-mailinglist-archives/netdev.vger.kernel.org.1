Return-Path: <netdev+bounces-77346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE2F871548
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F39283465
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B145BFB;
	Tue,  5 Mar 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZQo5t4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA05AD5E
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616795; cv=none; b=CL0AjKqXyRTMNNiI2lUARxbI41EbwbDZsgYOZwtBJe5jsJN19vHUeQGOnDpWQtApW+K/xlNI7faFBb9fAclaMtr4CvieBZfnRdBVR2rwRTk/pQaAFzsOdegyaAs+RW11ahIy1AP0rrl06yYKSk4qkzB2fq41VrBwy5SoqjWxcek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616795; c=relaxed/simple;
	bh=ZpwwSNZp0Y4tO59tRnK+4czKwgMn6789Yp8YI0luCvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFNOmyCTV/ewANuBx7eulOQ3DkY0+Ub6Slj2uUDXuRmFrzAYgZKNvBNKx8oShRa3Rzmm6miJIrsYuXo+VCXJ8lWQGZHVyC+dAqMQgI8/FNQUhGgn9Qt1Ug/vIEjsvJ8eNvumqdOnv5sXtPbfRWy8CScsS5ycaD0ceaVaFIh9rh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZQo5t4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61299C433F1;
	Tue,  5 Mar 2024 05:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709616794;
	bh=ZpwwSNZp0Y4tO59tRnK+4czKwgMn6789Yp8YI0luCvw=;
	h=From:To:Cc:Subject:Date:From;
	b=BZQo5t4WiH56fIIbLWTRDsb/Lkrp0Uvs8iHpSXqQWtogYQJBslu8vT0fMyzlI1eiH
	 IsHk1aHTM2cn+PT/pR3j7CZlMcHy9fe+vd9YaKYBZk4JKshWlNjbNJAq4vpCzLr+x1
	 EBqsZI9nD8CfqcZIY8MJlF3FkH9yR1VNpaprPkVHLGSL3NFaU1L461X5vDoW+QfLCZ
	 DJhSo+pfUf1ELQk1vr27LNbOGus9BabDfUeUk+6k1DZDSVFZUQsMdkXxdRzgjUZJwW
	 KM+BIpMuFcXCdpEMyhTksQ30N/16+Ilbi0djiW/t26GwlrT93SSJRG7G03U2T0pxym
	 WkrUHzpc8dn5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/4] tools: ynl: add --dbg-small-recv for easier kernel testing
Date: Mon,  4 Mar 2024 21:33:06 -0800
Message-ID: <20240305053310.815877-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing netlink dumps I usually hack some user space up
to constrain its user space buffer size (iproute2, ethtool or ynl).
Netlink will try to fill the messages up, so since these apps use
large buffers by default, the dumps are rarely fragmented.

I was hoping to figure out a way to create a selftest for dump
testing, but so far I have no idea how to do that in a useful
and generic way.

Until someone does that, make manual dump testing easier with YNL.
Create a special option for limiting the buffer size, so I don't
have to make the same edits each time, and maybe others will benefit,
too :)

Example:

  $ ./cli.py [...] --dbg-small-recv >/dev/null
  Recv: read 3712 bytes, 29 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
  Recv: read 3968 bytes, 31 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
  Recv: read 532 bytes, 5 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
     nl_len = 20 (4) nl_flags = 0x2 nl_type = 3

Now let's make the DONE not fit in the last message:

  $ ./cli.py [...] --dbg-small-recv 4499 >/dev/null
  Recv: read 3712 bytes, 29 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
  Recv: read 4480 bytes, 35 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
  Recv: read 20 bytes, 1 messages
     nl_len = 20 (4) nl_flags = 0x2 nl_type = 3


A real test would also have to check the messages are complete
and not duplicated. That part has to be done manually right now.

Note that the first message is always conservatively sized by the kernel.
Still, I think this is good enough to be useful.

v2:
 - patch 2:
   - move the recv_size setting up
   - change the default to 0 so that cli.py doesn't have to worry
     what the "unset" value is
v1: https://lore.kernel.org/all/20240301230542.116823-1-kuba@kernel.org/

Jakub Kicinski (4):
  tools: ynl: move the new line in NlMsg __repr__
  tools: ynl: allow setting recv() size
  tools: ynl: support debug printing messages
  tools: ynl: add --dbg-small-recv for easier kernel testing

 tools/net/ynl/cli.py     |  7 ++++++-
 tools/net/ynl/lib/ynl.py | 42 ++++++++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 7 deletions(-)

-- 
2.44.0


