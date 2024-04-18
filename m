Return-Path: <netdev+bounces-89370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8FF8AA247
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256C61C208DE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13D17AD64;
	Thu, 18 Apr 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1EWz8Kl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2617AD67
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466103; cv=none; b=U+XEn+aAhLpB5VPDFfcmqRoqUJhx8vtemS3jyipCFVt0u5YyYDs5JRQ9cvGW/DlscBy7MbpnBl9IscASL+6IybMIlVz4/51B3NyUEyZoC2F8kArClXX242npajftQefhTqpX/3ydMBT5uPGQT+z/odjcmTZuiHKecyuI9qGHQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466103; c=relaxed/simple;
	bh=XBzE4LuWccTnTw0r9CwnNxtwEK7las0u5c0J1TpM5mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9s1tfosTmrzBhHJYH2iyTlyvAg1sVljX3X+/WJeSkuaCChjGbmrADlgzFjK5hb3Y3WDFYzfnkbdvwgCQPW2DZqgbhrAr7KY6WmqUSMHxWJmDamdY1wGxttUqNimgCq0YrRirmkE4EW/cDsSlaftWuGcIHba5FmReMTTxvHjACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1EWz8Kl; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78f03917484so72331785a.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713466101; x=1714070901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGqXvxMT176mzoL51bvY92OUP3ZIq2PqZ3NYN+MASaQ=;
        b=K1EWz8Kl/JClioWHF9t2Sj8CxySXe8WVkLYcjtsj3t5+jQDO0AIIvxNt5mCUccrA2J
         iAo+lE8sG82c+//xnJr2tilDshuZGveUbahdnoE6nwJKTYCE7drZxtD0/gCdU4OIS+Vj
         9sktiJMYiaq1CvMs8V4VKUfRwP8HlUYNSDqwWbZLhbkGUN0+4Qmikpb7Eb13d2tHm1iv
         vSt5ehNCigdLoQOmksySyj79yfHKgLl+hCcyw8WBuyLV/d2E9Lg+ArpTcOUvDSvOjRIw
         i8l4y9YJikZJUmQ27dOuR8RsbwOjqkmBKzHrVq2i8YwpjRAupFxtcexq56Gv/0KUJoyz
         sggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713466101; x=1714070901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGqXvxMT176mzoL51bvY92OUP3ZIq2PqZ3NYN+MASaQ=;
        b=KGp9x8tl9g6GvnIOUjdi4I8XLWZi5AK7+6IHdGKDSEQpaih+cIimmpLp3Q/0lKoE5u
         Kwa5yiLKwPp9vAi/mdf7zao8Mavid/mVxI4Nj/sAMoGCU4bcKptWmr2JG5+/PgpQvxFb
         bjCKZfNvYxk/v5+J5uSnXw09MWyx9vQleSf5KDVR4/bYMC4HgVMdJ6VP6TGwt1LcEUtG
         2Ubu3bybzu4UUODLd2z0eRmVJsx7181JGDsTIRY1Zkalqm9dOe61OX0zVvYdAupVb5PI
         /Dse4MEyzn5imLIvUg6i0xF3tJ2ZA0SgOFMDpCxE5i6YGTFT+9/joKW5cdEAq+ZXcIL+
         9bJQ==
X-Gm-Message-State: AOJu0YwDlWr8Qsbd/uHNc0w0Aa8/K0Eo79tvkZh/nMGGBGp1IrNh49QM
	Wgycbl1awGxSR3n8xRSXD7jBYTWXrva+ZdB0/L2aOhM4CzjSqSOD
X-Google-Smtp-Source: AGHT+IH8Rc/y4Ihr2A346pTfATwDYMHDYG0p+qLnc9wkbwEVdKnVQuewL9jhIZiURjOP/SLnA9ri+w==
X-Received: by 2002:a05:620a:40cc:b0:78d:36e0:2b5b with SMTP id g12-20020a05620a40cc00b0078d36e02b5bmr4335137qko.68.1713466101519;
        Thu, 18 Apr 2024 11:48:21 -0700 (PDT)
Received: from localhost (24-122-67-147.resi.cgocable.ca. [24.122.67.147])
        by smtp.gmail.com with ESMTPSA id o20-20020a05620a22d400b0078d61f145desm881261qki.13.2024.04.18.11.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:48:21 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:48:20 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	shuah@kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	vladimir.oltean@nxp.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v4 2/6] selftests: forwarding: move initial root
 check to the beginning
Message-ID: <ZiFq9EmbGZ3psdho@f4>
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240418160830.3751846-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418160830.3751846-3-jiri@resnulli.us>

On 2024-04-18 18:08 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This check can be done at the very beginning of the script.
> As the follow up patch needs to add early code that needs to be executed
> after the check, move it.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v3->v4:
> - removed NUM_NETIFS mode, rephrased the patch subject and description
>   accordingly
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 7913c6ee418d..b63a5866ce97 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -84,6 +84,11 @@ declare -A NETIFS=(
>  # e.g. a low-power board.
>  : "${KSFT_MACHINE_SLOW:=no}"
>  
> +if [[ "$(id -u)" -ne 0 ]]; then
> +	echo "SKIP: need root privileges"
> +	exit $ksft_skip
> +fi
> +

There's a small problem here. ksft_skip is defined in net/lib.sh which
hasn't yet been imported at this point.

Also, on my system at least, the code in the next patch can run
successfully as an unprivileged user. So what is this patch needed for
exactly?

