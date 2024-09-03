Return-Path: <netdev+bounces-124557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9BA969FB7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764EFB2543C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA991EB21;
	Tue,  3 Sep 2024 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGL7FdCJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08E1E505
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372180; cv=none; b=h1DxZy0qSBh/0KutIMHfU1KfZuikYZEm2sTmxSy2rt2MDJqKGpqfbqLyt2CR0DBJqBoSZDMuTgU98MYI5+kTvgS5lPnO4Lwq8/5oWQ9lA4CzPmQD9LviE4zfao422uVRkQ76nkxJ3PE4X9sJL5OhjHo+mCJY699cuvBK/+hBSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372180; c=relaxed/simple;
	bh=KbVX5/WJLt/Z0+uhwnKhCH5C1tCBFTeakpeppFQXWBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3f5rJBWZ2ammm9Un/uPHeXnCY8OuVLzBMkN5a0Vx1Z/YpE5xpzYIfGnBZMGGG0TkBfxhK8wTnBMOtldG1vEn4/2oPurgO60EZMA1rBWzqGqQKkD30oRsRX4kSsAv27omcW4xqrQzxi3xJeXTIIU+00wG5zBntozKovsbfNn1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGL7FdCJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725372177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
	b=CGL7FdCJsmnR6SZWa7udfltvA29PTsXwLsiowBhg4B55ild45irmPh3u2306YoN96L+/89
	h7j/r6UfdMLLVNha7GzI9CTXMqNfXn8nJNfATH8p6QGoohfos8IJXW0iYSXt5XvhCoP/Sz
	N1w6B2s3IToapPCiA53gzS7Ab9dYe8w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-emd3evQUMxOOMSu43ma5_A-1; Tue, 03 Sep 2024 10:02:50 -0400
X-MC-Unique: emd3evQUMxOOMSu43ma5_A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb5950d1aso60944605e9.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 07:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372165; x=1725976965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
        b=K8UNve9f9U3def21vd2H61f2HnOeOwNl0n15oHBu/tHDBMj6oK3TKkR+KUE9uKYlBj
         QeMVfoOzAriEU9Z0yScJCh2ocW10pvHhhMveMLZKHwpwG58uyfjkAFkv1dDn1q+nFfEx
         3h4lFd1SYyJGS5rF+JTt67GziXqDW6mO6097Igy/0YcsJ0ahiJBhfYqNHI4IclAUoDCB
         3auPp4XsDVMMxRY/lJ9xduL2po6ms4/WEf8uDeLcoL5IyzYPb2k/ilthtdi72ylAOV7R
         WO/JSikoIx8SGDFQ2Zty7jlcfG3iMCBZExdHnKamZsO38IB3t+qCmyBx1DN1Tadvlg6z
         TNdg==
X-Forwarded-Encrypted: i=1; AJvYcCWjDACF+W7ALVz7ZSYkA7Mh9mcENvTj+HbZLBKEcvW4Ko2GL3VqRxcAxenbcsUTEDmpMCs0Y2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWrrcTiwX3uJLk10KP8wqmeljMOII6llhn+Tf7i0eOH03kyl43
	zXt+y0x32fBpIOURh48eqFT8lD7m9VGl4RTFNOJFzKpSKLraNvn2tUuXiZxaK+cRf98seiIFjKn
	1jPRrY34hZvutgQd0ijMMXBS0nffII6boTK4DT72ioL0nKFg9pJ4bKQ==
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013541f8f.24.1725372164309;
        Tue, 03 Sep 2024 07:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG+gCA4emCQ8lN+v2r+4PD0Xf7gtP5260Hobybyq26ysa18Yk2eN574I3dEkpcvY9bhrHY7Q==
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013434f8f.24.1725372163170;
        Tue, 03 Sep 2024 07:02:43 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm14372770f8f.50.2024.09.03.07.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 07:02:42 -0700 (PDT)
Message-ID: <c5658b79-f0bc-4b34-b113-825f40a57677@redhat.com>
Date: Tue, 3 Sep 2024 16:02:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] ethernet: cavium: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240902062342.10446-2-pstanner@redhat.com>
 <20240902062342.10446-7-pstanner@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240902062342.10446-7-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 08:23, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Furthermore, the driver contains an unneeded call to
> pcim_iounmap_regions() in its probe() function's error unwind path.
> 
> Replace the deprecated PCI functions with pcim_iomap_region().
> 
> Remove the unnecessary call to pcim_iounmap_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


