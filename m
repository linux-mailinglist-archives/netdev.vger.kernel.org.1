Return-Path: <netdev+bounces-193128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03420AC2954
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 20:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1797ABABF
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF3A298C33;
	Fri, 23 May 2025 18:12:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF59F226CFD
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023963; cv=none; b=Fwx3ro0zuvzQ6YWLC2spcJBNeM0gTYnlyK2wbzL8kTRu1GJgzPPTQTE+B/Nl1txDehSQAqn44+b1X+i8epzCAH9NcTFFKbog5ph5z1hqUolGXV5f4qo74GVHCVj4bCbaPdhvVDUsvHExMrgfWPvNdRKpk8xikIMDC4FSGJoCJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023963; c=relaxed/simple;
	bh=MvYe62TfYEt2cosPpNXLttH5zJguUxnZ2WMlIbdxcto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO4be0oapsyP87hMBxDEHRmfU37IARtfWNe/4CSEywsKRhmACFIkMt2jwyGIhJP5xhTjE0NWDTotrEpoZipjN6Lk0Ej9fvim3Wrw7/uZrLEAQ86Fjq+cgXdk4nWgZcC0jRW+ugGRNW2V/SoiA6ygYynCQsQcPdxdyrFAIxLehYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7BE356035B; Fri, 23 May 2025 20:12:38 +0200 (CEST)
Date: Fri, 23 May 2025 20:12:38 +0200
From: Florian Westphal <fw@strlen.de>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>
Subject: Re: [PATCH ipsec 2/2] xfrm: state: use a consistent pcpu_id in
 xfrm_state_find
Message-ID: <aDC6lpnfvhWoeM-C@strlen.de>
References: <cover.1748001837.git.sd@queasysnail.net>
 <6d0dd032450372755c629a68e6999c3b317c0188.1748001837.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d0dd032450372755c629a68e6999c3b317c0188.1748001837.git.sd@queasysnail.net>

Sabrina Dubroca <sd@queasysnail.net> wrote:
> If we get preempted during xfrm_state_find, we could run
> xfrm_state_look_at using a different pcpu_id than the one
> xfrm_state_find saw.

[..]

> This can be avoided by passing the original pcpu_id down to all
> xfrm_state_look_at() calls.

FWIW I found this get/put pair slightly confusing as well, so:

Reviewed-by: Florian Westphal <fw@strlen.de>

