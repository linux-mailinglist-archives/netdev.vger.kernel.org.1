Return-Path: <netdev+bounces-130134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645E6988804
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 17:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFA0B21AA5
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50791BFE1A;
	Fri, 27 Sep 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOsw4nN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CC15443B
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449976; cv=none; b=G0HGcDNPN6ISrdCgeoofVrG7z/B19XX+efb+Ds24YTfjik5RhHHVdnueF3bijpbtLmbjnPZaqFArCpjIoWtRz4Bz3xZ9PtZE+MdbSqm6sv/E7gRimb0FyR983UKw9ycL/7c8ZNz3QnX7ciMO1DezKPk8DJHjVU5CX20XBtOvLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449976; c=relaxed/simple;
	bh=XOmeNX3lHkeuSYdiVsJyXjn/zOaQyv0xyXfwZDU/QtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sTZDw0Gj4aBHO/9TgpYxzsLNbkkUQb94k4op0Zfz8ehpWpxt92RWtHAkafHoAG+rHPS4Hhzr5OtY9M2aIN72DQsfp/xAPjH/U+5oINAmTZVwDJBLpnUEz0aiAk9OwHNd/5ZLzpgdPKHzowe3ySblTqV93DyRcIHwTtwdqZUEN2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOsw4nN9; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a8d0d87f204so382308166b.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 08:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727449972; x=1728054772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSugix78U9Dl+H3lmeeGG8/58RwtpcFqxDTceAouLeI=;
        b=sOsw4nN9N1DKJx1PGD+GhoV8f10pccHEtUz8IhmRXJc+Ztey0Kk+92vsjDL7/hwuth
         Pek3Iuq0f3hPIv1ohRcFtlOgcM48PMBsskiOHo80I+maUvvXJJr10HL38xRppt3EKl8f
         +dfjJ2rLAzNh4kOU7fYnX+BhGpNkAM8DfLg2gJVZBxb2b8G2V2fdJA/3EHa7WGO5vMpi
         hP9AT95Y7Ilvij9Rv+uH952Cez/rD84o4yKwpbBySEAO1yq0CwDHV2G/bQg6xB6uN5qu
         jmiYrS2Urt/Vk+ibyUfUiP1EdzTmb9eA5Kf4bmvHgg7faJID2yeWrdGlKghpEFJWYdZE
         4ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449972; x=1728054772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSugix78U9Dl+H3lmeeGG8/58RwtpcFqxDTceAouLeI=;
        b=jal55A3jzl6zti4Z0BvBqhELExNz32QWenKjobqhVolYb5d9EqZj9yemaHFPu/lMIt
         yqqAfOMFo6kypyJKJAYqU5H7hWhlkWJLha17sOUSUQePvsxzlHzTltAodtsHyAk/3OSJ
         M2br1e4y2ghKiWnvW3OAlEpMWOuGWz+WigMj2zAISoMTDFGAg3TAkZzK/u9UaV8hqsNs
         s1ExUF19/qjDQL/956RySMzFsJcdjidDZMEq+IBmqK0Tkn9FQF+0SUgipHaAdvmd69Gm
         oJSdvolOPxSOnYYrksi+Ww1lCca3K8r5ZMHb99iG710UUR5uqSo/f/5N6kVF09yz5WyC
         8enA==
X-Forwarded-Encrypted: i=1; AJvYcCXpcuwMei4nXStpti7VUKDaWt84N2ZZM0kvpNBQsQhq/VRSgC08tQ/rYE4c4dduaIbO1scgFVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OxQrrH5pn1fT+st0euFW5cZWaPcwqij+bkCP/bhrKQo9RKLv
	cpjPZtk7ghkoNvSImoRqsH2O3RM9SvFw2AgZgBrQrciogC9mwcICoWHRTysMJenkAgJcM/9am9V
	akw==
X-Google-Smtp-Source: AGHT+IFKXJS0bTD9sAyJPVLppjS47lHPBv7sxYQkk7QiOsZXc2s41dYksguslKU/Lc7XCT+O5Idg+IRXb7o=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:ad4:b0:a8a:8dc3:6160 with SMTP id
 a640c23a62f3a-a93b16711b5mr447966b.5.1727449972250; Fri, 27 Sep 2024 08:12:52
 -0700 (PDT)
Date: Fri, 27 Sep 2024 17:12:50 +0200
In-Reply-To: <20240904104824.1844082-18-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-18-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZvbLcsQVTs_RESx0@google.com>
Subject: Re: [RFC PATCH v3 17/19] samples/landlock: Replace atoi() with
 strtoull() in populate_ruleset_net()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"

On Wed, Sep 04, 2024 at 06:48:22PM +0800, Mikhail Ivanov wrote:
> Add str2num() helper and replace atoi() with it. atoi() does not provide
> overflow checks, checks of invalid characters in a string and it is
> recommended to use strtol-like functions (Cf. atoi() manpage).
> 
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>  samples/landlock/sandboxer.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index e8223c3e781a..d4dba9e4ce89 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -150,6 +150,26 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
>  	return ret;
>  }
>  
> +static int str2num(const char *numstr, unsigned long long *num_dst)
> +{
> +	char *endptr = NULL;
> +	int err = 1;
> +	unsigned long long num;
> +
> +	errno = 0;
> +	num = strtoull(numstr, &endptr, 0);
> +	if (errno != 0)
> +		goto out;
> +
> +	if (*endptr != '\0')
> +		goto out;
> +
> +	*num_dst = num;
> +	err = 0;
> +out:
> +	return err;
> +}

I believe if numstr is the empty string, str2num would return success and set
num_dst to 0, which looks unintentional to me.

Do we not have a better helper for this that we can link from here?

> +
>  static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  				const __u64 allowed_access)
>  {
> @@ -168,7 +188,12 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  
>  	env_port_name_next = env_port_name;
>  	while ((strport = strsep(&env_port_name_next, ENV_DELIMITER))) {
> -		net_port.port = atoi(strport);
> +		if (str2num(strport, &net_port.port)) {
> +			fprintf(stderr,
> +				"Failed to convert \"%s\" into a number\n",
> +				strport);
> +			goto out_free_name;
> +		}
>  		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>  				      &net_port, 0)) {
>  			fprintf(stderr,
> -- 
> 2.34.1
> 

