Return-Path: <netdev+bounces-221913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C58B52547
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A88B3A69E6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7FD1519AC;
	Thu, 11 Sep 2025 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwglnLtp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2984D02;
	Thu, 11 Sep 2025 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552530; cv=none; b=iZXxuxMMF1wNHz+aQg/vfKvt+3xOLm3SyVu8pcfYyUUpikkIW/YUTrqc4ZHOuGuJ4DTTuR2PlinTTwUmSmv4+0b/9a5nvoiZIZsMGkclTbvTty84hYAu3hEFno0AODj89vbG74zQsEN8yuVUo+DEU8deUMdgvJgQYnoYLIwWY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552530; c=relaxed/simple;
	bh=EVGCd5BbRAwcJoicX4HKq/Mvmk0vGHVHkjRCE7kHZuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqCggxIgHoECdQYsVcXyCmKbNUuPiZR4w3H0EJchyVP5ucspGuRPqRmeFSATcgUNY2jCFzZ3cKYfheVPkzlQOkwE47+V7jfZfhSoT+d2WZ0J54kXVw8yJOCbXUAI2G4lLIgjwqbuO+o5Z2hrssyn8XsFmJNy8EavPYUtwSAucCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwglnLtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF0FC4CEF8;
	Thu, 11 Sep 2025 01:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757552529;
	bh=EVGCd5BbRAwcJoicX4HKq/Mvmk0vGHVHkjRCE7kHZuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JwglnLtpDuQJaG4XzkrH/in3g9M1BviCAbi9c/PYln39pXnJyFLZxPaw8aDnsetkT
	 5lpNbBNtPJoTmGlFFOMR111Hfo+M80oKWBPQMC80v/a05InZiUutI7GvxqRgPYMyf3
	 PuF9tkwJSlpuS+u/usUyPjRo8mhpzcHjWJA1+iFULTAMxbRhlB9w1UMXki9IWWTyhZ
	 YLkN/E+dhXoezMU8Hv4wI/AmRfmKE1cmoTxGkXuYcFEME5X6AqTHUugyaNAdoQx4Yx
	 aaCJaJZKm1v2fKAuXojIZLOrSzSTh5sE1CnBpu/1s/GulIE7opCWEPXT2oYVrmIgzM
	 KuIidxoc4nD4w==
Date: Wed, 10 Sep 2025 18:02:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: "Anwar, Md Danish" <a0501179@ti.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
 gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
 Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
 alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
 gustavoars@kernel.org, rdunlap@infradead.org, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <20250910180207.2dd90708@kernel.org>
In-Reply-To: <36DC826EE102DC1F+20250910055636.GA1832711@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
	<20250909120906.1781444-4-dong100@mucse.com>
	<54602bba-3ec1-4cae-b068-e9c215b43773@ti.com>
	<20250909135554.5013bcb0@kernel.org>
	<36DC826EE102DC1F+20250910055636.GA1832711@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 13:56:36 +0800 Yibo Dong wrote:
> > Not sure this is really necessary, I'd expect C programmers to intuit 
> > that 4 is the number of bytes in u32 here. sizeof(u32) is going to
> > overflow 80 char line limit and cause more harm than good.
> >   
> 
> I found similar code in other drivers, ixgbe, it like this:
> 
> #define IXGBE_READ_REG_ARRAY(a, reg, offset) \
>                  ixgbe_read_reg((a), (reg) + ((offset) << 2))
> 
>          for (i = 0; i < size; i++)
>                  msg[i] = IXGBE_READ_REG_ARRAY(hw, IXGBE_PFMBMEM(vf_number), i);
> 
> Maybe I should follow that style?

Personal preference at this stage, but I like your code more.

