Return-Path: <netdev+bounces-61501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A68240C9
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EDAB23E7A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B7921357;
	Thu,  4 Jan 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LRXyB32K"
X-Original-To: netdev@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE01EA74;
	Thu,  4 Jan 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704368409;
	bh=6gm0MtDf0rBmmCKqW7YquHOvdQEOxHYKjl8+HI/3+Wg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LRXyB32KwiwH05gIgQ/c3xxhwVUR3lWL1QF+YJLK+RTVyYSvhp9mB4l3XZOivNy4l
	 7wp10LXZWg4qJVdA8mb76ASbOdkKjwJO/WjS7fGrQtdf9rqOqV/DlIiYMP+gOVvtDX
	 hlTKspcs3h7J3azJ/t/Nay/8g6Rv2vUDc8492gtJpOO1zmgStOAzyO02ubnndr9+C9
	 L+ebxjbx0a6BJf/5jqqm0PIYh0I1aXz2Znjqnw38ycqMTgAnp0NHkI9pwNX9uqTKSj
	 f8dTTMO97tI57JXZePupIzJQg017G2a24b5/Wb6WA0slcIGPk1VHVVvW+ZITe8MuEY
	 KXXPP0oFy/VNA==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2F52A3782002;
	Thu,  4 Jan 2024 11:40:05 +0000 (UTC)
Message-ID: <d4a31d87-0fa3-4ae7-a1be-37d3ad060603@collabora.com>
Date: Thu, 4 Jan 2024 16:40:08 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] selinux: Fix error priority for bind with AF_UNSPEC on
 PF_INET6 socket
Content-Language: en-US
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Eric Paris <eparis@parisplace.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
References: <20240103163415.304358-1-mic@digikod.net>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240103163415.304358-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/3/24 9:34 PM, Mickaël Salaün wrote:
> The IPv6 network stack first checks the sockaddr length (-EINVAL error)
> before checking the family (-EAFNOSUPPORT error).
> 
> This was discovered thanks to commit a549d055a22e ("selftests/landlock:
> Add network tests").
> 
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Closes: https://lore.kernel.org/r/0584f91c-537c-4188-9e4f-04f192565667@collabora.com
> Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
Thank you Mickaël for the patch. Tested patch on v6.7-rc8.

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> 
> Changes since v2:
> https://lore.kernel.org/r/20231229171922.106190-1-mic@digikod.net
> * Add !PF_INET6 check and comments (suggested by Paul).
> * s/AF_INET/PF_INET/g (cosmetic change).
> 
> Changes since v1:
> https://lore.kernel.org/r/20231228113917.62089-1-mic@digikod.net
> * Use the "family" variable (suggested by Paul).
> ---
>  security/selinux/hooks.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index feda711c6b7b..8b1429eb2db5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4667,6 +4667,13 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  				return -EINVAL;
>  			addr4 = (struct sockaddr_in *)address;
>  			if (family_sa == AF_UNSPEC) {
> +				if (family == PF_INET6) {
> +					/* Length check from inet6_bind_sk() */
> +					if (addrlen < SIN6_LEN_RFC2133)
> +						return -EINVAL;
> +					/* Family check from __inet6_bind() */
> +					goto err_af;
> +				}
>  				/* see __inet_bind(), we only want to allow
>  				 * AF_UNSPEC if the address is INADDR_ANY
>  				 */

-- 
BR,
Muhammad Usama Anjum

