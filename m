Return-Path: <netdev+bounces-158266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B1A11452
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B8B167B68
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF420E6E7;
	Tue, 14 Jan 2025 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ahyDEiFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C78C2135B9
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894718; cv=none; b=PO1LxmhwN2qBenyW8ECkLYoDwxR2CvVPS7XJ3sqO0toEBtxpiZ42InJmPAdSvg8XIUAT5QRqkNfWf50EZ67sPze1EHWMoGu+iKvCKsWi21H2RxGdasebKxY50QN9Ue/FhOxt8mB03oxFlQOf9fmu3wQNA5NdOMFpF4Rz+udpAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894718; c=relaxed/simple;
	bh=D2H+/P+jspEXBn4ZPJvywvQQVm62afclDDQi8aIUkDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjEpr3XwZXZdPH0/zeH4+0xJyB4RRNWWbJrBtOGLFD6/p5lw1tiSUTBnbPKoJEHELnxLpaKq/BpqTHpv1ftdcd/ChREZ3ypuQCZU35rCaIXzgMk0asizsRC1ABjD74HQwX9hmQyjWY5B9lHecg78JKi9erp4wj5OUQlaRvlxsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ahyDEiFF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21628b3fe7dso103549025ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736894712; x=1737499512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpgGy1rlvkFZUFKTF+Tyu4oueF8ZyKknNe7RhMva3Cw=;
        b=ahyDEiFFav6vsxZ/Qe8VQ0rri3cZwqtGv6kvf+X1QZL3kOCWb13k9nhd9YplU+Tag+
         pldFsP1TDRacYwdjaUNiShvOcvmWZANk9hRLcA/VluW54cUAO0NU/Eu9BefNYupzmAwH
         XLMFurucmXBruqStn9qhO4XaNs+pOEoK1kWFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736894712; x=1737499512;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpgGy1rlvkFZUFKTF+Tyu4oueF8ZyKknNe7RhMva3Cw=;
        b=YFVM/niIbuAo1mmFueIqRDkJE+ATigRJdhScl49fIf7NtRgKSR5avyt5HSaCl7hhtI
         15mgfv0/fKCbOwpYvnOom94dT+u9n1KVcTH0dSg0GZz5hzbXqdf90Ai7sVnahXNwkNMP
         xIs3ZuhfiWclsTH0NS6YEHVmGs/tvTPAgD/emSYwHipjQmwCQHmIdyNauX86Zi7BZVyB
         Ee27pC7uyvd6MpN+YJXdWi6vAfEAHn0NZGZWsC11NCkZ+CHVHiabp0Aptrjag5zQjREq
         Qi1IxIoZDOdFJ6GLY5PUbPws7XWxGBQ7Rd1iVnBML7lDOjEOSUa3EPsWu3XM+f1+/F7z
         jPKA==
X-Forwarded-Encrypted: i=1; AJvYcCUnW8YCJuuZXLygZ0Czge/X1QPqZ2Nr698pFhld3uArXnkxMKQxrmlhDNv7PmgTbhCYcKovO08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFK1+DDnQmAGqkZNJQ8Wd3mextfQzDhtkPWRqsXzAIB+aixUOE
	H4wcmgwuopmlbznQUjFgeVNWpd1QX0dw2hPRoSnS7t7GHiRKZsGT9sOrhv6Q8FY=
X-Gm-Gg: ASbGncuTMujkxKi6aVyjOrmPZrgiB8FvKfI2MndnUQBTjctZnunmzjmPl3cYmVeX9oL
	Q1VDn0AL65kp9C3JQp4ORA7V1W9HLyhy230Txc1QfYNAppjIyLLv8aoZzZGA4lwASnYAjsbppGA
	7yEoLeiy2cRx+99RecnF1eDlLWFp7zsGU0Pg5V46cAEAsKDSvmaWL+fDlccHFOlzqL1ZsS+fRaO
	d+6GHY1N871gpOPYlNTGU6auZ0f+XIjVVSHID1qMrnGQ8H31r4A+4EiTcY21XhenrDqsb5WXu3U
	a2qwJVXm2gwWni0o0KYoz2o=
X-Google-Smtp-Source: AGHT+IH6NJUCQ+W2v3EI0n9imKTXWaYcU87DBVaFkoUUA3YYyskKcY9tPvxx3a9GML+cG/CyDoqkYw==
X-Received: by 2002:a05:6a00:368d:b0:727:99a8:cd31 with SMTP id d2e1a72fcca58-72d21f47fc5mr36631352b3a.14.1736894711912;
        Tue, 14 Jan 2025 14:45:11 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e5d8sm7932454b3a.122.2025.01.14.14.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:45:11 -0800 (PST)
Date: Tue, 14 Jan 2025 14:45:08 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	jiri@resnulli.us
Subject: Re: [PATCH net-next 01/11] net: add netdev_lock() / netdev_unlock()
 helpers
Message-ID: <Z4bo9O5gGG2OBNXJ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jiri@resnulli.us
References: <20250114035118.110297-1-kuba@kernel.org>
 <20250114035118.110297-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114035118.110297-2-kuba@kernel.org>

On Mon, Jan 13, 2025 at 07:51:07PM -0800, Jakub Kicinski wrote:
> Add helpers for locking the netdev instance and use it in drivers
> and the shaper code. This will make grepping for the lock usage
> much easier, as we extend the lock to cover more fields.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: anthony.l.nguyen@intel.com
> CC: przemyslaw.kitszel@intel.com
> CC: jiri@resnulli.us
> ---
>  include/linux/netdevice.h                   | 23 ++++++-
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 74 ++++++++++-----------
>  drivers/net/netdevsim/ethtool.c             |  4 +-
>  net/shaper/shaper.c                         |  6 +-
>  4 files changed, 63 insertions(+), 44 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

