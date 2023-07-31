Return-Path: <netdev+bounces-22940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF776A20D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 22:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2775C2815FA
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332818C26;
	Mon, 31 Jul 2023 20:38:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1435D1800B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 20:38:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C42C198;
	Mon, 31 Jul 2023 13:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ISelzNfwyo+LcVPzu+i+zMJl2RrP3z4luSWxJvJvqhk=; b=ecUqOk1P/oc9OcuXHSZ4MXiHaz
	s/PUYhO4jddknCn7BxNh6AzglP5ru5XtyE4NPHgTggJ0hBrG/vFhkvbG5IJbN1J7hGM0EDaSwc+pQ
	TsZc+j9vY2HQCy+iTROBNCUObuLKlTx3SROOpnfU/3kMNRKFdtDEEXomOVD/pJcUfyog6zrUK/ISn
	regdYt0O7+gGqlcThcy60t/PrOiRSerwdcBtDt1m4wQGOE4knIxa9iQKHqmL9w58KiZAnE9IT07Ub
	1nty92Qo1vZPqkwYQTLkzX3ueFVI5MOeL/cKXq8eA/gAQ8Ryd1hzXRsM73GsRhoxl8qgKPID3F/cN
	IJkuQY5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qQZey-00HJ3x-0X;
	Mon, 31 Jul 2023 20:38:32 +0000
Date: Mon, 31 Jul 2023 13:38:32 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@nxp.com>,
	Joshua Kinard <kumba@gentoo.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/5] modules: only allow symbol_get of EXPORT_SYMBOL_GPL
 modules
Message-ID: <ZMgbyNKnotCMyB+f@bombadil.infradead.org>
References: <20230731083806.453036-1-hch@lst.de>
 <20230731083806.453036-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731083806.453036-6-hch@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 10:38:06AM +0200, Christoph Hellwig wrote:
> ---
>  kernel/module/internal.h |  1 +
>  kernel/module/main.c     | 17 ++++++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index c8b7b4dcf7820d..add687c2abde8b 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -93,6 +93,7 @@ struct find_symbol_arg {
>  	/* Input */
>  	const char *name;
>  	bool gplok;
> +	bool gplonly;

We'd want to add here a reason or something like that to allow the
caller to know why we failed if we want to provide feedback.

>  	bool warn;
>  
>  	/* Output */
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 59b1d067e52890..85d3f00ca65758 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -281,6 +281,8 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
>  
>  	if (!fsa->gplok && syms->license == GPL_ONLY)
>  		return false;
> +	if (fsa->gplonly && syms->license != GPL_ONLY)

And set it here to something other than perhaps a default of NOT_FOUND.

> +		return false;
>  
>  	sym = bsearch(fsa->name, syms->start, syms->stop - syms->start,
>  			sizeof(struct kernel_symbol), cmp_name);
> @@ -776,8 +778,9 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
> @@ -1289,14 +1292,18 @@ static void free_module(struct module *mod)
>  void *__symbol_get(const char *symbol)
>  {
>  	struct find_symbol_arg fsa = {
> -		.name	= symbol,
> -		.gplok	= true,
> -		.warn	= true,
> +		.name		= symbol,
> +		.gplok		= true,
> +		.gplonly	= true,
> +		.warn		= true,
>  	};
>  
>  	preempt_disable();
>  	if (!find_symbol(&fsa) || strong_try_module_get(fsa.owner)) {
>  		preempt_enable();
> +		if (fsa.gplonly)
> +			pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",

Because here fsa.gplonly is always true here so the above warn will
print even if a symbol is just not found.

  Luis

