Return-Path: <netdev+bounces-217671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0B5B397C9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA98016717A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE422B586;
	Thu, 28 Aug 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="R/MFZaLv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A11C01
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371834; cv=none; b=kXEOyc/KSRss8Iqbf7dkQla+9To9oIN4yE3MdvpP7iGQyaTibVSj8X8spHMdIBzaW04ope1g+AdolPVrS8vyb5ccj4FninxEKwmHUd3qSc1pWZ2+P53qiQVYhe3/Q0SHpaPGoFt6YqpRtRx8uJZxCkEMa4IcD9qfN5fMB38wwTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371834; c=relaxed/simple;
	bh=P1Km7viXNhdxwdjmJkd8eGWJ5f9QqWJPyNfjEulm+ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uINndGcodDeuxwjSQ8UJJmdYZvNoUtyR3Z0+enj56tAuh4FlhSgR6gfBiKFXuGTWPvB111tdJ+0YYofONYs/zl6NjSW4NLkc4EgjZnXeFHHXWEmhyoaLxKvJ3OTr7a51z6i6dxa0CWD2yiYKEZ1dAYvgJQP22JhCfvgwwkO6bo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=R/MFZaLv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b7722ea37so1722655e9.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1756371830; x=1756976630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/tMGPUR6oWh2VD+AseVEvZ/r11JVAy4s+xORZuZrac=;
        b=R/MFZaLvBWrTDIPMhHquzrtw1ZWJRiEQj4DzXH3tVklmvs/YUYsMTX8XwU2/IOJymG
         YmI305UI8aXxmjF5Gf1aCbvavcyGv2SNxZZJgRlFBv06k98j9ZDHkJUZ3XRyTs4uvr/K
         wn8aCDet6WLVlHu/b2tcDrfxYEX6tY0sN24rXH5KXEMQQyeMomXSu73grJm8FJhpBXIH
         r4qrLFujyVxvPXjkT5c7ogt3i6W3kadKn+7yuMZ/6kmr8ptmvOx/VYlJo2p2G7Eea1p2
         WqK1WbEe/uzn95WZlueXT+ZHAU6Eq0PQVjegDluVBB6a2BZwKYZqmxzr203Mm7RJdQzk
         KuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371830; x=1756976630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/tMGPUR6oWh2VD+AseVEvZ/r11JVAy4s+xORZuZrac=;
        b=LlXNmnMfofv2Y7fQwxWctxQac1rBHjD8reVYvB3c5pAtEhQ9rjGCC5Ns4zFQHeAQep
         j3IV0aAb145syRXetLj44KqnlI/VrxHN9Xtwl5O8Sgt2VHRAIAePI1fdUiqbwEgDCf34
         4yD+CEWvX/psUflwe/9oB4/HL53aV/JJR27IQeta3Wlynu++3vIIzVoaB28dcWDRBrMi
         xzR3LYimCPC6FgXM9mgWFHVqi+zdGsTc4MEo0/ud0B5qkXJ8FZr5Yy9SBwE0fxutQVRx
         zcqP0RFltfzcr9BpuB0uNIuPzTlr1gA+fuQCxog/dgWiUZvJsUThFsQ1pro9lvrmDmFE
         p6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr4wbPJK0lKo9enAs+/dK3O2USl1HL9q7RyjzI8ozKS44AStq90MVg2pjtIxpa9MAkg5f+X2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkziC90qsQKrhdCYlbcrGaij7qQl9fsrEI3fNzC1771AIqav/+
	ASYhkwAc4cgjDUEeOHasYYIUt7FpxM9HyX6m/Jjc3fK1/gS9l81R2c3ZUHIQ6z3eQvg=
X-Gm-Gg: ASbGnctadGJfqHJ8SUTiwT6HLNB3M57aGN4VTnhgWTMj6hgzZKB62uAThGMJlhqrI5Q
	YnsgEcNbu3AtT+j+iL+7sP4gO6jGbArzL4CwybBqiWJF7z0Si7292fj0+XjTfclQlEc/Bvr0rOz
	vhzdT6yHXU0TGGe5xpd/GIvmv0SG0b8DFNgE2F8XDjVh5JCzXbiKENSeO18tQAPTusT82gwMZDY
	ZGSX2YZJesjimQFgT32D9cuu4SaUGkNTAerMmbVOdS5nyc7e1JZ/9m+VHpnE8fvCY9uEY6Yq2pH
	+f4WYSB+smNGruWyJnuorlARaP0meDiMW/E8uRHILf98T/9K8L3Q8A5H9BoU0zd9pFAGnUiLrwl
	9zX/dRckZi0QDrzxwRsClypVl0+AZfPiZfSU=
X-Google-Smtp-Source: AGHT+IEQkb3N/KBo8fFYG98LYdWj+YzrY4TyITmKn1kxcqsHzLx+fbBxRmb0Q2QgmqZTikTM5/a1lw==
X-Received: by 2002:a05:600c:19ca:b0:45b:47e1:ef7b with SMTP id 5b1f17b1804b1-45b6870e3dfmr83816435e9.17.1756371830191;
        Thu, 28 Aug 2025 02:03:50 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba390sm25342324f8f.12.2025.08.28.02.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:03:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:03:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Shay Drory <shayd@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ozsh@nvidia.com, mbloch@nvidia.com, tariqt@nvidia.com, 
	saeedm@nvidia.com
Subject: Re: [RFC net-next] net: devlink: add port function =?utf-8?Q?attr?=
 =?utf-8?Q?_for_vport_=E2=86=94?= eswitch metadata forwarding
Message-ID: <ilh6xgancwvjyeoqmekaemqodbwtr6qfl7npyey5tnw5jb5qt2@oqce6b5jajl2>
References: <20250828065229.528417-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828065229.528417-1-shayd@nvidia.com>

:q
Thu, Aug 28, 2025 at 08:52:29AM +0200, shayd@nvidia.com wrote:
>In some product architectures, the eswitch manager and the exception
>handler run as separate user space processes. The eswitch manager uses
>the physical uplink device, while the slow path handler uses a virtual
>device.
>
>In this architectures, the eswitch manager application program the HW to
>send the exception packets to specific vport, and on top this vport
>virtual device, the exception application is running and handling these
>packets.
>
>Currently, when packets are forwarded between the eswitch and a vport,
>no per-packet metadata is preserved. As a result, the slow path handler
>cannot implement features that require visibility into the packet's
>hardware context.

A vendor-specific slow path. Basically you provide a possibility for
user to pass a binary blob to hw along with every TX'ed packet and
vice versa. That looks quite odd tbh. I mean, isn't this horribly
breaking the socket abstraction? Also, isn't this horribly breaking the
forwarding offloading model when HW should just mimic the behaviour of
the kernel?



>
>This RFC introduces two optional devlink port-function attributes. When
>these two capabilities are enable for a function of the port, the device
>is making the necessary preparations for the function to exchange
>metadata with the eswitch.
>
>rx_metadata
>When enabled, packets received by the vport from the eswitch will be
>prepended with a device-specific metadata header. This allows the slow
>path application to receive the full context of the packet as seen by
>the hardware.
>
>tx_metadata
>When enabled, the vport can send a packet prepended with a metadata
>header. The eswitch hardware consumes this metadata to steer the packet.
>
>Together they allow the said app to process slow-path events in
>user-space at line rate while still leaving the common fast-path in
>hardware.
>
>User-space interface
>Enable / disable is done with existing devlink port-function syntax:
>
>$ devlink port function set pci/0000:06:00.0/3 rx_metadata enable
>$ devlink port function set pci/0000:06:00.0/3 tx_metadata enable
>
>Querying the state shows the new knobs:
>
>$ devlink port function show pci/0000:06:00.0/3
>  pci/0000:06:00.0/3:
>   roce enabled rx_metadata enabled tx_metadata enabled
>
>Disabling is symmetrical:
>
>$ devlink port function set pci/0000:06:00.0/3 rx_metadata disable
>$ devlink port function set pci/0000:06:00.0/3 tx_metadata disable
>
>Signed-off-by: Shay Drory <shayd@nvidia.com>
>
>
>-- 
>2.38.1
>

