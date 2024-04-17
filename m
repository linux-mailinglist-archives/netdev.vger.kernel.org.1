Return-Path: <netdev+bounces-88552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF3D8A7A81
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 04:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846291F23DF1
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654CC6FB9;
	Wed, 17 Apr 2024 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AvR1qm9f"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1B4690
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 02:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320586; cv=none; b=hLH6AUzW1/nc6D7xpxwHzFVxZXqzTmYtav239nhVOu8/OdDqGPvUkhOn/09seAotkbs6kup3ZnK9E+Z/vNulMv3eR5kgOSXwClnid4eTOkXSCobtAPIzXo8nEBVan/PK5yVm6X3uSU1KigpyuDHpK3mQ5nzvOdUi2PDFAHAFAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320586; c=relaxed/simple;
	bh=b6z9a2sq+XyqS26y6EiD/zKw6EXQNsuBhU7W3ax7Kjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kbk14itsMezkbjWN8tUy/+vJ9ZBdwwledRRvVyg8O46zdYfgMq/q/pkx6oQIdeRQkMPI+M01Geb7wr6Ci88N0NtCJ3cnWx0pbSZ7Y2SYHi/I8NuqaFoPfabNGAIVwIyUZZ6MTRfv7GTT7f5qH7s6y8kRNDRxtCe/SoGDnYojLhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AvR1qm9f; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713320575; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E55CPw2jBiMvRQ6oD9WS9XetsEfEvIXR5GCoyNY9BDk=;
	b=AvR1qm9fkSQI1KlrM6xGPws9kVDiwQAomwrUiCEO/d5Or5EsHfwSBfgRLWeQGfqGLxjO5EaCm9eeifXfgYB7TQ3QVVMI79lYjef1+24BGIhl4O+rolQYiA3WNcuo4O08+5yYLwcTudugSkUQ230WLHYg99lCAF/EbVCKp1GR0o8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W4jWXJf_1713320573;
Received: from 30.221.148.177(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4jWXJf_1713320573)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 10:22:54 +0800
Message-ID: <1abdb66a-a080-424e-847d-1d2f5837bbc4@linux.alibaba.com>
Date: Wed, 17 Apr 2024 10:22:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/4] ethtool: provide the dim profile
 fine-tuning channel
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Simon Horman <horms@kernel.org>, Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240416122950.39046-1-hengqi@linux.alibaba.com>
 <20240416173836.307a3246@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240416173836.307a3246@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/17 上午8:38, Jakub Kicinski 写道:
> On Tue, 16 Apr 2024 20:29:46 +0800 Heng Qi wrote:
>> Please review, thank you very much!
> Please stop posting code which does not compile.
> The mailing list is for reviewing code, not build testing it.

Sorry, three versions v7, RESEND v7, v8 in two days, this may have 
caused a mess.
RESEND v7 has addressed possible bot warnings, and v8 is a fix for 
Simon's comment.

Have you encountered compilation problems in v8?

Anyway, I'll bide my time on v8 to avoid another mess. ^^

Thanks.

