Return-Path: <netdev+bounces-248548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FC6D0B231
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 17:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96C17300672E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A84E35CBD4;
	Fri,  9 Jan 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s/BekWOL"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFA35CBB6
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975148; cv=none; b=fRklEy667NtVrl92qAyXgbW5jin0lGwtevqC5B7ghSc+H0SF97J1kzAxd5OLYvqocDlm8PzIr3hNHmF1eUhCYHYQkFJXnQSlgPckHyeBu1L5tIH0LZ58/0UF2FUt/LDtEAEAnd9jWqdGLsN1e1Mca2TaPcmzPjzc13mye+h8w44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975148; c=relaxed/simple;
	bh=oBV9OHBf0Dq3/ev8OmQYEkjsWG4QQ65vMOuv6xZEzU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCdErDClYUvVaVCBAJizNQkGqhzftA1DeBUVhzF5/V8X7hR8usIod5MMyD09p7GkGIKKRoJgw5wHPuEFHUA8NvJC7NcYYZsjvp8J4A0yowbEM3QsNuZr9KZwBvMTweI/NKxYyKthyYdHbNBKj2Q2CZvHGLvR3cD/laxV8l1TBN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s/BekWOL; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <67ec1ef6-4148-42d8-a37d-56d089c6d686@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767975143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKUbx/Z1+Yt4q5NGapHD0PxmcD1lDzWGnEJYNLdw6QA=;
	b=s/BekWOLdsRBW/H9lUmDHMUGOMrh2PKQQVgUaBpcXEL5ebGzElBvaFnimjXKayq52OS5sv
	+0dQUR6T0rVlTxwJayh7VGLyCf1VwJ3mrXrfjwv6xe9Go/ZpGuMtNE4eV1NTO9ESXTXrO6
	cbJApz2ahZld+6YGW+MxdytZ4tGZCw0=
Date: Fri, 9 Jan 2026 16:12:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 05/12] dpll: Add notifier chain for dpll events
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
References: <20260108182318.20935-1-ivecera@redhat.com>
 <20260108182318.20935-6-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260108182318.20935-6-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/01/2026 18:23, Ivan Vecera wrote:
> From: Petr Oros <poros@redhat.com>
> 
> Currently, the DPLL subsystem reports events (creation, deletion, changes)
> to userspace via Netlink. However, there is no mechanism for other kernel
> components to be notified of these events directly.
> 
> Add a raw notifier chain to the DPLL core protected by dpll_lock. This
> allows other kernel subsystems or drivers to register callbacks and
> receive notifications when DPLL devices or pins are created, deleted,
> or modified.
> 
> Define the following:
> - Registration helpers: {,un}register_dpll_notifier()
> - Event types: DPLL_DEVICE_CREATED, DPLL_PIN_CREATED, etc.
> - Context structures: dpll_{device,pin}_notifier_info  to pass relevant
>    data to the listeners.
> 
> The notification chain is invoked alongside the existing Netlink event
> generation to ensure in-kernel listeners are kept in sync with the
> subsystem state.
> 
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Petr Oros <poros@redhat.com>

LGTM, Thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

