Return-Path: <netdev+bounces-70642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8412F84FDB4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BE41C21F1C
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF725C96;
	Fri,  9 Feb 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYF/nXis"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD7568A
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510915; cv=none; b=MgWGG3V5fxMgw2RAucM/Z9L6y7YUDAJNamlBH03k3PlzmU7ztAYkx94fpu2aS2mG37KjfUGfMcpUCpB1nRRyeHl2/jyQKeT0uvbAh8uWZ45NjA9HUViA4mNWJWL7yOL/hwF7bOdrwBoIJStjXc0ZiS/HJWUn8QvJ9BshEEG5slU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510915; c=relaxed/simple;
	bh=Cp/AN9/HGGXoAPiTYJogFYMkfFcAC2rlQPrKzKguFQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZDXObi5FICAXGzb05EuEAJGSEeDf0R92ItYbUShMKBtNMV5zlJ+IxXQZps84frh0HekCq/DVan8bwPUKbwEjXcNLw+X05q3zfTDmQ+cTp77hZa7FUoZKOkwSO57naYq/AwVJKnh0vX1lFJQIlOSJp/vWivPTpqsgTeNMwLXlz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HYF/nXis; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-42b875efad3so44883371cf.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510913; x=1708115713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6wQ7ycFTq+UkWN04lv4Q9eRhEGXWS4c+3KCfqAqIE6M=;
        b=HYF/nXisR9CBEGZhKZNjSt6PYe2Tr1FGUo5/S0FAw4gWKvmgKS3CpehBCF+D/gxFe9
         rxhr8ig0u/qi9l4FjkX2F0z4mAjE+baihRvfmZnZyY2Pto2apMtIjNHqqUjtOU19xiad
         AMkwA92YHGmR3KLojN1l671l79x9QZtUTWjXlxGJcSUFkwFw//EEylgqZ3mQBpMysgge
         74Xw46/EUVPk11ebYb8Yts4qXwrXUx4uTTaljLk4CGZDpWpGad7nl8k1BGrgAFdiNPpb
         8CGCzBmPlQ1ELSfnRng0SYi4I9X0mTPVVuOh6ALmpoBmVgZjbdWihy+i4iY9zK7FExZi
         BNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510913; x=1708115713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wQ7ycFTq+UkWN04lv4Q9eRhEGXWS4c+3KCfqAqIE6M=;
        b=tlOPq3Qt/Yb+Wiu3Zh2P2qu0jNMnHYM5waagztUESk5kMenAg5iomLP+7rVC+S3K/l
         GxVT6F6MZwYLmbm7DvWc3iek9qqkfnZA9lnLr/IsK0E1XIEGYycDsl2UWSReQPrIbKux
         91HAuyXF9sepX/OMh66u6hWvc3ovtPuDf9tQ9COKhMC02MskqINqfwcHJrX+weLUTMEP
         k3DzhFQkYVEOQhQpH9s0NJ90m0nyyRI3d4QQqfryZ3s5epzdtNi3fU7n7c9LT+OICnCr
         Q8H7NGbrltLr+t9D8DMGgn+LiJBDfVmltpfTcAei0RDFMM/ucmeOuToI1v3J4bjy5tXk
         rVQA==
X-Gm-Message-State: AOJu0Yzrr9nVSfU+KX/Jqrnuf1jYc8UFjke/aP+GfotkjhGDKOfmDHQw
	H1dTNLpK/z4RAPddsIN25fWOitiWGkRVmYBnYFPxtiekkbRdgQiaYU86YMW6qzadC9f+pLaWVIK
	BXObp5JtMvA==
X-Google-Smtp-Source: AGHT+IGSv8dfiyjx25/ppmvhb6xaU6XtnxIw4SzcUlrbnKhXn0zlAqW8Vev7s6wbTiR30U2YR1JWUnShDs5DAg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:58c4:0:b0:42c:4572:ac1c with SMTP id
 u4-20020ac858c4000000b0042c4572ac1cmr6136qta.2.1707510913213; Fri, 09 Feb
 2024 12:35:13 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:26 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-12-edumazet@google.com>
Subject: [PATCH v3 net-next 11/13] net: remove dev_base_lock from do_setlink()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We hold RTNL here, and dev->link_mode readers already
are using READ_ONCE().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 16634c6b1f2b9c0d818bb757c8428039c3f3320f..c2e3d8db8b013585dea62d8fbb0728a85ccac952 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2979,11 +2979,9 @@ static int do_setlink(const struct sk_buff *skb,
 	if (tb[IFLA_LINKMODE]) {
 		unsigned char value = nla_get_u8(tb[IFLA_LINKMODE]);
 
-		write_lock(&dev_base_lock);
 		if (dev->link_mode ^ value)
 			status |= DO_SETLINK_NOTIFY;
 		WRITE_ONCE(dev->link_mode, value);
-		write_unlock(&dev_base_lock);
 	}
 
 	if (tb[IFLA_VFINFO_LIST]) {
-- 
2.43.0.687.g38aa6559b0-goog


