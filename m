Return-Path: <netdev+bounces-97826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11A8CD644
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45840283E6D
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C255538A;
	Thu, 23 May 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWZHyph8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E124428
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476173; cv=none; b=j3O6k+Ajl+TVs8ae4/y48UAfs99sJzd+cQcVrZT3XfwKRP7e8fzgwzWdV28gWqK1dk/HhHdlSkxpHQRn9sXdXECSOiNP+O9KFhuQvuve7WB7r/wIY7M+xN5A4D/CjkQUrSFsBvNkni2pJLUV+7XvNReBfw3wAQpiWJPnrrCgCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476173; c=relaxed/simple;
	bh=1g9By/Ki/GssaDgNBFBcK8MtxIyzUQ98mMwiLIKul9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5vf9ttT4pm3t119OJ+0IvP/13bpyo0Q2Il8uFzLZseFBb5JEUjrElvRcIvqGDAYWgXz6sibsz9ZP9pscL/z91TvRxf8D7DXQCq+R8fbZwF8GpDImBZhxPRYVl3jdIh0XXg/DlPg52jSr7INotJsjIXG0QVdwgMtFc+AzBmQxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWZHyph8; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36dd37767dfso14119895ab.1
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716476171; x=1717080971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1g9By/Ki/GssaDgNBFBcK8MtxIyzUQ98mMwiLIKul9k=;
        b=hWZHyph8fckI+imr8NhUoVacTj82VMtpg+wA2lhuq4/NbAlCIqycpxQJZaVPbSA635
         gRyLMds71qZKivOFh3P5iQfFR8dRB98C0XBgneTrw7nwG96CrLgOVodLYMhErZDd6rLO
         y+PnMjD7coJgWy3AjrjhNSa6yBgmWzIaSTLqg7m7aYrDW6SaDR5aK6hjrnsVQTONjbHH
         SX2NPiKRiC8vz3QBSrf88yWdOJGvK5L7i6B/qzIkarJMZlIk3r3VvCkGZqq+Jbm98qoo
         VvtzS2L4kNP9NOrMztmXZcgkAUwkuh0qZhDyrN3nlpNzqwArvUGMhRddDn5zvygkEMPw
         gBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476171; x=1717080971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1g9By/Ki/GssaDgNBFBcK8MtxIyzUQ98mMwiLIKul9k=;
        b=DrOENfAesKJy631xK0LQ8/y4InEefcpqxBYx86yAWxaiuEaajTXDF8ZNLXaIF7QJ43
         to0NWNxOEB2EB0hSJeOtWXY6G2SDlEtM1CuN4OJxP36Icpc441Vw2YJfd5+IfgyqISsh
         DYeliLI8XwHmfkwwQJnKWtuAJ/2y21APYc0x2Yjy9em0IocANoDg9FFbzSrYzxv8pcA1
         Nk8bO9RlfVNJbasU2rUjFT5lVHyhaIVlKJILMF8+L0T3jeon7lOlLsG4l9DYZ+GbwPa8
         TityKp7f7dvatMjOk+ugUNW95h/QqYBXOZhvZw8QQLDvGaQOVx3/mu5hECroL+vTeADq
         mScA==
X-Forwarded-Encrypted: i=1; AJvYcCVcXl4YYkt1OaVE/+tHdfC3RV8LXunY24vwrH7oyaLoSrMNOpttYFckj59RAw6nKsuRsN52G54MEosvxd949RrxChPFK3wt
X-Gm-Message-State: AOJu0YwsS2ldSFJjboQNrUgDa9i+uNHc8rBSe3ai5j27aDLd7Ut9BJ1M
	iqH+Xri3+ylhbzbdyBKi8DOrApMa7PeG93IJWATf6OChHRBItQ2U
X-Google-Smtp-Source: AGHT+IGtsOHgStkNl8H544mgrtVZnHAYvefGN7p6ICwbPk/1bo9nzBLQKQvS83qBlHOZJkeeZ4LqRg==
X-Received: by 2002:a05:6e02:1d98:b0:36c:513c:e7f1 with SMTP id e9e14a558f8ab-371fbb110b9mr52834125ab.31.1716476170627;
        Thu, 23 May 2024 07:56:10 -0700 (PDT)
Received: from ?IPV6:2601:282:1e81:c7a0:5108:8443:63ed:1abc? ([2601:282:1e81:c7a0:5108:8443:63ed:1abc])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-36cb9e222edsm76148275ab.87.2024.05.23.07.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:56:10 -0700 (PDT)
Message-ID: <f5d0722c-0608-48bc-9863-eef6ea21b388@gmail.com>
Date: Thu, 23 May 2024 08:56:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC iproute2-next 2/3] xfrm: support xfrm SA direction
 attribute
To: Christian Hopps <chopps@chopps.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Antony Antony <antony.antony@secunet.com>, netdev@vger.kernel.org,
 devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Eyal Birger <eyal.birger@gmail.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <cover.1716143499.git.antony.antony@secunet.com>
 <3c5f04d21ebf5e6c0f6344aef9646a37926a7032.1716143499.git.antony.antony@secunet.com>
 <20240519155843.2fc8e95a@hermes.local> <m2y18242oz.fsf@ja.int.chopps.org>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <m2y18242oz.fsf@ja.int.chopps.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/24 3:26 AM, Christian Hopps wrote:
> I would think this should be a different patchset since it would be
> totally new for iproute xfrm, right?

yea, ip-xfrm does not have any json support at the moment.

