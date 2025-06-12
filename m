Return-Path: <netdev+bounces-196897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1031EAD6DBA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9643A24FC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39389232369;
	Thu, 12 Jun 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vUxJJVgb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27E238D52
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724195; cv=none; b=lsRUTGJRczhxcVP/yFax4aU48Uc5TUt3MIVA4PnwGLHgaeS76AXTCW5puoHkdnzhoe7guz8eH0q0DsTLB2fm+A6B7LF1qvf+xDrkecuJ9J8218W+5rcDO424BfEV8A6sq+xaW435r5FSxTM1UkhDJ9MwlajixBY7kJ0eHvEYu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724195; c=relaxed/simple;
	bh=sNOOV+9KbWG4OXOMCA38feIL9Po2xJyY6W5gxIy+2CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3hhan3TexdQrLgjcyCWwvymXdfDc8XeA6OYFcq8OjvaXobN5Z/l+uKefaUfJO+oav/3I4mN8mC1nDq0k6hrcvwBINvzcrp/037t5KVz6AG48DRCYVXGPJK2GqtaOv/nGm/1lFwCwyYu8YJWrnSqoknyqrolSeCKhT6YOC4Rcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vUxJJVgb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553246e975fso844789e87.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724190; x=1750328990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBgZC1ZKNoQszzI7uLPK/aOgW+pbDnzau2oBiF8iNu8=;
        b=vUxJJVgbFB1M9qTlWCFBKpDLgJgl+JQVUlv/+/SP55sYZMUgKoSiiBBDQdeZKiBBjO
         /A+4sQApDmTG6gzlTp4CcTGFvgSC4yaKiS/LF6PWYx/gqdNEOmUTuyIhDo9u1ZOVbxj1
         gEMUwdHqfuQNN1L351CaWQTgt7GHAs4RQqYYlLQg9+Et6XdcNYdXeIVQcigEQ/ienuUT
         AnGfYN3P+nSFg6IhdMj80IFDJOEwqZWxJOeB1LHquzjWCdjfMHYnVQ0z9hmfQt0a3sJa
         8L+kOBdUqEnRXwct4XCQwh3g85irYzspOVuf0dFmaxRXGwB5dhH6HWPOVq14ANd18DVi
         V9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724190; x=1750328990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBgZC1ZKNoQszzI7uLPK/aOgW+pbDnzau2oBiF8iNu8=;
        b=fxswY7GxnSGmoSN/HclwZIaR9pYgwAw+gLjF3OUytNQC6U91ARvPOCRt62ggd6HUgs
         0ew8dSRx6yGib6+eVayVjnmYFDZSlSMqy+EyaJh2F7e+SKQyf73EadLhYnAUACAs4fhj
         XxSW2qZhQhjXPc5YaOcyKtZANLn4l0aqpfrpnq9X4tcuDdqF8f21IfgITgIiUahY9KoF
         buqEz7ykGU9bcK4Ax8scpqcVxlg0WjLpgIGRkHzQyR5DQwhwZvEaWWQzHluAPqIwN0//
         nJkRkoVSD+bZHzjqMVUVW6TraDMEM1kvFnrlR8ahuwvGxG0NksimsISdhXtaCirCbwqQ
         3nKg==
X-Forwarded-Encrypted: i=1; AJvYcCV54ZlMAAUXvv9XwCFMzEnzdiCAirVhoYgY4moYU9FG5mMRcL7wS2eGsNU/ls0XfWZwY6YPKCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrG1iepjOLsdeBSRL1XU/fuwtfBhg3fkbf9s/TJM7zckY29GN
	ROUutozmwXs3sUxJ7PPPWJMsXF+ETied1liuG/g0rE7iZiOxX9yVNHuNVCwowxjj+EQXLfbfil9
	7PdCQ
X-Gm-Gg: ASbGncvfNSU3nzUK9hhoox8x5Hd4KU13Pv7iSapGNMFDhwA3JWbohqzR/5NtU8QhO07
	54oWFbpcXtNb+hoVdfBDs01Gb8nt59S/VavxJlLIbc9A1Nilh8Tvj1FdxNAXr/0ZgwCyvTDYYoj
	59NzuRjirvXwr87qXQDfd7Z6VHhh2LTofvoqg4wrJ7F9HIO9tk6X7lGi8OYOx4o6lIDsqdEdd7t
	6nn2nvwDYLts42SJwDXp4fSqp342CUDp46c+rKlYjwT5aLIBM7CaVTbiIedQ08mWCIBGCUkvmIU
	vYiyBSF8bGiYtLjjSubDc378qYTkqWDLNxBcXVhpVsqa0J65dCkoey7ewpyuu91pRsAxEmK1Iue
	Dvhyv97QGqdmXjdrQm5lCikpfHreL8jA=
X-Google-Smtp-Source: AGHT+IEIdyFP+saitKhmaHv2s5wN7JGPbFFGxeEZmaLzif+QZDiO9p8Iu77WjtfkY5X6YR2I21uERw==
X-Received: by 2002:a05:6512:12c9:b0:553:2c92:a867 with SMTP id 2adb3069b0e04-553a559e831mr773144e87.55.1749724190270;
        Thu, 12 Jun 2025 03:29:50 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac11686fsm68151e87.28.2025.06.12.03.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:29:49 -0700 (PDT)
Message-ID: <edbb9a85-c392-4224-927e-6597c686a8bd@blackwall.org>
Date: Thu, 12 Jun 2025 13:29:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/14] net: ipv6: Make udp_tunnel6_xmit_skb()
 void
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1749499963.git.petrm@nvidia.com>
 <e73fd6fb6ee4f4ee6c85823217d9fc3ccee49db6.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e73fd6fb6ee4f4ee6c85823217d9fc3ccee49db6.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> The function always returns zero, thus the return value does not carry any
> signal. Just make it void.
> 
> Most callers already ignore the return value. However:
> 
> - Refold arguments of the call from sctp_v6_xmit() so that they fit into
>    the 80-column limit.
> 
> - tipc_udp_xmit() initializes err from the return value, but that should
>    already be always zero at that point. So there's no practical change, but
>    elision of the assignment prompts a couple more tweaks to clean up the
>    function.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC:Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> CC:linux-sctp@vger.kernel.org
> CC:Jon Maloy <jmaloy@redhat.com>
> CC:tipc-discussion@lists.sourceforge.net
> 
>   include/net/udp_tunnel.h  | 14 +++++++-------
>   net/ipv6/ip6_udp_tunnel.c | 15 +++++++--------
>   net/sctp/ipv6.c           |  7 ++++---
>   net/tipc/udp_media.c      | 10 +++++-----
>   4 files changed, 23 insertions(+), 23 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


