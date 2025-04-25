Return-Path: <netdev+bounces-186171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8032A9D5E2
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FA83AB9EE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB92957A1;
	Fri, 25 Apr 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AoyEpdxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA6198823
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621422; cv=none; b=c0++OeNsN2cAtuhnTMFxmYvT0qRS9SfAEtpEaIKLxj/3fPi9XAg18tGvs/ITgDUqqgIX2RTz602DgknfALXNUhcA6Tk5U2pLGcQd2jxegOIoaxk7F2RGau0e/g+xsM0DssIAuocQILUSK2nrefhJGWqFgyFnTbLfe9m3O3YUgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621422; c=relaxed/simple;
	bh=oXNnnF0+XCh6Y7siLi0qPCV+R5vy/IEr+SHavfkR5w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLed+wLNYO2JvSSQ7XbtJbY5NjoVkpSlsPa/UAmW3q+b3I/NMMjIBgOZJypkfYIWpLxgZNvhL9/r3LGoY1SjD5Z5lXuP4e1yoDNVzcrLfRCv1V+Tr2dd66ARTj6Oy1zutUn7eeyLl97USZNy6KmMn0jMFyz6kcUpQJideIjoiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AoyEpdxR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736b98acaadso2833805b3a.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745621420; x=1746226220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46SDFM4tCUrvRqKnn/Inigyc+ZLZx28XQIy7v/Ih8Sw=;
        b=AoyEpdxR2bC5YdXyrs+nKuSTN7/rYXv8DxdqUXUXem1xuYW8gYtGHTJtNlNtUjtB3r
         kAeHLOr6n3YuQZXx4rxgA7OGg2Wb/fzJViylaH/4q69gCX/KLB7A3S+kzM9Zneb5qwYT
         MePCUCZAnzupzGEyDXml8BaF83o+qQdAvM/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745621420; x=1746226220;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46SDFM4tCUrvRqKnn/Inigyc+ZLZx28XQIy7v/Ih8Sw=;
        b=Bqk3EvWI+RFm3K9hMwTu/yztIeBAXJ3+wk52Ypk0Sy5kpdPKxUB9CpBe8roNvPkhqO
         +GVO6pIenBNO0f4iLHkEQfG/6mVF8K4VivPId0gPKdwFFvNo2Yka86i3cApA9utAe6fa
         i+YLndm1Fd56f34XPT/pEWkh3oW0MvR6qw+zEQ3QnAopBS/nWKuAxUBYNVF5wLq0tB/a
         AelFUObsl3WaMitwMTEqmKZiyDWWiQDjzwOKdFCd3VOD764+GJPRtTHXJ/lV6jbgNrcQ
         /Jhi93/xnRpkOtb/HdZbS98F99lFXrxZMpoE5chBuDP1V6wx4WyNGVlpECSF6EmPfjNI
         HR2A==
X-Gm-Message-State: AOJu0YzRymjpYt0ZWnji1sYI4KAJd9yRyt5L5vuIslQHDv5foK80wHXK
	SYJlp30bzqnN72YEignMs2ozwCkVyYsms4O7K8ibNuW863bRdFUBt0cV0qMVyas=
X-Gm-Gg: ASbGnctyoe0UVk6I6+Zb1CR5H0PP0zAlz9KqIA26dp8xDn/9P9cRJOnlRaweII1oMWF
	sD7Vmt0ihuG5jsPqBtfbzECm+SL0IEW41mzBw4SQxFWwdyr4Ew3YKAfn8y4bhkfsSii8ucJZML3
	LG3mfn0RDvvMkafO1BLQmW8c7//XYACdipnqDTFzCF5pgr14zYlrMoctz9BgiL9qwluBcd0607T
	kLWFnEPZl+9rryBw4vBKU1hExAQfzoOojq8WfstGSeWQNEHuPA+lhDjv2gy5MHKw2aFHWwPBVuh
	bF+iTbaMWE5+zHno/I1sKZGr4yCEXWuQSSr5/3nT+4DfjgZQOJGjUQuE5Zxchixln5XqI+f+7sx
	OHxtAnCWjSGU4
X-Google-Smtp-Source: AGHT+IHgyie3jBmhccVM6unaody93KG4M83Mfm0kT7Zu1s6XapwXzJ23xqtNO6+0aLflqCnT01wIRg==
X-Received: by 2002:a05:6a21:10f:b0:1f5:6c94:2cd7 with SMTP id adf61e73a8af0-2045b9fdbd6mr5478211637.42.1745621420244;
        Fri, 25 Apr 2025 15:50:20 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a420sm3825539b3a.107.2025.04.25.15.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:50:19 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:50:17 -0700
From: Joe Damato <jdamato@fastly.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/3] io_uring/zcrx: selftests: set hds_thresh
 to 0
Message-ID: <aAwRqSj8F--3Dg2O@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250425022049.3474590-1-dw@davidwei.uk>
 <20250425022049.3474590-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425022049.3474590-3-dw@davidwei.uk>

On Thu, Apr 24, 2025 at 07:20:48PM -0700, David Wei wrote:
> Setting hds_thresh to 0 is required for queue reset.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  .../testing/selftests/drivers/net/hw/iou-zcrx.py | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> index 698f29cfd7eb..0b0b6a261159 100755
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> @@ -8,10 +8,11 @@ from lib.py import NetDrvEpEnv
>  from lib.py import bkg, cmd, defer, ethtool, wait_port_listen
>  
>  
> -def _get_rx_ring_entries(cfg):
> +def _get_current_settings(cfg):
>      output = ethtool(f"-g {cfg.ifname}", host=cfg.remote).stdout
> -    values = re.findall(r'RX:\s+(\d+)', output)
> -    return int(values[1])
> +    rx_ring = re.findall(r'RX:\s+(\d+)', output)
> +    hds_thresh = re.findall(r'HDS thresh:\s+(\d+)', output)
> +    return (int(rx_ring[1]), int(hds_thresh[1]))

Makes me wonder if both of these values can be parsed from ethtool
JSON output instead of regexing the "regular" output. No reason in
particular; just vaguely feels like parsing JSON is safer somehow.

Reviewed-by: Joe Damato <jdamato@fastly.com>

