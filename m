Return-Path: <netdev+bounces-162641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03FA27744
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94DE164AC4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179892153CF;
	Tue,  4 Feb 2025 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bzGW8A21"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19E20D4F2
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687064; cv=none; b=L9Eb1nrmYGxKrzNSe6iLJlJBE5ig49J+FV8nXoKixC4CYKU77S7Vz/d4N6JOnoRnYgEfgZq1L/P42pdqkUwQuwSm4PB2DCA2LUFoa5UxMFonZNCbzLIcSBD8tsZ3vZ80HXrVmI1UuwwQUhtpzGAdP/XBwT0jZhBzYWbngFs5QwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687064; c=relaxed/simple;
	bh=oAQUD3NOig+EJmiGnroSAnxP315Xcbwak8eQmyYFBcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZcC4hQMWXG8lWQvhIjvsaFlMWp3ZkO9QgjtzHLyNnSv3l55OdotFugv1LpFZQMbYwQmZKQeu2luX+R8E9JOxzyvxyAwSFTjxWOs41HmdTHBOnIqF5tAQc8mjtGFuUAYbN770wo9GSzmSyleuP9UuimrMVmx2vsRb0w29+/WiQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=bzGW8A21; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec111762bso663762266b.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738687061; x=1739291861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azVWa+X8VHLBsu6Oq4b0LavSloPxp6Lh4xpa9ao53RE=;
        b=bzGW8A21xDL7Ca8Nw4y0z6FyJ6C+WPCxjS9v1UJ9zIcryTxPGuOmU1zczZBi/KhsME
         pSdNrwjdMh+VZDJqggaz+BI1N085tRYkWBmCp+rjjRUCOrgMePDxs2lDA/ZD0rbSS42s
         kfAzFFFDEOifJdQz5RUAUSR93BpYnyIpfw7BBpqdgBDepVhb0foaT/62iokWwdU2l64H
         C1Q4WMfETwRFuleE8hLsZFJSzyppaWtBA8Ma/Fk1rdVWh4y8Ezp/w0gtBc4mpTwjlubZ
         4aj9G3Tm7W2jYe8Bb9xMvaUbCnyowCOkV9XOobhl/eFEao+IadvaSeRMS+mZuc5ULtum
         00Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687061; x=1739291861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azVWa+X8VHLBsu6Oq4b0LavSloPxp6Lh4xpa9ao53RE=;
        b=DZSSB4qvBx9lXTtmmS25ttt8LeK1ACQPqg1BMcuhq842xgCVaHDoIAEEXDTesS12/x
         WC9TawQWClkN1JgULV9zS5RKRr5phgUEr0oN6IB3v0hr0OkHrCJOGKucWwJQva1aoKOc
         bDVwKNLBJEVBO8jJQxK710m97eKPnUVDskQYCPACNT7xJ6Eb9V3lWS4Ubpwrgva5NY9j
         rO97jLyBKMivYz4kpB/sfjKUw65GoKkfJDt8IyXUwV+qigKtwqoKk+SSjEaRv7CMYSrP
         M7fh5qXPV+aEdpHyPtnURWNeJijotl6CeMxTQy/Kq/Jt1VKMoZ5LSIz+kKcYUxjj8dcG
         iX5g==
X-Forwarded-Encrypted: i=1; AJvYcCU324AqPSu7qAN3Prr1bZ4h4LR3sCj3M7M8mKRaSQQRbCdwPKrYRqTO6uvsNkgEkg+K6F5yL/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9EeiO1ftj65kgyqJ1hS3ED0ynd+wWMgQ9LU5PrdMa9/tItGb
	in7tfxwLDAsVtkgeE33094NZjGXwEXqE2i6MkjqeuUzGSnC8U+idttEGK9mtAvE=
X-Gm-Gg: ASbGnctnsRvCod2BI9MAsnVUsuV7trvHfZmyXFeibo/y6QMPZYlLsiVjiqMZA3YpGk4
	IgDcVApc12AsNsOnq+Wfgs7Akq6r2/b81NC/gRFcyxzP0pJEXBTGRErJK6E18JeY0WYbE4Mw+GN
	02KP6W8EhMA3O9g68QMHDO9DXfJ+D4s1ckMGgOrzpwpkWaOPvMSrTI47Z9r9jwaxYbUHunRblx7
	J9N3vFwGchnvJJYTEKYiWoV1GI7qYqlLWmlClfmfXzMPb7N4yxe3aVUZ6bDyfZcBMu35ZniP0Ui
	PmT8jr0qrucGSFCIeL7dc6jBcNJC2BS3rOyPs/Bfxp+AcxM=
X-Google-Smtp-Source: AGHT+IFGObaw97n8Ht4AFcxlCdDk7u4ilv5Sc42271AZDm38AZ/T3kslyRDCg0f1FUMzUuefB5ghHQ==
X-Received: by 2002:a17:906:478a:b0:aa6:94c0:f753 with SMTP id a640c23a62f3a-ab6cfd096f9mr2839573266b.33.1738687061369;
        Tue, 04 Feb 2025 08:37:41 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff3d4sm947173466b.112.2025.02.04.08.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:37:40 -0800 (PST)
Message-ID: <eea10487-d6ff-471b-9f5d-aa802a2088ec@blackwall.org>
Date: Tue, 4 Feb 2025 18:37:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] vxlan: Refresh FDB 'updated' time upon user
 space updates
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
References: <20250204145549.1216254-1-idosch@nvidia.com>
 <20250204145549.1216254-6-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204145549.1216254-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 16:55, Ido Schimmel wrote:
> When a host migrates to a different remote and a packet is received from
> the new remote, the corresponding FDB entry is updated and its 'updated'
> time is refreshed.
> 
> However, when user space replaces the remote of an FDB entry, its
> 'updated' time is not refreshed:
> 
>  # ip link add name vx1 up type vxlan id 10010 dstport 4789
>  # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
>  # sleep 10
>  # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
>  10
>  # bridge fdb replace 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.2
>  # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
>  10
> 
> This can lead to the entry being aged out prematurely and it is also
> inconsistent with the bridge driver:
> 
>  # ip link add name br1 up type bridge
>  # ip link add name swp1 master br1 up type dummy
>  # ip link add name swp2 master br1 up type dummy
>  # bridge fdb add 00:11:22:33:44:55 dev swp1 master dynamic vlan 1
>  # sleep 10
>  # bridge -s -j fdb get 00:11:22:33:44:55 br br1 vlan 1 | jq '.[]["updated"]'
>  10
>  # bridge fdb replace 00:11:22:33:44:55 dev swp2 master dynamic vlan 1
>  # bridge -s -j fdb get 00:11:22:33:44:55 br br1 vlan 1 | jq '.[]["updated"]'
>  0
> 
> Adjust the VXLAN driver to refresh the 'updated' time of an FDB entry
> whenever one of its attributes is changed by user space:
> 
>  # ip link add name vx1 up type vxlan id 10010 dstport 4789
>  # bridge fdb add 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.1
>  # sleep 10
>  # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
>  10
>  # bridge fdb replace 00:11:22:33:44:55 dev vx1 self dynamic dst 198.51.100.2
>  # bridge -s -j -p fdb get 00:11:22:33:44:55 br vx1 self | jq '.[]["updated"]'
>  0
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


