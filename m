Return-Path: <netdev+bounces-265396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAhYGhR/rmlfFQIAu9opvQ
	(envelope-from <netdev+bounces-265396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:04:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FEF23540B
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D684830292DB
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0236B058;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqte8O1C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CA35CBC4;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043426; cv=none; b=FVtqKVbrmUZPM86elKg/5ssFRDNlac8tPMzMt+1y0NlVEBCZJbI6SNViMBb3bNw+73ZFP1p0EP53Et0aZc1DDej67k+tycwsmeDPBqPrwJiti5+NjwzADtbJ16vasXM9nTJGIwCYC2xyBg0o/3dPOSaHbJwzeoRK/+R63Knzo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043426; c=relaxed/simple;
	bh=3vpHAvYSJE1/E/Zw+R+U696ggtTJgVYAry+AHza2BC0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T3lZWeeGlnyJyI7lucIc4sHyoIQye+0LyH5MOK2XgiDYcv0iODltta6BkSI1B5/cBNeR+Fp+k47aCq67LKkPvKoI+GEQTQR6NKAACoAYRe5XTFT1uXwsuJWueQsOksCBNZrYzZUusqGm8usVgY0PEn84EWIC0S1MwS5vUTqmTWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqte8O1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FB41C4CEF7;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043426;
	bh=3vpHAvYSJE1/E/Zw+R+U696ggtTJgVYAry+AHza2BC0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Aqte8O1Cm40S2wOMu2x7Feh8H5HruVyUqkCwIz9uvhTbBZK4tIrnlTYKElFUgozOU
	 vDx17qJSpyMJRw8ZhdNEvStgwXyarUKdPK2Nl9wMsWb/T0/xQo2nLQ/qS0Li8rtNp+
	 qJRZMhgRlqELCTvwpsg/6tQ3Q7/Tv2SDzUx0XnVrm9Dq6UJnmks4GFMAb+kJe9Wqir
	 bjx/MefvwvEfHmLNUCIOFo2MPOa6+sxoYs/I5iV5yB7PftjIZ9gKarKDJ7Yt6SRhzR
	 v5qrcQKQUHW4SsoZ4/KeD9jW4U6J8V8R5xoj+mIise3a4B+ZdiOQfvmOzgjCYohxiL
	 6QG65DA+fXtSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39449EF36F0;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Subject: [PATCH net-next v3 0/6] tcp: RFC 7323-compliant window retraction
 handling
Date: Mon, 09 Mar 2026 09:02:25 +0100
Message-Id: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ6CMBQE0KuQrq0pv1jAlfcwhpTPLzSRQkqDG
 MLdrax0Y1zOTPJmZRN5SxM7JyvzNNvJDi4GeUgYdtq1xG0TMwMBSgAIHnCsvMFcgqw8Ba8xVA/
 XvDuOhYYGak11QywKoydjl12/MkeBO1oCu8Wls1MY/HO/ndN9/+thTrngpcjKDE4qzfLy0vba3
 o849Ls7w6elflsQLa2lKUyJqOSXtW3bC63aRgkcAQAA
X-Change-ID: 20260220-tcp_rfc7323_retract_wnd_rfc-c8a2d2baebde
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
 Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 mptcp@lists.linux.dev, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773043425; l=2738;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=3vpHAvYSJE1/E/Zw+R+U696ggtTJgVYAry+AHza2BC0=;
 b=kjc0s3J5JCYmq3GL3c4pN+j3Sh2jXUPcSLsACTyzPCeAcEecc5kYPGGaFYIVKCviKD9I/pjtE
 SqZlBqN54oHBpEBmApZTEBi2NMxOI3WSLi8DVVvnBfjjWaJhu1fQ5fm
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Queue-Id: D6FEF23540B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-265396-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

this series implements the receiver-side requirements for TCP window
retraction as specified in RFC 7323 and adds packetdrill tests to
cover the new behavior.

Please see the first patch for background and implementation
details. Since MPTCP adjusts the TCP receive window on subflows, the
relevant MPTCP code paths are updated accordingly.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
Changes in v3:

- Address MPTCP subflow-level rcv_wnd adjustments
- Removed RFC status
- Adapt tcp_rcv_wnd_shrink_nomem.pkt to reflect 026dfef287c0 ("tcp:
  give up on stronger sk_rcvbuf checks (for now)")
- Link to v2: https://lore.kernel.org/r/20260226-tcp_rfc7323_retract_wnd_rfc-v2-0-aa3f8f9cc639@gmail.com

Changes in v2:

- tcp_rcv_wnd_shrink_nomem.pkt tests more RX code paths using various
  segment types. It also uses a more drastic rcv. buffer reduction (1MB
  to 16KB).
- Setting the TCP_REPAIR_WINDOW socket option initializes rcv_mwnd_seq.
- SKB_DROP_REASON_TCP_OVERWINDOW increases LINUX_MIB_BEYOND_WINDOW now.
- Moved rcv_mwnd_seq into rcv_wnd's cacheline group.
- Small editorial changes
- Link to v1: https://lore.kernel.org/r/20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com

---
Simon Baatz (6):
      tcp: implement RFC 7323 window retraction receiver requirements
      mptcp: keep rcv_mwnd_seq in sync with subflow rcv_wnd
      tcp: increase LINUX_MIB_BEYOND_WINDOW for SKB_DROP_REASON_TCP_OVERWINDOW
      selftests/net: packetdrill: add tcp_rcv_wnd_shrink_nomem.pkt
      selftests/net: packetdrill: add tcp_rcv_wnd_shrink_allowed.pkt
      selftests/net: packetdrill: add tcp_rcv_neg_window.pkt

 .../networking/net_cachelines/tcp_sock.rst         |   1 +
 include/linux/tcp.h                                |   3 +
 include/net/tcp.h                                  |  22 ++++
 net/ipv4/tcp.c                                     |   2 +
 net/ipv4/tcp_fastopen.c                            |   1 +
 net/ipv4/tcp_input.c                               |  11 +-
 net/ipv4/tcp_minisocks.c                           |   1 +
 net/ipv4/tcp_output.c                              |   3 +
 net/mptcp/options.c                                |   6 +-
 .../net/packetdrill/tcp_rcv_big_endseq.pkt         |   2 +-
 .../net/packetdrill/tcp_rcv_neg_window.pkt         |  26 ++++
 .../net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt |  40 +++++++
 .../net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt   | 132 +++++++++++++++++++++
 13 files changed, 242 insertions(+), 8 deletions(-)
---
base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
change-id: 20260220-tcp_rfc7323_retract_wnd_rfc-c8a2d2baebde

Best regards,
-- 
Simon Baatz <gmbnomis@gmail.com>



