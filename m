Return-Path: <netdev+bounces-289398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB1eBRo/DGqqawUAu9opvQ
	(envelope-from <netdev+bounces-289398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:44:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E9057CB25
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2951C30B586A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA50820C461;
	Tue, 19 May 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM5pK93l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lK0Lbkjv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6157C15A85A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186790; cv=none; b=f3lC68hQ96iw+FR+8K/4KtH1h/R7+jBoVWFKsJG660Ir8uupL2gES68GH3rwgrcglnP0/O5+Sxys4iWWsATrTXvVVVqzUyOdj5rt+WLQqvr71T4Aw7guTl9YOy2A4LWSZ9WrJgvkDCboM7TQXnQK/f3X6+iHsZmO9Qo7ZRxU2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186790; c=relaxed/simple;
	bh=4TueB+EmQy42wWDpEnoVJT38DKfByKA2hwBPwpPS9Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRTwaUPEx9Up/fFVHjS1srzRCPiQ+7CqancYuM77JhqFIsb0b0MLjncAWsQZmsrh3OH4OgzINuOFvcsYP1Ks3pjyLtqPO9qpOUaEAwvFzgblINb13LT+rdl3AONgN28tyCNqbNQqdIyFsJRAT6FxtznpCdpc3gHj5JXBZrKOlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM5pK93l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lK0Lbkjv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOTQJ2u1JpaxxG8B+jFf5ppv4eTuJ675o7KtE2qODbY=;
	b=CM5pK93l86rmN3+YlsJEy83pLHSBrsy4yQsA1dGPZqtMEoH6dV0eJiI/SLr1tVCjgEnzms
	rFQMTtXZf4ssPXJG5RJnY7uAnE9aQ6DAKqSwSRysv7pqdLJmqVgogiOXBz96BcxmikkaE4
	kZVN5dthrTixpuE9I/fEnAw2fWbGhHw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-aU2KL2YGPruJA7-YCu4TcA-1; Tue, 19 May 2026 06:33:07 -0400
X-MC-Unique: aU2KL2YGPruJA7-YCu4TcA-1
X-Mimecast-MFC-AGG-ID: aU2KL2YGPruJA7-YCu4TcA_1779186786
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-447f2ce5556so2910936f8f.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779186786; x=1779791586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOTQJ2u1JpaxxG8B+jFf5ppv4eTuJ675o7KtE2qODbY=;
        b=lK0Lbkjv/Rp7X5hxNZKsVSH/dzTJeIXO+1wHZvoWS2rgqXeeSf1Mpq/Q3sS0m/HUOR
         JSNRQ8tkidOdTNUJtO7KceGMb/xuQwaCcFYzxVVVSEAqyseQTNYHKwt9nov9I5j/QH2X
         WEiOKy2fU8LzWi0SHMoLyczcthcaKg7pnK2RbFsUhg+C+S+oL/Qbw4Ife/NAZx7T2MOU
         OyAFc8JQsVCyW7/CtbhkzS7H0yOP9ZCASNm/yrqb/2oc8avhP+/jwR8MbMG/jumaXyM5
         ZwVv/5ofJ4Y2BHHbj2ZH1abmLKKdlf05gZRyLrwBSIHTzVCUUHAfPo8IyoHG1U7G2bpu
         evdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186786; x=1779791586;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOTQJ2u1JpaxxG8B+jFf5ppv4eTuJ675o7KtE2qODbY=;
        b=RRpoZpqxglKJIcYPZnfivkp63vMzDKSBXKsoVl2gIh1acEiNLglxpsmIonHNVBq+e4
         wCbxnsvpJaTtrUkAhL2FNReM2P0MMs/T6tbYdjPuIGkWhOGxJp2k8ZeVFyVwamAYG+Ze
         yAb4SNj5U/3wRRBv1Sc+uV1P85JkpzhTuVTO1GsEX/2dMcfqs+QSTwtjlMEE4o5mUDW5
         QO5ZAonKVdQE7jc33UgoRhSzNQcERfueOo2rKabblAjEeL3SMJsNxgxHT51oCJBGqzFp
         C7nYH+N4GNRSXWxON8AKJ1Zweeg4PIUw0u5L9prSPsJZy9C0Y1Ce4/PyJohXdcpSTfZU
         2zow==
X-Forwarded-Encrypted: i=1; AFNElJ/mUyAnKTMTCBJK0Ki8LtiuWHV3qhwDFtGT5NsjXLIl+El29154LwdUn+lQiSijVSkIizkuK8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MaWR9AvAeLyiDX/Qx7dPNwbY7QXuC/pIRJvR+2NX5sKGc1z6
	sW9/MJNsO91n3jc4ItjOpn5ABVLVaS+Qw76xaBWgGLoMp5Hsy0tiCCGC/dldE/0Futr6PkwH78v
	rVpik9otLY+jyYGM9edf5AQhS4FIP849+VrIe6q7Dibu2ZO1qkLZuo/LkCA==
X-Gm-Gg: Acq92OEHW6G+XYlddvWhqqP6bSOEL+sSqF5nPPI5uAJMxNtRijWBwoP6xBTVoNp66dm
	6xoMVS5HgLpN1jXZv02U3WkVxOar43Znzj61bv6NX24Tm/WmZEsNIon5IUzP4KFgE7FYDLTpOYv
	iFONLgGWip+0jaXQbNC5u4b7glEOm42bnh1WXkMYgVQZkLywj98U//2V++JWtraTXggRSPNcV44
	9lEIdaMCQK/b70jhM2Adp4iWh1DwkGMZ3EhRGF1U0sqjGDzndcRjNdQfCP9fTkdsAFp9fix/vD+
	1wRD1nhG03vubVQaECukTkbC6N0vjw9GJhqF8HXRgE+5GaubABNGZp9/MY3QRTPQhdTpD8xQS0K
	xMOpBVU+kzygLimM0wv63TjqPhzkJN5xwhyWsMeE6m3dO/GLtrjzMIvg=
X-Received: by 2002:a05:6000:2c10:b0:45d:7bf0:e61b with SMTP id ffacd0b85a97d-45e5c5e6af9mr32295859f8f.42.1779186785919;
        Tue, 19 May 2026 03:33:05 -0700 (PDT)
X-Received: by 2002:a05:6000:2c10:b0:45d:7bf0:e61b with SMTP id ffacd0b85a97d-45e5c5e6af9mr32295807f8f.42.1779186785464;
        Tue, 19 May 2026 03:33:05 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm45122579f8f.28.2026.05.19.03.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:33:05 -0700 (PDT)
Message-ID: <5cead28c-d737-4ba8-9ebe-02c555bf3d4d@redhat.com>
Date: Tue, 19 May 2026 12:33:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v43 0/8] eea: Add basic driver framework for
 Alibaba Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>, Dust Li <dust.li@linux.alibaba.com>
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-289398-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 71E9057CB25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/14/26 11:51 AM, Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.

I went over all the sashiko feedback and your replies, and I think
pending concerns are better handled as follow-up as needed.

Thanks,

Paolo


