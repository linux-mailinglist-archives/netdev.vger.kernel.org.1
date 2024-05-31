Return-Path: <netdev+bounces-99811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60C78D68FA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7EA1F2693F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0C7C097;
	Fri, 31 May 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hVxI+mdJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90617758
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180241; cv=none; b=SAJsXlFEnp5RoG3Udm0PccROi8q41wyjtUPMPGRMwEf47WiShAzZdhoR9g+eoXVVmDlhgouRj/hrvgOrLSjC0QqIsBOQ/6HIj5Uhn4n+uURccKq7c/mhq68sdlI7FJc542qcGDS31LST5ybbXFZy+HiJQ3GY12qNbLwymjCwXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180241; c=relaxed/simple;
	bh=YT/aQN35TGh8Chsjf5M28KpRij/hRyTR74fXiC+CKQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH/giJf0JldxR9AvSOk2zzEjmU6HiopkPDAPgmlnyvsPkMAKGeOy/aXagBaBBuCWNkvUmMa/V1CWAVZWX5CXXCxrb9fPWsW5oIf7rRRClHnGhUJ/EESRcU6Lkgaya/dlc03Lw2ROslN3JQXQxdpewFbBIaURo3FN7thaiXieRE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hVxI+mdJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7022cabdc0aso1831310b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717180239; x=1717785039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKzaRn43o/9ro5kVoZpov9f7l9ZGcLQ6ga/P6WrvCMw=;
        b=hVxI+mdJ1JIHQavwKz0L9E3mr8D6Y24GZINoIG2f+HjNFD2oOo5KY+JwTC9U2I8Rwc
         6KvUoKgH4SpFXFJnRcwhvFB5Ikwp38pMSgf/zPfWJTO2cBNPggJ5qy6rxr50BWUEot1q
         NLlANUMtvCChSPin2ae+wVyWC1PdZJYt7n+Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717180239; x=1717785039;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKzaRn43o/9ro5kVoZpov9f7l9ZGcLQ6ga/P6WrvCMw=;
        b=UGIcxkgJFjVROJ+/nyhCOF+51HSM4f7e/u4iqpmZi4RkuuUf9p78HXw3KEmt9iR273
         1VFK00cnVk/HICg26IRG51dFNf2QuUfMKPXiAURWCyRIKK1eY53dzCvBEpLzdfQv1jUR
         c+vX1/5b5VH+GUSP7lZwPiKySr9zzK9k0tKoFHaaDIUjZCOqK4wjzMlj7soIwvUmuVS7
         9KxIk7YCMtNTDq+uo8i/0Xpw3qIOCoataX01V9opC+6K38AbjxYEGZjjOLZt1LgH5T3x
         VVDgXX5NX6ElFvuWkroSlPU89WwFI/0W1pRnJhcVF5/ATW5f8oVt/PfE9qcntjuv6gks
         Q1dg==
X-Forwarded-Encrypted: i=1; AJvYcCWx3IUfcLqGFA4lvceGB6ETUGDAFN99IrAW3tEAoA7PgP88NVobLJEraZ07yyhgUR6zcHXm5O68s12j9oADdkkVdYUkaZXw
X-Gm-Message-State: AOJu0YycnaptVYQs1E8d2vL4onN84ks9jlWU6GsSBcp7/PVRGrRCvm++
	kPS1dgzwf4WRTYhLb12ZsBNhSCoq8UlDr2devgK9bR7ydS89hQCKgLN6jD6PsWw=
X-Google-Smtp-Source: AGHT+IHDAof3GghhU3bST8irgoZ82PH9+1MMNRPtS18E3V7MNmIpQbpjcgm+hwpgfDuo91V5+iaOPA==
X-Received: by 2002:a05:6a20:ce4b:b0:1af:58f8:1190 with SMTP id adf61e73a8af0-1b26f12a98bmr3112042637.12.1717180239224;
        Fri, 31 May 2024 11:30:39 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b055dcsm1721722b3a.172.2024.05.31.11.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 11:30:38 -0700 (PDT)
Date: Fri, 31 May 2024 11:30:36 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 0/2] mlx5: Add netdev-genl queue stats
Message-ID: <ZloXTJmCJlvh2AGP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240530171128.35bd0ee2@kernel.org>
 <ZlkWnXirc-NhQERA@LQ3V64L9R2>
 <Zlki09qJi4h4l5xS@LQ3V64L9R2>
 <20240530182630.55139604@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530182630.55139604@kernel.org>

On Thu, May 30, 2024 at 06:26:30PM -0700, Jakub Kicinski wrote:
> On Thu, 30 May 2024 18:07:31 -0700 Joe Damato wrote:
> > Unless I am missing something, I think mlx5e_fold_sw_stats64 would
> > need code similar to mlx5e_stats_grp_sw_update_stats_qos and then
> > rtnl would account for htb stats.
> 
> Hm, I think you're right. I'm just surprised this could have gone
> unnoticed for so long.
> 
> > That said: since it seems the htb numbers are not included right
> > now, I was proposing adding that in later both to rtnl and
> > netdev-genl together, hoping that would keep the proposed
> > simpler/easier to get accepted.
> 
> SGTM.

Cool, so based on that it seems like I just need to figure out the
correct implementation for base and tx stats that is correct and
that will be accepted.

Hoping to hear back from them soon as I'd personally love to have
this API available on our systems.

