Return-Path: <netdev+bounces-280287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HZlJ6cw6GlHGgIAu9opvQ
	(envelope-from <netdev+bounces-280287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:21:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 326264415C1
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B2AF3012228
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E544311958;
	Wed, 22 Apr 2026 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0BNdJBp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26681310620
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776824485; cv=none; b=FzS7RT9L9tLw9TBs6g4SkcxJWYiwxSH/kicgpSUKmIlLuxGdSvfxKor6c4gvbDnB+8DFdWX3Q3sAWb2qkEYaeYRHiUDYqYmt03DpS3PSmsug/kczgKYjffdtDR/HJwYjNaD12fOaNHeIjynWdcCelHnC6wfyF6L2eC+iT5anHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776824485; c=relaxed/simple;
	bh=qTQz2vSFPrt1UdUDLXJDjD2WVqA6OtwK3Yztcv6mH6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/905jxjJDL2XF9HZXe+r0FvcsYUS0L8LGRZ097KmpFvumCdFPbe4Gn/CXOTJGLtVp5L9jn3kfRB1zGJH1BjR3a2feKZi32XjBtOJbeRnnKIggL2kWeTe72GfyIbIITkzrHauRg2ySdLVAcri7VUrSHhKu9xgqB4eXMbaUjZ7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0BNdJBp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f2766905fso2203852b3a.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776824483; x=1777429283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyW6Dq3v0wfgMxaoUPexIZg9oPAHn/sng0+hK7J4HUE=;
        b=f0BNdJBpobcde8Z1AOd+sT3q2R6sflKfcDUaN5CFqjB/uiGLgNOQyrmzqZ2vSCjYh4
         xtrrJSd4oC7sjD7UUCoaMu2Aaj3ow8dICE9txVWSAdF+mDVNYUcF6oHI1/C9RR+8tSVd
         qOU+P3Tgb14duQyxYT3J6SFiL3wVEFJuGF1wE7ZhGLMqToyGWsISsf5cvfRxEAJtO+Kv
         1a2uKKpp1rUMWLJrb0f5GTKRdDG1dp8Jt6x1oOPDHUhIse5SINE1LOwrvTN2CRximGM8
         pFUPTvHBtOUxJ+IJF/I1yYPMwOnGmG4D0mRtL9RgLOCcWz2WC8mh/jyTIA3LDTfDDhtq
         0TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776824483; x=1777429283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyW6Dq3v0wfgMxaoUPexIZg9oPAHn/sng0+hK7J4HUE=;
        b=GqwiI6K90a+HfQpgF8BjvvGv9CgsEqO/vI2VKYFqc5vVyxjfKmsyRb2GIzo4oQxOva
         g0LV/PSkZ2X+4tdkA3Y4htiD6OYXSniS+P1DFVkwWwTY6IbqXCF7RHB/n5uBxwIbaYiL
         fCYTN+yUJHUoFt53g9Tj1VvDtFMeSyzHJriZph/U/wt/wJIZz7x81hxqvEnmoYGD5ojq
         7v6CBabpguMo0V/SXP3IRc+3CyTw7QoWFBCm/jclpB5YPYZ3uMtoo47lGq6rDOxX2SXD
         lKYHBbxtStNZXg2EHfBeXA7RHBOXaN9zuPnojt5yDJ3HSgNjM6p6wTNpUvwJ3Dpj3Fbu
         4dAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1RNZiVUZmxlBVXfHYYGu/CM/yOt7EnqIUi2T3pD2TQtjd7sV6utGTnL4tx+0Va3iKXyr0zwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08dX01n2tIWPFtYPcXn9utc29Amva/mkwIaFIj8IyWRIAVFW1
	0j+G07Qbe3pLfAiZrbgwtUhUj3hHzoz7VeYluWKhkT4+YtMWi3vKVZ+0
X-Gm-Gg: AeBDieuiQAv80Wakauu6NTwQ+KeXqTAQbmJ9QY7u0G2FR5zZWXeEFBg9EdBnu4wPqhL
	9FKz6w0iIbiTixpBnqXfGNDLmsXhnv0QyrpuRUYLSuEh1AzI5oaV6tJfuVv4l7YlgQfsFCypT1I
	f8yjUDmFAghKH8aLY4unxHwvVN2ReLjvhpp2PxMpUoIGo1MKwc2DDl/p9erpuv3jBfPco4n1q3u
	GFY3xl0oNrO+KWUp69N4wxCxif24Ro/vPDZQuCGw7lWc0yvxZ+bOx2Tr6q0BdikruQRt/0nhhfd
	C1ZAAo4v14TOD55mNov3ChKsD63glhEgXDzzB/3xb3DrKLqDfF/kHYIM/EsoD9GVPLYv4F4T8gF
	clxm2/ykvqc8691ffBMe8K9f0Jc0lPTv5votf+mcnIvFKROdYXCmLIZ3gIwnwbJrTlMHMzRF+N6
	A7xgJ44TkkcecvHR5BWfeEWeo5eVUPDhpMJ1MSR5mM1HoAfqzGvzkzxpmmZIMzfWwCifBSd90hC
	LJ2W/imO8kFRHI3SA==
X-Received: by 2002:a05:6a00:22c5:b0:82a:7734:8c6a with SMTP id d2e1a72fcca58-82f8c9378ebmr21412584b3a.48.1776824483420;
        Tue, 21 Apr 2026 19:21:23 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:6adb:27a7:d382:d9c9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec0092bsm16269002b3a.50.2026.04.21.19.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:21:22 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: zhangdandan@uniontech.com
Cc: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	zhanjun@uniontech.com,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: Re: [PATCH] net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind
Date: Wed, 22 Apr 2026 07:51:14 +0530
Message-ID: <20260422022114.17097-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <81A6570B633FF6FE+20260422013807.63087-1-zhangdandan@uniontech.com>
References: <81A6570B633FF6FE+20260422013807.63087-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com,googlegroups.com,uniontech.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-280287-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 326264415C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Morduan,

Thanks for fixing this syzbot report!

I independently worked on the same bug and sent an
alternative patch here:

  https://lore.kernel.org/all/20260422021533.16987-1-kartikey406@gmail.com/

The key difference is that my approach checks the bound
state BEFORE calling pn_socket_bind(), rather than after:

--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -207,12 +207,11 @@ static int pn_socket_autobind(struct socket *sock)
 {
 	struct sockaddr_pn sa;
 	int err;

+	if (pn_port(pn_sk(sock->sk)->sobject))
+		return 0; /* socket was already bound */
+
 	memset(&sa, 0, sizeof(sa));
 	sa.spn_family = AF_PHONET;
 	err = pn_socket_bind(sock, (struct sockaddr_unsized *)&sa,
 			     sizeof(struct sockaddr_pn));
-	if (err != -EINVAL)
-		return err;
-	BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
-	return 0; /* socket was already bound */
+	return err;
 }

The root cause is that pn_socket_bind() returns -EINVAL
for multiple reasons:

  1. address length too short
  2. sk_state != TCP_CLOSE (without prior bind)
  3. socket already bound  <- only intended case

Your fix correctly prevents the crash. However the
ambiguous "if (err != -EINVAL)" path still remains.

By checking pn_port(sobject) BEFORE calling
pn_socket_bind(), this approach:

  - eliminates the -EINVAL ambiguity entirely
  - removes the special -EINVAL handling path
  - makes "already bound" check direct and clear
  - simplifies the overall logic flow

Both fixes prevent the crash, but this removes the
underlying ambiguity rather than working around it.

Thoughts? Happy to defer to your patch if maintainers
prefer the minimal change approach.

Thanks,
Deepanshu Kartikey

