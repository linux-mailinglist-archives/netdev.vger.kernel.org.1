Return-Path: <netdev+bounces-77809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E377C8730FC
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 09:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC6128B3B6
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F3B5D730;
	Wed,  6 Mar 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HuQxIgDo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2965D49E
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714600; cv=none; b=cEv3WEck6OjEUY6ntkk620HhNF5+GMymx+1g31k8KqXY4jZTJVWoWD0GCJi3vUGrB4E030tmU+e3Mi2hgUHQuVq32XRyD7qEmdZ3946SqkZr707rf/tBTA5F9yOaW3Ss8XqxqNem95Xj921gU4kmJiBAMCfY0r7PIVfbFpBF+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714600; c=relaxed/simple;
	bh=PR+Nk3pCiZKxNZDXI7fJRBjQbinANPBrnGZjGnCs9/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYKa5YVKCDR6/vhJFc/G9tG8tSOXDQkusWV/5KxwQgnmIK4u69Lg2KBDwIyIdTY+29ew642JaOkZVmpEQlDV6XZEOqnREQNrSFYSsQwamHitly96CZBm+w+j9mQkDBlmppJTsVtMq06O7YeBbeYUpaBAZNg3eYRP0z9hQKahuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HuQxIgDo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so8392865a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 00:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709714597; x=1710319397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PR+Nk3pCiZKxNZDXI7fJRBjQbinANPBrnGZjGnCs9/A=;
        b=HuQxIgDo+HERjwUeAeA9smZB6YuhpawhISW6KO7HAUX4QCPh8n0G1FdGs4NcA1ObsB
         W6o/HfC6m5rBoZTl0fE3CXXcGYh8fvbRzeTdLFilHjGh2FLPffv3LQ7u68PuCzUQ8Q7v
         X3m8SpLpetts2AooEHs6PA4oo11doOuvEX/O6F22CYAXxtAH4COJPrh0fHoIFBp5qi/j
         eZkmFHjvM7RCV+RyoaU0tDuJUiA6sln9vOUbmPQK6dG48qDuT0VEGS+IBVy4WkgXFEve
         KmwmMeZ4s4nY4FvTIjCFxbrX99jmsdf46wztWdiFIwvKX6wh0mZtMexR9L4scWOhDuKJ
         thOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709714597; x=1710319397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR+Nk3pCiZKxNZDXI7fJRBjQbinANPBrnGZjGnCs9/A=;
        b=e0jUz0joKnjRp7LdUfOJ0q+6uho9xuAHPg4bpkXET0sNBrhoHRWBxede1AbKJ8Hg9g
         mQszefDxzY+6JKQUC2cCN4yJ/h9Cm9zOhr/j691LYQvaPUZrdCYtcN6rNhfN11Ky3CWr
         yLlRKHl23Guw+NITb0QlXGkDYS1zAWRgEMKbm5n634vln5OTu6v5LAVx93aGShsW3wFP
         y+odzWOVd9TGYqQhDf1YfH2w7GcaVy0M9emW2YVLgcIQ+ITUsM5ovZHA2/BJ4Z/rxDNZ
         3SmiM0N7CAvuul3I25B8dLoA866lYQLcHQplAzg1SfaPzzHZlyWnFDydoL0sQHtzWazW
         lpwg==
X-Forwarded-Encrypted: i=1; AJvYcCU5NrxE9p06IHJwGMv0Rcl1S88cNChv050wVRswcuAslz3aeZdMt7FY8GjCT9XkmQcPqqrhoFCUbcTiJB1QvuhcC3hDy5Rg
X-Gm-Message-State: AOJu0YxegZnes8iuDVICCR6BMw6NcOyxVYe2JyBEG/9DD1ZdVPGUVV4O
	2YdiRGFptov9C1vz4oFEdYjTeGTq0wYyR3+ATnxxQ2wkM7gdAE7Vgg9NlnUSzyM=
X-Google-Smtp-Source: AGHT+IGyYG/nOCxuZnL80qCIb7SDO35oUUKTkZuCFl7a3pHgumTeZUt3jFvFSSgGwHFqzd5t3COW/g==
X-Received: by 2002:a17:906:fa8b:b0:a44:4c9e:85ef with SMTP id lt11-20020a170906fa8b00b00a444c9e85efmr8081171ejb.77.1709714597555;
        Wed, 06 Mar 2024 00:43:17 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709063b8100b00a4324ae24dbsm6886108ejf.62.2024.03.06.00.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 00:43:17 -0800 (PST)
Date: Wed, 6 Mar 2024 09:43:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, kuba@kernel.org, horms@kernel.org,
	przemyslaw.kitszel@intel.com, andrew@lunn.ch, victor.raj@intel.com,
	michal.wilczynski@intel.com, lukasz.czapnik@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v6 6/6] ice: Document
 tx_scheduling_layers parameter
Message-ID: <ZegsovsvS08Vvplb@nanopsycho>
References: <20240305143942.23757-1-mateusz.polchlopek@intel.com>
 <20240305143942.23757-7-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305143942.23757-7-mateusz.polchlopek@intel.com>

Tue, Mar 05, 2024 at 03:39:42PM CET, mateusz.polchlopek@intel.com wrote:
>From: Michal Wilczynski <michal.wilczynski@intel.com>
>
>New driver specific parameter 'tx_scheduling_layers' was introduced.
>Describe parameter in the documentation.
>
>Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>Acked-by: Jakub Kicinski <kuba@kernel.org>
>Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>


Reviewed-by: Jiri Pirko <jiri@nvidia.com>

