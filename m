Return-Path: <netdev+bounces-259615-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K0zISGjl2mf3wIAu9opvQ
	(envelope-from <netdev+bounces-259615-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:56:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F880163B86
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01B973004621
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6D32D7DE;
	Thu, 19 Feb 2026 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+0Iifi5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142A2F8BEE;
	Thu, 19 Feb 2026 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545364; cv=none; b=DbXxaJfkZNP5cIlBZY5Qpyu85DO/ppXFYAeEDFBum4Jam32goq1t7jxHHzhsdx17xXMbc5Wj8EWSht3qyxA2N+x7nfBO6YlGV0Nbjms3Bsu4EEbQkeoYf7P+pIPs70ySVBh96zr/P0N7AJ6QTyvWhotTHIIMYDfdY/V8kZUMOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545364; c=relaxed/simple;
	bh=A4B+KQUKfkALABSV4ypfoM7JWCIo0oQ5oJiT+QXtlgM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mrxmipTmLoCfmXG6MxASrInapV0BHCzevcE+P+tj3gQcJzxGEpGB6wePYAdrn+6LO+tl/HTg8pYCqVYjFMSRELa4JEx2M6sdQMeRh0hCe1klQiptQiDIZmhcvGIU6EYIk1dIFYvF3KEYhVypVWn1yTYQTyYp++uPPVU05dJF/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+0Iifi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F2F0C4CEF7;
	Thu, 19 Feb 2026 23:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771545364;
	bh=A4B+KQUKfkALABSV4ypfoM7JWCIo0oQ5oJiT+QXtlgM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=V+0Iifi5+SFjh+Yw/WgiKjgwHjI3opt4dXeXq6KoAbiYr4TQxojGCZMubfHRivQJ+
	 YGvgCLahfUFOr+UXWEDlgIqRQsOE9iVnbDZ0QrKmV1dzv91pXgd5fWUvK8dXv4rfXv
	 FRKUAwx8/klPljntVcQ8ZQO1MQU5VbW+w5sgL7VksiE0u/Xjwy/8uXr7bl4mbK4l2M
	 QnGMahUKy6iY8DIwQ2rGpyXU/HPUwaZc9BwBW6pMtaQW6geqZ3wOIdJZSFsB6Nthvk
	 W3hmgJEHHHBd8Nv8CC/ncRdHZuQ1hYzmtkEVC5hCiri2fCLOza50nX02rzTw7OW9Ng
	 dCLW8pYo7fEow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A93C531F0;
	Thu, 19 Feb 2026 23:56:04 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Subject: [PATCH RFC net-next 0/4] tcp: RFC 7323-compliant window retraction
 handling
Date: Fri, 20 Feb 2026 00:55:13 +0100
Message-Id: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQrCMAyA4VcpOVuoGUzxKvgAXoeULs00lzrSo
 IOxd7fz+P2Hf4XKKlzh4lZQ/kiVd2k4HhzQK5Une8nNgAH7gBi80Rx1olOHXVQ2TWTxW/LePJ0
 TZhwTj5mhHWblSZb/fYD77eoKmy+8GDy27QfkRiVoewAAAA==
X-Change-ID: 20260220-tcp_rfc7323_retract_wnd_rfc-c8a2d2baebde
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
 mfreemon@cloudflare.com, Shuah Khan <shuah@kernel.org>
Cc: Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771545363; l=3411;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=A4B+KQUKfkALABSV4ypfoM7JWCIo0oQ5oJiT+QXtlgM=;
 b=oNGmNjCqW5WuUBHxUhDcDVp1H6go11aygE11D7Wp0WGZ4sPYxX0QAVXGO6QFSqO1gf443g7kk
 EhnarpSRwfrCr7CdlrCXJ9zQP3PXVeF/8Y8odmcZ1PtJ9Di/MO7qMDy
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-259615-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[proxmox.com,vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F880163B86
X-Rspamd-Action: no action

Hi,

this series implements the receiver-side requirements for TCP window
retraction as specified in RFC 7323 and adds packetdrill tests to
cover the new behavior.

It addresses a regression with somewhat complex causes; see my message
"Re: [regression] [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks"
(https://lkml.kernel.org/netdev/aXaHEk_eRJyhYfyM@gandalf.schnuecks.de/).

Please see the first patch for background and implementation details.

This is an RFC because a few open questions remain:

- Placement of the new rcv_mwnd_seq field in tcp_sock:

  rcv_mwnd_seq is updated together with rcv_wup and rcv_wnd in
  tcp_select_window. However, rcv_wup is documented as RX read_write
  only (even though it is updated in tcp_select_window), and rcv_wnd
  is TX read_write / RX read_mostly.

  rcv_mwnd_seq is only updated in tcp_select_window and, as far as I
  can tell, is not used on the RX fast path.

  If I understand the placement rules correctly, this means that
  rcv_mwnd_seq, rcv_wup, and rcv_wnd end up in different cacheline
  groups, which feels odd. Guidance on where rcv_mwnd_seq should live
  would be appreciated.

- In tcp_minisocks.c, it is not clear to me whether we should change
  "tcptw->tw_rcv_wnd = tcp_receive_window(tp)" to
  "tcptw->tw_rcv_wnd = tcp_max_receive_window(tp)". I could not find a
  case where this makes a practical difference and have left the
  existing behavior unchanged.

- Packetdrill tests: Some of these seem rather brittle to me; I
  included them mostly to document what I have tested. Suggestions
  for making them more robust are welcome.

- MPTCP seems to modify tp->rcv_wnd of subflows. I haven't looked at
  this, since I wanted to get feedback on the overall approach first.

- Although this series addresses a regression triggered by commit
  d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks") the underlying
  problem is shrinking the window. Thus I added "Fixes" headers for
  the commits that introduced window shrinking.

I would appreciate feedback on the overall approach and on these
questions.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
Simon Baatz (4):
      tcp: implement RFC 7323 window retraction receiver requirements
      selftests/net: packetdrill: add tcp_rcv_wnd_shrink_nomem.pkt
      selftests/net: packetdrill: add tcp_rcv_wnd_shrink_allowed.pkt
      selftests/net: packetdrill: add tcp_rcv_toobig_back_to_back.pkt

 .../networking/net_cachelines/tcp_sock.rst         |   1 +
 include/linux/tcp.h                                |   1 +
 include/net/tcp.h                                  |  14 +++
 net/ipv4/tcp_fastopen.c                            |   1 +
 net/ipv4/tcp_input.c                               |   6 +-
 net/ipv4/tcp_minisocks.c                           |   1 +
 net/ipv4/tcp_output.c                              |  12 +++
 .../net/packetdrill/tcp_rcv_big_endseq.pkt         |   2 +-
 .../packetdrill/tcp_rcv_toobig_back_to_back.pkt    |  27 +++++
 .../net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt |  35 +++++++
 .../net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt   | 109 +++++++++++++++++++++
 11 files changed, 206 insertions(+), 3 deletions(-)
---
base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
change-id: 20260220-tcp_rfc7323_retract_wnd_rfc-c8a2d2baebde

Best regards,
-- 
Simon Baatz <gmbnomis@gmail.com>



