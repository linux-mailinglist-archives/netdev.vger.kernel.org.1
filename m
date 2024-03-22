Return-Path: <netdev+bounces-81275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EE2886C77
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A348C287272
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC30B45C16;
	Fri, 22 Mar 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xcPlWOWU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140845BF3
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112309; cv=none; b=HDSeZbO1zYSvG1qxvVnRZrOg3PfVU/cyHBeYEwneIxhYsXObGvUOBzLVZ6OfVIr3CwGn3KywyXbSdNWlWZjO/WUT1fpiYpfSMCbHFAFU39lnrDrpFdcGuiQhxls3LvME71UZ2EKUWUKdrr5d+XDff5fcHH73oLuV8SaGYI59V9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112309; c=relaxed/simple;
	bh=qdq2a6bQB4zLF5y7rJfn6/zbx1ScX1p7uoT1aN+8DbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UASwi17P4CxnUmqEfnY/7LPFaaLrDZKPkutyufWsU1ILj2g7HczjS3SWNAcEPZWePHZHXxJ/DAkgyfLIMqLHinxJKbzyBpRpUFIOD5+u4vcK8ng7M88gKhNsowehq2pbZm+1KI2yaqopKyAtQttryaW+aXAtEsNEb9KPhrXlGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xcPlWOWU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so2925252a12.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1711112306; x=1711717106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LUGwsxLnMUWkae2CSge+OitZs3lt/HylfNAJOAD4fw=;
        b=xcPlWOWUwMyfNjmr91ZsOJW2Ja3Ov4WqRWh//6Lw95DdwJXYZMB7JlWeIQr66myALl
         c1J9PqqLjEP0GpAvTG4pFMDd46B0s9vspXgJwns6Dus7dXeH2cN1Pcw5Gr2lLo9TpDNc
         wVs8bAcpphYzXW2sS05CmgoXrKqt1lGTVAyX39WAzZMyjTMC4s8vEe+j+yKaxMP4hXZF
         MhtTeTQQUgHw399lw8J2wx9Mv6y24zjovU6pzKMAh20RdH/SghVdK3nQP4gnJzzG5RAM
         x7y2TvWi4agGsb4eD2Bo3i1UNfpfQDMmqO79UPnvaYSKoAHgzaubfEWT7KGNp5qaeUpe
         92jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711112306; x=1711717106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LUGwsxLnMUWkae2CSge+OitZs3lt/HylfNAJOAD4fw=;
        b=M4bHJ3r4gP/rlIk4uVx3ndI4jpL3Fk5GmaSe2ATQWe4/wzHVfsNq8TwXBBGfzBJVyF
         VCEcD4gFCxSnVNi08XOTIHIgisp7eNGTslavsfrawp14xwxl+54Kr/DCjjKwYRXPbBEm
         6eVyU5J41mXIyls/MxkEuhOuvliIq/Xjrg3+T702K52Dc0+7mIdgWpjIr7rxJZ47/Mic
         zZgb6X/yubB3/6E5ZDK7Xia3JxI8A1WGyoaWzycCfXVjc8BgF3N9rOfnshHQsGuUfXTk
         a/LLHkWTq0LbKGgq3Ud4s783u9MLkQSIdlX3IRFdKzuFoVRgdpQMHdiXKIXo3ylXn6R5
         u9XQ==
X-Gm-Message-State: AOJu0YwwqBlyMH1CiVk3ly9vrFlSigkqjTVASlFIcq9mw4ngnZ+Ckav+
	LEZQPeHj+7tZtbxqPAwNcI93sZok0eYGFn380Auqn8VBLMUlI5QZoJ2MXjtIX9TZB6ciEY+EBve
	B
X-Google-Smtp-Source: AGHT+IFnlm+CULBYCrQvbVt0F/cdsUUhs/GbNE4xpUZg9du+9T7Z6vJNQjzykH1gIhhv//3ZXzIDwQ==
X-Received: by 2002:a17:906:340c:b0:a47:1d03:f37a with SMTP id c12-20020a170906340c00b00a471d03f37amr1785429ejb.47.1711112306339;
        Fri, 22 Mar 2024 05:58:26 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b00a4737dbff13sm229585ejz.3.2024.03.22.05.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 05:58:25 -0700 (PDT)
Message-ID: <95e8aab3-88cd-4120-a246-fd3589ff59ba@blackwall.org>
Date: Fri, 22 Mar 2024 14:58:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 0/2] bridge: vlan: add compressvlans
 manpage
Content-Language: en-US
To: Date Huang <tjjh89017@hotmail.com>, roopa@nvidia.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <MAZP287MB05039AA2ECF8022DD501D4BCE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <MAZP287MB05039AA2ECF8022DD501D4BCE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 14:39, Date Huang wrote:
> Hi maintainers
> 
> I followed Nikolay and Jiri's comment and updated the patch to v2.
> Please check it.
> 

Your cover letter should contain an overview of what the set is doing.

> Date Huang (2):
>    bridge: vlan: fix compressvlans usage
>    bridge: vlan: add compressvlans manpage
> 
>   bridge/bridge.c   | 2 +-
>   man/man8/bridge.8 | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 

Generally it is good to give people time to review and wait at least
24 hours before reposting another version. Also please write the
changes between versions, something like:

v3: ...
v2: split the patch into two separate patches
     changed the option in patch 01
     changed the man page description in patch 02

Keep the history from previous postings. Also you can note what changed
in each individual patch for the version under the first ---, for 
example for patch 02:
---
v2: changed the man page description

Cheers,
  Nik


