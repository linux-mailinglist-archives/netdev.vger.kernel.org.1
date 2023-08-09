Return-Path: <netdev+bounces-25653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D19775027
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671401C210BA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F022443F;
	Wed,  9 Aug 2023 01:07:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F24437
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:07:48 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC1B1BF7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:07:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d47a02fc63fso4863729276.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543266; x=1692148066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MG9K9YUhTMTzK19uCHNnSBLcKhcXx1YxnQhkeYxtQnQ=;
        b=FLufdnQLID7CLFxDuinWTCHCNOM0tHWDzh/Q+ezwYBHvUhcKrvNRwf2X/858fNR7wb
         d8vbxPP43ceY/pyaj0Uw5PQ59JrcnSpcF/a3LfcIMqUOkY5p5Iam1144VCB1Ons2vj81
         BmLiwO5IZchhdKNB3Hp+SHWii5wcBQkoVNE1bp5inoSeur+njvbFP1qGHTgPtXq1kfjg
         BEkjKbj13r7baEfK+6B3OTRz0y7Eybl5D1FWifL02RvN4LssSj5E1eUpHkMefprJM5KT
         H0ueJcMX3S8gV9suDKG8GXE43UgliTiV3eYQCRxb8WAldQnhoOh0RconuamFRyja+cUu
         eP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543266; x=1692148066;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG9K9YUhTMTzK19uCHNnSBLcKhcXx1YxnQhkeYxtQnQ=;
        b=ZFeHf9YTrREhZrdCnRl019GQTfc87Mao1zEFPQ7daPtad32fEpKUzPTm6B6T7WjGnw
         J1oAHMZuv9C1Z4595eOKHtpoQXvKzmhMbsgK2pozy+rMZ40Oj5Im+rs5bedX2u0Um/qG
         k83xz9IV01eWkEKd17EOqfyEkY89cccjtHEe88YdU5oP8x8s9c5GV7ZnOSLlLOtiwe8k
         bHwS25Yu/IrK8Z5Z1/PLbFNp1v2ohjVYoHm2gWpu/hAgXo6OJnf01iXkYefGQROcHRhD
         sZX16rB6eDCtdy2++JKvf2/0VHMmv4dy8UaeXPjF0CxyUi2DrBfBYeNCSVXgSBTVzdcM
         gC7A==
X-Gm-Message-State: AOJu0Yx8cB49H0M5cZOK0VNAe6A//f2Aw9acDp4F5w5pXTc+4SZHZCBb
	7kIQ08p3pWI5mE4XceNCTqaiIsEi6A2HKstwig==
X-Google-Smtp-Source: AGHT+IHZpwGDo8C14lufhH346u2Bau1BUWvvndGq88fm59ryfmewZSsy7jAPCKUfUcYrjFtU1dpqY0m+aY5jSzBV5Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ad26:0:b0:d58:6cea:84de with SMTP
 id y38-20020a25ad26000000b00d586cea84demr24517ybi.11.1691543266633; Tue, 08
 Aug 2023 18:07:46 -0700 (PDT)
Date: Wed, 09 Aug 2023 01:06:10 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=1182;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=PvqWKqnPHt6FvPDmHzVp42icOwjac4OjqNFq/tqlT4Q=; b=sh9zj/YLC302K92KXYEsgv5KQ7slHtAn4AjmXQutkadONIDR1z3dS2tfhEUE1/fEjCLLxhXmz
 uQNQ/ErDWgqDBqL2ooZ4J+hnTeNjcylCNu2Z3wgVuRaaaBWLe9vWLDa
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-7-5847d707ec0a@google.com>
Subject: [PATCH v2 7/7] netfilter: xtables: refactor deprecated strncpy
From: Justin Stitt <justinstitt@google.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prefer `strscpy_pad` as it's a more robust interface whilst maintaing
zero-padding behavior.

There may have existed a bug here due to both `tbl->repl.name` and
`info->name` having a size of 32 as defined below:
|  #define XT_TABLE_MAXNAMELEN 32

This may lead to buffer overreads in some situations -- `strscpy` solves
this by guaranteeing NUL-termination of the dest buffer.

Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: build tested only
---
 net/netfilter/xt_repldata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_repldata.h b/net/netfilter/xt_repldata.h
index 68ccbe50bb1e..5d1fb7018dba 100644
--- a/net/netfilter/xt_repldata.h
+++ b/net/netfilter/xt_repldata.h
@@ -29,7 +29,7 @@
 	if (tbl == NULL) \
 		return NULL; \
 	term = (struct type##_error *)&(((char *)tbl)[term_offset]); \
-	strncpy(tbl->repl.name, info->name, sizeof(tbl->repl.name)); \
+	strscpy_pad(tbl->repl.name, info->name, sizeof(tbl->repl.name)); \
 	*term = (struct type##_error)typ2##_ERROR_INIT;  \
 	tbl->repl.valid_hooks = hook_mask; \
 	tbl->repl.num_entries = nhooks + 1; \

-- 
2.41.0.640.ga95def55d0-goog


