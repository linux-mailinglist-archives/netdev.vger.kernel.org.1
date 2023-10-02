Return-Path: <netdev+bounces-37516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508A7B5C07
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C151A1C20863
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B272030C;
	Mon,  2 Oct 2023 20:27:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F120309
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 20:27:02 +0000 (UTC)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA89C9
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:26:59 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Rzstn6xRTzMpnqQ;
	Mon,  2 Oct 2023 20:26:57 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Rzstn4QlCz1Jm;
	Mon,  2 Oct 2023 22:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1696278417;
	bh=RzP6rUMZRwJXcm9nbI9v+6nmC1mwKqcqVRxqX6fvfPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XH0yBUUeoFP6breSuPJWxxybKwF58111DYqF3DcRJ+xUIkSfiwtDIl2cR5Howxwzz
	 Mbn9w0t7D3DNF0feXSJyrIFEnW/vtAcwYtJJq9vHWGLo6t6/0l7xw7+oA5SeFAmGs5
	 1h0vBXnihXLDBVHuhLMVA+4pZTaDjYW7AZnxLKXs=
Date: Mon, 2 Oct 2023 22:26:57 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH v12 09/12] selftests/landlock: Share enforce_ruleset()
Message-ID: <20231001.Aiv7Chaedei0@digikod.net>
References: <20230920092641.832134-1-konstantin.meskhidze@huawei.com>
 <20230920092641.832134-10-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920092641.832134-10-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 20, 2023 at 05:26:37PM +0800, Konstantin Meskhidze wrote:
> This commit moves enforce_ruleset() helper function to common.h so that
> it can be used both by filesystem tests and network ones.
> 
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
> 
> Changes since v11:
> * None.
> 

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 251594306d40..7c94d3933b68 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -677,17 +677,7 @@ static int create_ruleset(struct __test_metadata *const _metadata,
>  	return ruleset_fd;
>  }
> 
> -static void enforce_ruleset(struct __test_metadata *const _metadata,
> -			    const int ruleset_fd)
> -{
> -	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> -	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0))
> -	{
> -		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
> -	}
> -}
> -
> -TEST_F_FORK(layout0, proc_nsfs)
> +TEST_F_FORK(layout1, proc_nsfs)

Why this change?

>  {
>  	const struct rule rules[] = {
>  		{
> --
> 2.25.1
> 

