Return-Path: <netdev+bounces-198804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EE4ADDDE7
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D992F17DC01
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B749D2DBF51;
	Tue, 17 Jun 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEyxF3f4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502252EFDB2;
	Tue, 17 Jun 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195813; cv=none; b=DYq4ONdMrGsQUXtROgjMl95HGrR+rKWjNIwkPDNwdfRcdfbECnJrT0MT1ln74B+zu+9QNo79QIacYAYQQps92Qqiv56rJ8L4fdNXLm6tQB5ca+cik3Ffr3BVRDGVynnSW7zGoS6nYQ/mBvfHytaLg/M28DGdtaO54dbQHxK8GWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195813; c=relaxed/simple;
	bh=jiP8xbBvm1cvkS8muOTzto5Z82L2aKeW+7MsVHYfaYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv3oUU8Esq4PpYdvnpPKjLoJxvC7SI5z5vo7YXG3bTCqiqACta2gd347m7nhTmzUhDAGuMhQWvxEMaZJ7jZc5HUSZDg6EZuYOAHqXUxgrmB7Mv9rebxVM9fmTzghXisRI5M/Nfjv8QdN4KdK4+ef4kblP7FqPVIe0p2ku1l5LKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEyxF3f4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234d366e5f2so82769015ad.1;
        Tue, 17 Jun 2025 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750195811; x=1750800611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mTbtcXAi0UCuLpVRrm81ZJg6wnZpaGU+V9PP7dgvRgE=;
        b=XEyxF3f47Dd4GsFdLFThJpnIYwQo6Q9yKisX0eChc2PZrErRXYlIzkSJjv8zixmo7N
         U+D6NARiANKXNxxGV/S7OapjmAKsBhngH8movJat2RHcVRw//yO6AMzeA2K4h7coUtTw
         uQa7UgaeRcHw/Aiti7yAqiytUkGppQA/EUxhfRNS5vJeND0OgzRVT5notBRxfUolUKax
         PEyu4lgVwAy/VffnHwlssKPKDcAZyHdaSfKRLl4SjBHuYWNcdXF96ah6Krf/5cYC72wA
         SySmh8Q7H53PjPaM/5ZgtgFzz5UdQamDltHKI5tAOL/RM+GA0Jkp/SZYZu93QcTYARI+
         fL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195811; x=1750800611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTbtcXAi0UCuLpVRrm81ZJg6wnZpaGU+V9PP7dgvRgE=;
        b=R+IGi9ppi4uQvmDSLUmZdStPWGYPbi5WiIqqaZ+xPT8pNGvGVLprDUKCkuiohxX7BQ
         rVH5RORJzCiQ4DdidcOFNpMCWzebU6j5Gx1BZ4eCOmRfbNYzMRco9TAcJGouCztjfwH2
         DMbM3urSzQjW9+6pX3ZY64k0loPWkdpKRm/UZqUhlOVT31B1h6qq0LuECZ5pSoHbBZE+
         zHoQ2m7iN/MYb4k2WByNNdP3YpMQXz7X2h4QecQXMFMpwPj7L5dwDdxrsUARjLUwrGd3
         23eomUNZW4CmQFG5FwoOm3OL56kEjl8tCQJe2Cljx+AgYtr2ttkgkyd7rVSnS/fonsBk
         lnPA==
X-Forwarded-Encrypted: i=1; AJvYcCXmIO9JBF8XaTNeu3RJYayVy7j36p/5oOjVckLP6j4MKkSN9Yng0XIghaxz0vCWrY76X8PSx6V8LcGH/U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYoYmtg8WfGVj/N1TyLoXU7qwxDRu32+eyQEBN5rZhFuMgUuT
	oFR5bCpoovu3mzQeWmhUwXS3+zB1meWfGmdwlG+2B/tugmWArLyKJ0M=
X-Gm-Gg: ASbGncvoY5EKjVIbm58kPjR8fgmtj2nOG75UrXfCny0BDingLUxky+sCPWr+TxOpeEY
	ilvphJk92VKlT2awk5MeTfHDymW5/2nC6UBrl3DcPd2fJb9aHQEj85AU3ykZG8LEhTs9cjhd8tD
	2vJUADO02JbPeTlTP5eEqVsUVF0rrQqQfgtGAR9PT3g6FyJ9mmp448BPW6eI1NfbI1C52NrnEj1
	T1WfqWzvIVaTrN/1YS/kouBOXEnBOPsG+7D5mGKt5nzh2NRtjfI1DR13gCnil5SOnlAFUFBBQwI
	1L5nf689wRh1rNfnEJPBHEf1rnsFvdlWbR7ibQ5C3kKpkYJTzdcxj74EGMPnojkF+TjffcTiJ0Y
	2ATxkDX32NJfz/38IGtZOug0=
X-Google-Smtp-Source: AGHT+IHiCZunwaaJjtzIQEZAsX9pMdt7B3YfAFAsa8w34AEtZGaqLSQlr+9zn9U1so3Qbi/LBOui+w==
X-Received: by 2002:a17:903:124a:b0:235:f3e6:467f with SMTP id d9443c01a7336-2366b3138e6mr234079925ad.2.1750195811419;
        Tue, 17 Jun 2025 14:30:11 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365decb0c5sm85211725ad.215.2025.06.17.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:30:10 -0700 (PDT)
Date: Tue, 17 Jun 2025 14:30:10 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, ap420073@gmail.com
Subject: Re: [PATCH net v1] netmem: fix skb_frag_address_safe with unreadable
 skbs
Message-ID: <aFHeYuMf_LCv6Yng@mini-arch>
References: <20250617210950.1338107-1-almasrymina@google.com>
 <CAHS8izMWiiHbfnHY=r5uCjHmDSDbWgsOOrctyuxJF3Q3+XLxWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMWiiHbfnHY=r5uCjHmDSDbWgsOOrctyuxJF3Q3+XLxWw@mail.gmail.com>

On 06/17, Mina Almasry wrote:
> On Tue, Jun 17, 2025 at 2:09 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > skb_frag_address_safe() needs a check that the
> > skb_frag_page exists check similar to skb_frag_address().
> >
> > Cc: ap420073@gmail.com
> >
> 
> Sorry, I realized right after hitting send, I'm missing:
> 
> Fixes: 9f6b619edf2e ("net: support non paged skb frags")
> 
> I can respin after the 24hr cooldown.

The function is used in five drivers, none of which support devmem tx,
does not look like there is a reason to route it via net.

The change it self looks good, but not really sure it's needed.
skb_frag_address_safe is used in some pass-data-via-descriptor-ring mode,
I don't see 'modern' drivers (besides bnxt which added this support in 2015)
use it.

