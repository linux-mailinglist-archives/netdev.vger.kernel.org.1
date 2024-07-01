Return-Path: <netdev+bounces-108074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5891DCC4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AEF281850
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091213C3D5;
	Mon,  1 Jul 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="GN5LcITj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DE12B169
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829679; cv=none; b=bzJ+p9NOuW0ql2JeMNWKkfY/sQQTdJSqVUbWooVhHPwYkmC3fDjMU4Aqen5yXdvfbzmltX8XJBZZmeJ54jadaovnGMKhXeDOZcM5FAmSm5umXxDx0+fXfHwFq+JfLv2mxupg65jYgIhZ3jZ0PMdKi381jG/Ld7JXH/S7lTH3R4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829679; c=relaxed/simple;
	bh=1JxgQGkLSclHyQYAw1ULg+W2FRvg0av+uQnGJX79Z50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcMF2ncWcvVFvzks88KFRhpVcZfR+8Oe9hecx5Thmcht+SdF+TFXTr+xkBnEFdnnkHKk4gw+UZ+OlX1Yi7QfYz3Al6ik4vclznylsf0K5EIShJryApzj22s68bofBiiNZywSHZELMEwsxfoFfEn2I5jjFIHr8LkRAr50buPbn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=GN5LcITj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d4ee2aaabso62614a12.2
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719829676; x=1720434476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oGs6VWTx/CKsPEiKjuFm3FYUM/k9K/hMgueppu6Ppc=;
        b=GN5LcITjveRViCST81FJNqfWKLugxfIE9jFz27t+rXhT7lvXVjO0wwFvYWECoy3iO8
         s+jtc87eaq1VN8zpPohIjYDwq0BDsZjaI1eJEUrCugC9kUXEQl3bGLOWfzjjgZ2jn8FJ
         VasJ6CiNc39JdV9yXQ+ecc0C8XjJQfooumXkEbd9Fi0eatA5cykZV53H8JS6W2d+ZehC
         bccRKhl5OyWwaUd35DK18XpLkZ+NcoSn8Ni7axLsCbcwbkUw4QmwcnbGJLKWOpzYBd+S
         qi6wwbVOgsaMZRA70f0R2cpMx3YIuH5NcYPnz+95Anb1GSRARD1VQr6MjC/SHfJ/FTtE
         bXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829676; x=1720434476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oGs6VWTx/CKsPEiKjuFm3FYUM/k9K/hMgueppu6Ppc=;
        b=onTmOXg0wAX6Sc8VrYknUCQcqR/bdclvLpE5xwNpHBIsTtB47CNMn4uJclzJDsXq4H
         eaUBcNoNW6PsvUw628ULHVer8akZAnnKzavVcJ6fBEvxYth8M9DyDfK3ttFOyd2rctPt
         keGZg8onG3Bs3HbmYH2yOFR1IdmMKotpGjvPGCApKQp5VfCFOrRfe68tDHthR8Fp/23N
         lrTQjvQVohNHbNi5Jb1Dt5RoF1RTHJURBq7n3RYoJ5AprPDwgW0VsYNhwKAdlGspSODc
         JVdEA9i+dxRVgPGf0qD8t9c8cqABCThsGAC3H/ZNGVjHAZAZpaeKYufRExZ0OdxQSEuf
         TkHw==
X-Gm-Message-State: AOJu0YzTydiNDUXiw7iGTHfjGAUzB5RZbLh3+yKrajdO8lyY6ipANk85
	k9Sasc7wFy2puxAuiqMrQCz4Enoupba+IQwhRra1M+SmslLChYTeRgZ2zHUE/QQ=
X-Google-Smtp-Source: AGHT+IFvrHkubZD6k5qIyvp8NRVvbIW7ckppYNznV2QN5jk40Xog2tn6mu2UO34rc7puAXuZuh0SCA==
X-Received: by 2002:a05:6402:2750:b0:586:6365:b3cf with SMTP id 4fb4d7f45d1cf-5879f59bbd0mr3130589a12.10.1719829675778;
        Mon, 01 Jul 2024 03:27:55 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c835adsm4217982a12.17.2024.07.01.03.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 03:27:55 -0700 (PDT)
Message-ID: <ffa1036b-fee0-4e0a-bb5a-791ff95c7142@blackwall.org>
Date: Mon, 1 Jul 2024 13:27:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bonding] Should we support qemu/virtio for 802.3ad mode?
To: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <j.vosburgh@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>
References: <ZoKAt6ZkoCR2roEx@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZoKAt6ZkoCR2roEx@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/07/2024 13:11, Hangbin Liu wrote:
> Hi Jay,
> 
> Some one propose again[1] if we should support 802.3ad mode for virtio driver.
> What do you think? Should we treat the SPEED_UNKNOWN as 1 or something else
> in __get_link_speed()?
> 
> [1] https://lore.kernel.org/all/CAJO99TmB3957Wq3Cse7azgBxKeZ2BV6QihoyAsjUjyvzc-V8dQ@mail.gmail.com/
> 
> Thanks
> Hangbin

Hi Hangbin,
Because of 802.3ad we added:
 commit 16032be56c1f
 Author: Nikolay Aleksandrov <razor@blackwall.org>
 Date:   Wed Feb 3 04:04:37 2016 +0100

    virtio_net: add ethtool support for set and get of settings
    
    This patch allows the user to set and retrieve speed and duplex of the
    virtio_net device via ethtool. Having this functionality is very helpful
    for simulating different environments and also enables the virtio_net
    device to participate in operations where proper speed and duplex are
    required (e.g. currently bonding lacp mode requires full duplex). Custom
    speed and duplex are not allowed, the user-supplied settings are validated
    before applying.
    
    Example:
    $ ethtool eth1
    Settings for eth1:
    ...
            Speed: Unknown!
            Duplex: Unknown! (255)
    $ ethtool -s eth1 speed 1000 duplex full
    $ ethtool eth1
    Settings for eth1:
    ...
            Speed: 1000Mb/s
            Duplex: Full
    
    Based on a patch by Roopa Prabhu.
    
    Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

You can set any link parameters and use virtio_net with bond/lacp today.

Cheers,
 Nik

