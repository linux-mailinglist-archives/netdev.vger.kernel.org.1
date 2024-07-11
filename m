Return-Path: <netdev+bounces-110835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1625C92E7ED
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 14:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289321C21F38
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7821015B0F0;
	Thu, 11 Jul 2024 12:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633E1459E3;
	Thu, 11 Jul 2024 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699546; cv=none; b=XSZleU4PFEVzUl19X01JqSduDBsWc4iSillTxi4VZoRLCivL0dIqqX2TCAmk9SbznJT8KZSxhScg+1fJK2zWrC9o95FCE0rib1Jd8ACEHU4ZdFh5Nbpd4G4Wr9ZJNmty8/Vc5OxC/tvRa0ZWQV5oppqTCl0q+MenLVqaEfMQhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699546; c=relaxed/simple;
	bh=UEG5oO4aQWYowkNRCgVYBDNTQFSZJ3RG3sBGHi73afE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7TNhlCywbAyRo4p0+1hRoRbnaJno4esfl2n0UgYIzfR4cJgUFtOptnSNOl+MA7Dd3vEfH+mwIea6D4PCC2Gra4exOUdIdyW75CjsIC1MHa4WaIpGFs1UYRFPI7lE9EGCUUp3Bmm/KK8y15JHhBNBDM36WHbIq5scYPZJkj7JIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.148] (port=29942 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sRsLr-0003JI-9K;
	Thu, 11 Jul 2024 14:52:44 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1101.mail.hosting.nic.ru (Exim 5.55)
	with id 1sRsLr-003wUg-2W;
	Thu, 11 Jul 2024 14:52:43 +0300
Message-ID: <74a44b62-def7-4848-9495-caebcc382b5c@ancud.ru>
Date: Thu, 11 Jul 2024 14:52:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] tg3: Remove residual error handling in
 tg3_suspend
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Michael Chan <michael.chan@broadcom.com>
References: <20240709165410.11507-1-kiryushin@ancud.ru>
 <CALs4sv20_K0P_Ach=_kZ1jDZHKXvvcNBxatF9sP0iHRNku2OMQ@mail.gmail.com>
 <c5601e9d-e020-483f-a984-886f1aaf3207@ancud.ru>
 <CALs4sv2mxjHkOB95UysSPKCZ1v8+SJqyxi8cvB0b==3dEakeEw@mail.gmail.com>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <CALs4sv2mxjHkOB95UysSPKCZ1v8+SJqyxi8cvB0b==3dEakeEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

Thank You! It was an outdated tree on my side, what a shame.
Sorry for the confusion.

On 7/11/24 07:02, Pavan Chebbi wrote:
> No, I do see the patch in net-next. (net->net-next merge takes care)
> Please rebase to latest?
>

