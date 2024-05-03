Return-Path: <netdev+bounces-93261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B0D8BAD2B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 15:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463F71C208DA
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B24153833;
	Fri,  3 May 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b="opUPuwgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ycharbi.fr (mail.ycharbi.fr [45.83.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B015358B
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741756; cv=none; b=LLWEVgKUI62KH7zvh6zdRP9n6Av+oqZkNxLND+q92tdRFnKSsUEKYgkTY4LUAJxyTXmW4IXI5NRc72NsNi2ME6MeyoBzveILgL4mURm24Q/vOJ0GD1N7dB74bXCOIN+K9iFXJzE1B6m6S3JH+wGtBBh2cU04imbVRHew0QVwdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741756; c=relaxed/simple;
	bh=MEqUzqDW/TOiMz20Ph7/o+xIaZvFQabwFkxkR6vHIjQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=l0oSVq0M9RzALgHpzqjnvSAXlSquxRvNiOKf7RM20TVr1dy53klDl/28ZQG7Ox546yzMl7DG8pjO4urEcBGC52uxFjSncjDKcOpg0YHeoZaWpGXJHITocwO3CaUuphxA3Im8wcyqtlqMlBvk0pu8nnkBW8Ke4AcKRwYg+Ic1bIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr; spf=pass smtp.mailfrom=ycharbi.fr; dkim=pass (4096-bit key) header.d=ycharbi.fr header.i=@ycharbi.fr header.b=opUPuwgM; arc=none smtp.client-ip=45.83.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ycharbi.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ycharbi.fr
Message-ID: <bf100765-5930-4dd5-9004-aaf7e9f2eaa2@ycharbi.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ycharbi.fr; s=mail;
	t=1714741261; bh=MEqUzqDW/TOiMz20Ph7/o+xIaZvFQabwFkxkR6vHIjQ=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To:List-Unsubscribe:
	 From;
	b=opUPuwgMYTXpG0KaSvmWRuzl4+ua604kWLHy8R4cAHjCS3IDTPcwjFLkAxSIEOUv6
	 QYAH6AdjSI4lkqHNN0NjBYLFkRYdDEGusO7GnqSXCpwRu9VU67S2pMv0v79Y9XkBSE
	 wLGzPpCERbqeVFV5aex9yG8Cv5V+OOOHNT+M4f9E51tZwuRVt06XjlQznUcyR2R3XX
	 Q2Wi76yVLBYzu58ptALokOyhS7l056QqVvczjxdaJVXzIN5a6+nEuXfqlyGUhb4MQr
	 PlLUcBF8wPlV3SqL97V6C4OnS9Z+XrA88UM9c/ZM/Nwho08PSDQ/rrftRwZ9CDtWSG
	 JtyB58yq0Hrcg/SeNRu217/jaQyakwuh7/gIk0AIEYRg5IxDazntccxQb8MdLTR/H/
	 ErXEnui+gE+ZCcQXUlsMW0IzmQG2rln1kDwAyet2oPgSs4PAp3nVk63SJahmwHhAXw
	 GlH004LpK2Jve/e3rINPnswjT9X8RzG+g8FA0ms41opRgOFok0bPA9xXOmLFFLceWO
	 /EW4oX5cI58nkt34MrMAAyoIeg1FDetF0YyecOzvr4EJy2RDqexPitr2LcgIHtAOOf
	 Z+t9Gunjws0cnGppEahUmMrpnt36zO7BFTpg4cBY/nsCEV8JuhGBipgtW13lLlpNjj
	 WzG3DowCqmt+M9xDisJoIlB8=
Date: Fri, 3 May 2024 15:01:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: kernel.org-fo5k2w@ycharbi.fr
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com, netdev@vger.kernel.org,
 debian-kernel@lists.debian.org
References: <8267673cce94022974bcf35b2bf0f6545105d03e@ycharbi.fr>
Subject: Re: Non-functional ixgbe driver between Intel X553 chipset and Cisco
 switch via kernel >=6.1 under Debian
Content-Language: fr
From: kernel.org-fo5k2w@ycharbi.fr
In-Reply-To: <8267673cce94022974bcf35b2bf0f6545105d03e@ycharbi.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	*      author's domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*       valid
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature

Hello,

I have not yet received a reply from you. This problem is blocking many 
users and is a major handicap when using Intel network cards with X553 
chips.

I'm always available to carry out any tests you may consider useful for 
resolving this ixgbe driver bug in Linux kernels > 6.0.

As a reminder, here is the link to my original message:
https://lore.kernel.org/all/8267673cce94022974bcf35b2bf0f6545105d03e@ycharbi.fr/

Best regards.

