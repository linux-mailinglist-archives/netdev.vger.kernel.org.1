Return-Path: <netdev+bounces-237374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32EAC49C3C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E193B188C0D9
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92F303C81;
	Mon, 10 Nov 2025 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vdGJeAKj"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3430594A
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817301; cv=none; b=eJaLXUpyhA9kQsPRBU5Aq7Fv5NUHrpm+L/0yvZS0lsE7nNJx+q6J7YIqUK2zOhLQhYUJUbXyU2G0iUUCqHfD/oFcveM7fiaK/9FByoG5U777uDfiw2YAn5+M/SIpMJ59RpkHxWItR62ZG5PInOHFLpgM5s1ebhyEjXBAVjVTqXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817301; c=relaxed/simple;
	bh=HdfeSIUrqPUlIVyGs5EEeF50sJNc26hT5bndakpZrAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIL4Jy9YHc+kd2wwjzIyAgyiEBG8ORkrUCI4E3UrZpCe820lNKmg1hq2chdRlnrQhoodHOtq2bOfL9ClW0aXZoFHzVb8WcCwflUImuJc28cRdrHe1hs5wglibL8gHfOLvdYl3hxoiTsy8rA2vEzCv47iVMyLa8y3+V0BmDC0+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vdGJeAKj; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a7d4d89-6619-4fa7-be97-26f1871d348f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762817296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KW1WC+RwpOyORuaXesb/84eum2vgMyM2yQDa/7HqvQ0=;
	b=vdGJeAKj+uhT5xwc/sxrN8qVWK2PdTzt6QX84d/TwUiLYBMTrK+J7McrZs7BN45q3OS8FA
	YKbstBMm56ljBMAPZgaAcgrZ7D/3om9kScRaCNnXGv7Luh1tZqOXmBgw8Ay8GJCdIgD+3B
	jT7ycoU4izzz6Mer6y1Z5nQZeKAxF6s=
Date: Mon, 10 Nov 2025 15:28:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/3] bpf/selftests: add selftest for
 bpf_smc_hs_ctrl
To: alibuda@linux.alibaba.com
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
 yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com,
 wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 sidraya@linux.ibm.com, jaka@linux.ibm.com, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev, bot+bpf-ci@kernel.org
References: <20251107035632.115950-4-alibuda@linux.alibaba.com>
 <85f7a32e705dc34a7e76e4f41727076593fa4ad52ce918549103885c9719821a@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <85f7a32e705dc34a7e76e4f41727076593fa4ad52ce918549103885c9719821a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/6/25 8:16 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
>> index 70b28c1e6..fcd2f9bf7 100644
>> --- a/tools/testing/selftests/bpf/config
>> +++ b/tools/testing/selftests/bpf/config
>> @@ -123,3 +123,8 @@ CONFIG_XDP_SOCKETS=y
>>   CONFIG_XFRM_INTERFACE=y
>>   CONFIG_TCP_CONG_DCTCP=y
>>   CONFIG_TCP_CONG_BBR=y
>> +CONFIG_INFINIBAND=y
>> +CONFIG_SMC=y
>> +CONFIG_SMC_HS_CTRL_BPF=y
>> +CONFIG_DIBS=y
>> +CONFIG_DIBS_LO=y
> \ No newline at end of file
> 
> The config file is missing a newline at the end. While not a functional
> issue, this violates POSIX text file conventions and git warns about it.

I fixed it. The set is applied.


