Return-Path: <netdev+bounces-138071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D19ABBF5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 05:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67CB284BCB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492D80027;
	Wed, 23 Oct 2024 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwZGoD6R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A545A48;
	Wed, 23 Oct 2024 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729652725; cv=none; b=SwKlDN/ReYU7vmO0hTWFwHxKEq/PSFmPPANfymQLW/uaqTmVo+RUaC969b+FJwNhXCXO46Sb2SBUe1J7ZDju/zwxoUqwAmRNlpC5NArbKeOuvWiDx3DenE1fn8kJNW/+fo5cC29cdYZDHq0v/QQi4o0Sv4kOe6P7bWKnQMOKmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729652725; c=relaxed/simple;
	bh=bOzHRlqzme7Gk8wj104vkcRGuZynpK1QLzUDGGuNWhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC1QLVMvFi4f8FERLqDsvRnUcpwnh6hMCMLQY8RdprMC6HOY2oJTiLLnqzZBwE2MTXuo0UuTscnzfIGHkge7g/nInCYz62m9vFwFALeklUKxj1zO+8gQdZbGmoDi5SYmjm0QNZTC9PNBJdQOn0egpqcS/A6KMfnOlK8b8ZdRDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwZGoD6R; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb89a4e4cso44762265ad.3;
        Tue, 22 Oct 2024 20:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729652723; x=1730257523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QSo+aUkA2L09wnQi5t2l0lbWR/1059zX0K6vucStlzg=;
        b=fwZGoD6Rm0AjroDQR8tRaIHNH4WdfyzXCET8kDwVwD2ijoSXu5h4TwztJrMtNzTEBO
         7xvz65sip5WBSzyPLqZ9q3XsuTRl63xeO305vbHJhC2BhIUafzOnUWVLJBk21wJk3z1r
         AKWODavF2cX0iUPHK1uCTJTOb6t0iA59S5KF6g0iWn7mh/NRxaqzdMIfrvFp8OEgzqcW
         efqfIDhl6cTZtkweD5B+YRvRlaP3xErul9X+ebOdy2LtHnPBWr9ODO8ywG1+Nuq0hvvU
         FwcRh1xXmiE6g5M/3a4DTtKOWQQmGc22d1dEa524p4PU6YaBpBXPQOMuK/v/5cDd12pQ
         r0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729652723; x=1730257523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSo+aUkA2L09wnQi5t2l0lbWR/1059zX0K6vucStlzg=;
        b=MIEz9keE5Ph6fDIADBNcFq2TAcIcI6jFnpWSCdWCSrYMjew3AWAcm5BuQ/aR8KqCjz
         UtBHyKKLvpYlhdqx34OixJ0ginhB2gSfeUUop7npTvU4DAfCIE8b1c7lL/NVKz+S5Iup
         VRcQk3ERa1bWwkhH8sjFHHPMCf0zVVsxotyOV4Pm5nbzTXIOnK3hpErEWzAA8m3HrL97
         ja7h8fhWko5fAdNslAHHWcVB6SFLU+K141ml6vMVKeOX7Cdx8BbC/MtW5JxbY8/3ns6a
         bpdSKb6E8PblrxaSZyC2RRqkkv+oZGUO4C+swLJdAz+wxrujBT/IgDXk9NRGOdYWU1jH
         9sxA==
X-Forwarded-Encrypted: i=1; AJvYcCUhc3GivwxJATzejSM+Dfk6jeiFZteWU7rg/GV6JNe6lOtpKocLgKvf6+sAiw0t2qjcnpDJtWuv@vger.kernel.org, AJvYcCUleU5VTH241E/wLbszxCueaT8Rc8yQMuSEK1rb1yrR2cRyXgCOqm7fqSNxen6EgNjIieX9gCTItI5QNLbs@vger.kernel.org, AJvYcCWGVmb79WzRCcbvXmzW258fKrQbt0gEO/kq0OrCElNUv9zK90E/3qpNzXhB5QoQGSFu/uL3vRJS1kddjSnrZZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/+/j6vhLHr+x/yaLrfhEF26rempnDDW4YZ8ZIty4+/E03Gud
	ke1sVcnYXs7Ng2nlwh9pds7q+a3mHJKSxDlhm2FgZM0XX5H4ypH+
X-Google-Smtp-Source: AGHT+IGNCd6pswnFVJbP69j1MMou7cXV+SSVwZfX4y88ppmSoNsF/1akW0qlPsxclP17PP3VS2uVgw==
X-Received: by 2002:a17:903:2287:b0:20c:bcd8:5ccb with SMTP id d9443c01a7336-20fa9e61d41mr16004915ad.30.1729652723384;
        Tue, 22 Oct 2024 20:05:23 -0700 (PDT)
Received: from Fantasy-Ubuntu ([2001:56a:7eb6:f700:b2d3:e25a:778e:1172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabb8418sm4914142a12.67.2024.10.22.20.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 20:05:22 -0700 (PDT)
Date: Tue, 22 Oct 2024 21:05:20 -0600
From: Johnny Park <pjohnny0508@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] igb: Fix spelling "intialize"->"initialize"
Message-ID: <Zxhn8AfRBNzY8XEO@Fantasy-Ubuntu>
References: <Zxc0HP27kcMwGyaa@Fantasy-Ubuntu>
 <20241022160933.GB402847@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022160933.GB402847@kernel.org>

On Tue, Oct 22, 2024 at 05:09:33PM +0100, Simon Horman wrote:
> On Mon, Oct 21, 2024 at 11:11:56PM -0600, Johnny Park wrote:
> > Simple patch that fixes the spelling mistake "intialize" in igb_main.c
> > 
> > Signed-off-by: Johnny Park <pjohnny0508@gmail.com>
> 
> Thanks Johnny,
> 
> I agree this is correct. But I am wondering if you could also fix the
> following around 3909. It seems to be the only other non false-positive
> flagged by codespell in this file.
> 
> mor -> more
> 
> -- 
> pw-bot: changes-requested
Sounds good, I'll make a new patch shortly.

