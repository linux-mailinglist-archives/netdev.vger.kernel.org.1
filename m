Return-Path: <netdev+bounces-120939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0007A95B3EC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1FAB20E57
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ABA1C8FC9;
	Thu, 22 Aug 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQQwgE6R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB507185B44
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326378; cv=none; b=IWbBkJ93mzuF7VTc+DBSTYm5H8HPnzAl4KLzAghEUwGVI/LGE18Q2mf4UZzODG+yncL91rLcSsyk+joL+Dcymz1CbFSj7rJH2sCz9auAOAGCguwyFwZNS4gprxB0AVL/HCWrzqTF8EsiT4Ab0G4G7DUK83bdRp7//RR3j8Ddcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326378; c=relaxed/simple;
	bh=Ci63qR+zDbNpd55vwrnyuRDltjguxaDQhHSy/g6tS/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjdekyz8IjS+BnAbc2iuQHtEfCCfPduffH9eo5voX7YLkKVPEyakJ1PGVoCmfjIfE9I3HlnATNCizlgLALvD+ibbzgPJ6B2J7LJTjqcL0knikX7wDx8PZrDLpmQ386d8GNL9x7HPAiyoSMCs0hu0TCKwD8VkEoZmKzS2Hlo3eTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQQwgE6R; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so2899822a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724326375; x=1724931175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEuqfEPz/wQcg88M/7L6hQvyoAuxf4QP4VV7eRrYBJ0=;
        b=RQQwgE6R1OtJ3CqVqI1q/ssZV6m/Ibzr+BEbJA1RCMV3Wpj6dR8e8hIkpSEdD8/8sH
         9finI92i3n1GF8Q8dL+enNAfVOcMAA3cp+w8amFhyVsanNdGnwI7HJwzh4/zcBOJu+QO
         QXhvt6YX7Z9h9Jai7bT1EC5AJhZjGCqmXh1xNXGrxqvTVcSWuebWhejsZCv3NygFjYxk
         ZG3Je47LvYCOZvGHoOF+eEpzMVMNS4H55BW+bmNRZEjmLUGHACb90EYZxf00j+TbyzEI
         d6zFl7UhB8t+uv/XXqGxjWwUFRyam4DpT7//8Gog0DhNaQI1YO+yXfmkjRDe8XCnHWWk
         yUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724326375; x=1724931175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEuqfEPz/wQcg88M/7L6hQvyoAuxf4QP4VV7eRrYBJ0=;
        b=YvuiQ1MactPazeiF4574YYWn55l4ZpFEQNVTxCiRwt9O5BDjUJx9mNyAe21d+GWPEd
         NZueKaMJvtlTOCKC7iJFd/UvNwB6nnFZft+stp/tBag2XsAtDnGD+0r9aAq/gfshTKvF
         Fz6fTuZrqe0+DCm6XesRsGdV+7l0V0IWtvxGJffGnX377vKQseAoQS3aW1PZKg46EAXx
         QqVDKUhVvC3m4w4rqtpaKoTtWZ/J/p5yzIKRxgujPHaoFucVuYGer9xWYADoNEwJDyhv
         ERwQ5/gKroXr7KaaZoF5ngSWTvv7Lsp/GO/NS5ZVvN9qa+vV0s3T1M15/kJoGE/CWGyl
         NR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm6bH6PAobXFCclD/nyJZexoSKICk0+rslptoXBDxQDagENJRI6fF5VY2frICauFtrl+XLnTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNKZo9BjlPqRZUTRpm+xxTLQacjD+WMEqLDThP77w4ia6fh62
	3lhzSWB4W6Uo1alRefHA4G+3hcBKFtyQOw7Ec8ZMLGotgLmiHAtFUTr90IehHqM=
X-Google-Smtp-Source: AGHT+IEZLMLyT9V9R+7tijjPChEoFjN4faNKVaDnMSiAg9BTtShFVYMWr/ION2Rh8H2N39z2OxY4VQ==
X-Received: by 2002:a17:906:f598:b0:a83:849e:ea80 with SMTP id a640c23a62f3a-a868a921340mr258262266b.32.1724326374890;
        Thu, 22 Aug 2024 04:32:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436c11sm107578866b.135.2024.08.22.04.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:32:54 -0700 (PDT)
Date: Thu, 22 Aug 2024 14:32:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, "Anwar, Md Danish" <a0501179@ti.com>,
	Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH net-next v2 1/7] net: ti: icssg-prueth: Enable IEP1
Message-ID: <5fa6c2e5-19e9-49fc-b195-edc5c6b3db7c@stanley.mountain>
References: <20240813074233.2473876-1-danishanwar@ti.com>
 <20240813074233.2473876-2-danishanwar@ti.com>
 <aee5b633-31ce-4db0-9014-90f877a33cf4@kernel.org>
 <9766c4f6-b687-49d6-8476-8414928a3a0e@ti.com>
 <ae36c591-3b26-44a7-98a4-a498ee507e27@kernel.org>
 <070a6aea-bebe-42c8-85be-56eb5f2f3ace@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <070a6aea-bebe-42c8-85be-56eb5f2f3ace@ti.com>

On Thu, Aug 22, 2024 at 11:22:44AM +0530, MD Danish Anwar wrote:
> 
> 
> On 21/08/24 5:23 pm, Roger Quadros wrote:
> > 
> > 
> > On 21/08/2024 14:33, Anwar, Md Danish wrote:
> >> Hi Roger,
> >>
> >> On 8/21/2024 4:57 PM, Roger Quadros wrote:
> >>> Hi,
> >>>
> >>> On 13/08/2024 10:42, MD Danish Anwar wrote:
> >>>> IEP1 is needed by firmware to enable FDB learning and FDB ageing.
> >>>
> >>> Required by which firmware?
> >>>
> >>
> >> IEP1 is needed by all ICSSG firmwares (Dual EMAC / Switch / HSR)
> >>
> >>> Does dual-emac firmware need this?
> >>>
> >>
> >> Yes, Dual EMAC firmware needs IEP1 to enabled.
> > 
> > Then this need to be a bug fix?
> 
> Correct, this is in fact a bug. But IEP1 is also needed by HSR firmware
> so I thought of keeping this patch with HSR series. As HSR will be
> completely broken if IEP1 is not enabled.
> 
> I didn't want to post two patches one as bug fix to net and one part of
> HSR to net-next thus I thought of keeping this patch in this series only.
> 
> > What is the impact if IEP1 is not enabled for dual emac.
> > 
> 
> Without IEP1 enabled, Crash is seen on AM64x 10M link when connecting /
> disconnecting multiple times. On AM65x IEP1 was always enabled because
> `prueth->pdata.quirk_10m_link_issue` was true. FDB learning and FDB
> ageing will also get impacted if IEP1 is not enabled.
> 

Please could you add the information mentioned in this email into the commit
message?

regards,
dan carpenter


