Return-Path: <netdev+bounces-79699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B9687AA39
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 16:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B742283B0C
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF444778C;
	Wed, 13 Mar 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSlUNBLb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91641446D6
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342962; cv=none; b=BkfAjQXODKCIWciJFbOE83BLtXkrG9EMkg43c8Nw5xOiJWhXpsH7GHVqUQHzKHl6YUMoS+BpuHd6CU0SXOR/dA8lrVUxxfAvs0c/VAAeKe+1bc2lpKJSHrEWdbUGaphzYrT7Qw5B18sKCknCORsOfLS68nJ0k3DjVkm8FzJOD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342962; c=relaxed/simple;
	bh=wo+8XUVZ6ioK9G4Sp1j0QYOyDvxZDEEvuVlcXX0TV+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maIx0sNF80XB5SxbCtvg+EkJIOL9TUCouLPmJ57B2v2FJnNxKjmK7JXBfHd4eQR/gPyLgMZkuMagzpFBnojroE4DR4xRyX41wRxI7Q3iXqaXRn8TEAOUhaZMCHBYqcUs4Fgo3JDO80y5NT94rVVlnV5IBkhVcl+/0YHs/osG00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSlUNBLb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710342959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zitympJcMqQpZuvfBggEaIHiO0WpMlfnPdF8UjN+huc=;
	b=cSlUNBLbVpjv9sk0YX6pZkD79Ln+kzDRjra3Av6qSYopP+SLIksl/H3EXQOdIgA/RKSFUz
	fg+tI6wvekdLJPbZAmFV04RO0wSbwPAZ6GNb12cNirTHrLK6PRyaayRhMWAp5Os+S7cvDp
	kGp+Z8sv4N/8rpIqpB5MdwD8eyTgYeU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-HkdNa89aMmqpz2KCcnIf3g-1; Wed,
 13 Mar 2024 11:15:54 -0400
X-MC-Unique: HkdNa89aMmqpz2KCcnIf3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FDD43C0C8A1;
	Wed, 13 Mar 2024 15:15:53 +0000 (UTC)
Received: from [10.45.224.236] (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C0D213C23;
	Wed, 13 Mar 2024 15:15:51 +0000 (UTC)
Message-ID: <3f934c7b-867c-4550-93ea-4f567807fa98@redhat.com>
Date: Wed, 13 Mar 2024 16:15:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: Enforce software interrupt during busy-poll
 exit
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, pawel.chmielewski@intel.com,
 aleksandr.loktionov@intel.com, Hugo Ferreira <hferreir@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313125457.19475-1-ivecera@redhat.com>
 <CADEbmW3NQ7SQpccOqTD=p_czpBbOY=41kS7krwx2ZEDmFfcgrg@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CADEbmW3NQ7SQpccOqTD=p_czpBbOY=41kS7krwx2ZEDmFfcgrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1



On 13. 03. 24 14:47, Michal Schmidt wrote:
>> -/* a small macro to shorten up some long lines */
>> -#define INTREG I40E_PFINT_DYN_CTLN
>> +static inline u32 i40e_buildreg_swint(int type)
>> +{
>> +       u32 val;
>> +
>> +       /* 1. Enable the interrupt
>> +        * 2. Do not modify any ITR interval
>> +        * 3. Trigger a SW interrupt specified by type
>> +        */
>> +       val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
>> +             I40E_PFINT_DYN_CTLN_ITR_INDX_MASK | /* set noitr */
>> +             I40E_PFINT_DYN_CTLN_SWINT_TRIG_MASK |
>> +             I40E_PFINT_DYN_CTLN_SW_ITR_INDX_ENA_MASK |
>> +             FIELD_PREP(I40E_PFINT_DYN_CTLN_SW_ITR_INDX_MASK, type);
>> +
>> +       return val;
>> +}
> This function is called only from one place and with a constant
> argument. Does it  really need to be a function, as opposed to a
> constant? Or are you going to add more callers soon?

This can be reused also from i40e_force_wb() but I didn't want to make 
such refactors in this fix. Lets do it later in -next.

Ivan


