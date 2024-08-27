Return-Path: <netdev+bounces-122231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F90F960806
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743FB1C20CDC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B815CD4A;
	Tue, 27 Aug 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0mYO20d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC319E7FF
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756264; cv=none; b=LBa1Q5ONRo6V8DLXpuFnlnVAq1BJFXG1hyjTc9dxEYNYEsq91IOS+/aTrPtx2iXs2OP2f8ZwVxQtoPHAA1rbAyTIJzT/Z5LmnxNyJ1HZVcsBUQjeEQRmE89OIGYtEElYh1wXZBCjw+CZmwOSljC/f6AGO6wwLOQLkYdbjq7cIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756264; c=relaxed/simple;
	bh=g8uJNZkbVx6Q9xZvvulJh+re7FcoazoLPLMRv5cLVVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAMWvUMaAjbq+/Q8aQPbE/lUuxvt2eSj4VO85e9jpDgxGgI2VFLp0lx+bdZ7/+5w/D9q+laKwvRNwJBa1/6FZnSuAP02thsQQalF0pL8+gXSou5wt48SjXj/BO/7KbDgw88SrLPDskj5uuqUB46qYkO2i23oRihNlhmc3NuQeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0mYO20d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724756260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcn+r1A3GLYAWgYgC+CIr8PBP/11f1+9CHxGWAbtMj4=;
	b=U0mYO20d/VKpcjuMZUF8Xsmni6ZwBqxqmKZjJy6ArdFqg/Mf2n92UApq0Z1AWTnutEpC24
	JsrhDf/0ZAYKPVDPQv7y5HQYPvMo2/MXQ+Rc+Ik8ifv+7YVbpgpRg4f28q5RGZFqmPFLlf
	AV2kUVb2sRKkASW2S7/Oij0uQJCQo4c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Fe3s4aV6OLSj0IvJJTqpeg-1; Tue, 27 Aug 2024 06:57:39 -0400
X-MC-Unique: Fe3s4aV6OLSj0IvJJTqpeg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281d0d1c57so30483945e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 03:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756258; x=1725361058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcn+r1A3GLYAWgYgC+CIr8PBP/11f1+9CHxGWAbtMj4=;
        b=ljRDR3cKPWzg96ldHPM5UDhbG2a/HH7ItGVk5sW2eXMO+7F9LOQYiVdCaN1qL//oZI
         AqFmOQv0jjionquILXmUHF7wNBw9DnXBhkOLBoEcOFlG1yUAdM0U0voZUtq8PNvuOTrj
         10kqvw/k21OWwtCNWWDgHu+PETv5kTz/mNqUgxtmtmk/cmZODf7z3C6Cph10pbQH3J7Y
         0RY6dGe0sXxAVknKgBs/kknN1P00LvPCNdW9+OF0s2KPb+J/VVHi6iHnFGSNrzO1ipkj
         lU5j50LCbeqZmpxJMVvSqMM9W12qvCzmD85qnplmw2PEqgSgCW1gn2XVAacb1hs5m23F
         r1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUEE0l7T7uHXFbgIef0wAdWxqFoPu1Iw3wD0suD22MzDarXEzaSVmV2iuEuMSfN2cTpQflMzHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jcxebRj2wNsBQQyt9E8vW8Qd16LRPp7OMcRFoBgv36cjFcy7
	+7SiBmP542M7Rfkt5nn2P5zm+JU5bRBNSUXc/dwfYbfiHr6aP9IJbSCw1HfEEHMsNICOC6ET952
	2lkXhe+grSUVEX9Os3T/f9PrMLph8D7ctAdswIFthU2wOs3f8U2KkN0g6x4QdxsS9
X-Received: by 2002:a5d:46c7:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-3748c837cb5mr1280939f8f.28.1724756258111;
        Tue, 27 Aug 2024 03:57:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAiqVFcY6Bm/bsOoRWCanu83DXAYMA4v6iZJL0diXG52qHx0v78y3EqZJgnOulYrvwMF+qGQ==
X-Received: by 2002:a5d:46c7:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-3748c837cb5mr1280922f8f.28.1724756257577;
        Tue, 27 Aug 2024 03:57:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a548sm12775718f8f.63.2024.08.27.03.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 03:57:37 -0700 (PDT)
Message-ID: <2564cd0a-c236-427a-abd7-e9933adff5cc@redhat.com>
Date: Tue, 27 Aug 2024 12:57:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: dsa: vsc73xx: implement FDB operations
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240822142344.354114-1-paweldembicki@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822142344.354114-1-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 16:23, Pawel Dembicki wrote:
> This commit introduces implementations of three functions:
> .port_fdb_dump
> .port_fdb_add
> .port_fdb_del
> 
> The FDB database organization is the same as in other old Vitesse chips:
> It has 2048 rows and 4 columns (buckets). The row index is calculated by
> the hash function 'vsc73xx_calc_hash' and the FDB entry must be placed
> exactly into row[hash]. The chip selects the bucket number by itself.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

The patch LGTM, but I think you can deduplicate the code a bit, creating 
a few additional helpers.

> +static int vsc73xx_port_read_mac_table_row(struct vsc73xx *vsc, u16 index,
> +					   struct vsc73xx_fdb *fdb)
> +{
> +	int ret, i;
> +	u32 val;
> +
> +	if (!fdb)
> +		return -EINVAL;
> +	if (index >= VSC73XX_NUM_FDB_ROWS)
> +		return -EINVAL;
> +
> +	for (i = 0; i < VSC73XX_NUM_BUCKETS; i++) {
> +		ret = vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_MACTINDX,
> +				    (i ? 0 : VSC73XX_MACTINDX_SHADOW) |
> +				    FIELD_PREP(VSC73XX_MACTINDX_BUCKET_MSK, i) |
> +				    index);
> +		if (ret)
> +			return ret;
> +
> +		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +		if (ret)
> +			return ret;

the sequence:
	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, ...)
	vsc73xx_port_wait_for_mac_table_cmd()

could have its own helper

> +		ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +					  VSC73XX_MACACCESS,
> +					  VSC73XX_MACACCESS_CMD_MASK,
> +					  VSC73XX_MACACCESS_CMD_READ_ENTRY);
> +		if (ret)
> +			return ret;
> +
> +		ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +		if (ret)
> +			return ret;

and even:

	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, ...)
	vsc73xx_port_wait_for_mac_table_cmd()

[...]
> +static int vsc73xx_fdb_del_entry(struct vsc73xx *vsc, int port,
> +				 const unsigned char *addr, u16 vid)
> +{
> +	struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
> +	u16 hash = vsc73xx_calc_hash(addr, vid);
> +	int bucket, ret;
> +
> +	mutex_lock(&vsc->fdb_lock);
> +
> +	ret = vsc73xx_port_read_mac_table_row(vsc, hash, fdb);
> +	if (ret)
> +		goto err;
> +
> +	for (bucket = 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
> +		if (fdb[bucket].valid && fdb[bucket].port == port &&
> +		    ether_addr_equal(addr, fdb[bucket].mac))
> +			break;
> +	}
> +
> +	if (bucket == VSC73XX_NUM_BUCKETS) {
> +		/* Can't find MAC in MAC table */
> +		ret = -ENODATA;
> +		goto err;
> +	}
> +
> +	ret = vsc73xx_fdb_insert_mac(vsc, addr, vid);
> +	if (ret)
> +		goto err;
> +
> +	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX,
> +			    hash);
> +	if (ret)
> +		goto err;
> +
> +	ret = vsc73xx_port_wait_for_mac_table_cmd(vsc);
> +	if (ret)
> +		goto err;
> +
> +	ret = vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				  VSC73XX_MACACCESS,
> +				  VSC73XX_MACACCESS_CMD_MASK,
> +				  VSC73XX_MACACCESS_CMD_FORGET);
> +	if (ret)
> +		goto err;
> +
> +	ret =  vsc73xx_port_wait_for_mac_table_cmd(vsc);

AFAICS both fdb_add and fdb_del use the same sequence:

	vsc73xx_fdb_insert_mac()
	vsc73xx_write(... VSC73XX_MACTINDX, hash);
	vsc73xx_port_wait_for_mac_table_cmd
	vsc73xx_update_bits(... <variable part>)
	vsc73xx_port_wait_for_mac_table_cmd()

perhaps it would be worthy to factor it out - also using the above 
mentioned helpers.
	
Thanks,

Paolo


