Return-Path: <netdev+bounces-232097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C27C00FC5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E28E4E41AB
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E9830EF7E;
	Thu, 23 Oct 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="P8RhfIsj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6762F6592
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221191; cv=none; b=SBvveh+oXxkjPHRpLqAJp3uSRNhrXYF1ppF4c1DZyoGDHQeCA+ejTEIE3j+deC3RTJGlhh/sMIA00aCjCDnwkbZz8rPfF685sztCNkZA4BhSAngqCBspumPAxE32vpnp+PQmss1MaN7g8iasxsFwqdg/OAqA38s6ZhFsI88C3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221191; c=relaxed/simple;
	bh=hPmHx44aw4/MuCBOKepCAb/VY50gLeqy+XS/PsI9ph8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOSbFVkFRtq+x9HvwBVBzc7gKObfJgPQDvodyn8PFPndpIpAlwKUISkqlL32p+54tdyzbX8HlnsIGPV3+9EmzSo86wExkAiojXxK7A+ymrOp4QiS6Z6dwSDSQXw7IrPTf0iemC20NZZVsOtugv+K3dReGUSZQx6J1ZHsM9lNnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=P8RhfIsj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47117e75258so5634785e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1761221186; x=1761825986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPmHx44aw4/MuCBOKepCAb/VY50gLeqy+XS/PsI9ph8=;
        b=P8RhfIsj0p0g1inRzb0CHeZCIC0xKrgqfTOrVKXHw5Pv8+8h32FzMbr2bXFk58R7Xj
         prfZ2xlXPq6gASSCpYjlNGRSf7azr9n17tL2LYJM3lrztF9hXPpG9yff54ze3lzzc5k8
         cCQnfWaa3hvBjqMNgzpAXc0cG4vZvJi3rfQ2TvANqYorRWPbpP4uIbDcdRGlf65fwRwV
         hk0qJwxaZRJa7yJyhpcbsONbDZ1p6DaHMVaS6vF9n+cfJKmXG15Wy6t6GgnR+JXazrYm
         dOzTe+65NAFB/xnQT+RJNm6n+GzLYMqhd8QizpQNoljCrFglUZKFKHggDbCxgGWRmGAL
         /4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761221186; x=1761825986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPmHx44aw4/MuCBOKepCAb/VY50gLeqy+XS/PsI9ph8=;
        b=MbKDh4IyhkDNhEph98sSHnjq2PIZdqcNzj8F+Mg1hOHrIhHDCBJZHe7aE2RNM7prQh
         qh5LMo/veNf8JafzZpts6Burq1e+huGOJ9Bfz+G3VpSM4i1tP5s6qdrMyyuyVeMFrCUb
         QTGhowcx3+VtPMNVVFluX4ghfldfCEYMo3KgKHGfW4z3XRwe/iIf1sHBIs4F7A6LMErj
         ezotIuKE8TYjM0ggUKrVX4Qx1ohyKTAM3xfvliaM4lG6ctK0mY5eCoZhbWUuaKI44wdF
         EWdYR8EPQ73bvWYigj2GrPAlz7OsP9RJxgQ3P5A3T4iGO1W/RLs19avxU35kZ9xYICUJ
         3yZA==
X-Gm-Message-State: AOJu0Yxg+SC2LJIML1XmCCTYG/qmNfxHemrwcYqCPRwdYV+OYC98ZYmj
	DQQChUNR5BqHfMRXj/cCB+SpnrTdnuk3SVmZoXOGiArPhKKDbkEqaX9Br7+a1DY43VoNE6hvtYN
	aBHEPYRo=
X-Gm-Gg: ASbGncs9lg/Zec2QajkEt+CZPREA6lSJibP1hJ9prSSpEWYkls9Cdlfs1YlqDWsC3HE
	kU2vf00x5Z74AQJPQtYtLYo5+PqzO/6aDkNiXipqAjfM6oqO4q1cps9BJhspdkLJ0K1WhM7TBw6
	EGxyqcJcxywb4Nz2Aiq1ZGoTCufEQsBURYLBRIGore20f0fUNInuYJ7gbN7E5JXy3NS2vW/4V1Y
	mIDRlHKsqq4/UypkQiWmfpgXg+85fASAIPTvjL4gaHHvu8I0MviVDb9vW9rDVCSKf6Ns0/xNdnp
	3lWMg+b2lSn75ppGMi8qz8yebhmNksH1EiOsz+p4edx7uhU5uPZBt9zwj4WoTvdpX+q580h4XTd
	tl7mfJAGZbITnIdPS8qvbMGZ3Z4Fo0+RJi8p2XyaoGL1QFdicLco0nT3zZKs2vtd44zLiOSPPIV
	TbDFfT2CIjyt7nMZP6/Ps159E3UXdqDU6kGYQmxQ==
X-Google-Smtp-Source: AGHT+IE/ZFB/FkNtSsSj/a9XHSfYqDn/p+RkIpv2w7TjfbTtfe4lhoS+DxKWsp5VKtASQ4PM1AB2SQ==
X-Received: by 2002:a05:600c:4e45:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-475cb02faa5mr15127305e9.22.1761221186248;
        Thu, 23 Oct 2025 05:06:26 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae9253bsm32727225e9.1.2025.10.23.05.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:06:25 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:06:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH iproute2] devlink: fix devlink flash error reporting
Message-ID: <m36eg2tmmnqnu7yznbn5jdlqxsxxgwknv2vnc4bpfc36q6zopw@macasn5cvvrh>
References: <20251022122302.71766-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022122302.71766-1-ivecera@redhat.com>

Wed, Oct 22, 2025 at 02:23:02PM +0200, ivecera@redhat.com wrote:
>Currently, devlink silently exits when a non-existent device is specified
>for flashing or when the user lacks sufficient permissions. This makes it
>hard to diagnose the problem.
>
>Print an appropriate error message in these cases to improve user feedback.
>
>Prior:
>$ devlink dev flash foo/bar file test
>$ sudo devlink dev flash foo/bar file test
>$
>
>After patch:
>$ devlink/devlink dev flash foo/bar file test
>devlink answers: Operation not permitted
>$ sudo devlink/devlink dev flash foo/bar file test
>devlink answers: No such device
>
>Fixes: 9b13cddfe268 ("devlink: implement flash status monitoring")
>Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

