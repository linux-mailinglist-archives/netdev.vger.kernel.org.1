Return-Path: <netdev+bounces-118975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D2953C4B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9526D1C21AEC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92E6F2E6;
	Thu, 15 Aug 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vam5PsWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197C39FCE
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755848; cv=none; b=MXeKIhrE3cQXrghli6Ch8GAWJ08NauLewpyQ5aibGzazLm3Qnp5gVbLyS72/udgNrlNDHtC+0yt3pnIrFcMI7MPgApQqJtI/y8rjvxDCLzyN8x2m/hXPsd0Dhyeycz0f9CuPio5MpYFZZVfMZhnxmEIZ8WWmvksHY3qIaO8w+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755848; c=relaxed/simple;
	bh=AX/PSUcayu4mpKtfN55i14drOLjD68lOE+gzzLy24sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTYiAGZs4Peiyuie5+Wg3eRsjuIHekEIq+NqL1Y10PAN2TBb1TnNz91pIIvg6H973hqH2huNdyTXcHlxSy50T18ginSuam1/I1zXiJNyA+TUieyjT5fYFStvlL+cQ3KeF/QKCjM178uLqlLbiHrlCBO+lg7awN2KQcK+niqyIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vam5PsWN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ff496707beso1003515ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723755846; x=1724360646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AX/PSUcayu4mpKtfN55i14drOLjD68lOE+gzzLy24sE=;
        b=Vam5PsWNZjVAsg+KYH4diSZ2D9ivpcKCkCXTOHybhuXZTzuNHogdxDvyhrQ4QuaOrS
         lWZ+iqEQK34khipYSwH4UmAFlFveN5dbEesmN05bkOuOeitlOSIwN4Pi48uETlaIDdW7
         BFexUgjfjgjTdqUgVqOhUd936Df7cVNYmlIkPnty3Ta2BLXfbSGOYP4tMDJOYQkuBzV7
         HFXOwBePTfOq0tNtu9dLWk9hE3ljYeLrDyF+8Z82hHeclYWmwBYYsnhqSpf4nOJrG8KZ
         /kM/kz377GPzfmr2yrdQYk57wRYOD50Z2bJPyLJHoRQHUzkG4XLwAp3H8fbWINmvMck6
         gVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755846; x=1724360646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX/PSUcayu4mpKtfN55i14drOLjD68lOE+gzzLy24sE=;
        b=psjqsOjv/cmFuL+3POc+620HKX+vp5TGtzoyjZqEWRbQEvNjd31L6P74kbT0C6Zm5Y
         PuJmiem1sB3/BztNuqrxO3N407ICaAeKK3LH8ioKYXms2qJ1UZOJ0R+pz7ITB8dwaXs4
         uk94PDopkJOuYAsGR+DzeS8LuclHloCe+mfwueS5YLvKx1PxZCJ4qYkpSmnKUMjlsvuC
         u3VbABNlzq4kHeQfqCzGOHecusyOhyt1kdK8zSNqG/wBRqesCzorNUkupI6Y7imTF2nG
         CiYictHDyLd6G4k6ilD7UGiBzgqmuXZ5s18BsPt2hTGhavzbkkx9zelpviatxB5v7PMh
         yXUw==
X-Gm-Message-State: AOJu0YzshSEcev+OLrDv1uHOHLreHyTRTwkZnObG1pVmtlZEclEF7Rur
	+YR+S6wog7GNXA71xyvFsK6mC6oMYK/GpX+VBR9dRgZLbrvHYpo5
X-Google-Smtp-Source: AGHT+IFFK52sBWsmpdPbEIs+23N604tiPBk7Ww6ILTjmnICrBOyhFrEBDNmZMJNMzdo1hKK+UcBA+g==
X-Received: by 2002:a17:902:c40d:b0:1fc:6d15:478e with SMTP id d9443c01a7336-20203e6031cmr7074465ad.1.1723755845978;
        Thu, 15 Aug 2024 14:04:05 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a4c28sm14098095ad.287.2024.08.15.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:04:05 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:04:03 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com, vadfed@meta.com,
	darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 1/3] ptp: Implement timex esterror support
Message-ID: <Zr5tQ3lzx8A-UXI8@hoboy.vegasvil.org>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240813125602.155827-2-maciek@machnikowski.net>
 <Zr2Cun2AhVLRAm1t@hoboy.vegasvil.org>
 <fa372172-ef1c-4cbb-8126-7665d3e15251@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa372172-ef1c-4cbb-8126-7665d3e15251@machnikowski.net>

On Thu, Aug 15, 2024 at 11:47:45AM +0200, Maciek Machnikowski wrote:
> I can implement a generic support in case all the information are
> exchanged locally, but the driver hooks are needed for a use case of
> separate function owning the synchronization, or an autonomous sync
> devices (Time Cards). Would a fallback if getesterror==NULL be enough?

Well, you really need to show us how this will work with the Mythical
Time Cards!

Thanks,
Richard

