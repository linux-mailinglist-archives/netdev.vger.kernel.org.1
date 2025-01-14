Return-Path: <netdev+bounces-158045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F05FA103A9
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DA166A78
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF92309AC;
	Tue, 14 Jan 2025 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne0ksYq6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7F1ADC91
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849352; cv=none; b=f11CEMTnhK0yK5alB5k/Gc4LPw9G+ws0rLtR0As/kWyserDxsqr4Ok9xDvrGpAiW2t1XzjICTAOBZQqV7tLLbpEHPA++1hKc+Npm3Ye4lT52yEHguTb3mML/HVyW/KKDt9UI1e70yAmm8FykZZ+nZ1fsRrFObxSjX7WJMyCzXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849352; c=relaxed/simple;
	bh=XcSIevRn1/EjW1X8ukzXZDS3TrhR5umTaWKSdNYpZRk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y/5jfhamQQFAFjtHc5EyubToeJNrJsxKXI33U86WjUC79HOANa4vguyw0bHwzyEAG8XVyngZUn35X2QGtY6m78+tnazy++F7nUvIm0L6SD+Lte9c1YIZQYECW/Y7w3VftsZULY0j5h2cMYlf0MmezN5DNcE92aqX4siyy16bUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne0ksYq6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so50394625e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 02:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736849349; x=1737454149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s04pYJOuT/V48BFocXvcRd3UH18Id1C6p/Sv3sRqQH4=;
        b=ne0ksYq63diG+QJUic9PORXcoyU1kAXZsyxxDPGqyvytr4dYIiXj6PvAtUlFcX4AtI
         gbjNQHn6jYBmAz3CcnImZRtu7wn8gs/M8PouC5udElgb5EwqQ/24pokCLTG/lYsepnxM
         UiUcWG2sTpwozVfN73njpDE+QCZPYiMjSoyucoLW/DUgvzKEaWtcGaxrI1ekt/THaUuI
         aYLwxJKvQceMkFiAMAuosun4Jy4I29T5gtPCN1YVEYWDPa5qGiEHNIXA+0IYoASZVVMJ
         /BiFNZMzLmashh7nUtUas12DMjjF+AXmAwsD9QZoIQ/EW6hMowfMZj/d+R/MVR9rIrGL
         smSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736849349; x=1737454149;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s04pYJOuT/V48BFocXvcRd3UH18Id1C6p/Sv3sRqQH4=;
        b=bk47fsAEyVU8C9ochzNowHFx5yUE/i2Nu/55mvhnoUWhP7iathnsd0d9MQwmmOnLZ6
         QaLasfzTfY1I9F6cCqRy1Eetxh0TmKOPv2weyqPoNoYvqidpiRt4GQWJJW71xj0sxchC
         /U+mKxCI3ghJOwHB5wffykrolJSarY8G0sgVnhlTPmzx3DEgJJbv5rl8VmkL48WaZ9J4
         blaBOPgiGUc1Yek+hJMEz068mMzoA3os72JiWb6yETwmdmjuwMdI72h+yGQ+n+HFIUVy
         HFmjHnY4Pz3NoTUMUMyyVZC5x9cmUwEUtWvunpfFs8piLn8H3uPwiLK8FAd5lheZ9HOK
         g0qA==
X-Gm-Message-State: AOJu0YyWWiX89BThrk9W4Miff0sr62au8pziF01KrtMAHLRTQKI2kVpt
	MywJOCdjOae1sZ17UgVUxWpfv7xaa1DtBQ7XcNt6bGCVoJYEw4kpdOA8Jg==
X-Gm-Gg: ASbGncu17xydBXY7r1tnyOKxguKfj4ltr7XstQg071Lr5vJlgSbi7RxyHG2SOhLVZLT
	G4XCrIrIAmrKwyQxTsSp5PY53SnlSKoP4FufiVviln7v4v1WY+JOPVOMzOGwdivB0XhIhadBqUR
	BtF6S5igZtQ0GVCsBpgDzFWLHmHFHOmpzAygodLvLhqHUUiGI0CfL6AlfnUZ+gyxQwDyJb8qAdz
	07JqpWTx7uQlK/sOlKJUm0MkrOwP0c7vt/IGeGHOJ4v9+b8XNTmXoB1LobW6NlLZWBaavSxTleJ
	lizAmGesg5ORmWRxE+TnO5A/IxRLROzz0uPRhAsdMkn3
X-Google-Smtp-Source: AGHT+IHzO163od/zKZCudB8ElSIOI0K1lL9z64fXkWgVrK6gHz2ERtJqDlTszntgPT7i6XbUYhMJIg==
X-Received: by 2002:a05:600c:1d1f:b0:434:f99e:a5b5 with SMTP id 5b1f17b1804b1-436e271cf4amr179466685e9.28.1736849348354;
        Tue, 14 Jan 2025 02:09:08 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9df958dsm169154425e9.17.2025.01.14.02.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 02:09:08 -0800 (PST)
Subject: Re: [PATCH net] net: avoid race between device unregistration and
 set_channels
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org
References: <20250113161842.134350-1-atenart@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <8a1835db-b72c-4e9d-64e8-0bfffae2d8c8@gmail.com>
Date: Tue, 14 Jan 2025 10:09:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250113161842.134350-1-atenart@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 13/01/2025 16:18, Antoine Tenart wrote:
> This is because unregister_netdevice_many_notify might run before
> set_channels (both are under rtnl). When that happens, the rss lock is
> being destroyed before being used again. Fix this by destroying the rss
> lock in run_todo, outside an rtnl lock section and after all references
> to net devices are gone.

The latter (refs gone) being the important part?  Doesn't seem
 particularly relevant that we've dropped rtnl, this wording had me
 confused for a little while as to why this closed the race.

> Note that allowing to run set_channels after the rtnl section of the
> unregistration path should be fine as it still runs before the
> destructors (thanks to refcount). This patch does not change that.
> 
> Fixes: 87925151191b ("net: ethtool: add a mutex protecting RSS contexts")
> Cc: Edward Cree <ecree.xilinx@gmail.com>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

