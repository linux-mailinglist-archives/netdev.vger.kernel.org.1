Return-Path: <netdev+bounces-164153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D525A2CC30
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813273AA208
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37CD1A8F97;
	Fri,  7 Feb 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W9a48pDC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6E1A3A95
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738954916; cv=none; b=t2o1W3rCJATYimOWMZfijQcU7Rnj7hfvQlm3cDEZDy2xHRXcH39k/3e2PiteS22pcAQGCaUmWZx0tGgwDnto+k3yL9noQcRVStafTN/vpbNbjNo2DPBKUJAeZdmx0JJYg+CAq8Bui2Rf1+xE1Dbw0WXfIrlBNBxr+mkEWfS4988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738954916; c=relaxed/simple;
	bh=YPSaecsiFXwDzTGHAFZ+jSzAX3eweeruBqLKgpgEvCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdoRwWdw3w1473YD9Kj0lJmmeoGShhkhz13yvIrnvi0fpxtlkUoq5RuvLRj4mNEXJxF80o1tdzcnNPbp4yBe/u4eMAwCnxyXryA/wiU+kdEjg5u7vtRG1hqrKR5Cyb0vuj4c0R3pe8Dt8hFOB3QPAZF09f2z6ROvXQ3KmhQ2n/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W9a48pDC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b7041273ddso218961385a.3
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 11:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738954914; x=1739559714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jhHb/Iyzu9wCbvQ3EuxPsy9WEDtQ71gsxOEbCbrMAfg=;
        b=W9a48pDCS4gt7FtBNlj7uKmO9Pm2RKBBxA9qICSurXf0AhrGc5f1hhwZGIeuFnT/Eh
         QRcWjyALaxu8QteGT5B6VQVJ8ZXe5fLZMEBVDZk/rkDdtqRlF8HcrJjbCwN0QzQy78Ee
         YLMOnUH7IylejaoHt3HLJRFJIc1zc9DZE8gSUYAnn0Rz7nNhc2JStbwQbbBl2/ZUmuXm
         8CTNOlV1/pkv6WWuCp2aVNHycS9d9j9I0v4T6ZxqBCf4dyQ/QVJNNOkRZNvd5/v+tSMO
         gaMmADwnAcZz7nWJziV7K77t6BnFs6Tap9R1Zwr+7tmnhHKX633UTaMlmk/MhKi/Q/Hi
         ZdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738954914; x=1739559714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhHb/Iyzu9wCbvQ3EuxPsy9WEDtQ71gsxOEbCbrMAfg=;
        b=P1VeaxfBQXYxGW1BiqAozytpSS5HsL8hXTHny/SGlN3bI7sDccfbmUMCE/5QGnAXcx
         67Nv3Yj8Dkmt+4H/vQwVhBsMDaQD5+nK8rLqHaZyykff3dD4DR7LAk0n5BAOZ4LEQPd9
         GFPBmfgrH58z/ixwc0ns2O6A6+RTdMBlWj1d8y4Jv4V/nkw8O/73PSFSG40tHPZT95bE
         JTvtNzgye9hCpNPawQPAPyHDESsxO/GZc3NZtQZ6VR4klUP4AJEpSOIqg63v3OvD4Hba
         e2ntjqkA7Lus8NKaC0+ImoQawIr52ERlghBWr2uJ67zXh40Yp1J2Q2io9BN6n9ORWvrm
         nHSA==
X-Forwarded-Encrypted: i=1; AJvYcCUuIz1PFWIwBJuFzazvbdTEfz/ikwAiqpcQEGCywe0HZcG5uEfc401rGZsKVa//NF3wyPISfiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkgeBoxcONkMrLOAy4VKx2yFTYX+Orj15e++J3T+MVDzfCJKa
	hXkxuPfo+Xr2Z8Hoj8sdoqDy09PhOU4tBsvYiiAEIR+SojYCff0LY364RjPxNpI=
X-Gm-Gg: ASbGnct1SEEOoGxHZ2w28yKCxGiECvXiayK9QYWPuK5hjNsssptpaL8nQJEcuU3RAKb
	Si32KE4OeXANMiAGjqJeLIbFQJXjwWzjU2+YtfkftMXvhnMspG1TqZRXLhuCdnVnBzJ1YRyzkE8
	bYkA4AbnpE39kaJQaSI4CfLTF/6xB1LSO1mXI70uJ/1Qq/HYRDN53DZFNqnnWx41mr0dETBjtKp
	tCPcmVO5Ec88BmIlSJa2+IqsJgBkKNNaM0RLl0k5F1H+PUfmuMWLtzPXN1uMwjKpNaEhANYRqTD
	5saOMpkSsmE/m95xVtyma1vz0f0RAbFx/PzcwzvQGnSDvxx4k+sZb2yE2spp+FrE
X-Google-Smtp-Source: AGHT+IGI7NvAKLU4JsJOvorfEjiFHTyYvApddGJTHotUW76EJE4gTICxKMW+ZU1MxMaOyB1msPjlAw==
X-Received: by 2002:a05:620a:2b99:b0:7b7:106a:1991 with SMTP id af79cd13be357-7c047bba9demr630217685a.16.1738954913493;
        Fri, 07 Feb 2025 11:01:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bc75aesm19533301cf.64.2025.02.07.11.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:01:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tgTbs-0000000FUFC-1jHG;
	Fri, 07 Feb 2025 15:01:52 -0400
Date: Fri, 7 Feb 2025 15:01:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	andrew+netdev@lunn.ch, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Talat Batheesh <talatb@nvidia.com>,
	Feras Daoud <ferasda@nvidia.com>
Subject: Re: modprobe mlx5_core on OCI bare-metal instance causes
 unrecoverable hang and I/O error
Message-ID: <20250207190152.GA3665794@ziepe.ca>
References: <CAHTA-uaH9w2LqQdxY4b=7q9WQsuA6ntg=QRKrsf=mPfNBmM5pw@mail.gmail.com>
 <20250207155456.GA3665725@ziepe.ca>
 <CAHTA-uasZ+ZkdzaSzz-QH=brD3PDb+wGfvE-k377SW7BCEi6hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHTA-uasZ+ZkdzaSzz-QH=brD3PDb+wGfvE-k377SW7BCEi6hg@mail.gmail.com>

On Fri, Feb 07, 2025 at 10:02:46AM -0600, Mitchell Augustin wrote:
> > Is it using iscsi/srp/nfs/etc for any filesystems?
> 
> Yes, dev sda is using iSCSI:

If you remove the driver that is providing transport for your
filesystem the system will hang like you showed.

It can be done, but the process sequencing the load/unload has to be
entirely contained to a tmpfs so it doesn't become blocked on IO that
cannot complete.

Jason

