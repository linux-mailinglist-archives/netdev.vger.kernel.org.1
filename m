Return-Path: <netdev+bounces-68424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD5846DCE
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC26B24674
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B87A70A;
	Fri,  2 Feb 2024 10:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ILrQ3hjz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE087C0A2
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869327; cv=none; b=hMEMxVwBHVVFkbz4Cw0RYRz4dKUugbwS9WmHY9wAKbCJnXwCiPcVAwpf/K0K4miJio6AAr7kjL8EPRFbicYY2SVxCe8qQ7OQ4+yLY3RHMo954NzQqTm5wA0QucNPsBLjDOrMGmSVm0VDpFieljrG8sO/Mcm5Zx/iUjv7fCVmH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869327; c=relaxed/simple;
	bh=xJRvclZqLQRIQ7HHQbca2mFArdZBQmiQ72MbKVhd/PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+Jhq8dMaNeGjow2k51LSinjr5oAwXjHwNmpD5O+aBhaP+4aRcLQ5yuTXjgMZA4kb6Zbm0R/vAwvjHoqx1GJT/dqqrjNwAvVA03wNhwiQQsiUC9Xwlf6KyZnvrxzvHDSkMwZpJTGKjoT+gJ5PC0RGExmx7TKnc6LQtupeZHR5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ILrQ3hjz; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511363611ceso609310e87.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 02:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706869320; x=1707474120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJRvclZqLQRIQ7HHQbca2mFArdZBQmiQ72MbKVhd/PI=;
        b=ILrQ3hjzG9wo2bZhdRWex5Xm6oV+FrAmUO3PjuUVjzYd96WKELQxNNfw36g6wskfDE
         qjo8rH0fdvhuhHQAC5kOALC4MylyrOpOBwYNK/9hEBaWA89R2ZYiZ1iBZRv8Z8GG9CZq
         Vw2j7IQiXgBlKPlKUDhBOuQ30jtZjKbjjmtM9CnS2JQIi6uvv+k+mLipwIZoNnU4UMdF
         Nb8jjXdnRYqEjAN12wmmsgHnOQuOOPtQV6NjcRQsGtzM2Xe/vyHQ361gqLClQxBfWskE
         TPjW7wH47aifv07wI54VUOOmQGWOFJsTvubD6zRg79prpvGSW7acJgU4O2Z6Gq4rpmN6
         GLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869320; x=1707474120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJRvclZqLQRIQ7HHQbca2mFArdZBQmiQ72MbKVhd/PI=;
        b=TjXNSl5PkLW5T03KKZY3mJq6878Y6lzGhAzmdWOKi+pT5tx3zj3C92fB0JryH8a1UN
         0cRaPIWRtBUf3CSaRw6O0utaVa5DTJObJ7L5VayNLCsnktc+PaztDQpB6c9zFuOyzIXt
         M+Zzd3vxY5oeWqG2QIz3oCTn75uGizr5mjU/tM7TJxjttGwi7S0NNsznn3VsEeE3lBBu
         nHI7dMz5RTKFAW6BwD7sflpdMS0Y/Wy9DlDo+R0m9NCZLOuL0K7iIOiVGBc589NZ8aWc
         tmfZZCHxQme7uq3HCOro105SLQ6+8O3+n4j/FNWHw5LYCOitCDZteNk6mVH0UKvpXFBO
         mnXg==
X-Gm-Message-State: AOJu0Yzfkr4v7Xg/Bhp+7jFCNRgxOsQ+6hr5nhrxE8hR/9GT6EMLCH6F
	UgQG0Q/1osDr2aSWQklJxjK4FthzG1aQKrKFIFvmNCriSd5bglBevwEhVNjgRX8=
X-Google-Smtp-Source: AGHT+IHlIrwa3TWieKAuVodpLntn07DoXpc3dmhIhqhnvS0pHNR9YX/N/wPVyqcgFxpRP9t79llu4w==
X-Received: by 2002:ac2:4256:0:b0:510:d7e:4cbe with SMTP id m22-20020ac24256000000b005100d7e4cbemr3610558lfl.63.1706869319828;
        Fri, 02 Feb 2024 02:21:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXaNmf4oCN7sjZ7+p+5DI8RU/GppMD3cp3tP1NOUpU/+x3neASPDJ8w+TubzrwXYbc5p/E41IvWsHWWTGXDBXvMQ5zLeaeDScwH4lbywBmRrhtsljLj+0Ak9ZE1HaDJZuVTfVCiTp4cEwVXSMBa91y2t2yMD2aGT6TK3C+y794z1b/pE0Zhc3TlLGsFML/auySU66D3NMe1i0Vnmb0f69vImAQxPpGs9wQz
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b0040efc845cb6sm7066959wmo.7.2024.02.02.02.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:21:59 -0800 (PST)
Date: Fri, 2 Feb 2024 11:21:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com
Subject: Re: [PATCH net-next 1/3] tools: ynl: include dpll and mptcp_pm in C
 codegen
Message-ID: <ZbzCRIkQUSQAy9Wp@nanopsycho>
References: <20240202004926.447803-1-kuba@kernel.org>
 <20240202004926.447803-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202004926.447803-2-kuba@kernel.org>

Fri, Feb 02, 2024 at 01:49:24AM CET, kuba@kernel.org wrote:
>The DPLL and mptcp_pm families are pretty clean, and YNL C codegen
>supports them fully with no changes. Add them to user space codegen
>so that C samples can be written, and we know immediately if changes
>to these families require YNL codegen work.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

