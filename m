Return-Path: <netdev+bounces-176392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD6AA6A078
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175F33AE8ED
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040BA1EBA03;
	Thu, 20 Mar 2025 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfWPdF2I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407A51E231D
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455953; cv=none; b=GlJxmZYVl64rG4eS64eeRk+QFD0XRrfYgEki6ziy6h6x8OvcYPLgDDdwpeHJOc1i3xulkc18kbfSCgmetrr7zyK5hVXaEVq0rJBTZoOFLnPQhpqpw7OS43CI/WTu5a+RGmsMVXcKLtiWY/KmiEsJur1kO4RjtPPGs8bC+O7YHUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455953; c=relaxed/simple;
	bh=VaUCyFjoBbXD5p47bnIKiSYiWY4qk7r1NZVAZDTS35Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hk4+GpgJpi8mIYQDqYRvrraMca82K5uNAewIFvVd/KReTzO16nI/G30XYMBPLJVIje+hzYPuOMRGdpwjno43t6D2sYIkxTlxrTK88itdXSwPiD/cLs6XKBqzVqDJtwVVEMilWuf5iV70yKsnRMRa2XWoOK4riToOhy5vRwa0FcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfWPdF2I; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390f5f48eafso182603f8f.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742455950; x=1743060750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPyhiARCFu253Fa1rlUSfBlVmPJhFTKavSMh2Tb9NyU=;
        b=NfWPdF2In+aeLxi5EO2XnCcMWqnKIRwyxrrHpadprQyjd6Z6WGy+gdKcZOL23mrRkY
         QaEbQOlhaInT2dq90sLmEIoTwpcG8hQvs6AQNuo3N55X0JPXKtrSLokDJZ2rn5djsABR
         3/4L4+tc90J187jVIZDfAHO3g3R2crKI546+EpFUsfMrizBaa8ozQObcziuSLDdiJTEu
         bWZ9mUOUBzmF/LnmaeYlyk4Q7zSGvlrURqxVY2VoeQkJwUXF9nGT4atY9drNgsDXKYd7
         5Y5tSpfLScK2+8oux/pLZqlmpH3KRKwadHYqEagsZuwVU+dUKcCHxKQBhco5YMkY3kMg
         PCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742455950; x=1743060750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPyhiARCFu253Fa1rlUSfBlVmPJhFTKavSMh2Tb9NyU=;
        b=n0MTxte/3zeOoc+eFiDwvBVwcrUdvryUg3/E42M2qPjZgly49xyzMAa/6XDu0u7XjA
         D9qpobLkw7BsB0QizrjMGZzQXsNyZW3VEs53qrbj4s0732OEEcOfDzVJSnveH+/61wL7
         zYW4faUt/zPpzBI21417DK43Qc6CPyX9COB7Aq0RXebXevyrvNJ3ewCjhlJWe/g7lFyw
         u+ViwJ2RBdI/468+/URRUaATyepislhLRp8Qn75cpkEVfbaDPev5x3zecrIJgaarH52L
         aIweFSHyLTa/2HwcEYqStGBcgQttl3x0dPntds/UxCcTKELPVh2Sa5h4zk4Zo6CJR7l+
         /Juw==
X-Forwarded-Encrypted: i=1; AJvYcCUsZk4mrWObdJEwFE/yO4MOon0sjZ7XT4rnMZdBVMxrVhaj97m1viqQXJPOAXihCEEnTVSVvsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wqmAgVre6x012UhYFwWKsKqRiiN/yh5lIjKahCPS1U8QX2N0
	w0uLDTQ9HHnqooEx4ydbP7BnQWvLh8vZfIOckRNZS477wWJI/8we
X-Gm-Gg: ASbGncuTMh+hVEJEN8+rYOnJffC6xzl3wHVEL0K3VJOhN71Rwxsm/jM8CSQblIhLegN
	8SzarXwb/Q0e8aomZSBUwYUjEmMh9FaPi3HKSvVn3xI3HN+5Q2UyhqsE4H0H3XnKoY+56++p2O/
	RcGVfoEuRCI/OaRcsaD3XV4ZWr0+7oqoSbt2qLbhk1FkXpplQZqAOFWorqC7j9YIVWP5qlMZnfo
	F7sPWgnLxgufdl0wgybNGhIo+0d8lLy9SuSZ99ysG8BHS1OpnOYOfToS97pnRc9mD0NzBepdm4W
	L8pA8vKCmF9wx7fNSlinjc9JEwfvScgIMlIpbbF9h0li5Vvu6gKgQLGS15IHY1huLQ==
X-Google-Smtp-Source: AGHT+IF+4zRnQp0FH6NSLzDNIoIwp/BaZuO2NR5FPpGqw9aarCVpCUBC/NIP0oWcAWBYhqmoF6QXrg==
X-Received: by 2002:a05:6000:186b:b0:38f:28a1:501e with SMTP id ffacd0b85a97d-399739bc288mr4776790f8f.8.1742455949983;
        Thu, 20 Mar 2025 00:32:29 -0700 (PDT)
Received: from [172.27.33.126] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318aa1sm23578718f8f.64.2025.03.20.00.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 00:32:29 -0700 (PDT)
Message-ID: <0fa82602-3b4c-46a7-bdfc-e8a9535e74c1@gmail.com>
Date: Thu, 20 Mar 2025 09:32:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS
 context
To: Maxim Mikityanskiy <maxtram95@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250319124508.3979818-1-maxim@isovalent.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250319124508.3979818-1-maxim@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/03/2025 14:45, Maxim Mikityanskiy wrote:
> There commands can be used to add an RSS context and steer some traffic
> into it:
> 
>      # ethtool -X eth0 context new
>      New RSS context is 1
>      # ethtool -N eth0 flow-type ip4 dst-ip 1.1.1.1 context 1
>      Added rule with ID 1023
> 
> However, the second command fails with EINVAL on mlx5e:
> 
>      # ethtool -N eth0 flow-type ip4 dst-ip 1.1.1.1 context 1
>      rmgr: Cannot insert RX class rule: Invalid argument
>      Cannot insert classification rule
> 
> It happens when flow_get_tirn calls flow_type_to_traffic_type with
> flow_type = IP_USER_FLOW or IPV6_USER_FLOW. That function only handles
> IPV4_FLOW and IPV6_FLOW cases, but unlike all other cases which are
> common for hash and spec, IPv4 and IPv6 defines different contants for
> hash and for spec:
> 
>      #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
>      #define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
>      ...
>      #define	IPV4_USER_FLOW	0x0d	/* spec only (usr_ip4_spec) */
>      #define	IP_USER_FLOW	IPV4_USER_FLOW
>      #define	IPV6_USER_FLOW	0x0e	/* spec only (usr_ip6_spec; nfc only) */
>      #define	IPV4_FLOW	0x10	/* hash only */
>      #define	IPV6_FLOW	0x11	/* hash only */
> 
> Extend the switch in flow_type_to_traffic_type to support both, which
> fixes the failing ethtool -N command with flow-type ip4 or ip6.
> 

Hi Maxim,
Thanks for your patch!

> Fixes: 248d3b4c9a39 ("net/mlx5e: Support flow classification into RSS contexts")

Seems that the issue originates in commit 756c41603a18 ("net/mlx5e: 
ethtool, Support user configuration for RX hash fields"), when directly 
classifying into an RQ, before the multi RSS context support.

> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> index 773624bb2c5d..d68230a7b9f4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
> @@ -884,8 +884,10 @@ static int flow_type_to_traffic_type(u32 flow_type)
>   	case ESP_V6_FLOW:
>   		return MLX5_TT_IPV6_IPSEC_ESP;
>   	case IPV4_FLOW:
> +	case IP_USER_FLOW:
>   		return MLX5_TT_IPV4;
>   	case IPV6_FLOW:
> +	case IPV6_USER_FLOW:
>   		return MLX5_TT_IPV6;
>   	default:
>   		return -EINVAL;


