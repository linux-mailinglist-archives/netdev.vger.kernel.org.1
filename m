Return-Path: <netdev+bounces-221059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C0B4A006
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 05:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E0A1B274BC
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D87265CA7;
	Tue,  9 Sep 2025 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUw6hqJL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3991D8DFB;
	Tue,  9 Sep 2025 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388368; cv=none; b=mZXVnEfQxrCAIDosC1+Wvuc9bJ0BuojhLaec2UPe+5LKiMVaM3vlOnUNLkWQz8aGSn2+04vK+LP0d+qF2pHkCy9+llTIUO48/YAeNRw/lHDf25AqIYt8jIdzUPanv830a490wos/4B88Wjqjx5XvsJ00sVAyReJinwLsM7fpPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388368; c=relaxed/simple;
	bh=TrEbotMNuds7Qdq81awFfL2gjP1OAB95dbF2hcUtTlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kktAYVj7/KRQSQ8m4povpMKWboiUXU9QL9lQ7LErVR7kWuqz2LeT2cLnWv/X+DoTCcNh9InAMxiMlq3OHoHsnx2m5g8fbkFJkDsmsB3yA4glCFM21s9OU9KtabF+26m/kkUcE4FtoQ4frFums72m/dlPV0ENPbna6cJasbbqKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUw6hqJL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7728a8862ccso4409108b3a.0;
        Mon, 08 Sep 2025 20:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757388367; x=1757993167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AkLNEj1i4t2vrSWBkjZO2xh0b/5j+DGQrKsquLBjO3k=;
        b=GUw6hqJLRf0aSd3eG82Fw6aE243QiH6jcDnWfDaVO9vZqf64ll/E/OH0r7C2OTQnXG
         tl63CrLTiywx+bt8mum+RIDerzgL30O9aoxbIdJGhXc5T2fpnjq5evGnxkt3/q8dUkGr
         jTUqtfhgORDhB5SKgonPfbZuiyCfFo3T3eROVPVfA21G2Iuh3Xr2K46zPC3e4dib69gK
         0gRXo0UVa/81vMSqRoNIIF8CWjbFxaNoy2EzOI9HfDoBUgSCJdfEzd8epSpUBDFXxG3/
         7QeffYqJSuHqAu6inlXpt5jnJJ4g6Ugr+/dd0Fb8zE4nt8bToYkIf1P0ZrKzwZClrRjS
         rciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757388367; x=1757993167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkLNEj1i4t2vrSWBkjZO2xh0b/5j+DGQrKsquLBjO3k=;
        b=jgSgI3aAswd1O+qE7YQjX/6bAtNguLctrLWinC2w/Ub3FwiqcwFua5+3JIxs76Oh5C
         63+gQh57YWCMZprm1Of1iDqR6FRSTVnD/64VkAo+bs0UoTJquUZVb7O2qSUaC6RfGKeE
         8I/YugiQGfBFp43apRjF91NVoha1hJzVBfNyPZIr9wuatPTYhjC4IQX57hCFc6Z7ZB7N
         +BoFh2JKfIayYPuBTgV9rDLxClNGZ9z8gcbZqS4+ltaurJ6jHDDTaEPsBW9lj+7Hb1+o
         FwF7cy1NGFLJVhWIoiqENYPlHDkp+U6rkkhZbzOEHVgeuXWB/V0iNVAVd4xRqyaL8sOm
         ye8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXk2OTePPEud1TTzIWoPysW9W/5Cr/I/wgSFZcJLir5+hBCqCqZqxeRyFvVSAhVT/wh0l4cJrS@vger.kernel.org, AJvYcCXtXyi7JOFGcw0hdvuaKbyYpWBTlojM4Mq8ec/pnhVlzKdXO6MN1mqLlo/EsTi3oewDkBQFkDfwH4Ul8qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTC0+O8MUB3irJwwzt1aHUwIrwRKw5E1CHTFUwIQpBjPXYCWC4
	lKhlwSRpL/KzsY8mR7u4XWVl2tFK+WlbpwKFXBRYCUuAJ+CYpqWCP19p
X-Gm-Gg: ASbGncvWDWBiYcQG7DPoeJFi+oVWMotoAVq8VwBklGBtkdpHwiN5UssptYqrRvztGXU
	mGmXExG92Ex0Li+VyE0BM19l3JU/Jwr/qdCHCTOfFaJTO2ojRvsqJa8s0rFAqRAW6tzpPZcRJCK
	BeNakCZoYBDSM/T/zBU1Pfvjz5mbOa1WNY3MOGI+Wyg40ryYJAbQ3fJpKxls4m65B6K2NpugR0E
	92oX4UBj6z97pEyWVwRyEsPrhotpMF86SHOPB0cYwjw9oYiennKwWrmlAVDTV4K0bVsExloh1ED
	HmUKjVaesZ/PdjXDVmznSy8Bo7WpEEkbuEX2Qjo+G7hasmpc0UrD6JpdwCOc8mOt6yMjaAtrBfE
	UFxpiDJbQZJW1aU3F8p4ezAOQYI8=
X-Google-Smtp-Source: AGHT+IF7IiZNw69xqiXFPeTTUlAHNfw0BXZZF30ky6qi5h8ozXWMsCssJ04yFuxynGBl+GR3uACpWQ==
X-Received: by 2002:a05:6a20:1595:b0:248:7e43:b6b8 with SMTP id adf61e73a8af0-25376386e21mr13470591637.3.1757388366650;
        Mon, 08 Sep 2025 20:26:06 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4de04a9ea7sm24934736a12.16.2025.09.08.20.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:26:06 -0700 (PDT)
Date: Tue, 9 Sep 2025 03:25:58 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: Carlos Bilbao <bilbao@vt.edu>, carlos.bilbao@kernel.org,
	jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sforshee@kernel.org
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from
 counter to jiffies
Message-ID: <aL-eRu6eTHb3eB3A@fedora>
References: <20250715205733.50911-1-carlos.bilbao@kernel.org>
 <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu>
 <aJIDoJ4Fp9AWbKWI@fedora>
 <49b975a6-25ad-4c11-a221-952b466d267e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49b975a6-25ad-4c11-a221-952b466d267e@gmail.com>

On Mon, Sep 08, 2025 at 04:26:12PM -0500, Carlos Bilbao wrote:
> Hey Hangbin,
> 
> On 8/5/25 08:14, Hangbin Liu wrote:
> > On Tue, Jul 15, 2025 at 03:59:39PM -0500, Carlos Bilbao wrote:
> > > FYI, I was able to test this locally but couldn’t find any kselftests to
> > > stress the bonding state machine. If anyone knows of additional ways to
> > > test it, I’d be happy to run them.
> > Hi Carlos,
> > 
> > I have wrote a tool[1] to do lacp simulation and state injection. Feel free to
> > try it and open feature requests.
> 
> 
> Very cool, thanks for the effort! If you’d like to run my bonding patch
> through your new tool, I’ll be happy to add your Tested-by tag.

What kind of tests do you want to run?

Hangbin
> 
> > 
> > [1] lacpd: https://github.com/liuhangbin/lacpd
> > 
> > Thanks
> > Hangbin
> 
> 
> Thanks,
> 
> Carlos
> 

