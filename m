Return-Path: <netdev+bounces-150977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B19EC3C6
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2EB5284D1C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F5C20C496;
	Wed, 11 Dec 2024 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZZETFFl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637E29A1
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 03:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889282; cv=none; b=EqjVA5Su7pNk8lnT8/Nr2HWOEi7ef+t+egGyBebzVjlp4GUBgt615brWOQ9CXQqJMS4HMDlhzlo/khaihi5zq3Q/6DdA0lda6+toahAoa3u8ICIe1vZrGESLgyvpXcW7e0I3KGON87fx1VOqaVbfB1TtoCVz6oiFJgWTKWcvC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889282; c=relaxed/simple;
	bh=9jn2NpSoLd7StaWKkgIdmVmyIKQsMCKpDXdAQoZyOBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUaeKXSvpwIMIou1IuZeCR5XseoUfehRI0ruVtkVuaMkDMeI+psr5lDLxbZ/ubw8KucFN0ceogIP5cwycuQwFpuoJONawV8tfsSWLKbYvm672ypc7IPflX2EcB4bUGruabmodU+cmvWxdY7pMdY6RoFpEL8lt0tdjRvbFpI0RAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZZETFFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4661C4CED2;
	Wed, 11 Dec 2024 03:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733889282;
	bh=9jn2NpSoLd7StaWKkgIdmVmyIKQsMCKpDXdAQoZyOBA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fZZETFFlHkwlZbU8+NnTwhbJ+tiwkmgzIMWfZpkjfEQKh/ESJE+HqIzu0Y7dYjjSN
	 56/5pQJHSCK8RlJ45b9ARZnJ1nMGna+E3W6O+KFPcOO10R8nj1HJopsvwNsblof2Kg
	 QxdOuNcdJ+sydcpkzn3A6/jLuTxoXSISIDYUInnH60G8O2XWRJlKOZ0Ecl5aITHnA3
	 s9jigvEj0OUAtgwLB/e3/R3HiKrgnlZ/oK4Hmmg872wwsj27m840nlv64Sl7sBLnOP
	 Mi4eOZuYsSSVQEnThkOOzonp+Yg/2WTNrGC586qpIKDBsVYeDGM8F5rmfWVktkoG/k
	 JVIRODyYVyGQA==
Message-ID: <f62026bf-825b-4e19-a2a1-2ad403d11fae@kernel.org>
Date: Tue, 10 Dec 2024 20:54:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] ipv6: mcast: annotate data-races around
 mc->mca_sfcount[MCAST_EXCLUDE]
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 eric.dumazet@gmail.com
References: <20241210183352.86530-1-edumazet@google.com>
 <20241210183352.86530-3-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241210183352.86530-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 11:33 AM, Eric Dumazet wrote:
> mc->mca_sfcount[MCAST_EXCLUDE] is read locklessly from
> ipv6_chk_mcast_addr().
> 
> Add READ_ONCE() and WRITE_ONCE() annotations accordingly.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/mcast.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



