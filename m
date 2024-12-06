Return-Path: <netdev+bounces-149656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF29E6AF5
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261971881F70
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2F1F9ED3;
	Fri,  6 Dec 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wWJIk+lk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C621FA254
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478303; cv=none; b=sdtbvvxyZOdMeDi6bS7rO0qSq8U/NZPV9u8MLAvwr/yLY+LenpEag8N7s6usY9h1OlvAA3itLJ5RNClaKl18Tmycp7kjrRy1RUjQDjak3/lDMHcYcK5EG8ZFtsj1a0YtC7JS76KPJGaoGfxxMWfNLdk8bp60xWuc0bnGzKe+ofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478303; c=relaxed/simple;
	bh=QAHcjiXMcGCYMWRi6b3jIZTIWCzCmJfmJyG5xdDRTSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u891oeLwI5XfmhK7lee+dAns6Qmgwo1J0EzIRh1yoW6VEQOmuTmuqIFIN2wMjqxK49Ip1fsAJ4YC44fmzoi0HKqyFJcuTwQ5gtNcKoI+yRZ7Njqeos1yha6Xxb4RQs6x5s+IZZce/0//y9S0ZBW/U7XLiNRwRZMD8zAHxrN1P+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wWJIk+lk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso201522666b.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478300; x=1734083100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ti1qdDktUYvdMf8sBoP76e/SiXinmstLE1fHCLSggDI=;
        b=wWJIk+lkwPnsBNH5r+uOFrODQo7bDxjx+vFNo2RlnHiDftgyz4xa05v2qWIOGar620
         C0tcqhmq6SZstWqMQ83MzIBoN6Ewi3U+J4mA9srG6atxIOjstbKX/o8gsnh/34xJymy7
         9RKcsp+x11+4iJpPoxnxXM0VONvuefRGcAGiz9j3sKR2si+IQ+xh7Zyo4TB7/O0RcOCF
         bU8QlUrzaSJUnznRbJGq17onXJv0UZ8Wh1OciIGxiStS9X4LGG0fnf/lw/ZSp704fOHZ
         EX0hUFDhvq5zkHZz6l4hMpWvCOkBvR4QkW7KE8bZ1hBD9bMntzEuVI+DEKKZE/Ao4RtV
         4iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478300; x=1734083100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ti1qdDktUYvdMf8sBoP76e/SiXinmstLE1fHCLSggDI=;
        b=t4VKQVxilC/f7uVrNmr5/wllbqwwWlAzvV20KKhFyfA9FDouzhAnv8Qzyjgqcmj0gp
         qjlylIrikPoORDbF1Q0TTO3C5qU188XHS6MPMZ1fBRrA5zslFeVYNsp+OX6+jD6XAtsP
         WGtPqiZUV75HY4LqTb+rpQ+ZzptweFUw1j5hxdVaovrapJQzXJFGitTLMc+/fySUR2Ky
         5bVRI4A4ynQGZWVrrBDUkdVYoxdSq+lT0takbhpsXuT1RlT4dt9tN8nBpAqxJaShSpN/
         NsL16eDZvIMH7K0IdrqadydklCz4NX7vf95vbD1mlEBIEgv8m9KX1Jar8Ub7P9n5tzCE
         1Reg==
X-Forwarded-Encrypted: i=1; AJvYcCWACKCeYk3nQ9HzePpJnJPM0GV5kKHPFPLPleFyLHBswCiBdAt51MHdBjbHyprxU7rdKKqQ9SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3+cmuFqkfJUBPY2CocsTXUXOsOZ3oMtkHsyD2+3cn+ZTxKlA
	ZVcPAVTaBpMXFcAMsieE6nkApuN3JyyJuyp+Qr0ugKLiD+igCnb2U848AF9dxwk=
X-Gm-Gg: ASbGncuavkgOZBOn7bpjCOPIK3FR2haMvUreb/5Kkdyh5oWOAjqPIxA8kF261rDwsva
	+c3PZzrRCBaEJycBetMwmTiq6DeZfwK908iIOOJ8KyDd+3uE8v4DfOwey21HJsqtQ0m3OgWINDE
	5lKgKujMpvn/LCTUvBNVu8jl62XZtXK7gVLMB3GkY134FVN/KlRQn8uKLoE5DVA6AnUamB2geD/
	DSJP/pnsC9mCJ+YVEHi/RoAcCUdxR156nlPCVhuvQGSoGeIo9dgmKrN
X-Google-Smtp-Source: AGHT+IGuBVWRYeq0JkRbHW4GHAGv7e3ocQlGoF8QWE5a93SPWZsYH3oevF+Zld/Wx1kX4gJU0ZGDBg==
X-Received: by 2002:a17:906:31d3:b0:aa6:303f:6b41 with SMTP id a640c23a62f3a-aa639fa4c68mr181812666b.11.1733478299816;
        Fri, 06 Dec 2024 01:44:59 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dbfesm213442766b.6.2024.12.06.01.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:44:59 -0800 (PST)
Message-ID: <6434a8f3-c5c3-42cd-b7b0-c9c06a3eeab0@blackwall.org>
Date: Fri, 6 Dec 2024 11:44:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/11] vxlan: Track reserved bits explicitly
 as part of the configuration
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Menglong Dong <menglong8.dong@gmail.com>,
 Guillaume Nault <gnault@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Breno Leitao <leitao@debian.org>
References: <cover.1733412063.git.petrm@nvidia.com>
 <984dbf98d5940d3900268dbffaf70961f731d4a4.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <984dbf98d5940d3900268dbffaf70961f731d4a4.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> In order to make it possible to configure which bits in VXLAN header should
> be considered reserved, introduce a new field vxlan_config::reserved_bits.
> Have it cover the whole header, except for the VNI-present bit and the bits
> for VNI itself, and have individual enabled features clear more bits off
> reserved_bits.
> 
> (This is expressed as first constructing a used_bits set, and then
> inverting it to get the reserved_bits. The set of used_bits will be useful
> on its own for validation of user-set reserved_bits in a following patch.)
> 
> The patch also moves a comment relevant to the validation from the unparsed
> validation site up to the new site. Logically this patch should add the new
> comment, and a later patch that removes the unparsed bits would remove the
> old comment. But keeping both legs in the same patch is better from the
> history spelunking point of view.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Menglong Dong <menglong8.dong@gmail.com>
> CC: Guillaume Nault <gnault@redhat.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Breno Leitao <leitao@debian.org>
> 
>  drivers/net/vxlan/vxlan_core.c | 41 +++++++++++++++++++++++++---------
>  include/net/vxlan.h            |  1 +
>  2 files changed, 31 insertions(+), 11 deletions(-)
> 

One very minor nit below, if there's another version. :)
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 257411d1ccca..f6118de81b8a 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
[snip]
> @@ -4080,6 +4083,10 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  			 struct net_device *dev, struct vxlan_config *conf,
>  			 bool changelink, struct netlink_ext_ack *extack)
>  {
> +	struct vxlanhdr used_bits = {
> +		.vx_flags = VXLAN_HF_VNI,
> +		.vx_vni = VXLAN_VNI_MASK,
> +	};
>  	struct vxlan_dev *vxlan = netdev_priv(dev);
>  	int err = 0;
>  
> @@ -4306,6 +4313,8 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  				    extack);
>  		if (err)
>  			return err;
> +		used_bits.vx_flags |= VXLAN_HF_RCO;
> +		used_bits.vx_vni |= ~VXLAN_VNI_MASK;
>  	}
>  
>  	if (data[IFLA_VXLAN_GBP]) {
> @@ -4313,6 +4322,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  				    VXLAN_F_GBP, changelink, false, extack);
>  		if (err)
>  			return err;
> +		used_bits.vx_flags |= VXLAN_GBP_USED_BITS;
>  	}
>  
>  	if (data[IFLA_VXLAN_GPE]) {
> @@ -4321,8 +4331,17 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  				    extack);
>  		if (err)
>  			return err;
> +

minor nit: extra newline here, there isn't one above for GBP

> +		used_bits.vx_flags |= VXLAN_GPE_USED_BITS;
>  	}



