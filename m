Return-Path: <netdev+bounces-127226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB50974AA2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA942870C4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B017824A3;
	Wed, 11 Sep 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HkwwtjUq"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB642052;
	Wed, 11 Sep 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037515; cv=none; b=eZCuT+gkbdzuDf/44xaRjOv8+Kmu83dK7IW8DMHFvBoIIlGurJgGNhCMZu3SwTY8tUPxO5R7Z5BiuOWSDZysgruTUvUuod0dd616YP22Q7hPhmKttTnbIpXmgSHOcZ6jatmSeuV1F1hV+ToeunF080RCe89gw+u5O7Fnu2gQP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037515; c=relaxed/simple;
	bh=5GoDa1ZuHwo8DnYHyJawsyRzPVv7J7o0/+2nhxgXx0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9VxZa33vZLyrPkZgav4A/gAfkxrqusVoTvxExAOT8/Q24z01pUXXcx3ToLX74u9pKXQZhYKTnSdDqf8qYjBa55/rmhBi/2C3MWj/DHcx2vQEd+VQFPj+A83lbWUiHKnYjnWVnOW4l8sIlNoacb+pdZ/tzLKqc0nu1f0rROgP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HkwwtjUq; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726037510; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=V+Cf3j8kyIpe7fIpFYgsQUDbORzHorAudKvDimVjAPU=;
	b=HkwwtjUqqCUh5JQRxPbJNu4c+jv7Rip8VX4yhLQr4qBC4bgw8f7fE9zHIkCnKeZBfp6THW1sujy2spFbJZaI0suOoObkhqT7zJQmaJeP7miI4Hkvo5sKNe4/UiSzHX5121CHiODAIFGREz4OTS9p1YQmXz/TZaf/6MNQcf0lCqk=
Received: from 30.221.149.106(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WEmySDX_1726037508)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 14:51:49 +0800
Message-ID: <18f0012c-c7b6-410f-9c48-74419c8f7de4@linux.alibaba.com>
Date: Wed, 11 Sep 2024 14:51:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
To: Qianqiang Liu <qianqiang.liu@163.com>, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240911050435.53156-1-qianqiang.liu@163.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240911050435.53156-1-qianqiang.liu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/24 1:04 PM, Qianqiang Liu wrote:
> We must check the return value of the copy_from_sockptr. Otherwise, it
> may cause some weird issues.
>
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>   net/socket.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Looks like a fix patch, maybe you could add a fix tag.

> diff --git a/net/socket.c b/net/socket.c
> index 0a2bd22ec105..6b9a414d01d5 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2370,8 +2370,11 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>   	if (err)
>   		return err;
>   
> -	if (!compat)
> -		copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> +	if (!compat) {
> +		err = copy_from_sockptr(&max_optlen, optlen, sizeof(int));
> +		if (err)
> +			return -EFAULT;
> +	}
>   
>   	ops = READ_ONCE(sock->ops);
>   	if (level == SOL_SOCKET) {






