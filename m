Return-Path: <netdev+bounces-201506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35988AE9959
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA973A4305
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34723BCEE;
	Thu, 26 Jun 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEB6oE8x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D06218AAA
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750928493; cv=none; b=LKGW8tj+scy0DX+Xk81TvDgx3MqlnEzOJeYn4vkZVM6pyAaMaR0hjGz839atbvNQuOwP0FslY+BcNIT2QCNfG6+vjjXpv5FAS9FfuJ/akiTKdS0doLWHr31rjT9vJnv1qwrf0dj/3JJ6uWd2pI/6JfD9T9x0I5EHOXiPZR7O62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750928493; c=relaxed/simple;
	bh=V/+xd8na3ScrW6dHL2oOP22RCpzGwcknKLxV8kskNz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfxjTgOdHS+uHskO9RyDbcuP+Q2U5UmnrxxrblGoUYDi3If/WWQXYnItv9zZS4RsrZWgjhqjSborRQxrtJmXmOB/uPrEmscwIOJn/+xitGytTMqoqMpcIMWyuM03tQ0qhlsHLjNC2TV92sIX5O7LdHRrSxafdRSzldcl6QWlAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEB6oE8x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750928491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7C/XYnvTlg+p4+wGljKwIY953bj6tkUufxSfXORvgI=;
	b=OEB6oE8xZji2tTKT6CNb56gggNu6j+LF6mBBmsTW+cLBzjkgSd53juRkIH+7hgTw61x+tK
	jfFfb/hCL6YY1i6ql/NXV95HdlAeblIhWOSuyZmPk/vsLXQE+2jW3Ykn/jFudvVRG1aq5t
	hBD5t4InLVKmQOwEQt7IzErytGPca8U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ezPQEokPP3-EZaoE6iQamg-1; Thu, 26 Jun 2025 05:01:29 -0400
X-MC-Unique: ezPQEokPP3-EZaoE6iQamg-1
X-Mimecast-MFC-AGG-ID: ezPQEokPP3-EZaoE6iQamg_1750928489
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so3747335e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750928488; x=1751533288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7C/XYnvTlg+p4+wGljKwIY953bj6tkUufxSfXORvgI=;
        b=gf2p3aX58VfD03lk6gb2SaveyOJE/jrpvmd3wYX+XzX+KyHwQNNzKeF5gCDmlxi834
         llOCBpULXNaaOB1s6MbHzAvPk2ZCPggpdguGHYHNT3N0XogeFzNGyxmCZ3Sv1ZeTr1Ta
         jF7L+2MEePSZlT9sv1c94n8f8rtGK9PJD+asB73tIjZqOdtsore/tRzM+3hl7pGEBZuj
         aDb5E9M9eWa44Hai8OoqqWe6zHH94DarFr9tlfZc3heqC55rxfctzwnMsMgaYdgJFOhh
         WHs5NJhoI8DueBAEVfHwO2FXpQeyHoexhYJUDd4e9OKQJqrEjXzX/AoKA9jRTQRdoL4G
         5dKA==
X-Forwarded-Encrypted: i=1; AJvYcCWgzLEOnhEW57eWdJpsTS8J1Pa/8fT1BubBYKFXYzUx+cKa7HFatPiEFnIIj31rJbQs/TqQwbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwP/bBDNgh/hwnZwGZL7Q1VLSSko8LKnvKmhGGxEhf7j2DU8x
	iEEE5y9TN+IL5tgIPjKX/jjdAbBvWQpmMFPkpBc1cKX11PLkiMWyoUSaWJaYw5nOMBcJdhm/s4c
	JuLm8JMBrqgFwYvyXciHIqOzKN5dm1Sm85w+huYPAKPP5o9Y6Q3Id2vEt+g==
X-Gm-Gg: ASbGnctEFaZn2gPpYrAbvkbOPKXnCNgxV6fLrJV7RA2SxMgU728CgJPYaQo9Z+R2Arj
	QT5i0KNpC1l33tZ4voHajVKNitdMFMYZOQxMHvh1k47/lunkbWzOofquzccgVp2n5/4RCVFNqTV
	xIaRYZ3neKUZy3p1VUQzWVCZXjmCcg4PLzsYzQFodP3H4vk4+A+DiW7XsOTrMlHWVHLwZYGUghQ
	PuxRF62JzdLcvRSbhWB8kRt3bvbILJdRezUDwMh/7fa3FDZUxo9zhKKJL10r+OOwlGmezEPe8Ba
	G3O3PBzKkbcSwbHee2NqK97Ofj8ykOTOG8fnQuoJRUWtDTV8xNSBG1WwJhx9Bi+pu/XbiA==
X-Received: by 2002:a05:6000:1acd:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3a6ed66e377mr5900066f8f.48.1750928488566;
        Thu, 26 Jun 2025 02:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRnNgtEu/IRO6+46Z+WOGFPBJefKUBFyzqv8DKDS3z9R6AGvf9Dr0B1zMMndjl1+awYL8WVg==
X-Received: by 2002:a05:6000:1acd:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3a6ed66e377mr5899964f8f.48.1750928487558;
        Thu, 26 Jun 2025 02:01:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8117187sm6593325f8f.101.2025.06.26.02.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 02:01:26 -0700 (PDT)
Message-ID: <637bf12b-44e0-470f-b86c-43667fcb7e7f@redhat.com>
Date: Thu, 26 Jun 2025 11:01:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net] net: thunderbolt: Fix the parameter passing of
 tb_xdomain_enable_paths()/tb_xdomain_disable_paths()
To: zhangjianrong <zhangjianrong5@huawei.com>, michael.jamet@intel.com,
 mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: guhengsheng@hisilicon.com, caiyadong@huawei.com, xuetao09@huawei.com,
 lixinghang1@huawei.com
References: <20250625020448.1407142-1-zhangjianrong5@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250625020448.1407142-1-zhangjianrong5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 4:04 AM, zhangjianrong wrote:
> According to the description of tb_xdomain_enable_paths(), the third
> parameter represents the transmit ring and the fifth parameter represents
> the receive ring. tb_xdomain_disable_paths() is the same case.
> 
> Signed-off-by: zhangjianrong <zhangjianrong5@huawei.com>

Please add a suitable fixes tag and repost. You can retain Mika's ack.

Thanks,

Paolo


