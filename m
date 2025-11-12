Return-Path: <netdev+bounces-238152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBDC54C0B
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 23:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3393C3AE3FB
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 22:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB54C2DC76C;
	Wed, 12 Nov 2025 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMHBrv1q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B72D193F
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988012; cv=none; b=uZVkkFnA86iTAUaKHWSCKsj/oqk8UzkGsOLRxUpLEvxYv1vloOelmfdWkVjBywHxwffy4HpRNbslWJwoY4ECI5+QXejq/NuEaChf158NA+BWb41YfWsxR7DT05uIPwGdwNH1Ah7wMb8vcy6Y48K5B56ffG3CCM+uzRwzPgSCpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988012; c=relaxed/simple;
	bh=CW1/WHgPn9qMuft/a1iGcmRDzfQKLcINdw7buHzOOa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR1Wv8ELOvNHbPFSBnDk6M3rbsfprTy2l2ioyBjNsnca00LiMeWJ7PFnoAz3fKWsL0b/cggGDd07VtLBtPw1cn0+pKYsCaYXGJ3sUUW5m4DE6wkxukBfV6QZxtWspbe8vM35hjD9g9Fnbq2iAtolmzwckjL0Lc+xIaaWJPIicwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMHBrv1q; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4330e912c51so1209255ab.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 14:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762988010; x=1763592810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJezF/9b1ZI2Ff9ouhH/QarQDhiDX9Qh/QOKFkhGS0Y=;
        b=lMHBrv1q52nVF1a8uhCpm7zmKC4X/xJfnZrOp0wqFntWUsL92KuNsbtswTfSqk+ukH
         9QMDSHNko/wDiWugOexP4nc4ZwFPtyXgrseITybgOOFSQsTP6ffRaNF1HXGrkXXewqbt
         bcgVEtUrdX9Apj4ztEZVYJEKZ0JTCrbUonUEI8S5QYJcyLN2p4nm5oCfMkNDrPW+WaEn
         tlRbslVbYCtMPdkfCyQzaTdlf9fI9N4Xyn5jPHpi/v69Ux/sNxlnK8Pbdv00QnevnRWq
         PoGXDElkTSNOdhUx+1tTq01kzXBGJUrDQiClQ7CTqNjpiIrXvEsf3yaBJnCSFhFcaAeT
         8rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988010; x=1763592810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJezF/9b1ZI2Ff9ouhH/QarQDhiDX9Qh/QOKFkhGS0Y=;
        b=cmLkQ9737Cfo9j+9Ch672rQp/jYmNvnoVi2zdy1OdbdiDq8C/KgBy3nLptpnk4afMq
         QOnSmboiIVsoOApYmlDmzNQP917sNm08H8XGWofDkgVXGF1HtvMMf+/+fCWkX014caoU
         zbejxcwyZn7Wu4LaDfd4U1j6m7+LE/GsTZgFDxtpNbJYgZq21Z86gywK3a4ZFrvZGO5z
         tGgCDgPyfYY0YVdrBg+rrgbv3r6D4fsRUmP5i14fzuMeQmQ22Tqh9G9h2W9/WkLKOoR+
         48xmHEfkP9LoORuEC5QuGqJnapiP68z0gNeUfdFofbITAxJAutaAwnh+LvHhJ4y/DF1b
         XYFw==
X-Forwarded-Encrypted: i=1; AJvYcCWoBZk/sSjx0bPTgGaTz1SXQaoEO64jAJCbOsZ27UJIGFnVQiT5hkIg1Bh+qCczUx2tQfmSxNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgzPb+cIznFP92AwiUL6jGNUIZ1DmTKpFJTrdZv36Ia2qhmuq
	5y1faMJKGYyXlsshSbFsNWKxvozGleH1BsQHB5MLfdzGTc61P80Lflc+
X-Gm-Gg: ASbGncufyi1gwZbkakHWHzA9H93bNav8ECT0nbaay6HiLjw0jO9Sxj3F14h9JKyx7mU
	KSl1titZCZsBzPvBmzP5WxzHy/rDbQloVzeHT2vnJxbKSkcKHqy+0rfERlXOPRsNVYBb4RqKlnc
	2YjoJ1Wek6Zghf8JRnd9xWlNR471HVJcX59fxHD90pWvK862FPFbAlP1TsZT9zAbS5LVIfH7pxq
	JQsvzilesrjL2eARj463ctEE7PeBv6oMvF1+qjUgkg/ZeKk28NZdYrI4qfKrwvbCuOCxesGHTYi
	kUhDunDONwMPaZwj9rlY430JxHQ+nvMgmVbjJoNWfTgWn005s6Rd3WtR6q557tBl90dzffWRlOE
	k+ybk5BvonPqmWqy5/NlQTcq/eCnL8OTTFLvm0zDzDpq5z2gWbInmM+3P+PPasq6HKxQchBQ/wB
	a3j7uclnCx5um3HbraRfz5RPaxqhYWHaE/7lde10eQb4rATQlBRKexJ2nKecF0TMRpvfOkzY420
	RDFoQ==
X-Google-Smtp-Source: AGHT+IF3B7yFe1EFwfh4Nk48GD9ViEa1tek9tp+2vf8EQPe+iKRYEJLF0IQZp4NjeWxIuf6wkX5TKA==
X-Received: by 2002:a92:ca86:0:b0:434:7797:bdab with SMTP id e9e14a558f8ab-4347797c9c9mr37644065ab.14.1762988010569;
        Wed, 12 Nov 2025 14:53:30 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:85e7:c261:d08f:ac20? ([2601:282:1e02:1040:85e7:c261:d08f:ac20])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5b7bd330947sm97463173.49.2025.11.12.14.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 14:53:30 -0800 (PST)
Message-ID: <cdc429d2-e0ee-4744-b11e-2ec8e325acba@gmail.com>
Date: Wed, 12 Nov 2025 15:53:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] devlink: Support
 DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, Jiri Pirko <jiri@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <20251107001435.160260-1-saeed@kernel.org> <aRUOMli4cW7XlLFY@x130>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <aRUOMli4cW7XlLFY@x130>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 3:46 PM, Saeed Mahameed wrote:
>> [1] https://lore.kernel.org/all/20251107000831.157375-1-saeed@kernel.org/
>>
> 
> Hi, this was supposed to be marked for -next, do you want me to repost ?
> 
> The kernel part was applied to net-next:
> https://lore.kernel.org/all/176286361051.3417146.8495442358677824245.git-patchwork-notify@kernel.org/
> 
> 

all good; i was just waiting for kernel side. will get to it some time
this week

