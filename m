Return-Path: <netdev+bounces-185719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E5DA9B8A6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E401BA393B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B971D2949F2;
	Thu, 24 Apr 2025 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEzZ5A94"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E62949E1
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524743; cv=none; b=Czy7BElYQQ5aqiW971LjRsDCrSXgd/SF8Y613SwF+HDdlwzZRtfsugri+E1TuBV18lxKmRGcuPpox5TW+9t8wd8Wv1nbfTW49SPniQucNjNzPOWSOvQ4RiK5gQ0layxboaLvb6hyqkyciZdXE+RsgJBMHjDZfK3gtDIUFIi586c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524743; c=relaxed/simple;
	bh=S256UgLsAfrU64+LkzGesSug2ELdCLZJ3BM5GSBy3A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nO3KYd5hK+S5okXSdr6XYGjB/S8UsacCs1XuknAQdne+IJ81jY3bNqU5Nl30CIFlNPohM4AtalQQOYoiywvYSMCPkUHEswlXEO/oYEmFOxNuTg4hlFOB/PkBf2cumNib6eyIUiKiYWZ2XIHa2LxmgpldIf2rtsoxli9vH9/HrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LEzZ5A94; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745524740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBXTdv+sLZhhh3HMrE26Hq7ELTP03d30ZG0+ag31+Z8=;
	b=LEzZ5A94pS9GZxfiNgt+2WbxPobDzvmnE9KlUvS8iiwCNYjUWhC2hrQBVW2hexcgJhWo4s
	Zggvicvyf2g5xHI8NmzkY46bQ6iUTpnlpd+ekfBh5rdEsZ03f75J4Xp9MSMK7wIxscA0rV
	4S9JyzkukbAa9ret+5kBd1cKqnsbrWg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-Il5dtNCfOpy9lrqf63iSaQ-1; Thu,
 24 Apr 2025 15:58:58 -0400
X-MC-Unique: Il5dtNCfOpy9lrqf63iSaQ-1
X-Mimecast-MFC-AGG-ID: Il5dtNCfOpy9lrqf63iSaQ_1745524736
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 877A41956095;
	Thu, 24 Apr 2025 19:58:55 +0000 (UTC)
Received: from [10.44.32.28] (unknown [10.44.32.28])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E3801956095;
	Thu, 24 Apr 2025 19:58:49 +0000 (UTC)
Message-ID: <7d96b3a4-9098-4ffa-be51-4ce5dd64a112@redhat.com>
Date: Thu, 24 Apr 2025 21:58:48 +0200
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
 <458254c7-da05-4b27-870d-08458eb89ba6@redhat.com>
 <98ae9365-423c-4c7e-8b76-dcea3762ce79@lunn.ch>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <98ae9365-423c-4c7e-8b76-dcea3762ce79@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15



On 24. 04. 25 9:29 odp., Andrew Lunn wrote:
>> Yes, PHC (PTP) sub-driver is using mailboxes as well. Gpio as well for some
>> initial configuration.
> 
> O.K, so the mailbox code needs sharing. The question is, where do you
> put it.

This is crucial question... If I put the MB API into DPLL sub-driver
then PTP sub-driver will depend on it. Potential GPIO sub-driver as
well.

There could be some special library module to provide this for
sub-drivers but is this what we want? And if so where to put it?

>>> The mutex needs to be shared, but that could be in the common data
>>> structure.
>>
>> Do you mean that sub-device would access mutexes placed in zl3073x_dev which
>> is parent (mfd) driver structure?
> 
> Yes.

So, some helper functions for taking and releasing lock... The v4
approach uses (will use) one mutex per mailbox type but one mutex for
MB access is also sufficient.

Ivan


