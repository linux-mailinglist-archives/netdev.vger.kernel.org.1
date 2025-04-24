Return-Path: <netdev+bounces-185567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BACA9AE7F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACD27B2E10
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DE27E1A7;
	Thu, 24 Apr 2025 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gmc2XK7y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7BD27CB2C
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500097; cv=none; b=D5R/8RiJfFeI8inbENoUUm6FzSlIjM1/FWlrmih4zQuHMZITZvO3TEIPPcxw1l0F+yKijYfvaJyQCFTLDghfu6gE6XWpGOewOnSWlS5fg4DL34FgyaZ53aEXBZiDUtMrdeKK/IgLbaEKWM+8KxzNfiEeGiRidHjOJuCXvLjsiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500097; c=relaxed/simple;
	bh=dBh43d05JPaTFzI4tVAr4KW3VJiwFVSs07sUTiMBl3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHUQ2Pj6cvcvYFwWtgRAp9v6AdSYPu4PxsFCHwSL3nYF86Qexk31VWXrpEqdUWtVu9uICx0Rz8IgRYA4Vl1by8PYGRYt0DptBiQrDQvgbG/y/54P8nZEdgPm+84pzZd2/5VuwdzmwJDu5i/NYjYGVH/XLCHF8QScxv62bardksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gmc2XK7y; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c59e7039eeso146059885a.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745500094; x=1746104894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9tjejH+aT/nxyoiEDM11iJSGPvdQo5zscD8cSUP0nQ=;
        b=gmc2XK7ywcHfJhe7Xx9/im0XXRHXrVay6vPULQELd4jmwYurJ6swWAB2Mm6HSTSg9M
         8tSirpMIBuBrqE/dt0wk+No3C5395so8+zQ9TJFRwSYnAOk4sMx8YPJRyCDKEi/gj19b
         //SyDxACsXkSDkc+KEf3RPc2Z2CVctAiER8Xjg/fHSWz8dT6Yb9MeIy5O/FVHy34LBeZ
         9qrlbzJP6MlTxLVzhIYsW2/XvSIn22aY8Hnqf40MrGBNs4/kKn6DVysvxFnq544XGysG
         CSpwLMPbjonk5Xog8xD4qFTsO4dR17F6j/l/3cFaNsX0PI8/mIQgkGA9ELrRoXu5vwkx
         3QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745500094; x=1746104894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9tjejH+aT/nxyoiEDM11iJSGPvdQo5zscD8cSUP0nQ=;
        b=mTOoP5Tp5hawktbYAO8XRfRVUferdJotBX9boZydASQlZsZqUbB+zYTIcwSbBm+mSo
         NL89G4jpqRBW0uepeaN9eD0iFzuk2w6TmYr7euA09OgER1UlYNM4VFZ4I93FbrAS7Ref
         npUXg2Vo1TirfADqsXRp3MBxsyzuajp/1CSaprB4m6mvc7/ejWZyQmtv5U+vCTOaGXFz
         /SRRR2/QsQXZE94fcttGJcWSOBxaQkyCCQwTclt3Qvb8HzFZk/2jmEkHlniW9w+GK+xD
         TTduL+SCSAgfFpJ09Z50n49HlEbHfwDts79QKVVzu6Y32oHyREgo7Hg8PwlUWqAcOYq3
         41Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVSR6LSR6BjoSLDvnRWrq4oMh4U8l6kE6/1OvGfgCX9cszoYDJmFeVNBI8OZylZyUTnQcDvYYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPePZbND8b0jCL3US+C9HdzHQllnURd6jqoR7OGQE0JIpYlO8T
	I1L+KXROi4GuVBSbo+J9ysZDPiZwrPjaqW9wgPWcNPFkbCVMzptszV/2hzEE8X8=
X-Gm-Gg: ASbGncvhLyaTg0BhW2I+pIFb16QUIYVNYHE8xn3Enmo1oVTPneWU4gryEMe8/7ivj73
	EwE7hmNJuirhielJ+w4JyC/Jc7Qjm944CcGMZfeBF4fFdC2RPfbiyN4ZOhcOo6ZEEbnqG3qmdzI
	JP17fLF8VtKfuDeJolRFQnv8Cmvt6/KsZbOCu2UzyttfnH+SJ17gj6Nj6eeWAaYJvCkdnkNMd2e
	IEd1tXX6YWKC2CNFsqNv/4b1B+uz64cxC+g3IUAK/tmUC+s/eJut52vZY2HR2VyWsbRNqYau86e
	O4GUqQiVuCKZZhgwI3qqgLdvBOJWC2bQ6HgUTzmSssT6o28a2VuA8jq7RFEGpJumcTX97jkmvR2
	qg+rdLnAvT+FmGTxYWkM=
X-Google-Smtp-Source: AGHT+IFf1O6xGhdHKl6+2HV6nVAPSFzlmWIRSiCQgOhIrXIGUIOWfO/3KcZH+AEpqhBBAwnRKtBRCg==
X-Received: by 2002:a05:620a:2442:b0:7c5:5296:55be with SMTP id af79cd13be357-7c956ede013mr373709185a.27.1745500094571;
        Thu, 24 Apr 2025 06:08:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958c92188sm85129885a.23.2025.04.24.06.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:08:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7wJJ-00000007U7r-1YtD;
	Thu, 24 Apr 2025 10:08:13 -0300
Date: Thu, 24 Apr 2025 10:08:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, leon@kernel.org, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH 08/14] RDMA/ionic: Register auxiliary module for ionic
 ethernet adapter
Message-ID: <20250424130813.GZ1213339@ziepe.ca>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
 <20250423102913.438027-9-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423102913.438027-9-abhijit.gangurde@amd.com>

On Wed, Apr 23, 2025 at 03:59:07PM +0530, Abhijit Gangurde wrote:
> +static int ionic_aux_probe(struct auxiliary_device *adev,
> +			   const struct auxiliary_device_id *id)
> +{
> +	struct ionic_aux_dev *ionic_adev;
> +	struct net_device *ndev;
> +	struct ionic_ibdev *dev;
> +
> +	ionic_adev = container_of(adev, struct ionic_aux_dev, adev);
> +	ndev = ionic_api_get_netdev_from_handle(ionic_adev->handle);

It must not do this, the net_device should not go into the IB driver,
like this that will create a huge complex tangled mess.

The netdev(s) come in indirectly through the gid table and through the
net notifiers and ib_device_set_netdev() and they should only be
touched in paths dealing with specific areas.

So don't use things like netdev_err, we have ib_err/dev_err and
related instead for IB drivers to use.

> +struct ionic_ibdev {
> +	struct ib_device	ibdev;
> +
> +	struct device		*hwdev;
> +	struct net_device	*ndev;

Same here, this member should not exist, and it didn't hold a
refcount for this pointer.

Jason

