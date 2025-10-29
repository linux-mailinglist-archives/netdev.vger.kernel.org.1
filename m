Return-Path: <netdev+bounces-233807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C66C18C84
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 486E0507E74
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CE311C21;
	Wed, 29 Oct 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/XzqotP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6341311959
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723908; cv=none; b=KYEpJoMW5hQHnl8uxACP7TFK4Biculwrnymwv8HDcNzNuGm2SxrZDgIncNyELetZKpHxohiBvlx99LX4TABdxrcq1ZFwP+JFfGTP3FRE7wFzBv/cnnDtW3AENqgkJaF/lebCoXhWQjSWT0neU3mm4TJ4hNlOXRpnTsSIoyBhIkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723908; c=relaxed/simple;
	bh=BpTz6wyxzgFePsE1XYKQzbSZygBAeSVul/fpXowQG6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wsm8pT9Ou/PM02yQi3sXnqQw36va2LUOceDVdri/U+soVkvMz+LNilNVs4fX2rTgXuelVQN5DxACM6Id4M/TYTWjfEwJPfrn2aRaTtkaGPisQCrJxqPucJOieyxMgqgSp3DG5VltYczIJQXzP6roVSw/SALwNSo2MQMTG0ROmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/XzqotP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761723905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IO9uHdt14tKqgu7NcmSLY4LLxup1JDL8am31B4OZNM=;
	b=Y/XzqotPVTdpfyxPvThhprhLqDuE8RLmm2+FIO2QP+oPmo5TrDtFR/0iM6sAMnWmzsU4DE
	YG9ojBEXhPdv0NrgiBuIdEgNthAVI6i/+x9N5lYrwbWDAX3qSOmMJ2DgqZ6jKcFYi5BEgw
	iqdcS8AicqNc+XNMWRh06/nGqNfGoDs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-U34KAEhUOHixRWxtkPKs-A-1; Wed,
 29 Oct 2025 03:45:02 -0400
X-MC-Unique: U34KAEhUOHixRWxtkPKs-A-1
X-Mimecast-MFC-AGG-ID: U34KAEhUOHixRWxtkPKs-A_1761723900
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8B0E1808972;
	Wed, 29 Oct 2025 07:44:59 +0000 (UTC)
Received: from [10.44.32.34] (unknown [10.44.32.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD6551800579;
	Wed, 29 Oct 2025 07:44:53 +0000 (UTC)
Message-ID: <b3f45ab3-348b-4e3e-95af-5dc16bb1be96@redhat.com>
Date: Wed, 29 Oct 2025 08:44:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dpll: add phase-adjust-gran pin attribute
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251024144927.587097-1-ivecera@redhat.com>
 <20251024144927.587097-2-ivecera@redhat.com>
 <20251028183919.785258a9@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251028183919.785258a9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Kuba,

On 10/29/25 2:39 AM, Jakub Kicinski wrote:
> On Fri, 24 Oct 2025 16:49:26 +0200 Ivan Vecera wrote:
>> +      -
>> +        name: phase-adjust-gran
>> +        type: s32
>> +        doc: |
>> +          Granularity of phase adjustment, in picoseconds. The value of
>> +          phase adjustment must be a multiple of this granularity.
> 
> Do we need this to be signed?
> 
To have it unsigned brings a need to use explicit type casting in the 
core and driver's code. The phase adjustment can be both positive and
negative it has to be signed. The granularity specifies that adjustment
has to be multiple of granularity value so the core checks for zero
remainder (this patch) and the driver converts the given adjustment
value using division by the granularity.

If we would have phase-adjust-gran and corresponding structure fields
defined as u32 then we have to explicitly cast the granularity to s32
because for:

<snip>
s32 phase_adjust, remainder;
u32 phase_gran = 1000;

phase_adjust = 5000;
remainder = phase_adjust % phase_gran;
/* remainder = 0 -> OK for positive adjust */

phase_adjust = -5000;
remainder = phase_adjust % phase_gran;
/* remainder = 296
  * Wrong for negative adjustment because phase_adjust is casted to u32
  * prior division -> 2^32 - 5000 = 4294962296.
  * 4294962296 % 1000 = 296
  */

  remainder = phase_adjust % (s32)phase_gran;
  /* remainder = 0
   * Now OK because phase_adjust remains to be s32
   */
</snip>

Similarly for division in the driver code if the granularity would be
u32.

So I have proposed phase adjustment granularity to be s32 to avoid these
explicit type castings and potential bugs in drivers.

Thanks,
Ivan


