Return-Path: <netdev+bounces-113540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B093EED2
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 09:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF532826F6
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA98712BF23;
	Mon, 29 Jul 2024 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeLynTjq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2712BF30
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239021; cv=none; b=bIquI3kMQHXo1OTaqU7b8+S2VhKWcUR6LCVffTfAWT+yKoycxrQM2ooJVTi/kiNpd3o1VKrSHHYZ+xyk9twWCXQxuWFrRaLzy8xRXYxBWW8Dtx2vTdXKx2fx/v4seD1YL9IrIp1b+s6YHv8EOOul6QXn+Di+iKmkwhUGYxCohLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239021; c=relaxed/simple;
	bh=Nc7Tir2M4E76sYAdq9eOQME2m1X4fk8R0qZhUBVzsFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWXWGBVrZIWj9yRzdoFiFiSXwFpEfN9YsBPuPa51WOaV8tAw5ATMoet305fO3l0mRPYBu1vMNEkFH1tsVV2gh5rEP4eeLSCHwCWble1zmHBpQPzsXzNKRQ2Su7KlyZWDsa8jlvrJgibzanexKziYp4IWdpWZyz0P9HSm555R6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeLynTjq; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7092fb4317dso2036247a34.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722239019; x=1722843819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfIWETwmMusUNn+SIzxCLsgyLJq3bGLMV71fuYjqIMg=;
        b=eeLynTjq36AO6FcXRnOhxAVULVeUfXCEOxoYvHhUd7pQc2bwD7kzjsaWTlOWH/E4Hf
         ks0ntxJAkHWrezkz+K4H+mhlojmgbm7AgnpZGASAavoa80oo1TsLTqTYDekHj6UVxN76
         R9ipfgSLLgK2jHKZFHb3S7ATzMjph+OgZEukEOjZrNIo/FwAH55Q7yMhw6Ex+To7kR01
         4zuB4hxJyU/NrnLpPh6n136HRAJ1HvNW2pxaEY6ZPHi0NrVaFoQvOdv6gFSe0i4p1lUm
         V+MTJUwkdh56Zs/5ws/h0eczFjbklU/Pi70wZwdmpFEe17wCeLWuMJ0jo+plEih+8WIJ
         YN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722239019; x=1722843819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfIWETwmMusUNn+SIzxCLsgyLJq3bGLMV71fuYjqIMg=;
        b=kcpNj0ppxGSbzNmo/53b67l2mJyjcRNaxkIe/emEVo/ykzmr4PJDD9javrMcals6Hq
         nIuCd0OvhPx6GqJDvNqgOZASHwL14cSRR6hOnBmzEIm9p0l3Cq9gdpZtsKPUhy2JbOC7
         Ndx3WPFxSBagTPO843FU46VK2hS5zRe5A+1mCYFv9hEYOHkoFHWn5ACB/XHp/Z6Zshlc
         z/0ezkoceXB+umnuoBTS/hHiRJBWA2ntjPUHT5SCaDylDW+4HlbwwcqB18wdNnLXstAC
         6qU+ZFaiFDUA94ro2iUvp8qDNBSTJ2myHAZm1nzqSi9TzXjybsFqBKX4/6sBFJyTpgNn
         CB0A==
X-Gm-Message-State: AOJu0Yw81X+C9F8jnoDzSqffH897Xfs6GVFmLX0YYUoRPQ9NlQlRqWYw
	xj/VmAY7aAXEhwbDuOi2P5Lvslhs5HpjjjfzR72YurIeJsAKj5s3bpCUHtoe
X-Google-Smtp-Source: AGHT+IGxS81nHi9tcVAHFpIrOgAaPFp4g8GLxNz7Khl8d1Insgsn8XQ0z0eseC6btdgD0f8ekWQ8JQ==
X-Received: by 2002:a05:6830:358e:b0:708:b40a:fecc with SMTP id 46e09a7af769-70940c04016mr6701139a34.1.1722239019266;
        Mon, 29 Jul 2024 00:43:39 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7827:1770:9c43:581a:1588:e579])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817aebasm6740225a12.28.2024.07.29.00.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:43:38 -0700 (PDT)
Date: Mon, 29 Jul 2024 15:43:31 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
Message-ID: <ZqdIIy7H_57MimwE@Laptop-X1>
References: <Zn1mXRRINDQDrIKw@Laptop-X1>
 <1467748.1719498250@famine>
 <Zn4po-wJoFat3CUd@Laptop-X1>
 <efd0bf80-7269-42fc-a466-7ec0a9fd5aeb@blackwall.org>
 <8e978679-4145-445c-88ad-f98ffec6facb@blackwall.org>
 <Zn6Ily5OnRnQvcNo@Laptop-X1>
 <1518279.1719617777@famine>
 <ZoOzge5Xn42QtG91@Laptop-X1>
 <Zo9NtDv8ULtbaJ_k@Laptop-X1>
 <ZpoLgQtZG5m8gU3L@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpoLgQtZG5m8gU3L@Laptop-X1>

On Fri, Jul 19, 2024 at 02:45:25PM +0800, Hangbin Liu wrote:
> On Thu, Jul 11, 2024 at 11:12:58AM +0800, Hangbin Liu wrote:
> > On Tue, Jul 02, 2024 at 04:00:06PM +0800, Hangbin Liu wrote:
> > > > 	Looking at the current notifications in bonding, I wonder if it
> > > > would be sufficient to add the desired information to what
> > > > bond_lower_state_changed() sends, rather than trying to shoehorn in
> > > > another rtnl_trylock() gizmo.
> > > 
> > > I'm not sure if the LACP state count for lower state. What do you think of
> > > my previous draft patch[1] that replied to you.
> > > 
> > > [1] https://lore.kernel.org/netdev/Zn0iI3SPdRkmfnS1@Laptop-X1/

Hi Jay,

I hope I can get some of your comments.

Thanks
Hangbin

