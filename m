Return-Path: <netdev+bounces-305413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5ZKGJFbdTGqOrAEAu9opvQ
	(envelope-from <netdev+bounces-305413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:04:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B43471AC2D
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:04:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=en4uQpc3;
	dkim=pass header.d=redhat.com header.s=google header.b=d5rOWwEz;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305413-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305413-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD57C306CC44
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5C3F44F9;
	Tue,  7 Jul 2026 10:59:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C63AE6F3
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 10:59:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421994; cv=none; b=sRWu1FvuLoelcA4hRiKl8QvBAe+F4G+cocL2bJOQRaQ44EQ0hE1qAybHMybrsm6Fcyi8PLykHUwYVK3/52Vrh+MlU7ByYVNbdV8NPL3WhVPCUIzhkZaWIU/8QACR29g47C8ECmG7/7lT3eIGg0a5QfI+7FcxPtFv10g2ol9AeWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421994; c=relaxed/simple;
	bh=57nlmS3czWktRztgmPKDUccMTAH8kQqCnaRwmEcm/SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVs5P0ftBCYtOXh8UpCQR1f07PhsPA91di72Kz9YJ0dE+JfBSTVJlkqU045S43GAx/GFRU8AqaBUiwuGaJhc6miZza8k9+74xDE/46la2km5DI30sxuXQB2UfKURJC32Vph9FMAyUULp/HcsDd8PnblgaURFfWE018B3ubNcYv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=en4uQpc3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5rOWwEz; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783421991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KG6dF7uTNI7G+jE/O/3fAI9JePYHU7L+4iIKuiT9JOc=;
	b=en4uQpc3kI997U6o5z40J/1IVitt6G/XJEWQY0dOKZxUPPvMqomjxfJhSTIlCYdDKXsRm0
	iTdBeJPXCrVF0lcsQpbDDrmWJ05pdBP2/QXaUJg8XPdtRH8ZB9ipWUCFyJsWEpcKqZPBfq
	PFcOmOg/xxZNqrhkiD02GDZgiB0Ogo0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-i0lwC9iFNQ6EIV1LPcyOLQ-1; Tue, 07 Jul 2026 06:59:50 -0400
X-MC-Unique: i0lwC9iFNQ6EIV1LPcyOLQ-1
X-Mimecast-MFC-AGG-ID: i0lwC9iFNQ6EIV1LPcyOLQ_1783421989
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4784d0fb9cfso2136264f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783421989; x=1784026789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KG6dF7uTNI7G+jE/O/3fAI9JePYHU7L+4iIKuiT9JOc=;
        b=d5rOWwEznejX4EV2pQqvJTqC16adqtiCxjjRjrRFg8s9jONDvzUjVvHc8HGOLkxb0o
         d5i4j5kJeSL/nnN1w2brsWzK1LmSN7JxfhcgJRSQa0VgnbjiXCKf6Wel7ykL2lWZ/Czl
         uKSBIyUhBIsAhFdqbAnh0qSaw3pUCHHRM+QUXso7oisw3G9iiy9fbHBMqPx0f4BGEwWH
         Iy08UMuzi3Qq5qhlBFbGoml6zWHk61tUDbCay5ObsturwP1kM4VNgBRrnncO8dhdjGBd
         DnRmSPRlUQjaTncInfCJ2BEwdEuskENIkW4279nGWmpzS/dWJRUBYv1kt53A+fUTjYNF
         KdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783421989; x=1784026789;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KG6dF7uTNI7G+jE/O/3fAI9JePYHU7L+4iIKuiT9JOc=;
        b=nKniLvvZIrpI07+xSaNJ/gAxTXqlnfm2hU+XF6IwtwwA7+wVhe/5ACRE3Y5GozlPWh
         goQ2FyxplN79i5D9d52KevZc4a/s9vXI95i9kLVMQfxEvxktnqhbbPw5TJvgzcFqUumw
         ejKjgqCVMqJP50hhTyrjt92zzf7lEbXAVCFquZP6kWF1J3DoiQWT2o9ajtpm8OLILyWb
         ew8NrD8UlN28F6XxW8UNK9WxbE/MiAoltV+eNyRTACTK7ohMBmoHwbgiDLbF8BwfWATe
         vbH+fwvOtEu9mfCrRnuDWyJgteCX9kaVqg+wkIZIM/5lq7yyd78JwcLemopQfVVc44sq
         B96A==
X-Forwarded-Encrypted: i=1; AHgh+RrRB09CY7fdOM7RJR7IE6p5/uPZZH1MBQ4BtXpScxooGno1lPqK3RoFSbEj5s2bw0jrEbpWlLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfk26nRqw0LSK13lqQzt3ixbGpeuMb+Jz3OaEkLPbqLn6Q8t4z
	Tp3OIdfXI6uUes2wtvrBXh9lP/BpwVlYx70qWCzjPEJ0k6i/JKXeVgSiZs5loxg+GGVjohiMcQD
	VqZ2lVKqal5kItBr05lgstDADrh2fBnFlFIoqOBH3s6jyCtduwi/dP5PHMw==
X-Gm-Gg: AfdE7clUwZZDJhkdSCn40bsiTZbRxNzD0RQ/49B2mSXuYUY1hrlNiThWv4GO81eXcfp
	GGla05DuNse3AIml9CsjyoPnkApq7u4JAtXd8XSydfmUgMeMs8v2DpkgaBexKvyUkgebdIGEYdI
	CB/a8NcQMjKINRMSiAZM7zUmUyyUxeN58Lv2/cN4RsCBJgiBYSF1nt8NdEPhFdIJGrH0BezNTYi
	GDUfUiusDrFR2wLlTofaBnqDBghDi9e7UiGopQQsAVRx6Ej6JP02oOjVZwku3j3vdmY4/lLSYMB
	bbsERc/Tkq7V44mvELqi/v9GMHr4UjOb1SJ0nh4uH9zmKY3sCYlMJmXYqqyxSGzElqW+GUfk0HL
	A+6mDlFQenaQCFpinK9D5XdM8RDEBV2ySXOnGo4bD9NZLarmkraIDr2td3s7ZZN/TvMGSxf0UjP
	HzNaKmzezW44HN
X-Received: by 2002:a5d:4384:0:b0:472:55a:ef8b with SMTP id ffacd0b85a97d-47de66d3b8bmr4233807f8f.16.1783421988906;
        Tue, 07 Jul 2026 03:59:48 -0700 (PDT)
X-Received: by 2002:a5d:4384:0:b0:472:55a:ef8b with SMTP id ffacd0b85a97d-47de66d3b8bmr4233771f8f.16.1783421988442;
        Tue, 07 Jul 2026 03:59:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm32101388f8f.14.2026.07.07.03.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 03:59:47 -0700 (PDT)
Message-ID: <93f8ae24-f87d-49e9-b33d-decb18484e98@redhat.com>
Date: Tue, 7 Jul 2026 12:59:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/7] pull request: sfc 2026-07-01
To: alejandro.lucero-palau@amd.com, netdev@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701113805.14072-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305413-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:dave.jiang@intel.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B43471AC2D

On 7/1/26 1:37 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Dear net maintainers,
> 
> here are the last CXL core changes for enabling CXL Type2 drivers to
> initialize a CXL-capable device plus the netdev sfc driver changes using
> this new CXL core Type2 support.
> 
> Please pull or let me know of any problem!

Process note: this is 'net-next' material (as opposed to 'net'); the
target tree should be reported in each patch subj prefix.

/P


