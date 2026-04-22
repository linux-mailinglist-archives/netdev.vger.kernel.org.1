Return-Path: <netdev+bounces-280334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id noWPO9h56GlvKwIAu9opvQ
	(envelope-from <netdev+bounces-280334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68A442F77
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11791305B283
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BE1370D5D;
	Wed, 22 Apr 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx8q9FOo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJJe4WJD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8192370D4D
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776842881; cv=none; b=UCGS1i2nQbwP4QBrjEAqAblx581UZP5V9MDsqcmdwEIlV1i/+DIyZkn9Gv4HQwYgZKRqv2Ta0o09QUSwPRfU/w/+EDZNwBGXA8XZoExpFc1x7AmYD6W1jmNhcOJ3Reb1qZwS/JbO97XSmVaolJalAmuw+kk5cce0cmNgsPfH/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776842881; c=relaxed/simple;
	bh=OsXLT27jVxa+U94eroW3yxehIzcJr3Bfm/wFw65C034=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX89lyUKTZT6z1Hq51F39/7A0MFGASTM/Nf5GmMchIZk7EjJhjZFC9K3aKlDmQiaoj1bMRbT3IDKuK9ZGDb4HQHzkuJ8Z2ULW7YrAT//Rf1xf9J5C47h4hCTmMg+P1kejj2d3efOjVqy6pOmD5wnD1Dd6hY1Pc0osqRllUb7/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lx8q9FOo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJJe4WJD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776842878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yM2hCY1D2zT3y8Cj8cQteL5tmgGd5DdBXcgk1jHmXHI=;
	b=Lx8q9FOoKl5uVCDUC9xP+SZtA1CaitSoErqWhbjh/opN3QSrHBHgHDChjz+YN6spl0e10S
	PzQsPc6nd6h2jF8uf8uha21QseH9ETTWmzR3B6lqZvPKB8Mv/Ea5xSvwdhjZ0nVm+UHvHy
	OJgw7yVNu2OycChhWCIfH5fbYw5lyro=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-pgelQNk9Mo6hgbs5wh3lvw-1; Wed, 22 Apr 2026 03:27:57 -0400
X-MC-Unique: pgelQNk9Mo6hgbs5wh3lvw-1
X-Mimecast-MFC-AGG-ID: pgelQNk9Mo6hgbs5wh3lvw_1776842876
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c76cb2dce57so3071894a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776842876; x=1777447676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yM2hCY1D2zT3y8Cj8cQteL5tmgGd5DdBXcgk1jHmXHI=;
        b=FJJe4WJDX8kaycx0WgMG8ZRueKWxVeiDHlHKtuT3P63j0VSWRjivic/Fu9hLOdM41Y
         EvjCDR/fGWGzaILdSXCwEnNhd+cINhABvOr2d2P843SsZxUfl6mt5IZY+IKg/JjBIgrB
         V1xsYTeZ+/LY4uJjl4BL6wYi0lBnuTAWC5cXgzsd8YEFk01qf/QhexHKv300plJh3OHj
         YbolFS0kIC36/j6TuxZhthtJa1h77qwwt3SylBpGPm96etK0yCsffIikoYdmNPWdlDFE
         j6qTEQzrLKJwKG4jTAaNqdlZ8Ocj6dF2HE2wJVS1D1W6I0EgXOPyNMfn2B5Lmq/uwP2A
         euxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776842876; x=1777447676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yM2hCY1D2zT3y8Cj8cQteL5tmgGd5DdBXcgk1jHmXHI=;
        b=HLeKWJAQPLWbOwREllFJf7Bt473OFPX4Al/Ub5ELsH2DCeHGPSjiw73j1P6h/yubBD
         aDOdKe6r3EB0NACPaSJhKoUyXCwsvwwRftGpatc2Akwd/28pntf0WTD7cOVjGXGSUKs6
         zQqJwTPcCavMN1GR4tNc6DAxogW3OO1pfhZITW1UFzH0BCbchYH0pA1W0NV3gENhsLSY
         Hh0X+E7ahPumVVAeEFuG2XLiDP0lA/QtHIiUdeVblbmh+YKrEI4RNIcsbKDZRZN1mdKW
         NL6l+DU1z31CJuAor7iy2qQefH21VmsFwh/0ALc47dGLxVzy5/io6CSECeWAKLh4nycT
         iqzw==
X-Gm-Message-State: AOJu0Yx33PXHM/gkX9bzE58DNBwh6glddv21AwNjR+g3jmI7aZrV/P8X
	LhMliMrRggldtKWcPhYVaHiKyc745XVpvmrwxfd73nHYWO5lOC2F1oBGS8Cxw5jYrh1W7aIrIy9
	1Qx5VzWK2norLdM9fkUKWvib9QZU0KJJxbQ3YHiWeriocKVm+l9DyeV4mOA==
X-Gm-Gg: AeBDiesCzfVvtbgIDEIbKJ+6TXDzTsjfgRuqMuarhRt4Y3g1shgrM3b/+R/gh74PKnO
	bcK55ffBjLsubP7mZFr30q8ERy7t0ztjZMpZO9O2Pin3gGXHXZhAJm0lthDtCsvrZSCo3XY04r2
	EBRZ24Tg6FIRFL9UdX9zTOXqTcqnW2dUCh+ZmCxdQ3bB0W4+R+Qn8SiXCavK8mpzOx9dO6/HzLW
	ugBXx/NZY7LKulF0Z1LPrzYzNUK8cIHwlQCe9/xvht4wZTf6h/5xhD70j+Wq/HYyX5eL7pWj833
	Yo0698jffXj4gHevOVtOoQKfGF33lf+8cy4PmDSEflh8xo2MC6v+uYiNdzMVzO5N80e9QozmoAP
	9JmcqJzk4KEavYHpAs4tljn/miXe80rzFWMh4Qus/g+QI0Mf9+4ToCv7W2gMOs/1Ynb8=
X-Received: by 2002:a05:6a21:9984:b0:398:837a:7af0 with SMTP id adf61e73a8af0-3a08d8a6589mr23079627637.30.1776842876310;
        Wed, 22 Apr 2026 00:27:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:9984:b0:398:837a:7af0 with SMTP id adf61e73a8af0-3a08d8a6589mr23079596637.30.1776842875806;
        Wed, 22 Apr 2026 00:27:55 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm10813642a12.14.2026.04.22.00.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:27:55 -0700 (PDT)
Message-ID: <27946411-c226-426c-9307-d2cf76b88b1f@redhat.com>
Date: Wed, 22 Apr 2026 09:27:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v8 03/15] net: cache snapshot entries for
 ndo_set_rx_mode_async
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
References: <20260416185712.2155425-1-sdf@fomichev.me>
 <20260416185712.2155425-4-sdf@fomichev.me>
 <1d871492-2da5-44b0-b6fe-860966dff55a@redhat.com>
 <12244c7a-07c5-4d75-98aa-3fe35c149272@redhat.com>
 <aef3wzOywP8_LhCh@devvm17672.vll0.facebook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aef3wzOywP8_LhCh@devvm17672.vll0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280334-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: 4D68A442F77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 12:19 AM, Stanislav Fomichev wrote:
> On 04/21, Paolo Abeni wrote:
>> On 4/21/26 11:52 AM, Paolo Abeni wrote:
>>> On 4/16/26 8:57 PM, Stanislav Fomichev wrote:
>>>> Add a per-device netdev_hw_addr_list cache (rx_mode_addr_cache) that
>>>> allows __hw_addr_list_snapshot() and __hw_addr_list_reconcile() to
>>>> reuse previously allocated entries instead of hitting GFP_ATOMIC on
>>>> every snapshot cycle.
>>>>
>>>> snapshot pops entries from the cache when available, falling back to
>>>> __hw_addr_create(). reconcile splices both snapshot lists back into
>>>> the cache via __hw_addr_splice(). The cache is flushed in
>>>> free_netdev().
>>>>
>>>> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
>>>> (cherry picked from commit ba3ab1832a511f660fdc6231245b14bf610c05bd)
>>>
>>> Are you backporting from 7.2 via time machine??? :-P
>>>
>>>> @@ -611,8 +633,8 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
>>>>  		}
>>>>  	}
>>>>  
>>>> -	__hw_addr_flush(work);
>>>> -	__hw_addr_flush(ref);
>>>> +	__hw_addr_splice(cache, work);
>>>> +	__hw_addr_splice(cache, ref);
>>>
>>> I think here sashiko has a point, with the cache size being unbounded. I
>>> guess syzkaller or the like will find a way to make it grow too much.
>>>
>>> What about hard-limit it to some reasonable value?!?
>>
>> There are a few more remarks from sashiko at the driver level, but
>> AFAICS are all pre-existing issues.
>>
>> I think even the above one it's better handled as a follow-up, so I'm
>> applying the series as-is (I'll just drop the cherry-pick statement above).
> 
> I have a follow-up series to add retries here, but not sure it's the
> right direction. I can send it once net-next opens just to opinions.

I'm not sure how you are going to use retries with cache access?!?
Likely some code could clarify.

I was wondering about a dumb limit for such cache, possibly netns-wide,
possibly with a paired sysctl.

/P


