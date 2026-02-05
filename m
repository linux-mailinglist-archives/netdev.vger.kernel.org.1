Return-Path: <netdev+bounces-257138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDbrIaeBhGl/3AMAu9opvQ
	(envelope-from <netdev+bounces-257138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:40:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31265F1F97
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0E4B300614C
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 11:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25483AEF50;
	Thu,  5 Feb 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyIsmjyP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRfThvEV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F873A6411
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291621; cv=none; b=GR2+0qcU0qjQGlmT/GrTe1NQ5Tr2M8ns8tImopdCqpYAfchd1slRctAmubZ8tu57WUOYMyT3CowjWBd3uQI+BuJvUHmdHaUVPBgfrydQSIcBsjkcFffLtSVbUqssK4EOO52rJZU7irvU5TiAlxQxRxsqQFVc365NexAkZwKfD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291621; c=relaxed/simple;
	bh=ujJgyhJ1/5gHWxnQNQrbJV/1ev2WHtN0QVoaYNb7Kns=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ToOWjKGhBywaZ1VsKHfRcT/6nXDxz41D4QHblL798hZaz4KwKCMGKM78i8uNOwm8dYAr0SR4W29zAWRvSUNY2fO2qy0oRduMrn7ubtuRACXoPTuRFrK33/sHV/IuOVKh2cOf/FhfQsUyK7tkxAsfMDWpYvsKLDQ6BPEpDqAjnMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyIsmjyP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRfThvEV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770291620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZGp7wmUh7VtEk8sjLqUKtMDtexQxxk82Pts+Tqc7Jo=;
	b=dyIsmjyPX6/eQ+JPVEiEkJjPmjbsEdXZIdcMVXySp+jFnfazW7QwcwAbMA23zk5VRkK17G
	W/ioVDzVk4NrZPFM034WHv+tyS3LhAj7FgFfh+ISK9cA/twlWhR6oMnlD0zYwsHNBtwcJt
	61qFc6TWq7CJDjdvl/m0Z9SXf7fGVKU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-yrGy-fDGNsaa66mE25RwuA-1; Thu, 05 Feb 2026 06:40:19 -0500
X-MC-Unique: yrGy-fDGNsaa66mE25RwuA-1
X-Mimecast-MFC-AGG-ID: yrGy-fDGNsaa66mE25RwuA_1770291618
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so13482205e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 03:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770291618; x=1770896418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ZGp7wmUh7VtEk8sjLqUKtMDtexQxxk82Pts+Tqc7Jo=;
        b=aRfThvEV1EULdDt6pZfbG+SnBRnFT9ve0nUeKkVvKBToiqKlCu3eFinoTQLGeYga3X
         gkCbdafH6i2/QWqdg1ARg+lDynY3cG7giaHeUjbBivKWMXbvkn8DdxNE2Ct4KHTRMEgl
         tw8aGzKG0o1tZhQ/o5H8Vi92/uJ9NKdzi3Qzp2z/JDJoKdWolg5ZPoBqwBtvnAuklq1J
         AlQxPMg4Z2UsKIqlwi0iQKFfcgwiTHYlT06A61DN4afelkgaZMBRNW/dweBcraYXIDYn
         xbuDliB8AqtIMTskdj4X/JFv55z0SkeECce4Me7p//WbhAg4dnzMSq7O2SCpyfH2PIOW
         Q2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770291618; x=1770896418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZGp7wmUh7VtEk8sjLqUKtMDtexQxxk82Pts+Tqc7Jo=;
        b=L9J01Ipq9BSsAx72w/60Cg0LWirwz6UEV6AHvgoJMAyfhtK2HYj8qHuK27Zf+5S8+8
         Bxyzu8BIq74bLQiKdomjT4cqAtDbhL5a/JrwCnIU50S9uBqvXDohHeJCgvu+c2z6gum/
         ssR4RblPV+0bPT+F+4JRZdypAx4YAJtSmujsIp4UPma1L7dzg4s2aUMqQMNHKaZ/KPwL
         9if1vvGpqPPt/1JpsRo480umNickob3/3m/kEehfWidHh1zrmXhNlU1rFgImsl6xiAql
         CH3Av6FFI4zU8wuwV5uLGKKFUr7p178y9BVD87GjisYMLBaHisei44xBInk8uAD27Mbw
         ofuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX45dFEfsIHLqGdJEkHtaFK6AyyHwdsYFREBmaoH67v8XG0N7he1W3Mb08ZRkD7ysj7adTnR18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGhVUm4FZ+QDu6kpad5VSEcvtjsIktmAfxsp6I6P7jozDIGGgn
	C5xMWh5tGb09B/Tl0oK49ETETUXs+oES/PK+Zr8wtTR76+hSAleY1Fq6hdV8kfNSu1XegX5K1jp
	+v+DKTmkwI4GaB9zhBjlbqCocbuM8M1Jkr5MxQjGTsYclFetMRe9i42AYrA==
X-Gm-Gg: AZuq6aI1wtIuOP/WTrPDerVOJrx07Rla7kGyZhWouHjnqAn/cKnMPiZj+emYVGOu0fZ
	adbZVC7MVGc6C3NdcTxA+kHymh5U3a1uXo9m6dSh49W+e0hG7iWRp6rVQlWPe+nGnO81mHXKmmE
	wIWKEuUKNvx7ifXfpKwo9807QL+nYcGmF8LPQQO4ecip1nJ1C7o8LzpAeFFOFcEiDwPUDi14bki
	gK8u0jv8xca5nIVc5w1De+dbE6h9EWPJLuCYEF26CpwWV7YPUg3yj1nf5TGIaaWADhjup0Jl1vO
	obG3KNWUxyGsM1yekf/i1YjOeVBg+GMZiJYkLfyyVhFftlGn07EcyTZVcZ8hUj+lSQQBGAJGXQF
	fhgzRP/1Q0PEl
X-Received: by 2002:a05:600c:4fd0:b0:47a:9560:ec28 with SMTP id 5b1f17b1804b1-4830e93060bmr87310715e9.13.1770291617989;
        Thu, 05 Feb 2026 03:40:17 -0800 (PST)
X-Received: by 2002:a05:600c:4fd0:b0:47a:9560:ec28 with SMTP id 5b1f17b1804b1-4830e93060bmr87310245e9.13.1770291617532;
        Thu, 05 Feb 2026 03:40:17 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fe62fe7sm64825025e9.4.2026.02.05.03.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 03:40:17 -0800 (PST)
Message-ID: <b8083480-b34c-4066-99c2-1bf1ebac7004@redhat.com>
Date: Thu, 5 Feb 2026 12:40:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ppp: remove ppp->closing check
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260202092116.266568-1-dqfext@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260202092116.266568-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-257138-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31265F1F97
X-Rspamd-Action: no action

On 2/2/26 10:21 AM, Qingfang Deng wrote:
> The ppp->closing flag is used to test if an interface is closing down.
> However, when .ndo_uninit() is called (where ppp->closing is set to 1),
> dev_close() has already brought down the interface, and
> synchronize_net() guarantees that no pending TX/RX in the network path
> can take place. Thus, the check in the network path is unnecessary.
> 
> For file operations - ppp_read(), ppp_write(), and ppp_poll(), can
> normally still send or receive skbs. ppp_read() and ppp_poll() are safe
> because ppp_dev_uninit() sets pf->dead before waking them up, causing
> both to exit cleanly. 

Please report the accurate call sequence that would lead to such syscall
complete cleanly. Also what if ndo_uninit() happens just after the
user-space has been woken-up?

> ppp_write() does not check pf->dead, but
> ppp_push() verifies that ppp->channels list is not empty before sending.
> 
> Remove the ppp->closing check.

This still feel risky to me and it's not clear which would be the
goal/gain. It this change performance oriented? If so please included
actual figures.

Thanks,

Paolo


