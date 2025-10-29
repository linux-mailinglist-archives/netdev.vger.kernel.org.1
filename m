Return-Path: <netdev+bounces-233978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCAFC1B258
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13C5F5A95DD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A39A33F375;
	Wed, 29 Oct 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kyGtX2Pt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC9290DBB
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745000; cv=none; b=QPuYzdHCzZ+nxDvkNiph6ZqXjMFPAo6o1FalQ8nOstK5FwIjVs6qwEgiT26UOqVZpAItceylHHl5/hVs5w+XS2Y01OL5BNW3dHFC1cb4by70R7TKoLvtyGP8VquACXldVorXmSkHnyrDh9pjTh+KYI9rmyvZ/0+Lwkj0QRqLdIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745000; c=relaxed/simple;
	bh=Wjvd24PZ6lX6SZVjlm0MRWQ3CTydIvzI0NC4nd8c68o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Brupwnhn1cOWiic3DAi8e6yXEYY5kZHWIgwvlu0hqF3uWOBOUrGs3dlI2h2OMQl/JRobepzaaGMj3E+2NWAaZePX0vqZ57fuac5JWgnOStneYuDimOBbnSWXjgQGIbAZSZxri982f+uoHX2mCAFV0/nprU3pO7/NuRj/9ImtddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kyGtX2Pt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-89f44f98acbso515174385a.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 06:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761744997; x=1762349797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0AdKLzPillHi033TMRXHFAVev4P+ahw30kja1SvViY=;
        b=kyGtX2Pt0UHjizPvA4lOssULuwTGHR9TEKag3P+qN5gGIQBojcV7/DZp0KnEG3AmEO
         +w2UrwIJI1lLQZSRIAwm5eT4grenYjw6r7gppwhNKhxblhI0ePyYebiVdvC82j39QYpD
         8WqbbCLniutr9aYtwe1EHKcffxCTkXUMd22YD2aMBssJJAnO4sCeJeURoq2PKOw89lbv
         3oc8uVnwgFFyd/83v2i2eLT71/hb6VrWfd+OIYj+O63RQn2u11JcZaf45evyHHjThmS9
         r/wJ3jESGZYFroLhp1ptpOXWC0xXCR6fvB66+63zxzeWF3JdoXOwklXQScr0Jh5IuJtl
         8pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744997; x=1762349797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0AdKLzPillHi033TMRXHFAVev4P+ahw30kja1SvViY=;
        b=h0b65Tv2C6uQ0f3F1A7h+7vAatrjSrfxPbYusTKdSlY0tp1so87PdJn7QCc8aGmltz
         xa0Pd6NEPa9FTU6i9mOMy6qGVSXwBcTG0+Y+tN45Ggww4w5dItu/G36HE7R88ZtB7guP
         7pClnFRa5U2UvtX0Z1RVJ+uh1TxT7JW5Sn6V+zxmeANQ43pwj5+8vqPI3m5Qtwe2z/Vp
         F7sDmLVNgOQ+0rX9bAfHd7Z6z/UlssIvI4cr59a6svcJE6uhFRDqMIGF54t+IMNYXPN5
         UzuSQxk18nXQeqMnTuWzjxRyKURIVFozAf9AIAdGpXtIpt/q2JUvVftz1c16nOCwckj8
         MBgg==
X-Forwarded-Encrypted: i=1; AJvYcCWfWBjDGaRtnEVQIsQnbjlYar9PWeh+wY2tJaTbu1FMWO0BEkSB1fTzSwY0aihDkYDlNNAGsNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJGzoyQN6N3n8gZWA1amOMATjaVkiO5H04de5o7qYtdS9B9UG
	D7sVUraMpeR5h0AX040mBSGfgk75BdOdJZ/Q4EykCy0kBQkcLiQEMpNsBJmBheLotPs=
X-Gm-Gg: ASbGncsKhMdynvqcpAgOPrU62b+CSxdK9Lsfvg6y0Mq176OHfw9/2Ic8PZYIk65z+/M
	L3103Fn5aU7O6sABO/oj2tTSjRB6DN5BaW91l3LaZ/u09xr66JVldxi2t1XSd47b2D5NkcIwzLU
	EeIXKGKGXEsW0S1TLqsPb4KunopVHbNe3CGTyPAW852Qh01KRK8ZZyk+n3oI4OSzzvIeqx64OuM
	GCgudoZPe/aQYmz/eqSh6L7tKlKmjsozZc9N00Xn8lEZf2Rs1Ej3RmYHmae6mlJOP/kQGScY8wB
	ngZFrZtjfRFtgjy0ysr9k5uazkSQ5m8m/JFzAqtEQcwNWXdq5z7PSRbxCIjJCCeqkDTw8WUFe3W
	5o3aoh33romRevUFdc7DQVVhzmtA8LnzhHZnwmNo5CNP2icsW7hOqQkEYgzGrcma5uBAWgyGd9e
	1nkIX2s1IP+uztBBMCJLQHR5FYjvakSYnThr9845Pd2SaXq6rxg4sT72kx
X-Google-Smtp-Source: AGHT+IGAE0SOpZpoN41adN34IF2YwVMvQ9wz7z8YvoKLlmaz7aDJPXOZRSV/8w6Q6v+YU59eEE8YQQ==
X-Received: by 2002:a05:620a:404b:b0:892:5b57:ea3c with SMTP id af79cd13be357-8a8e37bb07bmr368352285a.2.1761744997082;
        Wed, 29 Oct 2025 06:36:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fc6fsm1046414485a.9.2025.10.29.06.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:36:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE6Lr-00000004eO9-3vrt;
	Wed, 29 Oct 2025 10:36:35 -0300
Date: Wed, 29 Oct 2025 10:36:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, michael.chan@broadcom.com,
	dave.jiang@intel.com, saeedm@nvidia.com, davem@davemloft.net,
	corbet@lwn.net, edumazet@google.com, gospo@broadcom.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, selvin.xavier@broadcom.com, leon@kernel.org,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v5 5/5] bnxt_fwctl: Add documentation entries
Message-ID: <20251029133635.GM760669@ziepe.ca>
References: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
 <20251014081033.1175053-6-pavan.chebbi@broadcom.com>
 <20251028164651.00001823@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028164651.00001823@huawei.com>

On Tue, Oct 28, 2025 at 04:46:51PM +0000, Jonathan Cameron wrote:
> On Tue, 14 Oct 2025 01:10:33 -0700
> Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
> 
> > Add bnxt_fwctl to the driver and fwctl documentation pages.
> > 
> > Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Would be useful to provide a reference to userspace code that is
> making use of this.
> 
> Jason / others, did we ever get the central repo for user space code
> set up?

No, we have some fragemented userspace repos at the moment only. I've
been looking around for someone who'd like to take on the challenge

Jason

