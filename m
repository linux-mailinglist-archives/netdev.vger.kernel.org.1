Return-Path: <netdev+bounces-293032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEy8Nm9FGWrHuAgAu9opvQ
	(envelope-from <netdev+bounces-293032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:51:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4DD5FECF5
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9243090266
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67AE3B3894;
	Fri, 29 May 2026 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="WOJcZml3"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57405342507;
	Fri, 29 May 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040732; cv=none; b=MJ4sVgn4U5NAIG+J0ZIwHl+ifx3iohpHspNLK7EVCYxuyxg2LZbLR9LOgwkAc7aW6XAkHrQzD3Vc0GhyyloQIJPC9rXE4R9XfO4kmnIyHmM3j/qTj8G3xKotklsKpq12D6O5yLej71e+wfKtT5jt4bamOGLi12jOSk9PYBEoKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040732; c=relaxed/simple;
	bh=V+fWrbXEkgJq7sZ8FP4Mw7u/nUWzeu+529+F2WCqw4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HSuQKg6rXcIeCY9dOQQmwS804uyGH2jBBcgorXCm6ye5ulMA4pdNXheKp9ByFyQNnmPHHynNN22iUGIZriygBHPreG342W7owXy19yjrIpIqjgT68svuDt+NjB2J5inICK3vpmjBLBVnoLVeGJ7X82HFkNxkmdzPVy17Oh6txcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WOJcZml3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=tuUYV6q8F7uU6pcbL77F3mVfiEjN4CQIbUjssP+vxw4=; b=WOJcZml3HSyUeCYsbfQdtL43Ax
	aPyxMBDCqDkuR8zgHQd2RwnZw0l2Czqi6qjhoVTaUQacRzm6WrVsRXyK+xy9mHeEpSHbvN+NooN69
	bsN2ZJSV/0vFpBKdcb65TnES0aaeAoFzKE+oVfnLB1hSv94TwtCFB9mERgqMlhkSQ29obZ06uwjki
	uEqeESDEfW+LI+Oknby8QfYKHngsqX7wFCIrvuuWkYq0qstc1qnr2idkaH2DHDeKIyIN16cwORpqW
	uapZDp8Zzbzqo8K83McehA18aWnLHSdxS8QFvPvxUzlQvI+LaJwo9jwfrrQjqW8uD8YIi3u3Ji9Um
	YWQwd+yw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSruA-004kLy-2r;
	Fri, 29 May 2026 07:45:19 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net 0/3] netconsole: Fix reported problems
Date: Fri, 29 May 2026 03:45:10 -0400
Message-Id: <20260529-netcons_fix_before_move-v1-0-cb2d1426dd75@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZEGWoC/12N0QqCMBiFX0X+6wa6nAxfJWTkdlaL2nJTCcR3b
 5l00eU5nPN9CyVEh0RtsVDE7JILPofqUJC+nv0FzJmciZe8KQWXzGPUwSdl3Uv1sCFCPcIMpk2
 jLXQNaQXl9zMiTzbyifKJum+Zpv4GPX6Y+yximLJ33Lc/bVv8S8MdaoOyozA1Kiul5LKdK+rW9
 Q0tfPoxywAAAA==
X-Change-ID: 20260528-netcons_fix_before_move-cd6cfec4e8f5
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neil Horman <nhorman@tuxdriver.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=leitao@debian.org;
 h=from:subject:message-id; bh=V+fWrbXEkgJq7sZ8FP4Mw7u/nUWzeu+529+F2WCqw4w=;
 b=owEBbAKT/ZANAwAKATWjk5/8eHdtAcsmYgBqGUQMhoJssY/wErsXDaSU2Edqpd8qSFwpqX9bW
 9MUL5po5syJAjIEAAEKAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahlEDAAKCRA1o5Of/Hh3
 bTtpD/i//k+vv7RjEljWHGvEDt+IqYM38wX3v4w+jEOuNmp/seYSqcD3wZ3+ubV1Nt+aEaNuxKZ
 wWegBIpNHYVDyiPiw6Gzp/Vw8b5h2A8uz6xF7pmk7lROH0Ayuq1Cve0hQ8j/lxB0kIyjJPnrH70
 3NzNJgSMWPStMl0zq9/PVl39RgHIjv9QM8VcZO8LrSEkHi6N2a/PTvntH5PqbVT4MVroxUKcdN2
 XlcWhcbM6DzV07Ay4YSoPpjfN6xXh+Vq2xO9YDi61QBJDGktM3j3zDsBQzvzTEX9/B93PLe6+FE
 fHziiS1au039BD07AIKsYj8sjTwjQE7nY300IUmqGy8J4PLpPEpGi8efXiFhOnPIvumfuOzcUaY
 A7E6+6Xht7muz3NjX1vVpb0mwOjLe0fZRTID3qVZBE6fzpFOqJcAM+nduTrIJEvPowhbiFFnxTz
 k7IfnHFHAgZPA/DfYhIjwZc/oun/7aV4qwkr0GHhUuvjJenXBr9ih3zFlkyeGdaHWLqY+G3LKhC
 2uqZEadG0cKPnAwKhT6fI7Pzw2aGChbI6F9wWBi6tsS0AS2Brxt+X4FrR9fnmPMC6I1UE6Uzuke
 x/8L5g1QIhAxLvzk/+gMP6wbJ5eFr4ca7OUo8sT+LGYhkgwbWObPMkkegk4FC6VRAcRc2ONOj/Q
 fRl7uWytckDJB
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293032-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,tuxdriver.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F4DD5FECF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These are some of the issues that LLM reported to netconsole, and they
are being addressed here before big refactors.

I was doing some big refactors, and got some "pre-existent-issues"
during LLM review of the refactor, that make them hard to guarantee that
refactor is not introducing any bug, so, let's clean these pre-existent
bugs first, and then submit the refactor.

The issues fixed in this patchset were reported during the review of
https://lore.kernel.org/all/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org/

Not all of them got fixed, but, those that were easy to reason about.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (3):
      netconsole: do not schedule skb pool refill from NMI
      netconsole: do not dequeue pooled skbs that cannot satisfy len
      netconsole: take target_cleanup_list_lock in drop_netconsole_target()

 drivers/net/netconsole.c | 26 ++++++++++++++++++++++++--
 include/linux/netpoll.h  | 16 ++++++++++++++++
 net/core/netpoll.c       |  7 -------
 3 files changed, 40 insertions(+), 9 deletions(-)
---
base-commit: e7e28506af98ce4e1059e5ec59334b335c00a246
change-id: 20260528-netcons_fix_before_move-cd6cfec4e8f5
prerequisite-change-id: 20260528-netconsole_fixes-35d4e1f88828:v1

Best regards,
--  
Breno Leitao <leitao@debian.org>


