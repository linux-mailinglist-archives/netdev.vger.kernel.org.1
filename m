Return-Path: <netdev+bounces-146595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C89D4815
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5E9282617
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A2D1547EF;
	Thu, 21 Nov 2024 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeTzLkJ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257B74068;
	Thu, 21 Nov 2024 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173235; cv=none; b=K7l2e8DiH8nUeE/2bEPgw0K77oPcoCSp1gkZYL781LBf0AZSfds562pCTF0E12AbiLLc9ZHE6SkTGiYC8t9YWQ74quDKZs1k1lynQP5AvM6XcMvD5vMSZ9A/IyMGKCs1cXxjUbZECybEYFWd9Lav3uN9FJsfiUl7sMKX83ElEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173235; c=relaxed/simple;
	bh=8asvzXQgvkNgGEQb9dmSkLgi5OwVK7cchw9YDUp2VTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyVP0oQZjEc5K9rXFxAkFSUz3UZUCjcEH28Lvq12xtVc/3k5y4Hk5QMkA2NFZLwkrYACePeAvw7dZoTq13KDTrTj7uD79lv+UM0UjJvp22tKWGs5Z5d3L/KO6yTKMvYCMfQ5/fSYvbaXCXO7NgMPtza2uO0HwByN8LlD42w+nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeTzLkJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D479EC4CECC;
	Thu, 21 Nov 2024 07:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732173234;
	bh=8asvzXQgvkNgGEQb9dmSkLgi5OwVK7cchw9YDUp2VTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DeTzLkJ0XCEkObLOHTAh9p15JuG4I6twejfdRIFVUuQirivuUZre1CnF8dBIct1pN
	 wfnKI+dumRddNCz3WzlPzXVbXPqWH2hh3Tvez5+RPPY7WpCQvHP8TjgpZz1QF6O3US
	 CTOdk9yvQc90CnWq3DirkM7xMZUWpIdMjQFHU7INVp3zkLx+ZZRBgqTgVfo/2TvuC2
	 M6eY2l1zrCQgbsWysmATXWJyjCSMaarsUo36C7u7BPjvj1Sj7YprCZhDcDRdzxzMQN
	 rmOaJgdY1TT4jyGR+udRgVhc3LOk/qIFktIAsBu6GKX9G/Fl/pQxLEwJ1Pdomy9/Vy
	 lC4kllDfa25Vw==
Date: Thu, 21 Nov 2024 09:13:47 +0200
From: Zhi Wang <zhiwang@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Subject: Re: [PATCH v5 10/27] cxl: harden resource_contains checks to handle
 zero size resources
Message-ID: <20241121091347.0000233c.zhiwang@kernel.org>
In-Reply-To: <78cfa71b-5501-b79d-477c-c3a67340d60a@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-11-alejandro.lucero-palau@amd.com>
	<20241119215042.0000617b@nvidia.com>
	<78cfa71b-5501-b79d-477c-c3a67340d60a@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 13:45:54 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> 
> On 11/19/24 19:50, Zhi Wang wrote:
> > On Mon, 18 Nov 2024 16:44:17 +0000
> > <alejandro.lucero-palau@amd.com> wrote:
> >
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> For a resource defined with size zero, resource_contains returns
> >> always true.
> >>
> >> Add resource size check before using it.
> >>
> > Does this trigger a bug? Looks like this should be with a Fixes:
> > tag?
> 
> 
> It seems it does not until the new code for type2 support.
> 

I see. Then it is not necessary for a Fixes: tag.

> 
> > Z.
> >
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> ---
> >>   drivers/cxl/core/hdm.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> >> index 223c273c0cd1..c58d6b8f9b58 100644
> >> --- a/drivers/cxl/core/hdm.c
> >> +++ b/drivers/cxl/core/hdm.c
> >> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct
> >> cxl_endpoint_decoder *cxled, cxled->dpa_res = res;
> >>   	cxled->skip = skipped;
> >>   
> >> -	if (resource_contains(&cxlds->pmem_res, res))
> >> +	if (resource_size(&cxlds->pmem_res) &&
> >> +	    resource_contains(&cxlds->pmem_res, res)) {
> >>   		cxled->mode = CXL_DECODER_PMEM;
> >> -	else if (resource_contains(&cxlds->ram_res, res))
> >> +	} else if (resource_size(&cxlds->ram_res) &&
> >> +		   resource_contains(&cxlds->ram_res, res)) {
> >>   		cxled->mode = CXL_DECODER_RAM;
> >> +	}
> >>   	else {
> >>   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not
> >> supported\n", port->id, cxled->cxld.id, cxled->dpa_res);
> 


