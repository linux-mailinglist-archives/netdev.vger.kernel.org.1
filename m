Return-Path: <netdev+bounces-75371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16BF869A2A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC08B20DFC
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A7E145B1D;
	Tue, 27 Feb 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jZQe0FJi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D314A0A5
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046504; cv=none; b=s1VZ9dddu6fkwVmDPVfkSZbotBIkRK6nLw/9cdEOfJ7VJ3NoFQkkrai9D9ippamEnzH66SEobE4UlroQ4IsBqi5BaQPIIOsnezFyuKzf5EXfzjtxQV/DzFhx/zrPBM3GF7tilKAPwvR7XFYnU63iSgrhKE/2+YD6jMgVt7op3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046504; c=relaxed/simple;
	bh=kVffUr20Izax4YF9+0wwB28rgK6Y0uZGPUDJDiZR4Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHr1yZsIAUtyFUrG4NIc8/cshxyKJ13RIyE9j59LvvpgdAVB0XiuXkqlaG7h1zzHfqUL0FbkIJmgsYC74dza3/QIBsX8H4CN6z0/yhpRfm59D3RpjSxI/+q+9oxSSVnwxB4TxvwsTeAg8GMrUf42jWR+HYIs5+bedi53TmarS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jZQe0FJi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512e568607aso4465818e87.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709046501; x=1709651301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgKE4Y5Fe/K9QqRyLFbe9JH+uzN4iuJkkyLvvTToOHA=;
        b=jZQe0FJiot8xHRg2/+SN4u8bLQcl8nfsdtJE/3XZlnHjlolw+d0hZ4oMdQzbN7RPKO
         7q5YemsjDOsFdDmI+QRTzyoBtzkZ5TqCuJTqHyW+ILxQ6toEY42YCjsq/YPEOiHJnqNW
         TVXraVwgzIAra9cQFdJ3AkgHtz1sPsq3OcbeltagZI6VWQn/A3EA0TjRLdKfAkdnjgjz
         vBWBINHBWfMgHcOKB1WJyMt+L/W592TTL0JAMFZ4UWjALr8BU/1klAF/gXOyLx4+PylX
         YtzcZZcfG0IbAbxSyLHDRR5VGJ4sYPk/OLCBDXt/SiOBa2g3TD7VwoLUUSdaAp4rHZpP
         0SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046501; x=1709651301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgKE4Y5Fe/K9QqRyLFbe9JH+uzN4iuJkkyLvvTToOHA=;
        b=ggHrdtkIloqqCSnLXf5IFAhzRWSa1zmh0FZQWPdCKqT2uZfqtrOZigMRapnrFL5AHz
         JqdiWaN9Uq1eMfLh9uw9o5Jusx2pvZ7nws72dL8oz4oYvE3vKFosllJQ+2g5SwqCE5G8
         qDwIx/MDKUpwv5w6fAPvsJ6VUEwCeVLde2Y6M0DVc1ZtJpttiMNJq8ygiHw9TA075Io6
         RKs6rqV59ymgaDc08FUF/HA3AMIRba089y4ApSwasbhjD7M7Qh1Jle41ljqg3LJ5Tijl
         1Rd4L1MqNc0nxa1uFRTl1GvN2Z1vtOTidP8W8YgKA0QXi8P0+ZGlkeuOTGd45xAG8Vu1
         VaWg==
X-Gm-Message-State: AOJu0Yw27otahu1XdGnPXULBeQV7HSyPUV5aGC/itEnK+fn6i1SFDvy1
	7/GDW/5yHIu+m+2qT7nt+tsPz8J0ahbFM1R22S3WfSqodqhT9pEsnfT8LfEyIkc=
X-Google-Smtp-Source: AGHT+IGTERjeJ4l2yM/AZTnVBJihHHv2kACSJ6apoYoy24DobZxv5fIlFBhKgDxUgSkMlOVD0RJNmA==
X-Received: by 2002:a19:5e19:0:b0:512:b27c:18b5 with SMTP id s25-20020a195e19000000b00512b27c18b5mr6445800lfb.30.1709046501439;
        Tue, 27 Feb 2024 07:08:21 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ba16-20020a0560001c1000b0033dc7706be3sm9409625wrb.79.2024.02.27.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:08:20 -0800 (PST)
Date: Tue, 27 Feb 2024 16:08:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 6/6] virtio_net: rename stat tx_timeout to
 timeout
Message-ID: <Zd364r85MU0DDVNB@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-7-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-7-xuanzhuo@linux.alibaba.com>

Tue, Feb 27, 2024 at 09:03:03AM CET, xuanzhuo@linux.alibaba.com wrote:
>Now, we have this:
>
>    tx_queue_0_tx_timeouts
>
>This is used to record the tx schedule timeout.
>But this has two "tx". I think the below is enough.
>
>    tx_queue_0_timeouts
>
>So I rename this field.
>
>Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

