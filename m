Return-Path: <netdev+bounces-273343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDieCVH6ymmlBwYAu9opvQ
	(envelope-from <netdev+bounces-273343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:33:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFA2361FD0
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C72730E98F4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0783A0E85;
	Mon, 30 Mar 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SRVjkBgu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A83E3D9D
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909607; cv=none; b=BbmnBKNd/Bne6GIadEyNejEuTNSG7Fn2raPKk/h+vB8QoJDrBb4LW1w6CJRxEjw5sZit82Ckq6y8lBRNvlCmQo4292zjxASAF5eNlDUNi3UxS9DoHQ5wk4zmFmjrQ6rsRMOqDCYTMWqkSWRgZmLrMkbDXdjN/5NVGqeXbvjJqTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909607; c=relaxed/simple;
	bh=njYxOmFhF0kKZxmCluaJeRNQJOvHXtTT/LYX+fA/Jes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxC0lpaKO4Fb8a1fWHFOdnS/kZCrzEvG07osFlUipvrKSONHz/LU9g9PxejLzR+t0vpLWHwqjs1ZiKSxwR8ZgnRrm08Tv89G/omBlGILMSgUd8SojzgvC4tji7gqzU2lPCaK8exXAy67pG3yTlaD5vh0quB/G+mSRUMPdmWe7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SRVjkBgu; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfc40e4158so596223585a.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774909593; x=1775514393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMpjIoYB4wkYY1B4Qvo8YM+LGvG/wS7KH0HgKJnMSKw=;
        b=SRVjkBguFjfCZK6KyO2Br10O0nqWk6wAn3BLxlEleze8weF4NGKj5VBS1no0JjO5YI
         g/8icibDzjoJ0tJ3mTX8v++aieNJw05tHkPlWTQpChPxIIwkR+mVcZapcZOaZwamMkGU
         BxFsK6CI60m3/NSHR9n7W/1RRGEA/BwYPMseTh37M/BCi6MEgkRPdeEMsVaqjQzrH1M2
         hfIKXlVf8INWVlRRJtrqNQBeTHeyhxBgPBBJti+7t1bjluyepJUzik8KVlxhpl/B3k5a
         5bv6rOSUlHPqk37gDhEw2D5iGe/tdQtZx2u/ofN+hR7axrwuYFIQPz5ctd56nxod8Ysk
         WMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909593; x=1775514393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMpjIoYB4wkYY1B4Qvo8YM+LGvG/wS7KH0HgKJnMSKw=;
        b=cfW41bDlLTtpRlx/mzSSKb1DgcTeaqSt1MYnEt43iQ8rngv3qLV3NQUcyhZ/bGFwhl
         tw1S7LLmgk59ewMHpNpiMp8pHgRqVU4EBxBcR96mq2QuVoUcRwBXrFleYqCHf+FR8u9T
         7aFxUTJ5a+Tjq40ZxdpABEx/WBXPTA/HWhIYgbmNDcm9ujW4PZWQ5eNOIk2znrnY5rIM
         Ow4sVrUrOUA/keWH8XOdp55lvP8zm/wq3IgmF73lenXuzEUJvi4tgT+hZCS73e4MhqzV
         Ju/crU5Fj9Vxpcwaujt2dGVBIuC18R1e10ZaTz1NY0dgJlAUAeheonlEAdCOhPmHJI8B
         s8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXP+iVrYV5CYAPQwDybKA7fUpDytBEYI2yJ4JL02pfwZXaMdVcpjevsGXOibgZnkTlcFbfowcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvXoav3L2pMw0aEnL8/j/TLmRL+QX1oakva40PE/zzJNyyaHA2
	FthZUpP6EpEc8M+ENJ7iE858aBKT9AgpZbwg6Deb1A3EjPzVjBiBq2h958QnpHDNtUU=
X-Gm-Gg: ATEYQzzHd9sXmgn0kgVvzS6vKjMyLf89TiOEoG2yELbGzA6GKtsJCk7oxgvD++JaDe+
	K88Is/vnupolcIIZa9bGGeSprx1jopAqvPeJUdrmw2LNc4MyxGwKTcZmCuV/OvcRvNoVKWqD0O+
	d7ZDFOacqcxkdXLSfBhFZSkctJq1QDwxKB114qFMr7YXO8GQouGS3zhqaRUhYke8uuIXNQPlTWr
	rK0+tDvCY87j+U1fhEaUnTCtvX2h9YVbAC6s0vnxO9Zby77Z9hx/r8lIuX9cRnUhlNQux2KYOBa
	b1QBBSmge3bvBcPvLyBv25Mg8ydto5Skyzrm2MTBv7x7Q+Jl/wilKGdxqUZ/a8lvG5YVPpBiVLz
	6jymd0JV8i0GlzhZH9DZ8T0DXmVwdI+x1EFG27tLDEoH4fKNtgt/BlBwQExOUwyESDTZO1LiYtG
	jELupsWhS0upY3Nnxs92Z0TH2vHfKjbVu7KcI86EfpU1gyzn0scEVlyDXcY9OFDtOpLxerbQ==
X-Received: by 2002:a05:620a:2991:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8d01c689577mr1767721685a.32.1774909592771;
        Mon, 30 Mar 2026 15:26:32 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028090f43sm711572985a.45.2026.03.30.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:26:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7L43-00000005H5o-0vBI;
	Mon, 30 Mar 2026 19:26:31 -0300
Date: Mon, 30 Mar 2026 19:26:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michal Kalderon <mkalderon@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 1/3] PCI: AtomicOps: Do not enable requests by RCiEPs
Message-ID: <20260330222631.GF246076@ziepe.ca>
References: <20260330-fix_pciatops-v7-1-f601818417e8@linux.ibm.com>
 <20260330214253.GA92498@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330214253.GA92498@bhelgaas>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273343-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 7FFA2361FD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 04:42:53PM -0500, Bjorn Helgaas wrote:
> [+to amdgpu, bnxe_re, mlx5 IB, qedr, mlx5 maintainers]
> 
> On Mon, Mar 30, 2026 at 03:09:44PM +0200, Gerd Bayer wrote:
> > Since root complex integrated end points (RCiEPs) attach to a bus that
> > has no bridge device describing the root port, the capability to
> > complete AtomicOps requests cannot be determined with PCIe methods.
> > 
> > Change default of pci_enable_atomic_ops_to_root() to not enable
> > AtomicOps requests on RCiEPs.
> 
> I know I suggested this because there's nothing explicit that tells us
> whether the RC supports atomic ops from RCiEPs [1].  But I'm concerned
> that GPUs, infiniband HCAs, and NICs that use atomic ops may be
> implemented as RCiEPs and would be broken by this.

AFAIK none of the NICs are integrated into root complexes in their
topology model..

Jason

