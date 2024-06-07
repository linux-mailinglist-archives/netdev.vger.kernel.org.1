Return-Path: <netdev+bounces-101878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65079005C2
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D24284493
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6A194A60;
	Fri,  7 Jun 2024 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="MISbF8Bt"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195C1667DE
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768624; cv=none; b=gXtfbtCkwvGd3EA+Y2WfWNROJTn+rtmbFXk7ZiLTRctx1ZbttupTyViXic4YTb4O+WegAbws+bALmcXjR23VfSIdsgjwmIN7Mz7H0ahY2ei5Bxin2ZUpvqIln7waUkl0PEoFBKlKmzYnVK16hCvubBrMMxnkqNtfr0pKSAQweYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768624; c=relaxed/simple;
	bh=JujG1IjAVzM77t601Y08rMwNJgRYeWgvPpHigPv7XRk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MjfLSA6zBGNotHHWZWtpXV3dImoDKQFxjDJb8p6r/EDJJvd2jn7/8YfMnQJhmLBnJfz/CCoHlAPENcEWrA76neU9t8jznmBM55Z5Y6AOY/vBDF0FV5K4vx2z13vHeW1SIhSOiW/N4YiyTXW3Pv87TPs0c5DAzJjt6JiJnqwZIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=MISbF8Bt; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E2D989C42F3;
	Fri,  7 Jun 2024 09:56:58 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id xwExqFRXAMud; Fri,  7 Jun 2024 09:56:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 610049C57AA;
	Fri,  7 Jun 2024 09:56:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 610049C57AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717768618; bh=ngruN3mXLwK6FGpje9WZVM0gmy/m5ISvQ+DwJj7ptxQ=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=MISbF8BtoMvO5s1ps6TMdaj5irb2jsNCzaW7eK7pW+TJE1b0tveyFQr2h9E/9AQzT
	 vyxNPjkXWaSIEfczjszvvuVWgDgrTo6in6vGFE6bygnqYPtftW7p1kVPpnHXoF6zfY
	 HyVwSlM7IOgxm5fTf9k3Kgq/cfnHdiypwC30cBMEqrhyJ0cbEzKNpsEhiiLJcFwUbk
	 a6+QiwQ5+IlPK//weVP78MbCMna/KssuZ3HB8F7ndzx0swLtCtLzXG6iz7TBlH/5Pt
	 cjnFpo/mNURBZjMd4GhCZRKaZdGY58nTYDbeGJMyxsB+71qCoJmGavfXwO5JRheZ8b
	 PmyFqvDG9v9WQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MbOGRdOt0E9Q; Fri,  7 Jun 2024 09:56:58 -0400 (EDT)
Received: from [192.168.216.123] (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D64EC9C42F3;
	Fri,  7 Jun 2024 09:56:57 -0400 (EDT)
Message-ID: <21cd1015-dae8-414e-84d3-a250247a0b51@savoirfairelinux.com>
Date: Fri, 7 Jun 2024 15:56:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: woojung huh <woojung.huh@microchip.com>, netdev <netdev@vger.kernel.org>
Cc: UNGLinuxDriver <UNGLinuxDriver@microchip.com>
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: KSZ9897 RMII ports support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello, this is a follow up to:

https://lore.kernel.org/netdev/BL0PR11MB2913BABB130DAB1E768810EFE7FB2@BL0PR11MB2913.namprd11.prod.outlook.com/

I have submitted patches to support the KSZ9897 RMII port (GMAC6) 
connected to an i.MX6ULL (See above discussion). The current patch 
implements a pseudo PHY-ID because the one emitted by KSZ9897R collides 
with KSZ8081.

Are there other ways to support this RMII connection that we want to 
explore?

Best Regards,

Enguerrand de Ribaucourt

