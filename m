Return-Path: <netdev+bounces-75839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B905D86B514
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF591C23EC2
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AD36EF02;
	Wed, 28 Feb 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="GQldds7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474221CAAB
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138022; cv=none; b=twtmbVQ2ySXp0hXpbdUsFO9ox/8UCaNK5XJINj1D2o8WyAuyH8lnCS+FTAsoIoB/5Hlh3uT112tuegX68QDJgIp29V7UzSWYkMHM9Wl2W8lB2KHpcaMboyq8kZ0LhmC4nQ9hsqVWG39x02EbH8Z/wAbePZv8nf1sfj8Fa9LZKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138022; c=relaxed/simple;
	bh=Y3bTg4DOn26LnNJlO6NSk6Js1pYtdcYw2MEh5L8b6ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4u4qm9NbEXuowNLENniRSfQew1+W/+m14bhQuzRIo6ImahP/vrKxj7ahufaZaF+9ct7cfp7093ThxOGzl52KRbreWdEFfchC8mYvDA2gQs1r1McJnVtIxYZbaliqtd6RUCRqqBwK+4O0DQAw3ip71W8Sr/zjf0voGsTMiLfZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=GQldds7b; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e5796d01c8so258114b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709138019; x=1709742819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CXIIP5wVzmKRA9tEAeIz7Ea3NPkY6q2faPhHzJ2+Mc=;
        b=GQldds7bACZjdIUiUHbYWb2zlxmPNwMQiuyS/vgnkmm5sCICWAUSpDpHLYeOlLVPat
         JKu2Ca6zB0CQ8iPYASDgLqfJwOiwogRMu/Svyqd451OCwHXZv1VFvkf7zSb6ypnWASQi
         GXHrJAZecsnQDiqaxlxdue/f5SGqPDu/uEuoa4o2QkGfKAmtyNykisZdUE2igDoNy7VO
         PhmhpFLVunWV29OFny6aISRb3F/QCZkKla65e5paXgTHfjFXTyOQVJtdsInA2Ej84kch
         yM3Nu+mNjpO1st226jHbSw0hs0jkoe8eZYgH/IX7gJvz5MwzUDQBLWDbC+Ehe3ZSUWBQ
         Upyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138019; x=1709742819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CXIIP5wVzmKRA9tEAeIz7Ea3NPkY6q2faPhHzJ2+Mc=;
        b=Ts0Wep/EPMub6tlRDJNs+qJwvHRHzIQL89tQk3r7gSUSYSrJQ1H1oz7auMEySwj48V
         s4D1hBEvQjUAhOuEjrQFkRR3m3X+2HinLkqmnHWjn6KZy8yVTEM9ZxFAtgIoHa+Rq+fR
         55Xxg0hzjRU4+IssMd4F9z6GpNyvDlfQY4qgTIVmy4HndZa1o5qfPgvWALo73xmkmwQm
         Fluwq39m5YhyU/kJYaTbQUsnEdBx/Vvw+v2/il9IHUlTePbXXrulO+LVMIFUHRUaD1IC
         Vk59P4LHKTBmrSBGUmoqMvQOpgBxDPA9llwNBFMrCDFVGgJFMIb1EezUE2GNwN+9Qlfd
         DlGw==
X-Gm-Message-State: AOJu0YxxrsB9EcsTTU7G70BMFiIGKFbaVKodifqXfuoNTU+Bfj81zsQp
	OE68CsbeiRITjS3phqQmF0FRXoY7r+SR0taFWWMLD3GXrqZ1gd1YOthvz2JuLxM=
X-Google-Smtp-Source: AGHT+IESXqCJZ3iNUwjVQsr9e437y944z2YksH1bTC2gzdxxkzcGTAbu/Yxqyzn1wU2Zjsn405XBaw==
X-Received: by 2002:a05:6a21:3949:b0:1a0:817d:80d with SMTP id ac9-20020a056a21394900b001a0817d080dmr6671332pzc.45.1709138019486;
        Wed, 28 Feb 2024 08:33:39 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902e35400b001db5079b705sm3498163plc.36.2024.02.28.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:33:39 -0800 (PST)
Date: Wed, 28 Feb 2024 08:33:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Tu <witu@nvidia.com>
Cc: <netdev@vger.kernel.org>, <jiri@nvidia.com>, <bodong@nvidia.com>,
 <tariqt@nvidia.com>, <yossiku@nvidia.com>, <kuba@kernel.org>
Subject: Re: [PATCH RFC iproute2] devlink: Add eswitch attr option for
 shared descriptors
Message-ID: <20240228083337.18bfc306@hermes.local>
In-Reply-To: <20240228152548.16690-1-witu@nvidia.com>
References: <20240228152548.16690-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 17:25:48 +0200
William Tu <witu@nvidia.com> wrote:

> Add two eswitch attrs: shrdesc_mode and shrdesc_count.
> shrdesc_mode: to enable a sharing memory buffer for
> representor's rx buffer, and shrdesc_count: to control the
> number of buffers in this shared memory pool.
> 
> An example use case:
>   $ devlink dev eswitch show pci/0000:08:00.0
>     pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
>     shrdesc-mode none shrdesc-count 0
>   $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>     shrdesc-mode basic shrdesc-count 1024
>   $ devlink dev eswitch show pci/0000:08:00.0
>     pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic \
>     shrdesc-mode basic shrdesc-count 1024
> 
> Signed-off-by: William Tu <witu@nvidia.com>

This needs to target iproute2-next.

Please update man page for devlink as well.

