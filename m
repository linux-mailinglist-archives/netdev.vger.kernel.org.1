Return-Path: <netdev+bounces-163878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91035A2BECD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23C13A548D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471CE1D618E;
	Fri,  7 Feb 2025 09:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kouUVYFe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B61D5AAE;
	Fri,  7 Feb 2025 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919374; cv=none; b=XBBkw1bBh36cqUuMK5lCtzhUGdVRSx39i+W8VCiL6oR8fGIfMH7c+TB9Q5hm5Vh6rfI9g3hjqtEUId/Z84xhlr1OR6lhMiVYPK8vve3J9gf9SqZXdkza17sA/jbNYTuV32uOYmIZg23OP76QIScGfllc/lqmXRhwnJaBJRYN2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919374; c=relaxed/simple;
	bh=n6KPFvLpWDG9fauFII0fbFqVQsx7I7kPJtBxKt8Jyk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lunH4JmOQlBpEM3NaBOo7VukDdP0dWW2KLKff/BlNuP0NpVsszJzQhou52d6zplMNdWXjbJ31rgBFu1vLDMHkKosQnyHaBKIKxdmdtZJMSfLC1XtRvqtF/QMOqzpIf62eB57GUjsPgaAEl/GNcatlpk+6N8eB84zZ9+eonGWPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kouUVYFe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f20666e72so38261565ad.1;
        Fri, 07 Feb 2025 01:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738919372; x=1739524172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tYIxWjH4asPJ7vGr3zm8KkssG+yJatoWr9svY3RnU4=;
        b=kouUVYFefJ4AWQMa3yEJKYOPz3hPSpzsiVSEIfNgVSkJRlAzSPyupQ51lYOs4nsith
         P/YNx4fBzU+GK4h89x9ibGBiaP0taOxQQTTbczrv+D2bl77zy7/TzjLuPEVatQfnB7Sj
         9KVNyt12/gCIw70W0eD9ehQR8ZyZ2L3ds3Q8eTALTsirxLBmQwFDoctBcmk2u3k+QpjW
         EjDNxEYcuzhg3TT9MZ/wwVCL/p1K3OlXDhAa+k4gKQXNMX5vu2ltIM9WrjAjJXHohJvh
         1tU3Hq4tm89W7Aia9erSxhv6SEJ6wZyDLDlHMXhY5tFFe6xrD6RiQEepCIJ/ej0fmrmK
         v1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738919372; x=1739524172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tYIxWjH4asPJ7vGr3zm8KkssG+yJatoWr9svY3RnU4=;
        b=jOinM3bKtIOYGVhRdCLfr8QcADs3BXXNXL9xJwx91grnhTh91R1zLycKnJedlS3n8D
         I9Y6GOwHwxKUz8gn4b88AI3dFXngd7bXi3Gl5ykv7w2rBLW13J0zAG1STbqBEXAeOdsI
         PTPNq2GtK+MrVtnPglOAgh1NvSzku9OSPFU1jO2hDQ0rVNo9syzUrbBjRgzqunEP12qk
         KtCMg2hAsTCz2AG+KM09cQyj7THEFJkpdvsOS5u63j/8m89ZGgdO+zbOAe5xFV7HYGCQ
         74VPDvSJiryumgF8b9WeqDbDfuPkmo+5BYXm8hCikBp+ou7pqxIz0e1lUjvPwCOG97UW
         UIzA==
X-Forwarded-Encrypted: i=1; AJvYcCV0bnzIW8kl7/aFcSQ96EKC8mKtiLi10FneDyt3mraytdpJVBQC0MOj/KfOhx8F/S+qNjXoxKcD@vger.kernel.org, AJvYcCVb5eVelUvPW1vzpdz3jafRarmlqYYZBfIeDb1w+7M+ZATsTGugnnbJqLOrFk8UR1kUJfthwt1IsF/pH8o=@vger.kernel.org, AJvYcCXp6TGKLPcMS5QjF65qy89tZDF9Ip4mNh76k8LI9xIWIVviSzEq7ivE85iuq+f2hs+aMk/6ZqcbjYijbL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPP3B6zrkhsktGRvHnaoxCW3nab3HnTlc13M+NldubyFyO1kr
	p0YxWmAXhKl2IEAmjWs9jrPu3+zebZhoopMo4SWlLuzU7fI/tCDy
X-Gm-Gg: ASbGnctoUpPX2tYP+Ms0WltFyZS8y6hJiTxTKfdKhBZxRuQmP7kgiHjzrCrMMK26h8D
	oeYBXoAiedlTyWutXKVecLXZcjL9YL12oSze8rqBvR9pED7pMbRt0pOZ7WL2e3EEOXZ6l0ouKyl
	LNzV3scKuAVWojjLE0JghApO4B0C71NBxie38YEO0yEvbIObdF2neQ0vRX6hsIQe4gAt73/fuI0
	R859gd9us1O85RIbtZupkO6MMYYh8XVYtVaPvPd74IHtnDrnDnVF1aHRGhd+0xebKWZ/Gnf1y0W
	EB8z8hrT3jTj
X-Google-Smtp-Source: AGHT+IHdbdRPTIQl2gSZ+CotH7ac/oBwZCxsHs4UvbL1u5MkN8h8LbL1QYV1lgF7a8TsacFSkfg1rg==
X-Received: by 2002:a17:902:ea0c:b0:216:760c:3879 with SMTP id d9443c01a7336-21f4e781389mr39271805ad.46.1738919371696;
        Fri, 07 Feb 2025 01:09:31 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36881e14sm25847215ad.207.2025.02.07.01.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:09:31 -0800 (PST)
Date: Fri, 7 Feb 2025 17:07:44 +0800
From: Furong Xu <0x1207@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Ido Schimmel
 <idosch@idosch.org>, Andrew Lunn <andrew@lunn.ch>, Brad Griffis
 <bgriffis@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Joe Damato
 <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
Message-ID: <20250207170744.00006ceb@gmail.com>
In-Reply-To: <108592a6-de5b-4804-92ff-c7d4547beff0@nvidia.com>
References: <cover.1736910454.git.0x1207@gmail.com>
	<bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
	<d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
	<20250124003501.5fff00bc@orangepi5-plus>
	<e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
	<ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
	<20250124104256.00007d23@gmail.com>
	<Z5S69kb7Qz_QZqOh@shredder>
	<20250125230347.0000187b@gmail.com>
	<kyskevcr5wru66s4l6p4rhx3lynshak3y2wxjfjafup3cbneca@7xpcfg5dljb2>
	<108592a6-de5b-4804-92ff-c7d4547beff0@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jon,

On Wed, 29 Jan 2025 14:51:35 +0000, Jon Hunter <jonathanh@nvidia.com> wrote:
> Hi Furong,
> 
> On 27/01/2025 13:28, Thierry Reding wrote:
> > On Sat, Jan 25, 2025 at 11:03:47PM +0800, Furong Xu wrote:  
> >> Hi Thierry
> >>
> >> On Sat, 25 Jan 2025 12:20:38 +0200, Ido Schimmel wrote:
> >>  
> >>> On Fri, Jan 24, 2025 at 10:42:56AM +0800, Furong Xu wrote:  
> >>>> On Thu, 23 Jan 2025 22:48:42 +0100, Andrew Lunn <andrew@lunn.ch>
> >>>> wrote:  
> >>>>>> Just to clarify, the patch that you had us try was not intended
> >>>>>> as an actual fix, correct? It was only for diagnostic purposes,
> >>>>>> i.e. to see if there is some kind of cache coherence issue,
> >>>>>> which seems to be the case?  So perhaps the only fix needed is
> >>>>>> to add dma-coherent to our device tree?  
> >>>>>
> >>>>> That sounds quite error prone. How many other DT blobs are
> >>>>> missing the property? If the memory should be coherent, i would
> >>>>> expect the driver to allocate coherent memory. Or the driver
> >>>>> needs to handle non-coherent memory and add the necessary
> >>>>> flush/invalidates etc.  
> >>>>
> >>>> stmmac driver does the necessary cache flush/invalidates to
> >>>> maintain cache lines explicitly.  
> >>>
> >>> Given the problem happens when the kernel performs syncing, is it
> >>> possible that there is a problem with how the syncing is performed?
> >>>
> >>> I am not familiar with this driver, but it seems to allocate multiple
> >>> buffers per packet when split header is enabled and these buffers are
> >>> allocated from the same page pool (see stmmac_init_rx_buffers()).
> >>> Despite that, the driver is creating the page pool with a non-zero
> >>> offset (see __alloc_dma_rx_desc_resources()) to avoid syncing the
> >>> headroom, which is only present in the head buffer.
> >>>
> >>> I asked Thierry to test the following patch [1] and initial testing
> >>> seems OK. He also confirmed that "SPH feature enabled" shows up in the
> >>> kernel log.  
> >>
> >> It is recommended to disable the "SPH feature" by default unless some
> >> certain cases depend on it. Like Ido said, two large buffers being
> >> allocated from the same page pool for each packet, this is a huge waste
> >> of memory, and brings performance drops for most of general cases.
> >>
> >> Our downstream driver and two mainline drivers disable SPH by default:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c#n357
> >> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c#n471  
> > 
> > Okay, that's something we can look into changing. What would be an
> > example of a use-case depending on SPH? Also, isn't this something
> > that should be a policy that users can configure?
> > 
> > Irrespective of that we should fix the problems we are seeing with
> > SPH enabled.  
> 
> 
> Any update on this?

Sorry for my late response, I was on Chinese New Year holiday.

The fix is sent, and it will be so nice to have your Tested-by: tag there:
https://lore.kernel.org/all/20250207085639.13580-1-0x1207@gmail.com/

