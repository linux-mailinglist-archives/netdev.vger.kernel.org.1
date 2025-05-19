Return-Path: <netdev+bounces-191372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674BDABB34E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 04:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6C11747DB
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 02:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B51F5833;
	Mon, 19 May 2025 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMRiJboM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1F1E9B04
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622133; cv=none; b=h8oHCe+n84UwqAk6bI4egtyN/HtwC5RxKxr7/Td8f3RHqzBkhwqw65yoWIXB7h2FeBMnckqX/IYuzbuVyjx5ZHN7UFajge2yYK+WvsHd/YsW8QhanNs5CownCjZbECwIP9otQHnuKSJgomXpjcPSZi0nxWEawtTbtHRvzLHXmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622133; c=relaxed/simple;
	bh=+fLzCD1RoUrUeV193X0CN0MPAFz9uajW9owZKfgSTYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HV1ZWt+/DuHjv6vUxG+w0loh6ZG/MA+wcaG8QG3MPqq7iflmYm/O5vuLX3GKLubjbSh9I583bjijfVFn9tIQ4nik6vY7dv1m5FZDNgYlWkWsN771afjeSjJ5MJnqhyXBoBvM/BL/I4HVKBjBKBTV3IXStFZZBkEgMyDIRo5u3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMRiJboM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742a091d290so2427559b3a.3
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 19:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747622131; x=1748226931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsib5kCQHhRTpjaf9L/1KcIsuAgRVw/2/Ukd6+B+UoU=;
        b=eMRiJboM5FmbZ4BlQVCQ7auO2YVtnmud9a38WkzMsbFnO5jKC6rDMbeiICIWLjcvq7
         LwLNvT+XYosFelwN+EJrcsLRK8ez+ZeNDVKLL5r1ySnwbqf4k+3WC+7msr+GlRDqwqE8
         9xS++oVnIlxpxa3bi2jX/vTSQFr/McAzGjpjM1A8kv0VFljDin++WY42KUPLDWcjezj3
         Cx1uYG1B0XaEhqAs54nif+0qzk5yeDuEy51C+W/BTaAjTjG05B7BQHu9pCKOiPu6el2N
         WVFFlOG7LkT5ii3aH3WfWOPoDKqFtsemHKSefutGIVKc9WRxTUUofqxWdIuvsNI3AdoB
         qXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622131; x=1748226931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsib5kCQHhRTpjaf9L/1KcIsuAgRVw/2/Ukd6+B+UoU=;
        b=pOtyrqF3ndyMeYI3ZJsuRSceSFYHc4h7ovG60Xyzb1/a/AKcrsgxtiPxKEC+dcIchm
         C9wVcYCA4UqDJnyGmFhLySHsZrR+CNMkf64O2zSRpscDBJgkSjXsuv7jW9o1+pkzeYS1
         nV7JxN3CMEpHhu9xICJ5TdpWpisBWRgHWd4qp0v3bUEm0TjGWHLdWgfStxhoRGgdiITA
         jd6xysDznvcksuvKyI1GMTtocLAPRo8Akt8i9F1LTfR6mRSgaUPYn7N9cnQ7cyrbhC5f
         FGk/8tsvub4uT5k/L2xLcNHLE/aDDp2J8FOlVKBUTq+1p00HTF7zvT7QoORVTR9NxfKI
         GAbg==
X-Gm-Message-State: AOJu0YygnpcISWyMJUET3YDi0PCgc2eGmdougM4rsZuA37G/9+XIi3gA
	92LRbTPdV3hCsBfTdeTDpT69OJvApPrl5NhtHvVG+u8WP18p5EghhqPOZUw7ryDCNFWbvmQjxSY
	SKxo+QU9v6rf4SHF5mdsowthANTreLhSdylN5PHpxJAkSfu8WroZllo4rVmhDAQ4GSxi5oeOq0a
	078AO+V+p5PxVOEjt/UVj53N9suI/dvqI7zvo51gnFjrQ/RAPHE5WCob/ppu+Y1J0=
X-Google-Smtp-Source: AGHT+IHYtSlpqkjG9aEm65HFlOMqCYP8ZVIHIn0ysadn3DoH/Dao7wFtqE4cnWV8BuGlnEjplUE25OvnhoAFtu3l/Q==
X-Received: from pfbei22.prod.google.com ([2002:a05:6a00:80d6:b0:736:415f:3d45])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:91e0:b0:740:b394:3ebd with SMTP id d2e1a72fcca58-742a97ad507mr16514775b3a.7.1747622130537;
 Sun, 18 May 2025 19:35:30 -0700 (PDT)
Date: Mon, 19 May 2025 02:35:14 +0000
In-Reply-To: <20250519023517.4062941-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519023517.4062941-7-almasrymina@google.com>
Subject: [PATCH net-next v1 6/9] net: devmem: ksft: add exit_wait to make rx
 test pass
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

This exit_wait seems necessary to make the rx side test pass for me.
I think this is just missed from the original test add patch. Add it now.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 tools/testing/selftests/drivers/net/hw/devmem.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
index 850381e14d9e..39b5241463aa 100755
--- a/tools/testing/selftests/drivers/net/hw/devmem.py
+++ b/tools/testing/selftests/drivers/net/hw/devmem.py
@@ -30,7 +30,7 @@ def check_rx(cfg, ipver) -> None:
     port = rand_port()
     listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
 
-    with bkg(listen_cmd) as ncdevmem:
+    with bkg(listen_cmd, exit_wait=True) as ncdevmem:
         wait_port_listen(port)
         cmd(f"echo -e \"hello\\nworld\"| {socat}", host=cfg.remote, shell=True)
 
-- 
2.49.0.1101.gccaa498523-goog


