Return-Path: <netdev+bounces-121963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0B95F641
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A81C28278E
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5B194139;
	Mon, 26 Aug 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O1qvXrow"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD244374;
	Mon, 26 Aug 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689022; cv=none; b=satYa1qzMccJYeQIMYMKFWKEW1qOByUV2tACkTSJwSBAVaVGcKO4SuGMCVUK7QXFjxFfiwxywIYVEZoMw8qvw99ECetehJpFZY+P/kIztYM94mimMB0oijfls+TWkLh6NZYeYjLxVa9TYvbteGNQMR+ZQP2OkMSF1AK88Lco2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689022; c=relaxed/simple;
	bh=r/Y1mfScW9UcQbiPaDA37XL4lBiWZnftoXaKnR1sy4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMihJFmsOcWk4eakH6Q4BLDU1REnlTHo6k1GcHRGOihVkG8d3pYhBB7yUTtsetoS+bbyyCJo4nND16VzmBCCYCrCh8BTfcT6p4ilKumoXTaGhHsB4cUMLgbGEKCcgu+cK5AIaX/sYguXGuzB9Ia1pJpT4wEGKVO5FHd4fPoNVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O1qvXrow; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D21EE1C0004;
	Mon, 26 Aug 2024 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724689013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hK8ZLclc1jMdr3Pd0ZxN4ypyAtL2rWb7tLyHxbrERAU=;
	b=O1qvXrowUMp156WbWlhQfXQQn4ikT936Sj3mKQVoKz4Qe+geU48L95VvCiRKZqHEpEHGg9
	B+je9keGRJvKOYLC0+prZlt11vVrRPTrdMhgv2iBoHNzhaD5V/tkUll7z2TeRLmUwI/zbQ
	KtRBEW+MRJb/wZLYbE/R7DdyLlUEBPtLJkROQlUW9vMRlWNf60SUpG6KfSw4xwAo29cAg8
	1dzpz9HJq1/nU0MeNPQ1cpm3//pMcnrw1AKv5LHk3PrfIQr8ETvwvHARtObZ8HvDRReyD9
	5C7P9KWWTQroB9eH9v159/Y5//qo61aH0uqhqn1OV5PO0ez2gtHFwDUw8GuJuw==
Date: Mon, 26 Aug 2024 18:16:50 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 syzbot+c641161e97237326ea74@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch net-next v2] net: fix unreleased lock in cable test
Message-ID: <20240826181650.46a8fda8@fedora-3.home>
In-Reply-To: <20240826134656.94892-1-djahchankoike@gmail.com>
References: <20240826121435.88756-1-djahchankoike@gmail.com>
	<20240826134656.94892-1-djahchankoike@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

Thanks for addressing this, I was unavailable in the past hours to
quicky respond to the issue so your help is welcome :)

On Mon, 26 Aug 2024 10:45:46 -0300
Diogo Jahchan Koike <djahchankoike@gmail.com> wrote:

> fix an unreleased lock in out_dev_put path by removing the (now)
> unnecessary path.
> 
> Reported-by: syzbot+c641161e97237326ea74@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c641161e97237326ea74
> Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

