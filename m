Return-Path: <netdev+bounces-182210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1A5A881CF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB113B9732
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE9924729E;
	Mon, 14 Apr 2025 13:24:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456AF247289;
	Mon, 14 Apr 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637085; cv=none; b=AOvxTQdHJRiCAY4YdTmrztbHnrqIK2tJMk7n12f4vsq/iIs432Hi1U2ogI3hH6GY7uONE9VszvwmmK3i7sJOsY6vNxIH6/IKKPa3a/SkS6+7ulrL6IowPuwISm8l43T89WiBlkeM1W01FWf+A4malFelyIUAiQRenLLI75KkTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637085; c=relaxed/simple;
	bh=BeHZLdzECqUINxpRH3TbRKrvymamvWqDpttGTBLG8kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZjIfZqI/+nyr5+u1aRa6Y5fWU5VLN4IDmuppFeGFHfpvggg3wf8qcc1z9CZakSsYAukW7jhlGqGuJ7fvFc6CjBinvECsxFR2tpa4jKh0ZOMEbfgx5xiOcI4ZAql171jcwUFmciXbdKP3fuAa8VQDU68bjvN7bPHITcYUOzh/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so8558155a12.2;
        Mon, 14 Apr 2025 06:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637081; x=1745241881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEkPNAzwNjB8l3D6JqgcGTPbVionTGNe1sx+qPQk13g=;
        b=NqMi0XHvJPWuzCS7/mY/FukPmR968b0Z697fuJK7U4LIB/4Eu4UVomsZ035XWxWAv9
         Dd9EyoulahJp7wkO4eLbSWVnLbscPVNDEnfzpzt7hPmweNJdnvAHUAFvmRSAx4ExBmRG
         wchin+h0o5vxow4XwS+BbyBQhvIlM5feuOX3Wo9dPSvkXQT8nJ6sFZAiz0Z0cz6RWTID
         tvxtI9MnjrVW6jOZ97XYf01h7oBZFZ/B3FIa3dHa0ZboQlxmdV9LIENkpPF23mW0bQTf
         dANlSghGKgGKGQvH0a2I8t8gUb6BrGk/ZAmh31Xaqn64Epw04/sDFPyUtm9sUFgB6/A4
         kY3A==
X-Forwarded-Encrypted: i=1; AJvYcCUvB9IpwlHmJsqaSkYVSgcpnW9dRJvrcNEosYu1c6M3anX3rMiVsd6hWW14BhywOuLntjdtXy/6JM/HZbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7A9ajItU8RL/8ChS0voMkquT9Ivy7png7daW+lrksu9fSL6nV
	rRuHNy+9T8qduIPCfp1d3Ocii1r8rFh0SJ4KFRV0rtg44ArZTqIA
X-Gm-Gg: ASbGncu4XY+6kbdvbH5Zgpq1U8RoE63PnOcLcjNG941Yne1IVdy+hcSH5VO7hkjMHGH
	vdNtFVtcVhkU5ojOpxFqlXaBxVEy8g1mX96AJYyWHYNrJxmjLIXVEMGhbIF3V7wR9MRTu4+UhzI
	qCcKVgNQstGTxaJiYmIQMoTrE0mVV31qdXyZHJe0mBY1fqn0m4k3BHjKYBWOkt//EQi9DpREZFB
	44x0QUqOR7efQbXCdh1rRtD6IlbR6u/z2EOVsljQMex1o4V1Ft0jAr8MSAMCQxR14apzF7QqGlI
	pnOxkll8GLeqM5eTi9286AmO9kXSfaR+
X-Google-Smtp-Source: AGHT+IFQQNlHXBQncGv93dqH0UDQzDTmNKlSKlaC4dGQwbHvfWdmCHZCAoDKQ3q3Q163bNzxbswVZg==
X-Received: by 2002:a17:907:d92:b0:ac2:c1e:dff0 with SMTP id a640c23a62f3a-acad3491ec9mr1108522766b.19.1744637081342;
        Mon, 14 Apr 2025 06:24:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3159sm911015966b.37.2025.04.14.06.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:12 -0700
Subject: [PATCH net-next v2 06/10] ipv6: Use nlmsg_payload in
 inet6_valid_dump_ifaddr_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-6-3d90cb42c6af@debian.org>
References: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
In-Reply-To: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=leitao@debian.org;
 h=from:subject:message-id; bh=BeHZLdzECqUINxpRH3TbRKrvymamvWqDpttGTBLG8kk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyOji0lpgZoo31f34mvxasPoBxU5JVqNNHC8
 OHcWOO0PpuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 bSefEACCuaZmLpa3vZYziuz8MJ9l+gc8cojb6qsv7y4MhPuwHEcdkbRRFWLhdytpfm5AIZlEFAk
 RqqJqNgHEyDCWDW6J3m98EJhUJTvbqUxe4KrKcZd7Ocfefr8aF2JIyP9K22G3HuW8SaQxtvDDN8
 xCsJTXkF3yktiyLIVlASiYLWc1tcYpX1k6IDFJ785t8Vn16+p//LCHDCslX5u5PylrWcf9BMkkw
 gO8AGHgEMTj+GCYcUwLxWDjnqXF0oyPb4NGK9mkFNUHOneRqazNEARiMTOl2g3hI0Zo+7WxTr2Q
 aStaVWUCdlS84VU7FZCLiFj4C8npRr/hc8IZ17G2fvUfZsOn9iNJ7p3OAWTHs5vSvFc4YoWakn0
 nd8NjKwuJRq/YumHJnOxMYTiIUo/1HHausszjy3Z/lKXU4hdi9wFwlDXo8wVBVwz9ziBBcguTfi
 +TDn8NKOrW1DL1j2XZB8kyP+JIj4sGvYlhe+Jj+RnlN4a10981v8/GSKRM24JNXiBDuWGCL1HzN
 tdyWjjnNPX25fXDtk0ofz/+GkW9PBQq4DvG0MxJ3FaE/TfRRSdeyfNYdvz4hpFTgwC/DuQ/EZcy
 i+TMlQdGyl+7oyH5zS3y2cCH6GwXk+Syin23B5t9X5UVowHO2PEZ9dsOGYJh6ROsuuV6pZmC6Hk
 I4US/JpEQZ374sw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9ba83f0c99283..a9aeb949d9c8e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5346,12 +5346,12 @@ static int inet6_valid_dump_ifaddr_req(const struct nlmsghdr *nlh,
 	struct ifaddrmsg *ifm;
 	int err, i;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ifm))) {
+	ifm = nlmsg_payload(nlh, sizeof(*ifm));
+	if (!ifm) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid header for address dump request");
 		return -EINVAL;
 	}
 
-	ifm = nlmsg_data(nlh);
 	if (ifm->ifa_prefixlen || ifm->ifa_flags || ifm->ifa_scope) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid values in header for address dump request");
 		return -EINVAL;

-- 
2.47.1


