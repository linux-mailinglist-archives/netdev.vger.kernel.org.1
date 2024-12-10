Return-Path: <netdev+bounces-150718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2E09EB40C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF17928180C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4701A01D4;
	Tue, 10 Dec 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeXJxGhL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8B523DE87
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842509; cv=none; b=XyxstN8opTI86y5ax5ZiZVVetIz3jVhk/FkfBqBvIUoMewgRX+S76ZhTB8ZZy/6XBvuNCpzfVN3woqB6XMTDr5ZNAmMEJCnx+Oa5O+OFaLX3SoX4nf4phszVMkexDSeerTPjucbIP4kiAZaIV1dijn1WZlrEhK3wfA4Wc+N6zuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842509; c=relaxed/simple;
	bh=12KPYsuRgtZ3yzXT2spUtH9ViCOMs5kWr/jCQzdLwYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaGj2eKbYNoXpt1i+1bbfnHLWpjCKzXMv3Wl9JG2ieT3v2Neb+505qbdE63fg5MjsCEl4s9MwxKhRZ2+L0raXV9PQehTPlrwtHZsbve2JMNxJXGCb2MFd89Ta3BEQMsPchiW/+uWVAf10sfrBYFj1UYy1ZLdoB01oJAW5PeKPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeXJxGhL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733842504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ThFU/xA+DZ3kCyB6utWGPiIodf6fNfGIiLpxfivPXs=;
	b=VeXJxGhL8zEGn5fA68XWkxx70hVBfwMSUT2+sMqCTAN0Bc9ADVrV6gNqL5Y0TJTB3zAdbA
	KCWvEV1iKz4HaPnbztNRV6fx3NyCwipoJyFN2mDiv6YaTB8Sdi8EV+UGTwEqxoMX66tu/u
	rQQtZ51eBXe5w3Av0TmCAfutly6hbns=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-0Mmh2ucpNK6KOrZjN7iqyw-1; Tue, 10 Dec 2024 09:55:01 -0500
X-MC-Unique: 0Mmh2ucpNK6KOrZjN7iqyw-1
X-Mimecast-MFC-AGG-ID: 0Mmh2ucpNK6KOrZjN7iqyw
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e241d34eso82532885a.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842501; x=1734447301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ThFU/xA+DZ3kCyB6utWGPiIodf6fNfGIiLpxfivPXs=;
        b=OPnB0kaa/8pC6uXKP8PrxJGM/tl3ODoDwIc+IRiPQ9JmT2lqjgO1DpsjadqZzDXUY1
         /rhSh0BMKEjfKnCgotnw7TRDI5d3PuAL0ooMRM2i+sGmIZJklmyBIb5WT5zqEVwl8QQC
         Dgdb0kgTgk9vurHPSmPtwE5sv5YUZ+/ypI2AuO7VvgQ+aOA1KmShk0kAtxLz/V0M+OS4
         DuOMwWtTKUxm6wY++nlh/q7A7eyqmHNrJSe6JS4lavjmNn8oy3oTca5Onc7RRouvutLA
         iBa0u0Gj4WMBgM2KRqVinmBHiHR2AjTXpnD8rBRZFriWpWz+SkJDrdR91ebmyGb3pot5
         un0g==
X-Forwarded-Encrypted: i=1; AJvYcCUTiQ6I5omyiTwXBeQejCs98jx6t4Cy+uyMW5jCyrcu6Qczhfm+9PYGcQB9/6cg0UK9H+ecFlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBINtmhlA+RfbTSBwEccufMXzW+YbKvutguh0UTjgCgoI1j4Cb
	iAkpIs1BUb1b4B1jiBiBJANZUUWYB3V1eGtH+H4e/OyJtGujbCLmDnIgERjLqyfOa9rHniujyRR
	5OgYo/7JFKjc/9fz/Qh9dai0ZpEW52H1SsLPiYLe+fwqPrLdWQULq0g==
X-Gm-Gg: ASbGncsYbUkhUX8J0tRPbsqnkBSgyzTBaBHSAUZuTTABhYV+DcswWW+Lg2B0iD1AH52
	Cg8Rp6TX5JCvq3HQKyzurKeW5XjcVaYV4LtT8yjMZz/A4bHW2y/I2NM63DMnqrcDQfy0gqbTt3m
	Oys5OyvU01EyxEFnQuIhh4PAuOajY9sax1n/Ug5hshBDmycaKXhuKR9EfHTPklwYmpN/gX6+UcU
	e4pCXCmq5XS2K/3P4M1Fn+jdtHcLEJJbpAa8T6RF9hKiDCTmfM3RwvDlO92QvM740ERkh6Sf+eW
	/R8Zj0wqyu2gxsHdiPhudInuxw==
X-Received: by 2002:a05:620a:4494:b0:7b1:516c:8601 with SMTP id af79cd13be357-7b6bcad369dmr2260762485a.20.1733842501174;
        Tue, 10 Dec 2024 06:55:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUhz77q38D8lxjvYXjcAohHMoKZK/g0bbcazsR10XuD7YswcYsuoNSNMMbIKassN1XY4DR1Q==
X-Received: by 2002:a05:620a:4494:b0:7b1:516c:8601 with SMTP id af79cd13be357-7b6bcad369dmr2260759285a.20.1733842500893;
        Tue, 10 Dec 2024 06:55:00 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46785b73236sm1848751cf.69.2024.12.10.06.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 06:55:00 -0800 (PST)
Message-ID: <04a216d1-6952-40f0-b7d0-f9d8b4f5a866@redhat.com>
Date: Tue, 10 Dec 2024 15:54:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] ice: Add correct PHY lane assignment
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>, richardcochran@gmail.com,
 przemyslaw.kitszel@intel.com, horms@kernel.org,
 Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
 <20241206193542.4121545-5-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206193542.4121545-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 20:35, Tony Nguyen wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 496d86cbd13f..ab25ccd7e8ec 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -4095,6 +4095,51 @@ ice_aq_set_port_option(struct ice_hw *hw, u8 lport, u8 lport_valid,
>  	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
>  }
>  
> +/**
> + * ice_get_phy_lane_number - Get PHY lane number for current adapter
> + * @hw: pointer to the hw struct
> + *
> + * Return: PHY lane number on success, negative error code otherwise.
> + */
> +int ice_get_phy_lane_number(struct ice_hw *hw)
> +{
> +	struct ice_aqc_get_port_options_elem *options __free(kfree);

Please avoid the __free() construct:

https://elixir.bootlin.com/linux/v6.13-rc2/source/Documentation/process/maintainer-netdev.rst#L393

Thanks,

Paolo


