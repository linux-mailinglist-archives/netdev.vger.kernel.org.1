Return-Path: <netdev+bounces-116165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 163059495A8
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470D31C2132D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C73A268;
	Tue,  6 Aug 2024 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcVQopZ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A93BBC1
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962269; cv=none; b=n91I15BiNShTYHxeb8ov2IrG7Oyj2nm3wRMVKM9J8OUdBfl9Yndb+Ita9Ra/nZUD4GuaYHCc03qjOeVuAfS3ky1kpQIlwFYjSHKxCfH0G/03D2XHotH4aaElssQ1vxeoBe/484yIfzUJ66vJ77yuLMqWz13seNXuQVn1h0Bpmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962269; c=relaxed/simple;
	bh=0ymGuRei7HsILIT+/h/kfDdzxsYZv3svSI04wCce1ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j8bVfawEbh+kuOD9maSFCDCKF7KGoyNqkHWGNd/bl8pmxmeoNPeVpk0asDyrxtwuLhPoPeXNcw9td4rPQ5ddULUVaOvF/rz2UTxc0KUrV6PsEBTHMOlWDqstHdeF1vehQyO6fwBvJpTooOSBmImjZBdAgtj4HSlKtJXjjBtMuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcVQopZ8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44ff9281e93so4036021cf.2
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722962267; x=1723567067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HePzbHogrEeR5rgK0gNA+aFvV40AMbvFpi1R2h6OjF8=;
        b=KcVQopZ8QVOqGSRoa6NcKOw1MUGzeapDueduj3oukTbQhVclm3qt5gnrYeGXNmLyxT
         Gy23jVJzpIxt8izQ+TWFebqsRYivFNLoYxPuZ4Bp1rw/uU6u0S+xsMvUT/TBNZFK/JjL
         7t+2MRlnaSG8oQAhdoHsl2h59J0oRUBF4yeeQa1eftwqK+UhG0x5ppaQ2VfGIpYLmM9H
         aXrVOCeJvjCIYtfBKd1V8+C7kG5fIioxyvtmrdbBRQ9O5HWbzMjrglW7Awe0jO/DK9X2
         s+HMCF35Bx+C897PFjHrvQ4kYHjCUyyEnSDYfaOGQCdC2nuwuNwjQkOnTSbCtewWBIl3
         kvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722962267; x=1723567067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HePzbHogrEeR5rgK0gNA+aFvV40AMbvFpi1R2h6OjF8=;
        b=fBHgHIXD/ZTrVc52rdg6fy+DKH4GFSY8J9KfzHGfbdf+2OboWvqTXSZZaGK80rehdX
         mkrc/npG6mWwbF8BuvoUgo1omyXPFw9VR9IEmmQe4fPrIh5aFkFTjS3CPFx+WL9n67OY
         aLzwBT5AFNrn2BQXXO9UrSV5cYIPfNnP1jvLPawp2IVlJMHMUm3tBOinUL6mwAAuTJej
         t20pYCN1ldNxw12GEw41JQ6CQNkXQxzU7Ht2HoGzUPWC7EC8SHDp8aTlbdyoubjnR0Wd
         6w3ZH7kmZX63DJ0pL7ZBm+c7u3idQufUmJOQ8e2hi5gYbQpVs4GwpcF2Gx+NtV9bbgix
         YnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxEPS3xDXe9yC4D744k/oCJVxO8VIDh2Xos0kP424M0Azx4ZCJ2JbDQGiykjNcIQf8YAw37EZd4LnxAdu9tgK3z59vHSfz
X-Gm-Message-State: AOJu0Yx0QUZCIYpp/n7GhyBjBvSsO4n7hD3hZVbS3lqPtW2Z9KPzmxXs
	BO1MgGCZRcUFPS8nM0MDqx1OZ6w5YBmjv7V3DV+bpMLtaOpaFBgu
X-Google-Smtp-Source: AGHT+IHSYSKtevLO1kMcEb/5TecUqEsXsdv4G+QFrY7dyCIm3VKcKiP0mTw7FJGQbqZOybdeU/6gFw==
X-Received: by 2002:a05:622a:180a:b0:44f:ff90:b153 with SMTP id d75a77b69052e-451892a9439mr165053661cf.38.1722962266933;
        Tue, 06 Aug 2024 09:37:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4518a6c3daasm39301071cf.24.2024.08.06.09.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:37:46 -0700 (PDT)
Message-ID: <01a908e7-d2bd-44c0-8705-b480b91412c2@gmail.com>
Date: Tue, 6 Aug 2024 09:37:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dsa: bcm_sf2: Fix a possible memory leak in
 bcm_sf2_mdio_register()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20240806011327.3817861-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240806011327.3817861-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 18:13, Joe Hattori wrote:
> bcm_sf2_mdio_register() calls of_phy_find_device() and then
> phy_device_remove() in a loop to remove existing PHY devices.
> of_phy_find_device() eventually calls bus_find_device(), which calls
> get_device() on the returned struct device * to increment the refcount.
> The current implementation does not decrement the refcount, which causes
> memory leak.
> 
> This commit adds the missing phy_device_free() call to decrement the
> refcount via put_device() to balance the refcount.
> 
> Fixes: 771089c2a485 ("net: dsa: bcm_sf2: Ensure that MDIO diversion is used")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


