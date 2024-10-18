Return-Path: <netdev+bounces-137060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC65D9A43C6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09581C23C44
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D6202F8D;
	Fri, 18 Oct 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RjVsYvhM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1754201273
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268729; cv=none; b=pdPiW/NIhupTYLfpk+FdIWXAkvlxNyJCMudGJp7AFTIwJPShTZreBdgFvnlDiv7SItZvyy/V2WphGkxjC8b+8JiuuSLgT30iSX8UoF/a/MeBYre+NBdxtRfgDG+gAfIwtR8mlBAEw6rGE4nVTd9YgROKe3IMTFzyqJZOWpKPiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268729; c=relaxed/simple;
	bh=Qm8FJuHRRwls/WqAeoFpruf5JFERUa8R5bqjrs0EgM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p19spOX3oqn8l/EavnNpcnB6aWBukro0Wwl/qcTrKD6uLnubOwdzLLPE4+4gRWI+24hMaElCkSnu00MUR9/RIFNt3brtJT3BwcCFMI215EYY1K+aj+2deOf6DGKP5tt0v5wzP3siAcW8xbm8rdeuxZOZsQVF63X5pK8XS3xb0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RjVsYvhM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so23829765e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1729268724; x=1729873524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ch5DeSK41qqOXt5fRprznhl/8uUUV8RtaTKJ1Y7/r7I=;
        b=RjVsYvhM3Mc6wlYizbegi02tKxbPVH4ARBoMpGYGbVcZ1PlKTvAi2NItrmqbIMoHRx
         6SkYNKF4XlL1UjxyZdBzoOC+ncnsXvti806U2Qy0yO2DDvRa4qMpobeBvcyautEay/AC
         r1uMxur7+sjjXazk+pHhaPuFW/iQmCc588iLHCJbpuuvYlfRZo1X6I4Jt/nFH2w2C6Qj
         aFxIwhlvVoQxWEh9tb3YlOhLvS13KKb6qnvxnGFsa5ELOHwvrMrQzlVGcbcVJfXTt3y/
         mSWpgsCQjWOL+3SZtcf4l3I3s6TUUCCuIV9xPAbOUkg5CgdIedd5twRP8WEaNPTkM4pZ
         ZTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729268724; x=1729873524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ch5DeSK41qqOXt5fRprznhl/8uUUV8RtaTKJ1Y7/r7I=;
        b=gKUjK153XumqXozGiF26qzyRA07DjHAS4fWixqAlfrUixdfc3oKk8/vrHp7Nc+5l4N
         X+Qr4I3GBHwrsC2OSn0e+wwLlAgcuk4DTO9xzCYiQjf1b4MvztsWnplL20vnUF/ZAGcl
         Fli5J26UCYrZqsn+jzCE749R8f7FEHRyqMjbeKcJhwqI33mLoy+Qr7GgQpnwnQB9O+Me
         VjQqqGb3MIRg6NBPy2oXHZSMJWNfwvnras4sWDOUHuKerrrH2bULhKxqijBhW4Qf3equ
         0HlGgG9BgpDdSaQpxGk28dLVGo6ii8FwIAObw9dZmqtFZ3SYtol8b7YK085Af7gT2gk8
         W7RA==
X-Forwarded-Encrypted: i=1; AJvYcCVTzf1c6dH3kDZrh8LwlHQEvuuQPM9PAKRnLlDYO8mhdaQmVtkphMRXV9jVVePkANjPHKjwHs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLw9ucCiYm7PkxEkTD7dF8Pa3KkTaLxvQDs+v1TIOmWxF8dxqB
	CtJ/Cvg+LzOiDA5P0Y66h0/88HUc3As74Pw/MWNhS07Rl89Z6YIUIn3ZOw765DM=
X-Google-Smtp-Source: AGHT+IG55NayxS0oQBlxGjkszsHyKw5MDiOhDqS4zbVLWOMuBB2ZIxTPFLk3EVur+Ss+hgvqAJlzvw==
X-Received: by 2002:a05:600c:3553:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-431616a0b1emr25002345e9.30.1729268723752;
        Fri, 18 Oct 2024 09:25:23 -0700 (PDT)
Received: from localhost.localdomain ([104.28.214.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431606c64b8sm31178715e9.38.2024.10.18.09.25.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Oct 2024 09:25:23 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	stable@vger.kernel.org
Subject: [PATCH net] netfilter: xtables: fix a bad copypaste in xt_nflog module
Date: Fri, 18 Oct 2024 17:25:17 +0100
Message-Id: <20241018162517.39154-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the nflog_tg_reg struct under the CONFIG_IP6_NF_IPTABLES switch
family should probably be NFPROTO_IPV6

Fixes: 0bfcb7b71e73 ("netfilter: xtables: avoid NFPROTO_UNSPEC where needed")
Cc: stable@vger.kernel.org
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/netfilter/xt_NFLOG.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_NFLOG.c b/net/netfilter/xt_NFLOG.c
index d80abd6ccaf8..6dcf4bc7e30b 100644
--- a/net/netfilter/xt_NFLOG.c
+++ b/net/netfilter/xt_NFLOG.c
@@ -79,7 +79,7 @@ static struct xt_target nflog_tg_reg[] __read_mostly = {
 	{
 		.name       = "NFLOG",
 		.revision   = 0,
-		.family     = NFPROTO_IPV4,
+		.family     = NFPROTO_IPV6,
 		.checkentry = nflog_tg_check,
 		.destroy    = nflog_tg_destroy,
 		.target     = nflog_tg,
-- 
2.39.5


