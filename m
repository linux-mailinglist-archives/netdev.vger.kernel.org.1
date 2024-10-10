Return-Path: <netdev+bounces-134053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C4997BBD
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A532839D2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377676EB7D;
	Thu, 10 Oct 2024 04:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrCpqQ+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6CB405F7
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728533988; cv=none; b=LAAMVEIoRP9LJA7vo0ZYkbF8m1kQ1ZQVqutv0plMpwD64K3jpAZsjOrRqQmx/vLpCfjQuAfyCmanztMT2DUijxqNHXepsjHsLEwYRBgOXsUPxMsb4lV75cuioCTnwgfsMtcLvQTn2JU9N/1DF2C/Mv2mG3W6mxZE46W9vvZ7yAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728533988; c=relaxed/simple;
	bh=g4FWWcs4nJP8NDvNmx4CvH3dCp0OgifI+LkBS3rO7kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJLCEBV+sw7oSN4xQvMxdGFBLWwLrPLy/CfMda8LspwIBLVxEDR0imibHmACeH1b+pAUFYP0LzBQu0iA9Zc/8ctQvcJkIDtsJVwBXhX8rEhkyED6E/6d6QnS04r83uVtZIIrbcQurEyq3IX80pKUil2ffM+mnzluUz8izCkNxyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrCpqQ+3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so423747a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 21:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728533986; x=1729138786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qdtx2n5Y1xpnOgomN/ZVHYd2i+wOXfBAFxlQfVAZXE=;
        b=RrCpqQ+3uOJ1WZcbm4/5CwOc80XnZHSz+4LxowDsy0P/1wAS8nvJ+QB6cB+r+/UWlV
         fviaVACy3/5+bPATAYBE1xHIeGnkoQ9Z/Om7mpBrWlEk6srVq7eI32xQIHfC8B3OoeVH
         tiWN8dUT6z4uEpT1VfmTljjxNcvibSp3Xnx49VUxlwtTVm9jdBNZg8H7JNw7BGr+h/gE
         h10e/EPeI5WzDjurBXQ6440DtL54Pjk6b0O/Njgeeb6lMH0QQnAbKmQMPUu2RPO7+2Xa
         76Jt2PwIcMPlOT8JFSXfgKx0sF6uEduuc8rgS791BjYMqusg7NQ4mP1izMPz3yo1uCC5
         RAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728533986; x=1729138786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qdtx2n5Y1xpnOgomN/ZVHYd2i+wOXfBAFxlQfVAZXE=;
        b=uUXewZEF2eZJDBHNF8k9xM3RK17zDuye2QuPKArJ+jp4w0FoLwOR5ZbCjoymsifZ2y
         qE+kCrwpqOBTsnFIaDygnAqevvz9Iubx+VW8ujm4IvJypbAOs+bJ7k9kznKF2KL0ZF4t
         +ndYZe6nGzjoaFkUeymuo1ksBJf9hpy/vHrABX3+TX1Oimyv5y69dt/vlRLYkRT5hhI1
         qEVXlSgrnX69i1q6KvqcP7V1CPi6wE2Kg5Z1erFczqTIC21TaNC/xykuoEb6MAmj9yq+
         KcJKjWXm9sWW32mxrn89RWfaeUQ42vZ4MS1MtF++6bSrsyXfjXgUWTEDzW4HSmnhhdw/
         DSIQ==
X-Gm-Message-State: AOJu0Yx3uX9TfSSV/kmEA+lppIiB5cLduqRyHAPfi8qZmIG35NkmrMDx
	Qs6x+DkY0x6CekZG3eb8eEiwGjcCqyNNO+/dSFqiij5pBVixAYI=
X-Google-Smtp-Source: AGHT+IFQx839W17wsnH8iBvcQqgxL1B8/nRfI7xsgWW9YTc4wP3k14QP3kg20En/36iXk7oga31jDA==
X-Received: by 2002:a05:6a20:929d:b0:1d7:5a8:379d with SMTP id adf61e73a8af0-1d8a3bff07bmr6365049637.15.1728533985937;
        Wed, 09 Oct 2024 21:19:45 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aaba5b7sm217872b3a.179.2024.10.09.21.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:19:45 -0700 (PDT)
Date: Wed, 9 Oct 2024 21:19:44 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next v3 10/12] selftests: ncdevmem: Run selftest when
 none of the -s or -c has been provided
Message-ID: <ZwdV4OOI27nEVyqU@mini-arch>
References: <20241009171252.2328284-1-sdf@fomichev.me>
 <20241009171252.2328284-11-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009171252.2328284-11-sdf@fomichev.me>

On 10/09, Stanislav Fomichev wrote:
> This will be used as a 'probe' mode in the selftest to check whether
> the device supports the devmem or not. Use hard-coded queue layout
> (two last queues) and prevent user from passing custom -q and/or -t.
> 
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> index 90aacfb3433f..3a456c058241 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -64,7 +64,7 @@ static char *client_ip;
>  static char *port;
>  static size_t do_validation;
>  static int start_queue = -1;
> -static int num_queues = 1;
> +static int num_queues = -1;
>  static char *ifname;
>  static unsigned int ifindex;
>  static unsigned int dmabuf_id;
> @@ -706,19 +706,31 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if (!server_ip)
> -		error(1, 0, "Missing -s argument\n");
> -
> -	if (!port)
> -		error(1, 0, "Missing -p argument\n");
> -
>  	if (!ifname)
>  		error(1, 0, "Missing -f argument\n");
>  
>  	ifindex = if_nametoindex(ifname);
>  
> -	if (start_queue < 0) {
> -		start_queue = rxq_num(ifindex) - 1;
> +	if (!server_ip && !client_ip) {
> +		if (start_queue < 0 && num_queues < 0) {
> +			num_queues = rxq_num(ifindex);
> +			if (num_queues < 0)
> +				error(1, 0, "couldn't detect number of queues\n");
> +			/* make sure can bind to multiple queues */

[..]

> +			start_queues = num_queues / 2;

Should have been start_queue, not start_queues. Not sure how I missed
that. Also means I haven't run this for real..

