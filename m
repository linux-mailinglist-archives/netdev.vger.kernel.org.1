Return-Path: <netdev+bounces-231780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3107BFD62C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B18085651D1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6040E35970A;
	Wed, 22 Oct 2025 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9ZYNqHi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7349359708
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150393; cv=none; b=XbE9BFBOuRhtK+QMyraVdI3PgJyAUPLfP7tgagI+0HuXF50m5+DHJzZPV9jQlqoyNnFpoQ152yXZJP6QsvU8vtrQWM7tUf2wdHHb8ysy0lSE6zoVVYgKOu46aHmBLW4vXEwaTu7l9l9/5oHSKvYcqoJsMYZF8K8qCio0+i0Rsv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150393; c=relaxed/simple;
	bh=iwlMtyfC2xPKxk8S4p6z41sGve762X8rQc4zMjYt0j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqiXKxGQ8mVUEZX2w0Fsf4zbZy5QV5QlehFNLwV1/aek+N4fX9Q8s1Wau5QV9txl6nQQlea4b7Mwla9bTvIU/pPrLafj3a95ZTutItJbAG6+YO00FV1uMechKgO4TSFwd9d6eiel3dMkjCaYpqblowV7oCQWKiFnR5J3JF1Ruxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9ZYNqHi; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-79599d65f75so81215616d6.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761150391; x=1761755191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwlMtyfC2xPKxk8S4p6z41sGve762X8rQc4zMjYt0j4=;
        b=d9ZYNqHi0DdfAIPClvyc5Tk7CKtJf+94kEJFQmcNve8UgS8bruDicpT2IgYUP46aqU
         i3URMlLkxCDzpcBH1nbColTOyoa0qJBdSXRd+DdFmHAxjpjLjWY9C40Dch8kWXxMP0EQ
         gNI1+wpRUnhwn/6ePoe8deVxR2PvPgsV01H+Bs0bsi3GtJ1e4meZDnRncc0kqMnV0QeO
         Bn712c9I69JFj3/expaySei/OWFXuf32InLW0r/Q+MhiCQrTw5phSeGT/OPGNbMumhjs
         9LCfWuzvzaF9Cb3VXIcfvFQFOCBCVWaqFgbT2rGXWbn7GYMX9jtDDX47rPSH5U9LsXWu
         JhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150391; x=1761755191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwlMtyfC2xPKxk8S4p6z41sGve762X8rQc4zMjYt0j4=;
        b=HEyibhR6mV7tbfhke714VOQaWd/km2CvTaPBAYEYbuT9qTJdbfB1lhnMJ4gE1REbc7
         CZRuyFq9GRjEMHABFfc6IlNUdrUU00J5SPHa0aHxCMF4/sVruCmUmwlt1YWaLSHMMfsG
         bdbc5BW7WJ/Hzca37mOXXpak7Pcedo89ZxBdJWjWnCsKWpMxKMw2nB2ueEwl1rnUWKQn
         21ZowQAjJ5UxxqNjXy285Vz94uaZLcX74JZT+zVJ9CTXhvTgIy7zyWTS32Ps9iHdjHhE
         VYKcS//UlZmj3Td+9kWtWcDbbiGKoKqC0LvFhYA+cI/GWICgguorX+cFFBqiVbnGmDhC
         4L6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhkXXovZzq5qZvwyO8uQXzrIzBkm2c4VvKk5WRz/A08H1aGNn+UUggMiithao39JbrZup9w+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+MkwZDvPmsdOUf8UbOVb8tOlf6OE+RPUPLO3WPdkqbiyhSen
	rdom/FOPQBSTFFbtK6tojNu/fS3G4ISzLOxpSAyavgccHUicRLf708K4
X-Gm-Gg: ASbGncurQTwrvk1ojExg8mVQOwU4RKsgZSjwAkxe8ddXjGzJJArGJ+u7b56Zjru4GIc
	RD5plKdXNnmqd0nnm4CG7KwGkwyRkyZCrZ8jzADyK7RwZrk7jipF4Nj8a2HTSUJ9kUh9Pm/W1k1
	3/D+xfB5cp6ZeVLFhTCOpiib4fGiFqith3E3rRw3G+taTVDhv4w53R3dZ9Z04V+BvF/szjGcieE
	lUvG0xY60JclV9snW6e9v1Yg1FDlOo3SiV0APihu02sJB30ATutCyhfqCHBIz3xd+nJY9La5+WU
	sTU//Wcww+8mQOpgL4I5rwRSIDNy+9T9TqVxs5IRuAK1mItMIfUzUKSyrTQ2bnQaYbs5upRGw0b
	7xnHeb6sXlEgg1OKnzTnOulyIIy9DmJazbL7mJPYSPWb5CZFSSMkeKG4JrTW3zdRwJUIhKXDRA3
	B5OsBffa/jK5VRzwIr2/zFW9SwauL8rWCmmY7ROExj5TQ=
X-Google-Smtp-Source: AGHT+IEyDB0xk7fNnhWSdCfidUD+oD/xiM7h6K1VQwfUJ/QYWZX/S+LivYs8WeurDoVm2yRYzvWvMw==
X-Received: by 2002:a05:6214:19ed:b0:87d:ca03:fdab with SMTP id 6a1803df08f44-87dca03fff2mr185779966d6.49.1761150390634;
        Wed, 22 Oct 2025 09:26:30 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:fca4:2cf5:8006:30f8? ([2620:10d:c091:500::4:1180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf5235863sm89173976d6.29.2025.10.22.09.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:26:30 -0700 (PDT)
Message-ID: <0900b8bc-3251-40a7-9e6f-0b4275828fff@gmail.com>
Date: Wed, 22 Oct 2025 12:26:29 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 net-next 02/11] net/mlx5: Implement cqe_compress_type
 via devlink params
To: Dragos Tatulea <dtatulea@nvidia.com>,
 Tariq Toukan <ttoukan.linux@gmail.com>, Saeed Mahameed <saeed@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
References: <20250907012953.301746-1-saeed@kernel.org>
 <20250907012953.301746-3-saeed@kernel.org>
 <ec51df17-260e-4ec9-a44a-9f0c3d3a2766@gmail.com>
 <d4ee68d6-7f57-4b24-970f-41a944a22481@gmail.com>
 <4dde7c9e-92ac-43b4-b5c8-a60c92849878@gmail.com>
 <efj4hbhm5ek2vtvu6ssohprswedljy3d527myi3vgc6mhvntau@w6t4ewo7zuiy>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <efj4hbhm5ek2vtvu6ssohprswedljy3d527myi3vgc6mhvntau@w6t4ewo7zuiy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/22/25 9:42 AM, Dragos Tatulea wrote:
> Thanks for the report Daniel. It seems that this was a bug in the FW
> which was fixed. I was able to reproduce the issue on the above
> mentioned version but not on a newer one.
>
> Could you update the FW and check it on your end as well?
>
> Thanks,
> Dragos

Thanks for looking into it, Dragos. I upgraded my FW and it works ok now.

Daniel

