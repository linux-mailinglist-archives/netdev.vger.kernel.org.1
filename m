Return-Path: <netdev+bounces-170691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E109A499D5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EC0188C3A4
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6126B964;
	Fri, 28 Feb 2025 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RWTNqkwv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C0226B2D2
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746996; cv=none; b=rsSJaJRRslS6pU80TjC1VFsUS74KcLL/nshRkFwgUY77pM2nWrjjaWktZLilmRTpyyMX04BIoGyYfAR4ByExtYuGJfKQugiq1zZYuBh3ZRECrV1XaKTvbYJqzRfSMdCPxRbYLn+U+48P3Vz+4oERzjj3tM/eVcLXsPzXhuvEF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746996; c=relaxed/simple;
	bh=XvJ8SPIETZ+ANuRZRMpfOCAEmosxY/R3fM+j9Iq3DBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyGW9S+PX6iFGCv+jddJJzmu2LSF75dFhMyanrDf55UiNSPbRnKybUrVN88FUrlgFHFj3OYzO7scriklkMSC+BFE2lNbF4aUyqrkxzZHVwipEx7BmEUIUaA+6GsshYgDiT7qodEkzKt/BufPCK3ugc/KHUr5ylaPDr88wgWTi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RWTNqkwv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so3452716a12.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740746992; x=1741351792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ynElw7PN3u4S4jF9tOVzwz/2XxzpqqT3FLlG/Hf3kk=;
        b=RWTNqkwvjW5011cHKs5I3H5etLXKdzigbAY6kCyZQ+T/y55h9bHfKSM7/X43m5Br9U
         HPsHj9Z95HxGUMBfspDwHdUgvloIoEt+At5iup2KEMg/OJ93F3+2uo3fbciiQahg+Fqi
         PjTu+R7GUSI/yFtudRFXjilzG+G8XkXlkuvNexeW3lZSOUcHW39zomw6/LhqAWw7WLoa
         4cYVeDi344q7YP2ghRH5F5l4xyyj9d5P/fWCwC+r2obBDmZlkhTpHKL5gqfGgRkIiBUm
         y832hnXNbWge9+3lWnPY6QmgzGDau8ze7I5cG7NINHQVZ28uDgRGh5OxilRqGfBzdDlN
         qYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746992; x=1741351792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ynElw7PN3u4S4jF9tOVzwz/2XxzpqqT3FLlG/Hf3kk=;
        b=mIMH1GXvxOoiTWaMXvajvAz++AxjxXiUvC1rPFsaNxW4+tMY0MwjdIYvEA15/NoQaG
         cMEu3AnkbOuI68P2nihGQkrKocNMWwKJdmLh5RD3yQin8sIMm6cost2YczuiJECvIFch
         MXb4o4PP0rKcDkvJaMk34IrHmn8bVmxWPhuU+z32fzkUg2vmzZzkQ2N4gP3Byf0NLsO2
         DsZmGKK4pGbmQUNrqUEYErUrovtlH7fjHw6C5DO2SgMCI+AHxFDMsd+PfFh+FVsAddoh
         C/mMbD4+35/txVAfdiz2AOJz2MZjb6vEzY+lgaBxdwN1EN2U9qvExDurLWIv6AAr+E6Z
         0zRw==
X-Forwarded-Encrypted: i=1; AJvYcCUD3XKgdb+rFy1ND8vDtPwj9jKSnWJpLrSw5pYuz/cuIS2Ea1cCVmuMOTJD18J+5zfK5uWIJW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7MooM9tlmbykHrFc33nuGWBc72J65Q3qruGzbl0oRKGsJRpp
	6o1ZF2pti3yzFtuBpM8lZPnvl46fsBnXj1Xd7xqgLrkLZyewSYjj/Fp11qJJwu4=
X-Gm-Gg: ASbGncspID+SYB86skkRq/Qjvgj9qHlxt+WVTny33t+ivU81zDGMXAwNBCoOYWdbSXB
	YHnObqwKmCRr8cXc1FFx9LFrdaRsBh3/ksIgKUr87XH4NvLSJkiw7bG5KtEllJH7wxhLfaMJEYg
	3ssxB6YGSqcm3llmMPlntW6U2W4KpxaEa5UbXA8MiccpYQlHZIXIs/cMFtZ1fCJC4xey2GrQuvD
	sCpwStdEmwhkLWyVFOz6l+MLwDgIxeN8Ize9qJS6nGO5NNqnCkjTjxXCtYB+GrgQMTwyZoHZ50f
	8lUo1G9HrodoptodITQuQFFQptCGtIOoAPjH5f12iYZo1zO1747fCg==
X-Google-Smtp-Source: AGHT+IGTPll723bIgilVqQcwlyuqSaz16QI5imj+Kgi9uRnvl17yovg2atGa/T1JO0g92yhYGOK1fg==
X-Received: by 2002:a05:6402:5247:b0:5db:e7eb:1b34 with SMTP id 4fb4d7f45d1cf-5e4d6ae14a1mr2622568a12.13.1740746991868;
        Fri, 28 Feb 2025 04:49:51 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa51sm2429525a12.12.2025.02.28.04.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:49:50 -0800 (PST)
Date: Fri, 28 Feb 2025 13:49:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 09/14] devlink: Implement set netlink command
 for port params
Message-ID: <vlqzukr6vg6ydiytf2trujif7nlweam6j6hejwf6wbenudysjn@76ssulrhubrq>
References: <20250228021227.871993-1-saeed@kernel.org>
 <20250228021227.871993-10-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228021227.871993-10-saeed@kernel.org>

Fri, Feb 28, 2025 at 03:12:22AM +0100, saeed@kernel.org wrote:
>From: Saeed Mahameed <saeedm@nvidia.com>
>
>Add missing port-params netlink attributes and policies to devlink's
>spec, reuse existing set_doit of the devlink dev params.
>
>This implements:
>  devlink port param set <device>/<port> name <param_name> value <val> \
>               cmode <cmode>
>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

