Return-Path: <netdev+bounces-89063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C928A953A
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72381C20D3D
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC67615534D;
	Thu, 18 Apr 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqDBM1RM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE12E403
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429840; cv=none; b=TaEbQUyUAGZ+PNAyRp/eFBHZULyGnUQKSBycJKOqnctAz0NzVurmF6qBTINJ8ZJEnCTHMkMu/UCL10/i/dexx1PbwEiW0HGWH2ip+EH8sF01UmsCgKZBM/gbo8HFpBfRQQ5WpprXeexsRgfl1paUe14bhFn+YUHV5sDmZYgFELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429840; c=relaxed/simple;
	bh=M0pqY03giSoVWQJLwRJdyz+VqHm1gJ9R7OHry28YfxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uYjLmvyxHm9XNUxTeTTBR1oIuzy9TpeoYACvjsy302wlF4LfT9uvmhOj961Kiz+P0iv9tL8YNH1JyJYTcPTKfwe2C0rJ40cGei6E0rJPftethmiS2ZDkvV7RwZni5+Hg1N9Ohw394t+amcNmTHB7sk/C7xjEdau1cDBgYK4frgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqDBM1RM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713429837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hH0KlyGAwY6muyn3zO72F/b5aBGpWFeE01tortR3iN4=;
	b=CqDBM1RMIBbyTIQpfuh8vOAekTTRmsYnzWHM+q5c1Ss3bmEScKNW/IDJgUB1ywzivAFR4S
	UDyU6yxNYl5yHQfVnCQYwHfHYUpLS+KHwTYmcIcdSKsm875bpJluBTkfrnzXdODQoBUXLi
	vBMPM71zgLBWYav92nnEznMnflYLLB0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Ne7AcNMPNGqdVFDVdcNS5g-1; Thu, 18 Apr 2024 04:43:56 -0400
X-MC-Unique: Ne7AcNMPNGqdVFDVdcNS5g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-346dee56965so26335f8f.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429835; x=1714034635;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hH0KlyGAwY6muyn3zO72F/b5aBGpWFeE01tortR3iN4=;
        b=flHB3nHBocE5Osi+9mS72imJ/2HKRnEQZfSHtay7ryhUO3Mc6UObci2nalVi9U8rsB
         jzZmfXBW3vq4I+nWYqqobsXrqwMYR/jdRA58X4dSa+WZmvC+aGvhSX9g4B54Txwp1h6w
         pf6quuuZy0+kk134orrYasHdcX0PHm2DCVc4Ov8QyKkpvfGE39YEW62ij+t3eClucTwf
         7XuOUos6/8lqzqHTv+AKMppx1kDxWj/iw2xEILg6X3/X6mVFYFZgVu1/qDxyrPQ7G8F1
         pAgPYzqeecQtodmWT2jXUfG6XI17ozKp1PcqUN17anBqcKTmDrKGjk4WpCUK3cROmGol
         MWbw==
X-Forwarded-Encrypted: i=1; AJvYcCXa7pD2YONhL6LDE3GWXmR4u3AGwiMcUJ/tAFnsV4FBCk6thNNz1zO+UqtlhDQfs3aJPHuy7i8xv9//rPHGE6BGkHuaEfF/
X-Gm-Message-State: AOJu0YyIUyR6xkIVnCFIX3uiXSm58tHHC9wZ6g3jIfXgboV8yu+Lwlwb
	uoo7G8O2jfQ7fcravYrQbccoU/1LGR6kRazWCyK0C6gxi+vuAOlAK+ZTFLwiU9MF7js+5wnkfDz
	8xKHqEa6VyNI+OuYe7eNz7mYr6vvNwBv97975prVlok5cmxZ4KDNUPg==
X-Received: by 2002:a05:600c:3554:b0:416:7b2c:df05 with SMTP id i20-20020a05600c355400b004167b2cdf05mr1418785wmq.1.1713429835237;
        Thu, 18 Apr 2024 01:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK+D+3mE5uBVWPtkZZRTBpgBEjyrAeFfgU5tQxnNndN3O+YqpL4ymjd3ZGwtz4ulur8/+c2g==
X-Received: by 2002:a05:600c:3554:b0:416:7b2c:df05 with SMTP id i20-20020a05600c355400b004167b2cdf05mr1418776wmq.1.1713429834851;
        Thu, 18 Apr 2024 01:43:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b00417e36953a0sm1912220wms.20.2024.04.18.01.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:43:54 -0700 (PDT)
Message-ID: <001b07cdcd22ce7873ce5e160000fe9ad1d59459.camel@redhat.com>
Subject: Re: [net-next PATCH v5 4/4] test: hsr: Add test for HSR RedBOX
 (HSR-SAN) mode of operation
From: Paolo Abeni <pabeni@redhat.com>
To: Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,  Oleksij Rempel
 <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Simon Horman <horms@kernel.org>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Jiri
 Pirko <jiri@resnulli.us>, Dan Carpenter <dan.carpenter@linaro.org>,  Ziyang
 Xuan <william.xuanziyang@huawei.com>, Shigeru Yoshida
 <syoshida@redhat.com>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 linux-kernel@vger.kernel.org
Date: Thu, 18 Apr 2024 10:43:52 +0200
In-Reply-To: <20240415124928.1263240-5-lukma@denx.de>
References: <20240415124928.1263240-1-lukma@denx.de>
	 <20240415124928.1263240-5-lukma@denx.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-15 at 14:49 +0200, Lukasz Majewski wrote:
> This patch adds hsr_redbox.sh script to test if HSR-SAN mode of operation
> works correctly.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  tools/testing/selftests/net/hsr/hsr_redbox.sh | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100755 tools/testing/selftests/net/hsr/hsr_redbox.sh
>=20
> diff --git a/tools/testing/selftests/net/hsr/hsr_redbox.sh b/tools/testin=
g/selftests/net/hsr/hsr_redbox.sh
> new file mode 100755
> index 000000000000..6946a0c6eb17
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/hsr_redbox.sh

You need to add  hsr_redbox.sh to TEST_PROGS in the net self-tests
Makefile.

Thanks,

Paolo


