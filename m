Return-Path: <netdev+bounces-234580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE64C239F3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AF214F0C87
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F0F2F5498;
	Fri, 31 Oct 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYzpE7nf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CA42F3C1F
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897399; cv=none; b=FhC5z3V++xFXFrJvESYWiLFqduCHQbUOr0++p2+no0w4ePG8RlTqCcAYsro/ZfsiTIemgAFLmxtwHNn3hPJNDXgWOdHhjwzbD05pP6MSKntDH5vXIkYMRWCygTay3unHkd/v6oVqxq2ZPA8TqMxXr4lRuAv0/0xqlRCvslUXJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897399; c=relaxed/simple;
	bh=NlmS59yZKYVIiV8i2noMRb9/j+DV47lqg76W0m9Tq2M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dm+1QzaZw6jJmuCzJyBI+XpdpwFTLzGouOq1nZdcmhX7md8b14h6wOG+/4+j8scjsems8/06ZLT9lgCvqu4lHIn5/8gBs05/LeEF8xpVgf/mvh7v0E39DVbhcyksXgbc6SqxS0cPKRLjsDigSHRlNfPeAau1tcUQIP3+4Ru6+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYzpE7nf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761897397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpMcVCzhIs9r5rhlnH71r26taumjyHLV8vk0HThNmus=;
	b=VYzpE7nfyJVQiBlR5H5KRPpra0J3WIG9JGRUIUCyJ/565C9WJSsM6UOnHp1Djd1jzK1gmz
	PXbimp7+BPwtTS6fw+sfU30XGtJ0OBrTveP6b8U0a49lGNgdVUE9BdIrUwmX3rnDjMIKes
	gN7HjXrq6myiEQPQYngGqA02iCoJU04=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-gr0DsPRFOjaA21HbOh2t1w-1; Fri,
 31 Oct 2025 03:56:31 -0400
X-MC-Unique: gr0DsPRFOjaA21HbOh2t1w-1
X-Mimecast-MFC-AGG-ID: gr0DsPRFOjaA21HbOh2t1w_1761897389
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5F1B1955DB9;
	Fri, 31 Oct 2025 07:56:28 +0000 (UTC)
Received: from [10.45.224.160] (unknown [10.45.224.160])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15FA21800594;
	Fri, 31 Oct 2025 07:56:26 +0000 (UTC)
Message-ID: <c0f06b60-f890-4f0e-b736-3bfe8c54114f@redhat.com>
Date: Fri, 31 Oct 2025 08:56:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] devlink: Add support for 64bit parameters
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@kernel.org>, Petr Oros <poros@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20251030194200.1006201-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20251030194200.1006201-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/30/25 8:42 PM, Ivan Vecera wrote:
> Kernel commit c0ef144695910 ("devlink: Add support for u64 parameters")
> added support for 64bit devlink parameters, add the support for them
> also into devlink utility userspace counterpart.
> 
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Tested on Microchip EDS2 development board...

Prior patch:

root@eds2:~# devlink dev param set i2c/1-0070 name clock_id value 1234 
cmode driverinit
Value type not supported
root@eds2:~#

After patch:

root@eds2:~# devlink dev param set i2c/1-0070 name clock_id value 1234 
cmode driverinit
root@eds2:~#

Ivan


