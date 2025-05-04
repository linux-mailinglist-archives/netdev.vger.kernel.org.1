Return-Path: <netdev+bounces-187653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C82AA88F2
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764E53AA2DF
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B4B1E3DF4;
	Sun,  4 May 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fmbgsLyY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DBC1AAE13
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746383118; cv=none; b=K3lFGYZkkINduV0d85z9ZBnuNATGxcP4lI+itYcpvcBlNBHCbkTT3ra2/80fZXP4PXlghmn4YY9WnCPGZ1AxqcgXIgne3PHG76i5+YvpztkB3pxG24q1lUBva9eGX4HhrI7+uRFNCcfdgd2TbuVT7zj1OEcRWWgxupRyaKXo7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746383118; c=relaxed/simple;
	bh=AHQD6c6qWKDIwojiYyNtwfz8sxAgfunXZCbhRB+/28A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uegHIZpCDRbFYCUbBM7QKubwd2O2AZFRDLSvlnz7eu9uAvXFqjD3wwhL7OBJJnfB2w35XkqGrqoaObmNMDxNdYor2wTqWqmdXZgcz2p2Lu02bh75XQ4QApfIHF+lalrOePfYioOWMxmUedz0Ie6FJStSk92uVSNAONKbM6ZG4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fmbgsLyY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so2139971f8f.0
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746383114; x=1746987914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDT3JHgVKGlkfgIsNZyWq1jDYJKNmdu5OHg7pB9h6zw=;
        b=fmbgsLyYPL6lP1B8u9dv1Czc5GIBdOvHCrTAS7pNw9cbCy3xtqSpZudc4PDDBhqOre
         eivwZEO/an6t9US9YtbVBg5bB3ahsjqumqdismM/KcD4FaW+KUdQSIJMgBJokEO+u26b
         eAbaas4VAqS6zObY9luQFXCPLU01SwO+ZEz2q2QwiUZTSLTVh5x1S2Dultj41GY26JQ6
         v8T7q0aYBwb9WD557ijSxFWbz/TMVBM51FFE9Ox4uE6/2OVPTCm0caSTW+YlgEow8kX9
         JgtrNqO3OtLdBtgQhNolN4Bav+CrbzV3VDEucI9H08BrlIVsjU1rjxSdHwZ5OGC9r036
         UqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746383114; x=1746987914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDT3JHgVKGlkfgIsNZyWq1jDYJKNmdu5OHg7pB9h6zw=;
        b=ZA/lxkWcXBKw7Kw5wXUFZIbmiM3pj1EF/z/wPaWjVwJn3FKFlZn+uKP7tGKsFqQxnX
         cw1i+xD0KYEiOIOZVI0apY71uACoC0seBPE6s7Jjkpk2cRewQ+OJFKx62bI2u/E6mniH
         x+3G9POMIVAwMujtVdBu9mf1JD9QwqhUNnvm+KT4rQVjWXgGoDThW1OwNSiLXEH4IhUE
         m3CVvLU2yfXJ0NfeNu0p5SSgm8deTCDWFBVsqgyMjXN4eKUlacNrL9bL/tN9T+Q7aXpL
         PpRIiryitKEDqYpFIFTGPftTmfgIxVVyA3edr1n7H+7CyxDtgjo1wrGVP929+Liymjxw
         2pUg==
X-Gm-Message-State: AOJu0YwGcwfjfdgT8VgxQ2HZ1+QFYsUGcSxJvY3Ul/Qob47zdB3K62DB
	9VzoTQ5/oCfPih388JUvt1I4efft2HiuC/a9/H4PQ0Jq1PCR248mQoqHXgGhiBQ=
X-Gm-Gg: ASbGncusOo9rnMRekSbByyazufYsoWNKLe74I3U0Qbk5Jl1Y8BavqMMFU45xMnb1C4o
	bbH6tyKRwasLuCOeKTDRBXfk/olmWXWLSE8h+vAASCPZdYipHOp5xK+L9kJ+CXdVxOPzlfc1wTL
	czUBHLRWbmz6NbIUZOnCc06Y3Qj3pGprWYXyeUD1cio+Ji9prW5Pb+YrduyeeDg5WxnKBZ5a8s5
	SvEIyiv1LpNKl1vqAZIQ/YPf96l6iKR+OjLYtluePXSuACBxhHqUm/oeXflBN0pKkl6xu1pAx7S
	bbDdyCLt8oom8oJMBrmD2j76YzWack7Hz/fjCCRcDfNKsxBoJX56fIaeCNBYapQ/niUz
X-Google-Smtp-Source: AGHT+IEXJ/x08F22pIpmTz2A8suQX53A4j/B2p9cIZFVe09lH6U+bTIC5/fcB/HKQVhz8C5Whru1Pw==
X-Received: by 2002:a05:6000:1888:b0:391:43cb:43fa with SMTP id ffacd0b85a97d-3a09fde5b65mr3105749f8f.51.1746383113747;
        Sun, 04 May 2025 11:25:13 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7caasm8169687f8f.54.2025.05.04.11.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 11:25:12 -0700 (PDT)
Date: Sun, 4 May 2025 20:25:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, saeedm@nvidia.com, horms@kernel.org, donald.hunter@gmail.com
Subject: Re: [PATCH net-next 3/5] devlink: define enum for attr types of
 dynamic attributes
Message-ID: <fozccqzcqh4ihgtnvio3y3m73vwxorcszunwqlphexxjq6lqnf@4nphkotznath>
References: <20250502113821.889-1-jiri@resnulli.us>
 <20250502113821.889-4-jiri@resnulli.us>
 <20250502184604.1758c65e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502184604.1758c65e@kernel.org>

Sat, May 03, 2025 at 03:46:04AM +0200, kuba@kernel.org wrote:
>On Fri,  2 May 2025 13:38:19 +0200 Jiri Pirko wrote:
>> +/**
>> + * enum devlink_var_attr_type - Variable attribute type.
>> + */
>
>If we want this to be a kdoc it needs to document all values.
>Same as a struct kdoc needs to document all values.
>Not sure if there's much to say here for each value, so a non-kdoc
>comment is probably better?

Okay.

>
>I think I already mentioned this generates a build warning..

Did not see. Any. Will check.

>
>> +enum devlink_var_attr_type {
>> +	/* Following values relate to the internal NLA_* values */
>> +	DEVLINK_VAR_ATTR_TYPE_U8 = 1,
>> +	DEVLINK_VAR_ATTR_TYPE_U16,
>> +	DEVLINK_VAR_ATTR_TYPE_U32,
>> +	DEVLINK_VAR_ATTR_TYPE_U64,
>> +	DEVLINK_VAR_ATTR_TYPE_STRING,
>> +	DEVLINK_VAR_ATTR_TYPE_FLAG,
>> +	DEVLINK_VAR_ATTR_TYPE_NUL_STRING = 10,
>> +	DEVLINK_VAR_ATTR_TYPE_BINARY,
>> +	__DEVLINK_VAR_ATTR_TYPE_CUSTOM_BASE = 0x80,
>> +	/* Any possible custom types, unrelated to NLA_* values go below */
>> +};

