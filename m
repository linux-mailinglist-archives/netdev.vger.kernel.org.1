Return-Path: <netdev+bounces-158270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1599A11474
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FB83A245B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277852135B9;
	Tue, 14 Jan 2025 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Y8d15Fec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23D20AF6D
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895436; cv=none; b=dGwv5TgmvpJ2+0w5V7TVHiZ9H8f6dkxGYwol6SaQf2V+cmPXPOC3VHgfini4Fb0/6Q7ElGVNUE6bQ8CnmIz6WCN74JfNiTdqeMCA1CK6SoHpzNNDAsk+smtWla2dyyjAGr0kBxvMmPb77flrDEXrR7jbureA18Mr4F15lRPcYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895436; c=relaxed/simple;
	bh=OZiuBLAJBXNGvVIwmJtNwwR43VPlyX/gJuNU3whLxCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpMEfQXW3cZDA23/BfIdbLPBEqKU98i3CMshe9r+8qQSMF5qiMYZqBRa7Q9cYj9h1EwgrpebdBnMdBgAOR/h00a9R/GDYZj70PJxv2R3ZoEwXUxM5iHZ1nYCKaxS4I/Keg+mWjOgy2jkbVyCxswTUqlaU2ALVfzWxYjKXAeYZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Y8d15Fec; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216281bc30fso129149095ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736895434; x=1737500234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMec8Zur50HOt0VYsYeTIbY1gqKds+DtKFN6HJsme8g=;
        b=Y8d15FecXqRQfifAmrllO3l3rVna9CRm8jja5cmUjz8Y15100cilr14hCnfSyf+ngm
         jsHuuMt6uj3PShI134YxthbzdQGF7KI+9oteKWO6cg5AIeuR8BkwB1tKTCO7JxHiVLfG
         +tN6/DY1TxfowwjqpzoWA372lbm6EiGHxgv2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895434; x=1737500234;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMec8Zur50HOt0VYsYeTIbY1gqKds+DtKFN6HJsme8g=;
        b=lZ48LQyWqTlXG22Pprie8fVdr5H0DUmB3n7QNOb71IHMzonKoV2FHJjlkYxAfga1qf
         L2N9OKAI72NDtg2+3qVf+tUNzc1k5iDw94Aukae5tcQdRbWjQxmZJ4ipqR3A1HDaxBQl
         FUqu4XjZA42E2sh8RtmWB/gkOajfDoMAaV/luy3iKRHnZ/pIEBxxWCvysAIa85jxndD0
         SXea3ARyPodlI5/J/BlB57XyOv/M6JiTOgWX1NZ+yqhLRJCrwI1sfrEKkPKiVzqxLmXr
         uHlzO/i4ylN0ovuJ4SXjnVXX5fmeqH/VMmy2Mf7G+qkG1UMcuEwgVNHPvgN5BZlmT62I
         ij2w==
X-Forwarded-Encrypted: i=1; AJvYcCXcVJmudI/im/3CUw341T2ayyW7vtg2kzzsTvdgMauqiO0lr+jXp44mQz92Gdwj+jsDHPYSxhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+rM1AMVph8PgTgwzT+fq4AsVdsk/jDKzvAKkbCPniZhP9FMBj
	2bOJJeC1NdMGzpen9Ha4390SyV+pT93pN8z0SRPbKR9aGla6VwinDmnVwCpv8lL5QoNeDwKj+Tk
	A
X-Gm-Gg: ASbGncsDbhMOUVaKuXxyKcB0VimbTYxr4SbGdDIIP/dITrQu+5rLa8R8i0AL8KqtXST
	6vK3k1DJacOhFCXwOgGD2dR8Sw62wmEYcXzWj7w8M3kUq2mWlBgptbW959trBRXlF2dMuPQgA6A
	Fu5OOkKDlvClQqcwbtbPuMpDBYAYHsnRUPoRafpwITdQOovwCA5D1jO9yN2980cV9fWBMiU4oNH
	vnRSlKc/NJTXQq3OkG9S3qizolLJjrU1CVPQ4wT49VK1yFsEKqC1RVbbRLm8dSLcmJEH8xXR1Jj
	0kzK6oIIKkTwaoVKLoP+U80=
X-Google-Smtp-Source: AGHT+IHaKYPuF2xAVdEKSaauzkiK/xrBi2A89kb+4wa77EvKLqf9G8Qla1YQQKUOC3blEGuRjNltbw==
X-Received: by 2002:a17:902:ec8f:b0:215:7447:ebf0 with SMTP id d9443c01a7336-21a83f665c8mr434386435ad.29.1736895433910;
        Tue, 14 Jan 2025 14:57:13 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219a94sm72367325ad.129.2025.01.14.14.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:57:13 -0800 (PST)
Date: Tue, 14 Jan 2025 14:57:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 03/11] net: make netdev_lock() protect
 netdev->reg_state
Message-ID: <Z4brx7KmFkSAylkR@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250114035118.110297-1-kuba@kernel.org>
 <20250114035118.110297-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114035118.110297-4-kuba@kernel.org>

On Mon, Jan 13, 2025 at 07:51:09PM -0800, Jakub Kicinski wrote:
> Protect writes to netdev->reg_state with netdev_lock().
> From now on holding netdev_lock() is sufficient to prevent
> the net_device from getting unregistered, so code which
> wants to hold just a single netdev around no longer needs
> to hold rtnl_lock.
> 
> We do not protect the NETREG_UNREGISTERED -> NETREG_RELEASED
> transition. We'd need to move mutex_destroy(netdev->lock)
> to .release, but the real reason is that trying to stop
> the unregistration process mid-way would be unsafe / crazy.
> Taking references on such devices is not safe, either.
> So the intended semantics are to lock REGISTERED devices.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/netdevice.h | 2 +-
>  net/core/dev.c            | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

