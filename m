Return-Path: <netdev+bounces-115783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3120947C3D
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA681F21172
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA36CDC8;
	Mon,  5 Aug 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7aVeQPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07240875
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866015; cv=none; b=tw+eN06lu5cEWjlRexL3eMXmlAXdsekI8h0pWV+8htdJz9esTSW+T0AZR/ETZciQzo5Zr28IiWHAus5vS84ticKgkcPmtZ0M/V0QvCjDAzE6RviUVthyW7CLzqXtdFCGC6MCn94nCVDAR8g39dwfoGI3rgbeIW4meoPNQOWgEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866015; c=relaxed/simple;
	bh=eiTupy60Hnk3Gx7DHWsXEucxGFZJuRO9PK5l+4IfUs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+HdafjC+HVR/ts41qBGAo8mkWmE4/7ONYv3m2wqPAcm51RBvG2uySX9p0DzpGdNJ+06aqb+G0Y2l7DhGr5HeRrT580E4VxPnp0Q54Ms7zZ6k0FAzsHHenaKilTD6z+DPHe3mSaQSboIGtNRBHk64H/xUzUR2ON0cqdySayLz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7aVeQPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DE2C32782;
	Mon,  5 Aug 2024 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722866014;
	bh=eiTupy60Hnk3Gx7DHWsXEucxGFZJuRO9PK5l+4IfUs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7aVeQPnD1jyw1kqVMAMdIeXbeMlqVLFhptzeJEvLuR5pdRwg2XUeBB2EDpEIjURv
	 yCxfK0okYDHrzt3+m+XvWc8XwbosZ3+wKYfYiUCkjaqcLEaOS8q7wKc0/SOZqbnlHF
	 a680rrj4q3M1jU57x9hcwMzp/yu62HEwL6qmLIVlTv9EKBTCtjOzEWaQ+IFmeHVS6m
	 RijM6CE88powadsTJpYJykAT7Zxrq3KPrf9cH5/QwWmJ9EnfFhU8mHPKxmO5zBe+k5
	 mBGHJI77QBe++C6xT/HBnGuncU4EsNSw9cR6CHsRN2Z15CPVQoS39AwdSpD8ZnyRrn
	 CdZ9k5kX6omHQ==
Date: Mon, 5 Aug 2024 14:53:31 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/5] udp: constify 'struct net' parameter of
 socket lookups
Message-ID: <20240805135331.GD2636630@kernel.org>
References: <20240802134029.3748005-1-edumazet@google.com>
 <20240802134029.3748005-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802134029.3748005-4-edumazet@google.com>

On Fri, Aug 02, 2024 at 01:40:27PM +0000, Eric Dumazet wrote:
> Following helpers do not touch their 'struct net' argument.
> 
> - udp_sk_bound_dev_eq()
> - udp4_lib_lookup()
> - __udp4_lib_lookup()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


