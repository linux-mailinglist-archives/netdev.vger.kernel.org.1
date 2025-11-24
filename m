Return-Path: <netdev+bounces-241136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A54BC802D7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F74E5DD5
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97F32FB0B3;
	Mon, 24 Nov 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn5nRsOf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AE12F9DA7;
	Mon, 24 Nov 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983182; cv=none; b=ZQTnemRF5A6bsi8z55cHpe99s6yY2toTB2Ulk/DZHGNbH3SI5dmpY3kWtSIxlhWunzj66trKg4KfEqS7Nc+HZMEdY+81oyxbSOAwRqIshOXUoSBkA3sD5NSPfyKaqCjbOtYIxrc1xXjQ/ZilVN5PNNlt+iVgNCSXT13xBLSNAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983182; c=relaxed/simple;
	bh=unYX2FJHz8jbaZtItwN8xl+kAJjn00RtndYpWZ3DSLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lCg4m54PvPBkHBs+k1eCH2CJIPKkZsjJkewJZCemgOKK2Jxn5NhNFxC8X5uysi5gB+TAW5+/iL6PuanE6Fq3ayWp5Z/Gz3NQLFDrmQKbp7gp1gl+HZF42XMOwJjdcgo/49hsp629j6zYrAqaFgqdfbvjCg+wN1CEVBcYfGHza4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn5nRsOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02715C4CEF1;
	Mon, 24 Nov 2025 11:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763983182;
	bh=unYX2FJHz8jbaZtItwN8xl+kAJjn00RtndYpWZ3DSLY=;
	h=From:Subject:Date:To:Cc:From;
	b=cn5nRsOfndN9k9JojmkOm0W2+ZGoW9QItbHFcfwThiP8QiNzAXvmUv3An8ggoOAY5
	 XzMFHweRHAIyv7GahPQCMS082aQ5k22G+9L5ZTCIzb520IUqhmvRrY8VHqfYrd6xZs
	 BUIlSPIRbq1MUHF80O6XY66qDHAA0BzBAc6Kuv1iLxj6MezHXZCgrXM1qT3co/tHlK
	 iBn23UcQfST/XrYh3Nw6prsBeZWob01FOjxOMsO6qn+2+9Jv9yPChw8gCkmLZ7qxJj
	 dQijH/QS338qjczA5Catn7XFU2DTlf0Q5E3Qz3qxAndTcAX0GelAaoc13hxM0uzjoX
	 e+v0oH4GhvKkA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH iproute2-net 0/6] mptcp: new endpoint type and info flags
Date: Mon, 24 Nov 2025 12:19:20 +0100
Message-Id: <20251124-iproute-mptcp-laminar-v1-0-e56437483fdf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADg/JGkC/y3MQQqDMBBA0avIrB0wU6utV5EuQhx1QGOYpEUQ7
 26QLv/i/QMiq3CErjhA+SdRNp/DlAW42fqJUYbcQBU9jaEaJej2TYxrSC7gYlfxVpHe7cMO7Oj
 VVJBtUB5lv789/Amh5wSf87wAmWKtHnUAAAA=
X-Change-ID: 20251124-iproute-mptcp-laminar-2973adec2860
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=unYX2FJHz8jbaZtItwN8xl+kAJjn00RtndYpWZ3DSLY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJV7D1Ov972emdgisRdW+PPByscGz7PXBB6q/pll1tPt
 k2s5pJXHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNZFsDwh/tWBc9JMS3n30H1
 dmUBNfmKN87Nz9l4719TM2u6aLCELMP/JAvlTW0MSWdXPbxxpFnor6/TQ3/pczt4the2JvTtrRZ
 gAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some patches related to MPTCP, mainly to control features that
will be in the future v6.18.

- Patch 1: add an entry in the MAINTAINERS file for MPTCP.

- Patch 2: fix two minor typos in the man page.

- Patch 3: add laminar endpoint support.

- Patches 4-6: display missing attributes & flags in 'ip mptcp monitor'.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (6):
      MAINTAINERS: add entry for mptcp
      man: mptcp: fix minor typos
      mptcp: add 'laminar' endpoint support
      mptcp: monitor: add 'server side' info
      mptcp: monitor: add 'deny join id0' info
      mptcp: monitor: support 'server side' as a flag

 MAINTAINERS         |  7 +++++++
 ip/ipmptcp.c        | 20 +++++++++++++++++---
 man/man8/ip-mptcp.8 | 20 ++++++++++++++++++--
 misc/ss.c           |  2 ++
 4 files changed, 44 insertions(+), 5 deletions(-)
---
base-commit: 2a82227f984b3f97354e4a490d3f172eedf07f63
change-id: 20251124-iproute-mptcp-laminar-2973adec2860

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


