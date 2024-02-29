Return-Path: <netdev+bounces-75959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4086BC76
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F60287569
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA0C36E;
	Thu, 29 Feb 2024 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQAAjyIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186C9ED0
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164968; cv=none; b=kXTViuQv+OFWK8Y868Ay44dNlMYahn2PbkHGlEV+LKBJfZ8LlTDi5vK1qKZhcy7moOb1Q8Crgy8QMzXhhECUcI6TAouE/wqQSZRhldIQEWLIS7goLeuQfsOt8iPHlLiFSi3FJma7HNQvCgC2dduoFtTWlGop+u4W1dvttmu3DvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164968; c=relaxed/simple;
	bh=tH8Do06WsHG8uh7bIC0z1/jOfTEgMGtUd5RXQ5jyXwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqwWCVGALaYlv1F5EbU3VlGxTMQWvfj1a12DeSv5c30H526NgeJEPG06yviCsOcW69SBGrZTAsIz5i4vpsD8Kt5sQuTkTicU5wHnhi14tQskDLk0igZ59kqJXdokOIzXPwbP9YlE5uyLBFXIwN/1SUnbcvs3euR35HgW+EIGEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iQAAjyIW; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e47a9f4b70so171767a34.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709164966; x=1709769766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzYFHNFtHHHpRZc8edEq8bHU8oqWM7vjNzOC9ZZj3Zw=;
        b=iQAAjyIWjHzlp0w0zAz8XfTortXy50gEPPvXUInJQNpwa2nzLMHuBnYqRILTEpwNbi
         GJFm+FilgeG+XUGAHAtwkUM4M3sEMT87s0zsdaXbf3Vz/MGUO0LzDopdH4+CbDPkG6L9
         MFTXQyqmObj1eNFTbtl8xAFTIGsl3UADpscxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164966; x=1709769766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzYFHNFtHHHpRZc8edEq8bHU8oqWM7vjNzOC9ZZj3Zw=;
        b=pyJqiRustbYtMbZDnzIfTnHoA1wTimzT27TtYSHZs1dxPrH55LOMiUL/zlhPnIkvhd
         ZnDLE+xJtVBPjsV4VE77jnb/DaFal0upEvM4O/QwG7X0yUWYZXjLqUquHSchc74Ezuzm
         +wBV/qLQu8xh9eDCELodG0gKjPAORLeDJw+EyX5boIERgwj2RYpIEQKwuJpOYJgF42rr
         ZYLJnqOapQ/wF/pRG0GpzQGEgJbt0XFw0XCZBF1kjCFI/3X7vSzeilTsAErrWqS0TlWN
         jEBtaUe44lGE3oV6aoFLawJkMQFuVuONZjZN0G4tsJUTHhHRxjCx6hIO/FvZ+FesUTbF
         QWcw==
X-Forwarded-Encrypted: i=1; AJvYcCVYx+kVdjiW8fDWaSN3lcpv2p7/gOok9+pQfQvPurx3qNr6DmFRVZgc2nNurVDxuNelbNtbSN6YEiBnA/qUP/QLIFEVL9xY
X-Gm-Message-State: AOJu0YxTNrWmNE/hUf8gbqaow7N+9B+6kn8jMxN/V1Y7U7EM69Y7Taej
	3wbWvYQLpJzjMjlWfAN3W8PZYLZT/5yOW6coVQAK0BzunvTXZcXPb5puEIT69w==
X-Google-Smtp-Source: AGHT+IHqJ/JwJcpPTP9TpL7Xpyx58Z+NNG0bN9Bpx1sjxaHowFIn1a95cgyKBfJKxJgwJgp15rh7Lw==
X-Received: by 2002:a9d:7acd:0:b0:6e4:787a:9bc5 with SMTP id m13-20020a9d7acd000000b006e4787a9bc5mr461484otn.14.1709164966200;
        Wed, 28 Feb 2024 16:02:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a63d843000000b005dcbb855530sm61436pgj.76.2024.02.28.16.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:02:45 -0800 (PST)
Date: Wed, 28 Feb 2024 16:02:45 -0800
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
Subject: Re: [PATCH v2 1/7] scsi: mpi3mr: replace deprecated strncpy with
 assignments
Message-ID: <202402281602.2750B1F2@keescook>
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
 <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-1-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-1-dacebd3fcfa0@google.com>

On Wed, Feb 28, 2024 at 10:59:01PM +0000, Justin Stitt wrote:
> Really, there's no bug with the current code. Let's just ditch strncpy()
> all together.
> 
> We can just copy the const strings instead of reserving room on the
> stack.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

