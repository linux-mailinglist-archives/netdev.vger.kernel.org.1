Return-Path: <netdev+bounces-219389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15607B41168
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9691A81DD3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC411A9F82;
	Wed,  3 Sep 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0LDnifn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CB8F40
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860078; cv=none; b=MypV67mblIJoINY6jJY7bprhgN5NgLV8/3vhwCQji0jGtu58RG9ou2V2TJA6mDVUx5+KnhHfBjbtudbXCYD5dy7RJ63nZ5wLeVV0a8l57K+6aDcARXFCRy9ON+7vI6Mie1gkBVck0XibpeNzGZRWGWxJIDhe5KBkKHJIweNtK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860078; c=relaxed/simple;
	bh=7Cu5aGihQI+cmoelAmFkjvBxmqTrnU1hNqTjl1myY6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROsliT0wazzSHnVaFOuWaf+6kY+gPeQ8nV+vC5KEYEa2TW9IKY+ewdmDPPQWW7m2aX6qgNwBAT3gjNDVB3FJj327ffP25hHa8J7a+K0Wvapld1sra/Znw2DKNA8uRhM8KcMlQgTmXsBwbb+l4QKaP6LFmZACZAJ3ozRGX4siA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0LDnifn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B6DC4CEED;
	Wed,  3 Sep 2025 00:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756860077;
	bh=7Cu5aGihQI+cmoelAmFkjvBxmqTrnU1hNqTjl1myY6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0LDnifnhlMCXiF4xC5RFgxEAQnqfTf5XXby9W/wSs+bv5mhccsXf+b9kmhPBxxjv
	 sa8kbFk6ApCdM3fvufe9qFTptWs0QBmSLGFRRskUvHPCaG7sV8CmxGqFtfoCDldUBF
	 y+LX01+rATkuzMPSmL8mDW85AOSR7r4I+oEjLj+lM2JL95DLTCiIup5eDKBbI6mDmu
	 tR/Acm95S2JcfINvcfupAt6pa6ZzHtAP1I1ZhAfcmLba0nZv3mTP5STaEyNibANhfT
	 goqqCJSjcnlwxKZI8j6+XUgFaRZJhkPUpUdn5ksWG7zf5EtmkvKa9m6Ajor8Iz7+RV
	 qkRSY/fyCvcng==
Date: Tue, 2 Sep 2025 17:41:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v3 1/2] net: libwx: support multiple RSS for
 every pool
Message-ID: <20250902174116.080782a5@kernel.org>
In-Reply-To: <20250902032359.9768-2-jiawenwu@trustnetic.com>
References: <20250902032359.9768-1-jiawenwu@trustnetic.com>
	<20250902032359.9768-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 11:23:58 +0800 Jiawen Wu wrote:
> Depends-on: commit 46ba3e154d60 ("net: libwx: fix to enable RSS")

What made you think this sort of citation is a thing?
-- 
pw-bot: cr

