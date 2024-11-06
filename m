Return-Path: <netdev+bounces-142496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7A9BF5AF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89B3B23FBC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D66620B1E4;
	Wed,  6 Nov 2024 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X42fVoZF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AE208236;
	Wed,  6 Nov 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918996; cv=none; b=tTYoHpK34I/VVSaeMj/K3tpSyLybF+D489B4w0VJnzIzCDqWjRzDQsGX7rRV60LlfLplEzQk2/b4lEnqcV3geA4eI+jRq4Ea5EQZ0n2KAw35b3sH1UaFajiWph3jh/teYJH9zvbF+fiGL2uK9GmIG4RwV/ckYlbILsSPF22LtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918996; c=relaxed/simple;
	bh=BKqLaO6XPMvQ5HpRGFcPhcfr1sfukA4hEzfeaiOil0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OH0TVeNG/vrchY/3xWbQj31T8HkPILs6RFYsC6vL3jlRRocWf9D0vBeALALxvZHqXF8YLw0CZSFXdprpcieANn3qlhmvm2W9fI6MIPGNlxh6eTMvgCCmdjkUlzncQdc53f6XJ74IMBjQvG2VvJFe1/n6z3fX1B7/hdO4KdLRxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X42fVoZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4167C4CEDD;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918995;
	bh=BKqLaO6XPMvQ5HpRGFcPhcfr1sfukA4hEzfeaiOil0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X42fVoZF9AmC1mgk5dH5kfF7n6AUHEAvUh7vzTRgQK/hkcZc8ui5IxjUCZAfxi9rI
	 XkxKhA5nGLh4w4JCbvRufqCJWQbspGRnk1u4JlE8StWFvyCsxITV0G0h6Et24u5Shz
	 UgqkTC2onFiKnU76GU7LPJpfpmFcGOf4V+Ya1gnMpFB7H+ehiYXlmw0z/COlOyXBE9
	 2MjP/Jjtr4GnHgqxlIo57XUes2tBSxyVDeA9u61icNUSjlh/NYB8OAJsAWWjT/FINX
	 NKfVQM57YI4Lt4Hik+WUkmlzi1xl2bMUcFb4wblNVb3r5Vky5vLOaPpJAWk7IWXpWi
	 BJi8Zn8xGDbHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A775DD59F66;
	Wed,  6 Nov 2024 18:49:55 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 06 Nov 2024 18:10:18 +0000
Subject: [PATCH net 5/6] net/diag: Limit TCP-MD5-diag array by max
 attribute length
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-tcp-md5-diag-prep-v1-5-d62debf3dded@gmail.com>
References: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
In-Reply-To: <20241106-tcp-md5-diag-prep-v1-0-d62debf3dded@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ivan Delalande <colona@arista.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730918993; l=3314;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=PKo8fHDH+Y26BFpEtywm6891bWe9iV/N0VRAp9ggg7E=;
 b=GkfMWOeUE2s8NVrp9CoHDE9rOxuVaoN4dBrn5VXXR6UodtyakVhNuPnRIF/MWiE96me7arJ6t
 VWcWdJ1SnRBCM9WAsfrVxdklibcbnzPRrSaKm8pUMUFaOc9d2MO9qCG
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Currently TCP-MD5 keys are dumped as an array of
(struct tcp_diag_md5sig). All the keys from a socket go
into the same netlink attribute. The maximum amount of TCP-MD5 keys on
any socket is limited by /proc/sys/net/core/optmem_max, which post
commit 4944566706b2 ("net: increase optmem_max default value") is now by
default 128 KB. With the help of selftest I've figured out that equals
to 963 keys, without user having to increase optmem_max:
> test_set_md5() [963/1024]: Cannot allocate memory

The maximum length of nlattr is limited by typeof(nlattr::nla_len),
which is (U16_MAX - 1). When there are too many keys the array written
overflows the netlink attribute. Here is what one can see on a test,
with no adjustments to optmem_max defaults:

> recv() = 65180
> socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
>      family: 2 state: 10 timer: 0 retrans: 0
>      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
>              attr type: 8 (5)
>              attr type: 15 (8)
>              attr type: 21 (12)
>              attr type: 22 (6)
>              attr type: 2 (252)
>              attr type: 18 (64804)
> recv() = 130680
> socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
>      family: 2 state: 10 timer: 0 retrans: 0
>      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
>              attr type: 8 (5)
>              attr type: 15 (8)
>              attr type: 21 (12)
>              attr type: 22 (6)
>              attr type: 2 (252)
>              attr type: 18 (64768)
>              attr type: 29555 (25966)
> recv() = 130680
> socket: 10.0.254.1:7013->0.0.0.0:0 (intf 3)
>      family: 2 state: 10 timer: 0 retrans: 0
>      expires: 0 rqueu: 0 wqueue: 1 uid: 0 inode: 456
>              attr type: 8 (5)
>              attr type: 15 (8)
>              attr type: 21 (12)
>              attr type: 22 (6)
>              attr type: 2 (252)
>              attr type: 18 (64768)
>              attr type: 29555 (25966)
>              attr type: 8265 (8236)

Here attribute type 18 is INET_DIAG_MD5SIG, the following nlattr types
are junk made of tcp_diag_md5sig's content.

Here is the overflow of the nlattr size:
>>> hex(64768)
'0xfd00'
>>> hex(130300)
'0x1fcfc'

Limit the size of (struct tcp_diag_md5sig) array in the netlink reply by
maximum attribute length. Not perfect as NLM_F_DUMP_INTR will be set on
the netlink header flags, but the userspace can differ if it's due to
inconsistency or due to maximum size of the netlink attribute.

In a following patch set, I'm planning to address this and re-introduce
TCP-MD5-diag that actually works.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 net/ipv4/tcp_diag.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 722dbfd54d247b4def1e77b1674c5b207c5a939d..d55a0ac39fa0853806efd4a6b38591255e0f4930 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -72,6 +72,7 @@ static int tcp_diag_put_md5sig(struct sk_buff *skb,
 		return 0;
 
 	attrlen = skb_availroom(skb) - NLA_HDRLEN;
+	attrlen = min(attrlen, U16_MAX - 1); /* attr->nla_len */
 	md5sig_count = min(md5sig_count, attrlen / key_size);
 	attr = nla_reserve(skb, INET_DIAG_MD5SIG, md5sig_count * key_size);
 	if (!attr)

-- 
2.42.2



