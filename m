Return-Path: <netdev+bounces-90546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3795E8AE714
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC66B20CD6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A82129E95;
	Tue, 23 Apr 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vIuHSojF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A537E765
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877015; cv=none; b=k3o9gq16QoD9a3AzKw92aAKYeml5hEcOCwlAJHFjm3Ga1enX9suLQvlaceN2zpYeElYMbN62RtLWNfDZCMLDZis2uOBj+rWzbsJIWRjBmik0pXbOLV2DFtaNdCg/O+ZkT3bKSRZIz2OUQmopiej1vOim3oxqLZSMv1bChP9Q6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877015; c=relaxed/simple;
	bh=f6Z+o+xgj9PM23FyriN0xzEPc3uiy9E/YIUdc03valU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKVj5Av+DlRGTykAzutOtnU2bwTJunSapACgci3GlCEDrWsQaGJFJukwie5ErUjCqbdSIplui9PBR22nwz5Y2z0ZgW3WELFvMmqqhJ4320OMlqRtQWhJmUz29nX2V4km6bpyYDTptTLxgu2k8Wnxjf2YRccTbOkbpjTjlXkCVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vIuHSojF; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51bab51e963so728067e87.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877011; x=1714481811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6Z+o+xgj9PM23FyriN0xzEPc3uiy9E/YIUdc03valU=;
        b=vIuHSojFtK3XYpB16TFKoOissahrx43Aw6ew7pZbdD0sPlF9ZAICotBpAaqlcQfAfG
         vheAhS+GvK2RZvhFEvRAv0AEzcOiQolG7TDw6h6afvYjlq9Ddy5u6hnL/ZtfgW7WiMAQ
         lLFCef2IRhrQsk7ZpVwnfbNkubkbrU1Uuuyje/mk9ZTF4UyL0eGpPxrSnLxWc0RJJSK+
         rfsh/liA3U6KKLsUnMgtB/J4dAvujnWFirMi0I5RIadtMjOY5TS88HhVx5//rJVfjA50
         Rho8wQIZrBSiYA6XDWwKCLeuWQC/E0K79oTaIDxqwPUFS/mO/ekP9h+UxXaxLIwY6UB6
         h9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877011; x=1714481811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6Z+o+xgj9PM23FyriN0xzEPc3uiy9E/YIUdc03valU=;
        b=os49AiVO/3vFd/p0bnUis+cXdV9GYWujxlzLVRRXQz71iC9n8NBwghrKGtt22F0jzR
         M0nD+NxhNJreJ437WHucLj9AQF/fVc3Z9TPB0OZKAaT+4uPS6jXuckqEbMWZdCRl003I
         v3z7SqL+N4644vRoDSP95uT3E0Xa8AZa/Acb+ZAdKa+/iajhYUSEQfbGTrl8MB175vpI
         DChBYU49fbecPIQ0JsA3KgVRJ6HGPooMaE8TwMgbPAJm+xUyj/pQeIGuISyOIaETgiIW
         UnxHvpDpcTqwGKp3elRmGworn7nC060d0AnyWXEOIegGefzgvNkrI+o2hQljGclqTb9j
         ZcOA==
X-Gm-Message-State: AOJu0Yx1XAH2lC3Q7G3TjqOTlLN7z9hZYoPkR5ct+qE3d80xwYJf3KRj
	yvZEODmA911JaMovgbXPeBZPvq5Kge6RdGS+4KhqL+tAf/sx/Tt5fkGYdGXnP1A=
X-Google-Smtp-Source: AGHT+IFFuhrISIMhxTfW6IGKz1USrI/VzV1UhYtSxvpvIJMgOYCxg57AMxIr7EOvnNCAfxzw/2nmmQ==
X-Received: by 2002:a05:6512:3693:b0:513:23be:e924 with SMTP id d19-20020a056512369300b0051323bee924mr7414572lfs.59.1713877011358;
        Tue, 23 Apr 2024 05:56:51 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170907360200b00a55a8ec5879sm3408082ejc.116.2024.04.23.05.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:56:50 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:56:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH net-next] bnxt_en: flower: validate control flags
Message-ID: <ZiewEJb7KHXeoFeJ@nanopsycho>
References: <20240422152626.175569-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422152626.175569-1-ast@fiberby.net>

Mon, Apr 22, 2024 at 05:26:23PM CEST, ast@fiberby.net wrote:
>This driver currently doesn't support any control flags.
>
>Use flow_rule_match_has_control_flags() to check for control flags,
>such as can be set through `tc flower ... ip_flags frag`.
>
>In case any control flags are masked, flow_rule_match_has_control_flags()
>sets a NL extended error message, and we return -EOPNOTSUPP.
>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

