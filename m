Return-Path: <netdev+bounces-182823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2E5A89FC7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B62D4413B4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76B161302;
	Tue, 15 Apr 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf/WD21T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930761537A7;
	Tue, 15 Apr 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724660; cv=none; b=FhU2fk881Lg7QHOUXF9CNuIxpF6uiQu15fl0LBHHG3MWlmalU1sXI6EUzccCRNJLymiwbIp9/E7Wh+lIe1fv6eAgGR2faVSlNGDdT7fHlhU4znYAyOhfysvuhiVv3EpuK00gWh+hCVEccT9ZpwnQHGkpcdwjuDAIGE713pcRNvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724660; c=relaxed/simple;
	bh=GsSFwxZ4oHuFSNl6lAHCTcoSiHZsa1Y2n1lp4Zh92g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgw2vqDA3lR/M1u/dIioXP1spBqKVk8YE7xOot7PhPp0Jsqo64ZbstDvyZJLD19ZDbioex94F45vmiBtdcsfXXvPkeBBSEScZ4OY4B8xdNVP+bvFYYCl623e5VwGUQ2+EydAeUk7emsFwTwTE1J7Uwv1tWeeo3kqz69Hayjm3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf/WD21T; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so3932942b3a.2;
        Tue, 15 Apr 2025 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744724658; x=1745329458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTORsZPlrk/AMuWxuyI7eh//pFCRSnfTepFY96Ssd0A=;
        b=Jf/WD21TmUkhttJugs8077tZdbocyNEkpDOnYzh1rR1n8driI29PyI8G8m+UoCVHag
         FntRGtBWx83/jBY5w9vxhHx0KwHVH0y4qkEvnNH3jpKjpZKCYNMLYSJcky6KyqYmoltW
         OQ0M5AyCF67JiAVliZffXmi3jxUoFr7uk1DqRBrXh6QmUDpxmmRAmDOfHzOZU3YqZ2og
         ZXrUUdriXsr0e3XCpGGnChsFN0dE4/yo6tWqecjI3lDS4geneHpc0db2F0wnm9rVIJvp
         EyjdB1FpQFDDmg+CPhLzzKT2BHj3PfrbHR6aZ42YPAC7U1PnEed3pdc3Uv9OkDr451dS
         OGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744724658; x=1745329458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTORsZPlrk/AMuWxuyI7eh//pFCRSnfTepFY96Ssd0A=;
        b=qvFodidwvNIFyEk1ejwWO+zeNFCBrCIigQzk7XMY6cBfnHO1tDFLkVTYfp63K++n4K
         NdzCQpBTLwzjuWUlRHcMyli/kwtry6NBmniniT/fCRKrqhKaGxcB3hdQYzTUegoPLlOY
         p+1Bag6j4u3iqU70KoKwYFNpqAS5vAepLb/0WFCP99gQZW7fj50gA4KmhgOhhA/n7FRL
         WXh1wqb06lwWVi+3rxRn0qkR+efEB1osWeKEbMNFjBeGvFCCf/PBGmoGEUmz4ouyCfkI
         CsBe27THC4yDHGTqoe+ICWBr38pBH6qspq85XLtTGsH2kbxEzzMiiK0VCe1BSDd3c7GJ
         LIFw==
X-Forwarded-Encrypted: i=1; AJvYcCUBSPz+VrZlKVqPIZcjzOV8xIFsNEtuqVNvmTFFELoq1B9tCfscJWxjqsrlq9kXum/CFZ5lw24PDG3Wvac=@vger.kernel.org, AJvYcCXd6WyxICSLmchUofduPzdbN+Zrjb6BcYGUICAlxv0jkZ7du5q7tPIotbXHx7hYZfM+wvlbOiPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyVFs+KNs52EbrCFWYowWrvrASQ56n/WoHGPyJ1l+EvzeOurTSP
	tqfECIe4xW5FgFqLQdMrcL2IGZCf+f6gouPeqjJ3JWfHj8CBT/52
X-Gm-Gg: ASbGncsfdOYZtkVX66XWX0vrU4PWNqVP+pix8BSY/qN2z9b2IliUpQ0cX0ksY/s1Umv
	OAWfod22EmHfFJF1i8ZZ7P66fJ4FR8stus9iG8w4z7u/mFRy9tBCL6snXVv1BlTXvmPuyV5z6jg
	hxhwSyRQs+z8lmQJUlDqFTK21BAhGrnP0ksOSNie3XFFjETnTbPVEjU9x2f7sIGKqPDKgraKQQJ
	ivoQIEGyl2sx2LzR24oCvGTMsQW5atBCOFlPG4vLGBPbOaAyuxag0/Q28u8wCU6aI284yzpaN+h
	JWRSa9VfBoFAGi116DcvfWq5ssCBe6SfGw==
X-Google-Smtp-Source: AGHT+IFViVyAaP+ggZIbpa3bg1tjZy3LOGm1xo9ytu+UHIK/9ZwrptKd7ilpthfCZVlFvyurrwMotA==
X-Received: by 2002:a05:6a00:240b:b0:736:a694:1a0c with SMTP id d2e1a72fcca58-73bd12bef8dmr22407785b3a.21.1744724657616;
        Tue, 15 Apr 2025 06:44:17 -0700 (PDT)
Received: from nsys ([103.158.43.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b06161333a8sm6217828a12.7.2025.04.15.06.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:44:16 -0700 (PDT)
Date: Tue, 15 Apr 2025 19:14:11 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: 990492108@qq.com, netdev@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Bharat Bhushan <bbhushan2@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Geethasowjanya Akula <gakula@marvell.com>, 
	Hariprasad Kelam <hkelam@marvell.com>, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>
Subject: Re: [Patch next] octeontx2-pf: fix potential double free in
 rvu_rep_create()
Message-ID: <457o27qvjkgxlread7gvqsf6sz3g2tponkxtmehva6f2msi6xb@giaxsk5o57oe>
References: <tzi64aergg2ibm622mk54mavjs6vbpdpfeazdbqoyuufa5ispj@wbygyurrsto5>
 <777db8bb-89d2-46ac-b7b9-0b5f418cc716@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777db8bb-89d2-46ac-b7b9-0b5f418cc716@web.de>

On Tue, Apr 15, 2025 at 09:32:07AM +0200, Markus Elfring wrote:
> Would you ever become interested to avoid a duplicate free_netdev(ndev) call
> by using an additional label instead?
> 
> See also:
> [PATCH net v2 1/2] octeontx2-pf: fix netdev memory leak in rvu_rep_create()
> https://lore.kernel.org/netdev/8d54b21b-7ca9-4126-ba13-bbd333d6ba0c@web.de/

As Dan also pointed out (https://lore.kernel.org/netdev/116fc5cb-cc46-4e0f-9990-499ae7ef90ee@stanley.mountain/),
the best practice is to undo the current iteration inside the loop
and then cleanup the previous iterations after the goto label.

I think the idea is that it makes it easier to review. We look at the
loop and can tell that when it jumps to the error label, the current
iteration is cleaned up. And when we look at the error label, we can see
that it cleans up all previous iterations.

Whereas, if we had additional goto labels, we would have to go back and
forth between the loop and the goto labels, to tell if cleanup is
performed correctly.

Regards,
Nihaal

