Return-Path: <netdev+bounces-139436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DA69B24C8
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 06:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9852B209C3
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230918D620;
	Mon, 28 Oct 2024 05:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WVu/3owU"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16021885BE
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095147; cv=none; b=RpffdJgLSIP0n+z3uyyWJ9ktUn3ZpjcKlzEe9eDQYzFy6uclkU1KDzf9Rqz+JDyPyPih+whD3jfiAXe0B61g0QVsB6qC57iJJfDXE2CI9FSF3E+3/nV9gBAYzeMazNXzmF3tv1G6lfFD3vGGAKGbkwEK0Ks1Tc8co6y4KEo/OfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095147; c=relaxed/simple;
	bh=GyHy2ehMiq0kSfxmRoAo1MH2MwYdvN/RRAYfkPXzTwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8cmKGNoxwwfmUnhxTl9Ix70ZfBo/U+pQ0UKxrYnqVcUVIoL2JPpXXRcTOEYRQSKBl9RkyR41hPfDTX1YgeioCvx6eF8+tm1fYng3cDTZpLjz4Oa/IuklEwxxlsX7KnD36AWsBey2BRLvKmWW2xzdeOPkntAl4j4e1PZtlUZyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WVu/3owU; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9117f014-3ad3-4d9a-9357-4b57d376c660@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730095142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFVZGR7EERaxw8wCgEoCpv+J0X7JC4VBGETy3usqJSY=;
	b=WVu/3owUA3h9p48LY+zfyilS6UtV9vUVknKJc8gkGgURcTNPLMJhfaw2Baqq9CE1p0fSUK
	bL6MTKKhlKD7Z+xgzdjQG7y4Hi0/z5mnOoqz3pyLv6AhRf2HmpwAhktq3PAu7Re9aQ+KOu
	4NL67pe6ZMj7KxukFQPImEGAjMG+dmc=
Date: Sun, 27 Oct 2024 22:58:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch bpf] sock_map: fix a NULL pointer dereference in
 sock_map_link_update_prog()
Content-Language: en-GB
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 Ruan Bonan <bonan.ruan@u.nus.edu>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
References: <20241026185522.338562-1-xiyou.wangcong@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241026185522.338562-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/26/24 11:55 AM, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> The following race condition could trigger a NULL pointer dereference:
>
> sock_map_link_detach():		sock_map_link_update_prog():
>     mutex_lock(&sockmap_mutex);
>     ...
>     sockmap_link->map = NULL;
>     mutex_unlock(&sockmap_mutex);
>     				   mutex_lock(&sockmap_mutex);
> 				   ...
> 				   sock_map_prog_link_lookup(sockmap_link->map);
> 				   mutex_unlock(&sockmap_mutex);
>     <continue>
>
> Fix it by adding a NULL pointer check. In this specific case, it makes
> no sense to update a link which is being released.
>
> Reported-by: Ruan Bonan <bonan.ruan@u.nus.edu>
> Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb progs")
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>   net/core/sock_map.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 07d6aa4e39ef..9fca4db52f57 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1760,6 +1760,10 @@ static int sock_map_link_update_prog(struct bpf_link *link,
>   		ret = -EINVAL;
>   		goto out;
>   	}
> +	if (!sockmap_link->map) {
> +		ret = -EINVAL;

Thanks for the fix. Maybe we should use -ENOENT as the return error code?
In this case, update_prog failed due to sockmap_link->map == NULL which is
equivalent to no 'entry' to update.

> +		goto out;
> +	}
>   
>   	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
>   					sockmap_link->attach_type);

