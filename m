Return-Path: <netdev+bounces-38422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E26FB7BABC7
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 317B2B2098D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C64B41760;
	Thu,  5 Oct 2023 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3UHxsNuJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEBC4177F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 21:05:47 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FF9C0
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:05:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a2318df875so21371347b3.2
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696539944; x=1697144744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H4y2YlrnXWnp/3hBKGWFmY8QqOEGdTjDuhv++ThsjEU=;
        b=3UHxsNuJw13MYYcb1v/IzDb9O+Ehjey4iE5+8L7c4DKUlVB59vKzKp7yRpDq2MORDy
         uhE9ga55yAyh0ZkC0+58TtAFMP94wBZd9phHO4SBc2KC3bYAncqR6aLIVwyKcrPxvKQv
         UQtq5gYNQFTQKdzRmWEEDiNhFqb+YndaqyqZzk589ePyq570td+Ur8WNiOYvMHWgO+Qh
         Pkb9DAAmCfJBB1WU7EsrJcmv3rMDJUp75MFmwXI/iNcNLdCji/gOyAgZkDdqw63uFqfb
         p2odL43ZiZ19uHM23jeqMWL4aQZ4EPoKAu0S6xiUYgknczYDwVHp5cCiSz2LfxZyco/9
         oXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696539944; x=1697144744;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4y2YlrnXWnp/3hBKGWFmY8QqOEGdTjDuhv++ThsjEU=;
        b=XWUUOUneoWZynPnCTeWcfejBr4ND/q5mF9bC2HyHxlxeQkRvYlf7qLE3zOJlgqus0B
         lT7OLatEGQMpqnwywlITy9p57v5Et1GB1IHstL3l5vFhiKWOaZO2/iA4k9FtFiznzi6R
         HQ5NJno0EILsP0wU1aO2l3WmrD9MmJLvyYOfKTSCZrZQ3w3wI0QSsVmtGolJK56RTAqd
         qqd/3A/3XjHgkW6Xx75kEP5m2bstt9FuwoBKkJKpTYfRySCDyqyAUvWzb8vynVIaH57c
         GwHuJZEcwK1oF5XGxep5UrxvybVDT1GPHgimKyMlRVmyYNWLrkqJXXYt30QVXQtilj3Z
         W1pw==
X-Gm-Message-State: AOJu0Yy0+k+Np3zKIQnsEAm8L+fig/B71ca/31rFWAVIu/aGQpWNqfiG
	z+awdLZnFkVrwmvWZahngExL3HIh9BHSoyldJw==
X-Google-Smtp-Source: AGHT+IFYZDAsDI3aH1FkA57sI5MM9STwBtsstxHMNmmbHQo/N9JCli+azP76TBoo+x7ITXmPrGjh48fOOPj243Ue6Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:db48:0:b0:d7a:c85c:725b with SMTP
 id g69-20020a25db48000000b00d7ac85c725bmr87457ybf.7.1696539943849; Thu, 05
 Oct 2023 14:05:43 -0700 (PDT)
Date: Thu, 05 Oct 2023 21:05:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACYlH2UC/x2NywrDIBAAfyXsuQsaqdj+SinFx9rsRcMqISXk3
 2t7m7nMHNBImBrcpwOENm5cyxB9mSAuvrwJOQ2HWc1GK3XF1qXE9YNJeCNpWKgj9YXkB0Fq9Ik wFI8h+xfXiBGty9rcrM3GORjhVSjz/p8+nuf5BXYfPFuEAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696539942; l=1996;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=iWuTwxZczKzh+7gmgNXvK16vk7UgCuMWmTg1ny2oD8c=; b=YUlHgcN+oWStnkY0k8QsPE2sF9MJDlMlJwDVM6YDuXy2QvULO8Sa7bbF2I2FRmDvDk+53iYiN
 PyeP9/j4AHXAubuga/ZsL0+ZE9XOJq358MDHfpYVgcH2yjIPsxeX8yO
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v1-1-8dfd30123afc@google.com>
Subject: [PATCH] bna: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>, 
	GR-Linux-NIC-Dev@marvell.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

bfa_ioc_get_adapter_manufacturer() simply copies a string literal into
`manufacturer`.

NUL-padding is not needed because bfa_ioc_get_adapter_manufacturer()'s
only caller passes `ad_attr` (which is from ioc_attr) which is then
memset to 0.
 bfa_nw_ioc_get_attr() ->
   bfa_ioc_get_adapter_attr() ->
     bfa_nw_ioc_get_attr() ->
       memset((void *)ioc_attr, 0, sizeof(struct bfa_ioc_attr));

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
index b07522ac3e74..497cb65f2d06 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -2839,7 +2839,7 @@ bfa_ioc_get_adapter_optrom_ver(struct bfa_ioc *ioc, char *optrom_ver)
 static void
 bfa_ioc_get_adapter_manufacturer(struct bfa_ioc *ioc, char *manufacturer)
 {
-	strncpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
+	strscpy(manufacturer, BFA_MFG_NAME, sizeof(manufacturer));
 }
 
 static void

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-68f13966f388

Best regards,
--
Justin Stitt <justinstitt@google.com>


