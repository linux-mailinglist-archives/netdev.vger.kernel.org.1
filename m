Return-Path: <netdev+bounces-276570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLdzGRJq1mnIEwgAu9opvQ
	(envelope-from <netdev+bounces-276570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:45:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA33BDD47
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07B7A30221DB
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797222F39B8;
	Wed,  8 Apr 2026 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apP1WAvt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gz0hnVkT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E083BD64B
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659460; cv=none; b=SONSX+CTY/eEYvcBOviUXSBrq5Oe3W7uyQhEF2LXitH3NUmShGQX36vpnQ345b7pmsEvb8c/3ye1OTs7u+eYX+G3MZI4w1AMULRy2u2RZI4HA66h+sYDjfm69FCu79kLd2rVsevoK+KhWXJy07+xFBOjskPMTP/rQGE7rfpuvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659460; c=relaxed/simple;
	bh=JpwLaeGR+4CG8DxSsnhAqtc+mOf5z82prqz1dib3zi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haWN54W35plmXPEyNp7Rog0SGIox4Wxf89bOzsoa40lh4O2hB/Xm/M1tzxn0BBcvsmiKwQNmKNoJC+KpHRHfcO9oyiA6cBiIAlsG/BUzONzowMnio9dkbk3PxwehhdNs2DScz3vHUfiXt5Dw7o3i7uIHCCDYyHmn9OaL2S/c+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apP1WAvt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gz0hnVkT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775659458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pezfrKC7eYGJMuBaqOOteFy8MQajQLtYRWeC0Y5aebs=;
	b=apP1WAvtLZcmzr66ubZhS4undbd7I8FUATRf7mEhBy/Ii6/EFD+sqlGOQA0tECMFLOjOVK
	blQBqY5EPTX4/APEI/CuTtcVHY+TDMIfHxHgd07R8JhiwkVl3EFA5ZvKX9jT3hm+lrjJP0
	6YuJ67DqItvRsmMxOm3/XOH4FeYuKo4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Zd18p8buOtOKniW9yY-tYQ-1; Wed, 08 Apr 2026 10:44:15 -0400
X-MC-Unique: Zd18p8buOtOKniW9yY-tYQ-1
X-Mimecast-MFC-AGG-ID: Zd18p8buOtOKniW9yY-tYQ_1775659455
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1bfbd219so5016866f8f.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775659454; x=1776264254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pezfrKC7eYGJMuBaqOOteFy8MQajQLtYRWeC0Y5aebs=;
        b=gz0hnVkTt8WCp+PuqmCcc12iwOZai0nxAWDpx8BUqdTvqD0ZuWhVWeZnwutpqDqK4s
         30cifoTPEdGdKx5H0/lUk04PICF/F72m7ExN+UVOs+BkT1ywo3cDr2nT1dxeDQY6z/YO
         KbGFqYcA2Fdx+6L+VrDWSQBunbojP4JNLc/ldli86nCLKoXt1eNhEgFK/0J5ghl+uoiK
         mWkpzOSZ7Yt6SVPQ4NrsGeMXRA60k8DFwrHg8ChvtHeDMVDsbXcpRcUk8Z95C1UF1skm
         q2xPrlUlNXaFpwLq4NJzBu8J+4BteyMWR3N/VhuCKKn869nNkje6DtlbpV3Eoq3rPwH7
         03hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659454; x=1776264254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pezfrKC7eYGJMuBaqOOteFy8MQajQLtYRWeC0Y5aebs=;
        b=U/oM1gK69IllShNzMVrhUwrweekh/utgEIfmOJr2/4lzF5Mg3nITuytW80igrY7QN2
         sp6l7Y1+U8NorvEZ1wR5TTCQDQZ0UppDIHpEbJProHX0+fvWGbfgMdO/fqM/XeSCKLLl
         xhPBDEiK4YAoNEhI8tVVipYQXJJVEfSzjHzS6DBVlJVHg2tlet24VxBUa3NG0RyFIFv3
         lvmcIFWkBdrTV/RoGk00edlnDVjQKDGQdU1gkCIlg+gTv0zsEy6naHQvvl4TAeHrY9LR
         eURHDSzoLAO0sZsOxtMATSojV1/Eqex9JWAvpaFYuI2pMyFn27hCSzhZyQBEC5niVTyA
         Uw0g==
X-Forwarded-Encrypted: i=1; AJvYcCUpzyQBw2GBU7lIbb7vFTIgFGlK3SovJG9ydK6PZheF98kgZ9BDwsgA4/mOBiz/JUNOo1hJ7lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BD027EgQtZ7xRBUmxCj7xY5hk/wL3k5BRuhYIVaWESlxaz9n
	+YaMu5P466XuJYT146pfSRM0a8DGxFPGV7DGTY9RNkMUAfhvCvxkca0012nMQzgHSPxq7bXcShM
	Tuu6BsIHjLpubOcDFQWB/f+ASXTx1TWC1spUebtHl7ssYpNKtUaA1uSgf0A==
X-Gm-Gg: AeBDiev5L/pb2yqOjqpy9flZ4MxbGFytI7Tk/RD8zV/Mk20xTVgaDDgjAT+UCBMp5vs
	pR24e3ctoPfXK0q8hlylMhMrkRzchon0yzwP1UZG9wxiK43C1UaPZVpTG8QR3ea7KYbREIgrESf
	scKPlfZS/NaadU/Fu2EcJ/I2OrQyvyUDsw7ixZXD8KSQ1IMd8Ep07GTSxpLi4PY5y/9yMAutTpC
	r3O/rTMNNGc2UycDyvELY4QQQeZuSOgX3y2mszxwpoxn1VITZsJ+KCkl0wv0dU7oEpZph8ysNyg
	1ugTwoRNozoPTWNrwEaUhsSmGlOX91htABsVLgS/p5LrCFKSYahDkgmbZp4a3gIUSwwI+ntlC7w
	HMccpqOSWyfRAT27tVpablPOKgj7Wo19KoqYj8sqzjMF6K8nIjUP5t5PH/Q==
X-Received: by 2002:a5d:64e4:0:b0:43b:8fa4:194d with SMTP id ffacd0b85a97d-43d292855famr30342517f8f.6.1775659454544;
        Wed, 08 Apr 2026 07:44:14 -0700 (PDT)
X-Received: by 2002:a5d:64e4:0:b0:43b:8fa4:194d with SMTP id ffacd0b85a97d-43d292855famr30342478f8f.6.1775659453959;
        Wed, 08 Apr 2026 07:44:13 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a7223sm55239228f8f.5.2026.04.08.07.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 07:44:13 -0700 (PDT)
Message-ID: <2bae0dc2-4035-4fe2-a87e-dc5dae6c7df5@redhat.com>
Date: Wed, 8 Apr 2026 16:44:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/2] i40e: implement basic
 per-queue stats
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <cover.1775648513.git.pabeni@redhat.com>
 <0815f1eb4b60faa653ea703e420395b724d05216.1775648513.git.pabeni@redhat.com>
 <IA3PR11MB89864FAAC7BCD8459A2BCD15E55BA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <IA3PR11MB89864FAAC7BCD8459A2BCD15E55BA@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276570-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Queue-Id: BEFA33BDD47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 2:07 PM, Loktionov, Aleksandr wrote:
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Paolo Abeni
>> Sent: Wednesday, April 8, 2026 1:44 PM
>> To: intel-wired-lan@lists.osuosl.org
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
>> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
>> Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
>> <daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John
>> Fastabend <john.fastabend@gmail.com>; Stanislav Fomichev
>> <sdf@fomichev.me>; netdev@vger.kernel.org
>> Subject: [Intel-wired-lan] [PATCH iwl-next 1/2] i40e: implement basic
>> per-queue stats
>>
>> Only expose the counters currently available (bytes, packets); add
>> account for base stats to deal with ring clear.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e.h      |   7 ++
>>  drivers/net/ethernet/intel/i40e/i40e_main.c | 133
>> ++++++++++++++++++++
>>  2 files changed, 140 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
>> b/drivers/net/ethernet/intel/i40e/i40e.h
>> index dcb50c2e1aa2..fe642c464e9c 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>> @@ -836,16 +836,23 @@ struct i40e_vsi {
>>  	struct i40e_eth_stats eth_stats;
>>  	struct i40e_eth_stats eth_stats_offsets;
>>  	u64 tx_restart;
> 
> ...
> 
>> +static void i40e_zero_tx_ring_stats(struct netdev_queue_stats_tx *tx)
>> {
>> +	tx->bytes = 0;
>> +	tx->packets = 0;
>> +	tx->stop = 0;
>> +	tx->wake = 0;
>> +	tx->hw_drops = 0;
>> +}
>> +
>> +static void i40e_add_tx_ring_stats(struct i40e_ring *tx_ring,
>> +				   struct netdev_queue_stats_tx *tx) {
>> +	u64 bytes, packets;
>> +	unsigned int start;
>> +
>> +	do {
>> +		start = u64_stats_fetch_begin(&tx_ring->syncp);
>> +		bytes = tx_ring->stats.bytes;
>> +		packets = tx_ring->stats.packets;
>> +	} while (u64_stats_fetch_retry(&tx_ring->syncp, start));
>> +
>> +	tx->bytes += bytes;
>> +	tx->packets += packets;
>> +
>> +	tx->stop += tx_ring->tx_stats.tx_stopped;
>> +	tx->wake += tx_ring->tx_stats.restart_queue;
>> +	tx->hw_drops += tx_ring->tx_stats.tx_busy; }
> Why the reads are outside the seqlock region? 
> On 32-bit kernels, unprotected u64 reads can tear IMHO

Currently there is no seqlock on the write side; to keep the series
small I preferred avoid fixing the pre-existing issue. In any case I
think moving stop, wake, hw_drops (and others) under seqlock protection
is an orthogonal change.

/P


