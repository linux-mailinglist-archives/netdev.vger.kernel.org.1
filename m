Return-Path: <netdev+bounces-245115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F070CC728A
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B748130FC812
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC56364E99;
	Wed, 17 Dec 2025 10:26:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DC3644D2;
	Wed, 17 Dec 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967191; cv=none; b=XtFHiPs48pAdXP7KuAXok2tIFl14v7QUY5kyWrXuANMKZhDp/7CJFloRAk3ktSRycK/iVI9WcmzI8ect2iNqxczKKj1ZZQzBncvnjLgTPLMzsbNec2RSKBpxotSamCcruuwsgiWnNHyJpuvpvtIU6u/zsHWpNnOpy2xqPHSBtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967191; c=relaxed/simple;
	bh=kIStRyETvmykF7bKMutCRsxWmly1z40IKQfiXhf4ZZU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWU7hmBbgyeI6lKKcMj0APapblqtIhyCPRz1zpC8oJtOiFX6VtC6plQa9M/2yqyKEEDOaM7veZTGE8GwYKFbTmjb9UIrXi+8/eHiOcHaaT46FexG3lmxzIix8xgxg+AKj/cvnswWUuPqPHRXWCOB2pqUHt+LOUFw3oUE6Q8zldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWVLr0pGqzHnHMQ;
	Wed, 17 Dec 2025 18:25:56 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2068640565;
	Wed, 17 Dec 2025 18:26:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 10:26:20 +0000
Date: Wed, 17 Dec 2025 10:26:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <david.laight.linux@gmail.com>
CC: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, <linux-kernel@vger.kernel.org>,
	<linux-usb@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Crt Mori
	<cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Mika
 Westerberg" <mika.westerberg@linux.intel.com>, Andreas Noever
	<andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, Nicolas
 Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v2 08/16] bitfield: Simplify __BF_FIELD_CHECK_REG()
Message-ID: <20251217102618.0000465f@huawei.com>
In-Reply-To: <20251212193721.740055-9-david.laight.linux@gmail.com>
References: <20251212193721.740055-1-david.laight.linux@gmail.com>
	<20251212193721.740055-9-david.laight.linux@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 12 Dec 2025 19:37:13 +0000
david.laight.linux@gmail.com wrote:

> From: David Laight <david.laight.linux@gmail.com>
> 
> Simplify the check for 'reg' being large enough to hold 'mask' using
> sizeof (reg) rather than a convoluted scheme to generate an unsigned
> type the same size as 'reg'.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
Hi David,

Just one really trivial comment inline. Feel free to ignore.

Jonathan

> ---
> @@ -75,8 +59,8 @@
>  	})
>  
>  #define __BF_FIELD_CHECK_REG(mask, reg, pfx)				\
> -	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
> -			 __bf_cast_unsigned(reg, ~0ull),		\
> +	BUILD_BUG_ON_MSG((mask) + 0U + 0UL + 0ULL >			\
> +			 ~0ULL >> (64 - 8 * sizeof (reg)),		\

Trivial.  sizeof(reg) is much more comment syntax in kernel code.

>  			 pfx "type of reg too small for mask")
>  
>  #define __BF_FIELD_CHECK(mask, reg, val, pfx)				\


