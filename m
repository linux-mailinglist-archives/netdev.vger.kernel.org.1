Return-Path: <netdev+bounces-77670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3026A87291A
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 22:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FCC1F21950
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973712AAE3;
	Tue,  5 Mar 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6sROfdW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6D12AAE2
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709672850; cv=none; b=Kn6iIR6Vuo2Ocz5nsU/ZfZWfpcCDY1kYajuayRGoj3Dr+p0y7KgUHkmtPVFvoR9y+VANhwIA40n6UCz3FofuADrpnP7ee3u551/KNE7So+3GQrTvLFZ1iwHZHd5U8/SSmBctw0StKjX1VS6UBSZ/EjeUFmCnI/P55SQTRlLlcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709672850; c=relaxed/simple;
	bh=6D6/pQSYLZ1B+97LcA7kiWq0kqxPqiK30zZY7Nj2Fqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3Lb+GoXgt4QcNkqZG9rBMxjMZm259LF4lx95uA89CWH7rgYxEdehx0yRAN65iHKyJw8rcUfz8uddNxFcpd19Hqsk4XPVG/aE1oScznLt4wINH45V6wpqqzCwdO1ZqzaipNvljHHmjdiJGtgxgmnky4uQj53QKc6ldjgs/cS71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6sROfdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F00C43390;
	Tue,  5 Mar 2024 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709672849;
	bh=6D6/pQSYLZ1B+97LcA7kiWq0kqxPqiK30zZY7Nj2Fqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R6sROfdW+CLvO6sHW3Z4G5+SwvDzdYnYlJtmqYhWbyNvcuWwYI2YY2NVZgAJmonxv
	 uwqEh2ojnI+Ip6jEnAoExWOF373KJiU4goVO+9D22goJ+vvcR54b9qM90Ql6RAzWor
	 iJnLVk2Ofpr/a4w/Ry4/Pqs9E2gSkcthN5wPxmJPaoYwtyVoDNPmvz1Quf9AQ4CrVx
	 tpnaHun1q81rgZo0FXcP38xw48Iv9cGsnfP2HdHNUxaW3fmt1FYRpiJN+X0oEzJcTI
	 8apsWaBpdGgs20YHFKImdtgMrEBCR3N/me32ZMrPXA/AZShayESZ9ZW7rs26uzAShR
	 zW0NcbKaAfJfA==
Date: Tue, 5 Mar 2024 13:07:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maarten <maarten@rmail.be>
Cc: netdev@vger.kernel.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Phil Elwell
 <phil@raspberrypi.com>
Subject: Re: [PATCH] net: bcmgenet: Reset RBUF on first open
Message-ID: <20240305130728.5d879a7e@kernel.org>
In-Reply-To: <45ba80640e989541e142c32fb3520589@rmail.be>
References: <20240224000025.2078580-1-maarten@rmail.be>
	<bc73b1e2-d99d-4ac2-9ae0-a55a8b271747@broadcom.com>
	<f189f3c9-0ea7-4863-aba7-1c7d0fe11ee2@gmail.com>
	<20240305071321.4f522fe8@kernel.org>
	<45ba80640e989541e142c32fb3520589@rmail.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Mar 2024 21:36:03 +0100 Maarten wrote:
> > The patch has minor formatting issues (using spaces to indent).
> > Once you've gain sufficient confidence that it doesn't cause issues -
> > please mend that and repost.  
> 
> I'm sorry, it was blatantly obvious and I missed it :-( . I had added 
> indent-with-non-tab to git core.whitespace , but it seems to only error 
> when a full 8 spaces are present in indentation. By any chance, is there 
> something to test this? In the main time, I'll do a git show -p --raw | 
> hexdump -C to check this .
> 
> I've fixed that on my git (and fixed some similar issues in other 
> patches) and will resend.

I'd rather you waited with the resend until Doug or Florian confirms
the change is okay. No point having the patch rot in patchwork until
then.

