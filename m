Return-Path: <netdev+bounces-239673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC48C6B489
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id C9BCE2904D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D385C2E0902;
	Tue, 18 Nov 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvE5vKh4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DA2DF717
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491831; cv=none; b=HPtd1htMZvtG4dGe4FnacMk4266Gl++29RKVjRApL5rRZSiUxKmNSe4ErLGxKi+p0BUK177RgfhtLHcAlm8DCkBzpVb7mtCFWOuzxmcTxIMknLvwWhhsMZTDRQVXFHDfegsTijQJcEu/dD3cEpVcBtELywJIPdAq8fP635E+OEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491831; c=relaxed/simple;
	bh=FHR1vghh3/Ry94P21SXhw8smish6xFij+qwri1zqTjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+rtfUEm6Qtmg0uBkmpureumkjs9EbpUQZE6HJfYPb1vhV08TBwQn47amrkfAnBvWit0wuwFW+4Arkbc+hyfTeqAM77i+7TxTEYmUK8vPsXOMDFbUQgpsfSKWk1f31VV4ApiS7wuR1dAm7B2gNFziCi+loVn/Bn1V//W8ShNP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvE5vKh4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779cd413b4so2400485e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763491828; x=1764096628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/xelqTh0MJxdYizhebw3VTy7C2C4gWnDlrkViLNdgoU=;
        b=QvE5vKh4K0PXe/iK5Gz+DxqXXShnyMLG9fTdyr+6T3Xde98eMHNgA6cUla6nGzMcYz
         YKNPuag367ldhYpDExhC50jEOAkrAyiSxMoIxvq0naEmmLbAkaokKBO9S6Et2luJUtk+
         iL5b9mxbLlDYj9ZtzRZKJ5Hi3lnaOLD4RdsTrMIysJTS/BEy+Xo9NUE4QiqPb5qfhHRW
         8Im1bfD9oOJVJJUvDs+iSn05b6Gl0evuwNlq6jX0IpPiRdf+g7nmgv3QmxUhpaR1UTPy
         trflq4FEH5fZ2WopFSG0AyELUjdt9UCkTGbWGThs5ZMgXh5zDeqVSonrmOvB7ZL0LWeI
         NqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491828; x=1764096628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xelqTh0MJxdYizhebw3VTy7C2C4gWnDlrkViLNdgoU=;
        b=dWm1p8FctbluuVHRCu82Jc0bpL+VvzN2fdzj/3rnt4wwFpVDgkn7yaExADNxSyzhyV
         JzISLE/gKcNcMTx/pSz2YEjGByfxNZxLgCwNN+a/UzutRKjQ8gNp5b+r0hqwNP8hZBwX
         w2mChajn/GyBMhzGWm/qsLYeSzisdZUZ2bkxCDPufoRHk6ttkzr3lvo+m4E8ga792/0n
         b488q3L2eOWylaBELZWgYsj2cYW/qoCFCZOudiZApk0OdyRdwSh/Ha+GOZ8DZN3+Cu6T
         xutJ2vNWL5TuPM0hoKzRVPKKi+TizyLkQhEJCuYn52AOzwjNbz15QmBi1eFxfZ7WCH3i
         TJcA==
X-Forwarded-Encrypted: i=1; AJvYcCWIbsIM/sa4oDMALHkkY5FjsjIEMozbVLA9CXFRMvnjZlvmFWvKFWFblMpjVCFq1LNkSBd/E/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYlKAu1mMI/zId/+YhfySFRu+CPxghVdfNwGkgFqkqtwEp1uI
	cab2m2skomMiN9WqDwjrHPCsL2tF595gy5lwkCEwinW6OYV3G364bz/W
X-Gm-Gg: ASbGnctd99htpZKr9d9WwKl2eVE6XcNJ7SoxkI6crsZr9a6xxaw+wU7WjiVXzmTWtSV
	QgJp+WafjvJRtlveUh7zsNpn+hLf0WASo913R4Rio3Vd/CTGhnuV15vfXrQNXv5Q/F0yjztIem/
	QLtfE+d4TIMBh+MllOxd+zxz+twksCg2dmYwXMPAcHMBf370778LdCCF9SXVUFIP6ZheQiz8cH2
	AR7a8qb0jevXvRFc8pS+swxGnTcF2eyYbk/YiD75d8oWi0do1teLcnPv8LKNc7IyWaWRRdKlVV/
	2RI/crd1/JP+WOVK6m4BKOUUrxj8nuapBrzaeofv4DG0zpytRxpb3d7d1kejsBic/lXIoUr+puP
	Ljj2V97I1MB2PKdEzs561JJmLE80VQcas2jBTGJf/UhAU99IThy+VkAah1KOzgCJpyo+A68PRyr
	pBTWFydBw3JZaB
X-Google-Smtp-Source: AGHT+IHx6i4VYWR6pSTcXtSoFlN4Y9U/3Z/PI54PVyQA5JnsfbBaJwpdM3LzkIBKtiuh5JtXbYxanA==
X-Received: by 2002:a05:600c:1547:b0:477:5c70:e14e with SMTP id 5b1f17b1804b1-4778feabadamr87966605e9.5.1763491827278;
        Tue, 18 Nov 2025 10:50:27 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:9ac1:9a91:7d1:a813])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9df99d3sm22110705e9.12.2025.11.18.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:50:23 -0800 (PST)
Date: Tue, 18 Nov 2025 20:50:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Mladek <pmladek@suse.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 14/21] net: dsa: sja1105: Switch to use %ptSp
Message-ID: <20251118185017.kk7binsumhh27n7x@skbuf>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-15-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-15-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Thu, Nov 13, 2025 at 03:32:28PM +0100, Andy Shevchenko wrote:
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

Thanks!

This is a rarely modified portion of the SJA1105 driver, and it doesn't
conflict with other changes that I have planned, so from my PoV there is
no problem with the patch being picked up via other trees.

