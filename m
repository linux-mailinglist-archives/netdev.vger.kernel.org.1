Return-Path: <netdev+bounces-96190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E78C49DE
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24641C20BC1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39C884E06;
	Mon, 13 May 2024 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H9HUxKuX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9735E82488
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641579; cv=none; b=ISjp3/bsLuOIu5Km+co37nkivXdf5bY4HRKHnTv72Q3KboDYpzBSP588hY3W677HGodxcs9lF+cexGQAcb1ozPc988hOh9or0mXsAHzOg7wPF4kXQWzqYSeGNTjBITIKdM/Mjau/zlR7Brs04oT6XJ27CE9kBuIwtYbCibtX1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641579; c=relaxed/simple;
	bh=1QNMHnIjg/Tb+YW4thfawpAMJeCIRCs3mm95uw3AUNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkpgjJcbzv0p4C4pjW1nA0WKWTy/9FfKuWy8nf/ZiBqBDTC0r3WtXUPCEjiu/LR2lqCFeJMVf8PPKL63dR0BxGBZaQtCYkM7zOtYMu0NR1FDMEdj9glIq06zgwIzJUIkNnCc/VfgYY1Xrrs3RKiN+zKT905FUrQ6u1TPwRevQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H9HUxKuX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed012c1afbso39937965ad.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715641578; x=1716246378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/FqARGodQUd4K2eEmu4YR59CbGKEydXfi5YMd/QCV0=;
        b=H9HUxKuXtNIw0W7Y/H9C7jGqs40lPHSZ8LT3UsbQbJhDriVYYrFxrm3IjQbCqhTkyz
         Iko7kIBNBRicpn7DDSKUHCnTxKpG6AuzOiBjPntmN2xE+hfPXEnUVTpkRQZdDDGbeZqK
         yiJTLxLJXmhiBE0Zo3de3PtaF0MwCbb+BybXj5AHNWWF8kxyIXOFYI1m9Nr3Za9WKvfN
         CHUnJ3efRE1N4JxFRrayxTMpxJ1q5Z1C7DKFORbiyT2y93onUhB9wVFbvU2xePODH7rS
         lB4/d9WjM/6EHh4JUlwg4yKa52vWZ9aX9u3lS2LyBGRBCju8Gp4Et9RQGEpJu8waTTx5
         9LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641578; x=1716246378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/FqARGodQUd4K2eEmu4YR59CbGKEydXfi5YMd/QCV0=;
        b=scKO7nrFIMILES18lAYlZAu9Cp0okn2os+LS1p5b65lihZOS/u6Y1R57LMcjhzKlUj
         d7C9sAb9gwIH5xNU+kHmOCaLvpviTk1Eyu4abRJEHHoHCrKz/oMYRj30Zd7HkY/qIBwk
         WnjhAtk8e/8eYyXpLBIbsBEeq8PPRwso9LnJVUPoscxqm6FeSmWAnwMxlXJ0jFWwrqew
         VlCg9TmTKCd6y5WJfrdhTY81S3xKL1vK8PavmLSm6Q5P3gNJ9KLBiaMzoIuWXsHx/vbT
         gbO882ThMJE9EFkY7Zc/IK0Xk4gL/x9dklxYJSmwpLzKWPVVuy9jXjF9FUDX9j8mff7D
         VI/g==
X-Forwarded-Encrypted: i=1; AJvYcCUMU+Ryl/4I8lmkJBGShIe1o8kpxSbiRXEmwS4DWW0K9UCni/UgUWbgu06ET7Pss9G0bJJX5Clic1kJVs6eO3ACIaBYEoat
X-Gm-Message-State: AOJu0Yz8UDIsfnVVwaTohTLM3acsNDMvMGY0LhfTkfH11P29VQq7c2uh
	zlK1EDobJX/P6SOSSBivUpPDGQilsQQNcfzkO31NEvO/d6UKjDXeW7fYNQaGmp0=
X-Google-Smtp-Source: AGHT+IEY6vTkNLQ5aDFl6ziFRoY24BM7GlO8qN98W3K261UAVqcSWAl/Qhkhw497180Jq+GGmFRe8Q==
X-Received: by 2002:a17:902:f68f:b0:1e0:9964:76f4 with SMTP id d9443c01a7336-1ef42e6e646mr158440115ad.14.1715641577934;
        Mon, 13 May 2024 16:06:17 -0700 (PDT)
Received: from ziepe.ca ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badcd43sm82411555ad.105.2024.05.13.16.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:06:17 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s6ekK-0001fY-JW;
	Mon, 13 May 2024 20:06:16 -0300
Date: Mon, 13 May 2024 20:06:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shay Drory <shayd@nvidia.com>,
	netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <ZkKc6BFEQsmjTbvl@ziepe.ca>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
 <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>
 <ZkDg8Aj/TdOqFwqf@ziepe.ca>
 <5a3520fa-590f-48be-8594-de44ae4eb750@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3520fa-590f-48be-8594-de44ae4eb750@intel.com>

On Mon, May 13, 2024 at 10:33:18AM +0200, Przemek Kitszel wrote:

> What if I want to store some struct, potentially with need of some init
> call (say, there will be a spinlock there)?

Yes, that specific pattern is definately a bit tricky, I have a
version in iommufd and I think at least someplace else... A helper of
some sort would be nice and could do a bit more work to be optimal.
 
Jason

