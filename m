Return-Path: <netdev+bounces-65223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44F7839B45
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCEB1F22310
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6A53984D;
	Tue, 23 Jan 2024 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zCZj2S+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CB1EEE7
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046067; cv=none; b=OuYsV6XD6ms7PpyxBJEj7oFc/gVl6Y0CcGlzWY56+o0LtVBfbpi0ILzDfmjQHtI/34o3XYuSFDdaCZcv29SN/QenOCjLpicYj2wqb1ly8wl00t7AOjBIZ6WnRxLA44UnrSCxFG+QyWdJwEtbr3hdeUi0IDT9CoqTOT3sr0WQ28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046067; c=relaxed/simple;
	bh=kQtLBPIfcQAiSV7iSRDty0wVB4/l4DPXmkkr1VAxUxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISUvBHHGoLLG1ovnopEIqfPumQG7L/Re7Rpt84qiEdHtFjYOdl0clZ0oJh9YPPgfSDSJWpwa8UzGF0KPqyj1eSR7Bgb7pU7hTVDm6jDuxL5CF0wM2JLVaaex1AI1ZVuv0kW51DSrpxpOfeDRT4s5APHcYVhOWbZqk9gfEFCRyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zCZj2S+L; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so3517781b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 13:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706046065; x=1706650865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9Pn3IDwBwkxE6RxEKw9IjZecSiPr9jZLGy1+n4d62E=;
        b=zCZj2S+LnAs2Rk8JbkcSD8ThWE8DzQLoraaIFA0FvfDSoZSH3Qtbwo6SNA7SB6XkUJ
         qcphQiZMXzFarGGG/UOB5Gel6LD+NibrqnJRCcHNP4rDoFXyxboRdGpr5V2DfYTEalrh
         UKaHxZa4ExoL72SaYJ2bNclt8W0e4Qj/yMuXWkqYKYAjG/xMBe+S6vjh1ipYhf79zBm7
         NWlvSTJGhihNoKi5emZBQgGtfQMgmxElunS8r5c0Oc4vkKW4CN6S5Tl9cxuU9EM6zf/H
         84+PHHUKW7QFnzO0mHcxa2ifJZwN3jcQR1uJfa++Fl6JeuLXl2VY93iqICUigk6ROVhE
         owlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046065; x=1706650865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9Pn3IDwBwkxE6RxEKw9IjZecSiPr9jZLGy1+n4d62E=;
        b=wYpbNb2OHZi9PjHtEtwksr2/yY+etXvl3DDvtz3CszjupC5sbRBycCgjbnpF94eqUP
         OXihf022vwMQ7GxYsGBHmEMp4CzV98R1JwtGDcVdjMJiD3S19Yn7swvF44wgMBxXym+t
         N/kCGM6KoZJ8cs/MxsN0IUKYK9ST265ciRGZOmnVNlJ275MaForoJfhC1BorgSHT2+3g
         R7RuyVtvvMNYomrglUfMU0T1Jgw/PebwWDSzNRAfPaiJpEZpM3BND8inPBA/xJ9cDTRm
         Dgx29v7/PUKW3yOE6B0Hskb6/seY7KjNl4lisEanQjGs4pVWufL0wxL/IMLyMlseRMzQ
         7kCA==
X-Gm-Message-State: AOJu0YxQgaAm/W1KRzev9e2AYJ0A0IVO654dLFm9e2f5LfwHRt/LrfBN
	mLCtfDna9YwNG64sppTIrU1YGC7pNI5xaaIy2q+bfDDI//ilqA3Ry56BsZs32Q==
X-Google-Smtp-Source: AGHT+IG7Ym2Dc/4j9lhZJ+3ROkkUe3ElRWdj9IOIpTv0BpJYVxh7lxIjXtCwnC9/dE2oQQm8XTi6ug==
X-Received: by 2002:a05:6a00:2e25:b0:6d2:74fc:1f1e with SMTP id fc37-20020a056a002e2500b006d274fc1f1emr242838pfb.14.1706046064881;
        Tue, 23 Jan 2024 13:41:04 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c1:2229:1771:59f5:c218:f604? ([2804:7f1:e2c1:2229:1771:59f5:c218:f604])
        by smtp.gmail.com with ESMTPSA id ey15-20020a056a0038cf00b006db05eb1301sm12247385pfb.21.2024.01.23.13.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 13:41:04 -0800 (PST)
Message-ID: <afb9ea78-9d9a-4ab3-bee4-a1da3175cdba@mojatatu.com>
Date: Tue, 23 Jan 2024 18:41:01 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] m_mirred: Allow mirred to block
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, stephen@networkplumber.org,
 netdev@vger.kernel.org
Cc: kernel@mojatatu.com
References: <20240123161115.69729-1-victor@mojatatu.com>
 <158eaf99-1018-4ef6-bfdf-5f86464aae83@kernel.org>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <158eaf99-1018-4ef6-bfdf-5f86464aae83@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2024 15:17, David Ahern wrote:
> On 1/23/24 9:11 AM, Victor Nogueira wrote:
>> ---
>>   tc/m_mirred.c | 60 +++++++++++++++++++++++++++++++++++++++++----------
> 
> missing the man page update
> 
>> [...]
>> diff --git a/tc/m_mirred.c b/tc/m_mirred.c
>> index e5653e67f..db847b1a3 100644
>> --- a/tc/m_mirred.c
>> +++ b/tc/m_mirred.c
>> @@ -162,15 +167,38 @@ parse_direction(struct action_util *a, int *argc_p, char ***argv_p,
>>   					TCA_INGRESS_REDIR;
>>   				p.action = TC_ACT_STOLEN;
>>   				ok++;
>> -			} else if ((redir || mirror) &&
>> -				   matches(*argv, "dev") == 0) {
>> -				NEXT_ARG();
>> -				if (strlen(d))
>> -					duparg("dev", *argv);
>> -
>> -				strncpy(d, *argv, sizeof(d)-1);
>> -				argc--;
>> -				argv++;
>> +			} else if ((redir || mirror)) {
>> +				if (matches(*argv, "blockid") == 0) {
> 
> Not accepting any more uses of matches.
> [...]   

Thank you for the catches.
Sent a v2 fixing these issues.

cheers,
Victor

