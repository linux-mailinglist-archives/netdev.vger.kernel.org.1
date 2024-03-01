Return-Path: <netdev+bounces-76388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F6786D924
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C957A284FE3
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65C8485;
	Fri,  1 Mar 2024 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+dwGVk6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983138F94
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257756; cv=none; b=HfWxhN/rIdCtf2rW3/I5pqHT2DNemkYc1Ab5fUEANyAImxUFC8EYghjRQ8Lo+X+J8l8qUCrFUbYWrDdWCxfy7iSpBWkZEDrW+XBZRBWP8qD/pwPhsEew8imvweF3c5lQpH3WX5r7OzUmmjzTKfUCSY7qJEBCbeMJtGpGnOGUOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257756; c=relaxed/simple;
	bh=x6r2Y5DsuDRLe9aKxr3x8TPe4j53T/4JjcInqksnwpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUMtyR9hqR3unPHLaUdxDjE+HmMUaMJOjRcgvZ1Rbwgobx4ISXBLaAgxY7LHmNOh3FYJQC80BUYkfa3HFMK2YfznM7/001f+oKBmmuQ832/l6RRujJmm6uYpAQfd0TJJaqgdq+Wzc9A/HBpHvWGfxE0C+Eep1cBoKuamU1GVoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+dwGVk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEE6C433F1;
	Fri,  1 Mar 2024 01:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709257755;
	bh=x6r2Y5DsuDRLe9aKxr3x8TPe4j53T/4JjcInqksnwpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X+dwGVk6c/wH4eU1bTuhhv4a0XENi+oFSmpC+2NSqpPS4235ZgxEQnfryeJpcsWT0
	 iPN/aMLZsR3XX0Gz6weesCnMTOJuKYyouSV0kV2XCYY49jGDEK1sLxmSEsaHLIV1pn
	 8LyI0KhU/GFUVj7MNw8lohb6hY3XuBjJUBTub9QZH+qtYagELaGTXYFVxZs3889w/j
	 SyaHQgDSbyAq59SHT/VtMaGT8dxfyubTFI3ugqIQeKvKbQfwZsKh/lArxIVf4lBGKe
	 31zuMHmAB7zTYBz1Z5ZkV53woiEYn/0NSvvCASN5C6lsxFiFFee5rAI3PoFEvvOkWp
	 Ho9Hz4n3rklGA==
Date: Thu, 29 Feb 2024 17:49:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>, Michael Chan <michael.chan@broadcom.com>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
Message-ID: <20240229174914.3a9cb61e@kernel.org>
In-Reply-To: <f1d31561-f5b5-486f-98e4-75ccc2723131@linux.dev>
References: <20240229070202.107488-1-michael.chan@broadcom.com>
	<20240229070202.107488-2-michael.chan@broadcom.com>
	<ZeC61UannrX8sWDk@nanopsycho>
	<20240229093054.0bd96a27@kernel.org>
	<f1d31561-f5b5-486f-98e4-75ccc2723131@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 21:22:19 +0000 Vadim Fedorenko wrote:
> > Perhaps, but also I think it's fairly impractical. Specialized users may
> > be able to tune this, but in DC environment PTP is handled at the host  
> 
> That's correct, only 1 app is actually doing syncronization
> 
> > level, and the applications come and go. So all the poor admin can do  
> 
> Container/VM level applications don't care about PTP packets timestamps.
> They only care about the time being synchronized.

What I was saying is that in the PTP daemon you don't know whether
the app running is likely to cause delays or not, and how long.

> > is set this to the max value. While in the driver you can actually try  
> 
> Pure admin will tune it according to the host level app configuration
> which may differ because of environment.

Concrete example?

> > to be a bit more intelligent. Expecting the user to tune this strikes me
> > as trying to take the easy way out..  
> 
> There is no actual way for application to signal down to driver that it
> gave up waiting for TX timestamp, what other kind of smartness can we
> expect here?

Let's figure out why the timeouts happen, before we create uAPIs.
If it's because there's buffer bloat or a pause storm, the next TS
request that gets queued will get stuck in the same exact way.

