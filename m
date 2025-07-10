Return-Path: <netdev+bounces-205787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FA6B00246
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 14:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DA11BC57FE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBDF195FE8;
	Thu, 10 Jul 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PD8QGCWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F75A1E502
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151521; cv=none; b=IkDpkJWqm2oc5Xvt5qSumCJK+Dilx8GwwIsQYiLm3YazTwuj4DP2HtubYxdg+fyAEL4ZbQFiDpWTdPIjIlgtiTT9iyrBjXRExzOeKfOkD/ZosNAhFMQYC6RGg5lHM2KZlUj+0kG1qaTe8GUy+RWlssh35P1JZFX/4sTXu0PcP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151521; c=relaxed/simple;
	bh=ZAkfz9K+0DFOECuYR1ee1mMQIW37ePSW7fhKTJgZ3Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAoWP+t4KDRQLtPj55Ig7bqZmDM0IljdWVH9dczbupT0yLD0+EemMjVZH4YNMAtq2Do27pLhNTOmP/xcbh9RJ+Ap43JVDYcpb73OowsNSOkgB4x/JXWBRMsrRlWvCJEb56PlIrF+yjYYPs3R5kors44q0CWs4+FzRvk/pHkhdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PD8QGCWm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453634d8609so5656905e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1752151517; x=1752756317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7V2Jy57rLJPDlFLZ2eJPnYl+YS4GAvqF1OdQxGUDhoM=;
        b=PD8QGCWmGB17T4hDhojIqqWUubwN/VKhpewCQt841IP92MDdTTgTTvV6fuPRzq92Xj
         GMUHuu4USjuNkdAk3ahtPd5V0Tdw/3pNk/xbby/duP1QbeWPN4NkMM9S5af6uznpi1/C
         qKgHP/yYLU/rCyVb3r9IvKxZmRZLV+d3Il87tS/0pJNV4Cve6l9Hc3rW7WGrEHXn6bQ9
         qGbM6YdyQeb7fCKgPvuAE3hNxZQvsUsuhvHanPhln6tpYeO8K5kyRbik6CDJ6BXfe03p
         3tWSLUukjsoAJhKF1oFvs6H/XXMV4fpacvqNKF7IU3/djh6jRLeInVBAwub2oEWpO1y1
         DO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151517; x=1752756317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V2Jy57rLJPDlFLZ2eJPnYl+YS4GAvqF1OdQxGUDhoM=;
        b=crWGTewNodABkPgGX4yaTk1qpduqMe4BuXQZSVbogFNzy4ISiRaxhmG6eI6mfJkZjf
         RTOm7Se9X7hOYAia0mv3rhfUEUArxHlk/I+KN5VTCbeXSBk8Gl7fXMu/bd5jaLcFWD2s
         lxg2VoUGr0wl0EacqWLU4SEFl0i+ZEkcciL9B3SXmSxlXWTzlGzOW3DY5BOCmw+s1VsA
         fEr5+/e3tbpKMTy4KU1jh7Me+406ans/v9IIUvG1q9hB9eIfeCgPOwCNLS3mUYDoeFqr
         EoZ1VJvb/pUpCLppRHUwtWCttEkNe9pMNYxbrc0xJ//c+HrdxKR2nTevSKDcXyozzj92
         ukJA==
X-Forwarded-Encrypted: i=1; AJvYcCX3xeEjCNMF/i4MC82r9PmnVBej/bSbAJ6Z4WKIpbWKYcA0jfEJ22ckiGmNBNHXwDoG7u4E6mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxQNs9pyKuGUS5/ZqQO3qAOnCLR+j8SSJMs+DkJMu4wYfntz5
	Q/EdsgqFuYZSnGYPj8K2yDQ9aXlXVwlP9GPhHlkwNmE0VIoJ1jQ4aw8M8/SPqpi/7wY=
X-Gm-Gg: ASbGnctMWyxw8X3EnVJDbC83RQ1Cv2QnvDZVKMvdZ7S9Nd6pBuJCFctFMf2vhjjRQbu
	uAoxNfQ00ry9TOiy5kruApKW/obk6XWZ/j1p98rBHo8+wMq4rL12+DoFlzESW8dhkMNRMz0Amla
	ecHFJvW3h0LEtkF8pihXtNZQDy/sK4Eb3rkcWpv/xTW8Ej0tcBk5XloT6ju92Nq5QfcTa+8sI62
	dd7wFb1owCEpwH6tbqRn2ynvHxD6b5wDr9Fm9zH6+G3vJEk/AbUHl+ENzN3poGdq45kQoWCREHH
	GkXwi3SmyuyDKmVUbPj2XBMC7mA2YoYKtrkKcoK55od2Mv76AKLHpO+Cdz3DxVQ=
X-Google-Smtp-Source: AGHT+IGx6fDbwd7lrqPIKevMEfRvpZr9djpXkdIwRk0pq3cFu+jkIIHNa7pS0ErS8s+zew9K8E+8jg==
X-Received: by 2002:a05:600c:3e12:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-454de04a052mr17931245e9.21.1752151517320;
        Thu, 10 Jul 2025 05:45:17 -0700 (PDT)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d587sm1757152f8f.46.2025.07.10.05.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:45:16 -0700 (PDT)
Date: Thu, 10 Jul 2025 14:45:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <vurqwfc5yk4aalycnx2xw2whyqsxffmkkdat3qrshmxwpzjewl@vogpn4nkjylg>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-10-saeed@kernel.org>
 <20250709195801.60b3f4f2@kernel.org>
 <aG9X13Hrg1_1eBQq@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG9X13Hrg1_1eBQq@x130>

Thu, Jul 10, 2025 at 08:04:07AM +0200, saeed@kernel.org wrote:
>On 09 Jul 19:58, Jakub Kicinski wrote:
>> On Tue,  8 Jul 2025 20:04:51 -0700 Saeed Mahameed wrote:
>> > Devices that support this in permanent mode will be requested to keep the
>> > port link up even when driver is not loaded, netdev carrier state won't
>> > affect the physical port link state.
>> > 
>> > This is useful for when the link is needed to access onboard management
>> > such as BMC, even if the host driver isn't loaded.
>> 
>> Dunno. This deserves a fuller API, and it's squarely and netdev thing.
>> Let's not add it to devlink.
>
>I don't see anything missing in the definition of this parameter
>'keep_link_up' it is pretty much self-explanatory, for legacy reasons the
>netdev controls the underlying physical link state. But this is not
>true anymore for complex setups (multi-host, DPU, etc..).
>This is not different as BMC is sort of multi-host, and physical link
>control here is delegated to the firmware.
>
>Also do we really want netdev to expose API for permanent nic tunables ?
>I thought this is why we invented devlink to offload raw NIC underlying
>tunables.

Also, this devlink param is applicable even if you don't have any netdev
on top (e.g. you have only rdma device).


>
>Thanks,
>Saeed.
>
>

