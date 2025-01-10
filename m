Return-Path: <netdev+bounces-157288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF3AA09DDF
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C9C7A2F10
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D992253F8;
	Fri, 10 Jan 2025 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LObea50O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54622248BB
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547990; cv=none; b=FHnZBGiYgJmKHSoqhkctlsY1aEgAhlBeue3WJRzbDrrZcSXqWiYOojBZLioeenIeNFDqF58svNmDI0qHOfYsCgUCZyeWlzTaXXuPbzlxuDdsr4gdFOwCkrVhc0cw/3OCC2NpFUcS7ca+Ma6q+vyTI/+JRxpYrjrChUwIyOZOIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547990; c=relaxed/simple;
	bh=xVfdmalsIUFdZaZj3wkp00YkTZ7DNsXUfUlkMeI4mck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJN8upIO5vuZfsZOC5Z5PdrxJt6qZlMBrXNm9jrDuvNHLqlFeFDJ2f5SXyIlZcc0vfBSZzuWaiigfwamTEO5QkeZprq3jgEfHyHya/6Cu3tkL0O39ZZpCfV6aywSN90EwTkz3GxVdgQRzaG4ppFcdtP5pqBY5qeWsdVQXY69Sos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LObea50O; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436249df846so18620345e9.3
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547986; x=1737152786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtJVavG/GcMgpuSCqo0A8YspwTl4lu/lWPyS3Thy+Vg=;
        b=LObea50OOkhOi7YExUCiGGM9aHNwYflCRm03k0diseAmuQ4HvDI58+zhrXQbe+eDJA
         DH8D7x6Bs+cPYalcZSknAFJQLHkVXpS5oWd/3R/PmEwKoBefIuQCHfS5tCa+a5/pLbRg
         dqT+dRGZhy20txDP2abuJdrvVMf3xTvzafDfVWxKKy8tLMhgCn+4q2RM103dYii0sue2
         BfyRVms0ejGlv2Atxtoxb9pB5nk9SBwXBHQwaNshjDwhiBHaLlwHRWq9E5Ol9jOEr5hF
         VdSRm5mH1cGVdZwVzrdTWxaL5IL6F3nf/JtUBf4qTROkreRG2H3zpX1tPiVUs8rujlgj
         90VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547986; x=1737152786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtJVavG/GcMgpuSCqo0A8YspwTl4lu/lWPyS3Thy+Vg=;
        b=DWoTahqER0A0H9CHjwmc+70Ltwfh39iejvuKTVM3Y1aMkMQID3bkNyTmTjHGeQ995O
         z5Ucep1zaOGkb4GQXQ6l+Rp4ylTtX40/MWaoHdB/H8+9HIJ8qsQeKMeBhJXlEfsxmAMC
         dE0p+mvXRLMo8GRnzqxOruO+cRwkWV8yEhG0OWWKuHjifN6cx4Yz8BJNFirUNd2mIJGB
         cLSFgTLPFqLuJY2iW2JedCSZiBymEg9GTtwbXXhYclai0Ufet6TT/V2T+rdZHWgPLhnf
         5LWHG7Z3wNh7rTLOD+9GK7ITGfymdeiCD84FkNQVgP/cXNTGuDNa5FQ7cyzdnXvGr0ok
         PBYw==
X-Gm-Message-State: AOJu0Yyo/UL8uyrhz7Jrl/dWkVuGkxWh1zCtc6bXlsegkAl2cf74l1ld
	j5x1IgFeIszsFBuvCibWGBRVsUmrGfYZvxbP2MUhLdFPea22oWzh5ejYQz5/UPs=
X-Gm-Gg: ASbGncs0Gsi66QmwCsDsjAxz+YGHeHoNzV9yrHPspbf/OgGtKz7+LiX1wKK2WJit/AG
	n17cteM/QSDoIqQ3bwhfXmJPYGJkRmsxhuIg9zPyrAFNOH081fFhijp25rHAU0BmZXC5vSjXDYZ
	xe6sfE9bILzmx76oELgRToT4A+dwiqA7GdJObuYbnmF4Z3Hp/Ma75CuUsH9fOEzziPzTavoQNnF
	U8iA8GkTh6M1hWt4ey6OF8wdcl8ApGvPPE8cP6Zh1uAa9vLgmIyia1O7NNth2DPj63G
X-Google-Smtp-Source: AGHT+IH0Jj1tfks439GTP8TiXGh17Zt0H75JpCO6rncqDgNB268n7Q3X15lEk/6c7fjxzewczqrBqg==
X-Received: by 2002:a05:600c:3b0c:b0:434:fa24:b84a with SMTP id 5b1f17b1804b1-436e26d96d8mr100203245e9.25.1736547985874;
        Fri, 10 Jan 2025 14:26:25 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:25 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:27 +0100
Subject: [PATCH net-next v17 11/25] ipv6: export inet6_stream_ops via
 EXPORT_SYMBOL_GPL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-11-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=xVfdmalsIUFdZaZj3wkp00YkTZ7DNsXUfUlkMeI4mck=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6xXJ3P/5MXOMl1UskXkMiBnz1LmzJrNfdpA
 gJ50D1xAg2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesQAKCRALcOU6oDjV
 h3Z4B/0YWg0zeODlTBv5lEWd3Psf3Fs0EbMqIfdMPL4nWnIj1UnN8guoK6343lZ3ySHLTYV73eA
 dXQaTBhEw8Dpo8T2P11QEs/ohswWNHTBjv8TxT9h95GfPguYe3lXqZ8gmOlbQAw8jfup07dbxoE
 blW2DXUsvEP/byYcQF8Kl05+mQbNoHx8pOXnlSfwUqZvX3aAmvN/tLopVhkYN3UFzmEF5VAFHg2
 nL9uBw7HtQ3hs4VykqaEHMS0BF1p/jRH3dE1MqvpnPwNaRt4nyNPbddcrnNL3hDlVwrFF5reNaa
 cI7mBQMMYf3Lwl7JhIL23BeL+gxCYg9i24ZK41uggwWC/VTR
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

inet6_stream_ops is currently non-static and also declared in
include/net/ipv6.h, however, it is not exported for usage in
non-builtin modules.

Export inet6_stream_ops via EXPORT_SYMBOL_GPL in order to make
it available to non-builtin modules.

Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 net/ipv6/af_inet6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index f60ec8b0f8ea40b2d635d802a3bc4f9b9d844417..3e812187e125cec7deac88413b85a35dd5b22a2d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -715,6 +715,7 @@ const struct proto_ops inet6_stream_ops = {
 #endif
 	.set_rcvlowat	   = tcp_set_rcvlowat,
 };
+EXPORT_SYMBOL_GPL(inet6_stream_ops);
 
 const struct proto_ops inet6_dgram_ops = {
 	.family		   = PF_INET6,

-- 
2.45.2


