Return-Path: <netdev+bounces-111893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD2933FB6
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903831F21286
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B018002A;
	Wed, 17 Jul 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me6XPemS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E31E51E;
	Wed, 17 Jul 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230320; cv=none; b=jMdUA8lQ6lQ1K+g1Lbtb5xjPoEvLVfdvmgY0DyO5QwbjDXGhKHLyiH/ucnAITQae4qyIR4rS39XRpnxGaIjE+XfOdCNSe1KlkQNiyLGWymRoGzvfmjezuESDvbwT7YyA4EJ47rJqD6z+h/IwPn3rJjSh/grujjhIUu60CcnQ9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230320; c=relaxed/simple;
	bh=Mos8CBjJMEs8eYfAImHu0nnmj1Wxt+YKmcH7lURjrNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzANyMpp1Ogtwu3POODLyYrl7qypvTywsHCoaybKivDdYKaM+Ozl8D0MdM9wSkWfyPHSR5r+d6UfMT8n2rzi55ole+c1Xy0XA3/ubOAUyO3VirSRhEF1Ov2LujFvvcyyIaMO2EaeoKIQJYIKcwr++/lLW1VTbMEO0uRfAGdY1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me6XPemS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B7AC2BD10;
	Wed, 17 Jul 2024 15:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721230320;
	bh=Mos8CBjJMEs8eYfAImHu0nnmj1Wxt+YKmcH7lURjrNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=me6XPemS0nz8y/SPUIcKL59yHnC7qJG66xnvSs1rKmV4UzHIixgrq//+cYJq1tBxH
	 qcfL2KSCCfy91KvLXXtwKQlvD6qLxH/hKUN5O2CRNe1QSG0M71Qrdt5eHOpPSaWzWZ
	 LkRZBh3Aqzp3DfCd6DWR7ie807d6E+9L11oMcDAXbsFrKxJvwA+OcmByAGPYbGsrUI
	 1IT8lHzOcX5n9/eoEP9KKmvQuY3vTuy/A9V10t6jtpTNJSxcsrwa54nYnKzLMtPgYI
	 JGGy4w+UGM3PtUMHI23h5HKq0xEj9m7tQyn6UiDizRwNwtSX7GWBu+k87SEHTHWvN0
	 lxeedUnEW4OuQ==
Date: Wed, 17 Jul 2024 08:31:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tung Nguyen <tung.q.nguyen@endava.com>
Cc: Shigeru Yoshida <syoshida@redhat.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
 "ying.xue@windriver.com" <ying.xue@windriver.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] tipc: Return non-zero value from
 tipc_udp_addr2str() on error
Message-ID: <20240717083158.79ee4727@kernel.org>
In-Reply-To: <AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <AS5PR06MB875264DC53F4C10ACA87D227DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
	<c87f411c-ad0e-4c14-b437-8191db438531@redhat.com>
	<AS5PR06MB8752EA2E98654061F6A24073DBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
	<20240717.110353.1959442391771656779.syoshida@redhat.com>
	<AS5PR06MB8752F1B379BB6B90262C741CDBA32@AS5PR06MB8752.eurprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 02:10:33 +0000 Tung Nguyen wrote:
> I agree with this proposal.
> 
> Reviewed-by: Tung Nguyen <tung.q.nguyen@endava.com>
> 
> The information in this email is confidential and may be legally privileged. ...

What do you expect us to do with a review tag that has a two-paragraph
legal license attached to it?

