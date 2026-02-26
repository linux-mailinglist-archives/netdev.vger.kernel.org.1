Return-Path: <netdev+bounces-261106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDM6EaaYn2k9cwQAu9opvQ
	(envelope-from <netdev+bounces-261106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540619F9A1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 399D5304FA5B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168936F42C;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtkdZINV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805613612F4;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772066966; cv=none; b=ZapP+Xz8WYiUri3iIyIyPpd0ffUAhw2YGYgSN+px8Q5szpgp8xXxOJYhjJFHF4Di9FgPnG0+7HuFe6+jJ5sk61VtbnfQi3sP+d6U8XySYR2Vp1Ib0UccODHfvLcdUTGw74fiJbgMMzp1iPKDZvKM3ETb3gltQkuVxnmik+lSB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772066966; c=relaxed/simple;
	bh=YHtDERu+dGZKwokXML/KbGIAJKjFs9XTNnGWe5MyxQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fcKr6O/T1OQutWFLJa0OV6MQr4SdzMVOQy3NERN12y2czMwSGQxaR7k2T66aAdH8enfzouOvwvgjOoNc5IK6DryrqNiThIw1za7U7COZfRGRuhq/sfNACiAOjCgtG65Q2ni6JCKqJOO/5AXf++zF8LS0zyvumZbzt/RbPkUAkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtkdZINV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25FF2C116D0;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772066966;
	bh=YHtDERu+dGZKwokXML/KbGIAJKjFs9XTNnGWe5MyxQY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZtkdZINVIFGs2UX3J1me2TerYygxXkAhPLMVcLaXe9Kc0VBQAmhWrJ2bTGzfEMsMA
	 ZYOQqY92urwxvmCPFXq/4dCjP6IT6RMBykn3RqpBke24EVnmDlCkVU+Ni4FSK9unjV
	 fsgVHB1stLXXigkdjHDuls9DbnVww+v0UeXxU852O7zRJExz5h19LhDQhugZoHQIyN
	 YdjOsQFsWz2GgU6DlBHTucko097nCTSe3aRU7jr6EoafMzCcf3L1aOtwhr2P9MTSRh
	 7RilUuWvMNKaDgC+JVPPxN2fCqWXPMj9E+9RIiRjowE597J/l6HyXyzI5U9401yw+F
	 ydIt0d7Asq+YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED18FD45FF;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Subject: [PATCH RFC net-next v2 0/5] tcp: RFC 7323-compliant window
 retraction handling
Date: Thu, 26 Feb 2026 01:49:06 +0100
Message-Id: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-0-aa3f8f9cc639@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42N3wqCMBSHX0XOdYt5NM2ugqAH6DZE5nbUQU7Zh
 hmyd2/5BF3+/vB9Gziymhxckg0sLdrpycSAhwTkIExPTKuYATkWHJEzL+fGdrLMMGsseSukb95
 G/TomzwIVtoJaRRAJs6VOrzv9CY/7LTHkmaHVQx3XQTs/2c+uXtL985dlSRlnFc+rHE9FmpfVt
 R+Ffh3lNEIdQvgCiPkMpdQAAAA=
X-Change-ID: 20260220-tcp_rfc7323_retract_wnd_rfc-c8a2d2baebde
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
 mfreemon@cloudflare.com, Shuah Khan <shuah@kernel.org>, 
 Stefano Brivio <sbrivio@redhat.com>
Cc: Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772066964; l=3983;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=YHtDERu+dGZKwokXML/KbGIAJKjFs9XTNnGWe5MyxQY=;
 b=N0mn084EpHoTzzizetrZ3FJM/LK2M7Xhs7TrG0vLQs7Vld6CoyM/xKEdyG4BKmEp4cPfefUoI
 lgc8R4hpclvDUoFb7xF0KiCNm/S+71rDNMv+Ka7mjP+yqO2gyxzl0RA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-261106-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0540619F9A1
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
  tcp_select_window(). However, rcv_wup is documented as RX read_write
  only (even though it is updated in tcp_select_window()), and rcv_wnd
  is TX read_write / RX read_mostly.

  rcv_mwnd_seq is only updated in tcp_select_window(). If we
  count tcp_sequence() as fast path, it is read in the fast path.

  Therefore, the proposal is to put rcv_mwnd_seq in rcv_wnd's
  cacheline group.

- In tcp_minisocks.c, it is not clear to me whether we should change
  "tcptw->tw_rcv_wnd = tcp_receive_window(tp)" to
  "tcptw->tw_rcv_wnd = tcp_max_receive_window(tp)". I could not find a
  case where this makes a practical difference and have left the
  existing behavior unchanged.

- MPTCP seems to modify tp->rcv_wnd of subflows. And the modifications
  look odd:

  1. It is updated in the RX path. Since we never advertised that
     value, we shouldn't need to update rcv_mwnd_seq.
  2. In the TX path, there is:
  
     tp->rcv_wnd = min_t(u64, win, U32_MAX);

     To me, that looks very wrong and that code might need to be fixed
     first.

- Although this series addresses a regression triggered by commit
  d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks") the underlying
  problem is shrinking the window. Thus, I added "Fixes" headers for
  the commits that introduced window shrinking.

I would appreciate feedback on the overall approach and on these
questions.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
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
Simon Baatz (5):
      tcp: implement RFC 7323 window retraction receiver requirements
      tcp: increase LINUX_MIB_BEYOND_WINDOW for SKB_DROP_REASON_TCP_OVERWINDOW
      selftests/net: packetdrill: add tcp_rcv_wnd_shrink_nomem.pkt
      selftests/net: packetdrill: add tcp_rcv_wnd_shrink_allowed.pkt
      selftests/net: packetdrill: add tcp_rcv_neg_window.pkt

 .../networking/net_cachelines/tcp_sock.rst         |   1 +
 include/linux/tcp.h                                |   3 +
 include/net/tcp.h                                  |  13 ++
 net/ipv4/tcp.c                                     |   1 +
 net/ipv4/tcp_fastopen.c                            |   1 +
 net/ipv4/tcp_input.c                               |   7 +-
 net/ipv4/tcp_minisocks.c                           |   1 +
 net/ipv4/tcp_output.c                              |  12 ++
 .../net/packetdrill/tcp_rcv_big_endseq.pkt         |   2 +-
 .../net/packetdrill/tcp_rcv_neg_window.pkt         |  26 ++++
 .../net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt |  40 ++++++
 .../net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt   | 141 +++++++++++++++++++++
 12 files changed, 245 insertions(+), 3 deletions(-)
---
base-commit: 2f61f38a217462411fed950e843b82bc119884cf
change-id: 20260220-tcp_rfc7323_retract_wnd_rfc-c8a2d2baebde

Best regards,
-- 
Simon Baatz <gmbnomis@gmail.com>



