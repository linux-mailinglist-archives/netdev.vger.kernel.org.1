Return-Path: <netdev+bounces-89296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84988A9F90
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4701C21C28
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688516F8FF;
	Thu, 18 Apr 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AOpkoEye"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1CF16F851
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456380; cv=none; b=rMlEREInco5b4krEEIPpHjQXecSbztSe6cEK7qIBks6Pje7jjydrCqH5cDZFtdnWsss2lYG4Uer1J9TTaVCwxgy9pP9S1QOVRTaAkVD0ADIlh0G56S0BX0PFCzc764cXvPughKcRnqQvtjcevX/HRLvMjjVWM6wsLssNDjkNwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456380; c=relaxed/simple;
	bh=Y/heGktoA68QBCplEkjVHGnBmjZAzNi7ohDYGyE0POk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMeTxNO3Y76MyPNCjfVUzQFVZULYsZzsm/0G47INbM4IOvxi8P5BBNwRvdGzMe7Wbn5zPfAj/nERDBEpUECu3BmZ+tEpZG0wTA18+wZKfk7m0nd+JPLmLiorxWxKOF/DwrByyWvwS14zJAajIVbNtgN9b3Deu2RZxMu9Qa6/4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AOpkoEye; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713456372; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=huP7ejolsE0iGUnCoSxQbMRLw1Yoi/q0PzHQjduj7WU=;
	b=AOpkoEyesiMaP2/JysfdQsEzvxZXOdHymrDucqtx33zB12uSKj8RdmNSkLrkSUXTttkVgWuKiqr1DifGn4aimXMMxTEhkpgpb9sFZL5nw8Kl3UbkN6zi5AM23NPR5qpTfVV/R4vzYF3rI85KzAAQs4ioovdimBYuBCeeHM7SzEg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4p1UVo_1713456370;
Received: from 30.13.151.155(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4p1UVo_1713456370)
          by smtp.aliyun-inc.com;
          Fri, 19 Apr 2024 00:06:11 +0800
Message-ID: <4e71c828-7f50-461b-b5ed-90fb45749521@linux.alibaba.com>
Date: Fri, 19 Apr 2024 00:06:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command
 VQ.
To: Dan Jurgens <danielj@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
 <20240416193039.272997-4-danielj@nvidia.com>
 <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
 <28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com>
 <ad9f7b83e48cfd7f1463d8c728061c30a4509076.camel@redhat.com>
 <CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> I didn't see any warnings with GCC or clang. This is used other places in the kernel as well.
> gcc version 13.2.1 20230918 (Red Hat 13.2.1-3) (GCC)
> clang version 17.0.6 (Fedora 17.0.6-2.fc39)
>

I think Paolo is suggesting this[1][2], guard will mess with the sparse 
check and cause a warning:

[1] 
https://patchwork.kernel.org/project/netdevbpf/patch/20240416193039.272997-4-danielj@nvidia.com/
[2] 
https://patchwork.kernel.org/project/netdevbpf/patch/20240416193039.272997-6-danielj@nvidia.com/



