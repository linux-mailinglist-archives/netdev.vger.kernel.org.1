Return-Path: <netdev+bounces-68072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66AA845BEC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63E6B281EE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293A7626DC;
	Thu,  1 Feb 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOmbRBV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CB4D9E8
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802207; cv=none; b=UdtXUGueZN3G3cFyJ1HF/RFN20bXVIA3BFABozdBy1Dm62dU9cZvfbTkO1zgyXt3qLPzHUlTDacc3CLft4ErbiRv6j4jTVWpLaqgO6ojb+2nulYACmKW/9dP2mPaSeHLMzeM5FWSzw7BeNoUyKTDYeVLkJZ2s5xAcrMo4+QG+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802207; c=relaxed/simple;
	bh=ho8LI3ao7Zlsc+MhLfncwg6v//l99pVLVlAwlP1kXZQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jLDwaYKC0beRcjTeySFz05bphLBl/cKV68mh5RiWKxNiNNC0bhLkJkvW2FXetOEJkr40BfE0fTwYiQbTLM0TOkW+i7cbrnynTgDYCK7bV7d0/9GItIUW/OdX6v1OXc9uqKrt7Ix4OFOMfWWVpwNBXUD2NWHakC59fRT90Ont9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOmbRBV6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fb0c4bb9fso9468095e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 07:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706802203; x=1707407003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2UrnwlOgsItEDKTVLgJCkedsveuSTltHV+AVhMWfwo=;
        b=DOmbRBV6v79fqlb9JnscO30PglvENLfhWFWZ+JrDUxRiEPfQPh74bVbqdcqJvM4UlG
         WV6OMhTnAQCB8pbKidhteBKgfNqbXv7U1iwi++Gh3ArTpz1SBVUZMmzp7tEqbenia0wI
         VYeDmT5TOFV1t9QPfEWHXyF5+js+bySnxQShNSf9RkJ8tAv67Xyyl87K1WEc2qmijEl0
         AO4n4qtiNpARvxBQL8HJqs50CNMN6woZ1L3gFCH0dmLZ+Kb8qhkf0C1/HRAwjNA+nekd
         haWVImeLtiJDDWXszJ0HTvPr9soQuN5onj6LlfPoXPDCCukKn2yKhE03WDEE47nGVwmZ
         /PyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802203; x=1707407003;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2UrnwlOgsItEDKTVLgJCkedsveuSTltHV+AVhMWfwo=;
        b=E+cUmnPM1Eivl2iCtS9k9O8uzhTaiiqHF7ZoKVXm6RMN4qMI4RdOXohJer1oskJ+JO
         Sbr+LQvbfH91g2Q6FLKCX7V3kuKh69lPJl61HKWLXYYMHAhspDf4ED5zgf0bHnGXQphC
         nwxKPkZMrPevF4k6iq2PxTqOOtPpbH8TQGRAfn5/lgWdfGjKm71JglwVnVuL1i63SI1c
         BD0Hf+uWB2WT7dliteV57zPRJX2RW9MjmT1f2CQ/q2a473+g+d+GrSMWcWW7SDP3aqcs
         U2F+Gjv0kXdfLPmxRrAVcy8+A0aZTn4+gRMJMD8R9/5XG3jwAWcxJIzi3iwDYc0DrTbI
         8Tog==
X-Gm-Message-State: AOJu0Ywb7WSBDWnsUrsLIAizbqXrMwMw9Tu8+PywCRPFIyhwUlFATVDN
	QcqZvjwYC/zv8dkqDJaUD2mO/SaBZdqKK2PycgECJATi9OeHZeze
X-Google-Smtp-Source: AGHT+IGwEQbXnJ24dLKwBX9KdAuPoFpCEhwu8WSK1M5x2HdTKaFyDg5C3nBYtavqD107Kr1ecR86Gg==
X-Received: by 2002:a5d:440b:0:b0:33b:182f:eb9d with SMTP id z11-20020a5d440b000000b0033b182feb9dmr1261356wrq.43.1706802203356;
        Thu, 01 Feb 2024 07:43:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWhQorHyBHjSUpH8dxTdPXUf5nO8Z9/mt5FVm88AJruzfba5njDn7SvUjQAgNPuU7tlZqD0U5nA3VizSmFmtAhGM9Ry5S8SuJSInCWFV5UlbgMbv8KnpMdlcRXnteE3NnhGPS4NFlly26oaQtBBnbptkRA=
Received: from [10.95.167.50] (54-240-197-233.amazon.com. [54.240.197.233])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c260c00b0040d87100733sm4683354wma.39.2024.02.01.07.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 07:43:23 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <ee98c944-610a-44a3-a26e-a10c25c12eb8@xen.org>
Date: Thu, 1 Feb 2024 15:43:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH net] xen-netback: properly sync TX responses
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jan Beulich <jbeulich@suse.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Wei Liu <wl@xen.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <980c6c3d-e10e-4459-8565-e8fbde122f00@suse.com>
 <20240131162336.7d3ba09e@kernel.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240131162336.7d3ba09e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/02/2024 00:23, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 14:03:08 +0100 Jan Beulich wrote:
>> Invoking the make_tx_response() / push_tx_responses() pair with no lock
>> held would be acceptable only if all such invocations happened from the
>> same context (NAPI instance or dealloc thread). Since this isn't the
>> case, and since the interface "spec" also doesn't demand that multicast
>> operations may only be performed with no in-flight transmits,
>> MCAST_{ADD,DEL} processing also needs to acquire the response lock
>> around the invocations.
>>
>> To prevent similar mistakes going forward, "downgrade" the present
>> functions to private helpers of just the two remaining ones using them
>> directly, with no forward declarations anymore. This involves renaming
>> what so far was make_tx_response(), for the new function of that name
>> to serve the new (wrapper) purpose.
>>
>> While there,
>> - constify the txp parameters,
>> - correct xenvif_idx_release()'s status parameter's type,
>> - rename {,_}make_tx_response()'s status parameters for consistency with
>>    xenvif_idx_release()'s.
> 
> Hi Paul, is this one on your TODO list to review or should
> we do our best? :)

Sorry for the delay. I'll take a look at this now.

   Paul

