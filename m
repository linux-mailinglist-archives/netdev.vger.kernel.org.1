Return-Path: <netdev+bounces-190099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C248AB52CE
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1798C0A58
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C449267AF8;
	Tue, 13 May 2025 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="N6oSl//E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0242676CD
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131546; cv=none; b=Tu3BJsSpsxouV+YC/qIjzELC6Kcwx60B1h4XRup60Sr7IzB6gLzmdSyKW72W8PyqtBq9WsokOf2pagOm03gpqyFQfePjvvOegZMNG5FIo1EhSkER0D8/3YK9ZZhYaRg6GsEf0Y31sQJwxLk6fz2Rk9phJPZT67X5JFvnaHwOq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131546; c=relaxed/simple;
	bh=6T/d0P1sUVPNxRoQ+EAcZcSkZRYMi9GW2gHqUtNAvp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqYOcYtrBz6JmtRYlKyfnCB9tVm52uZ+5ajQxiSF1IAmvpiBXNAwdwj2IcBfeaTnqrSW89KlwsWS9b5QTeUv13RZJNz0UehHQtXp4v6JWxeumq+R/rImRJbznY+KE2fwWIMZgR8hUK9L2FYUtVsQwSpiUdrdueHXpjn9abEWyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=N6oSl//E; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5fca2805ca4so6333982a12.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747131543; x=1747736343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Lziol0DDM7/vSqu8jejCxQG+aLFOYY5z9F/nXLBCtg=;
        b=N6oSl//EVXsLpvH5ZWxoYOI1319XbzASZ1y2Qg77Vbdztherni8c3XE7OlL8c1+Iug
         Ttue94rdcd0EOZzc9mKFAMCvmws7LvzQd+GAqk7MPmXAfd7AojxLnBCfuMbcJ4viJGsu
         LIbmpT6GueBZIGbtnjEbAPjtGdDs4JQkCWhq0lBsg+FN0CjlnCILvhmsuf6jJbHSRYJj
         6/RezS1b8MmOjh7yOwCW6wlrms8vAY1mhX4JSC229MOs55ahdxP/DsgUz71DUyhKLyOS
         C1hfyKUX6ZghF7oUoOVHY8xou5drKfNZZNnc61QBSeaLZQxIU+2kYKmibQvyh4hQJz04
         DYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747131543; x=1747736343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Lziol0DDM7/vSqu8jejCxQG+aLFOYY5z9F/nXLBCtg=;
        b=u6nzo8ZUG56r78OS8QRoNUSQEuT/C1cpxSxQ4XFMMbGYJ2HtE+e/4yVdpncbuNyw5L
         GtEOjGYdNTGa0FmgA/XfZucdj1HnH5V+qErmqMTENch0L18UamH38jWHDka4pAZeJYua
         T0otj8zvCOhe07FXVwE8TZOjKD1zDK3G3nXaeBhyXVZzwgK4dQhKx+3JM0BLH22Y4u1P
         rqG+NMaeHOhh2Z/Xq1XRa0Hdx5Unp4pyouPBqQkuxlK/WBMb1K8PcU8OqoRhMtHIN8AE
         HGtrTnDVYzVOBbgzzjBf0kMMQSQiflMXUZTquJU5mvKhkL2Q3GFrluUZSJm+gfurrKjz
         kHxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUg7us885qhNJ35gezySWRr1gx9Qh4jDBQCvR4PpPkpNfMzF7qWpRIKXy5odTeYtl/OayectU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9Shm0vSY88/pQTtqhPeCfCglXQtgxFiQOdzNiy/hBy6sKm/E
	sTLcnUBFSU1Q3YOVIHc81B78L4rP8AyX9WVMOG12gX62beQ1eVa9EO5nnFobIGg=
X-Gm-Gg: ASbGncswbjBVtjiiF6WR+ylxbVceVpov9WjFrP0LNN2ekUtAfCXfURYwRClniFr7PeA
	g9DamMfwLF0MsJ9Z0MGAu7qmJ/pbZuEFTZqkJxg1g1eu3qSePDJ1BMc0k3EiwqdRHtjL1JY7jrr
	ityJxyMVTjyXguvFgbY0bwFB7QoJRzCkoULGRlNVd9zzNy8jVxUjCFNEbtWg7nOXS2WLx2UbLaF
	GrMaTitM1AGKNQ3EZBFPN7wJsx1s8CnzMfwcHiR65pMchRrYtOhFI0PMO6sj7EwzzRvyotwA+7F
	wTdIdcosmLV7DRhMydl2TNaHEGvOb2xmO8QfEJHil2ihxLfNKqEdHVV09NFNuafUjZN4f6sMTaO
	wYP9G7yc74Xe3dgRaLQ==
X-Google-Smtp-Source: AGHT+IHBkNd9v2QgaWV3YfFo2qlh3TBI59w/t73b/WSWzJaIIH6wpToNEG0iusqe8PqPx2fGoVtFNw==
X-Received: by 2002:a05:6402:2709:b0:5fe:524b:b47 with SMTP id 4fb4d7f45d1cf-5fe524b1c07mr6931116a12.16.1747131542659;
        Tue, 13 May 2025 03:19:02 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70d8casm6977961a12.66.2025.05.13.03.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:19:02 -0700 (PDT)
Message-ID: <3e8af869-0695-470e-b7fe-47f107d44638@blackwall.org>
Date: Tue, 13 May 2025 13:19:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: bonding: add broadcast_neighbor
 netlink option
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
 <2B0F476B6A0D5505+20250513094750.23387-3-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <2B0F476B6A0D5505+20250513094750.23387-3-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 12:47, Tonghao Zhang wrote:
> User can config or display the bonding broadcast_neighbor option via
> iproute2/netlink.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> ---
>  drivers/net/bonding/bond_netlink.c | 16 ++++++++++++++++
>  include/uapi/linux/if_link.h       |  1 +
>  2 files changed, 17 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


