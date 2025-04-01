Return-Path: <netdev+bounces-178604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78ADA77C64
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A243A938D
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB05F20469E;
	Tue,  1 Apr 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PI0SWEBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3E204684
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514897; cv=none; b=A9UR/AI68dfS4sDHBx2TtQvEM/ROkqeo0vAOx2nsmhm/ZP1nzlWMThjyYkuq6M3fVx0Uv92qkCyQqIcWVhV+kgmwVVEbDiLizS+czGJBDswDzojrX9zdJEGepEEvIpRrDxGqA7iy+D+1BHx77xOKSLGI14SwgCMO8lZbtcV4nD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514897; c=relaxed/simple;
	bh=b7DokJ7XVk/j8R8Vd23w/Heij2kXjXxZI4RCHC3HCzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsOSoNuRJYf7EwGZldkxXpE2kG01ibdu4sf5kwvYPWslDijUR2XwxmvDARgAZWV1NVIGmg8p+rVZo8negnj5/su6klsZ77Jnph76erOA3EaDyhrijkKe49/et6i7FYnBP/pwVKOu+fqfEbzVs85yNeJTQTco9xlEEzbH/mG0tJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PI0SWEBJ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e90b8d4686so49010446d6.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743514894; x=1744119694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7DokJ7XVk/j8R8Vd23w/Heij2kXjXxZI4RCHC3HCzM=;
        b=PI0SWEBJo/qEdpye4751KiR879Pek5Yp3ruLLRrHne5rsNDzaZzSaKomACuVpY8vDD
         BHWinpRi0c/JO7F+F7LzmWObUGliOAxLfD989tWYG4gPuNb5w8wSkunV9iMy4rHTSe/O
         v4U9MNBOysPF8NoiiwiWk/BWAnz9Qyd5tJPYSXsBvmkEZEklLjdZkHBf9yUaAs7m7PQ8
         en8OhU7RvmTFrYYXvwEORjGps85uaEu98fTDHDeWkuVHnefkOW55RiTbvC/p3Ag6TM4U
         X1snSxZ/j+sLaL38WYDxirzGi1PsyZ0rS7Rp1e6+n7evp394etsnMUU/Ta3eHxbI93QY
         EesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514894; x=1744119694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7DokJ7XVk/j8R8Vd23w/Heij2kXjXxZI4RCHC3HCzM=;
        b=Ja9pijoO/S3a7w8BsXMK3LcIBaPDqM73tZpYjtYaFpbwDzwK5JdZr3RhYsaQ13XjEG
         jyHkRsaqA3RLp46gnehlJy91ms9w+jPUIFLLnit6fE7fWtHc8tti8XFen7B/0NFaGd18
         cJBML9f+tnSTJZdz6KjBMbhEkoisWqCDzRLfuALOqDQvUSKYxU2o7sj/CsRWxSKy8Lt/
         N+DIiFrUFbMn1pAVzo1fkxOInFXL3KJZLjGcvsEnVcmPf+xt5upyWQ4QFEyIPsHrRQRl
         fy6dpJcmB16d768USDnGOHc6Sr8gUUxflyA7jBtqYfg8WnSJ/xjzCdXE948WxKmEb+tw
         Y70w==
X-Forwarded-Encrypted: i=1; AJvYcCXe7B4DQ+37mCjgMTMxK1VJ2CONUkCT1GoGOMwEqg27vKI3uq3DCJTae8dWfnFabxU/MbStjAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1caHK2HeAnTitkMLO2c4m6XaH8htVv0dI7Eg7nQmBrIfns3R
	R3nx4QhKWDrdfzHfUS7NSeZq36TTzhDAthWld3cVVSyMc6h1ZoGN7xMygaC5cCw=
X-Gm-Gg: ASbGncvDU6AqZnNWvjOo+UJWigvqB+ai4P6eXQBecSze3hV+LC9VZJeW+puUcOX3b9y
	Y+V0yequXgqJnp6cXMOdZiOlyqWC8D7zq66YAGuhWE3fwrTmCQd39iC6zStlnUCShSguS4AX58h
	+uEBxbvuL7X1YyNqwFCXH9VwF5/H0aJ8gAlkwOWcL4DwgKv190c7+Lh+Kw/9JdNkLeWzYgECdQb
	Se75Jbgj3D0fb5TMVksq9K4G38HU02KZQ4UM4ENFM/WNlYvFPkDkfp15wSTA12oEeFC3j/k1/cx
	Hxn+QOS2QS7EPc8tWwtczT5N64wAoY6KimEEp/fOdciuTtWD0pPpCzO8V30GvTfjH3O5Cw0gXRL
	dDRs6yJc/2e29yggdjvK2uno=
X-Google-Smtp-Source: AGHT+IEacbMHkOm9xYeGO73jBnk31ISf7JNXKfhy+DIhsFExOdd5H34dWs6gX0/0UMQut8otUAx5Mg==
X-Received: by 2002:ad4:5c62:0:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6eef5f14834mr46223706d6.42.1743514894053;
        Tue, 01 Apr 2025 06:41:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9627d88sm62019026d6.8.2025.04.01.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:41:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzbrx-00000001KsT-0FLY;
	Tue, 01 Apr 2025 10:41:33 -0300
Date: Tue, 1 Apr 2025 10:41:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, abeni@redhat.com, horms@kernel.org,
	michael.chan@broadcom.com
Subject: Re: [PATCH rdma-next 0/9] RDMA/bnxt_re: Driver Debug Enhancements
Message-ID: <20250401134133.GD186258@ziepe.ca>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
 <20250223133456.GA53094@unreal>
 <CA+sbYW3VdewdCrU+PtvAksXXyi=zgGm6Yk=BHNNfbp1DDjRKcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW3VdewdCrU+PtvAksXXyi=zgGm6Yk=BHNNfbp1DDjRKcQ@mail.gmail.com>

On Mon, Feb 24, 2025 at 02:30:04PM +0530, Selvin Xavier wrote:
> > I'm aware that you are not keeping objects itself, but their shadow
> > copy. So if you want, your FW can store these failed objects and you
> > will retrieve them through existing netdev side (ethtool -w ...).

> FW doesn't have enough memory to backup this info. It needs to
> be backed up in the host memory and FW has to write it to host memory
> when an error happens. This is possible in some newer FW versions.
> But itt is not just the HW context that we are caching here. We need to backup
> some host side driver/lib info also to correlate with the HW context.
> We have been debugging issues like this using our Out of box driver
> and we find it useful to get the context
> of failure. Some of the internal tools can decode this information and
> we want to
> have the same behavior between inbox and Out of Box driver.

Can you run some kind of daemon in userspace to collect this
information in real time, maybe using fwctl or something instead of
having the driver capture it?

Jason

