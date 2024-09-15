Return-Path: <netdev+bounces-128434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB166979849
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC6E1F21614
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CDB1C9DCE;
	Sun, 15 Sep 2024 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhxHNY0z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF161D2F5
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426686; cv=none; b=e1bbZhxKVhTiMd3m+xSKv2k8RJgG650rnDQAqesC4QX9/Z1+t1pmYdr9jxsDcioj/nE/jwuhHgyzA5xHR1UGEvu67hDoypoupo23Zfg50vK5vWnvkrzasg8dmP2ciGaQvvO1dxNc/hQi//cdt/58349+pj6vveOm+0mdYNyFvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426686; c=relaxed/simple;
	bh=leohg1gYS7q5/mCb24NBiRZ06SqyOoj07PHb+0AllmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUsqgiSSoI8z3sMtH3qqmEIvw7Q37MaqZDBS6NvsDuVrm+gfOMW486aEGsU9XO4+5vQcutUUkyfOcZfm6PpOgR2H7LHuyXaxpuYv9QdhdWykwgWye08/7Laa3RmIS3C4CD2kS9luwlqY3mjS8BOJNjYtn1UEn0Luel71NmNX/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhxHNY0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5E1C4CEC3;
	Sun, 15 Sep 2024 18:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726426686;
	bh=leohg1gYS7q5/mCb24NBiRZ06SqyOoj07PHb+0AllmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhxHNY0zAWO59wN98J/nPYBCq1sZL1pkkhBaqP+laFaJaKFFhbPjNxk9zSxCALIhH
	 xqXuSeT1X8f73LXsJuL3nRzeQ2XTYe/smYKONPsnJ+ihbGonJLVxYzXQrkuM2jynQJ
	 Pm99bI8qmGvbEvdDYuNwECfrmikc0dQTy+LkQ+audQJWbk37jFtM4CugQNqj2jtv8w
	 fccOgXG1Gvt0AJRwE4lNEJD6jG8gAsc987SNj06IS3EL2o2t+SGTQ7jbP3hQo8uDzx
	 A9u/hG1KtmvKGwRrr058741fbDh3Fke0kCH1S864e1kp4lnWpEXHZ/56gFz3kMhZKM
	 iXNaaOvSGA6mA==
Date: Sun, 15 Sep 2024 19:58:03 +0100
From: Simon Horman <horms@kernel.org>
To: alexandre.ferrieux@orange.com
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
Message-ID: <20240915185803.GE167971@kernel.org>
References: <c35a227c-6a3d-47c8-95f0-6fd6d41454c5@orange.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c35a227c-6a3d-47c8-95f0-6fd6d41454c5@orange.com>

On Sun, Sep 15, 2024 at 12:34:05AM +0200, alexandre.ferrieux@orange.com wrote:

Hi Alex,

these are good questions, but you will need to post them without the
declaimer below.

> ____________________________________________________________________________________________________________
> Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci.
> 
> This message and its attachments may contain confidential or privileged information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have been modified, changed or falsified.
> Thank you.

