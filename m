Return-Path: <netdev+bounces-54409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED44806FE5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0B31C209BA
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35158358B6;
	Wed,  6 Dec 2023 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TxQ8Mjo+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABBAD1
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:37:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3334254cfa3so395054f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 04:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701866243; x=1702471043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jz+VDB9IuC8ai+mZOJOJXmrBtxu8BlNDpDW3sPbwSdg=;
        b=TxQ8Mjo+LbP/ynwQnqWNEY3XvKx/uhIVob6xcE9KMNRyaoc/o5PL+KKE3Iic9NJ/OI
         TtQjSOTucUAKyBs+4TK64U7TvPbd6UVEc2Ftops4WrPZ4oIJXPsig8qwn4jaEo3oJIC2
         MKlbuRKw4rfAUEqdUMtPQTwrZdAsZnZ7E0UXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701866243; x=1702471043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jz+VDB9IuC8ai+mZOJOJXmrBtxu8BlNDpDW3sPbwSdg=;
        b=eynIMuS+sspb4qBeTwUP5vjnqmcY6rBgGAGdltDYzFzuvy2ZDvXb9nKUnLrBTuTZ2U
         7pUMRvM7Is5uFWxaB4UgDmo+a2GMKdieF7HSB3ybYEqQ3vU0MAXsyRca7Qb58nI3ShI5
         vI2uzEywlIaFXXE+hZOtetMcpkdVOuzaMsmpGOihaWJoJ92k0GVu3sUvTcZESSbHGhZJ
         T9kerQNctl7oThV4Oqf5Zi6I/Ib4vy5m57YmS/1/wpxfzi9eG2tppx45n8ajY1jvO/cm
         sSagEkZ8Gjz/+iDQxlEeKYcr6mfYmu7Ce3+8w8C2jg5LkOEOyjPAAETgdFafizXDTKUp
         VlVA==
X-Gm-Message-State: AOJu0Ywd6ozdFT4JfwDo1zV7yhem4dYoMCA/cAIzrhj4rZSiGKMYyN8R
	PcJNAHJxu/bTVwszZTSTYNNWZbt/9bctC6g6AmI=
X-Google-Smtp-Source: AGHT+IEbEl3hPWVlP/0jGUWl2nFn7sZhfzLO6OUH1KO/RKEZwzndAZVUa4pZ+va7kn+WQ26dPSmoSg==
X-Received: by 2002:a5d:424e:0:b0:333:2fd7:95f5 with SMTP id s14-20020a5d424e000000b003332fd795f5mr496465wrr.48.1701866242861;
        Wed, 06 Dec 2023 04:37:22 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:628b:53d7:2bbf:7988])
        by smtp.gmail.com with ESMTPSA id q15-20020a056000136f00b0033332524235sm14005573wrz.82.2023.12.06.04.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 04:37:22 -0800 (PST)
From: Florent Revest <revest@chromium.org>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Florent Revest <revest@chromium.org>
Subject: [PATCH] team: Fix use-after-free when an option instance allocation fails
Date: Wed,  6 Dec 2023 13:37:18 +0100
Message-ID: <20231206123719.1963153-1-revest@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __team_options_register, team_options are allocated and appended to
the team's option_list.
If one option instance allocation fails, the "inst_rollback" cleanup
path frees the previously allocated options but doesn't remove them from
the team's option_list.
This leaves dangling pointers that can be dereferenced later by other
parts of the team driver that iterate over options.

This patch fixes the cleanup path to remove the dangling pointers from
the list.

As far as I can tell, this uaf doesn't have much security implications
since it would be fairly hard to exploit (an attacker would need to make
the allocation of that specific small object fail) but it's still nice
to fix.

Fixes: 80f7c6683fe0 ("team: add support for per-port options")
Signed-off-by: Florent Revest <revest@chromium.org>
---
 drivers/net/team/team.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 508d9a392ab18..f575f225d4178 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -281,8 +281,10 @@ static int __team_options_register(struct team *team,
 	return 0;
 
 inst_rollback:
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
 		__team_option_inst_del_option(team, dst_opts[i]);
+		list_del(&dst_opts[i]->list);
+	}
 
 	i = option_count;
 alloc_rollback:
-- 
2.43.0.rc2.451.g8631bc7472-goog


