Return-Path: <netdev+bounces-287099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE6vOE0MA2pI0AEAu9opvQ
	(envelope-from <netdev+bounces-287099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:17:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6551F35B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8677303C43C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43D538E8CA;
	Tue, 12 May 2026 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YsKwi0Hr"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1598E395AD6;
	Tue, 12 May 2026 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584358; cv=none; b=KrotHFJOW8XpiYztFxaUmE4EgqDwvDaqfCjMPV7b6ziMZ0JuUyavvqoTr6mRuXRTWv+VMUkQMYhsGIdPFTS5lf6QRybwjU5KCo8EhFfB+1i0m9154kVd4aH0Py1O7SczGnNrGZaKB20aBfZ9fFHMGDGv6+5wbSedAFGqRjOktRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584358; c=relaxed/simple;
	bh=075mEFrwhO8lYzDCuk317bkR4GsVhyvSAsNkfbwmGRQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n9rRS23atmLioHpA9FGXLOTo7aARxF+yz7bOtcf0DVF0AldoA8/wpG3/n73cTVj/rTsJynZi7FLN/ADRSJx2s1uh25VW5qrhF+TLWOPIWqZwAJnzIXq5nZXqRv6C1Sx9cvZViPgahCUlAQQdFFjzBmuAdIjOmN4jcl+RkG1ZHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YsKwi0Hr; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=OemVZTlGneGOtNTeJm+06qjgoJUmri4JPX55WVVbYnA=; b=YsKwi0Hr7lat7ROqYZFfZbnHzz
	iu0S1hdCj94bRmp5trIXkXPWOkvSG4qTOXdQcrBOaQ3wi6CptUdCJ2qN3JZAq1AVUA57+A8NCFvig
	PO1vLLCMjhCJzGBbz+G8S6Nt74RelWX5VD3iuOPcokUGbh6+ChaxsDF+FWnICf4Sr9bRa9kJs4ieG
	gLz2at2KOaKtxxF1FPSEWq3RnSiohexFuOSGoTVzCNlLjfG3ObHH8RKdAnUC23EiLRgMXvO4QV8xW
	dgDWG/GvrsSyXxo44E7NeGoTR/gy/NiWu6h65lioV0ZmNemhN0JCDDIfQFV8qWkIZuUPnOH+zyqHJ
	vIem42tg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMl2N-002KqO-2P;
	Tue, 12 May 2026 11:12:32 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/6] Bluetooth: convert remaining bluetooth
 socket families to getsockopt_iter
Date: Tue, 12 May 2026 04:12:15 -0700
Message-Id: <20260512-getsock_three-v2-0-30b7b22ef14c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA8LA2oC/3WNQQ6CMBBFr9LM2ppOowVZeQ9DTEsHGE1a01aCI
 dzdgGvX//33FsiUmDI0YoFEE2eOARqhDwK60YaBJHtoBGiljTojyoFKjt3zXsZEJL3yVY9OG30
 hOAh4Jep53n03CFRkoLlA+1vy2z2oK5tuY0fOJabPnp5wf/ypTCiVxJPB3tZVbay7enJswzGmA
 dp1Xb9HJEKPxwAAAA==
X-Change-ID: 20260511-getsock_three-d0d7f1b2629e
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=leitao@debian.org;
 h=from:subject:message-id; bh=075mEFrwhO8lYzDCuk317bkR4GsVhyvSAsNkfbwmGRQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwsa32/PpdTQ36RhV2dX2/tPrWP1DkunJuz6a
 i8BKMCOWoSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMLGgAKCRA1o5Of/Hh3
 bU7ZD/9ENobipZOnFCKIxlOgMc+qLBUtjeuZDJrnrZbuTIyIrTbtOS2DuOokgiJnPO/exjkE+RF
 ocYwN+y7OpHwsit/YO53RLubK/2tqUKQqJCPk5LD3T/Btdw4ziHdqJhJ5iuXbkAB1DRGpeqfSxB
 aRlvk8PJ93O4sJcEMLOa0VXZKVKIwFqkAHVHFsT1NIsIrF1aVYrsoZcxff5Bx77QWl09K5YVt1h
 qvoXQClOKkyC60Ikrk/3kzupjTJ7KooXuKBAPwj8ye4KF9tjSC/AcLhkNhYhTgHEPmdWtfEE3XY
 f1nsNFSzirRcyj+5Ix05EtlGl/nNiD/72L+pGQqQv0BJ/9OcDqDCwcgK/n2DEjSHXjoXEK9+cNU
 OZwShndJLSZqcXeX8HKbkjm31cB22pJB+5TSiPP87kKqzO5AfOstrO/eWGeNXC+GEyPmAGmYN+F
 pE9OUCAHVPD1SKQMEYKERmXbNqcjhIvc5nHBpqRpX+lqCaILXlNjoKgg6ieefHVeBfsknNmEALd
 C4oIawqUaXOLryr430Nj+8NtD+ysLWWG6ITSJ5pIuqUYSr6SCi4uel16aSBAaW+4RpooFbCcPUE
 hhRJrPFPtY6HUXBvi18CyQnmiTUE1dnk1dplQQEsS7Q6mQXyCEHWB2VjCYgy+oDoHwrTWOdHTX6
 EhXJphLggWZMe9g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 7FF6551F35B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287099-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,holtmann.org:email]
X-Rspamd-Action: no action

Continue the conversion to .getsockopt_iter for the Bluetooth socket
families: hci_sock, ISO, RFCOMM, SCO and L2CAP. The first patch is a
small precursor that fixes a long-standing 1-byte put_user write in
hci_sock_getsockopt_old() so the subsequent conversion stays mechanical.

The riskiest change in this series is the SCO BT_CODEC conversion: it
is the only one that drops an open-coded ptr cursor in favour of
relying on iter_out advancing naturally on every copy_to_iter() call.
Every other socket option is a near-mechanical s/copy_to_user/
copy_to_iter/ rewrite, but BT_CODEC walks a variable-length list of
codecs + capabilities and previously tracked its own write offset by
hand. Getting the cursor semantics wrong here would silently truncate
or misalign user-visible codec data.

For more context about the motivation for this change, please check
commit 67fab22a7ad ("net: add getsockopt_iter callback to proto_ops")

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- rebase the tree on top of bluetooth-next.
- Remove the selftest, which was mixing network and bluetooth together.
- Link to v1: https://patch.msgid.link/20260511-getsock_three-v1-0-1461fa8786ab@debian.org

To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Breno Leitao (6):
      Bluetooth: hci_sock: write the full optval for getsockopt
      Bluetooth: hci_sock: convert to getsockopt_iter
      Bluetooth: ISO: convert to getsockopt_iter
      Bluetooth: RFCOMM: convert to getsockopt_iter
      Bluetooth: L2CAP: convert to getsockopt_iter
      Bluetooth: SCO: convert to getsockopt_iter

 net/bluetooth/hci_sock.c    | 26 +++++++++++--------
 net/bluetooth/iso.c         | 27 ++++++++++----------
 net/bluetooth/l2cap_sock.c  | 61 +++++++++++++++++++++++++++------------------
 net/bluetooth/rfcomm/sock.c | 30 ++++++++++++----------
 net/bluetooth/sco.c         | 59 ++++++++++++++++++++++---------------------
 5 files changed, 114 insertions(+), 89 deletions(-)
---
base-commit: c2f0079e8c42fd6814c8d6b1491e3ce0a0e3b3fa
change-id: 20260511-getsock_three-d0d7f1b2629e

Best regards,
--  
Breno Leitao <leitao@debian.org>


