Return-Path: <netdev+bounces-130509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59C98AB53
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB9B23EF2
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4BC198E96;
	Mon, 30 Sep 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LaTdSSNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A79198842
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718331; cv=none; b=RK6BAdV1Q+hMoTnUlsgdcLkBkJhSdF/ZNEGtsPhWiPCMbvgwiN7Sn4HA8aq3X2OolSKxbdHVAqfO62QWwR4PgHyfprLCF6aHg60t3wLxGNuXSAE9f5zsnJifF8NF5ENmA1b0vujajPfkvt4OFYHybq30UP4/Da0YyRGQ4q3eO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718331; c=relaxed/simple;
	bh=9Mg0+hxIuuJ44LsUxFpr5Z7P1UDH5ddfSfqotyQzlec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ru9HmsTP9v6DNROoxepi7c+zijMWl1/jZzU1zq4cK5EYhFBHWttw1vveyekoXChMv4nK7Nl7QvINwoRoXNDy+qfKKlQPnn+WAxZ6+RewISMqXPHCthr9l/Ovw0MtOyPODHmaVi4KaqkSG5WUT1kruDW9pu+btL4zADSCJGe4mWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LaTdSSNi; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82cdada0f21so169398239f.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727718329; x=1728323129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifVI+W+o/WaIn5pLyJflHc9b7OfCRgFL6hh+OGWk1dA=;
        b=LaTdSSNiYoVDLWfRVPxNlbD3G86F6YkCUAs3MOtn3soLGOm/lKq5zcldc6fwDl9dxm
         nnoIpeB2FFNQkjXT3YhFGCmJr41ktOn/MMv+NpXHKKHomOE1MfyGzMCzmP2+S7YtQ5Zw
         p4xD+9d7SGaUwSepV0uWQktTHdxi/uFkil9+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718329; x=1728323129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifVI+W+o/WaIn5pLyJflHc9b7OfCRgFL6hh+OGWk1dA=;
        b=EsaCk/MdUcB7pPqtoPkkJ4wCYo6UD600zF4PNMpbswK5SqsC54wgRkInJ8j8J5WALK
         bTdH6XFsdhiYBNDLABkIN96EG3FNzI/s/E4ghVaL/40jeo1HeB7m94o4RyALhfSUPSBg
         A+aM51csecPWC5fZzESp6gLCKZE4ZSqeg8ZwHi8P4/9quDZVk69X19ZQD5rTHlSuA1VH
         JZJD1X4fF97q7TFwAi1VKy3OKtAjApaZcMBAwj5ZQkFB7ILz7jqcAuKGEjMHC1Ubl/HU
         Pm/5wRgg2xXGgiRhbiN6Bf6PYkBj1Yw0x5blZ+Z2FCXv1QcoVvrHkrQgz7MjCyt3Ol8q
         qJZg==
X-Forwarded-Encrypted: i=1; AJvYcCVVBETxcRIHhnr3TVCcXyMcjV/9BG0bhg9ggQiK6EnKkH0JWfO1ENuJ+iW3OZG5J0pjollPRgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQC4sWOJ3ofP3ZlUjxq50DKss2LscfZKu62/1v9LH0YUA8cRiQ
	02nK+MM2UBx+JIxVynd4HaXqhZyvmlg6CPoWFK8EjOlAU9/qZZYvifLNRTsKgqo=
X-Google-Smtp-Source: AGHT+IE21h9OongXKzYRZbaL1iMKJngLPKHQNxt9/ihJQQ9SqklOtQkcIoDshYUV+O6b4iQX04tgGQ==
X-Received: by 2002:a05:6602:1605:b0:82a:a949:11e7 with SMTP id ca18e2360f4ac-834931e219bmr1039774339f.7.1727718328839;
        Mon, 30 Sep 2024 10:45:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d88883509dsm2223076173.16.2024.09.30.10.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:45:28 -0700 (PDT)
Message-ID: <3079947f-0228-4c3f-b245-549e1eba8aae@linuxfoundation.org>
Date: Mon, 30 Sep 2024 11:45:27 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] selftests: exec: update gitignore for load_address
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
 <20240925-selftests-gitignore-v3-5-9db896474170@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240925-selftests-gitignore-v3-5-9db896474170@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 15:55, Javier Carrasco wrote:
> The name of the "load_address" objects has been modified, but the
> corresponding entry in the gitignore file must be updated.
> 
> Update the load_address entry in the gitignore file to account for
> the new names, adding an exception to keep on tracking load_address.c.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   tools/testing/selftests/exec/.gitignore | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
> index 90c238ba6a4b..a0dc5d4bf733 100644
> --- a/tools/testing/selftests/exec/.gitignore
> +++ b/tools/testing/selftests/exec/.gitignore
> @@ -9,7 +9,8 @@ execveat.ephemeral
>   execveat.denatured
>   non-regular
>   null-argv
> -/load_address_*
> +/load_address.*
> +!load_address.c
>   /recursion-depth
>   xxxxxxxx*
>   pipe
> 

Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah

