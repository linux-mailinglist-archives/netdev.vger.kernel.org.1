Return-Path: <netdev+bounces-74438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A7861540
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98D81C22E83
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275415FEE5;
	Fri, 23 Feb 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="RAboLmSr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CA224D8
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701001; cv=none; b=F0QIkKFnmhsXUgQTGpyIygAhDk8EeY+jtjtHggWN4UaRMMSOc+p4/q9E9J17UoFs/ae7eNa6BsFG0Y5R0i1YTFIsmFdPTL5uy3qJ+2ZyCn8ufgv7OgKwZgcO1+L3VVlcX7KVeJ0KQHWUrCmmDvHI2sEt7qFz3Ld3U/+eHIVOLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701001; c=relaxed/simple;
	bh=nYCfl+z4QxVTJIiLU1ykae1cNTs1fFhOFdLs+NHPIww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDJuazDzgJJSBdlmf11Fa4B8nUT09sbq4u32eAzAgF383itui+EoYphp9ZmuzQcSJnVNekesQSaGzo55wy09XL64FOxxORRTTu9AQodjE5i4YHc9wTS6OqKSckrargrKux2hwYh/G9HwtTmWrkRmsudGzgAcqNpeoPVL6gLYR2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=RAboLmSr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so1236557a12.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708700997; x=1709305797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cCOuU8hjQQ1fOGA+uaUWRjJo1ucVPPlT0uvx39NC8uM=;
        b=RAboLmSrGwTOAm8p6FPiAqI8hTZwGG1fNXgbBG3SJ0ABG5ZKTl1NeTrHoXahjNG3LB
         L3HM4pd3xlIt+SzgcyEluId970ZcBLOQJl5s9Ny8gggk3dEA9/ELV7x/EHVL0v36Kew3
         MJXoHZP/IELURGAbWjaCKylLrkHM198f7NyFRIlFI1Oy62NuHttJyN8+yMys05JR3nNL
         8bBOxVapTDYP0TNwCs0Apq9E4UK+sYA4v47lih92oaUqpHwjQL1Dhe9VwgtYkyq4UjY9
         llWd8THN0sio7IteRC8PFKuYUArkMlU2q0n6iGz9kwrPe4FGwMa1WfT83Bge9d8M5KE0
         h6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700997; x=1709305797;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCOuU8hjQQ1fOGA+uaUWRjJo1ucVPPlT0uvx39NC8uM=;
        b=eYC9es5f/nMJDAYCyHGAVFsdxoiLW4DJdZeLDKOLh+Z1luUx7qGaoLTdPuQp66bsP/
         F1U1z6chxnEuyM2Szi2LPNm9k+qMCa4bDdPPo4oswiJRkQ7Nsl116L9ZsqT8/quFFxcU
         /h6SxJ8FXkuLgKi3HwWAo4pDHKunAMbrqFiGB9E7lUkhgbyjZCzNBxAGSkSyCamm+GPm
         5sZu6nwNGUjfsqHDZtXBzGbSS7IxXqQk2+ckXACSpT5C8pFwNa/A5XaNgcoG1WZa3x6/
         SE7jb9S7zyDrG8abKFBbdwgxxt+ssQU5sttVflLXOW6q2MrdQDtPNxh+txDT5a1fkAOH
         AdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiu4LKE14yc3IBO/zOCe63wYv1mAAoYjFO/3JkhKeVG3dq3y97+lycaMX+B+hElR6wpXcPIP7oQqzNZQZWwsm8c8GCOM/k
X-Gm-Message-State: AOJu0YzQ1G21ewXkQ3CVx2ynZmZFZuKlPoYx/1b5C3D5u8QQB7i9iWUG
	E2hlc0tq+rL42ksUReIE5YceK7J4hUTtz3+kR8qpVuiqB20SWyVjw9HxRf0UIHY=
X-Google-Smtp-Source: AGHT+IGrxCT/KGbNyjhfEmBPAYkCa2dYyQpyJXinHI9XZqI/mvOsIYI/2/WpdRCJEdB8YYTO05dCvQ==
X-Received: by 2002:a17:906:5910:b0:a3f:583c:b00c with SMTP id h16-20020a170906591000b00a3f583cb00cmr63865ejq.43.1708700997469;
        Fri, 23 Feb 2024 07:09:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id lj7-20020a170907188700b00a3daf530fd8sm6969373ejc.210.2024.02.23.07.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:09:56 -0800 (PST)
Message-ID: <5dfd82c9-5202-4047-a596-a9afb0041634@6wind.com>
Date: Fri, 23 Feb 2024 16:09:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 02/15] tools: ynl: create local attribute helpers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-3-kuba@kernel.org>
 <1b2fec9f-881d-48fc-bb11-b6269c4ad2f5@6wind.com>
 <20240223064650.7e7b5975@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240223064650.7e7b5975@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 15:46, Jakub Kicinski a écrit :
> On Fri, 23 Feb 2024 15:03:49 +0100 Nicolas Dichtel wrote:
>>> +static inline unsigned int ynl_attr_data_len(const struct nlattr *attr)
>>> +{
>>> +	return attr->nla_len - NLA_ALIGN(sizeof(struct nlattr));  
>> nit: NLA_HDRLEN ?
> 
> IIRC I did that because I kept looking at the definition of 
> NLA_HDRLEN to check if it's already ALIGNed or not :( The name of 
> the define doesn't say. Not that it matters at all given the len is
I need to check the define every time :D

> multiple of 4. If you think NLA_HDRLEN is more idiomatic I'll switch.
Yes, if you don't mind, I prefer. It better describes the code I think.

