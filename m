Return-Path: <netdev+bounces-239115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3896CC64479
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7695D382913
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3512A32E73B;
	Mon, 17 Nov 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="odLFDO+E"
X-Original-To: netdev@vger.kernel.org
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53691367;
	Mon, 17 Nov 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383859; cv=none; b=fExCR11RhQa3k9JcRmmRcausWEZ3pgBEtMAwO+7q59EdYgQLg4yQdzbcqAcPBPFPcCBSCl0WwUmGCzG53bp9khbY1/WTbG1fWRf+0j3LZkoFy0kmL+7CZDVE0H8GYia6wtmp3yeZPr8RGIzJ3snlGJtRu1x2iZXw5va3yPjfGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383859; c=relaxed/simple;
	bh=HVE2+1GS1j9WF6hoQ0fkIetyp7tgoJZGuLeD1CUsztI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OKssCdwEA5y9hgWhuPfO4PvCi5cnnlmiPNfKp03t4yJVcDLfmwNgNEvV1OyXJM7eKdb+KydUz1TvPr+qLCSSMvVnVqG85PEUlnZKJBsniKDj3ftqoAT6Fp/CxQg9th0+yU2iWqPCepPbbjD9abwPyHO2ro5GxUv5HkPb7LcEN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=odLFDO+E; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bcae:0:640:cb8d:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 6A6AE80BAA;
	Mon, 17 Nov 2025 15:44:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qiT0cq9L5eA0-CBVAMfSB;
	Mon, 17 Nov 2025 15:44:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1763383494; bh=HVE2+1GS1j9WF6hoQ0fkIetyp7tgoJZGuLeD1CUsztI=;
	h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
	b=odLFDO+ELaTmuQ0z8QbjrsPHcXRAhyfXoQogvS+UhRf7jbaLiYnrxvdhKnkDigRa/
	 fMuIZUbmMCpLIR2PU0AV5AyPcoHGyf4BJoCUAVRmGRfn8qEmNozQXZvFEqPStL+uoN
	 x9toPB5Sw3j4SIPQQ+M156IbSgRlPVj1j6v9SiOo=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <45655b89-14db-4cae-b92f-118b7cbd8586@ya.ru>
Date: Mon, 17 Nov 2025 15:44:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cdc_ncm doesn't detect link unless ethtool is run (ASIX AX88179B)
To: Oliver Neukum <oneukum@suse.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1c3f0582-4c92-41b3-a3db-5158661d4e1a@ya.ru>
 <701e5678-a992-45be-9be3-df68dfe14705@suse.com>
Content-Language: en-US
From: WGH <da-wgh@ya.ru>
In-Reply-To: <701e5678-a992-45be-9be3-df68dfe14705@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/25 15:33, Oliver Neukum wrote:
> On 15.11.25 09:58, WGH wrote:
>> Hello.
>>
>> I'm running Linux 6.17.7, and recently obtained a UGREEN 6 in 1 hub containing an AX88179B chip.
>>
>> By default, it uses the generic cdc_ncm driver, and it works mostly okay.
>>
>> The annoying problem I have is that most of the time the kernel doesn't notice that the link is up. ip link reports NO-CARRIER, network management daemon doesn't configure the interface, and so on.
>
> Hi,
>
> that strongly points to a race condition.
> Could you try the attached diagnostic patch?
>
>     Regards
>         Oliver

Nope, this patch doesn't help.


