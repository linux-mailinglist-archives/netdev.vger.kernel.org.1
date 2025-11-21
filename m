Return-Path: <netdev+bounces-240866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F423AC7B939
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EA003578CF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A8303A1C;
	Fri, 21 Nov 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKBBbTax"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38D2D979B;
	Fri, 21 Nov 2025 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754313; cv=none; b=I5puqjWNOujoJdpPaQyJY/QLQTXDs0oQiCdHLNX8a9JTzVmNMPlKug6ih8DJcKaZsp19w84g/ZcFTILvi+ckzLu7PuSLNWoDh5Epkt0vcyEZtdf5u89RjbGytJ5Fp3+KaQGRc2C0D02rQ1l49lnMAO5CEXfOlniOktb4C2+rJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754313; c=relaxed/simple;
	bh=xt2sMU4Pn8sTz7z1XcKEFqrHDUbonCIKd5lZ38jE7rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COFN3tmspViBf61CKHaUOPu5jReCSibD04dru2wzCPOCdZ+/YSTayQ7ef7bcLx3tOHOTpsEPJ0fsDs7OfSDA30whseDfLiHf/u37uNMbp4yonLxV411WGU2ztvV5P9qoJLim08XqP8ziX8U3B8l/R5EnqpkLpcsRePMsomPO9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKBBbTax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54A4C4CEF1;
	Fri, 21 Nov 2025 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763754312;
	bh=xt2sMU4Pn8sTz7z1XcKEFqrHDUbonCIKd5lZ38jE7rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKBBbTaxXtkUgtUs9OUwBM1KEOe+ZDQLuEtSsqaZEsCOtaqFMVA34nB0l+fuBL1rq
	 yxThCyQgCaveY9gXdrpKLT6uhLTnC90Tfen3ua7iKpwcZ/qJLaUNfe6uSFmVBvePaq
	 +3uHCVYai1hglJ3xZmmPyRIsnCuWVWIUXd9Av1ubvnwdmIy/teBOTMAaxd7Go6uWgR
	 vk+dgBtEmJr16Wg7xLRAyz9eW3bblUqooK9CmqOoa7QTGay3HsKH8n1zZd6PHx50xz
	 fEwtsCl4epJsX6ajKe3LqXEiewMFfp3N398lLLDzM25PagArNDPfe+vNaqWHqMrm0o
	 jzYY4CElHREcQ==
Date: Fri, 21 Nov 2025 19:45:09 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?Zmx5bm5uY2hlbijpmYjlpKnmpZop?= <flynnnchen@tencent.com>
Cc: krzk <krzk@kernel.org>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfc: port100: guard against incomplete USB frames
Message-ID: <aSDBRdt84f2O0Anp@horms.kernel.org>
References: <D9E78B690F07660A+202511171222138721171@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D9E78B690F07660A+202511171222138721171@tencent.com>

On Mon, Nov 17, 2025 at 12:22:15PM +0800, flynnnchen(陈天楚) wrote:
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> Validate that the URB payload is long enough for the frame header and the
> advertised data length before accessing it, so truncated transfers are
> rejected with -EIO, preventing the driver from reading out-of-bounds and
> leaking kernel memory to USB devices.
> 
> Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>

Thanks,

FWIIW, I agree with your analysis and solution.


I would add a fixes tag, as it is a fix for code present in the
net tree.

Perhaps this one: this seems to be the commit where the problem
was introduced.

Fixes: 0347a6ab300a ("NFC: port100: Commands mechanism implementation")


And it would be best to explicitly target such a fix at the net
tree, like this:

Subject: [PATCH net] ...


On a process note, as the from address of your email doesn't match
the Signed-off-by line, I think it would be best to include a From:
line at the very beginning of the commit message, with your name
matching the Signed-off-by line.

i.e.

From: Tianchu Chen <flynnnchen@tencent.com>


But over all this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

