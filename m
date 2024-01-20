Return-Path: <netdev+bounces-64469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75883350B
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF161C20F1E
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E89EFC00;
	Sat, 20 Jan 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DBc9w86D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E757DDD7
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705761592; cv=none; b=CLkKFyYWo9vSCuiwDaKIyaMHrplGFBjrBraSA6yk6DRnRQKna+mRtC2WTDd6Jtz2VUOc/y4ao7JT6iA7eSGmhRVWleYX9IoA3LrhKFfxyRDDVfVovXn/omblLk0kWKTBp41+JXhdMutBMg4pk/UWQqdZVEOf9xnLOkB0lwmJP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705761592; c=relaxed/simple;
	bh=CENnOEOf6vbNfEOvQGtiF5HmTuxz4m2ria+W+OXvjrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=fnYRIC7KeNYM2s/UvmFxe83YC15d8HgB8B6780GL11oXPet4d2zwhXEy9BWZCCFIFnaeJFxw6CbDOdiQfjSCHKp84mOL43uDw/8dQd32tSjM3qHQrXVdl53NgJF4WOZujVNukJeF9oah0Ib6ztIgQ7wa65szQR0Q35mnB0/0gRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=DBc9w86D; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da9c834646so1805077b3a.3
        for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 06:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705761589; x=1706366389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uw7SRaYPf01ny9WGGA++FMJ8mrF1vYqV0t2q3qmpq/8=;
        b=DBc9w86Dqsj9bpb6mWE0D9upeuXPoHaX7l30U2PnHO+MPEaPa9zY2Lp6UOvOcyUopf
         ZjDXpcMLuoWM3Zv26ipFEuhxp9eKRmjrWKJO2F6IWrR+tL0vLSdBPSG7HUUaq8ZW26yO
         dboEoi6kvHp3f+tENRv/72h/vsoGHbhbdiQCvt3OUdQs5GzvrZVFW1yrl7D2F4jw/gi7
         dNNrq2EISjkrO2FIwOAgwVzOqvZLaymgCU8q6GevgTVg90DAf+ibnsB60Fye3DB7BgoF
         C5NDFDaH1IivrRpoDb2dHUX2gjFltFWGxag5mZUxjMkoOnwxfoaljoa+op88ekBrmdxz
         rkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705761589; x=1706366389;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw7SRaYPf01ny9WGGA++FMJ8mrF1vYqV0t2q3qmpq/8=;
        b=kZIaiW/uZS9HX5A/Hce+nMIpeDRjWaLDCd+vMQ7hH5wljZum5nXNM1bLx4WXb9YPps
         5LpyHgzNdA97zaV6Iy/Pybwq/aFO+bGGb07Fh2ngh/1bYpyigaItSwTgS5C4cBR7JRYf
         PPXz6PvLujK+AgIvV7FOwpg85CT/RHxDXMJwYFYe/1Hx7TLePBgzpGZA/lGOfEZLswrT
         MHN1XChNFOfOTz1yEnzRQshX6Ds/Md7LGy8XurNf19x3FbweHkrTTtn7yUV5sQVkeCV9
         bOnBYJN+Fe9Bbi4iJoL1LLzyr40/RnXhs5AOWushtO0OmLQ7xdCDjoR9wo2ByHOfrbhi
         +X1Q==
X-Gm-Message-State: AOJu0Yzn9mdJILZL4olfBI4j9P7eI9mQL4Nl+1Ym5UETRXVafu/dPiwG
	Ptjl016MczGD33kmPyG6/Kt2k5gHjMUDs6Jpw2L7oARZKV9IfRwmHmyPvHtHds5NVG+8eUg/zoP
	frw==
X-Google-Smtp-Source: AGHT+IFLLFwwtGUkq1sma5MRMhETOcroOwiREcruEWI8iPvX5aILcBdbCMr7oMPK9afwJ1/iKWpq5A==
X-Received: by 2002:aa7:9f06:0:b0:6d9:bf73:6275 with SMTP id g6-20020aa79f06000000b006d9bf736275mr2273456pfr.2.1705761589253;
        Sat, 20 Jan 2024 06:39:49 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78695000000b006dbd3d7e242sm623173pfo.126.2024.01.20.06.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 06:39:48 -0800 (PST)
Message-ID: <9c6213b3-961f-4a74-a22f-143da42daf32@mojatatu.com>
Date: Sat, 20 Jan 2024 11:39:46 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] tc-mirred : Redirect Broadcast (like ARP) pkts rcvd on eth1
 towards eth0
To: Vikas Aggarwal <vik.reck@gmail.com>
References: <CAOid5F-mJn+vnC6x885Ykq8_OckMeVkZjqqvFQv4CxAxUT1kxg@mail.gmail.com>
 <SJ0PR18MB5216A0508C53C5D669C07F72DB6B2@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <SJ0PR18MB5216EBC3753D319B00613E79DB6B2@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <CAOid5F8TV=LbN_UZzmGfOrq1kh8hak7jrivHm2U9pQSuioJP6g@mail.gmail.com>
 <0b2bdc15-b76b-4003-ba1d-e16049c7809b@mojatatu.com>
 <CAOid5F8L8enzhKfW46SGxoZBp8Sed6xBSpE4Hqt+cY02r_O1xA@mail.gmail.com>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CAOid5F8L8enzhKfW46SGxoZBp8Sed6xBSpE4Hqt+cY02r_O1xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/01/2024 02:03, Vikas Aggarwal wrote:
> Thanks so much  Pedro Tammela & Suman.
> Getting bit greedy here with tc filter :)  -  Can i also use some
> boolean  for example dst_mac != aa:bb:cc:dd:ee:ff
> 

I don't think you can explicitly like you describe.

You could do something like:

tc qdisc add dev $ETH clsact
tc filter add dev $ETH egress .. dst_mac aa:bb:cc:dd:ee:ff .. action ...
tc filter add dev $ETH egress .. action ...

The last filter is a fallback in case the dst_mac doesn't match.
As long as you don't specify the dst_mac in the flower filter, the last 
filter will match everything != aa:bb:cc:dd:ee:ff.

If the == case is a noop, then just say `action ok`.


