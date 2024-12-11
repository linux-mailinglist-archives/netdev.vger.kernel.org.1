Return-Path: <netdev+bounces-150913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D679EC121
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12399284FEF
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C73FB1B;
	Wed, 11 Dec 2024 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdpIp3Kk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D87E110
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878609; cv=none; b=Z60a67Ie1CCLPwfT3YxybAw8PjOTuNb2VUoENugFfUGNgXOZKsJXrz+r6meQgAg4kDJGyNygNX5oHjUtKHAzLwJBLtYT+PwdOKtHE5yWMXppx8c4kxI0j0hcYzN4yH6aoMRIl8f+ueUT8WEZ81c+WaAA2tIjb+Vz87cKo4WT4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878609; c=relaxed/simple;
	bh=HOUJXa+NhVwnMeLxVmCi73+gCx+RV381nwV3c8EoCDc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=C0kXcLxBoruIpciqRhHxq9yzoMkd+7trCdZ4x5KDeYT7mQe3kyHLVKdbpv6ijbJoK9TlDF7A+jT0YZY2/RPdC7PdFcOgjZy6eH9JnSSZOqKATu/4myuKDwHjka+5ZWeH6GGSErr50K1YFBr41mO4w/+bw0I5aNTvLjK4Bj+XbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdpIp3Kk; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1601e853eso454788585a.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733878606; x=1734483406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fe8W200tJ78cQwJ/Lp2SLmuvmafs/Bp49CF0bF8MGJk=;
        b=EdpIp3KkEfIaq5BtehesCVwXiQtWwO+pkW9ol4HeRZgkw5AYBLpT8mOjwJH4PHlgRx
         Cm3Ndwr9bpP+iHyx+oOQuhXCR0007xClCApp+g6RY7T2QPV5ACdynSwHjx7VfquW4nw7
         xBER3vlgjshYpRfy0rLdWQ2KctCmA0ApLExmFeMPey0UsSEeuCDeY+DYN6Ho6iDN0JHd
         XfMQjMtL4luH74daSE+ONXF97WcZUdLJMYIsZZwQDYIlMjsINcgfiaJ9aHBoqnfK0wdI
         ksRzP7WT9oDbWrSw/BSJ6tuXpofbFP7JVTgiE1J69Rd5wJ+pFvQMXIL7B0cbAEzPxBfd
         nckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733878606; x=1734483406;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fe8W200tJ78cQwJ/Lp2SLmuvmafs/Bp49CF0bF8MGJk=;
        b=ZPoQb9DJDbKrmCwasfLtRzBDoqN7ufdVACNs82pZtAA/tUlllK0DA5e6QUjHRfzQnF
         GUAofvP/nHxy00gGnI3elWX2dhEA9IzmgeCQyffCbXp0zLDJhJ9Klz1MpfiJTxUj0lvs
         1rPkV4E8U07U5MnKH/lOMy76pTOqf8d7blJlfT+jmpevMVrjqBnoUICrU0s33SjpAerP
         duM3gY3xxYiMUrkZiluo1YixbT2zPrTRYMHURyiXAsj9opRUCrFHRJTQZlyxXNrGuWtg
         ijQJ1imfhRD39z6TSObqbzbb///Y93oN8ZUMSu5EllW9OSRqOSZOnRAAdYaTwvbKUyZn
         awNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXewxp9yFHyxdG+njVtv6LklxqjbAv8xrDoAeu6GiD570Zp6dPTx64fe2Onw+OUPYvaSi6eqhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUVFgryKuQ0Fpp+snCCTcn0oL9v87nGqg2gusdGrw4dNjb6wu
	FpVGNCB9oHhCiPoJPOZsk7Xr5VV+TccS/Yf3b0i3W7O/K6intjRbYSm7mA==
X-Gm-Gg: ASbGncsYrp5PM9ztMtkFn19lu/zPAH7V2uKU1dlzvMhpTo0Zcue5qSNLk1/7NGlDrUF
	atB3eRIx2RWuXtuRHw/1jRDTcccy5u/l7FK7FVcwnz2Vt63ycgWgJ18O6tK8Cn/YrayiSLEWDgm
	TlmGGThKhuqlKazESfyksNHTKRfqx6mFMBbo61d3BnD73y5tHc1XZ3iZBuaiRlzlte1wsgq11Nd
	n21g/4VZkacPunGXQCahYUFhFbsW3j8A767G0ttfpT4CUtLpBzpsIl2YCCwsr00J+cQWM2XdwfZ
	3KLSxYD67ySxgAj8ICLi3WStPg==
X-Google-Smtp-Source: AGHT+IFGra5ogXskVHNgKHGO9zkRnbGPSsAjDXtdnjA6obQAg6nlMfUYExSNiBt23mjbcUv0Lm0A2Q==
X-Received: by 2002:a05:620a:370e:b0:7b6:d826:40ab with SMTP id af79cd13be357-7b6eb4e4bc5mr183432185a.51.1733878606354;
        Tue, 10 Dec 2024 16:56:46 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fdeeasm66335596d6.78.2024.12.10.16.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 16:56:45 -0800 (PST)
Date: Tue, 10 Dec 2024 19:56:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>
Message-ID: <6758e34d1b9c_3ed2bc294c0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241210191309.8681-4-annaemesenyiri@gmail.com>
References: <20241210191309.8681-1-annaemesenyiri@gmail.com>
 <20241210191309.8681-4-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v6 3/4] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> ancillary data.
> 
> cmsg_so_priority.sh script added to validate SO_PRIORITY behavior 
> by creating VLAN device with egress QoS mapping and testing packet
> priorities using flower filters. Verify that packets with different
> priorities are correctly matched and counted by filters for multiple
> protocols and IP versions.
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


> +            ip netns exec $NS ./cmsg_sender -$i -Q $priority -d "${DELAY}" \
> +	            -p $proto $TGT $PORT
> +
> +            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
> +                | jq ".[] | select(.options.handle == ${handle}) | \
> +                .options.actions[0].stats.packets")
> +            if [[ $pkts == 1 ]]; then
> +                check_result 0
> +            else
> +                echo "prio $priority -Q: expected 1, got $pkts"
> +                check_result 1
> +            fi
> +
> +            ip netns exec $NS ./cmsg_sender -$i -P $priority -d "${DELAY}" \
> +	            -p $proto $TGT $PORT

nit: delay is not used here. Neither txtime nor ts is set (and only
one packet is sent). It's harmless. No need to respin just for this.

