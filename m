Return-Path: <netdev+bounces-251566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBPZKDrQb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:58:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFFB49E81
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C74B6A274D1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274034A783;
	Tue, 20 Jan 2026 16:54:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ABF34A3A5;
	Tue, 20 Jan 2026 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928099; cv=none; b=MVBsOMCByYUg6T2Qop8OfTzytUKj6Oy4KzKroBfwUucEYTK9q+khdvJ7TIDeA+715FyoZZOvZOn+jXvMVyDxFDh58UkXF7hUY8hWKFv3fw93FCP78A1i9T9CWu7LsXhZHvUBukAZ/HlpBSaZZKS2jMwP5fBqxdZTkFEy2raYCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928099; c=relaxed/simple;
	bh=xqbU3Irav68Y/Fc1lqz+UJGia7VxTLtZA/7j+X6Gllw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B24CCxLs5z4Vx/6gxQFQqHl5VPbMIr44E+gOdfUVwaH9Ehs+7XdiG099ibjx5VtktqlfRJ5+GOiDORzS+FL7eP6OiZZt256R+dI7Fl/dJhN/DakectRyKjM10tbSRPz1l7/QG+YTHZAYtHKfj0gbtVl60dA/xnZbY1RSaa166dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C68E04C2887191;
	Tue, 20 Jan 2026 17:54:22 +0100 (CET)
Message-ID: <56bbd1d8-4ea7-41b9-beac-2e496bf81206@molgen.mpg.de>
Date: Tue, 20 Jan 2026 17:54:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: Fix data race in idpf_net_dim
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
 Phani Burra <phani.r.burra@intel.com>, Willem de Bruijn
 <willemb@google.com>, Alan Brady <alan.brady@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Joshua Hay <joshua.a.hay@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20260119162720.1463859-1-mmyangfl@gmail.com>
 <8cfba7ca-03d0-46fe-92fa-5d4a119fc31e@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <8cfba7ca-03d0-46fe-92fa-5d4a119fc31e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251566-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: 0DFFB49E81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[Cc: Remove bouncing alan.brady@intel.com and pavan.kumar.linga@intel.com]

Am 20.01.26 um 17:50 schrieb Paul Menzel:
> Dear David,
> 
> 
> Thank you for your patch.
> 
> Am 19.01.26 um 17:27 schrieb David Yang:
>> In idpf_net_dim(), some statistics protected by u64_stats_sync, are read
>> and accumulated in ignorance of possible u64_stats_fetch_retry() events.
>> The correct way to copy statistics is already illustrated by
>> idpf_add_queue_stats(). Fix this by reading them into temporary variables
>> first.
> 
> It’d be great if you also documented a test case.
> 
>> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
>> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
>> Signed-off-by: David Yang <mmyangfl@gmail.com>
>> ---
>>   drivers/net/ethernet/intel/idpf/idpf_txrx.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> index 97a5fe766b6b..66ba645e8b90 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> @@ -3956,7 +3956,7 @@ static void idpf_update_dim_sample(struct idpf_q_vector *q_vector,
>>   static void idpf_net_dim(struct idpf_q_vector *q_vector)
>>   {
>>       struct dim_sample dim_sample = { };
>> -    u64 packets, bytes;
>> +    u64 packets, bytes, pkts, bts;
> 
> The new variable names are ambiguous. Would _tmp or so be better?
> 
>>       u32 i;
>>       if (!IDPF_ITR_IS_DYNAMIC(q_vector->tx_intr_mode))
>> @@ -3968,9 +3968,12 @@ static void idpf_net_dim(struct idpf_q_vector *q_vector)
>>           do {
>>               start = u64_stats_fetch_begin(&txq->stats_sync);
>> -            packets += u64_stats_read(&txq->q_stats.packets);
>> -            bytes += u64_stats_read(&txq->q_stats.bytes);
>> +            pkts = u64_stats_read(&txq->q_stats.packets);
>> +            bts = u64_stats_read(&txq->q_stats.bytes);
>>           } while (u64_stats_fetch_retry(&txq->stats_sync, start));
>> +
>> +        packets += pkts;
>> +        bytes += bts;
>>       }
>>       idpf_update_dim_sample(q_vector, &dim_sample, &q_vector->tx_dim,
>> @@ -3987,9 +3990,12 @@ static void idpf_net_dim(struct idpf_q_vector *q_vector)
>>           do {
>>               start = u64_stats_fetch_begin(&rxq->stats_sync);
>> -            packets += u64_stats_read(&rxq->q_stats.packets);
>> -            bytes += u64_stats_read(&rxq->q_stats.bytes);
>> +            pkts = u64_stats_read(&rxq->q_stats.packets);
>> +            bts = u64_stats_read(&rxq->q_stats.bytes);
>>           } while (u64_stats_fetch_retry(&rxq->stats_sync, start));
>> +
>> +        packets += pkts;
>> +        bytes += bts;
>>       }
>>       idpf_update_dim_sample(q_vector, &dim_sample, &q_vector->rx_dim,
> 
> 
> Kind regards,
> 
> Paul

