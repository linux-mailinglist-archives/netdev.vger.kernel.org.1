Return-Path: <netdev+bounces-230037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7FBE3242
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63EA5863C8
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A827F01E;
	Thu, 16 Oct 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Zn1ppHKH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81E06F06B
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615146; cv=none; b=pXRJBfDWN+sdYtLcXPbs6ndi+3ikzTA0pP6AxQWUAF7nrAkiZnqgcU+HpSyoVvshkgITZ7UqtgzDK72Lhs2ETlygRG2LJR8NZaeueQ+kLYYDPpuj4eZYIKz7yaC4KUXPr5xw9YW+5P2o5mH7o3KK2gWg8sC3lj0JtwOyjZ8SMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615146; c=relaxed/simple;
	bh=KhvEm4XFWGxbCXqhwXamgxBv8272sn5H3qSFc0nk0nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNKncAKJgT4hB0ozR+PrkHgeMUtBk8zwt4oJQq+/y4nQ4Xu5WE5Y8I+zj+0LtaEmXSHhA53FMS1J0iAgJ0a4/1nfugj4BOqEOfcDiESgeroSpStJVdPbpARx+uXQnVtw28Ie+9ZkgGFGjRrUCTy63TDVQGuYBC27xLDez2/4w/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Zn1ppHKH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3d80891c6cso333230666b.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1760615143; x=1761219943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9ogow/MCxwC6xQPq5tlB+OoZn7KTGO1gzWJixSspeA=;
        b=Zn1ppHKHZ+o4XR5K+7kYdLB3khls5GqDiEahqZK8grKGdv3DLCkLRGyyp1xJIBefvM
         bYhTWoW6RDpbEBTBnqUHe7yFx8h9j6VZ70F3irb6YU1YjGLv2aeV9pdyAyGBF3d+E/pE
         D6fTy4C9Pu6mfFGvGC08c64P+5ly6b0BwXoAKK5JMaCvoMeWNvnvtT4atVoYMIghoCPl
         xuzJVZq3gchXOuXfbFGMFJIJIW/jT57wyHoKN1hwO7xeWVlzWPr3/Ae7IsMDqSXvug6H
         m+d8zNjpjhRQCg9HiHh/XCJJtpqIhthpsAuKatRzvhuuhp/fIYWiGuyXprlaYaxl7usa
         yNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760615143; x=1761219943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9ogow/MCxwC6xQPq5tlB+OoZn7KTGO1gzWJixSspeA=;
        b=uhZHoVKYu10VhdnSiBvcbN+Q1bkGWlXidWzKK7qkFYqtS0x6LUhKPrO5ZgUbit0D07
         JUSLGsyOm5esveps2HREuEsfdYVfl3ctML5qh77fc1iupxjTlkjNpKwJ/Rm6Mw6mVKzj
         2heRAZCgvhc8E7jV3v8JRN0lXp2gXE+Figmuro0JY3o2SFDy/xTzZDBMUEXpuA9El+hq
         pqBwmoSIlezwZcHHUzV/QgoMejUlG87ftArIMn1FItkc0/elq/cPMGWcQBjkEZkeWJOd
         zHG4XaPd3rFChJxDz+7NgDNVMUSdL80uwT/Wz64h90i/C4aIBqU3ljBxp6unQ1308J/0
         HOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFBpODUWPyMmaZh56sZyYuEMPluwDDmpC+GkC/uSNY5sWwD4tdf8n5ZRbzlBb7JPqXJWSWYc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/ZW3MrIngZuWnohuGuzy67nRH8wstuqIpBfrl1biW7izTomp
	k+OSUQxLZy3RUBk1oXsaHm5ZXr76oBVPj5HIBNTgcZz3FODXWZAYPFwQFAIQn1HAe30=
X-Gm-Gg: ASbGncs+YTXeM/1aaJBoj4E9lbxZfMBl8mD8XynAmpjEUAnnmO5jKCW//FYKZU+6p3D
	73XOq3Z1pD1WjzBSfrbwtOmm4HhvywUOLQK3bahRu1WL2jVd1MjiQiT7bLwy/tCCeRZsuow1Q1d
	Gje2TqhrofmUrGQxwMTF3YOr5hVmRR0NeKBn6zbfkL2nxhEdulcRR1CNOzYoClG6YaJ5G4s4jpY
	Iyi5Uef3+eWBnMfjwjsgZZgx3R63OH04STTGKb0+thjZrMyzJtfILiKQVduLwsoOUdi3r1Yyq+w
	FnWFSkGZTLxEEU1bKXojzfojGF8pcYBqhkYUxW4ajT/wc9lmZNoZUZBMZ9LGEx1qJqPR+KP/reU
	5bWRX0+9CqvhGWhK00pB0+GvJpQ1elwfVNbCV3T23KhqPtSvgq9BZi7jb0dD3qgRwZwvkaNCchx
	mGJoUwpXRtGEJYHwlGKiFXqUtgt0JosZMRohRE51p6wlg=
X-Google-Smtp-Source: AGHT+IFfgI0RzU2YIEloFmDatyMK/vukia6tq364+UTKGou0F1vugc7gBfyEZ6gk3pRfF4mh6gIVJQ==
X-Received: by 2002:a17:907:60c9:b0:b4a:e7c9:84c1 with SMTP id a640c23a62f3a-b60521b11d1mr435792766b.7.1760615142901;
        Thu, 16 Oct 2025 04:45:42 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cccdacd88sm488482666b.43.2025.10.16.04.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:45:42 -0700 (PDT)
Message-ID: <bd16ced2-32b2-4f94-aedf-cfa8a955fa7e@blackwall.org>
Date: Thu, 16 Oct 2025 14:45:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rtnetlink: Allow deleting FDB entries in user
 namespace
To: =?UTF-8?Q?Johannes_Wiesb=C3=B6ck?=
 <johannes.wiesboeck@aisec.fraunhofer.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
 Vlad Yasevich <vyasevic@redhat.com>,
 Jitendra Kalsaria <jitendra.kalsaria@qlogic.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: gyroidos@aisec.fraunhofer.de, sw@simonwunderlich.de,
 =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
 Harshal Gohel <hg@simonwunderlich.de>
References: <20251015201548.319871-1-johannes.wiesboeck@aisec.fraunhofer.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251015201548.319871-1-johannes.wiesboeck@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 23:15, Johannes Wiesböck wrote:
> Creating FDB entries is possible from a non-initial user namespace when
> having CAP_NET_ADMIN, yet, when deleting FDB entries, processes receive
> an EPERM because the capability is always checked against the initial
> user namespace. This restricts the FDB management from unprivileged
> containers.
> 
> Drop the netlink_capable check in rtnl_fdb_del as it was originally
> dropped in c5c351088ae7 and reintroduced in 1690be63a27b without
> intention.
> 
> This patch was tested using a container on GyroidOS, where it was
> possible to delete FDB entries from an unprivileged user namespace and
> private network namespace.
> 
> Fixes: 1690be63a27b ("bridge: Add vlan support to static neighbors")
> Reviewed-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> Tested-by: Harshal Gohel <hg@simonwunderlich.de>
> Signed-off-by: Johannes Wiesböck <johannes.wiesboeck@aisec.fraunhofer.de>
> ---
> v2:
>   - completely drop the capability check in favor of changing to
>     netlink_net_capable
>   - describe intended behavior already possible for adding FDB entries
> v1: https://lore.kernel.org/all/20250923082153.60030-1-johannes.wiesboeck@aisec.fraunhofer.de/
> ---
>  net/core/rtnetlink.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 8040ff7c356e4..576d5ec3bb364 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -4715,9 +4715,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	int err;
>  	u16 vid;
>  
> -	if (!netlink_capable(skb, CAP_NET_ADMIN))
> -		return -EPERM;
> -
>  	if (!del_bulk) {
>  		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
>  					     NULL, extack);
 
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

