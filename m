Return-Path: <netdev+bounces-113141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C593CD6B
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 07:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6F1B21EBC
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392D52557A;
	Fri, 26 Jul 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgMz538h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B1816
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970370; cv=none; b=m9I6yaDpN+LFyJP8Utty2L/YJWXamPlUjkUnWbJe9GA2XuxpBC2exRC+vDJKvfACmFDI2/sUxlaOHgTaSb6QuW/GgFlb0h1AAWMKftphZKoBsNm7KxK6GF1uQbDp3CfC5OV1XwldK1uZKExllDh0rXkNocH6j2TQcQntV57g7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970370; c=relaxed/simple;
	bh=v5F0TtwSTZhjy1iiOp51i3y8C9QRIjKl1da6bAPINYE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tGmY59jwYoZed2fHrWp5R2HRlDPZH8vgREeScO60jMnZisz1JgoOYtbX5s+GfigWBcB5pFxH/SBnvSV+nifpdiyJNPWM3pzyTn+MP9+SrBCQqFQKOYShRpRu8J3MeVWR1i9mTs9B9eP/4cmfbUWFipLf/Iujx6+CRGUaTq3bPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgMz538h; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so15082755e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721970367; x=1722575167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ09fbkmQ+9CiOv+kics65FAREHpnWMPMDV6xd9PzeU=;
        b=kgMz538h3g/Xdk0F8n0san258BuVMpllETQGuwNmh44+bL5v0EI3QSSFIhcafxjDBW
         o5cSDSmRratwbTH3JHh6wU26kVyikI+7K6BJmx5uQ1BwaDveilzyicBPWZcDc+ZWUfTK
         hSZrAAJm+tfjGsoCr5gzooMeNpiqsMDlPALpbxWWNJDySwA2ksqANQ3ioT3l6yau+5l5
         KqmYjXUjHCaEcCalFQ7yOYT1Fjw6z4XjP6l0mV+MmKY/VL2AncNXpfwlvt5Qpu0A8xam
         mT6G8r7R6I2l277xTNl53bKCrqsCqsf3PNF+AFgxm7rK+l0HZ9wDKQfEyS+F0nV0cFDI
         lv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721970367; x=1722575167;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ09fbkmQ+9CiOv+kics65FAREHpnWMPMDV6xd9PzeU=;
        b=P4KetLzRS90dx/OXrxtVM06qFh0yorJi7qLyZ7H+R4H3ZVuoknCjS8WQh/Nc+s6XnS
         crc0ZqQ/WC1AKdPwy8SC1Aws5NujQ0d9oGXlA/HNqoEGbumVxpf/czYFFp80dx+C7kvZ
         RbdwyDfuJCAOHqQG+5xbYOrom7NpqEJy8qxS1r59AKSp+vdIFb0QItj5MHwcNfYw/keL
         vkqnkOJs8m5T41NZMBKKpH/AwcXkMX8ZFChN88osHXqVE4uwQ5rIxeueWubqdAvmi/sI
         DMYVgOCjvfJq+QWslymie5FYl/yEiUJoXWu3lJZWamgHXTnVvHLeKMjuA0f5JlVnF+yW
         wtSw==
X-Gm-Message-State: AOJu0YzTK8+xNautMLghq5PQDwXDwmeA/7C0zgAPMDnQMrKEWr5/EkQw
	Si8c3hJL3f1RCvahz/zR1g5NoxzZRJGjmo3ZJclD6xLAR+QtI/YU
X-Google-Smtp-Source: AGHT+IGgXEuqwE+9tHzameTkcoCF2Tih8PefF6anwJEUh+pMXVuvuw21xIRzacN8igyXKs7ckEqPJA==
X-Received: by 2002:a05:600c:4707:b0:426:62a2:34fc with SMTP id 5b1f17b1804b1-42803b482abmr31774325e9.11.1721970366493;
        Thu, 25 Jul 2024 22:06:06 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057b7274sm61598685e9.40.2024.07.25.22.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 22:06:06 -0700 (PDT)
Subject: Re: [PATCH net 4/5] ethtool: fix the state of additional contexts
 with old API
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com, shuah@kernel.org, przemyslaw.kitszel@intel.com,
 ahmed.zaki@intel.com, andrew@lunn.ch, willemb@google.com,
 pavan.chebbi@broadcom.com, petrm@nvidia.com
References: <20240725222353.2993687-1-kuba@kernel.org>
 <20240725222353.2993687-5-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <e705f0d0-557f-1ad9-e704-f6a0d899c70b@gmail.com>
Date: Fri, 26 Jul 2024 06:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240725222353.2993687-5-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 25/07/2024 23:23, Jakub Kicinski wrote:
> We expect drivers implementing the new create/modify/destroy
> API to populate the defaults in struct ethtool_rxfh_context.
> In legacy API ctx isn't even passed, and rxfh.indir / rxfh.key
> are NULL so drivers can't give us defaults even if they want to.
> Call get_rxfh() to fetch the values. We can reuse rxfh_dev
> for the get_rxfh(), rxfh stores the input from the user.
> 
> This fixes IOCTL reporting 0s instead of the default key /
> indir table for drivers using legacy API.
> 
> Add a check to try to catch drivers using the new API
> but not populating the key.
> 
> Fixes: 7964e7884643 ("net: ethtool: use the tracking array for get_rxfh on custom RSS contexts")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

