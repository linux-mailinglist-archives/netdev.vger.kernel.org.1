Return-Path: <netdev+bounces-121463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5FC95D457
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C04286EAE
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12172193410;
	Fri, 23 Aug 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1wkvy5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DB193084
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434321; cv=none; b=TAm4r8ja/cIRajc2czhvwdptR+VtZVpzA1eXnA8U+vL5M1XenNEz3EtwBV4dYi31/wmIxVgzf9GoVf+T8qt/bkdbnkBzGI4G5wyq0YxKFLnmcunWI3625yX8nHp11NqbK8Bliu2/ST/VnoWUowFe5b2Gocm8zdqqJ+lGQauMwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434321; c=relaxed/simple;
	bh=1bVu5rIMhH37sWhQXZerw8ec8LtXyPcATOFqPmLJvVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCbYlVeAQn1jdanKZop2VBiN7YIJ5kLZPvBvhSXxEaAC9D+yLVQkK9485MzRFC1Mx/po2Wuh/lqbjZKxebbKiXSAppnwIYA4mjitycsB+TC/aoC/XMqgWzuXNnOsjNW/V7y5ujc+nIZU0b7A1M7L2vy7OkXBW7JFUh9pcFA2cgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1wkvy5i; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e04196b7603so2285472276.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724434318; x=1725039118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymzTd1GfmfyY1t5padCfGqMprAyAOfwbo/RSX/RXUQ8=;
        b=G1wkvy5iDSqlLNDlZXUKqkrtMzq+q/bFGcEQrg5aMWcrqY3S1RHQmXd4ibiZQDwckQ
         zGAiBlzwq/NM1JCbMuGMH5PgOtbmwipl/AwV+Ph51aucH+gIOFgRq4cK7zleFfkgcR7s
         ZtOlsKFpiTNzaip0w2pNyftBV0yoZZPF9RAUINilFC7GusZ0ErMe3FwPR6ffnL9yOQ+Y
         QGAu/AGc7ZS4uZynOdlSXWBMnnFgHFL6pdRdmvO4j88IZFV1+K7D0cGX92QH25M5ynmZ
         LEoePU9P+2tOfFYUebMKl5Q1+Kw5oso3BR4DZjvVsTtp2NCMUJdlWHWBpTq2fgDhNJKU
         ZX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434318; x=1725039118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymzTd1GfmfyY1t5padCfGqMprAyAOfwbo/RSX/RXUQ8=;
        b=hZzR8NtYHj68PNqIBq2k59Emu+Fefbe3Os6XLL4WX2FoalK/weVgHO5ZwNKFUBTCON
         yN5lDin8DSXEHpT0D+2BMMVnTnLekf32N8CWtag8sfv36lr4wKQw8m13HW34FCD6lRbn
         bUqSqfFdlELxCG1xyyavjAaRje++AmrFdpUgdoovpsMZ2erKkeFBB/k0lnzL0sQVvASd
         48PNdwFlEqIiRkzlwminfqd1KUSiQDF3+upz55pQcixBtd/NJccnBCJDOG6VTA/ot2Of
         PawtXB8R92VSjHhoPJXZ6mzAQQqNszgTZWzaLhPxBzGLZZ4qxK0CsqTjubOS59wuaXI1
         N0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtOmMybjpVmcGOI0ci92iSYqhvkU6KJ0NAM3mereBwmwAhoLUQF9Cx08KBho2Gz3bJNOgtIc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBofcYzorYrEiDJtBeCYKrXl46ymCdE1frMCT9ByVP5EmpVFC
	RJDouEmzzfiFMr2yA5J7ByL9lAsqr+PXQzTPdbgdM+qquZ6DEZU5
X-Google-Smtp-Source: AGHT+IEj2q6U83edhf/7KcN7eTmBEv5rBImALH4IlPgguKXG9AsFN68ylOrsv9S5wUWmVphEA/BEjA==
X-Received: by 2002:a05:690c:88:b0:664:4b9c:3de with SMTP id 00721157ae682-6c625f1e8d2mr38428407b3.13.1724434318255;
        Fri, 23 Aug 2024 10:31:58 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39d3a9d47sm6081857b3.83.2024.08.23.10.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 10:31:57 -0700 (PDT)
Message-ID: <63af81da-d38a-4b57-8915-4823d6da1ec0@gmail.com>
Date: Fri, 23 Aug 2024 13:31:56 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net: dsa: mv88e6xxx: Fix out-of-bound access
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
References: <d9d8c03e-a3d9-4480-af99-c509ed9b8d8d@stanley.mountain>
 <0b6376c2-bd04-4090-a3bf-b58587bbe307@gmail.com>
 <4b004e58-60ca-4042-8f42-3e36e1c493e5@stanley.mountain>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <4b004e58-60ca-4042-8f42-3e36e1c493e5@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/2024 12:58 PM, Dan Carpenter wrote:
> On Fri, Aug 23, 2024 at 10:40:52AM -0400, Joseph Huang wrote:
>>
>> Hi Dan,
>>
>> I had a similar discussion with Simon on this issue (see https://lore.kernel.org/lkml/5da4cc4d-2e68-424c-8d91-299d3ccb6dc8@gmail.com/).
>> The spid in question here should point to a physical port to indicate which
>> port caused the exception (DSA_MAX_PORTS is defined to cover the maximum
>> number of physical ports any DSA device can possibly have). Only when the
>> exception is caused by a CPU Load operation will the spid be a hardcoded
>> value which is greater than the array size. The ATU Full exception is the
>> only one (that I know of) that could be caused by a CPU Load operation,
>> that's why the check is only added/needed for that particular exception
>> case.
>>
> 
> That doesn't really answer the question if multiple flags can be set at once
> but presumably not.  The ->ports array has DSA_MAX_PORTS (12) elements.
> I used Smatch to see where ->state is set to see where it can be out of bounds.
> 
> $ smdb.py where mv88e6xxx_atu_entry state
> drivers/net/dsa/mv88e6xxx/devlink.c | mv88e6xxx_region_atu_snapshot_fid | (struct mv88e6xxx_atu_entry)->state | 0
> drivers/net/dsa/mv88e6xxx/global1_atu.c | mv88e6xxx_g1_atu_data_read     | (struct mv88e6xxx_atu_entry)->state | 0-15
> drivers/net/dsa/mv88e6xxx/global1_atu.c | mv88e6xxx_g1_atu_flush         | (struct mv88e6xxx_atu_entry)->state | 0
> drivers/net/dsa/mv88e6xxx/global1_atu.c | mv88e6xxx_g1_atu_move          | (struct mv88e6xxx_atu_entry)->state | 0,15
> drivers/net/dsa/mv88e6xxx/chip.c | mv88e6xxx_port_db_load_purge   | (struct mv88e6xxx_atu_entry)->state | 0,4,7-8,14
> drivers/net/dsa/mv88e6xxx/chip.c | mv88e6xxx_port_db_dump_fid     | (struct mv88e6xxx_atu_entry)->state | 0
> 
> mv88e6xxx_g1_atu_move() is what you fixed:
> 	entry.state = 0xf; /* Full EntryState means Move */
> 
> mv88e6xxx_g1_atu_data_read() does "entry->state = val & 0xf;" so that's why
> Smatch says it's 0-15.  The actual "val" comes from mv88e6xxx_g1_atu_data_write()
> and is complicated.
> 
> mv88e6xxx_port_db_load_purge() sets ->state to MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC (14).
> I would still be concerned about that.
> 
> regards,
> dan carpenter
> 

Hi Dan,

The field (->state) could mean either ATU Entry State or SPID (Source 
Port ID), two unrelated attributes, depending on the context. In all of 
the functions above, that field means ATU Entry State. The field means 
SPID only in the exception handlers' context. The value (ATU Entry 
State) being written to in the above functions does not correspond to 
the value being read back (SPID) in the exception handlers.

HTH
Joseph





