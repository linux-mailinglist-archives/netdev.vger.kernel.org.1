Return-Path: <netdev+bounces-121915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F4B95F390
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D689428396A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AD418BB93;
	Mon, 26 Aug 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3yEYoSr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003BD189B9B;
	Mon, 26 Aug 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681209; cv=none; b=mLETW0Hf+iLfNcmE1StM6RT4sQEhGdkbq9L03OkPYlEwvKrGx8zSpa+ouelmUsgfxTTsFflgtUiIlU5l1OpFknv7E4XPUrLJi8ON26HUhpDgw11bO+UFnqW9lc8R/c3eTjZ8Ih1njgnnkI8a7uz5x5ixEwhzwJnWsMd5+TyTBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681209; c=relaxed/simple;
	bh=eYhKdqmbOgOpwPshoynF2ep8F7c45+A4CXEJdjw4aQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlORqT+/yFHHzf8HCj/mkoajGhCCsb1LhxUt9VTtORFtzjZQUHr6zeprAx1tSlTPWqZmuyWM1GAhYzaZSa0nqX92LhUJpWbWd48E8maKR+OrFk0qF5xd5MG9n6ZiyookkxWJjxBhcqIwhUw7vedlupZfpwPRuwnn5Ty2aog36J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3yEYoSr; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so3016512a12.3;
        Mon, 26 Aug 2024 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724681207; x=1725286007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM53xOUKKs6zBpzOV/WWFuOMuEf1yqdWXeukAuL97eQ=;
        b=b3yEYoSr7lQlYdWtOnD0/4VtAMpiMN/1soNio/26n5KAUrNMt0kecq7b3acgKPBdqu
         TF5RogZ1BVUvOxzV7BJ9ASI97yv6ar4utc3XOKY1MSBfHVPwah8kSSW7aKJrtjVBnCUn
         FWljogbWue2ncVTxggBCuNghiydOjuqijufD2gJA2CsWjKlxjCti6JkLMzCFJeVeKr9N
         0liIVX24jYRqG8EHluWbH6P2gCHxad7XSn4BZy6UcdWi+yDrw7djLmOHRWug92j2weBa
         HVlHxv+U1uT2g6sP+AnTk/gt00OaXbvnSxNMeJ27/g83KXenIbb+fAVT5uLUHyy/Mt2/
         cHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681207; x=1725286007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM53xOUKKs6zBpzOV/WWFuOMuEf1yqdWXeukAuL97eQ=;
        b=Spxk5gWiYHAIko3xarZrxTEr1ubelKZxbmwBtw5Jni7c5mGM+uZPvfF8i3mzxieOP7
         Ecx6TmGddkfMukkSGIhJB/i4fMjUNHnJe468tonONUWVasq0kIjWd+B3XmaO7HrU2T7o
         ToPIZ3qySAXW0xBtcmBOWcWKoDZKHMGyD0U4ch2HmppayTXr/fEmoCK7L1XWxM/zBLub
         M8zPLc/3SSCtB1hR3HQI6ADMh7Sc4Z7D/y8s787iUw0c19UdSQD87TeoPVoPDC9zrBcV
         DpjOIZ5sPaRYqNPz2DoARdGehn+QIACg+q2bRpR8VbmRo0yATYwaiYmZ9aAStzLjZTxr
         DJoA==
X-Forwarded-Encrypted: i=1; AJvYcCWEowasG7OxhCkBN+qX17FfL9h5+keED4GMoVVLom8l1X1kRkXO+t+Btk3ptccEsoJWYlOhfx22zKFMB/E=@vger.kernel.org, AJvYcCX5sDsy/XxrbhlfNoBfTFOxFWLHWgjAojfST3o2DTYqTN5gTkLyvY4GYVfLX/y/2MoqiM4p5EH+@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWsCf4BqTvUNW2iU1FsPV9+oF2ULXNU1yqeI0enyzk29OoBxw
	wW6jk2oi6CRYgEHCE9xYcGNK077DnTNgqlw0Lwvwq9OX8+spkk4R
X-Google-Smtp-Source: AGHT+IEvO+yJa/93qw11J+66UpiT7wwLV6cPyTuH24FPbdYM5oGHgz9G77XLUb545uxk6bMp7z81vg==
X-Received: by 2002:a17:90b:1052:b0:2c9:5ecd:e3c5 with SMTP id 98e67ed59e1d1-2d646d38277mr11201760a91.33.1724681206634;
        Mon, 26 Aug 2024 07:06:46 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941e6esm9884161a91.26.2024.08.26.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:06:44 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [patch net-next v2] net: ethtool: fix unheld rtnl lock
Date: Mon, 26 Aug 2024 11:06:13 -0300
Message-ID: <20240826140628.99849-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826130712.91391-1-djahchankoike@gmail.com>
References: <20240826130712.91391-1-djahchankoike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethnl_req_get_phydev should be called with rtnl lock held.

Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 net/ethtool/pse-pd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 507cb21d6bf0..0cd298851ea1 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -227,8 +227,11 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
 
+	rtnl_lock();
 	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
 				      info->extack);
+	rtnl_unlock();
+
 	if (IS_ERR_OR_NULL(phydev)) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
 		return -EOPNOTSUPP;
-- 
2.43.0


