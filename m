Return-Path: <netdev+bounces-162959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB930A28A3F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BFF1888D09
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534432288C3;
	Wed,  5 Feb 2025 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok0L9gaN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149415198A
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738758444; cv=none; b=N33ftUsZM63WBCvIy+1CAZNqMKPEhHYABu6Ocz/i9dY+xT6wg3sUWlHFsCL+67E900d5dQ0IOgp9OIq4qbh3K+jwteDCCv4VrpnWzogx3LdtV2hqIoLs0vGZgMJSwWQAVh6ohd+0Ev4Sal3AKBxMPvu1Z79F0i4T3teN+Cw1iHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738758444; c=relaxed/simple;
	bh=XqLjJZ++0/1l0SQUa94TZ5y1PCHgIUloI+C+vXmz3ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSansJ9P6R7mu8jrSxNpy/XGSyZKe/noOHsuR4ddadkHKbUp8CSfq6QriXRjb5iVuEWMxrGKzN+Mxtkn+8bTU0XfxrRUvI1NBbgO2UfMgTDe8mA2PxzM51LUCmKaak+CM3Z/SHdV5WBPJOqoLZ7S8KvsMGOUVtB9HHICtEf4skA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok0L9gaN; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e2bb84fe3so3429695a34.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 04:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738758442; x=1739363242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4HqSPzFENlEsy5chp4Yd55VgQkTCEYsx7+yU+3wcmQ=;
        b=Ok0L9gaNpDhdP9RacGXOCipKeuhmR6Q+3NMmOsX+/V8V6De8TydE3wQcjhKM0r2iss
         1L9LU6MTtqvxeQ8rYWKfIh7FCW2HgvBpquy716X079FsmliNsPBlo4wc0r0XwFGgvfnZ
         ZtmqxfG05w5p7DGhrIR7a3c463hMIpXjXyveERBKI4tG/puL57jh7xB6ODTcmjy8PoWK
         gxD54pFgM1kU/PEro1yp9xHys+LKk5BMKtBE6+FPTppHJUkDfPZovqckhCHpERJvqcl+
         iS39JUjQZT+B9UlakTW2YFslHnSvwlLOMQchDIqRHizp2+Tg2kNSo0IyhwZpLo+GwMJH
         B2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738758442; x=1739363242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4HqSPzFENlEsy5chp4Yd55VgQkTCEYsx7+yU+3wcmQ=;
        b=WBK4ih8rImS9R+cmIVWZmaDxvcmBxnunmzaPhRS65h0yK/wA3gLPVoNm8l0xamuM0F
         ACKOfsD2lfHkdWwNNZQh6lkHQ8LiFoT0miTob6OI7LD+wVO3wm7uQeJOxi2es7UeBhuB
         uaziG3YgnHqxQ/dlqj2aJCZL2mfvXnsjaVXDxx+4BAbZcQn11tQumTR8X8mpWsQpsauu
         n6+ZVkSVO+GqA30XIImzZxyxIHEsUKA4FlNlj9nwn6bbNhW63st2PkTwpQd0H4V1EJVF
         jgpyfQofwPpHTcFgU+eHDSZrO9+alUukRkzhZvuxItuVEV4Q6aTKg0cPpcAcil+XxIFa
         nvLw==
X-Forwarded-Encrypted: i=1; AJvYcCUbn6pkTN1a+U0sfOu2u+zSQogpc/UvH+eZYKyLPRP7ztyX4xpZ7i9meOvEu5hVkKgKnz1Cl9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzwtbljo3mKHjNlF2/H3pnEjyNIKOVOVujLU+NuWeoXd+cQ4XT
	1DhLpMn+eJQI79eTF+2FuAziXxomtFhDLOlKkzdSPmJlRgJ/qKI=
X-Gm-Gg: ASbGncuxTOVA7DLWHCziVdyiqt1h/HhI1emOs1rECflQF6E8yIf/QwYe43my5Bjo8GW
	P0vTcaJf8/CPPmSQFySmlc6MyDsiLdQ/4+zg9t9CnByniiogCj1KuT2JY54vFn5DDvuhD01HFFQ
	JeREDZVP+Ax/nahjHSZK6uhrMqPOnA7fHQUKK66F3kD45FXiX2bKi1cZBh63YD3cylTVsWnFkxL
	Rd2sRIrQNuW3qaC55FSPoAv5fnGwp59y1YwKW/5P+FXwhLSLGZbt8uZKcQ5ASH8nyTlwfEnAVwF
	035kKK36Fz5a
X-Google-Smtp-Source: AGHT+IEx29riKQAhXXHTh6lNNpwHXr8s1gMm9N7TRCyf5dViElzOTOXg6+qE4NsXzXEiUkIMBuoBjg==
X-Received: by 2002:a05:6830:6819:b0:71d:5f22:aff3 with SMTP id 46e09a7af769-726a416089cmr1729085a34.4.1738758441548;
        Wed, 05 Feb 2025 04:27:21 -0800 (PST)
Received: from t-dallas ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc104c2e7asm3699902eaf.12.2025.02.05.04.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:27:21 -0800 (PST)
Date: Wed, 5 Feb 2025 20:27:19 +0800
From: Ted Chen <znscnchen@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/3] vxlan: vxlan_vs_find_vni(): Find
 vxlan_dev according to vni and remote_ip
Message-ID: <Z6NZJ7R+TdruVSmM@t-dallas>
References: <20250201113207.107798-1-znscnchen@gmail.com>
 <20250201113400.107815-1-znscnchen@gmail.com>
 <Z59ddOmNCCIlFwm9@shredder>
 <Z6IRbns62vv7eJIg@t-dallas>
 <Z6IhJZR8JacO8oHk@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6IhJZR8JacO8oHk@shredder>

On Tue, Feb 04, 2025 at 04:16:05PM +0200, Ido Schimmel wrote:
> On Tue, Feb 04, 2025 at 09:09:02PM +0800, Ted Chen wrote:
> > I didn't see target addresses were appended into the FDB when an unicast
> > remote_ip had been configured.
> > 
> > e.g.
> > Usually when (2)(3) are invoked, (1) is not called to configure a unicast
> > remote_ip to the VTEP (though it's allowed to call (1)).
> > 
> > (1) ip link add vxlan42 type vxlan id 42 \
> >                 local 10.0.0.1 remote 10.0.0.2 dstport 4789
> > (2) bridge fdb append to 00:00:00:00:00:00 dst 10.0.0.3 dev vxlan42
> > (3) bridge fdb append to 00:00:00:00:00:00 dst 10.0.0.4 dev vxlan42
> > 
> > So, this patch just leverages the case when remote_ip is configured in the
> > VTEP to stand for P2P.
> > 
> > Do you think there's a better way to identify P2P more precisely?
> 
> I think it will require a new uAPI (e.g., a new VXLAN netlink attribute)
> as it's a behavior change, but I really prefer not to go there when the
> problem can be solved in other ways (e.g., the tc solution I mentioned
> or using multiple VNIs).
I tried that the mentioned tc solution functions well in my required case.
Thanks a lot!!

