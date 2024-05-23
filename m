Return-Path: <netdev+bounces-97780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452978CD283
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763081C20C4B
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F3F149E0E;
	Thu, 23 May 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuDJf7NO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900813BAC7;
	Thu, 23 May 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468388; cv=none; b=ZVwqCzaN1KFzT7xQ/NuBni60tk3FSI1dI5IoTvZqm1z5dDQv1MXyVtgo+24xFe/XpFyNKW5Gd7IBzjKKtgW+OuWMRVJXuLEDrp2O0NWfTaA9hwPuP3CTeA0XeMpLa9/EJOmKKJO4FYa0i6sLX7EIJu/acWx9OTyyU8i+Xxo9JZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468388; c=relaxed/simple;
	bh=lGMIoH5T46kzO4iwZdsC4s3lfRrC77+eDo7BvVfEl40=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WQTexGHADIIGl3AMZp0VJtlNHLzGEPlZaponojeY8cYL8TPxwcpCShKLrDr/HF/Tws9vFrXbseSLm4ZMPBz9K+NdbIrs7cTi+RhNnVmcI/7PHCLFz0tEDSoePlTYqUrv99PYaK0YUdgWpNGGu/uKL6B753VApOUxNQPf8K9FcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuDJf7NO; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c9b74043b1so3668702b6e.1;
        Thu, 23 May 2024 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716468386; x=1717073186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwfzWJdq4oiCB51H48RHNVbhTyni99WzNeARyS1lZ9c=;
        b=kuDJf7NOGfehJp7IqvkSrLbjnX2G9Uyn3RVhJ1gG3ml2qTRecRDCC8nblUtG1w1JI8
         bljYW6noF+ht8YENBga1G37s4WcZ9N9TVNwQiGFiTA2uNFNtlJbkLA6yhi86PF5iscBH
         C6SmhMc+q2PQVYcXTAnsIhz+iLjyJ8i+3XDTlMqfGaRNXXizfBfmZqFWGPvR33b2orkt
         mtM+uZOVswjbEamaOhJKxE986c0YgokuHH2CyYYLePMh81gMLf2vfIkq+L2DANA6Nb+l
         zkhO4FCjYXpxRiV2nQVtz2yg9quIazf8p4jZdNgKUki/rXCa+BiuD6xVdstZxjGvCf9r
         hpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468386; x=1717073186;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cwfzWJdq4oiCB51H48RHNVbhTyni99WzNeARyS1lZ9c=;
        b=N+vJfH1WCiFBA3Nso3JnLx/5gA0w2IAHDodrfSl6GqyLdjyA/h7g0KfIbt5UFb2DPu
         viLxVniRCwtqjQb/cZNv087W6f/0+a9k+YqIKjFTpHShCavlh2OVoie8N7DIc824tLNQ
         awDpPlrHp/bcVZ4AteX9wLkVXzCNdahpwqVwzlCRMbUqVEFTmemYnCeeaFuzTLY6IQ8H
         65epoMeRzuDJ41KG0IeAGhi8Yz+Q5NJh2oH/Gk3UExGz7zAYRVGlFmiYwnmw+A6yo3qH
         2L8VVKBTPdDR2n9OFEp05krfKmGeQGNRa0TiyBs7VdoSL3Is4sGgLe4sl7KxGqdlD9Ah
         fcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhCWKSALnshoi0X+HCymBoKi80FyWkm9LxliGC3hel6sWYGexzfmEan2eKQEcbes+hc5M2+mIvJs9uZeFRglx9g0PvTbdx
X-Gm-Message-State: AOJu0YyrVKHZc14gdHhGdmBcbF3dROdQaUBzBgVIAvwAP6sH5lwOEo+a
	7uQl8Eav/wsIWJZcLgxpjoqlY5rsIN9UaNXmhAsV+e+AJP6lYWWW
X-Google-Smtp-Source: AGHT+IEWOQO+sHcIWd+UYUki/AQh7qn5PKnlgpaB452QBrdO+T+G7beHRM5noFPXpQvb3P9XUG0IRA==
X-Received: by 2002:a05:6808:3a8f:b0:3c9:6cfb:bf4e with SMTP id 5614622812f47-3cdb1712ddbmr4620982b6e.7.1716468386073;
        Thu, 23 May 2024 05:46:26 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7949cdbb4eesm123473585a.94.2024.05.23.05.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:46:25 -0700 (PDT)
Date: Thu, 23 May 2024 08:46:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "kuba@kernel.org" <kuba@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>
Message-ID: <664f3aa1847cc_1a64412944f@willemb.c.googlers.com.notmuch>
In-Reply-To: <15675c6e0facd64b1cdc2ec0ded32b84a4e5744b.camel@mediatek.com>
References: <20240428142913.18666-1-shiming.cheng@mediatek.com>
 <20240429064209.5ce59350@kernel.org>
 <bc69f8cc4aed8b16daba17c0ca0199fe6d7d24a8.camel@mediatek.com>
 <20240516081110.362cbb51@kernel.org>
 <15675c6e0facd64b1cdc2ec0ded32b84a4e5744b.camel@mediatek.com>
Subject: Re: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> The problem now is the ethtool in ubuntu can't support "rx-gro-list"
> and "rx-udp-gro-forwarding" although it is updated to version 6.7 from 
> https://mirrors.edge.kernel.org/pub/software/network/ethtool. 
> 
> There is another verison in 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ethtool.
>  We download the sourcecode but don't know how to compile for ubuntu as
> no ./configure there.
> 
> Is it the one we should use?  If yes, could you please show me how to
> compile and install this ethtool?

https://git.kernel.org/pub/scm/network/ethtool/ethtool.git is the
upstream ethtool repo.

Since you are testing a custom built kernel, there are other hacky
ways to configure a feature if you lack a userspace component:

- just hardcode on or off and reboot
- use YNL ethtool (but features is not implemented yet?)
- write your own netlink helper
- abuse some existing kernel API to toggle it, like a rarely uses systl

