Return-Path: <netdev+bounces-111329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FB9930874
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 06:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C29D281C4B
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 04:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D74DDD4;
	Sun, 14 Jul 2024 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEX9kvu7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B44D51D;
	Sun, 14 Jul 2024 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720930277; cv=none; b=rCk1SCFQt6keuxXzzQixQ3Tygqot1mupCCbuPmk1OiDhYinsxr0FsrH+xiXWzea+ku+FRaIW0iHJzKb6m5S5bFygwOkQGqLBNNfhGTq7mm8fPJpHnzfkW4FmpeGnxUacOkkVkBR6jqu+9pCXfDMwCL0FKqUH9Plv+Fkyo4cKT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720930277; c=relaxed/simple;
	bh=CS0Ls0MuwNsY7hOa+wW/UsNVnthdrSTKsX+XpH3xDYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rwg8vLnPVoOXiIxDukq8d2b3tJ68IhWjmXpbD069b4Gd/KixDubPzsH94hHiK5GgJ1t9TxKiQtozn/4z2OYpsDos2iVdQuJMUaU0RDVcGKNlWX/afebDHZ54y7mqtqZLShkViPGkOJm6JbPFt83PfsEyueJ3tKQhpw7u0lh8JLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEX9kvu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC3CC116B1;
	Sun, 14 Jul 2024 04:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720930277;
	bh=CS0Ls0MuwNsY7hOa+wW/UsNVnthdrSTKsX+XpH3xDYw=;
	h=From:To:Cc:Subject:Date:From;
	b=lEX9kvu7A9gADCi1IUDUpTr8TMa1B1wpaLd6o+/gtzIxnUWmY7cDYJ6JosdFTFDLF
	 hmBJmAMYe/3d9t93CrOFE/f1TWyKk9vxeBlnixlFg224lRL2CDyhZMffOQ5i9D+Em8
	 iqYViJNAbLHpQcMiJEZ+jfL9mA6SWLixsmbjGeeGgz6DYunlXNWUQMF9M1F2lYNIlq
	 gDZOydTeHj1Rk1iUTWvFH5XhVI67Ter0+HHwufQkpkCKFRZhjyl73VEhwrxqrXU3Tr
	 ebYBmiA0TAkBbC0e9gyntQE6SPpln7cFXUC4LiBa64Y1G5UPBMk1O7aJpDsiEhA0io
	 VrH53q6HHa85A==
From: Kees Cook <kees@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] net/ipv4/tcp_cong: Replace strncpy() with strscpy()
Date: Sat, 13 Jul 2024 21:11:15 -0700
Message-Id: <20240714041111.it.918-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=kees@kernel.org; h=from:subject:message-id; bh=CS0Ls0MuwNsY7hOa+wW/UsNVnthdrSTKsX+XpH3xDYw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmk0/jgqbYNdSchEcFgoVX5gQ/Vj0Ot35vBhu9E p+U+m0RVseJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpNP4wAKCRCJcvTf3G3A JmBdD/41cm3ixFlgvt+VTgOfuFtJer3iyrrw1QmIuc2hf4ebF28VSORUg44rUzEVCHy8n5wY0VF 1OpxjPS1Htytu9Y2d+Xn3GEz91PnDn+OZE6d54uLbC0qzb183KfUYfUuITMBtUS++nyjyJ9SUJ0 5nGcIERWU5XUUnGQVjFZrxZ1eQ76iizWq4O7WSveoYVhP/upTBCpf/eIRHwB3izjHY6K7tOUvhC QhdYX8IGmUb1hWSRTfq4Wr94toe6e313+9ocBIpIkhYkgaw77ERAT1h6TyEufdDtzE23aGQTAJ/ 8JmOrBORwYrCXnlNs9AuaaX5yYYsklTcgahAAN6O7ptb8a4O3yjCvXgCUBYD4PO8+dtMfYmuGVR euZ/BC4qnjACAVb53JGxfJsu3wbLlDWSF+YE19ileJubBWwX1u2wWlRgiupFIgGz6iBD7fa6fLe F2kN9VbFWg1mqz6KMn/qzDPDIffhrqrsMbmCiClIM8eCMR05geGtKWzmoDPFw1Mh366KdXll6yY XjcnEpJehvu7EvllqyHQq31utMC7d3W6sHQtd6dfIGZ2S/4YmJIRdnNXnQpPETzvQ1WfUjmJtPf TWeaiZE5FuwSfOVrm+AIbeBt/OFmlUo8BwbW99hrZIyejAkZ26Qc6SUEasAImP5RvODbf3sMOve FKBNes9NN9zgK
 Ew==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] uses of strncpy() in tcp_ca_get_name_by_key()
and tcp_get_default_congestion_control(). The callers use the results as
standard C strings (via nla_put_string() and proc handlers respectively),
so trailing padding is not needed.

Since passing the destination buffer arguments decays it to a pointer,
the size can't be trivially determined by the compiler. ca->name is
the same length in both cases, so strscpy() won't fail (when ca->name
is NUL-terminated). Include the length explicitly instead of using the
2-argument strscpy().

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: add tcp_get_default_congestion_control() conversion
 v1: https://lore.kernel.org/lkml/20240711171652.work.887-kees@kernel.org/
Cc: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 net/ipv4/tcp_cong.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 28ffcfbeef14..874531c7c08b 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -203,9 +203,10 @@ char *tcp_ca_get_name_by_key(u32 key, char *buffer)
 
 	rcu_read_lock();
 	ca = tcp_ca_find_key(key);
-	if (ca)
-		ret = strncpy(buffer, ca->name,
-			      TCP_CA_NAME_MAX);
+	if (ca) {
+		strscpy(buffer, ca->name, TCP_CA_NAME_MAX);
+		ret = buffer;
+	}
 	rcu_read_unlock();
 
 	return ret;
@@ -338,7 +339,7 @@ void tcp_get_default_congestion_control(struct net *net, char *name)
 
 	rcu_read_lock();
 	ca = rcu_dereference(net->ipv4.tcp_congestion_control);
-	strncpy(name, ca->name, TCP_CA_NAME_MAX);
+	strscpy(name, ca->name, TCP_CA_NAME_MAX);
 	rcu_read_unlock();
 }
 
-- 
2.34.1


