Return-Path: <netdev+bounces-170703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09B2A49A02
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA183B0A02
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA126B2A9;
	Fri, 28 Feb 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UoLHNxqX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888B26B2B5
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747237; cv=none; b=QJAGVuTebIPBxt4gEceQh+ib4vecihWwit/AqFZz6UL2tFXY8WW+h8CJTXQsGM/KFK8T9Ib+9/wXY2gXw0lPDM11NiH9sxHtzr/q2ZtteCp1QVmkEuc+9C9HwYCNwHN4KsMkzhO0e+72M8wsTk6NE8yVQ99v/WdX78i5ffvnjI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747237; c=relaxed/simple;
	bh=FT5PPNhNxu+/sy1C3xutW1KF3A+K9M6I01pq07cS2/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR5zi/OBznpNuxvgMIAEOwaQIVZdLhGUyylm0/HSWeQHP4HuTb7E/yvC1ONwnRRBwFdG1ljUAz6SaZSiNrLQ586jrqyu06sfPts4XxkQ7lSoPxPsJEhW3OR9BIQDmj0OIkXebpRudnvd6xgMeGtTAp20GRpngYu4mxV1GpR5TaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UoLHNxqX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so3136215a12.2
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740747234; x=1741352034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FT5PPNhNxu+/sy1C3xutW1KF3A+K9M6I01pq07cS2/A=;
        b=UoLHNxqXVNBsQpMuWjvzfnvJFAi59QFSJqLJSnzzE3o0gi/z3UUTn6d0ElUVdg6zRo
         HUp7+BqeePX3TpIwsaBSR/YpE4EA3dx2BUXuSP9WutP6CtDy9q4385HkOv1IUv+CrkeL
         +FZFoRFGEodrpNuP6GPjjVz1gFF4HypJ2YWx0TQC6OhxqLpZJpBQ2I9O1OAkj30iWkNW
         pzdqzBsHjGKLiR0Y7vYI5WUCowCDtysBhSjnkKDBddxaZtmOU2APsmExQ60gJO20vAb2
         KXRV307W25b8juV1zOOZyjpck5aMmaCUcpdkJAItJRDiLVJA9kpT0+W2sQB4y5oVW5HJ
         zTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747234; x=1741352034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT5PPNhNxu+/sy1C3xutW1KF3A+K9M6I01pq07cS2/A=;
        b=mMQ8yolQHDGO1zPGEB6dGqXtZyVLuek6m/IyTxfTE77oGO/A67w55dvDaJD47O96mI
         PEC70T7GJ/rDK7XrV/snSBIMD/A2FjGJrN4640ODdlSBQOTDAakLG7DtCiTx/cuaEXcK
         mFf5Nv1JFzWM1M2iqxY0a3cs9f+ILe/OEp5/kR70G2Q7BRSoo+ciOy7NAjwoaCDIaL+g
         mZcWeiKPLJ1fIh0FshJdD7W6kXJx7kg0svX6/NIAN4pYZfM++Wy26djbQOTs/reneJ7I
         izvucduqVcUrbmBatjfPhYynW6X0SXNPv3yY3yCoCrd9UTFKUS1upNQv4nx5rSeO/1hb
         4tRA==
X-Forwarded-Encrypted: i=1; AJvYcCU1r3uIMWxiSXG3dJMXxWoyJbPWC+zkoxkymSw3liH9GNWZVNeuyggxevNvm2dzJ+tjsmY9o+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30KEzj6RAl9f+LnpBCzM41/mYxlnTY6TyUjV+pN8HTKots9mc
	Mq/mBrRPcc2jTsMuXmcPW6fFaEis9qe+3KGLpuufw82blyxrbuNSJd2OHYD0TpM=
X-Gm-Gg: ASbGncuiHEJ6MtVfVvwslH2jHrK8TH365gLmnAPRx9v7QeyUSEGdXcK06V+dP35B3qB
	hzMBHzsPjNjrqIFgiLnKFgBXxewGJVQM6Kn+HfVM+Sw2pPrO09W/QF/iEk56Jq0tNhFirMWX84q
	sNsl5sjvSnzo/9bgqF5hO7xHsUky4j5Oog3N/x3hIHnlyvRGdAqzQyuRNVpqrIqGI73/y8WsrKv
	xg2ZxCi/8Bf8s2Fju7SkvGnKvzkh2o/UFwgkTgX0PRvBVywFOFq732nGPIXHRDVzm766GteqZ3w
	iqVsVU86gC9mDVhpmDkasv44hSpt35H6/2DfKecHEN9KcHMWJBmTIg==
X-Google-Smtp-Source: AGHT+IFojW7B4IhQEoDi1zVMlZbw2vVPYsCjDyMvlfONPbgZ2RqP+c/kOAy02YZVR+biKWfMnRoguw==
X-Received: by 2002:a17:906:b897:b0:abf:2a6e:1386 with SMTP id a640c23a62f3a-abf2a6e13dcmr231689366b.37.1740747233892;
        Fri, 28 Feb 2025 04:53:53 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6f5363sm282012066b.123.2025.02.28.04.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:53:53 -0800 (PST)
Date: Fri, 28 Feb 2025 13:53:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 12/14] devlink: Throw extack messages on param
 value validation error
Message-ID: <6vcn77427eyfh3znvtmyjaexbmlejttdhemk3gnti6ghftejf3@4vejwxipqpju>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-13-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-13-saeed@kernel.org>

Fri, Feb 28, 2025 at 03:12:25AM +0100, saeed@kernel.org wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>
>
>Centralize devlink param value data validation in one function and
>fill corresponding extack error messages on validation error.
>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

