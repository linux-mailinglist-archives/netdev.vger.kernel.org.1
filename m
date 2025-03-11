Return-Path: <netdev+bounces-173900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BBBA5C2D7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BC3176718
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9547F156C62;
	Tue, 11 Mar 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AYP64sv5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9378F5D
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700315; cv=none; b=LNNgP6IUm3qnr7RAtkGLuZ9m2E02iXTC/OEsjlbh8Aqm+zrxJGEYVX3mXx0KWDBCsaX15jctujUHzGroiai2wE+neX0E1zAevEZNrLDwHhGEcJbN3GpUF+K2H3Y5q1QTDDpNc/IYxGmPKHDi0ep8HZuulMOlodHzRkI7JD3l5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700315; c=relaxed/simple;
	bh=bBJQCSVDhR9SsbJ+kSxMhSOrKIM8NEQTA0tZt72ZIBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfSEyels2fas76ZgX7ULxWLI+ghUosXl44x1fM4Zm4Re3KSphOMMeMN20DsPxsciEoRto4hMb9/VxDLPDrNwfqCbF1JzWTiGW55f6fXYMpzrLaBf2MbourWfr9d0+GxdYwn51RxA1Uk9Z3J4Ou4Rz3Da141L+vp5Gf2hqVHkI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AYP64sv5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso17604565e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741700311; x=1742305111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bBJQCSVDhR9SsbJ+kSxMhSOrKIM8NEQTA0tZt72ZIBE=;
        b=AYP64sv5VjWmcle8THL2IQRxH/cq8d74cNOK1X7kH6/mBhaa/FsPHt5BZtWAR9QzDm
         xmHPqk42Yz4I+QUo9S95P4ke4aKGW9Ps8XOAABM88fEqpblbSaZpsNLRUwH8UQP2ycya
         C08MNO/Nb7+dYz8sTLTz4GrVbRvUGyFMDzSJagJv4hg3sJBTt2+XsPpJv6+6mx9/T1a9
         lyTGXfub46IDd+d8sUCTdvi3iZqYPO99PEOkgakCVX+QjnpFkbJvgOFLiOnzblQxUSWQ
         +wcvyRvAbPvxjU39U5tINf94oXHEGK1N73BWbdIeIAN13GMqljKJ7BaELI6mQTfZl8VN
         x1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700311; x=1742305111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBJQCSVDhR9SsbJ+kSxMhSOrKIM8NEQTA0tZt72ZIBE=;
        b=q34VYjiwflPzqtU6L2Fl8fezGK1XX79TKtl3ORNpyk+Ey6ggBTFhjUh+aQEN+cSRbB
         L7J1VfUE7dKc/zTOlvsqAhP6BwYq8e1GtNopRHhMGvKiod7/xizGxP7vsm9EjDN9SrmX
         LwPgNMXrqZfCxTD+DyFeVuaYg3mIdEw0dfZjkpCXUQXY6zc5yRoWk42pNH5fLMSEMA36
         aEid4AaxVkdcdBfX8/BhWWwQBu8K/r4+Q4SF4n7JUm6Uad7bl5q4wyU1MTVc5ryYblM/
         C35Pw6QgWiqiaMMprJ/2/YuAO3JMfJcdloH1UR9EZTGdJLXa1L9RdOmWerC90t+GeG/i
         UYYg==
X-Gm-Message-State: AOJu0YwIcxhULSPylgtAY7/NXK/r3GaKT8brIRRszdmC1CMrtGbjwQ0M
	KLWGQYM+JaAT6kPG+aGjPNqq95c58UD1zLguyGnRjBYWEo8WL+B2EVH0aHBq+1Y=
X-Gm-Gg: ASbGncscrLCcz5Le9MYseDg1Pk/yhvUvaakBk55QS2eTPhMsX/w5oG/FtxFWYhaepI7
	QSLA6cc82O794VJ5Kg80m/4Rey0plzyorMvFEypFFlDTq4X1wGxFUXIfWI+pJ9+6Ge1ek32SmK2
	kwN94US2Up0D5QYO3CTxYp8BQ20k6bmqx51Z5nkVR2qF+B7MBmXOFBxStK7E+gh6KZgJKFen7/7
	7rDdW7hgjyv38q1whDwZivWt4k7lmsz1kVKW8tyqQpuIDBhA9BNHxNpb3MlSqQNQhpGpRgz3PA1
	i0inpXswD2AIGPWLtt38qvgXAOscXjfdlt60Xxj4JV9cnpoxrfKLtSsmZffbqogRNgOymzM=
X-Google-Smtp-Source: AGHT+IHI30fvE7HydHTlO20/cfGLT5bdzqrK3KYWhu8babl7x/IMoS1GTjRhMhqNQEazIh5LGz/89g==
X-Received: by 2002:a05:6000:1862:b0:391:2c09:bdef with SMTP id ffacd0b85a97d-39132d87f62mr14447036f8f.30.1741700310880;
        Tue, 11 Mar 2025 06:38:30 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e34fasm18264807f8f.75.2025.03.11.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:38:30 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:38:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"horms@kernel.org" <horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: net-shapers plan
Message-ID: <czbmzydl32avn6gnwfrsmilemcmajcklnsv6rrlhrcas7iwpjc@wmqwsth6wj27>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>

Thu, Mar 06, 2025 at 03:03:54PM +0100, cratiu@nvidia.com wrote:

[...]

>
>3. Add a new DEVLINK binding type for the hierarchy, to be able to
>represent netdev groups. That part of the hierarchy would be stored in
>the devlink object instead of the netdev. This allows separation
>between the VM and the hypervisor parts of the hierarchy.

[...]

>
>3. Extend NODE scope to group multiple netdevs and new DEVLINK binding
>Today, all net-shapers objects are owned by a netdevice. Who should own
>a net shaper that represents a group of netdevices? It needs to be a
>stable object that isn't affected by group membership changes and
>therefore cannot be any netdev from the group. The only sensible option
>would be to pick an object corresponding to the eswitch to own such
>groups, which neatly corresponds to the devlink object today.

Could you be litte bit more descriptive about this? I don't understand
why you need group of netdevices. I understand that for devlink binding,
you have usecase for group (devlink rate node). But do you have a
usecase for group of netdevices? Perhaps I'm missing something.

[...]

