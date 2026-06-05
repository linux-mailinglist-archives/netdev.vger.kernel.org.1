Return-Path: <netdev+bounces-295792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cr4pLESxImrmcAEAu9opvQ
	(envelope-from <netdev+bounces-295792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:21:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 25518647AE2
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JPMLQlJC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295792-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295792-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3324A30285E4
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173173F888A;
	Fri,  5 Jun 2026 11:21:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED73DB623
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 11:21:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658498; cv=none; b=JkDMwuBtDa1lXzzL9eJYizILKWnyA3K7iF4b4POWT8cG517+3fo471rb9ojsIpXsMyAE4LDNlHqi82XrjqoZaft7Wwgma1NNN6gm5fvRquB7DEU3c33Beh89WsZgPE+O/2CHWyfZ3pdCisdZZPM4zM/BF7hvz2BlRiKyaeQoOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658498; c=relaxed/simple;
	bh=b4Dvvl39/qvd09t/KzndcD8LY8sR+L9mXyPpXGNZHks=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=clbrtSaaCuNM1Ha2p01abrgi3GqkOv9IWZeZleXkw62wAPe83K0ay/ZvuRVkAKqJF7JGMwiPxvl6CYJ2zTgIoewioA9AF6giLWKPrasxWSM0Zb96suOzkDEUyM3LN9aIybXdYX/k7bzmTj7lMNNCLCKnRVDLzsa69bDobBpkhkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JPMLQlJC; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5176d949c58so48191951cf.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 04:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780658496; x=1781263296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bTJSJfZlrZnr72qQBV1nT54IsiqSXO4gYoEedTnTMa4=;
        b=JPMLQlJCXC1Eee5rE3hSZX+ARwdERYFlKJLWhLl6A7iyX0/o2BLPe0rl/r2rtcesC7
         GM24DTVGrn1UDWuYng21rfoew6zWtIhPUqelZPrioHQj/Lw+wAVknlxtzR5oReAduSZ0
         krBYVRdj6hjmGNsP3s/MatKYlY5S11HN4bKdxEAKIVj5kaGoBr3nzi53ZA4N+Dz1dkEO
         yceQyxyUY7gSzl7daYCYLBqR0SuXPrB0rcnHs3rY2+idy62pi8eGV2YI8N4AIRyvSs0N
         QwBVc8Tzbg+rYuLwnUNulvKO0+HEe8axDyFvtgyqWRSXAvsiF74k6RoFRgvQIElCOUim
         b1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780658496; x=1781263296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTJSJfZlrZnr72qQBV1nT54IsiqSXO4gYoEedTnTMa4=;
        b=sQp2ha1pStFoiQay8amOzRM9Karp0ykX5VSH2EaTaPil6iBZ+AQfXM+MyP4ajlR4Q3
         RYTueU0ucOjApRMN4OmgV9tYyeG8XeIEBpxGeB7nihR74GIR0hFI2TDtbCyvk/yprkar
         RuHhoVusOkJmRZ73yy7HlueqVRnsxVyowcoel9h8/DStpUHkGlHUGd4/UEIvoCx/mBnU
         CijSi+OTZf9is/DiyizdLreCJzBlXVcSjwP8BZiStLTPKhygJUaqfwMMep5Ix8wslH7d
         q3vebrLVsZ4m8t7NnYeTTDIZzR1KvXQDeyTUbCh7GVacLJ32eAb354OOQaZiDgXBubLm
         ETmA==
X-Forwarded-Encrypted: i=1; AFNElJ81zpiNrKUEaeVF2xdeYn5qeinvGYPeHjT+xOxC92m7MrfaevYSEC/y4TXHhsIC6kI2gGRPYII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/BSrMNHMcnU3a7UjnOlpBbgYLKQtF8eTcSqky8U1h9fJQJz9
	bn0Rbxfj9AXk2HguQiyyHG+rWIDjOK0w7cDFuuCU4mfTggEPvmJmCOEsO3uA7rF5MsuOwPOmNTD
	Dvr7eQmnrjwNXLA==
X-Received: from qtww3-n2.prod.google.com ([2002:a05:622a:6843:20b0:517:6663:a9fe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:650:b0:50b:4a84:aa94 with SMTP id d75a77b69052e-517959d5610mr47652751cf.7.1780658495128;
 Fri, 05 Jun 2026 04:21:35 -0700 (PDT)
Date: Fri,  5 Jun 2026 11:21:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605112134.3642413-1-edumazet@google.com>
Subject: [PATCH net] tcp: restrict SO_ATTACH_FILTER to priv users
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Tamir Shahar <tamirthesis@gmail.com>, 
	Amit Klein <aksecurity@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:tamirthesis@gmail.com,m:aksecurity@gmail.com,m:willemb@google.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ericdumazet@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295792-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25518647AE2

This patch restricts the use of SO_ATTACH_FILTER (cBPF) on TCP sockets
to users with CAP_NET_ADMIN capability.

This blocks potential side-channel attack where an unprivileged application
attaches a filter to leak TCP sequence/acknowledgment numbers.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Tamir Shahar <tamirthesis@gmail.com>
Reported-by: Amit Klein <aksecurity@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index d097025c116a863b29346c12470a9c81ec38ac56..cab041b57d286536cd4299c98f0d7d3bf7499501 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1465,6 +1465,11 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_ATTACH_FILTER: {
 		struct sock_fprog fprog;
 
+		if (sk_is_tcp(sk) &&
+		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			break;
+		}
 		ret = copy_bpf_fprog_from_user(&fprog, optval, optlen);
 		if (!ret)
 			ret = sk_attach_filter(&fprog, sk);
-- 
2.54.0.1032.g2f8565e1d1-goog


