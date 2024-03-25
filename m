Return-Path: <netdev+bounces-81627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BFC88A879
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C751F66D2E
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151C13D8B7;
	Mon, 25 Mar 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="own2Vihg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448013D624
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375166; cv=none; b=Vy5ylgfue1Vw2+8LAzToYqKqSfDjJqwrgEkiib3lnKUCsTb7wDyMEVs3sdptmaCUYpIjKSGuV9OdudhHac7L1krtG/izki/xm4sX6ENTBQTxw95mGKx5NcGWOKhCJv6IYd694PeLz2B6jMj4iD966mkLnT9o8oORgfCH+tGxmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375166; c=relaxed/simple;
	bh=aiMUPmr0TYR+OTuWbEB0NdvrDsA6Hxrr0DZTK4iOQcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAHqYSmnnRudrTit17Vh7GG3GOaH+SCBQTSJ9RJmml3yn5qgqSHXdp59CErvEjew2x1KmJoT9YZm1kPxuHcoNKksg1xHwXU9wNcm6oLcVmfK5E0TtrjCBPRWCqW01G+GoJwTwlkFJzbmQ61DhGuf1QMbEItj6vZZX5CPMhnI/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=own2Vihg; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so15892a12.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711375163; x=1711979963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiMUPmr0TYR+OTuWbEB0NdvrDsA6Hxrr0DZTK4iOQcE=;
        b=own2VihgvevU9YRCiKVFXirQxnmo8wM2siZ5eSbqmQPWPzIs3Osl1KtBc+bYtB46U9
         o6bTZrWt3Wu8zEx7A02JB2o4iSjknT7Iwwrz4vhTuYpTx6MNZulo5zephBWPcLtI/1JO
         6uKzNKR2f06SrYKAZc+40kibTuBgCqAFjMi6v267inrTTMf06cGlTpxbh+Pyf7b0+sPC
         ab3zffwKi4/+i1Q7JpaxB+RdrpEU8/sgqaZHAnrR6/fw2QOr5OSygwBJua1Mwbdi44Rm
         2sCosPAC0je3Auu4/GWuxiJ59nGD0e8+mn8vDkk+M5QNGGCAfxF7Kcopjz58v6sQpOEZ
         g9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375163; x=1711979963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiMUPmr0TYR+OTuWbEB0NdvrDsA6Hxrr0DZTK4iOQcE=;
        b=o3/ca6dq0V/W++XLq11f8Qa2zCwy2/wmDowzto6Rm9pjMeGkzk8OVsp9piERKvv3yC
         t06UNv6XetpyAtlJ7zwunukzgLt5I9d4EQKnkXTuK4qRYj/v6r2D8PdkHZSsNs0gHdrM
         Vqy8h9KriEu54ehQLib3X6y8ZvAtauS6WqKYlSvB+zU87QKqnkPIUK0uidOXRgS5k9yl
         rq+sQsQP5aUfdBb2KgUoaxlo44L0reyANsQpNqPmHDWPfahMBQ7fEgXuRJXCAjlH3UgN
         3Ud3tDGpe2wPzLVpGgYNFpUDeSFapi96wmuDO2YEM+4O1T7IFBhLiaLnPBzEhm7iM9YG
         e51g==
X-Forwarded-Encrypted: i=1; AJvYcCVcWY5UDLs97mJQ46o35ZzxSEmem1gOQ+nOUL4wf4Ix1yl/9PYpmvJu2TNbkLgoKGPTmyz84eH7D9GoPhjiVRfOZZATxRPk
X-Gm-Message-State: AOJu0Yw6so+BC18IBJZdU1qHkPyd7uGxS1ZUVwlAyyoB7KrcNls4ZbUU
	4bLUONEQy6I0lxdO5zK3j2kPMf+QDJ1STYKTw+qWrjgkDCJIL2clm0yVJEArevF9fMx71cEbQnh
	ClgYrxP7ayN38KSQcPds+YgSd1jFTss0pl4Zt
X-Google-Smtp-Source: AGHT+IEV5wDD3dHJtuQglxOC11Br3likX/HODpqsYK/HFkeJhAxfTM6CLt/xt+yEevunobYcapuEhcWHhd7Md8ZPxBU=
X-Received: by 2002:aa7:d298:0:b0:56c:d26:5e59 with SMTP id
 w24-20020aa7d298000000b0056c0d265e59mr130158edq.1.1711375162985; Mon, 25 Mar
 2024 06:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5A50BC27A519EBD14E1B0A8685E89405850A@qq.com>
In-Reply-To: <tencent_5A50BC27A519EBD14E1B0A8685E89405850A@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Mar 2024 14:59:09 +0100
Message-ID: <CANn89i+gqBKX-BkY58M0vWfRLsOy2RqyFqX8cwjqo3xacYGXbA@mail.gmail.com>
Subject: Re: [PATCH v2] net: mark racy access on sk->sk_rcvbuf
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, Breno Leitao <leitao@debian.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 9:44=E2=80=AFAM linke li <lilinke99@qq.com> wrote:
>
> sk->sk_rcvbuf in __sock_queue_rcv_skb() and __sk_receive_skb() can be
> changed by other threads. Mark this as benign using READ_ONCE().
>
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.
>
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
> v1 -> v2: include sk->sk_rcvbuf in __sock_queue_rcv_skb()

Reviewed-by: Eric Dumazet <edumazet@google.com>

