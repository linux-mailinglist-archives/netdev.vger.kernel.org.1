Return-Path: <netdev+bounces-14580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C21742793
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBFD280C2D
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F2811C8E;
	Thu, 29 Jun 2023 13:40:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377E11C89
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 13:40:44 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01FC3594
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 06:40:42 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QsKMq2XFbz9skx;
	Thu, 29 Jun 2023 15:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1688046039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQXxizR1uTsuVpYNguosUQBLFEcEenE7jC8bNtFlswM=;
	b=QirgCk7mEE/snxywwUj77fAHUra3L7FF92UgFp1pBXsiVHPfBWFvG31h58co2OS0q6uogG
	JV8UZJd2KsuE/msUDhU8cDkscAWbvXzNRzERs16QaWJYADhWe1cUzm4tNTMh2ckOzVaMQq
	NLAP0AJ3YLjqTVNhxgzeEb+cD+OlozmTLX+EFeBSC+sh7Sj2FAoJKFOe9mxaM8E0eqTMOo
	PCFf/2nkbJlitfnpNqdtK7UWVxzhUBmhkGT6luSBuXebQaQxH+Fo+VfdAMeZ89qOzuVh38
	0PXaYyDp0rAljGU/9Pt6E9REcTPUmiYpy7SGV1XEcdVlB/BiV9MJiFDXq9f/jw==
References: <20230628233813.6564-1-stephen@networkplumber.org>
 <20230628233813.6564-4-stephen@networkplumber.org>
From: Petr Machata <me@pmachata.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 3/5] ss: fix warning about empty if()
Date: Thu, 29 Jun 2023 15:14:27 +0200
In-reply-to: <20230628233813.6564-4-stephen@networkplumber.org>
Message-ID: <87pm5ee699.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Stephen Hemminger <stephen@networkplumber.org> writes:

> With all warnings enabled gcc wants brackets around the
> empty if() clause. "Yes I really want an empty clause"
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  misc/ss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/misc/ss.c b/misc/ss.c
> index de02fccb539b..e9d813596b91 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -627,8 +627,9 @@ static void user_ent_hash_build_task(char *path, int pid, int tid)
>  
>  			fp = fopen(stat, "r");
>  			if (fp) {
> -				if (fscanf(fp, "%*d (%[^)])", task) < 1)
> +				if (fscanf(fp, "%*d (%[^)])", task) < 1) {
>  					; /* ignore */
> +				}
>  				fclose(fp);
>  			}
>  		}

Reviewed-by: Petr Machata <me@pmachata.org>

As an aside, this whole if business is necessary in the first place due
to __attribute__((warn_unused_result)) that fscanf apparently has on
some libc's. But ignoring fscanf failures is safe, because a) `task' is
pre-initialized at variable definition, so ignoring the result like this
should indeed be safe; and b), fp references some file in /proc and we
can rely on the format and that the scan will in fact not fail.

