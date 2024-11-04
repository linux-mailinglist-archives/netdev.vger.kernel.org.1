Return-Path: <netdev+bounces-141720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525069BC1AA
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6611F2131F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372171FDFAF;
	Mon,  4 Nov 2024 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PAupFm0e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B851A76A4
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764233; cv=none; b=eZonp33ujr3k8q+81h/PqyV9UfLs5upP5Uit1X2hvXlqmpeZXn9JvpGyLwjwabrz+11Gc3SRUrrZD4+vqlNHWIkqzbIKbxovOxUvH34aSyqteLZVlJpqKViISl86bLHpQsQ14H2JG4SKRmSS9UqSv2zB0SEG7IkxlJG1+gEN6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764233; c=relaxed/simple;
	bh=XHPVifGKXEqy8LE0q970p31W+sJjEWNZsP8R4d+Uo/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFQQb2mKD9sDwqBJqMHR/Y/JZGzH2y1zEsCeV9RKeIgpu+xwbvoDgBNDSo93G1oyn3RZPyLGZmTmkDbdK6xeVzDbvwIqipQqiXuYcP3cttpoQMK51RE0jxDwOjk5Kco794cutbq2pM6zWUsdPWsrJ/dcMWxPDsGBOhxhnS39bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PAupFm0e; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so4200521b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 15:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764231; x=1731369031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDd2iS+HO9f2ODni7moor8fgiPBiv84xu1qF5aO0f1E=;
        b=PAupFm0eJU7oNszuHR2EeZK4hapGIJPeBS8WlM8xPtypTNhw2aO46E27q2yuXrq6Bk
         DT7nizFxDqRWYe1NkbBl0n0JIAton2M8UXAPc+DOL/7Dt/3IWsvtk5Ff5ZZvVm0M3MTh
         aSMAKyfnTALzmerGhwNuWMGXyxqf560gmpK1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764231; x=1731369031;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDd2iS+HO9f2ODni7moor8fgiPBiv84xu1qF5aO0f1E=;
        b=XLFlxkcNCUYPLVeczIj1x0h4YnhsckV2IkVW8tjlU1sARb+8VWiRc3rgOHjj8S2lSk
         kHE6ciPBjXlTCGxURWem0DJyEYRcgBspAsP103rzfbSiucJkCeojZLmazVVJIqb5Zdd/
         sqvDolJw73lSZikWlhO/2ploDe8fBm7/FkegSHYnLgJQtfrLsjhwOyluGaSVEn/Ncyum
         PQ97fEPoWDsUpAZBbmsl3Hr3aSF7eiFMUUteKhsBN67GCNdGwUzrSYObfxnPMSCyjZI5
         OuIRvaRNv682Bdz8zMGS+p36vPLcI5z2fiV553nb6ayL9/klEtsS1sGH6WcXBFZk4KZP
         i+cA==
X-Gm-Message-State: AOJu0YzXYMeLoelnmHMSJFXsBjiSG06jtqCVafixpYk4BXCtAl8YoTM3
	f233PzBAatwbJo1Vp4NCrRROVEjX0rtr/VfmzUAlRgZ54NCYa6Nigb0+qRlpyaM=
X-Google-Smtp-Source: AGHT+IHWzRXiGYvo8KNQLD4r4zmqsgkH7TShcEy59N1FdgKJ1Bm2tsdY9K3y3uV5t2Tk3W5BdjOUug==
X-Received: by 2002:a05:6a00:14c9:b0:71e:cf8:d6fa with SMTP id d2e1a72fcca58-72062fdad1bmr45801290b3a.15.1730764231110;
        Mon, 04 Nov 2024 15:50:31 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ef8adsm8276729b3a.84.2024.11.04.15.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:50:30 -0800 (PST)
Date: Mon, 4 Nov 2024 15:50:27 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 05/12] selftests: ncdevmem: Remove default
 arguments
Message-ID: <Zyldw-Ozq7PqbicM@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-6-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-6-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:23AM -0800, Stanislav Fomichev wrote:
> To make it clear what's required and what's not. Also, some of the
> values don't seem like a good defaults; for example eth1.
> 
> Move the invocation comment to the top, add missing -s to the client
> and cleanup the client invocation a bit to make more readable.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 61 ++++++++++++++++----------
>  1 file changed, 39 insertions(+), 22 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

