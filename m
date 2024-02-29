Return-Path: <netdev+bounces-75960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5436486BC7C
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E518E1F25A3D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80224A28;
	Thu, 29 Feb 2024 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aYNrdHUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010217545
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165028; cv=none; b=aNj5AtZJgMVpgNMDUIROszPI8zI3CviuI1CbCC8eMEzqfkcHhvn1cJFgPAEHJWBtFd4QU6bev5fuGIZPfEgTRji2Qzk47OU9zZxrIOrLtCnM73BSoBF4/pwRrhUiHlkdWHhVygNco+DuFjMEbuwiwNw6j65/Of+h3hS92I4ivYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165028; c=relaxed/simple;
	bh=OFgQwXsMv2PCEP7cboBXKNq0QnFBUPWLxnww317nqsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWVVg5Vw5ihuP6xZxQWvAeeS278dWEKbHe8UqLzIypdJAQ5rGSyyv/0DApePX/sYKEwluwkU7xXdxIv4UDCkuykf6nK3fBZ1gyr8xiOCxOCn8lV7SPZHJAbVKXj8oDYhb0eOwVlb2AVpJrtWntvW+fxN0lEXet/HtlbSXcASBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aYNrdHUY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e4560664b5so232041b3a.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709165026; x=1709769826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwLo+SlOHd8K2sY22rmYO9CHmiOYoa90iOQ05o2rFZY=;
        b=aYNrdHUYuyJGyk0h8wM585jDjVnxI2bOCC378+Bt1xtQkKPR8xJgMAjR+6Wz0wh4GO
         UzS/MtcE6YusEKbCPLQ9a5eRFG3f5KU00Gpru7VlfWPs0vOc89wzv1TpI7nJpmDNPmS6
         PinP9pCql/WHCNc8/OOt4d1AcJ4GF6FyUPHtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165026; x=1709769826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwLo+SlOHd8K2sY22rmYO9CHmiOYoa90iOQ05o2rFZY=;
        b=XaYE553/rQqO/CFq7bpPY8e8Sg5fnBI+9xZk46/v95esojPoxiQCfEfUllsX/hxNGP
         7pGZGjhDHF4ErBj5qW2X5jKr2Cb++E7lsl/j2nkE9XibDXB2kP0IqFiaM1/1362s1iZ3
         woTDBUGUOltWhdGvo0JX/7mMpy6ma94gfQqh35Hs7VLp2ZGaQ5UdMzTDExRUhtfDavoL
         ni98t6FqJdCTHvAq4lWVdy4+lq/fK9yezClF0XL4CmYTRDsuewI7F5lO1b0PF5S3upB4
         4PscLwBzTPYhQyHVafSwUkTyNV6koJ/YTS/8S/sAOcnF/dAPPqXid8PV2FSXdEAMv7Sp
         xxRA==
X-Forwarded-Encrypted: i=1; AJvYcCXUkhYBb99go4UEw8Px4ffcBjJ/lZQcsw/YB/k7V86C6TQjhejv5GnDuJBKrXnjpid5hrEUdkfTN5vPZYYAjFzUjDxwBvYt
X-Gm-Message-State: AOJu0YzZ2XbwxyPD3nG37h+jw0JiUUH25/ODhI9T6I0HxoXcgyT+u5Uy
	pvC+7Mh6stwUR0YnQb92uE3IP90tweggzksw7eVNY5/uxzNe5ah6Tent25sqgA==
X-Google-Smtp-Source: AGHT+IGbYipmoXWwMUNX0EpbZy8eo0Zyoq2OcZwuRennRyHpxCas19mkzz4HsTupR5aawal2RQuuDA==
X-Received: by 2002:aa7:9e50:0:b0:6e5:7075:7235 with SMTP id z16-20020aa79e50000000b006e570757235mr712201pfq.23.1709165026244;
        Wed, 28 Feb 2024 16:03:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s36-20020a056a0017a400b006e53d2c0618sm34321pfg.65.2024.02.28.16.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:03:45 -0800 (PST)
Date: Wed, 28 Feb 2024 16:03:45 -0800
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
Subject: Re: [PATCH v2 2/7] scsi: mpt3sas: replace deprecated strncpy with
 strscpy
Message-ID: <202402281603.E33A62C096@keescook>
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
 <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-2-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-2-dacebd3fcfa0@google.com>

On Wed, Feb 28, 2024 at 10:59:02PM +0000, Justin Stitt wrote:
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

