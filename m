Return-Path: <netdev+bounces-210003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6A1B11DEB
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 13:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF29561613
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068092DE70C;
	Fri, 25 Jul 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYxiGPnY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896923F40F
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444273; cv=none; b=aXjNTVz+YN5Vh/XquJH4zQYWiqTTVUz+2GYL7wVEmqzc7JhE4G1NDerirc/qxgtyPkR6Y2K19WQwnfuUOkk4F7RFc88bNmOIWbaea5Cm3/dQk/4SXMa273akRS8z7uJP37mQQLTG1Q2kSw/uDI2FfqfN9qNbvTbBDOfsIVi2npY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444273; c=relaxed/simple;
	bh=eaz/k0XUl9/m37N9jp4+DjxLU/AFRKjbVXkkx0LnzuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQnPg+Qo7HC/YO85IGz6xRdHTycXBfVVaj0eXo80OENg7kGt0D+mGEyTbXW5TrkrJO5Rz+r6vWyS1kShvoCnjUvRPq7yMkGyWYu7SWnCZGcCa1BTCDdGsF/IKXZkFsDnIbD8FP0Dpsy7N2G8IQoHo/Jkiba3+p7+rQpanLHm4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYxiGPnY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so11474315e9.2
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753444271; x=1754049071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G39Ht0cASJSf8Vm8tYG6XzeHDMGd5e51f/0AVFb03Ug=;
        b=kYxiGPnY0g8/NBH63L+t8ruusfWPAe/pxxcy/ilkihw4gUcHhj1ijjFckxvBKjDGHU
         LZtPGDJ5guJDbvUdDMwv0Ybg1dL1AIUTeLU3F019r5JOxzUs5xZuGtfDEAyot+dbzmBe
         3ho55sBfA1DsMts0qzRqB6gt16X2cmbBjf4yJdpIHourXWsuCWNose1TBB2uZdD5Ez+F
         vioKAQUK2BgdvWeTsr1YuorDF0JL/IpY4kRtl3GTPj96gb09KVOqnc0gHy9pfse4ogyr
         aKeeYUOVJ28YUw94LWzK8pwPIyKbpcKsr36W1Z33ifq9ndtJ2ZlFT6kxOMmuU3hnd3ih
         5QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444271; x=1754049071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G39Ht0cASJSf8Vm8tYG6XzeHDMGd5e51f/0AVFb03Ug=;
        b=LqvzbnzL0JxaHtXaZ/AkPRvlmieSKduzLSIC29cnh20PPdczR399bhiwweCBXLkVH+
         s+QFk43piL8+7UPgmzR3y2bji9tCSI20bn5/EGruHJt48wDEyZN8pA+NYxtmNGSvTOQ7
         WQR8xF9xstaCH1lK4FG3mH+GEKC+9FtgcO4fQosw2eWp80Yt/OOr/IBjNR/w1noh3r5r
         w9uhbT8ADj11fTMUWG1Z33ZXZPTI1pHqVa9mQvP6IksLlKTA6knFkhOz2dr5Zrh7K6yn
         upmg3/xyRtdR8DW8HUxy0Fmgqaj4E9ZNFiRmSBc7cfXtjr39Jlf/HCPd/USW/ppTEJGG
         bYOg==
X-Gm-Message-State: AOJu0YwRs37rumClRtjc5NktrCSUVKDYmgzUVqKXe9BTu7Nc+GnGJ9Zr
	yx4ThnCL+3ZSRxusIMHjW82agonn6nSmgREMj9IMVKE/RHlZNocuhooRfKTGs/s0
X-Gm-Gg: ASbGnct0sAPwo4ovTBxe4iVtMsnJVbXcDMvRTaufQ/b1JaWuDk78rjLcMO9ylVFVeXY
	MufZ2nTmRM7kJH1xKWiudqHtha3BzuUIjND3viZzGfpX040vbkNYgZJ3RDU6sSpquVjKbzUYLzR
	vSSWlVuIL/tJrdBzX6eIVmEfLHCV+b8ZpIkTLCNFhi0u2+Ui1jXSJEH8mjjP6SYqKlqL0fziTyF
	BQr4kvtDxncHJrvEP9iqcKx0LDcZtFkob22ZJ2Sv/4NPhddCnnEohjMdSebdS3b7XFyfbN4g8G2
	A/pyAY5GUQlPE1JHGWzSQGLkGgZBcXoLobEBwVWnfDdulN/GNGqRMTk3PaFLqjgxAChChJ4aEnq
	kw3+gty9A5nv91mEMUUW4E3RbYUh6rvHd9T4GTa8F5SY6zEME3lEu3VE=
X-Google-Smtp-Source: AGHT+IHGErcDFcSf5LS36mdqBjR7lNYNd3Z002kf8K8T7M2Y8YEGM2XGFdrB9eK8tqHhfmECuLSYig==
X-Received: by 2002:a05:600c:6291:b0:456:29da:bb25 with SMTP id 5b1f17b1804b1-4587643928amr13827045e9.19.1753444270361;
        Fri, 25 Jul 2025 04:51:10 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705378f4sm53908375e9.2.2025.07.25.04.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 04:51:09 -0700 (PDT)
Date: Fri, 25 Jul 2025 13:51:07 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Yonghong Song <yhs@meta.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: bpf: LLVM BTF inner map struct type def missing
Message-ID: <aINvq2iqUJkNBvZT@gmail.com>
References: <aH_cGvgC20iD8qs9@gmail.com>
 <PH0PR15MB5639C7853B00C613ACF18A74CA5CA@PH0PR15MB5639.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR15MB5639C7853B00C613ACF18A74CA5CA@PH0PR15MB5639.namprd15.prod.outlook.com>

On Tue, Jul 22, 2025 at 11:02:58PM +0000, Yonghong Song wrote:
> > If you think it's reasonable to fix, I would be interested looking into
> > this.
> 
> Looks like this may be something we want to fix as people starts or already uses
> nested maps. So yes, please go ahead to look into this.

Here is my proposal patch https://github.com/llvm/llvm-project/pull/150608.
The idea is to visit inner maps as we visit the global maps during BTF
generation. Unfortunately, for that, I had to add a boolean arg to some
functions, I hope it's okay.

> 
> FYI, the llvm patch https://github.com/llvm/llvm-project/pull/141719/ tried to solve
> nested struct definition issue (similar to here). In that case, a type_tag is the
> indicator which allows further type generation. The patch listed llvm source
> locations you likely need to touch.

Thank you, it was very useful to have this pointer!

> 
> > 
> > [^1]: https://github.com/cilium/ebpf/discussions/1658#discussioncomment-12491339

