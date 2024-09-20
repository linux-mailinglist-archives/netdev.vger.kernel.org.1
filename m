Return-Path: <netdev+bounces-129087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433CD97D646
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA1FB23683
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C417965E;
	Fri, 20 Sep 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Y/bK/QA1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5C14A606
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839534; cv=none; b=agZCcxwiT3T6N6DDdcXNvbp/YMpmLmx8qByY+Nrfx3xeKK6BFxJJYNQw3lyvYo6qVhgHFRz+RCBx9OpD5YoVbzeaGXV3a8QjVNRYrPz+95pjczSk3D+PIzGKmCLbEo+ZG8faNhqSgGxfo5Iv8/M8gD4XXqkz3VbEeRJwHEAwO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839534; c=relaxed/simple;
	bh=8RX0ToiJ3nDIjmLMVMGnIGFYp5BifwqJCCSLaxLJ4Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij52CEomy0TQv+kfAJk9T4NSr16TD660T3rVH2Ap8p0AjbnLfmhHlpxb1l+onFmblPTB1+flw8rB8ZNAna/ghuMzTByrfrRxnKntc7CkJHJL7h4J2x3bN8ugK/pp6Oy21JN69Ce9eb2x5UQYdv1asSm5HrlBk4mzBWewvhkaupk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Y/bK/QA1; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X9D4H57tXzvw1;
	Fri, 20 Sep 2024 15:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726839519;
	bh=LiYOG+j3lD+klQhAmAPE7DaKnA63+juYhKoS9N+wwcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/bK/QA1tfvQ8qImQihP7H+bSmhQnLcYAG/5pdmnaD/Fwbn+vKthMUIzskH1Amb72
	 RPzL6K0kXILI7MbC8afrSsWeQodAHF/9ZHS/I+PToI4O55DWTar2RR6uupkgCjZbk5
	 6JX71N073CaFqQC17FHetaIUqPN8OdOh8KNvEeEc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X9D4G0ls7zkty;
	Fri, 20 Sep 2024 15:38:38 +0200 (CEST)
Date: Fri, 20 Sep 2024 15:38:27 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: Re: [RFC PATCH v1 1/7] samples/landlock: Fix port parsing in
 sandboxer
Message-ID: <20240920.ahNgahzoh2ie@digikod.net>
References: <20240916122230.114800-1-matthieu@buffet.re>
 <20240916122230.114800-2-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916122230.114800-2-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

Thanks for these patches, they look really good!  I'll review all of
them soon.

CCing Konstantin and Mikhail who work on network support.

On Mon, Sep 16, 2024 at 02:22:24PM +0200, Matthieu Buffet wrote:
> Unlike LL_FS_RO and LL_FS_RW, LL_TCP_* are currently optional: either
> don't specify them and these access rights won't be in handled_accesses,
> or specify them and only the values passed are allowed.
> 
> If you want to specify that no port can be bind()ed, you would think
> (looking at the code quickly) that setting LL_TCP_BIND="" would do it.
> Due to a quirk in the parsing logic and the use of atoi() returning 0 with
> no error checking for empty strings, you end up allowing bind(0) (which
> means bind to any ephemeral port) without realising it. The same occurred
> when leaving a trailing/leading colon (e.g. "80:").

Well spotted, thanks for this fix! Can you please send a standalone
patch series with this patch and the next one?  I'll merge the fixes
soon and it will shrink the UDP specific series.

> 
> To reproduce:
> export LL_FS_RO="/" LL_FS_RW="" LL_TCP_BIND=""
> 
> ---8<----- Before this patch:
> ./sandboxer strace -e bind nc -n -vvv -l -p 0
> Executing the sandboxed command...
> bind(3, {sa_family=AF_INET, sin_port=htons(0),
>      sin_addr=inet_addr("0.0.0.0")}, 16) = 0
> Listening on 0.0.0.0 37629
> 
> ---8<----- Expected:

When applying this patch, only the following text gets in the commit
message.  I guess that's because of the previous "---".

> ./sandboxer strace -e bind nc -n -vvv -l -p 0
> Executing the sandboxed command...
> bind(3, {sa_family=AF_INET, sin_port=htons(0),
>      sin_addr=inet_addr("0.0.0.0")}, 16) = -1 EACCES (Permission denied)
> nc: Permission denied
> 

You can add this tag for this fix to be backported:

Fixes: 5e990dcef12e ("samples/landlock: Support TCP restrictions")

> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  samples/landlock/sandboxer.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index e8223c3e781a..a84ae3a15482 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -168,7 +168,18 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  
>  	env_port_name_next = env_port_name;
>  	while ((strport = strsep(&env_port_name_next, ENV_DELIMITER))) {
> -		net_port.port = atoi(strport);
> +		char *strport_num_end = NULL;
> +
> +		if (strcmp(strport, "") == 0)
> +			continue;
> +
> +		errno = 0;
> +		net_port.port = strtol(strport, &strport_num_end, 0);

Using strtol(3) is a good idea, for instance to check overflows.  You
can talk about that in the commit message.

> +		if (errno != 0 || strport_num_end == strport) {

I was thinking about checking the return value instead of errno, but it
looks like the strtol() API may set errno while returning an unspecified
value, so your approach looks good.

> +			fprintf(stderr,
> +				"Failed to parse port at \"%s\"\n", strport);
> +			goto out_free_name;
> +		}
>  		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>  				      &net_port, 0)) {
>  			fprintf(stderr,
> -- 
> 2.39.5
> 
> 

