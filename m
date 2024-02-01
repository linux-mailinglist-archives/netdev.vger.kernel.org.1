Return-Path: <netdev+bounces-67750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E82844DC6
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70D81C25D22
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E61184;
	Thu,  1 Feb 2024 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk+5raA/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D9380
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747021; cv=none; b=Ore/zRZ1YrCOSZdOyxtzg43HR3kvy1s9+Nf3lQEEfBSPw3UgZWppIbmnRqh7a6c7gbSsSRtyu350P3l3BOpSFCyNKzYx1PaVMnBmsDqInYTrRS+8PF999L5af7P+BIcESOOP6RrM6NaDpGIxplL2wDosuMarAv1Q4RhctfF7UmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747021; c=relaxed/simple;
	bh=7gsKG6V5s1dopCQuysbsTz34HGC4+l+xc5j4okSwkgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhOT9WJ5LoXx7Igq4t1XAHQosCHvD5uZdKKo6DLrhcF1QfRwOOTYnneTyXRXsYL+uGb3/dFxHxFeHlO3ay1LB2MToNFFcn1uyI2SAzG06q8GVrGVItYOaYKIHn+VKw1m56N5a1nF7LOAWaTBQFXyuLFYlHqf6FhQ6FDiBlC1x8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk+5raA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646C0C433F1;
	Thu,  1 Feb 2024 00:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747020;
	bh=7gsKG6V5s1dopCQuysbsTz34HGC4+l+xc5j4okSwkgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lk+5raA/Cc61dnv9T5cuz4gmbXaTbEiX742QUf0zqnvIfq3Fj3SYKTN/uoi3yP+g/
	 pLoelw6V1AJdY5MbbIOAYtjq2qesUk/3GIwLzdEFsN3PUAnwi+SxWwW3Lk9cgZsGoS
	 qlbBbWMb45LrvVgTPSl5JJf+j443ewZ3jZ6m6+9GWMGFXHWIqsoJk6VP5mL+8net8k
	 d2kwVXZdx5SbZTOwXM3ZVtzXTiOiHudjReNRanO2NxpAYRWNjdzws2AHMiA+mEOmcg
	 c0zNjS8GO0+Zn4sPw2NrOEAj6LZ6IyjsmFrxzylSiyQWii7Fsps6xQ8mJ7fjWr3eN7
	 6nJN7zWOFch0g==
Date: Wed, 31 Jan 2024 16:23:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Durrant <paul@xen.org>
Cc: Jan Beulich <jbeulich@suse.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Wei Liu <wl@xen.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH net] xen-netback: properly sync TX responses
Message-ID: <20240131162336.7d3ba09e@kernel.org>
In-Reply-To: <980c6c3d-e10e-4459-8565-e8fbde122f00@suse.com>
References: <980c6c3d-e10e-4459-8565-e8fbde122f00@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 14:03:08 +0100 Jan Beulich wrote:
> Invoking the make_tx_response() / push_tx_responses() pair with no lock
> held would be acceptable only if all such invocations happened from the
> same context (NAPI instance or dealloc thread). Since this isn't the
> case, and since the interface "spec" also doesn't demand that multicast
> operations may only be performed with no in-flight transmits,
> MCAST_{ADD,DEL} processing also needs to acquire the response lock
> around the invocations.
> 
> To prevent similar mistakes going forward, "downgrade" the present
> functions to private helpers of just the two remaining ones using them
> directly, with no forward declarations anymore. This involves renaming
> what so far was make_tx_response(), for the new function of that name
> to serve the new (wrapper) purpose.
> 
> While there,
> - constify the txp parameters,
> - correct xenvif_idx_release()'s status parameter's type,
> - rename {,_}make_tx_response()'s status parameters for consistency with
>   xenvif_idx_release()'s.

Hi Paul, is this one on your TODO list to review or should 
we do our best? :)
-- 
pw-bot: needs-ack

