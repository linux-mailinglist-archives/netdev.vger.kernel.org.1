Return-Path: <netdev+bounces-157916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D06A0C4BF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498773A0612
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AAF1E3DCB;
	Mon, 13 Jan 2025 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jpACI8F5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF51CEEB4
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807529; cv=none; b=lRXT+tXZr1++MR432+9wjdEN58im7QIMvp6Cpwjkpx9o6SPTnqRe4LrJ7t+wUcBXUTpmUl82nV8RieBNHp3hxGmc9Xft9zoFShd0KUUZL/+hcfJeEDf0GYcdkIYA/hK67VkmyeAmWOinJmGvm73ge5Aafc89AM+s22wYt0DDirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807529; c=relaxed/simple;
	bh=hbjFWc/M1u0JtUeGDfraCyEfZ1LuYrMt6ic+SN3g7Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDGlcDvOOAJ4RVPVpgfMOd5Mq02Wj90uHivEdINr0TYGoTek5FbTmJWrjJZ1CO8weflakDNUSFpQJM5/Wx5n9qZ06XgCyQ3B6bdTQl62z+Uw0iKklbt76qulfMsWBZIrBZHEFLfEXQJjsqxJN1COOQOx3LvbQdYXVtTrY7N258U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jpACI8F5; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce7a33ea70so1953805ab.3
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736807527; x=1737412327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=jpACI8F5zdSCaEhZJdlHGLRyv+e+ExUikhghVozjlLiCFCETguLJg18HkqUsjIPEXu
         7ZYZ2vzX50iawyyI6SaMxtF/bHYqUmUvXXdWAhubV0KnryfMHw347d5qN1OvMtgQwqhs
         9qIUY9qLWutz/kh7gQUM3snSG3Q5hk9lF/fskUu9xAlusNLi3RHmIoPLZPXzUvo4I5pl
         s92Pzer2XCn+BzTRd4jOvfg8aEbUDYVzyyLH8ixDafMHluhBOd8Z8je13QbfmbaPmUfT
         /hlc4D0XQqNFtbIyuorW+/iD/0cVdEbGXSMPnu2aYHe7QAvr6o4mv8Jbhl9GCooPnUA0
         4VOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736807527; x=1737412327;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=ZhgUwFFNEGc93ByEHhwfsBhf1LT5S/0Kq5bs+PkTwc4eC2I9/wzO2yUEIqa8IXjolM
         RP7lU3/bIK2M3Ddr21j7DwkgYVK9mI/TswCPOD7onALFY+nZ48tpXpgKpPvkATs3l7zh
         q0h2IrmlFJz9HppSzX4UzvyDgsyLnN4wAf4gRmRxGRlwEdiQ5NkoL7ouaodjvSzqb7tO
         cXna17qvbsD9WmJLfXFmGipsYldhGtujq501ek+Rdap7znvBoFmFWfPjB3F1o1RxFg5q
         SH72VfvU6VPg4nykVfPsIrPmDQBTsqxeuGfxIg/Jx68X8RiqWjLD2k4B/tEvfnltilub
         iTnw==
X-Forwarded-Encrypted: i=1; AJvYcCWR2bY6LgEUJUQyMiw1NP6TJ4YSNdtN+Aynx5zZ6kxbR8osHX+jBtelLwI+VQsKMxD7desocNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrEpHvyG+VsvaP9Tp7fJHXm7IWvSA1q3qlGrH1e2PbYfB5I1/X
	GBOSXh0jgQiKkJWx8Cn+kjIIULuK7SSSFuzBGRjM6eSJihhQ14r89EjYZiqBL98=
X-Gm-Gg: ASbGncu0b3P9tiK3dFTouZKQgnrhNWN9IqgFvC0XzwoZGuENfcv3ON/Y11TRS3Z8tmH
	ZUW5w0xe0p4RiPIXfd3ZZOEfii8UjqaYxwVb68Lf0pUhT8QjZGOVA+nPdQY9UCyn8UMobztwx/+
	RElegHRR4SIg6cJY9O1tx3LZXdiZL2QPSijusg/acOGjdMlzfwcDr2a9knxVTW2IpBdr4bemdAN
	KOKMwayPjQPepvNEFWGIsIIhFkn3lIMZBhmW/yU2PN1Mj7pffq+YQ==
X-Google-Smtp-Source: AGHT+IGza1UWlyinqLQDDvkXKHMxhIrf8nEuCr5exGMIqyR2VhyxBJgIxQ8XJ/KUXaebYKPkcdPv4A==
X-Received: by 2002:a92:c565:0:b0:3ce:7ae7:a8c2 with SMTP id e9e14a558f8ab-3ce7ae7a9f6mr4276195ab.11.1736807527235;
        Mon, 13 Jan 2025 14:32:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b611829sm3038094173.33.2025.01.13.14.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 14:32:06 -0800 (PST)
Message-ID: <3fff2dc8-f371-47b0-80ab-b87385339b9a@kernel.dk>
Date: Mon, 13 Jan 2025 15:32:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 15/22] io_uring/zcrx: implement zerocopy
 receive pp memory provider
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250108220644.3528845-1-dw@davidwei.uk>
 <20250108220644.3528845-16-dw@davidwei.uk>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250108220644.3528845-16-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

