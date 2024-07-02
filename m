Return-Path: <netdev+bounces-108544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B392421C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CD71F25BF8
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FED1BB6AE;
	Tue,  2 Jul 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDhYFsJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD51BA868
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933373; cv=none; b=YdyQg8Z8qdmVg4Ku6U0yOluUd0vZwRkDp2DyjGeTUmvN2OPRsPisE86vfYZwcp38GKoB8xTAjMneAyI3r5sLWk5XXoaLabrrbkqDNS/+Zyix9lE4KAn1KVJnHpcMlWR6+6CzfpXC4Bkn3uB1PSCib4zPOaTyfzosO0jLhFfkWsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933373; c=relaxed/simple;
	bh=PFuSodRLNrK58rHG08Ugt6OOXdx1ce25g0GNHzycwgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atwv6ccpHHvQ3/fv7+WV9Cbo4JVQ81LCwYVIApxVYwyl2Wi75J263EkVEHxlx1aIdMeRNyOpsgRc6KyWPPTxWi7Fv5OTa0C+1xS0rcwG9T8BA8JFbjX0+pl2MAXGbSKHZKtLhZK3aKWmpwNCrzen+LzJrrWOhEoVp6AqJK8E9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDhYFsJ+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ce08616a9so8631e87.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719933370; x=1720538170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFuSodRLNrK58rHG08Ugt6OOXdx1ce25g0GNHzycwgM=;
        b=ZDhYFsJ+jogtX4Ayq0BKYSLk+yp7ukS8R15IIZOMv0thsWe0AhTeMj60pk4ftidHWp
         5bQVl9nEBx6GswDwe760AJM3qiv/hQqoDWsO9/mtPi3VLiIq4NrzhFwtTQMDxtw0f0cC
         TTsdgd9d9ZLt2yMhXe18b17Ql2BOJPYJDK5ooJaOWb3khAVwqBLPPC9JmeyCgzizOMIQ
         l5qjvXWX/3+G5F2S8gVwRYUKXPFlAw1uqXiviDyrK2CrnGHIJCb2wJPXdMEPeHi0kjLD
         o9X4yNonrXxX1dH0qhO1xKLfOy8+TxQi8if94R+EjA40rumKOXviHTVvv5tY24/vLx5Q
         PjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933370; x=1720538170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFuSodRLNrK58rHG08Ugt6OOXdx1ce25g0GNHzycwgM=;
        b=bSpcdBtH8jYzUwtca5oz8oiV65LQ2oTBfGnA++nU0SxtC0ScYZQ8pRG/9vr/CEEBsA
         1mjza+Lr56ixhC7yikHsRWejYmaSurMRV0dlShz8GH7iz16YIOc4EcFV9/VY11bYyoam
         b90m1oPlv1JmNscCgGaKwDZhTi9DwnlkXxZKKXlzjFHNnucdr81Wg3UAITmDrw8+3y27
         za3Kha+9cki5q3eyz1HWsLz5fhBbU9MP0sH/GztGEj6rZLApRirQTdnETdj5p1Lv1jBs
         PpVE1uDt1QBcg/T0oSTkY4jSUsW40CBi1x6C6gT8E9BQjRV+xfaGVwBOKhEOMS/2VSrj
         wqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFSo4ezj7fpmxZxmZ3MmGPbZfJYGR7vLpTiA2Hwykt/DBz/pttalw/73+SlBW+I92+vu5xHgu0uSfKxpmjeyW5UnBf2x8K
X-Gm-Message-State: AOJu0YxM0vMVmwx9x88VeN6MGq5YQGnn7clLQww7bTqwPwuMy6UsFMzR
	T6psDfeIMPxlloq/yM+LDw06XDVIo8gyMKL4oGdbB8fSm+jkhstDbcW6+BZcw03z/qUQGwt5jTi
	hQoVR4Sc6t4wHGVAJPrsn1Kj9ZRxv1jGzb2Ym
X-Google-Smtp-Source: AGHT+IFX7cHYnRfyVZKgBvOahQcReiRUsN8SfmAePb9EYJsizFIm/Tgu8OMWGap6ZV8kbrdWXuhSL9HzGY+dRqxmJLo=
X-Received: by 2002:ac2:5f7a:0:b0:52c:ea5c:fb8c with SMTP id
 2adb3069b0e04-52e93d5e565mr8637e87.2.1719933369561; Tue, 02 Jul 2024 08:16:09
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702142406.465415-1-leone4fernando@gmail.com> <20240702142406.465415-3-leone4fernando@gmail.com>
In-Reply-To: <20240702142406.465415-3-leone4fernando@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jul 2024 17:15:55 +0200
Message-ID: <CANn89iKLWtyVP9-YU4a8cnE4Mj0zMNtzQkzkHgM0uqdQV-mcPQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] net: dst_cache: add input_dst_cache API
To: Leone Fernando <leone4fernando@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:26=E2=80=AFPM Leone Fernando <leone4fernando@gmail=
.com> wrote:
>
> The input_dst_cache allows fast lookup of frequently encountered dsts.
>
> In order to provide stable results, I implemented a simple linear
> hashtable with each bucket containing a constant amount of
> entries (DST_CACHE_INPUT_BUCKET_SIZE).
>
> Similarly to how the route hint is used, I defined the hashtable key to
> contain the daddr and the tos of the IP header.
>
> Lookup is performed in a straightforward manner: start at the bucket head
> corresponding the hashed key and search the following
> DST_CACHE_INPUT_BUCKET_SIZE entries of the array for a matching key.
>
> When inserting a new dst to the cache, if all the bucket entries are
> full, the oldest one is deleted to make room for the new dst.
>
> Signed-off-by: Leone Fernando <leone4fernando@gmail.com>

Hmm...

This patch adds 10MB of memory per netns on host with 512 cpus,
and adds netns creation and dismantle costs (45% on a host with 256 cpus)

It targets IPv4 only, which some of us no longer use.

Also, what is the behavior (loss of performance) of this cache under
flood, when 16 slots need to be looked up for each packet ?

