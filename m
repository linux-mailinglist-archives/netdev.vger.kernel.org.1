Return-Path: <netdev+bounces-182611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C57A894C7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6993B6C7D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7AC2749D3;
	Tue, 15 Apr 2025 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CXGYpBSq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9719F438
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701653; cv=none; b=H60NeQnk02DWlGJF2RrkcPMS92USa3pn5CPepojR0woUIeINHj65ELRQXte9Z30kMHlKnmonXghhvKCDsM1mEAYaWIYUBjWQYJhRhM2rvWNwzbtpfFnByTqrTICCC81HQ0WAO3V+mPpX0ftFazgjwNVy4mm+ragmmiaoMZDIpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701653; c=relaxed/simple;
	bh=PGCUZXLo/Fh/ceTh/2yBQKWPpZSFoJIqFXgrw05Stls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJc7v8RufbFEx5i1W7hoAo5wHRMVBsuYNqzZSqlWA6qDDPo+EwnsJqpo0Rnq3vh1QVAGZ7mR5oEdmfUVIAga48FxXxOPBZUo7vmB5X0eRG8cEtdnv1AURkm9zj1xggrWzJseOjW7DaEh0F/+ujQSlegOIM0ukBdcy2Q9QhM9bYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CXGYpBSq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c0dfba946so3704262f8f.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744701646; x=1745306446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOuClVoBHKEK0UO7zuSLo7Yk1O4Og3W1EOks+GwxyEI=;
        b=CXGYpBSqwTBL/D6RHF66eAeN26/bFKSBscLJHcMvwx6T8RgaS/oviGu6xO/YbDxbgp
         dMMd8o6Ip6klQh+R4APaLrVn1F9v509UzxRrqd2kMDnQISfmnI8c9uHpvteYH/tykvzx
         IYmob/NZAHtyQsKO9c/Fpms+TCMxueeeQr0hAbFJXAH0ZjZrexANIhLaQsMK7glBD5NY
         duTkZxUBvpjiosVE2yvMe3/LX5SOsrTc5BOkis0Rsh9Y2qQXjTOd802aXaP8b6DZFOW6
         oVDFCwbxR9Bme6v4elJZHX18r1fDRDDVGxj/8JNigKsTpgXIZIg6tTBFe4iR+Xgi+lGC
         GNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701646; x=1745306446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOuClVoBHKEK0UO7zuSLo7Yk1O4Og3W1EOks+GwxyEI=;
        b=cclDqT18wyrgd6ZYpLOQZEdXrB3hXcQxzqyiCS8WIWpfWPuWeHhXFo7L3HZc2j+6uJ
         a/JoPbViKjfbKEWG/TkVrdO3gYYRKuFxXV0HRxiSYAVX7QmqkcgcFdJMQ6qczP685HBi
         suuk+QohXxwpu9XpLntp0GL1mkCMSeP/DvjYfmUpzrEI29J9eiBu2nbWfYrEFZbeI2mn
         EAhZxd18FzSgoPY3EsXZkFNDAha9I/esAEEPIzw37BandZiVHfPnDa8Tz4X5kf32PeXx
         zO5cT6CwTs5jGBQSYL1qd5d9221Nps3eovhE//l3XR81uZTri4o/Kos5/UKhmnKq1xG1
         8jNA==
X-Forwarded-Encrypted: i=1; AJvYcCXPTXNAaFvheLwBKIDaA13j+K5rnl4QYikba25r1wPq9bOrvunJ4Z2+GQTWw6s7XRNWN4INUL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMSP/v6SwcwqPSuQWVWgZHTeb2vr5DJezfQlsLIjatV4AedW0
	IIIVXoINtcei4DoDlEhZ5gFeHC3v/yTifsUbbTGxwwQkBErskrL53v+cWfGk1o8=
X-Gm-Gg: ASbGnct6DZLZz9cgXHDJxUHiAj9tjiwr/mhNhhkTkH/7cu9Xdz/RwRnvjzC3oo464So
	jyoX68uqdCVSMHqaBb/KoSG8CvISR806IC4FKnQO/vNAMiECoJ+rFDGiBc+vmRMdVUqqo+tMHgB
	h78EhzlfsSyI5jEgoMl93xwuyxe1v4WTOCHajZZwd9E0ZU5otpoV2DgOTHo9lQSSV9Ci+o+46vE
	7BK9Ey2+VPIkCFFYNkFvCkZy+CMN2vtqAhqjG6fJzR+njymnffyW7buYDlTqc+HUVm5d1F/1GUV
	4gLwl/k2vG+ItefhdE70hVS0Aj5DK3fEuQfIDQY0CVbM7hzA
X-Google-Smtp-Source: AGHT+IHa3Xn4MPJlEm85wNEau6J7Xelwq17PRnt2LmR5z0ur7yeYqZYig6OspQPgoA0Lz43qhPosiQ==
X-Received: by 2002:a5d:6da8:0:b0:39c:1404:312f with SMTP id ffacd0b85a97d-39ea51eca3bmr11980005f8f.1.1744701645996;
        Tue, 15 Apr 2025 00:20:45 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445315sm13208729f8f.82.2025.04.15.00.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:20:45 -0700 (PDT)
Date: Tue, 15 Apr 2025 09:20:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
	Kamal Heib <kheib@redhat.com>
Subject: Re: [PATCH net-next V2 04/14] net/mlx5: Implement devlink
 enable_sriov parameter
Message-ID: <fpjtoekjucy6duxyfe5vldjgl3ualpu2c72wsq2oj35lta42kz@rm3rbilok2pk>
References: <20250414195959.1375031-1-saeed@kernel.org>
 <20250414195959.1375031-5-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414195959.1375031-5-saeed@kernel.org>

Mon, Apr 14, 2025 at 09:59:49PM +0200, saeed@kernel.org wrote:
>From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>
>Example usage:
>  devlink dev param set pci/0000:01:00.0 name enable_sriov value {true, false} cmode permanent
>  devlink dev reload pci/0000:01:00.0 action fw_activate
>  echo 1 >/sys/bus/pci/devices/0000:01:00.0/remove
>  echo 1 >/sys/bus/pci/rescan
>  grep ^ /sys/bus/pci/devices/0000:01:00.0/sriov_*
>
>Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
>Tested-by: Kamal Heib <kheib@redhat.com>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

