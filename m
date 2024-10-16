Return-Path: <netdev+bounces-135938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A9E99FD5D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4C42865AC
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B71A926;
	Wed, 16 Oct 2024 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwjDwLci"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08BB21E3C8
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039767; cv=none; b=YtSSRwvuqGvAwVl4YbKghSu641wnx4x5znetGtFfm/Cvlr1jb03m/qncnCxYq+bdEwMbRGmLUYGo0Osj6ynnw+y0wx4mqEtNwpilUq4NbxDCb6c26Yy3K2G8VfSTFk6WfF5WyRITVRkT/Z4prAONAbg9h3IDYZV6p7OKen0UCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039767; c=relaxed/simple;
	bh=qNenrMhb0a9zh0xZIMofaeV1B9E5VQmkx8lfgNnIoow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzJuKoU/YjI3yp4qIjNn6kmiT3tptKa5iO0pah196paPQO1RuuYo8QIAv3SDGBx8oeF4oVJjbIP1rSww0+UlkSNzJ846Zhj8wwGa/o68cw2jqPIilREeezDMU2Po8HbuGfbcIoqtJumNa6u+RwqSKiBMy7ne3o4Jj45VvHRNVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwjDwLci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFA1C4CEC6;
	Wed, 16 Oct 2024 00:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729039765;
	bh=qNenrMhb0a9zh0xZIMofaeV1B9E5VQmkx8lfgNnIoow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XwjDwLciPlybKOtlas1HC+lBwxD9LbRFWbVJxu+DA7cGBMh7EKyCGKztLPHWKG2T0
	 tJBf//Ag6RmbSbAJ8mKj2QiTj7A0YoyvHe6N/vVACkI85d2KxptUaexhG0882lKDA/
	 gT0d4yzSrx7S0trbd7uDWg/MHXKsNkgkR1jEDYot2VPYAokIqNa38gM/6uy5P4zA3a
	 bF5JtfOH6wsrgVhYLhhEBrxuhYufP6eXOj4OrmPd6zh0EN7J/SxVBY62XiwTOvX0Ky
	 L0p7rw9KCXn3LWnMpXgh8Xw+EvTA9iqFr2gx+VMz0OeJbzsJX2b2u17iP5DVIz/XS4
	 V8UE4PO40hUmA==
Date: Tue, 15 Oct 2024 17:49:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Rashleigh <peter@rashleigh.ca>
Cc: andrew@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix error when setting port
 policy on mv88e6393x
Message-ID: <20241015174924.21725f5a@kernel.org>
In-Reply-To: <CAOai=UuBxxfdu8HsnZi3CmWzZR=zBc_v0A624uTwfKUDRkrwiQ@mail.gmail.com>
References: <CAOai=UuBxxfdu8HsnZi3CmWzZR=zBc_v0A624uTwfKUDRkrwiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 14:25:44 -0700 Peter Rashleigh wrote:
> mv88e6393x_port_set_policy doesn't correctly shift the ptr value when
> converting the policy format between the old and new styles, so the
> target register ends up with the ptr being written over the data bits.
> 
> Shift the pointer to align with the format expected by
> mv88e6393x_port_policy_write().
> 
> Fixes: 6584b26020fc ("net: dsa: mv88e6xxx: implement .port_set_policy
> for Amethyst")
> Signed-off-by: Peter Rashleigh <peter@rashleigh.ca>

the patch has been line-wrapped and whitespace corrupted by either your
email client or server. Please resend.
-- 
pw-bot: cr

