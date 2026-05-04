Return-Path: <netdev+bounces-283710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGANGTdB+GnCrwIAu9opvQ
	(envelope-from <netdev+bounces-283710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 08:48:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C564A4B8FD3
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 08:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8F2830094C2
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 06:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243D277029;
	Mon,  4 May 2026 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8AjNwPZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353E1A9FAA
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877298; cv=none; b=kP4gI2igy+O3cCGM4JS8utSUvuXMw4kIRqaqUigKQFz3nqMUj7F19HR/ZGj3nx7OyGvk5xPK8kK7izp/U9iWfZzYerQ8wgYfQn+R1bz5zEm0/4/2IgrTeIZMekTrjECM/4rKtQcLTOHOpD5ra2RCeveKeOu9Wn477EY9++qyNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877298; c=relaxed/simple;
	bh=ic1aX0jj54ZLQjKhsxVcQjH4VXYhIu2hTmrCWtI0/1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBRLuHRCkFPRmelNXBcKrpD/ndN5h+r45dvlfWCmkcdahmKo4Csp91zCqulC4cG02eIMv6CW3nEZLcMk2qDWhAWweLUoMdhdpJvJksmFDc3Uvdg9ik/evHPvTqs+QWTcjxWXTJ/v7W2z2Cbg48dbNbO7HXcwWH4ScT3S6I87pQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8AjNwPZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777877296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKNR1Jciwk02pgV7pAphfScCbUV9VSUpffq6LVzlIds=;
	b=C8AjNwPZuHOoDB5wrndM9Zt8ciuirruu2GyE+fngnAtndQc8aI3zqOKm+WLhaWT/R+SQAv
	QOkZjufHUmVqyyRCRVqfEFyjqG7LCT5JF4vxsuppqxK9L3dZoA5/DenhA+UCWAfWGo1toA
	BsWJTKvf9sXjC2H0dVefRbJgbfXQRJs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-vIbFGAssNn-pEtVcHgBhvw-1; Mon,
 04 May 2026 02:48:11 -0400
X-MC-Unique: vIbFGAssNn-pEtVcHgBhvw-1
X-Mimecast-MFC-AGG-ID: vIbFGAssNn-pEtVcHgBhvw_1777877290
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58C2319560A3;
	Mon,  4 May 2026 06:48:10 +0000 (UTC)
Received: from [10.44.48.185] (unknown [10.44.48.185])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30A1519560B6;
	Mon,  4 May 2026 06:48:08 +0000 (UTC)
Message-ID: <a5b6f930-9031-45c8-8bb5-a215b8afb4ee@redhat.com>
Date: Mon, 4 May 2026 08:48:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 1/2] dpll: add ps unit to phase-related
 pin attributes
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Petr Oros <poros@redhat.com>,
 David Ahern <dsahern@kernel.org>
References: <20260503151352.136509-1-ivecera@redhat.com>
 <20260503151352.136509-2-ivecera@redhat.com>
 <20260503153459.388de695@phoenix.local>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260503153459.388de695@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: C564A4B8FD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283710-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 5/4/26 12:34 AM, Stephen Hemminger wrote:
> On Sun,  3 May 2026 17:13:51 +0200
> Ivan Vecera <ivecera@redhat.com> wrote:
> 
>> +/* Phase offset - JSON prints raw sub-ps value, FP prints fractional ps */
>> +#define DPLL_PR_PHASE_OFFSET(tb, attr_id)                                      \
>> +	do {                                                                   \
>> +		if (tb[attr_id]) {                                             \
>> +			__s64 val = mnl_attr_get_sint(tb[attr_id]);            \
>> +			lldiv_t d = lldiv(llabs(val),                          \
>> +					  DPLL_PHASE_OFFSET_DIVIDER);	       \
>> +			print_s64(PRINT_JSON, "phase-offset", NULL, val);      \
>> +			print_string(PRINT_FP, NULL, " phase-offset %s",       \
>> +				     val < 0 ? "-" : "");                      \
>> +			print_s64(PRINT_FP, NULL, "%lld.", d.quot);            \
>> +			print_s64(PRINT_FP, NULL, "%03lld ps", d.rem);         \
>> +		}                                                              \
>> +	} while (0)
>> +
>>   /* Gene
> 
> Any macro this big should be a function
> 
Will fix this and DPLL_PR_MEASURED_FREQUENCY (in the next patch)...

Thanks,
Ivan


