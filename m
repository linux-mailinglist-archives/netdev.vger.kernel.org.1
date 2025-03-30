Return-Path: <netdev+bounces-178221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D5A759A4
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9544518881E7
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7882F19D067;
	Sun, 30 Mar 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PGU9swEi"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D7BF9CB;
	Sun, 30 Mar 2025 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743331267; cv=none; b=ST8oNkkuZeUMext3rBagvJ2W5S8PbZw1/rtm+wmTUelDsAKC4aWX4aOLzpw7tB/puXz5I2YsDG3HVxqZyAAwAA4WVogwiJ13TwaIzBX5DUPHfrsOVMkNr9C9y/f4cut7kHkDNcJ46qevB7eXMMkeejhqj4IKiX3jWwsPgofqS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743331267; c=relaxed/simple;
	bh=/Q3k5X2P4dwXQISDL+GBAhFuGgVmsV1ZMtOfAK/F7aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BAMbqORwr3jig5zAsxfZq4vpMp90Z9fSRPGp/NHAdMVNBqvU+frKWig2kCIq6MCIUd8Ckhsq3X9J23SvjpJBVQN2hZ5GYw0iJy/Tm1+86BJfNYdPxrs6UKH7oLQ+K/WAgghJqq6kKm3ylcbNyKPwIt8yoGzgqZINaF67cbLGHVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PGU9swEi; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=R/OU0
	V8NdoaJXsUCiLUPKOq7COZkSQ1mwl2m2pWiWKA=; b=PGU9swEi2TtrVi8qIEJaa
	X2mISGL69kKvbKDpyxZr5eNup951wqhAY9NMQpCP7p0GQrxUra129YFYnClC9BRn
	PpQM18uJM0DaDUHlxo7c21hbR0vOOPc38YlukzUpq++K42XdG7Nhk2klJcfGHJce
	hoBuOEV2L13fhiR/cniag4=
Received: from WIN-S4QB3VCT165.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXplOpH+lnS_h0Aw--.46366S4;
	Sun, 30 Mar 2025 18:40:41 +0800 (CST)
From: Debin Zhu <mowenroot@163.com>
To: paul@paul-moore.com
Cc: 1985755126@qq.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mowenroot@163.com,
	netdev@vger.kernel.org
Subject: [PATCH v2] netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets
Date: Sun, 30 Mar 2025 18:40:39 +0800
Message-Id: <20250330104039.31595-1-mowenroot@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHC9VhRvrOCqBT-2xRF5zrkeDN3EvShUggOF=Uh47TXFc5Uu1w@mail.gmail.com>
References: <CAHC9VhRvrOCqBT-2xRF5zrkeDN3EvShUggOF=Uh47TXFc5Uu1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXplOpH+lnS_h0Aw--.46366S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1rtry3tF4kurW7Cry5twb_yoWrCryDpF
	yDKan8A348AFWUWws3XFWkCrWSkF4kKF17urWxAw4YkasrGr18Ja48KrWIya4ayFZrKrZ5
	Xr48ta1F9w4kC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRco7iUUUUU=
X-CM-SenderInfo: pprzv0hurr3qqrwthudrp/1tbiXwkglGfpFMS9dQABs1

Vulnerability Description:

	From Linux Kernel v4.0 to the latest version, 
	a type confusion issue exists in the `netlbl_conn_setattr` 
	function (`net/netlabel/netlabel_kapi.c`) within SELinux, 
	which can lead to a local DoS attack.

	When calling `netlbl_conn_setattr`, 
	`addr->sa_family` is used to determine the function behavior. 
	If `sk` is an IPv4 socket, 
	but the `connect` function is called with an IPv6 address, 
	the function `calipso_sock_setattr()` is triggered. 
	Inside this function, the following code is executed:

	sk_fullsock(__sk) ? inet_sk(__sk)->pinet6 : NULL;

	Since `sk` is an IPv4 socket, `pinet6` is `NULL`, 
	leading to a null pointer dereference and triggering a DoS attack.

<TASK>
calipso_sock_setattr+0x4f/0x80 net/netlabel/netlabel_calipso.c:557
netlbl_conn_setattr+0x12a/0x390 net/netlabel/netlabel_kapi.c:1152
selinux_netlbl_socket_connect_helper 
selinux_netlbl_socket_connect_locked+0xf5/0x1d0 
selinux_netlbl_socket_connect+0x22/0x40 security/selinux/netlabel.c:611
selinux_socket_connect+0x60/0x80 security/selinux/hooks.c:4923
security_socket_connect+0x71/0xb0 security/security.c:2260
__sys_connect_file+0xa4/0x190 net/socket.c:2007
__sys_connect+0x145/0x170 net/socket.c:2028
__do_sys_connect net/socket.c:2038 [inline]
__se_sys_connect net/socket.c:2035 [inline]
__x64_sys_connect+0x6e/0xb0 net/socket.c:2035
do_syscall_x64 arch/x86/entry/common.c:51 

Affected Versions:

- Linux 4.0 - Latest Linux Kernel version

Reproduction Steps:

	Use the `netlabelctl` tool and 
	run the following commands to trigger the vulnerability:

	netlabelctl map del default
	netlabelctl cipsov4 add pass doi:8 tags:1
	netlabelctl map add default address:192.168.1.0/24 protocol:cipsov4,8
	netlabelctl calipso add pass doi:7
	netlabelctl map add default address:2001:db8::1/32 protocol:calipso,7

Then, execute the following PoC code:

	int sockfd = socket(AF_INET, SOCK_STREAM, 0);

	struct sockaddr_in6 server_addr = {0};
	server_addr.sin6_family = AF_INET6;     
	server_addr.sin6_port = htons(8080);    

	const char *ipv6_str = "2001:db8::1";    
	inet_pton(AF_INET6, ipv6_str, &server_addr.sin6_addr);

	connect(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr));

Suggested Fix:

	When using an IPv4 address on an IPv6 UDP/datagram socket, 
	the operation will invoke the IPv4 datagram code through 
	the IPv6 datagram code and execute successfully. 
	It is necessary to check whether the `pinet6` pointer 
	returned by `inet6_sk()` is NULL; otherwise, 
	unexpected issues may occur.

Signed-off-by: Debin Zhu <mowenroot@163.com>
Signed-off-by: Bitao Ouyang <1985755126@qq.com>
---
 net/ipv6/calipso.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index dbcea9fee..a8a8736df 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1072,8 +1072,13 @@ static int calipso_sock_getattr(struct sock *sk,
 	struct ipv6_opt_hdr *hop;
 	int opt_len, len, ret_val = -ENOMSG, offset;
 	unsigned char *opt;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
 
+	if (!pinfo)
+		return -EAFNOSUPPORT;
+
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
@@ -1125,8 +1130,13 @@ static int calipso_sock_setattr(struct sock *sk,
 {
 	int ret_val;
 	struct ipv6_opt_hdr *old, *new;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
-
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+
+	if (!pinfo)
+		return -EAFNOSUPPORT;
+
+	txopts = txopt_get(pinfo);
 	old = NULL;
 	if (txopts)
 		old = txopts->hopopt;
@@ -1153,8 +1163,13 @@ static int calipso_sock_setattr(struct sock *sk,
 static void calipso_sock_delattr(struct sock *sk)
 {
 	struct ipv6_opt_hdr *new_hop;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
 
+	if (!pinfo)
+		return;
+
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
-- 
mowenroot@163.com


