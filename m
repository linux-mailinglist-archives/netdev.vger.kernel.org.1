Return-Path: <netdev+bounces-102793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B9B904B9C
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 08:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2ACA1F21543
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDA13B797;
	Wed, 12 Jun 2024 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0hYGDPhT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DDD13A3E3
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173801; cv=none; b=l8GPYi3vsFVOiqTMaKKZNWONqqF1OPm4ZBFwv6Tqet66Gj8Fbb/xwo2b9YI9snAdDm8OO7SCL5GvnLiuVcEVZcL/3gn2tJZW0dqEs4Zg3keWm0TaN4bH5MBr9FKCGDfQp8tolwM4rNPF4Lr1bbtfiDocISWSnZmZ7QNpO+x3Vso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173801; c=relaxed/simple;
	bh=Dw8KIMMn+F28OFpTAhQjzDCM2P9ytOTncCAHmd6nIHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO3tWgsvI1eEKhdYDC/9EbT4UPn6aKTxhkKzv1yB93vFcBjXxvcMRxNRGoeiLavGLJ62JdFrA9tKsBf5nzNcdYrxiV4PB/UPluJyh2T/4izf/wZ1jpJhGihezfSs4xZTWwouCGYjHr5bXwPWNAFKsVSL88hjz8kmFGeZQQ2jjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0hYGDPhT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc1261f45so5010845e87.0
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 23:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718173798; x=1718778598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5LH8e3qpcjluJss2hNPudK/MPhEV4gW+gLGQ/ZThC0k=;
        b=0hYGDPhTrP5DabeRqTvEnFuUoZWnORKBU8CLTKH0A0qO0Ih0BcoPlOczkFx2/EGhLk
         iO6lpFy/tSpQ/FuiRlomrdjp84kvZbiEiMVifwfvCwNjKCZesboHLSNzJcZXdietSsiO
         8sHKS/1DkGxaIr3F4fAu2pmNrgUd5t6bDHPC/itLJ66ic43hvsgu8HsEuJGsS9RYLN+R
         +1d67dHVs/HdTq2EODGcogUJK5j/i9EqCVWcsjbXwvMO4hbuwBOsnokLIZXVHNjk5BJD
         oX5xppbcuN6Dw7RWcryH3SPhqk4hMTz7+Pz4l2pJdYRlhYL24xx14pSpQnt/ZqOUAvIT
         IkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718173798; x=1718778598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LH8e3qpcjluJss2hNPudK/MPhEV4gW+gLGQ/ZThC0k=;
        b=OjWcThlm3L+weIB+tN4u9EFAT/xDqrn6xA06ymC7RUjtWFxB9w1oL/Tv0IYVOIXy5Q
         m+hSRguCLFPWxhKhVM2iui02IMjjaF51pyFZSDq5fxTGCJcY99KPuOwZAOYM81CZp0U7
         NRA2OdUA0rCJRQnC9QRKQkCOAaOnq5wpJFOeBD7N9HgxAbtKQxGsAepN47LDqCoNj1aK
         1N/PBSfiHbQ0pYzw7DmqIm5Zu+vTEi+AXD8WIW2NFicm4WguX5WrFFkVfeuAznFzOr8o
         PWR8l74UjDcSFuFh2f6m/ZDo+rOcUoY0UlZJMTiWBJt9VqK+BXbomT1g1u7224lOD8tl
         XPoA==
X-Forwarded-Encrypted: i=1; AJvYcCVvoAuqH68b1wsNcv6AzaYmj2vrbobLGV6jN0uiO2kzphgA7dLCYo3NncCunm/XGSTFHRSUedDxJbNdEorXu8Yudi4LxmDA
X-Gm-Message-State: AOJu0YxzKDiqlgsrDIfFcp4lxzgBaT1esuaKJjk0EQISN3u4Wk9t2NqE
	JDq0fL3zL5g24g/3MPKfKe/na/vUU4N1X2YYk3NfAur151+x8kvV9S/5fVmvijs=
X-Google-Smtp-Source: AGHT+IFp/68HMGdtt+tnnGcItdNkBhSFo46K5V4Iw0bDMZtwLsT4wVHxdkIyBopwMlohpTWvO6o3cQ==
X-Received: by 2002:a05:6512:1313:b0:52c:8abe:5204 with SMTP id 2adb3069b0e04-52c9a3dbeffmr624591e87.32.1718173797669;
        Tue, 11 Jun 2024 23:29:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75ebsm12495135e9.9.2024.06.11.23.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:29:56 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:29:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611185810.14b63d7d@kernel.org>

Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
>On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
>> Add new UAPI to support the mac address from vdpa tool
>> Function vdpa_nl_cmd_dev_config_set_doit() will get the
>> MAC address from the vdpa tool and then set it to the device.
>> 
>> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>
>Why don't you use devlink?

Fair question. Why does vdpa-specific uapi even exist? To have
driver-specific uapi Does not make any sense to me :/

