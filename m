Return-Path: <netdev+bounces-197929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C6ADA64F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 04:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB6C188D2F6
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 02:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30217A30A;
	Mon, 16 Jun 2025 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjL2ILdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41102E11D0
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750040748; cv=none; b=fn0K7Oak9CObNABNUTRWuIaG1SyCQjTZv5Evv81p0f0ZzbNTGrHU8OeEuOZ1la1Y7Hrs4BaIugiGJUQeV7YFCM7qGG3uBJvExK1JUa/2qPNn+ZTFkqaW+dryvL5SfqmZcIwHhNPnvwgdUJx0hwnLKlIeA4QTHADrgINrpDasdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750040748; c=relaxed/simple;
	bh=yeFyrQM5AEph3nqocW9/s3/siGve0QTTes0vDmiTWpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewiDdeO+bvYLozH3/xWZhGgbVR760JTfecTRTKLhmi/qtlJIZM0JGIaPiYNFEHSCfNhMBXGcITlbrU31paBmyE0OPsHkAJ5VqtkyHrtiR2pSCKVoJHthfGUHPVaQF1As5mr6ynXn2JXwO6K/tIoJKQlZN5PJfmzvsNuRd/B9I84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjL2ILdj; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ddd68aeb4fso37840025ab.2
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 19:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750040746; x=1750645546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BgTgVNhQF2E1TeVy3ZkzaWAE3nckokq6BK2WDQTXKws=;
        b=NjL2ILdjsN0FWSD6k+T+WIq3wU2F5MAowF3Oplig5fzew2Mzmg3YKufVqpXGrHaTRH
         /CuIN4QhKwaCQrW8A8tWk+1oRKxLBZrpuKMK0Et1v+sr9+63LKrikd5CVvrfmPe8a+sV
         hIeSNvtgCHxDs9s+5LuUsWP4sB4ehivJOAw0M+hD/wBxm1rUrStYoLUocy2ZQ06qvLK3
         j+YIqOZCpTvwlWKjY3ye6RLOijMSuahzinHQG9RJZnZNexNl8I/TCJz9YrMXLr6dB4CZ
         SrHZScFzpa8A0sT1ZDxEeMoFRjIdbZ/F7U/l8NhJtGWGB/42/NYeAlsWFys90E65UOp/
         QzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750040746; x=1750645546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BgTgVNhQF2E1TeVy3ZkzaWAE3nckokq6BK2WDQTXKws=;
        b=fi3wyZw5OFLqTrzIb5KbEY+r1WHt18g0aIKQC50qg8B7Ej8qJRRwaAIKa7XiZqdUgi
         7h0I/a6tgfQsk96Vb60FHFDtWBnd9SBBKl6vEzP+De2m1bFpWXa1Oq8Y14uOBj5mH7tM
         f347n6dFLUEsPLLL6sBwBIcqn+rt2IkbzXmm7SkvQnVPYxJQwAtcB0KaQx+zCix+PyHX
         uAjh2VdYCca13bNIDlsKtpxPt38KypKaLmpjlPazQBCvhapr5ddsOuZ9QttlQ5C9F3se
         uuWSWFNT2nciqT0MO4rQwLuTZ3KRMNPRrzhWq1JSqpT/Y45M6ZpbXhUl+NRzBl7+oZCQ
         frYA==
X-Forwarded-Encrypted: i=1; AJvYcCUsT4dCxzfObeXZ88vtQpewH1YIAO46XerbYbSR/EAGuJ1AnfuXz3Xs5JT9Oac1yG63MML544M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMT7d8hTk+8uxVvIfDJo/o/W6l12K/z+MP6XDp7h6b8N+ulZKe
	rIps0zdpMll7RfeeEp+a81HG0r8uzhnQWClx6z4KU1wTMVvTqC/4a6k3Vu51xsPt
X-Gm-Gg: ASbGncsmuSo0/rSLlL5ll3shOybDVy6UfJMu8EHrrjaVDw3xVSZFbrKBS2xPsCbjRf7
	bpFcqHbOCC0buzz97UZfZcmC94u3a+/AzZxNeE/GOvEXJerqBWTentbkWr+2F5ShI70zgAW4tgb
	22zsnrr7/VrafAKPNCGdBnVaOpWsdwjO0K1WcfwMNaX8OFKMM+UOcSHB0MuaHmWzyN3MRhZKVoo
	+DppkkZ7/A6X3bXPaFGKTFqBzQvyiFggpfg+u1TrvdPA63ERMVfz1Gh+1cLNraG5utQmWnwHiLo
	qSVxfhdBffZS4ZAyEyxF62rff84qE46iy6vv5wzJ6+8t7orJGGJj45o/nMdjhnQBovEtKsfRm5b
	rPtrQOdBBkM51dvtWP6V9WCF+2yIvKvlq+RCZLmuO2hDPlWzO40d13g==
X-Google-Smtp-Source: AGHT+IGesun+N2Fm0W/s40zUYMzKgBFnhl5xqVFUClZW1BUYLIvQHYcLL4mYPtHcTXUmtHHTDYEoSg==
X-Received: by 2002:a05:6e02:1a8c:b0:3dd:9a7e:13f4 with SMTP id e9e14a558f8ab-3de07c50279mr90766025ab.6.1750040745920;
        Sun, 15 Jun 2025 19:25:45 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:7db2:1a95:a8bb:562c? ([2601:282:1e02:1040:7db2:1a95:a8bb:562c])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-50149b9df11sm1531147173.54.2025.06.15.19.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jun 2025 19:25:45 -0700 (PDT)
Message-ID: <d38ab6ee-cafe-4981-9e01-19c7b5525847@gmail.com>
Date: Sun, 15 Jun 2025 20:25:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3 0/4] ip: Support bridge VLAN stats in `ip
 stats'
To: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org
References: <cover.1749567243.git.petrm@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <cover.1749567243.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 9:51 AM, Petr Machata wrote:
> ip stats displays bridge-related multicast and STP stats, but not VLAN
> stats. There is code for requesting, decoding and formatting these stats
> accessible through `bridge -s vlan', but the `ip stats' suite lacks it. In
> this patchset, extract the `bridge vlan' code to a generally accessible
> place and extend `ip stats' to use it.
> 

applied to iproute2-next. Thanks


