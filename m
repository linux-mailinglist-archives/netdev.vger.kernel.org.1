Return-Path: <netdev+bounces-185715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 714DDA9B847
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E71B4663CB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74628E60C;
	Thu, 24 Apr 2025 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSxNkziI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE428DF0D
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522779; cv=none; b=hGOjb04HJQUJmNybDejyBZhBvNU0W0w3v4OydhPLB4LtCzPil1dm3F/qBxxBGZdVsOnNsykQ33q1+WKsIreXtzd06gZo491+UXGtX31kG/hskTbLvUJ3ZvPilyKvcnSYZtMI4KoikRl/PS4CTniiMqwEV40jFoRPMyJ3R6V0f6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522779; c=relaxed/simple;
	bh=bu059oOGZ2b1GzECqaoT83+HulR1dptsnBlbt42RbG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AG0TYNo4NqJELP1D2byMoHqrzlDRfTXfcn0BInz576ktLmN4YpaJsU//N9cAd/TPAqUBUy1U3BmGV2IxZCmujTL1TRKO5s2ZxyZN7qLScI0N1wL3C/BwBdPgUgMwKffNx4iaG/h0Sl+kSniM1qkPIBFjOp9aYB5eWuu46mtLS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSxNkziI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745522774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXxRuxHtNOEgElVP80hKhstwAJQ4wypAH+ISjl66nlw=;
	b=fSxNkziIWrgifLkLhaTETrsdPWzcP5TbPwhT3qfrRLedj/Pr/LhfDB9W7/PJfVMhs3kLbx
	rq8ZnUrrOKtL9BqCOMzYDg/5ZNUo6beAZBilal57k2YxeI1yJRKTtpTWvrhsGgfFWxzjmZ
	VDYeKWLr/krarpWxuKLk7eeNUdw4C2M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-jm5CuxR5NgiLIg5U_j-wPA-1; Thu,
 24 Apr 2025 15:26:11 -0400
X-MC-Unique: jm5CuxR5NgiLIg5U_j-wPA-1
X-Mimecast-MFC-AGG-ID: jm5CuxR5NgiLIg5U_j-wPA_1745522769
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B105D1800877;
	Thu, 24 Apr 2025 19:26:08 +0000 (UTC)
Received: from [10.44.32.28] (unknown [10.44.32.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AA6C19560A3;
	Thu, 24 Apr 2025 19:26:02 +0000 (UTC)
Message-ID: <458254c7-da05-4b27-870d-08458eb89ba6@redhat.com>
Date: Thu, 24 Apr 2025 21:26:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
 <d36c34f8-f67a-40ac-a317-3b4e717724ce@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <d36c34f8-f67a-40ac-a317-3b4e717724ce@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 24. 04. 25 9:10 odp., Andrew Lunn wrote:
>> Each sequence has to be protected by some lock and this lock needs to be
>> placed in MFD. Yes the routines for MB access can be for example in DPLL
>> driver but still the locks have to be inside MFD. So they have to be
>> exposed to sub-devices.
> 
> The point of using MFD was gpio? Does the gpio driver need access to
> the mailboxes? Does any other sub driver other than DPLL need to
> access mailboxes?

Yes, PHC (PTP) sub-driver is using mailboxes as well. Gpio as well for 
some initial configuration.

> The mutex needs to be shared, but that could be in the common data
> structure.

Do you mean that sub-device would access mutexes placed in zl3073x_dev 
which is parent (mfd) driver structure?

Ivan


