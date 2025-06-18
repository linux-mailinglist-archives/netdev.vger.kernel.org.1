Return-Path: <netdev+bounces-199203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2907ADF646
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C17B7A58C2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA752F3C3E;
	Wed, 18 Jun 2025 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNG0Vlxl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA63085C7;
	Wed, 18 Jun 2025 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272709; cv=none; b=Vg/9TEpLt5DfkdYwokxfw3Hx2rsgsg/Z+9cqjcl6an05ZrM1NhOw6lPNIf/JzwDJ9puIIXQTjEK1tnfxUy7urXiGrsCduEOQ3bRXMFqb4e05YLBLBVdrPw2QBpdxZYH+8gTvHDcJ32kXn1z3EOrSlLsXooJy11la5ECH4/zsj3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272709; c=relaxed/simple;
	bh=RBp5ZdoDBE1Lqcv0CBVlTsp0wBSkaW2tEto6qnoZP4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTDP9Z4mPtyDCsmy+O2iESdfEDbcoRrWjMozaT5GRla2jD8ReMpp2iCOqDZy6G/1qJJlg0M4hfZoMhAI9X5Ox836xxy68M+NOhbhfBkOucvs1jlgLie6ezQiL/PNViJjThpmQXJ+pUQNhSUrSRqV5/xdS1+UEWRdres9LjIjEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNG0Vlxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCFFC4CEE7;
	Wed, 18 Jun 2025 18:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750272708;
	bh=RBp5ZdoDBE1Lqcv0CBVlTsp0wBSkaW2tEto6qnoZP4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNG0Vlxlv2KmfgUt5oRE4Eyl4Puq5VxzsGI+QTvlsieaYK3be/d3eBbWT/abNR3TU
	 PCl4zwRxtZaWur53UDRZnBdMqYuInRtgD9hmMwkMnh0qLZ8zUsPFW8Q8vh/xtpDihP
	 43IjnaHLMYB4lL2M9nTzG7xtNJieyeuEmVKOMuUpU0zKXnKaJaLPfQzmY/PnzEfCD8
	 9F9m8cr1ygfeJ8UvZCO86kO20JgAGz9M8xs+gnAPMReiEmviAr3/w2gIfcs2C0TxS0
	 V27cG0SBx7347qlGEPX27BAMenwzZ/NY6J95KlKMfGEHL0pLT9Obo82ghItpaN+PUL
	 +S8bVLSPIngcg==
Date: Wed, 18 Jun 2025 11:51:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, jv@jvosburgh.ne, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH 0/3] netpoll: Code organization improvements
Message-ID: <20250618115147.7987daab@kernel.org>
In-Reply-To: <aFLafR/RJqJFf8D7@gmail.com>
References: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
	<aFLafR/RJqJFf8D7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 08:25:49 -0700 Breno Leitao wrote:
> I will send a v2 tomorrow with the proper "net-next" tag.

No need, it's not worth resending for.

