Return-Path: <netdev+bounces-108085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C991DD0E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9F41C219D4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA7C12C52E;
	Mon,  1 Jul 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJNYJSbg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58666847C;
	Mon,  1 Jul 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831053; cv=none; b=p+4Bl68Kt2naUcl4hG1+NiMIZ+RSCHII2xcoO3h2vn1nMt0xWX8N6qbXoQURArQP0Fx8hgZyB52O03y9s5b3JB3PG8NXPVMJtB1fLMAolyrntWQpSRjV+9dhqhNzvq92ygO7X3/8kKmjPKM8GJ3CMlarkIsKcsmZz32F0fw4oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831053; c=relaxed/simple;
	bh=5d/pnoiUBPFukw6fNzHxyl7oNa7Flp+dnG4RXp74PxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9RzH6ltLc3CRJ++ofg/bMyCQGwgejJZ7dI1LLGbFNUQjHzrMrInLZglgowH53vrdupPs5OT6fgEFBYfuV1rHyofSJsIujoVcTbx125UQx+EHkI6xPDPZG2XDP9r0WlQ0BQm6JL5t6VZncPnzswt4UQLlOMd4I8uEv2csAe3ib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJNYJSbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262D7C116B1;
	Mon,  1 Jul 2024 10:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719831053;
	bh=5d/pnoiUBPFukw6fNzHxyl7oNa7Flp+dnG4RXp74PxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJNYJSbgQXQQsFEyE8EAjJTklMt9RlCsPYGSIEYAlf0aixcCOcqH9IPmEbP/VEkM4
	 FmOSK5RO0ZLWMR/cATcT/3cy+Noo9JSzeWaJFW0d46DQ/1aC/60TnPZsgeGdMnXFXM
	 lSwjh68c5KyVclgaCJCRGKbJJn7jl7/3OYbc8j7/z/AgNqdrxKqxv+KMhn6ghlkCKf
	 OcCkunmxyEeu6hhpXm74iFgFAoP+CjuPUDHv/azIUpnjJPHga5Xl6nB7r+GQSKUmh+
	 hdbPKMp6J6MkXeqwVgUMOuRZSyjUI23qPaIMO/8RQlPxILowLkGAu4XB9HUwnD2BEx
	 wf2yF744LUTYg==
Date: Mon, 1 Jul 2024 11:50:49 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v7 05/10] octeontx2-af: Add packet path between
 representor and VF
Message-ID: <20240701105049.GT17134@kernel.org>
References: <20240628133517.8591-1-gakula@marvell.com>
 <20240628133517.8591-6-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628133517.8591-6-gakula@marvell.com>

On Fri, Jun 28, 2024 at 07:05:12PM +0530, Geetha sowjanya wrote:
> Current HW, do not support in-built switch which will forward pkts
> between representee and representor. When representor is put under
> a bridge and pkts needs to be sent to representee, then pkts from
> representor are sent on a HW internal loopback channel, which again
> will be punted to ingress pkt parser. Now the rules that this patch
> installs are the MCAM filters/rules which will match against these
> pkts and forward them to representee.
> The rules that this patch installs are for basic
> representor <=> representee path similar to Tun/TAP between VM and
> Host.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


