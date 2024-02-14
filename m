Return-Path: <netdev+bounces-71750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25559854F07
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A923228FB3B
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC085D912;
	Wed, 14 Feb 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw+ATCYY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AA60B9B
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929279; cv=none; b=YXdpC8qILtIE0r1yZ4Cyu/Qjk4DwkTN8mJ9QjouBOV0wHB8wI705S4hA7J/g0AM8D4S9atxgMN0uojmxW7f0QWmu2vV0DAakhhoiEAziRgzwsN1LZv/2dYim6M+MZtbASUSZTTLbPAHcUKpSmOzDQS1lv4obWshlyvIUTV1PVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929279; c=relaxed/simple;
	bh=XwJoR7TTLG4MhprZasOKMxLMrkCbF9FIzUucdvqZnQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vm02Tg3q5lURMQS/wOTN5b5ubeoMa1ynxEvPP/yCmuvZ+vFKvPEtIFqOywzucxKdHfWKQTADsRB0mRkIIBcekSofxs6I5bGPELQy3Gk5eXJQFrZ2/QlUHcqwgLIpEcHnug82iJ/xYPHfhgrDlruBDGcJ0ozXhud1pOugtQNFuMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw+ATCYY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d159220c7so244120466b.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707929276; x=1708534076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vGriv4qu9uDXvdDYwIBv5PlmXymEIEo1vLNuMltzEs=;
        b=Gw+ATCYY7I/gSKe2JNdn5lM9yty7gwqlnrRvO4u01L0N1FAIDS2hwuG37MzgMNe4A9
         wsBT7NeYznE0+VM2hCorvKLBwAq+VnHfBJKdkKWG+YwX3C34aUfgeQQSZt8qRBLVmU3/
         NJ6clZc9inQ3nMqdSNnEewYfvsYDJcLLKYvDgNtSoC5utKgmGeHy60cxAQfPp5s397st
         CpDwBfuK7hLz1Qy7fYEmwLVdA2vJrK6izNBN7V+7VzzZKzuM2p+6QfUsuf68M3D/kYyL
         NfxDEo4V/umZlKICyHHUrct1x074AfmDJ/OTOtGio18n6tPDYyP5N+8/9I4ZOJFdzCdz
         nkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929276; x=1708534076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vGriv4qu9uDXvdDYwIBv5PlmXymEIEo1vLNuMltzEs=;
        b=b6xdUZ6d9SHr2uJ98UAPGBx7CJAPElWPpprRXKEnl7a83TP5UY5zqFsYeokLcuqRUm
         87ISqdS2ivY6FVCqX0SueFRbmzO6p1jLzjvdT+g1uSr7te+Utui9lsMp1Mfnc34m96+g
         gZRB2xeq4VgLr6n9U1oN6g3vH2s1XaXzaMkTnaqQNl2Kmp6Lhpe0oD0ftxXjjenhir+1
         rPp6XE58qpXIXZond0k2CUl0Ik1kNjbbfwlnZLjAHJ9Bjanglqqr2GQFyjz1j9KBU7CR
         vjsYvhPi1ovAiZGQBGCvica94RmCdOUWV4p47hhBrd2mhv/NdkHsTKoYbei7D1okGZDI
         43YA==
X-Forwarded-Encrypted: i=1; AJvYcCVLgd6flZrzrHIwlXoEAom5qPVowVtrZJldTyJ/mbFrFwttPyZzZVS7g2zwUVVHtZYeh3II0TDbzMLCcWUApXeruPmjkfKK
X-Gm-Message-State: AOJu0YzigrlcuWaH9fXL1+1CvKxyC11Q4GZ7SQbTPMzVoYDKGc48KItR
	L4n+k7iLUDixpZ7PAKEaU0ygpkLxf7rhwwvJerp/M6uI94zThdCW
X-Google-Smtp-Source: AGHT+IEMXax9TzmzcnyStu4w1MT7WsccQURF7KPvDKKN8gNAYkxWqTVPxY20pbi2VoURpx2/JU0sxA==
X-Received: by 2002:a17:906:f158:b0:a3d:1458:5e58 with SMTP id gw24-20020a170906f15800b00a3d14585e58mr2228545ejb.46.1707929275854;
        Wed, 14 Feb 2024 08:47:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8YtrNjenuTOuCM0oYZNDFSvWMlZ6YQjarJ2gF5TliS4Qgjctw4QduMUlCoWU7dJhd8CdrkKy9HPUCm9o3fasEigbgh97goEvxkvy00IZ+g/1ZJyyEmMY0HAUijumHgg9/WDDWCcAjr29Io5fUHXYlCCqd6vO03S/X5oKKYxigrRm+tqhkrqRY3oqLL2Gt3RBJJV0TQhtmwI9M6I2ZnegWDovLoQm6RosE/sO/mx2YmWkW8a07vqwwdFfj6lCZG+5wTbFr7+bGes9AeRzxp8T+
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id vi16-20020a170907d41000b00a3ce31d3ffdsm2327431ejc.93.2024.02.14.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:47:55 -0800 (PST)
Date: Wed, 14 Feb 2024 18:47:53 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, atenart@kernel.org,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH v4 net 2/2] net: bridge: switchdev: Ensure deferred event
 delivery on unoffload
Message-ID: <20240214164753.6ij6ksdgz5ailemv@skbuf>
References: <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-1-tobias@waldekranz.com>
 <20240212191844.1055186-3-tobias@waldekranz.com>
 <20240212191844.1055186-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212191844.1055186-3-tobias@waldekranz.com>
 <20240212191844.1055186-3-tobias@waldekranz.com>

On Mon, Feb 12, 2024 at 08:18:44PM +0100, Tobias Waldekranz wrote:
> When unoffloading a device, it is important to ensure that all
> relevant deferred events are delivered to it before it disassociates
> itself from the bridge.
> 
> Before this change, this was true for the normal case when a device
> maps 1:1 to a net_bridge_port, i.e.
> 
>    br0
>    /
> swp0
> 
> When swp0 leaves br0, the call to switchdev_deferred_process() in
> del_nbp() makes sure to process any outstanding events while the
> device is still associated with the bridge.
> 
> In the case when the association is indirect though, i.e. when the
> device is attached to the bridge via an intermediate device, like a
> LAG...
> 
>     br0
>     /
>   lag0
>   /
> swp0
> 
> ...then detaching swp0 from lag0 does not cause any net_bridge_port to
> be deleted, so there was no guarantee that all events had been
> processed before the device disassociated itself from the bridge.
> 
> Fix this by always synchronously processing all deferred events before
> signaling completion of unoffloading back to the driver.
> 
> Fixes: 4e51bf44a03a ("net: bridge: move the switchdev object replay helpers to "push" mode")
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

