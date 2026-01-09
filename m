Return-Path: <netdev+bounces-248418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3DAD085DD
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E996530118E5
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158B33508A;
	Fri,  9 Jan 2026 09:57:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E22335562
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952632; cv=none; b=gUbHSKESBeDvsukmLtBUhBUkDV6BKU1hwwNJpnRm0RwpDFDftbDo8i+gwnY90Vkf7Fqqb3dFFD2CYiLOpPz49EN1oDtrsrupBeDlP2+CxVYfrjFSbMN5hrcc0XrUizlMMs+MlBQfXMUmQ2ytQNtIuYjGB8KTvqwyB1eo26ailjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952632; c=relaxed/simple;
	bh=ZIv2ks0v+I5xUjrsxuPT5slTgULmlLe7AeTQkxhYLdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2EeMm1mMIr/+corqPVC0iRXr7t9l6ssjEoDmdebfiPf25NouyR+C3ic71vC3xJQsN0MHtwpVcNHrwup7snJcOFB2Q2F1zB8PHCEsW7/l538PNde8Hlh2vzDXE5zULHdcjt+rXqkpnNceovbXWQ0HX/xw8sOT0XcB2l3DIMcvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c78d30649aso2854101a34.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 01:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767952630; x=1768557430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kflOjGXSHLopFrMVAwp7IfrEEKDXiVUp2sZg3tRSfEY=;
        b=kxOkj3TwtsfVk42vQ7ZTgWGW9Xa2uMtpJenqqAf/P1+lM9IeTcGmYa5L4pqlR9cFcf
         PDf5OlB9IcnJKGwdLQ6q6BEex5bW7lYvRUgEg/L7FvXOYgbKNaPfwSld7Z3bQQDz0val
         uKjXNiP5pcDJWr8lJMNZflKNbRTqxNT7O6jfxnvZWmp0+RCDhyaUVCBLtduQTV3RhdVJ
         K6DIMnyBIBiIqsFQjMZnuLgI39kpfCssdnd59ZiIvkZYk6+ymxuJ/PUYT3tfYJfhNfMq
         TIyZUerbD5FMljdz2cHWaL3b1hGsVVAGrezC2/kAkVkQk3nyAXfy2HdfMfGu/VfmXupy
         7ctA==
X-Forwarded-Encrypted: i=1; AJvYcCXiH0HW/ItFS3W51zu4smJ5ZtRAiAM/u+W3yxffwj4+X8AB4iDgIpUQlfECfO8+szOdTWMgvr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdISDZBm44zMZ2W64PWGZ81/WUcr4qvPFzzVAD1GDb/VnysJjc
	kbX+9iQN4Zps2NVdTqKjl8P5Z21TmCe34stHkdUu1N+NQurjbO5k8Sqt
X-Gm-Gg: AY/fxX7/YD7s8GqxEgSMqLstJVWhIzPyaVgllVOONy3qm5x81XfHGEcXcQzUGlTFFRC
	+Lq5r1t2aeBdym8/c10g6bRuniMlck2JK6u8PJgL9Sqxtnp4/MnPgKx2G5KctHhOPvgKWXUhK/H
	7fsr5qgPZ+h7CkOPnVD9Q/AYjLjiDiX8b4qJl2s5RiPsad8Affb1/fti68El8eZc7q++9qoUUuo
	r5V9LJFlMCLGqjvk9msFyvQj3a8lyMfAyhvEv0N8apjWeE8OCXdNBXaBKD9HLXXi2BvoT8+N4KM
	c7mJFf5Y6Urnt5lVIXEmia0s+3OhEpGAdMtjWKr9p8bdwsunbyNF4D72Hue48GcYLK6KnkzYmMf
	5y6NC/A6ZLkCyTWefmvSf/tBSSSGk63aT45a/4GSV4E7eLohoa2/8dmR6vznaiSHxuaZlBhG5Qu
	Cf3A==
X-Google-Smtp-Source: AGHT+IGbTqhczWhIwv57lJTTKxd6slxfMkmNFicxm0SXSHnh6M/fl49RZ59Em0oW1pjz3+D20eebBg==
X-Received: by 2002:a05:6830:3c1:b0:7b4:f1e6:4957 with SMTP id 46e09a7af769-7ce50a02094mr6090839a34.20.1767952629685;
        Fri, 09 Jan 2026 01:57:09 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm6552444fac.5.2026.01.09.01.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:57:09 -0800 (PST)
Date: Fri, 9 Jan 2026 01:57:07 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com, 
	jdamato@fastly.com
Subject: Re: [PATCH net-next 1/2] selftests: net: py: capitalize defer queue
 and improve import
Message-ID: <jajmjcfg7ga76ueewfosv2mwd6ndbxzzeugtdesmk2l55frfx2@miahmmhzs3ra>
References: <20260108225257.2684238-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108225257.2684238-1-kuba@kernel.org>

On Thu, Jan 08, 2026 at 02:52:56PM -0800, Jakub Kicinski wrote:
> Import utils and refer to the global defer queue that way instead
> of importing the queue. This will make it possible to assign value
> to the global variable. While at it capitalize the name, to comply
> with the Python coding style.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviwed-by: Breno Leitao <leitao@debian.org>

