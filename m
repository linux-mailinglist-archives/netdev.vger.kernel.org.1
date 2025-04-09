Return-Path: <netdev+bounces-180607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E9BA81D4C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193F03B7934
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CC21DF748;
	Wed,  9 Apr 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pc0gd56f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03601D63E8
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180939; cv=none; b=IrN3bESn5i6Q8/1Bbz1UD3kyQAA7GjWfIAtthKVrHQx4FAC+cn1QOaJXM66X0qUd9AhyEp9dkH/DQNccWC4IcImzUfBHSdvLbqD0dZND/0lQ/wrYIzgJ3G8+82/X3McSqeTVlwAJyByk18XpdBUTUGRAvsbaH+5yygm91HwTFrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180939; c=relaxed/simple;
	bh=xQKw0XbFmKGsN+GZ6nIb5nWvMnctlKZfRwk3pF7YWzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/9eilkHkvdtVhePQk0Jebo0vKfk1TNmBz/5jIjA/0DN/h6zvFerZV0qgEkvCc+dANGE/FLdMZfjnXRXzRhqN23QwDq/9i3rCy5P4UXEE/FP0g2b1T3Fl03NDq4ZJR8XxHfdG3XlOMFGHk5eS/H9UCv5lBJlKhW7tTgIOoPUf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pc0gd56f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744180936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXOvHf+rQnYe15TmhKJ+zlI21FPd5oLP8we8fpA0shw=;
	b=Pc0gd56fsidLO3Yjk8zJutwZq2fdjX+5+BxhjFiDsKhH823/pHNFpgf/OPd14xZXoZ6aJK
	XybIPQ7a8m+8Tv26OwxuZZJwWZRT/WsHMTF7gZ8DJf1+LoiXl0eEXIQo2DpKjA5heYHhzQ
	lpe8GWrNKZ5qo+sJ1xo6WwsVhqIjnE0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-m7d0HUV2M7GLY8AnyzUsXg-1; Wed,
 09 Apr 2025 02:42:14 -0400
X-MC-Unique: m7d0HUV2M7GLY8AnyzUsXg-1
X-Mimecast-MFC-AGG-ID: m7d0HUV2M7GLY8AnyzUsXg_1744180932
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C574319560BC;
	Wed,  9 Apr 2025 06:42:11 +0000 (UTC)
Received: from [10.44.32.72] (unknown [10.44.32.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB74D3001D0E;
	Wed,  9 Apr 2025 06:42:07 +0000 (UTC)
Message-ID: <466681f4-22c2-4eae-aa98-ee923c148907@redhat.com>
Date: Wed, 9 Apr 2025 08:42:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/28] mfd: zl3073x: Add register access helpers
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250407172836.1009461-1-ivecera@redhat.com>
 <20250407172836.1009461-4-ivecera@redhat.com>
 <bd028787-4695-4d7b-9000-c725a9ae4106@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <bd028787-4695-4d7b-9000-c725a9ae4106@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07. 04. 25 11:03 odp., Andrew Lunn wrote:
> On Mon, Apr 07, 2025 at 07:28:30PM +0200, Ivan Vecera wrote:
>> Add helpers zl3073x_{read,write}_reg() to access device registers.
>> These functions have to be called with device lock that can be taken
>> by zl3073x_{lock,unlock}() or a caller can use defined guard.
> 
> regmap has locking. It would be good to explain in detail why regmap
> locking is not sufficient.
> 
> 	Andrew
> 
Yes, it is not sufficient. I will describe this in v2 commit description.

Thanks,
Ivan


