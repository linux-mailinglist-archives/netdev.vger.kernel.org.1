Return-Path: <netdev+bounces-149652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3525E9E6A7D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286961886886
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5AC1F4727;
	Fri,  6 Dec 2024 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="X/taIYmG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF61F6665
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477879; cv=none; b=igp2NgF2Qt3lJlmwYYr0xvBwcknjDXvqiesRqBxtOiunIVQEhNUMaARBcW5hZW0cH/fhyY/3psCtySbbS5zUonF5+nf4gSgDqHj0nkiLJjum9s5MWOf6+eX/f3P6DDs1Pwqtt8yeSY/zApaJCm2qKvXmMfXp/TfUY+3wZh2PaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477879; c=relaxed/simple;
	bh=xU8pzihQSh3sfs6Ah0gX5UDyiPE4d2yqWD813BQ4TBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTULjkSLMjHZ/ayUcUynBQDGA0mDdpq63O0TINH638CMkOle7HXIuHJ4pK32WjLtSmpnAdeoUEbZ1TODDD2dO/+lPhRe3irt4b2Z5Wpfdh9yRbFStMvBUw4waKGCUGW3OJKXuSxKiEl/IPrJL8msSETNS45/hlOyi08zPCtpvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=X/taIYmG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so2142168a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733477875; x=1734082675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0mUqMMO9NUfJRPX7sPHRHiox6mPU3UOR5Ea1ZIorjU=;
        b=X/taIYmGDG3MQgOL4/m7aGQvC8B3XcfSUes8d02Meug4Cpu2dT7I+Ath+OPr73EG4W
         ad37O9MzFH/1QftOBOzT9K87CRQk951iDGzdNdNmb0RLUVoK0vgHKnkVfkHjxWgVF+CW
         W1PxArJG38SsjtzXrzlFZZvIKMHQbdsGWhXKHDN5LXUPb6YTOy+D+rrrX+COeXN5zBIc
         Hh7TOpLIXZJBrFO1dxYZXE7sNte2rPxkfpv4nWJYQru4F9hczffeQQGbhFVPt54TEIjf
         Ed8cmV1ny2xlV2Wfh4546mNGiEj/qRR8XRd0GW9aIvNp57qys0KoyWya4W4PSP/ycSrO
         0uuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733477875; x=1734082675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0mUqMMO9NUfJRPX7sPHRHiox6mPU3UOR5Ea1ZIorjU=;
        b=jK/nBO2pjKAVFwSp67j1J57XIwW6BPs7cxfwLglAbzoPnOf56CIzHs2i+A2vEeGOK4
         anAeJOXke97cSwx9Mai2KlAbz8Ke3qUDiNrqDe6wp2E9+p4S5kNf5S8Oy/bUhjRuU7P1
         KTE/YhtWWnAlag+8DcwINY2miJcjDA4QJCZGbnuvVPQSiIcvY0jzyTVv6crHJizSCpCO
         c1VQ85FxinR9LnnmqBpIItwOEhGRXLBjb/PcgH4m1XLu3QXK4eDZEVYx9kVQHlbiWxqF
         pL9IzKQOVOtJvEJFShyHV4NG3mHWLPy6vM6A27YjdaqEkT03Rx2BjKfeJtAGdDQayP4o
         ifRw==
X-Forwarded-Encrypted: i=1; AJvYcCX0R94TYz5ufL5HYx3Pfm+X9b57rW5LMJomY+P/VmwuoLpviWG+9Z+mpe5Sox7STpw1mxW1Zyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfaz52QJtEcip7A9k9xQLk7W2iy+cEC1w4cCsanvJbXIafKGqB
	10m7Xt2KAw6acDs//mkh7FB+wsPR7olgqGvUW4Jrt/tLv6EVDw3lU775Qfnbo7o=
X-Gm-Gg: ASbGncveAhP0l7eQI9L2o94bGu212UzVg2go0YitttMYnmMTXp7Sk/cwcxWdmlQ1x72
	Lt7/ALX2Zn8FxqnepkeC85Ha+s8igoJ8ght2msQQC1qxYfemCZu8y/6oliVVc+Q8sdeymIKNNtk
	CzBg1f04agaFLUWld4h0CJzj8Dh3fgCxThkukyLPPcmKZHy3SB7ljnMDEun4k3tnfnf1FIJWXYz
	6+sukyWVz2izvyVPmJG90D9mHM2mXuGIE3AnNo/2tVD+qWF7/y5
X-Google-Smtp-Source: AGHT+IFBTV15QXDDPVkJjD8I571tVHStVYlP8ZluNVz3PMpcwafXacGmXVuNGq11wBBUCWeOB+9O9w==
X-Received: by 2002:a05:6402:380c:b0:5d0:e3fa:17ca with SMTP id 4fb4d7f45d1cf-5d3be695187mr1738132a12.15.1733477875324;
        Fri, 06 Dec 2024 01:37:55 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a25ee8sm1905498a12.3.2024.12.06.01.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:37:54 -0800 (PST)
Message-ID: <5d50d420-f94f-446c-b674-a532e31fd784@blackwall.org>
Date: Fri, 6 Dec 2024 11:37:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/11] vxlan: In vxlan_rcv(), access flags
 through the vxlan netdevice
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Menglong Dong <menglong8.dong@gmail.com>,
 Guillaume Nault <gnault@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Breno Leitao <leitao@debian.org>
References: <cover.1733412063.git.petrm@nvidia.com>
 <5d237ffd731055e524d7b7c436de43358d8743d2.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <5d237ffd731055e524d7b7c436de43358d8743d2.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> vxlan_sock.flags is constructed from vxlan_dev.cfg.flags, as the subset of
> flags (named VXLAN_F_RCV_FLAGS) that is important from the point of view of
> socket sharing. Attempts to reconfigure these flags during the vxlan netdev
> lifetime are also bounced. It is therefore immaterial whether we access the
> flags through the vxlan_dev or through the socket.
> 
> Convert the socket accesses to netdevice accesses in this separate patch to
> make the conversions that take place in the following patches more obvious.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Menglong Dong <menglong8.dong@gmail.com>
> CC: Guillaume Nault <gnault@redhat.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Breno Leitao <leitao@debian.org>
> 
>  drivers/net/vxlan/vxlan_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


