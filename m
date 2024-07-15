Return-Path: <netdev+bounces-111518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352D09316B1
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2384281ED0
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D4D18EFC7;
	Mon, 15 Jul 2024 14:28:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D518EA8E;
	Mon, 15 Jul 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053692; cv=none; b=eIuJm9+QpZgLN7fKv+MYTyE47kuiI5yChB+iVm2aspHmewPrdejb6thWgQ60sltchiavTk6G61HpyYHVXz6x6Hu77mT0K3O84eyugP9u81OWxsWOaQunPgSr8ybOLbnzrJobXNGf0zykqXHd+4k1oAKBwcH/Ov7CdmaSGz2TY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053692; c=relaxed/simple;
	bh=KsczNpke6SAAwXus2/gdsp5MkNx6FYnfSKnIbf5q+/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlJAppZagSXTS8XusM93IeqRdI0Y5/97UrghOuxgoyFwRaqg3/L7yLX/ZSLhfUVY0sB7ft4uSC7riLskVGmjAwQ2+CCdcdrZtF4T4LgQhFLy+jzR4Okg6nwSWRPv2uHYUxpZpH2dHlTzDVFKn7mKgbCOejIeiWOpp4ALohbvvIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=50922 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sTMP6-0005qR-AZ;
	Mon, 15 Jul 2024 17:10:12 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1sTMP6-00DCwq-0c;
	Mon, 15 Jul 2024 17:10:12 +0300
Message-ID: <faed05e5-f276-4445-85d0-bfa3d515539a@ancud.ru>
Date: Mon, 15 Jul 2024 17:10:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnx2x: turn off FCoE if storage MAC-address
 setup failed
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240712132915.54710-1-kiryushin@ancud.ru>
 <c9e7ab8a-9ccf-4fea-9711-11cc89e12fc4@lunn.ch>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <c9e7ab8a-9ccf-4fea-9711-11cc89e12fc4@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

> How broken is it when this happens?
I can not say what would happen exactly, if the address is not assigned
the way it should. But there would be at least an attempt to free unallocated
address (in __bnx2x_remove).

> This is called from .probe. So
> returning the error code will fail the probe and the device will not
> be created. Is that a better solution?
To me, it does not seem fatal, that is why I am not returning error,
just print it and disable FCoE. The "rc" set will not be returned (unless
jumped to error handlers, which we are not doing). Would it be better, if
I used some other result variable other than "rc"? The check could be the call,
but than handling would be inside a lock, which I think is a bad idea.

