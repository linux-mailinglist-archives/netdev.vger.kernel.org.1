Return-Path: <netdev+bounces-86845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D88A068E
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D84B22138
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 03:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598A013B5B4;
	Thu, 11 Apr 2024 03:11:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E113B58A
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805115; cv=none; b=FyuVOIFCPK1VkrO/HUJYYN4egx+AOMWsxUB1Po1yodhZrmRg7r6ncAQH1UznpCH5liAUDma3Pjo+UwufMwBsws3wT5BcGYP/Prbr3aHoc3ak/iqVQKC92cqVLX6DzuMKqgI6mdAk5HimUGI+hZl6eDJwTmPH/fznhEbpIvBIvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805115; c=relaxed/simple;
	bh=LIh0oE42GjGAlqoitfFkivY6PWVrC6QJAaXkgN0ZYmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLV+5r8SVrGWt2qeMwMZWOd2Fys99Ce8SGmQVlC7zmEw/GBeTVPe9EB3mr+HWuKluh3IxZ2pTbTCNsoq0ljIZ5zS5hJJ1+uu0K8IqrVZuBAO5B0ZqZymf7qp5xEt3zglw9ie9VKC0hgeAqZOT5Nv8IUovj45qcE49LAalkNoo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFPpv3vjfz1GGg0;
	Thu, 11 Apr 2024 11:11:03 +0800 (CST)
Received: from dggpemd100005.china.huawei.com (unknown [7.185.36.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 6005E18001A;
	Thu, 11 Apr 2024 11:11:50 +0800 (CST)
Received: from localhost.huawei.com (10.137.16.203) by
 dggpemd100005.china.huawei.com (7.185.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 11:11:49 +0800
From: renmingshuai <renmingshuai@huawei.com>
To: <dsahern@gmail.com>
CC: <liaichun@huawei.com>, <netdev@vger.kernel.org>,
	<renmingshuai@huawei.com>, <stephen@networkplumber.org>, <yanan@huawei.com>
Subject: Re: [PATCH] ip: Support filter links with no VF info
Date: Thu, 11 Apr 2024 10:57:56 +0800
Message-ID: <20240411025756.59008-1-renmingshuai@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <0bc56a4f-ff48-43c8-87b3-8d5d23a30997@gmail.com>
References: <0bc56a4f-ff48-43c8-87b3-8d5d23a30997@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100005.china.huawei.com (7.185.36.102)

> > @@ -2139,6 +2141,7 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
> >  	ipaddr_reset_filter(oneline, 0);
> >  	filter.showqueue = 1;
> >  	filter.family = preferred_family;
> > +	filter.vfinfo = 0;
> >  
> >  	if (action == IPADD_FLUSH) {
> >  		if (argc <= 0) {
> > @@ -2221,6 +2224,8 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
> >  				invarg("\"proto\" value is invalid\n", *argv);
> >  			filter.have_proto = true;
> >  			filter.proto = proto;
> > +		} else if (strcmp(*argv, "novf") == 0) {
> > +			filter.vfinfo = -1;
> >  		} else {
> >  			if (strcmp(*argv, "dev") == 0)
> >  				NEXT_ARG();
> 
> The reverse logic is how other filters work. Meaning vfinfo is set, add
> the RTEXT_FILTER_VF flag (default for backwards compatibility). From
> there, "novf" set vfinfo to 0 and flag is not added.

As you suggested, I've modified it and submitted a new patch.

