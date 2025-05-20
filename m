Return-Path: <netdev+bounces-192092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D760ABE877
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D493AEFEB
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 00:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F06134AC;
	Wed, 21 May 2025 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RByZ4gHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6BDF58
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786181; cv=none; b=nGSo9CZYVXDcz0HPZQ8ajmY53Y9BxigGspTjRMo9OVi6GkM2m5i8c+XhRDuIz3BzlWKJkR+wh9KOWPnZwxyTvKY3Btd5yvEvERs8Dp3EcZACLhxixKFE8wr7jglF73JqCknk1VN+t3JjJjj5ia4XoqwH3Zs++WM64ZVEEytYYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786181; c=relaxed/simple;
	bh=Ox0MtGkzh3nh7CLtFL5qX0KHPLfrIGtHILG1V0i/ZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFPgS+kRRKomaY/yfiwhC4pmIstv+jBqyK2joe8uLBqPYD/G9geRnduL4brS2DGeC1aAVFFZ9vPvDB6DiLeC2WQzYr2bZxnSP6PB0Za5PsJj4BPzteywqwnUjEAFRFeytWrMxga1e5iKwBnEMzx0ot3Os1I3gKsKDH3RXIis2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RByZ4gHy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a361b8a664so4557695f8f.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 17:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747786177; x=1748390977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=RByZ4gHyci7hC9h+Ww8A8aEixuG8Kdf5jzCS9VZ4HC2nfCsbXY7X+pd4wj1998w4vt
         8p4a/5po7oeiDOpdhU+cE3kJggRFdr20tBLiPYNmbAwA7D4l6dQs16MPSi4TuYmqLil2
         Db7+sHXixqNim+bnKJkouXFkxKWsbldohWfnJLsRDbNrVTntwkLrmWKBkFtIhuLP0Kob
         VOYHCNt2Be4aEalfCXh5f5bNncZxfjr+MMD/kWAiMxLWOb1jxo5oettordZuCi60MRIA
         khs1NANnQQdqMS/G9+i4/NTJTTUkYJwd7/iz4FiwOnX+SQJd8c07X+qB1sJxmuO3XwZ4
         FIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747786177; x=1748390977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=KYI3j6Mei3ceKcIZozRYq8ZQJfEX02oU30oGhpC7Xv6FAyn+6ht+GO6aqnKPznYvWE
         eQaQ0iOdcfl1uF4fTCfW9tCU9sq1MDFQ/NDBehUkEojVuKobcbLG2gAhKYTx/LuNn+yt
         BgykDfLMAIfuPRmANQjUENiREtUSRK3VSmY0A2dtbf6OjN9jnPflQIl8TlKQ2eeBFFVu
         tGQ3W30tOqf7p6iPsmhCiIbxqmrGJ+YkCQSJ5LpN+6wDX3VF2xggNjKBmiZ4LJ0kmopG
         U0QvRygGOaGxdIzuDOnlv4BBJekyDQ04IiDtXXkVZrvzZFU8MwPXeb78tSsdC2gTfyOl
         JcNQ==
X-Gm-Message-State: AOJu0YwMgWGMdeTk4G3KWl/6mWt4ZHD4yQP6GORnslDtZlr8z2NR/Ce8
	7MFVoErlcAskAgzTKNhBSic6EBjExM6qf8oLMYAqmPrsB0AGgf/Iv89w+y56VXXrpamV94pH72p
	ZffcxxdmCGfCfKvcUMadRQogruUSZfY8p/kLQ1za2f3gfz36u7V6rdPf/mvMjnAnt
X-Gm-Gg: ASbGncvsSiUCOu56vytY3I+LvW4W3LS/S7jw2uqekN3TGnIv8aV0hQ4bwDoIllxL2hU
	PQ7Q9k3ClFzfnPpiqKLF5EHIqfj0IoRfLds4vBjAyjb8YD/uSrzjKHgEGqJnoksJRVsGfESnNEi
	Cd2aLeNn9w+JsphS7waoHKPPimrGOMVQEpztS096cpBEhoHMXsdXeNgWI4bMWZCS53GHdAT/fDT
	Cz4HDdgs8iVh0YBUtgpgZvIK9k6ZCnmdK+XuDoGjpu34R1npHalj+6QhCmIwuwCsGY5IqfhHcCk
	bTJQiVtzpu2Lzk6gUsqlg2tBpmc06PJ1C9D+HbMAxg8HBoOpwKBro7vMZpcMKvLUQtrRPgcjZA=
	=
X-Google-Smtp-Source: AGHT+IEQShRJpoYU5IWlqEWhAXOGgYj5mKi9yL0Le/e0/qyluVPrx4bWJcrwsbL5nXykvG3mT1gsgw==
X-Received: by 2002:a5d:64e2:0:b0:3a3:6735:1401 with SMTP id ffacd0b85a97d-3a367351679mr10674775f8f.56.1747786176718;
        Tue, 20 May 2025 17:09:36 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:95de:7ee6:b663:1a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3620dbc6asm16625042f8f.88.2025.05.20.17.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 17:09:36 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 3/3] selftest/net/ovpn: fix TCP socket creation
Date: Wed, 21 May 2025 01:39:37 +0200
Message-ID: <20250520233937.5161-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520233937.5161-1-antonio@openvpn.net>
References: <20250520233937.5161-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP sockets cannot be created with AF_UNSPEC, but
one among the supported family must be used.

Since commit 944f8b6abab6 ("selftest/net/ovpn: extend
coverage with more test cases") the default address
family for all tests was changed from AF_INET to AF_UNSPEC,
thus breaking all TCP cases.

Restore AF_INET as default address family for TCP listeners.

Fixes: 944f8b6abab6 ("selftest/net/ovpn: extend coverage with more test cases")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index de9c26f98b2e..9201f2905f2c 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -2166,6 +2166,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 
 		ovpn->peers_file = argv[4];
 
+		ovpn->sa_family = AF_INET;
 		if (argc > 5 && !strcmp(argv[5], "ipv6"))
 			ovpn->sa_family = AF_INET6;
 		break;
-- 
2.49.0


