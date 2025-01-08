Return-Path: <netdev+bounces-156111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F2A04FCA
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9CF18874AA
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B50126BEE;
	Wed,  8 Jan 2025 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPjX7mCD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EEF2C80
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300446; cv=none; b=HjnBiAetwVAj2rxBOTs5SEuSzn/mbQ3qI9F8rsDPnRVuE2H5a9wqQTY/HXB3FPGRvTQrUerDXM/mfOweoF1YMxv6/42DZkqNZArnVypYccuPZYHOFNp+BnsuAhxZ79//uDHKHtCefVDYgcmklMVHcukaFIOQA6dLbb4KbM7PyzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300446; c=relaxed/simple;
	bh=OUY+rJo+BbLuVdamRVckUxouOpwsC4Yy4dp+27T7Rc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k41bZQtrb2MUtjr8ilfBUN2SIf/PngwBG8t59i++KMPukZKKeETqaPpVowFMUfGJtrnVEuf3FiTwCSg8VszolmJtDJ9ATUAX1wCWBQESCPpMbGQp5phPMxKG+i+91Bh4CIvhOm+Jfo+g4K3LYR6S28JDFVaGQChdrK7Mc7Uz7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPjX7mCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBA0C4CED6;
	Wed,  8 Jan 2025 01:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736300446;
	bh=OUY+rJo+BbLuVdamRVckUxouOpwsC4Yy4dp+27T7Rc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RPjX7mCDJB1ldY5rVVT/+jRr17+7pl0eQMYVQ2k+8oHQeeAl6U18VGGhwuxoVHgvf
	 545cQB4PAE4NyBIR3vhp3Eu/VbaKZo3d4Aa8E/TkqcZ6bcasYvHxYJhLnvMHzSsawK
	 kKgBZXR7yM2nzSQYaZgvtaV68pdy0RyOW6nxjf4K0jX9XsKFoKBW+cSswOVa4SpFmc
	 UjIrPO+oqGyPgmcf5xqYd7fMxAWzDu5uWrQPR/1hlIMdMqY+HbNeebfy8mrejZ//Ui
	 ZAzkhsb/rWChckhVDGTsGm4MgRWjGT8JRTdRRqYP2XbPgNj94GrbHFpa2fBD0BWYBE
	 98maYNQIVWSJw==
Date: Tue, 7 Jan 2025 17:40:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH][Resend][net-next] net: ethtool: Use hwprov under
 rcu_read_lock
Message-ID: <20250107174045.3763ffd2@kernel.org>
In-Reply-To: <20250107173943.223f62f9@kernel.org>
References: <20250105084052.20694-1-lirongqing@baidu.com>
	<20250107173943.223f62f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 17:39:43 -0800 Jakub Kicinski wrote:
> On Sun,  5 Jan 2025 16:40:52 +0800 Li RongQing wrote:
> > hwprov should be protected by rcu_read_lock to prevent possible UAF
> > 
> > Fixes: 4c61d809cf60 ("net: ethtool: Fix suspicious rcu_dereference usage")
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>  
> 
> In the future please make sure you CC the appropriate authors and
> maintainers. Always use get_maintainer.pl on the generated patch file.

Actually, the code could be improved, too.

Don't declare ret, move the declaration of int err instead.
-- 
pw-bot: cr

