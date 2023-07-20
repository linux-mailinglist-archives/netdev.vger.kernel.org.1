Return-Path: <netdev+bounces-19479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D107575AD8B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73CC2281E2B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734A917FFF;
	Thu, 20 Jul 2023 11:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633B17FF7
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:54:59 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA02D73
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:54:35 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4R6B1D4HS5z9slX;
	Thu, 20 Jul 2023 13:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1689854048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDvSWQprS4ixWqlrCdNjF5/7wf/KQlobtk0FxSHKfQs=;
	b=Vth8aiSjL3S5hDpcT2rGpS2HyJKMujT1vHXlyLvqGiPNl/waYdnw+LhBgqpd0316fD3u4O
	KFbJd7P9ZLmQpecZi/+SCGHzLsXG9Puo9pi1NO8b/Yk9E3OeTcMHK8S6MvtZ4HPL/PSwcz
	+evg5FwgWZsaLD3IQo8lzP9M2Z5Fh0aZMBHMS7kzdyRlFoehxuqNWJDxElGRbzh/x6ohAG
	I9Q4DFgBzJ1+Q4tSBj1UUP4Jst4fZmnlNtNzUhWK7jRb5y6koPVsNu4JH3wCWqz3iHRnkc
	dX9YM4tHpPAQl5Xh7RiipVXI2yzRV9ngtClnQ6zRI1cBN3N3wI+9xwqqe5JVVw==
References: <20230719185106.17614-1-gioele@svario.it>
 <20230719185106.17614-6-gioele@svario.it>
From: Petr Machata <me@pmachata.org>
To: Gioele Barabucci <gioele@svario.it>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [iproute2 05/22] tc/m_ematch: Read ematch from /etc and /usr
Date: Thu, 20 Jul 2023 13:49:20 +0200
In-reply-to: <20230719185106.17614-6-gioele@svario.it>
Message-ID: <87zg3q7q8x.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4R6B1D4HS5z9slX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Gioele Barabucci <gioele@svario.it> writes:

> Signed-off-by: Gioele Barabucci <gioele@svario.it>
> ---
>  tc/m_ematch.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/tc/m_ematch.c b/tc/m_ematch.c
> index e30ee205..1d0a208f 100644
> --- a/tc/m_ematch.c
> +++ b/tc/m_ematch.c
> @@ -21,7 +21,8 @@
>  #include "tc_util.h"
>  #include "m_ematch.h"
>  
> -#define EMATCH_MAP "/etc/iproute2/ematch_map"
> +#define EMATCH_MAP_USR	"/usr/lib/iproute2/ematch_map"
> +#define EMATCH_MAP_ETC	"/etc/iproute2/ematch_map"
>  
>  static struct ematch_util *ematch_list;
>  
> @@ -39,11 +40,11 @@ static void bstr_print(FILE *fd, const struct bstr *b, int ascii);
>  static inline void map_warning(int num, char *kind)
>  {
>  	fprintf(stderr,
> -	    "Error: Unable to find ematch \"%s\" in %s\n" \
> +	    "Error: Unable to find ematch \"%s\" in %s or %s\n" \
>  	    "Please assign a unique ID to the ematch kind the suggested " \
>  	    "entry is:\n" \
>  	    "\t%d\t%s\n",
> -	    kind, EMATCH_MAP, num, kind);
> +	    kind, EMATCH_MAP_ETC, EMATCH_MAP_USR, num, kind);
>  }
>  
>  static int lookup_map(__u16 num, char *dst, int len, const char *file)
> @@ -160,8 +161,12 @@ static struct ematch_util *get_ematch_kind(char *kind)
>  static struct ematch_util *get_ematch_kind_num(__u16 kind)
>  {
>  	char name[513];
> +	int ret;
>  
> -	if (lookup_map(kind, name, sizeof(name), EMATCH_MAP) < 0)
> +	ret = lookup_map(kind, name, sizeof(name), EMATCH_MAP_ETC);
> +	if (ret == -ENOENT)

OK, so this retains other errors, so e.g. -EACCES would be treated the
same as before, as a failure. I guess that makes sense.

> +		ret = lookup_map(kind, name, sizeof(name), EMATCH_MAP_USR);
> +	if (ret < 0)
>  		return NULL;
>  
>  	return get_ematch_kind(name);
> @@ -227,7 +232,9 @@ static int parse_tree(struct nlmsghdr *n, struct ematch *tree)
>  				return -1;
>  			}
>  
> -			err = lookup_map_id(buf, &num, EMATCH_MAP);
> +			err = lookup_map_id(buf, &num, EMATCH_MAP_ETC);
> +			if (err == -ENOENT)
> +				err = lookup_map_id(buf, &num, EMATCH_MAP_USR);
>  			if (err < 0) {
>  				if (err == -ENOENT)
>  					map_warning(e->kind_num, buf);

Reviewed-by: Petr Machata <me@pmachata.org>

