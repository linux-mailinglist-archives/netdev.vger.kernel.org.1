Return-Path: <netdev+bounces-246628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B5CEF766
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 00:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 708F13006E08
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9DA2D321B;
	Fri,  2 Jan 2026 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3RjcTdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCB29B22F
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767396101; cv=none; b=ReR5zqQ0WSJqy7iex9plHw9+NErJ5AaZUYbHd36tiWUrMopBbv4WpF6bb63ZVkNjTgOZjWt7pldx88+Pdwt4da9sVexkhx17K7lUWDJuvN6yCf+Av+HQaeElhtjJw+VdsmQjvEXLv7lXAUUcqxR3F+7NWPQpBx5+U/Y0rg8COec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767396101; c=relaxed/simple;
	bh=f4kteEJWqfB5NQC+HtTP0VKtTfVlTEXeEMM71ASFoaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HWUY1QwtVqIdkuXmc3C3DI6QaBmx2vG9tp7lBV2+0usnoZd2vv6XAjH4X9u/qJzkXawbkwZMAqGMz600Xf8ZtTBZNm+qCSy4mt95/fGXOG7yUt6juOtBhpK62WL3G6Pck+qxi0IGlPmEHlcmLIP31EdGLj5chMG6rSHm7Ma90Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3RjcTdg; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c6cc366884so6070332a34.1
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 15:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767396098; x=1768000898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKhe5lXW6R7PuCU3Ipdc8PAGYW/AaKmllbW+NUzDHeo=;
        b=T3RjcTdgx2hDyfVJjzK12DFwy0O9YtQCiCqbjUlwYKRVNvSOablDjnfvP7bD+Fcs58
         tcPJSevDBb0GONFuc58I7aP3P5CcwUlWBNgCF6IhYEAdISAg+sfQ0XU2gKXFhO3vjtzo
         Yz7k/QeLYHtb35J+WmX68zvov0eh9gLF+P8Xde8zYVaMFitug77kkP9zhkEbhUTznEK2
         FBl/8R3S4vo5KYtMoXTaKLvgO3PFLdNOWKsQjv0B4j23YAW6338eMnEpr8XrZbUetpPE
         leFCqss4rTHQwhhXCyK5yo/dZptZbxTn/M200Kd7CF9rkL9LvJxtyTlxkUi7IHL0HLYO
         qj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767396098; x=1768000898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKhe5lXW6R7PuCU3Ipdc8PAGYW/AaKmllbW+NUzDHeo=;
        b=RaHxZrMrYxhJ0ah7uajqyVQVZuNSmU96btlaIyQpg5VwcrbOOHyPvAT3LPGO6ebObM
         temjlzK9f7Wk4pLDYakZw84/5T3vy3weEa4ZLTcKvIqRdhRN2PQq/mUyNmpXBK3C+QnF
         U6FqI4Z8iYsd2kONbxyVqJ92wmzc0JMiYMiQL2PYHGAnzGUlCSpSlMHRkDWTzRZ2ebYi
         O5m2Oby7SJuhGdAJi2wwm3Z125KwQniTzeReJ6DYlKgkN91Y8CYG4xCHkZErxp+DlswY
         80T5pRjHy2JJXpjpJxzy4po11XCjoOq31Kjd5IBPjDoJyu/nXG7/Zo29IebZt05WSf2/
         u+Gw==
X-Gm-Message-State: AOJu0YwO70SGe7qYLZBaONkniI102idn42FvTnNrvnQIAEhXaheTjvwi
	9Bb1uD1qwEeJxiisnmid39gM5rHTXYOFNOGHnkaeWOfQXILU1zd2L3NH+5BKT5yd
X-Gm-Gg: AY/fxX5E/wiOZmfZr3QFsuYGiAqj/BOP5Jr13nXpVFSquKzsCKoV464TT7mffVyRf/t
	GIir0TN58R4aned8LxH6w71RhkDS6UJoI8GBR6NQG9xYFbZ1yf4GwJo+d6feWcdlKsN9BVGBwPE
	8V55DTNE4IghvW/FoYkKUbFUVHAjae12AWl2go0QgzrMqJWm891Wq1QY1zvj/qiiOQXTm3sTlmx
	4J3chlKBU1H//uY3uevDbE80zd3pvHMl/lKRYPHrZA3wiiOz0mU910x9apNOiufccCnw441aRIp
	rZv3RGVcIWPbrNvJK9sTWQ9Up9bYA9HS/sTrJb70C6uyNV/6+QpvgP588D/xtJmU6NbGchP8rRG
	upg6QQAyI53xrR3UdO5bSPGWxdsiHqdg61iLgFp158L4Bbbi/noral7z0oMkpJv0Q55XYsF51Qe
	RZC+AIVFRrS6zZHqZAh59WzHF4H9jYAj6Kjlu1skX5BzI=
X-Google-Smtp-Source: AGHT+IH0q/1hPcl4M/DWj6mwHSJUevT+paP2kujg0wB8vzvyehp7qn4CfGnDzFR9wYyDHvT2JeJmBg==
X-Received: by 2002:a4a:e252:0:b0:659:9a49:8e09 with SMTP id 006d021491bc7-65d0ebd893cmr14867076eaf.75.1767396097818;
        Fri, 02 Jan 2026 15:21:37 -0800 (PST)
Received: from shiv-machina.. (97-118-238-54.hlrn.qwest.net. [97.118.238.54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f69b9e9sm25421627eaf.12.2026.01.02.15.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 15:21:37 -0800 (PST)
From: Shivani Gupta <shivani07g@gmail.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shivani Gupta <shivani07g@gmail.com>,
	syzbot+8f1c492ffa4644ff3826@syzkaller.appspotmail.com
Subject: [PATCH] net/sched: act_api: avoid dereferencing ERR_PTR in tcf_idrinfo_destroy
Date: Fri,  2 Jan 2026 23:21:16 +0000
Message-Id: <20260102232116.204796-1-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a crash in tc_act_in_hw() during netns teardown where
tcf_idrinfo_destroy() passed an ERR_PTR(-EBUSY) value as a tc_action
pointer, leading to an invalid dereference.

Guard against ERR_PTR entries when iterating the action IDR so teardown
does not call tc_act_in_hw() on an error pointer.

Link: https://syzkaller.appspot.com/bug?extid=8f1c492ffa4644ff3826
Reported-by: syzbot+8f1c492ffa4644ff3826@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8f1c492ffa4644ff3826
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
 net/sched/act_api.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index ff6be5cfe2b0..994f7ffe26a5 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -940,6 +940,10 @@ void tcf_idrinfo_destroy(const struct tc_action_ops *ops,
 	int ret;
 
 	idr_for_each_entry_ul(idr, p, tmp, id) {
+		if (IS_ERR(p)) {
+			WARN_ON_ONCE(1);
+			continue;
+		}
 		if (tc_act_in_hw(p) && !mutex_taken) {
 			rtnl_lock();
 			mutex_taken = true;
-- 
2.34.1


