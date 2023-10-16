Return-Path: <netdev+bounces-41152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7477C9F8F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953B91C20950
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 06:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FEF14AB6;
	Mon, 16 Oct 2023 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwlnOkgC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CA14288
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17F5C433C8;
	Mon, 16 Oct 2023 06:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697437913;
	bh=20RcKOCRsPjkWUxtWVxoneCILhiaUiobXL++bhSC4Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwlnOkgC6zccBetdIF/4nLVwLqjuoMzF5HWii0KFLPnswduyOzUkRYmtvzGUKe6H/
	 x71JAKAzBWDfT2YbB6vDhSivu/5WI9dcUj8YSbMWMFChNyCO+nYUAWtd4Z5wwKjzsK
	 Czqi2PNjt6lzTOoyMwY8OzRwL3CnEGjua5Aqa/EcpbXlU1WyHH/8KikKyysrqW4NcF
	 Waiizhgi2T2ftzXY7vXc8rKZ1RjUcu4YQ8qL8+PKho+32ohOwNEyNMAGM8q3qeu6HG
	 Ail+JDmTZh7Uz+Jz/xlXQe7WtQ8reLHFKBG1VMT55zGExDAk3X5NsNf/Fej2sC/T2b
	 8h7eP08B+MGFA==
Date: Mon, 16 Oct 2023 09:31:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
	stephen@networkplumber.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 iproute2-next 2/2] rdma: Add support to dump SRQ
 resource in raw format
Message-ID: <20231016063146.GA4980@unreal>
References: <20231010075526.3860869-1-huangjunxian6@hisilicon.com>
 <20231010075526.3860869-3-huangjunxian6@hisilicon.com>
 <e12077e2-ac6e-ae76-bc11-7795034df6c0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12077e2-ac6e-ae76-bc11-7795034df6c0@gmail.com>

On Sun, Oct 15, 2023 at 09:54:14PM -0600, David Ahern wrote:
> On 10/10/23 1:55 AM, Junxian Huang wrote:
> > @@ -162,6 +162,20 @@ out:
> >  	return -EINVAL;
> >  }
> >  
> > +static int res_srq_line_raw(struct rd *rd, const char *name, int idx,
> > +			    struct nlattr **nla_line)
> > +{
> > +	if (!nla_line[RDMA_NLDEV_ATTR_RES_RAW])
> > +		return MNL_CB_ERROR;
> > +
> > +	open_json_object(NULL);
> 
> open_json_object with no corresponding close.
> 
> > +	print_dev(rd, idx, name);
> > +	print_raw_data(rd, nla_line);
> > +	newline(rd);

It is here ^^^^.

  773 void newline(struct rd *rd)
  774 {
  775         close_json_object();
  776         print_color_string(PRINT_FP, COLOR_NONE, NULL, "\n", NULL);
  777 }
  778


> > +
> > +	return MNL_CB_OK;
> > +}
> > +
> >  static int res_srq_line(struct rd *rd, const char *name, int idx,
> >  			struct nlattr **nla_line)
> >  {
> 
> 

