Return-Path: <netdev+bounces-64532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F228359F0
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 05:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B83C1C21296
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 04:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294381865;
	Mon, 22 Jan 2024 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uts/2u6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45CE4C65
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 04:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896101; cv=none; b=lB57Mcy/xH9pHMPCjapTgst3gI6zA2uo4Ftp4A27RWfhmvAFyIC4HOG8UoxXLOkxUHGeOWLxME8kB8WOaljJGSzUiHIfvhI2na0NYS2DG5Xeb9lNfddjJa0y2ZxkyqwxD8hkwg3mgchmWcsaewI5jHVwtxpJniwtQVSSSgarl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896101; c=relaxed/simple;
	bh=Z6kPKgWPBIyc74BfoLAnHtqT/UAn6gRNskxSv0LvWxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CM8RPMtmfy2DO0vFFuJ8EViAaPEJ+1yAP7SY3Etv05ki4Q0RtvFvpdcKk9+Z6XeYV6jSZ/WMjkE2F0j5sb3wcrJtl8BGCYV4Rayw2iNHqASLvhV9K4Ca8+Xl/rNgklUcWzbEMVvdBMdOH/JBHHloVispYhPxHpX3m22xRo/2ts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uts/2u6U; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7baa8da5692so115814939f.0
        for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 20:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705896099; x=1706500899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lGjjFHz/+XS34tPNIXpKCwpCAnlCPuXyiXL366vvh4Y=;
        b=Uts/2u6UNCPjSbPpDbw2hW5xBPFDr5x0juzJfB/oXFhWGFvpCjbvirXAJEKugMxlY+
         Lpnqg0pk55FuaalYSNar28T51rDLcguSf3TiMWh3rO+aZS7Hj2T4qp/p33pTKMajRPwX
         ZYk+SNLPV5Pv5MhYahRtsdy0d2duwztIk/pQsciOZhlBJ7d6MhJaDue5h7e/zk+EV5Iw
         NgYXocHn1UcKofz4gNHHJpbJUHuW52dOgDrxdSEfeB3b834uSPWnGxlJ3tmh72FHKPjg
         006ejtlTEC9KAAAg7ikkyUavMQ3iu2u5Qv3LmEgjmTE24HmuDMETeF6WG4368u51Q+bs
         MfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705896099; x=1706500899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGjjFHz/+XS34tPNIXpKCwpCAnlCPuXyiXL366vvh4Y=;
        b=lkQbPL7R67zib43mtV6hRc5gge7WfX2ZiMHM2yA9lXqUN+CecFeNHlEwdeVveeixSJ
         5rcJBhtP6QI8rKxhPFioAl1LIOgZvRmG63BHg7B1H7YhmWrK8XRKGgkMrvIBMkpfFU7x
         OlLHasoBhOZHj+iz7tVCDTcKzTCgC14wBZcb2hjHCslS35Iw04a89U/4ih2hR5B849WP
         RznzPtSSPR2bf2YXjkfxtaAdYwS0teTXiBz13wivlid0DizdmtaEwzGnQFlKIGJJCU+K
         ZcPLVC8HFKWxgfhnTs6zabQgM2s4rnOJhUkkXmFVA1vivF1e6acW2npttMqpOR2ZTHDv
         eiaQ==
X-Gm-Message-State: AOJu0YwJsbq9Zlf/IUaa+Cw/KbvwElx9euZJF1OK9JJAoKg60RaZvbki
	JAPXPdAs9EU1eg9Lk+WL2Qr5G730QG9JSYxbclGoN3ffp+vA+ST8
X-Google-Smtp-Source: AGHT+IE1QPdrBxwpcbbLbbeIEJjXUegVx64aEVlwyoyS8uADhaEKwWr9SWPyYqHiHHsmc2MrNicucg==
X-Received: by 2002:a6b:7315:0:b0:7bc:4210:2e44 with SMTP id e21-20020a6b7315000000b007bc42102e44mr3740390ioh.30.1705896098911;
        Sun, 21 Jan 2024 20:01:38 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:98eb:fac3:d51e:322b? ([2601:282:1e82:2350:98eb:fac3:d51e:322b])
        by smtp.googlemail.com with ESMTPSA id c14-20020a056602334e00b007bc102fb67asm5764919ioz.10.2024.01.21.20.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 20:01:38 -0800 (PST)
Message-ID: <680a66d1-4b96-4700-9c29-f238933aa962@gmail.com>
Date: Sun, 21 Jan 2024 21:01:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ss: add option to suppress queue columns
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 netdev@vger.kernel.org
References: <20240108111020.12205-1-cgzones@googlemail.com>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240108111020.12205-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/8/24 4:10 AM, Christian Göttsche wrote:
> Add a new option `-Q/--no-queues` to ss(8) to suppress the two standard
> columns Send-Q and Recv-Q.  This helps to keep the output steady for
> monitoring purposes (like listening sockets).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: rebase to iproute2-next
> ---
>  man/man8/ss.8 |  3 +++
>  misc/ss.c     | 24 +++++++++++++++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 

applied to iproute2-next


