Return-Path: <netdev+bounces-242307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FE9C8EB51
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1503A713A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914423321DF;
	Thu, 27 Nov 2025 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="SOZ8tUlw"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBC1A9F97;
	Thu, 27 Nov 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252409; cv=pass; b=s6tjQGpgWp/iYgpU2TcXaYRvDz4NzwO7Q/wAtKyJGutj6355hxK7tkBYgVw3yH0GhH2aLJRn86tbb8X23hEVJEwSZE3ro32yFxbGM8FksAqK95sxzRHbZPzW4NA69RWJwsAGBNCPnkPKJSrWAMC9H4TFGKbj/G4tOSPqDYcYtUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252409; c=relaxed/simple;
	bh=thUwf2ZuUYxLloCKvUiBKzwC22g+MicFemH8zuy5d3s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qZ4txuCpJC69GANVZ/ddPJPHvKUWQEgoQ/Z+AvGvYCACIYA4jjbTP2nmvhKXt/e+2OcpG6pDlwHw9zTupaYlyta2Sy44KJeM/9bLaPdivVfGChZzF50sGzZ8s68b3JACtXK3SLITGYLN5vcnW1LkMFovOCNeaSGBjkFE4UwgbEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=SOZ8tUlw; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764252383; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=AaHxMkXZD9Qp3QCgnVev5IcluV02Hgv0JJU6fUwa+Ote2sdMu7hUNUHHvoTe2E253sbeRKWqVIWSW5g0Tsjs6hbP5dNQYCAOdZ6AnKXKhqq5J+oWfLE44WI9cZgk45eP1gxay7NJLVrEL2xYp4W7T7eELK4aEGtHMATWrLmvSLE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764252383; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oeQqSC1EQimaN4njJ9kpq8vL1i88+TjOMYDNXIrlzUY=; 
	b=d3tlsvbEE117Yq3G9uaXlnrLFtJqymy5Bnye+mjXC9z6Q9M2mxxFpobn3ehURLMZdCwKGRLKkftA2NlbWGRC98Ia7Fw5IuGT2AsHyHrZzFlsNOVEY8LKWzbee/gg6qw4QZM+XKBABH2dLqs0xlOKU/GBBILUffehFu0PsLQwqtg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764252383;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oeQqSC1EQimaN4njJ9kpq8vL1i88+TjOMYDNXIrlzUY=;
	b=SOZ8tUlw36E6ckjFAlJJk3nluDqtiKQGEXFPMXc5vaKl3C8sMVHcI8ewSF+v4E3y
	8C+PsIF6JskfRu5wQr0XO9CSKvZgNRJFC+6HAd+zSec8oeju52zsBU0BXJnWm7oWY17
	rm+uV5QB9MnaXRkQSIC9rCRrpWJdF8ZVroNiTcE0=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1764252380701813.3980085473922; Thu, 27 Nov 2025 15:06:20 +0100 (CET)
Date: Thu, 27 Nov 2025 15:06:20 +0100
From: azey <me@azey.net>
To: "nicolasdichtel" <nicolas.dichtel@6wind.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "David Ahern" <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net>
In-Reply-To: <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net> <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-27 08:58:59 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> I still think that there could be regressions because this commit changes the
> default behavior.

I don't think it should - my reasoning is that any routes created via
ip6_route_multipath_add() would always pass rt6_qualify_for_ecmp()
before this patch anyway:
- RAs get added as single routes via ip6_route_add(), so RTF_ADDRCONF
  wouldn't be set
- f6i->nh wouldn't be set, since:
  - ip6_route_info_create_nh() only sets nh if cfg->fc_nh_id is set,
    otherwise sets fib6_nh
  - rtm_to_fib6_config() prevents RTA_NH_ID and RTA_MULTIPATH from being
    set at the same time, and only sets fc_nh_id if RTA_NH_ID is set
- f6i->fib6_nh->fib_nh_gw_family would always be set, as dev-only routes
  were stopped by the check in rtm_to_fib6_multipath_config()

Did I get anything wrong? I should've probably included this in the commit
message, sorry.

> As stated for v1, having device-only multipath routes is already possible via
> the nexthop API.

I understand, however I still think it would be worth it to add this
to reconcile the v6/v4 APIs a bit better. If my reasoning is correct
and this doesn't cause regressions, it's a pretty trivial patch, and
FWIW as a user the feature would be very useful to me.

