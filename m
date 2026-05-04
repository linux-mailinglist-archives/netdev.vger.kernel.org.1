Return-Path: <netdev+bounces-283786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CVhOdZ1+GlavgIAu9opvQ
	(envelope-from <netdev+bounces-283786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:32:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 724BB4BBC6C
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1161A3006941
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0307391E57;
	Mon,  4 May 2026 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxVBggCC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18238C423;
	Mon,  4 May 2026 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890523; cv=none; b=p99ETSpdR0z5pg7ksK4kO9g5e0KLd3oB70DXPOeet3HODAQWdakep2Up4xME+J0W42VC1nKUBavVsD2klM12YWW++i+/OkWJw8Ap9dDRPnXT6oSvbE/92KiqvOAfSxivHyTBoHGxgvq7vpHKOut/efhryX4rT1JbxWBqK3NxzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890523; c=relaxed/simple;
	bh=xoDnCBn4Jdqrut/JrWmmyw0jL/Nw+l0VBLZOEKZTgoc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YBXk/TyIPq+ijp+pMlTqOJcXNaCo9drR2dQ44LEq+9qKxJ9I1HvsXmG17xh9Q9WngcmJFHPfPS8IfEAHdHUM6pA1P1HWyuwgz9ruyXYWcJ6Gwdnqt9WVgw9TbKQeCgadYuDok0NRjRLnQz4/u9NsMskg9GZIn/OfggGU3Z70D3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxVBggCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881CCC2BCB8;
	Mon,  4 May 2026 10:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777890523;
	bh=xoDnCBn4Jdqrut/JrWmmyw0jL/Nw+l0VBLZOEKZTgoc=;
	h=From:Subject:Date:To:Cc:From;
	b=NxVBggCCXX4ntHXBsU06Uy3y5uM/bSgXAMjG/ZaBxWFQm1oortYGtuOnY868vNUF6
	 Pdr+IC8jxF7k5bf2EvnyupKaKQwrA18rKSkyUoNhnGHuLVkaq4gAiPIDIKeKDa8bB+
	 7RCDEzxtFh33KzAVxWRSsuLgxF5ap92Sxy9wLUDh4LKZJ49XlKXZOA90fKNQ8vHsO0
	 k3AYUuCeQ6LtS2cu+h3Gfjg2zdXr3rqRSJaOWRZjXsLAy4IoKtezcBC2VhQtI7iDgX
	 rHLRaFhzviKUTvzpqriMihfzYD2+aHCLVGvcC0cvsnt5DEQ6HRrw4gsKoz0XLjGo67
	 rHD67Fi0k8JMQ==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH 0/2] Fix a few memory bugs in RPC-with-TLS
Date: Mon, 04 May 2026 06:28:17 -0400
Message-Id: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMF0+GkC/yWM0Q6CMAxFf4X02UYgwoy/YnzYugI1pJJ1GBPCv
 zv08dzcczYwTsIGt2qDxG8xeWmB5lQBTV5HRomFoa3bvu7qC9qqaSHMsyHNmnERRWqod1fnOh8
 ZirkkHuTzq94ff7Y1PJnykToewRtjSF5pOibi+ayDRcxsWXSEff8CDVp2YJoAAAA=
X-Change-ID: 20260504-sunrpc-tls-clnt-pin-c1c678775ade
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Michael Nemanov <michael.nemanov@vastdata.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=xoDnCBn4Jdqrut/JrWmmyw0jL/Nw+l0VBLZOEKZTgoc=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp+HTH23ae+Vk+Ck3z4on8qTHVu8d1uKQln3/Q9
 DvSP1BdvweJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafh0xwAKCRAzarMzb2Z/
 lyNID/9RKhJOgL+ZJ5ewSUAJ79xVDGNZGCOx3g2NJiDUebNCdI5YhcgLzsoKzRvKKpXE79SsQFn
 dx2icLp7+7DuEm5iD24D79+Hz4AuomWDgg2h5R0luPVNzOE6Ok3OStmknx9LN2SVhplo3+FjwfF
 33E/Cs04HGnaRktxXzknOmoQxhfQvtVhTLUxYF8asEV6Ln1I26CzMf6Tdny7wH6yReg+HpGOLdB
 c4L72o+95larmbEyS52rh/UOmRD2vLjnzvr43spzA6m6x7Jy9QhCpohMC+jB5VH0aJ7GCGEzaQQ
 xQN0eaLrFjdtVcy8laELze7aU8qu3f6FG+hho6yOX7qy+/bS1Eawy1ZEUtM4sTw9oWbdkGDsO0j
 24dlquXdO52uROOzy2reTXYSdNvSaFJyhxo3LRzAWwJMeFC9CJALDKGi2Qt4vXKBjnSuX+s3HBw
 LqQBB7bM+VWsqA8VvoZhjT9Qygc6hQ+U92djnIW8HxzWH3QrE42GNyiEpLGCmMtcoAta5Eu1Y/g
 seZosPB5lA6KgjH4KBQhSruEBGcnOZdO0CG/H0UTahbJ7ai3k1BrYQ9PAXhUnpIud+YAGtXFxZr
 G7YuaBk5Kf7kY7wGfjqK5Q1WPpJUBdg42HlEag4PaEQt06/86YkIBU0BZ88cEyrCJ5sLYuZZFwS
 pYPCD7cwgy/m4Gw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 724BB4BBC6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283786-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

xs_tcp_tls_setup_socket() leaks the lower rpc_clnt when a signal
interrupts its TASK_KILLABLE wait for XPRT_LOCKED: the killed-wait
path jumps to out_unlock without calling rpc_shutdown_client(), so
the clnt and its xprt leak. Patch 1 calls rpc_shutdown_client()
before joining out_unlock.

Patch 2 fixes a use-after-free Michael Nemanov hit on an mTLS mount
whose client certificate the server rejected. Nothing pins the upper
rpc_clnt across the delayed connect_worker, so a fatal handshake
failure can let the mount caller free the clnt before
xs_tcp_tls_setup_socket() runs; the worker then dereferences freed
memory. A new rpc_hold_client() helper takes a reference for TLS
transports only and drops it on the worker's exit path.

Compile-tested only.

Recent related threads:

[1] https://lore.kernel.org/linux-nfs/20260309112041.1336519-1-bsdhenrymartin@gmail.com/T/#u

[2] https://lore.kernel.org/linux-nfs/a57879782d2d383e2d1af292fe2b9005a43ea06c.1773263233.git.bcodding@hammerspace.com/T/#u

---
Chuck Lever (2):
      SUNRPC: release lower rpc_clnt if killed waiting for XPRT_LOCKED
      SUNRPC: pin upper rpc_clnt across the TLS connect_worker

 include/linux/sunrpc/clnt.h |  1 +
 net/sunrpc/clnt.c           | 19 +++++++++++++++++--
 net/sunrpc/xprtsock.c       | 16 ++++++++++++++--
 3 files changed, 32 insertions(+), 4 deletions(-)
---
base-commit: 22ca5f8e836e43f49c9b622f60e7ee48012a81c3
change-id: 20260504-sunrpc-tls-clnt-pin-c1c678775ade

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


