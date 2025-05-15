Return-Path: <netdev+bounces-190827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3ACAB8FF9
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 21:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243433A1990
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA191F8F04;
	Thu, 15 May 2025 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CupUIatL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE41E9B1C
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747337246; cv=none; b=mdEiSwsHeKB5utKSVX3NwPxp0Gg5I7esx/ml4ReDadsz5i28norIuayOZuoBnhuXDQa22H3cr4MoXOkR4mcpnJqgwBLUN1fVb2UCfoyNBcCPTyZWxWvAVQIQKP/6TBZfQxZsV8g/tYnTr36JqWJjxOb625FQJ+Z4pAQfDFWhNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747337246; c=relaxed/simple;
	bh=mV0ClfbUxINVtAqpY2jkgwsGRqLig2HBjYjSg5lJlPM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZFguXKg5j9Cq69Mr/2SelKxlw2yKbZLbyoKDk6GCDonPVJoYJHeUtEo3In0v9gTfi7whKUITOdHSy1NTzuezqkrWpQCv0ZNE0yZyeMO186etRaFsvFffIMcFZNvffbQQXxvH4+LidmQDuIVNLxczpoxaL4rMRf4m9+Y2xmdGBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CupUIatL; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso12730076d6.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747337244; x=1747942044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5g8YtKQGLqG2aixZEfQzfDiggtPuM5vJ31ON1qYMCY=;
        b=CupUIatLsEcCTvnlhpzK1OIZ/z7lXMTNByeGxrn+mBRqEAgTZB3X/+X9aqo0fSmEGr
         VsRkRGUu+YBpFfQ4ctlxZcd5cV3InRL8NtdipyP+EUcAB/TVRiIGVAABe/J7Nav+rtVo
         vK/CLAdWEmelg6i171wEUZnw96qJ2i4r5Cay7fKe6e4sLY1GI0CvehcOwVfevyo23ZID
         ufe1RQguTXnL9AqY+QUwPl8VOUMQOLVuQAj5BUCA5XD7buT1jGIPjP8yEz5q2iuy5av3
         848VWcAE+P7JiH1DH2RLbmXmY3AjpbP4/YWF4SUoaOiuZxAs0sRDhe0pqI+6aoTHO7+h
         0Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747337244; x=1747942044;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w5g8YtKQGLqG2aixZEfQzfDiggtPuM5vJ31ON1qYMCY=;
        b=f4+LQ5jpUa/8N0PPTbSryjHD21y+ms7/g5+jQvR3qohH4YbdXp1R8AmO6XnCAjmNPB
         R5BuR3yTZNgQ1jd5YqK7O5Ea4IUKrL8uhihL6VAWbU3+giF06Vidrdsx8U5ciHlVuhBp
         yOXZ+5GFPU38MjmIUogbTz6ppu4qfd88SgyXTA774j3OTV764f4J8pu4oEdlLUTTweML
         +YbTA8/2DxOxFYW561U6Hf2xYoT2OMcroBRQJgpDxDbuX6+cvPh8a51ezhPo2EXeu6aq
         2yr0XIdeH4zafffLus2Nh7Zi8VKdX2KYs7Np/9/Wk9cyOXnggpzBnyxRWgmsxOcR+nZd
         EYjw==
X-Forwarded-Encrypted: i=1; AJvYcCXxxhDTSC//gE06hgpdoKvey+bS4j/XrrNnRjzAZORLLdS2+r1X3aj2ObTOUnVuj5YBFKL1uC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpsJVeKMbZgIYGh7Sti9ViGmXQomp//XMgFCMSKyDIl4/wFRE
	56gboUr8ULzUC1Ihy9JTiul88i4Y2HoJ0OtGE5LdQs/7NldqcAy2lsrd
X-Gm-Gg: ASbGncsV73d0dKrJN4TEJz5ykTQD0dIveHRv8+yrKHS/fNmSDPvjYBKnU9Um04akLLX
	IPJ9/YT4pWHNupHIBf3b+O6bh8LjMfCswqJ5B0z80n0LB6jDwfOlz9c366j8RCTZQ7J5m6oFLxE
	R+cUe1HIg/kMJuFEBBQjqzU9JfGrlUCZmpUfikv6r1DpJc6d9PkGO04Bhla69+5a0TkSi3vrs5t
	QeYtj2/DE+EIrhMyZy9WrSuYw2qgHQ01plRZ8Hhm/HwdJTo8pm4aKbauGPAbWX5+MCcUKcOe4Lt
	HYAjeiY/u962fDCZ0Oa5bomCR/3QIzwh6bJ2rsKaxbasTg139v5HlqFaLjjnhv0T0JV6fBE5e4v
	ILXT1Uhk+7dKc8otkTdJFqLU=
X-Google-Smtp-Source: AGHT+IEDuubLqykI1qG5INMNFN8OGkD6uVZt4M0i3+JO/oBOetDGZ5khAfD8f+q7jAr1gfz5RJbsiA==
X-Received: by 2002:a05:6214:2a83:b0:6e6:9ce0:da9d with SMTP id 6a1803df08f44-6f8b08d5181mr15843506d6.27.1747337243538;
        Thu, 15 May 2025 12:27:23 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b097c30esm2887006d6.105.2025.05.15.12.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:27:23 -0700 (PDT)
Date: Thu, 15 May 2025 15:27:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <6826401ac346c_25ebe5294c3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250514165226.40410-10-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
 <20250514165226.40410-10-kuniyu@amazon.com>
Subject: Re: [PATCH v3 net-next 9/9] selftest: af_unix: Test SO_PASSRIGHTS.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> scm_rights.c has various patterns of tests to exercise GC.
> 
> Let's add cases where SO_PASSRIGHTS is disabled.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  .../selftests/net/af_unix/scm_rights.c        | 84 ++++++++++++++++++-
>  1 file changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
> index d66336256580..7589f690fe2f 100644
> --- a/tools/testing/selftests/net/af_unix/scm_rights.c
> +++ b/tools/testing/selftests/net/af_unix/scm_rights.c
> @@ -23,6 +23,7 @@ FIXTURE_VARIANT(scm_rights)
>  	int type;
>  	int flags;
>  	bool test_listener;
> +	bool disabled;
>  };
>  
>  FIXTURE_VARIANT_ADD(scm_rights, dgram)
> @@ -31,6 +32,16 @@ FIXTURE_VARIANT_ADD(scm_rights, dgram)
>  	.type = SOCK_DGRAM,
>  	.flags = 0,
>  	.test_listener = false,
> +	.disabled = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(scm_rights, dgram_disabled)
> +{
> +	.name = "UNIX ",
> +	.type = SOCK_DGRAM,
> +	.flags = 0,
> +	.test_listener = false,
> +	.disabled = true,
>  };
>  
>  FIXTURE_VARIANT_ADD(scm_rights, stream)
> @@ -39,6 +50,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream)
>  	.type = SOCK_STREAM,
>  	.flags = 0,
>  	.test_listener = false,
> +	.disabled = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(scm_rights, stream_disabled)
> +{
> +	.name = "UNIX-STREAM ",
> +	.type = SOCK_STREAM,
> +	.flags = 0,
> +	.test_listener = false,
> +	.disabled = true,
>  };
>  
>  FIXTURE_VARIANT_ADD(scm_rights, stream_oob)
> @@ -47,6 +68,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream_oob)
>  	.type = SOCK_STREAM,
>  	.flags = MSG_OOB,
>  	.test_listener = false,
> +	.disabled = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(scm_rights, stream_oob_disabled)
> +{
> +	.name = "UNIX-STREAM ",
> +	.type = SOCK_STREAM,
> +	.flags = MSG_OOB,
> +	.test_listener = false,
> +	.disabled = true,
>  };
>  
>  FIXTURE_VARIANT_ADD(scm_rights, stream_listener)
> @@ -55,6 +86,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream_listener)
>  	.type = SOCK_STREAM,
>  	.flags = 0,
>  	.test_listener = true,
> +	.disabled = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(scm_rights, stream_listener_disabled)
> +{
> +	.name = "UNIX-STREAM ",
> +	.type = SOCK_STREAM,
> +	.flags = 0,
> +	.test_listener = true,
> +	.disabled = true,
>  };
>  
>  FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob)
> @@ -63,6 +104,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob)
>  	.type = SOCK_STREAM,
>  	.flags = MSG_OOB,
>  	.test_listener = true,
> +	.disabled = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob_disabled)
> +{
> +	.name = "UNIX-STREAM ",
> +	.type = SOCK_STREAM,
> +	.flags = MSG_OOB,
> +	.test_listener = true,
> +	.disabled = true,
>  };
>  
>  static int count_sockets(struct __test_metadata *_metadata,
> @@ -105,6 +156,9 @@ FIXTURE_SETUP(scm_rights)
>  	ret = unshare(CLONE_NEWNET);
>  	ASSERT_EQ(0, ret);
>  
> +	if (variant->disabled)
> +		return;
> +
>  	ret = count_sockets(_metadata, variant);
>  	ASSERT_EQ(0, ret);
>  }
> @@ -113,6 +167,9 @@ FIXTURE_TEARDOWN(scm_rights)
>  {
>  	int ret;
>  
> +	if (variant->disabled)
> +		return;
> +
>  	sleep(1);
>  
>  	ret = count_sockets(_metadata, variant);
> @@ -121,6 +178,7 @@ FIXTURE_TEARDOWN(scm_rights)
>  
>  static void create_listeners(struct __test_metadata *_metadata,
>  			     FIXTURE_DATA(scm_rights) *self,
> +			     const FIXTURE_VARIANT(scm_rights) *variant,
>  			     int n)
>  {
>  	struct sockaddr_un addr = {
> @@ -140,6 +198,12 @@ static void create_listeners(struct __test_metadata *_metadata,
>  		ret = listen(self->fd[i], -1);
>  		ASSERT_EQ(0, ret);
>  
> +		if (variant->disabled) {
> +			ret = setsockopt(self->fd[i], SOL_SOCKET, SO_PASSRIGHTS,
> +					 &(int){0}, sizeof(int));
> +			ASSERT_EQ(0, ret);
> +		}
> +
>  		addrlen = sizeof(addr);
>  		ret = getsockname(self->fd[i], (struct sockaddr *)&addr, &addrlen);
>  		ASSERT_EQ(0, ret);
> @@ -164,6 +228,12 @@ static void create_socketpairs(struct __test_metadata *_metadata,
>  	for (i = 0; i < n * 2; i += 2) {
>  		ret = socketpair(AF_UNIX, variant->type, 0, self->fd + i);
>  		ASSERT_EQ(0, ret);
> +
> +		if (variant->disabled) {
> +			ret = setsockopt(self->fd[i], SOL_SOCKET, SO_PASSRIGHTS,
> +					 &(int){0}, sizeof(int));
> +			ASSERT_EQ(0, ret);
> +		}
>  	}
>  }
>  
> @@ -175,7 +245,7 @@ static void __create_sockets(struct __test_metadata *_metadata,
>  	ASSERT_LE(n * 2, sizeof(self->fd) / sizeof(self->fd[0]));
>  
>  	if (variant->test_listener)
> -		create_listeners(_metadata, self, n);
> +		create_listeners(_metadata, self, variant, n);
>  	else
>  		create_socketpairs(_metadata, self, variant, n);
>  }
> @@ -227,10 +297,18 @@ void __send_fd(struct __test_metadata *_metadata,
>  		.msg_control = &cmsg,
>  		.msg_controllen = CMSG_SPACE(sizeof(cmsg.fd)),
>  	};
> -	int ret;
> +	int ret, saved_errno;
>  
> +	errno = 0;
>  	ret = sendmsg(self->fd[receiver * 2 + 1], &msg, variant->flags);
> -	ASSERT_EQ(MSGLEN, ret);
> +	saved_errno = errno;
> +
> +	if (variant->disabled) {
> +		ASSERT_EQ(-1, ret);
> +		ASSERT_EQ(-EPERM, -saved_errno);
> +	} else {
> +		ASSERT_EQ(MSGLEN, ret);
> +	}

Why is this errno complexity needed?

It should never be needed to manually reset errno.

Is the saved_errno there because ASSERT_EQ on ret could call a libc
function that resets errno?

>  }
>  
>  #define create_sockets(n)					\
> -- 
> 2.49.0
> 



