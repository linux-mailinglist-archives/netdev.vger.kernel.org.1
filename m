Return-Path: <netdev+bounces-92653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC478B8317
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12011C2039C
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50017BB03;
	Tue, 30 Apr 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEXEj6W4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B91E49F
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520651; cv=none; b=HzsX1RnXy4manMdy7cknPUpMH8CXup5N5A4WQgaquCmjQ1m+bJpV1nMkRiNr/YCt7w6FskijPOo03Pqt8JjkY1PXzVAPvXDFZf9AVCcqeqRTNeyyqU70zKOPlGyuLFvgUTSU9iGdz2u81eddf53KMi8NGyKXRm8S1sEIO0aj7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520651; c=relaxed/simple;
	bh=jDcDiyZwlPH32wdPzAMHAVX2GtH0BoXSMcYJINMmx+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4ZoTYzsKF3k8+43ZbuNUESFAUnZUsYVJXby/POl+wDby/QkbvHnv/5z7de0I2j4d/BLRB6YBoSRYux+UFHzW/POPI1QiDx6qI9If25irF+xqucT/goF/JOqqyw0Yw4PuzWKgT/OD4nDXp2IfidPeuyStEYsVb/ckP1Jpri2Raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEXEj6W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE32BC2BBFC;
	Tue, 30 Apr 2024 23:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714520651;
	bh=jDcDiyZwlPH32wdPzAMHAVX2GtH0BoXSMcYJINMmx+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bEXEj6W4f2N2lFvKLLAi1eiWahZXhapp/9gFYQ/92f/WWBjG0sEZWAXR3pZYupCkp
	 wWp9Tz1he3pbmF+MrZdA8TyUY4j1hw+2vPr2lRlmjJCASDcRaetGYChodaGdC3qZt7
	 NSySQ93JnrZR7VKmR6/f/zbss9lllvJ/eOYsiVOZ6XGX8dFdO3JDio94f6gOv0w/q7
	 cbN9TpDQGGbSvV1nZ0TySGfbKeTvoVE+Fhpp4X+S3sP5JqxMowSbumwbIBvLiAX8uS
	 FzNQ0SiY32ytgcKmFMOcuuW384N5cS7iN+UkCbVJGxAq2aD8Sl6jY/nvaWM5swQ4H1
	 wqRxG5sXxXjvg==
Date: Tue, 30 Apr 2024 16:44:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew.gospodarek@broadcom.com, David Wei
 <dw@davidwei.uk>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>
Subject: Re: [PATCH net-next 1/7] bnxt_en: Fix and simplify
 bnxt_get_avail_msix() calls
Message-ID: <20240430164409.1c8ff441@kernel.org>
In-Reply-To: <CACKFLi=K4zOMFHiSsh7A_T846MmPD=puxa2wU_1SbDstF4tJ7Q@mail.gmail.com>
References: <20240430224438.91494-1-michael.chan@broadcom.com>
	<20240430224438.91494-2-michael.chan@broadcom.com>
	<20240430161940.4cde5075@kernel.org>
	<CACKFLi=K4zOMFHiSsh7A_T846MmPD=puxa2wU_1SbDstF4tJ7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 16:35:51 -0700 Michael Chan wrote:
> > On Tue, 30 Apr 2024 15:44:32 -0700 Michael Chan wrote:  
> > > Reported-by: David Wei <dw@davidwei.uk>
> > > Fixes: d630624ebd70 ("bnxt_en: Utilize ulp client resources if RoCE is not registered")  
> >
> > He hasn't reported it, he sent you a patch.
> > And instead of giving him feedback you posted your own fix.
> > Why?
> > This sort of behavior is really discouraging to contributors.  
> 
> Sorry, I wanted to get this fixed ASAP and did not quite understand
> the subtlety on how to handle this properly.  I will work with David
> to get the fix in.

Thank you, feel free to repost the other 6 patches without the 24h wait.

