Return-Path: <netdev+bounces-225911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AACB99311
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 11:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54AC19C78CC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 09:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B52D97AA;
	Wed, 24 Sep 2025 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDnoTsTt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C305A2D879C
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758706843; cv=none; b=ZkplYhpvXrr+UnpFxu522vNK7PylbL2y65yOmvLxF/I2mnY/rG1h3ZDtZv2D7k2nr8QouYRYJ4La1Qd57SsnZWlrq+c4Q2a/CphpNJ4GqGlR9L60bACOv0kI+7oU51nnEpGNl9tHf8bqivHPJ8fxml2MFERPnfW293xp0rhzifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758706843; c=relaxed/simple;
	bh=jzKLiKmTv/j27SzZOjxIl4Qu+tZgt4ATA7sg5rWQMC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wol8prVaL3tlP8IQnXY41kkHUfK7qvYBF49w4C2npaJBFtf0k6nfLWdqMYG0KJk6bgo/KCzWb9dtDS7GXqBA911/P1i/tREDfGkiAtPCOaxkWUeF57cctsHfy+lCzzr2WHxZHqk8YJ1mV1sJo1Oze203dFeCtHddKZ6NaqhX5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDnoTsTt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b331d5cad07so4101066b.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758706836; x=1759311636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kETfRtb13E45xSUCjG7RsgFFIEDwDhVzUH8S0QeQpIs=;
        b=HDnoTsTtXs4kRENzc4A6+V+3atth8W30GNZkN4GkUGyc/kr2V5dP2DxYrWYrq0hMIZ
         uasZc6gAMz/JPDK3pnHr3+x0Ux+AZhamxlbJ0tRLv89TDVX4+nevUGDHnanI7sQv1egC
         4c73EO9haZQ4ckQqifgnov6nz10dxgQwbebMRtyuK1xXROprmlfGWAuXPjby2cMJketS
         z9IVFJ5T0hlTAdfQLsdO1G8suY+UFaxK8mLn3HTNWcaylr/riMtDUxMXRGnE5+SjkmIj
         fKohfO32lfOViSA2AMzVtXb9E9gfvIMmM1hlThM5WFWOVT8YA3/SHYe8+SNXC+BdrkOT
         23qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758706836; x=1759311636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kETfRtb13E45xSUCjG7RsgFFIEDwDhVzUH8S0QeQpIs=;
        b=a2lltjirKlS8CQXCRWH0NI6Y8O8wLawruIhWfmWlZlB6CJD4l+/7VJHcHGlzJmmtVP
         jKnlkSpS5Qa6YJuMHrknvRz0XPaaSIcTqesS0jvI/7b8PVGP/KNkQhQuuWzoXWVTrCkC
         tOfEVvP4xI48xTIWX6yJgjiKha9TbIiAQ6YOKiP0o6djNDTRKwdJzS7Bp3mZyJVea/z6
         uawr0W6Apo6N6OPGCgQUJNzh3P3buiR0Qmp5O9w6sddU/8hGqztGJofrjn0Q+w0S9Ebr
         3yvWTHMxFpyPUJP2hTY2SE+1rZC1kLWbIolg7DnyOcmFqJGaNOU0ZaQn/jDgxzMyydAy
         P85g==
X-Forwarded-Encrypted: i=1; AJvYcCX4Ib4qKxVnNu+GmLg3L6nZQh60l2Ax7/SfcGpNzyoTe6STAcMr6cIY/vuUzfu2GqlQtZcioqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrO2I9wNJZ1N0ZN7rFcsQ3ikqPzVSnwgO0CEGcMs3/U55vDmgC
	Dtack6uvHMtFtK55CmAy+82V3Dg5waukvLPpZreQGTIh4FTMCJNc8xg+
X-Gm-Gg: ASbGnct6Jusv8TeSiEt0+RW6+0j25WFmFEjfeoUEfcnpfYxdXUBEa1+oah34fGBQjdw
	/R80+KaAQzTFBVJtVLB5RSs9UXRPj2f5K4j8RsA0da+voZ8Wyti8WINo7SOfVoK/wTyUCgmRwLS
	YplX5C3bsN/6icxt8X9rMqStlHds7F/IUbbrdj3+k5SMqiZEdg5ojKoLa8um7FhIkb/TFX3/a2c
	ChMUITB+/cCDHS1Z+2hmzK+sF981Oel8myXBvYgFDvMA6r/puCDTsEz6yr/axlgZWtJ+O9iyEAL
	1Q1HHM/pBX/IKQ8DClh4/uCLTHhB1nRWNnhKo/TnrqyMeYcp4/cJKcT6b8E1PDkp3qQC182LUu/
	QL92K/teytPYOILZPXaPK9dzgQ6NPflLGqXBM58I2hQCM0gdaPcU=
X-Google-Smtp-Source: AGHT+IF0eP7C+aQmBPuYKh5yIDRssL3F6YcaqJ1p8ewtObRtDnPBvvunL6qa6AQJ5XZK9rsgzL9BsA==
X-Received: by 2002:a17:907:7b8c:b0:afe:ae6c:4141 with SMTP id a640c23a62f3a-b302689ce0emr223705166b.2.1758706835860;
        Wed, 24 Sep 2025 02:40:35 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b31a562fe38sm211353166b.45.2025.09.24.02.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 02:40:35 -0700 (PDT)
Message-ID: <f103da72-0973-4a45-af81-ec1537422433@gmail.com>
Date: Wed, 24 Sep 2025 11:40:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, andrew+netdev@lunn.ch,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, matttbe@kernel.org, chuck.lever@oracle.com,
 jdamato@fastly.com, skhawaja@google.com, dw@davidwei.uk,
 mkarsten@uwaterloo.ca, yoong.siang.song@intel.com,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org, horms@kernel.org,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
 <aNMG2X2GLDLBIjzB@mini-arch>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <aNMG2X2GLDLBIjzB@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/25 9:45 PM, Stanislav Fomichev wrote:
> On 09/23, Mehdi Ben Hadj Khelifa wrote:
>> ---
>> Mehdi Ben Hadj Khelifa (4):
>>    netlink: specs: Add XDP RX queue index to XDP metadata
>>    net: xdp: Add xmo_rx_queue_index callback
>>    uapi: netdev: Add XDP RX queue index metadata flags
>>    net: veth: Implement RX queue index XDP hint
>>
>>   Documentation/netlink/specs/netdev.yaml |  5 +++++
>>   drivers/net/veth.c                      | 12 ++++++++++++
>>   include/net/xdp.h                       |  5 +++++
>>   include/uapi/linux/netdev.h             |  3 +++
>>   net/core/xdp.c                          | 15 +++++++++++++++
>>   tools/include/uapi/linux/netdev.h       |  3 +++
>>   6 files changed, 43 insertions(+)
>>   ---
>>   base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
>>   this is the commit of tag: v6.17-rc7 on the mainline.
>>   This patch series is intended to make a base for setting
>>   queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>   the right index. Although that part I still didn't figure
>>   out yet,I m searching for my guidance to do that as well
>>   as for the correctness of the patches in this series.

> But why do you need a kfunc getter? You can already get rxq index
> via xdp_md rx_queue_index.

Hi Stanislav, When i was looking at the available information or recent
similar patches to populate the queue_index in xdp_rxq_info inside of
the cpu map of an ebpf program to run xdp. i stumbled upon this: 
https://lkml.rescloud.iu.edu/2506.1/02808.html

which suggests that in order to that, a struct called "xdp_rx_meta" 
should be the route to do that. In my navigation of code i only found
the closest thing to that is xdp_rx_metadata which is an enum. I tried 
to follow was done for other metadata there like timestamp in order to 
see if that gets me closer to do that. which was stupid with the 
information that i have now but for my lack of experience (this is my 
first patch) i tried to reason with the code.So yeah, since xdp_md is 
the structure for transfering metadata to ebpf programs that use xdp. 
it's useless to have a kfunc to expose queue_index since it's already 
present there. But how would one try to populate the queue_index in 
xdp_rxq_info in cpu_map_bpf_prog_run_xdp()? Any sort of hints or guides 
would be much appreciated.
Thank you for your time.

Best Regards,
Mehdi Ben Hadj Khelifa

