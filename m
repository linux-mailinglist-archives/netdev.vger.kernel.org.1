Return-Path: <netdev+bounces-74643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4E8620F5
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5D2285BF8
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB4EC7;
	Sat, 24 Feb 2024 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h5dT+U2j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB9623
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733143; cv=none; b=FTlhsPS8mroA8u0tjB0aktLdtvNVQW7eFxOheeSdqIhHE+EmK4iXOsw4vdmRns2cchaRROTzXmwj/dLHFvoJc+sLDQgRASKbgmmj+P5REzPgGOGGqhMIXxFyhmheLSMXy9GvSGH8rP/qfU2BuSLG4+nrMysmaubPYwNd/Lm2C7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733143; c=relaxed/simple;
	bh=BtNLLDRfUzf0j5Xx0MzJGDSaQOP9BLR490iANSNKg3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BK9Rv8GKggx/BQA4k++g0mRJveS/BNAkvnf8qD7iUHXR5HjPDcOUYq9cqmgULeLhDHiFcWCjUNRIYHv9nd3g/21+k6VGqBr4zQ/lYPGu3mEn9u2+ezH+gFJwIw1RvnCtHTkObqJWAp0GZ5KYXxQSw0H/cjWmuVGkGqeRcbMvLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h5dT+U2j; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e4e2380588so729171b3a.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708733140; x=1709337940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISFcMVB4Pi1paX6ZB9XWvqasqvLqqrENosxnYhDGUTM=;
        b=h5dT+U2jOHgOh3n6I9Ce0rEW+mNzvHrbQUjqc+yCvqNMMG8bvW2as2dZb4mNmAQAPc
         MAh8dE8aRop4mHXczQP83Y10OjSlouO8niFtdvwjZEfbML0vHWv+H1KWam1RyWscDCjk
         hMsooris10osvVDd7CqTdxeqtu+IYeQhLtwT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733140; x=1709337940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISFcMVB4Pi1paX6ZB9XWvqasqvLqqrENosxnYhDGUTM=;
        b=WCuI29XZjfn4VKavOFMoSGQkyHv4Mu2OEtF0jO8tb6im7inpWxIPtbkZtwYfKi3MZh
         TUvqnqbfBgEgeZxjDtFOEWIRCn0V5oQoKxUuXx1E+9qxQ+92GoehWdq/7RC+Lu1I+loR
         nx3Bs+XppJGS6YV3b99qwyV3wTzWJWW6TJDjKTGpmrxg8OzUEh/NfYM0elJiUSKDR+ww
         4iPkyNq1yRTisCf585QM6wyecpyT2yZ8m1KNimmDDuN+Vj453AgDIsQiFaogot8Ynh1N
         vVuuzLVYOWWXefWgLHGkrejRrNjz0vN+/DC2jgrcFojg5IgHxTKVBoHmfvOytQgW2xjW
         0iKA==
X-Forwarded-Encrypted: i=1; AJvYcCVSFev43A+UU+fY2LGov9n9HW1J2/bX5Z4MymKFnibACa24r0o66yjGToR/kZnDkKCeatrt7RFWglRn1SmK36Y6XgTP7ied
X-Gm-Message-State: AOJu0YxOQlfi5HP0fZu8CWHuWmLKdRGsuiauY128yhpbPnxI3JcUye6n
	+9GQgYFrEyBfN2Eh27cOoqMe2wugtR9SKN1R6zeqcp3aE/5nEvG1SF7sKZ7aMg==
X-Google-Smtp-Source: AGHT+IEYGoG8kuObm+K6CkUKu1PoKg+VjgXJU4uccu5PNgmBbCgBxkplrCyKKdgTzkD1guBLILMifA==
X-Received: by 2002:a05:6a00:9396:b0:6e3:b7cb:b105 with SMTP id ka22-20020a056a00939600b006e3b7cbb105mr1558704pfb.18.1708733139964;
        Fri, 23 Feb 2024 16:05:39 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w67-20020a626246000000b006e25d43630asm46314pfb.108.2024.02.23.16.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:05:39 -0800 (PST)
Date: Fri, 23 Feb 2024 16:05:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Don Brace <don.brace@microchip.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
	storagedev@microchip.com
Subject: Re: [PATCH 2/7] scsi: mpt3sas: replace deprecated strncpy with
 strscpy
Message-ID: <202402231605.3DABED3@keescook>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
 <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-2-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-2-9cd3882f0700@google.com>

On Fri, Feb 23, 2024 at 10:23:07PM +0000, Justin Stitt wrote:
> The replacement in mpt3sas_base.c is a trivial one because desc is
> already zero-initialized meaning there is no functional change here.
> 
> For mpt3sas_transport.c, we know edev is zero-initialized as well while
> manufacture_reply comes from dma_alloc_coherent(). No functional change
> here either.
> 
> For all cases, use the more idiomatic strscpy() usage of:
> strscpy(dest, src, sizeof(dest))
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

