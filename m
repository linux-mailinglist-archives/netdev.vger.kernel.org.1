Return-Path: <netdev+bounces-125808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10D96EBE0
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C50AB20C85
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D32014B09E;
	Fri,  6 Sep 2024 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVG3vC7Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0E1494AC
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607487; cv=none; b=ClnwT7n+tUiKGB8Lg9LPpePAJlm74jDViuZJK9mDV9/NSt8iLzrPdfXR0BbHeC9wTKhPHRBBk2ZZExGZjX76T5TXRzgBpMF0cAmeJHWzO6JNMKPvx4vF0m4MgrzwbyYEW1zGJFXo8rGicDxcAZOwm4hXOc84aERpRWqV4dir3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607487; c=relaxed/simple;
	bh=3G+qtWDxOxwod7MU/uFJuVj9WRnieDz200m20VgkTPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXlZ1jHOndMT3y0BgLq7Ixd6q3jxoyOcV0Vacw1Wxd2saK6b8FcSF1wJ5A56+DSEcLOKpvXw51Ft334S6hMG4YZjV0uBbRSIhkTT7yGEpMZQK11zWGwVE42oQSreFLSBrcN0lrjyVhtGEzsr7pjlm3E1q5BUoebDfSS9NDoHjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVG3vC7Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725607484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MORqsPRc6LL8/hLy00E5QUO0Vbfyji6+N6yEF5t00yo=;
	b=AVG3vC7Y9SHOA1lcHBSV85XYhphD3WG+mbsOiwsTiu/UED8GWzX3bjqdQV+CHbPKO++J3M
	tK7+cBTnDhb3vp41MlAKC5OtL752aCCg0FVGhPPNkUoxsKMqcMi3aHd+W2I5bkF1N4qZVN
	t3rVgrOsnGoUr8JEEXVn02FtYRUlqPg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169--tV5c-HPMAuLbSO0MzfVPQ-1; Fri, 06 Sep 2024 03:24:42 -0400
X-MC-Unique: -tV5c-HPMAuLbSO0MzfVPQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-371bc601737so940709f8f.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 00:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607481; x=1726212281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MORqsPRc6LL8/hLy00E5QUO0Vbfyji6+N6yEF5t00yo=;
        b=XHUZaWHGx1lSaEaFtfS2fNx90ZSl23GOwp047OhCh3QvaN6sUNYumar819QIsNIYAy
         jnKvMBQS7oTRqxVbPbH0S8E0C1bs9uaSkpnOldmAoR68m0FI1GN/AtVO5dZDCNNd76JO
         XZZSr99j85bJ/D0Yzbk4F8oUW+EjoEY1zJIR2lAVbB56K6xeInLAeVp5BMIAt/TIXGsA
         eTEg0Dt+zl44s5elw4lZY+lYpm2nq4ZE3B6ViD3O1dTVOtQK0B74z9YepbBfdDIpLH6i
         HRTF5VyPRO4sQCqZs48YveCEBgk13Kz23eR5KYeGG8tJftzIfms+g+m3GUg7MfPttvm4
         aKAg==
X-Gm-Message-State: AOJu0YyIha4CIR0whdNM/n072YdEm933uBIVx56gEO3VsineyY7tzzrL
	SICQyHLjqKp4SbqnFcVlXgEWrFnfplaZeGHgW/FK7+02GFpbiqvEmJSaL8w2XDUcCZimB4LAAcC
	Dsyi6uQNsFhJnCNUYcuMl9QTQaoTw5xhd6A5X/y7rm9iaIi7ebBWTsg==
X-Received: by 2002:a05:6000:4581:b0:371:9377:975f with SMTP id ffacd0b85a97d-378895d4740mr871119f8f.25.1725607481308;
        Fri, 06 Sep 2024 00:24:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwGATQr2dsLhcDhhyv1A4rBB1+nUBOyR0bLPfImZK/EFdfts9/h9LFZ7CXllWNSkpjhhnKNA==
X-Received: by 2002:a05:6000:4581:b0:371:9377:975f with SMTP id ffacd0b85a97d-378895d4740mr871102f8f.25.1725607480768;
        Fri, 06 Sep 2024 00:24:40 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ca0cef22sm12752274f8f.106.2024.09.06.00.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:24:40 -0700 (PDT)
Message-ID: <a49069e1-d90b-4edb-9a9a-3d63972c1c5f@redhat.com>
Date: Fri, 6 Sep 2024 09:24:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests/net: integrate packetdrill with
 ksft
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 ncardwell@google.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 fw@strlen.de, Willem de Bruijn <willemb@google.com>
References: <20240905031233.1528830-1-willemdebruijn.kernel@gmail.com>
 <20240905031233.1528830-3-willemdebruijn.kernel@gmail.com>
 <20240905143128.0dde754f@kernel.org>
 <66da3dabc3f71_25102d29476@willemb.c.googlers.com.notmuch>
 <66da4ab570989_269be02944d@willemb.c.googlers.com.notmuch>
 <66da5b8b27259_27bb41294c@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <66da5b8b27259_27bb41294c@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 03:31, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
>> Willem de Bruijn wrote:
>>> Jakub Kicinski wrote:
>>>> On Wed,  4 Sep 2024 23:07:03 -0400 Willem de Bruijn wrote:
>>>>> +++ b/tools/testing/selftests/net/packetdrill/config
>>>>> @@ -0,0 +1 @@
>>>>> +CONFIG_TCP_MD5SIG=y
>>>>
>>>> Looks like this is not enough:
>>>>
>>>> # 1..2
>>>> # open tun device: No such file or directory
>>>> # not ok 1 ipv4
>>>> # open tun device: No such file or directory
>>>>
>>>> https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/1-tcp-inq-client-pkt/stdout
>>>>
>>>> Resulting config in the build:
>>>>
>>>> # CONFIG_TUN is not set
>>>>
>>>> https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/759141/config
>>>>
>>>> Keep in mind the "Important" note here:
>>>>
>>>> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-build
>>>>
>>>> I recommend using a fresh tree or mrproper for testing vng configs.
>>>>
>>>> Feel free to post v2 without the 24h wait, it's a bit tricky to handle
>>>> new targets in CI, sooner we merge this the less manual work for me..
>>>
>>> Oops sorry. Thanks for the pointer.
>>>
>>> Sent a v2 with CONFIG_TUN and a few other CONFIGS from reviewing
>>> the existing configs and defaults.sh. The above steps work for me now.
>>
>> Packetdrill scripts are sensitive to timing.
>> On the dbg build, I just observe a flaky test.
>>
>> The tool takes --tolerance_usecs and --tolerance_percent arguments.
>> I may have to update ksft_runner.sh to increase one if a dbg build is
>> detected.
>>
>> Let me know if I should respin now. Else I can also follow-up.
>>
>> Need to figure out how best to detect debug builds. It is not in
>> uname, and no proc/config.gz. Existence of /sys/kernel/debug/kmemleak
>> is a proxy for current kernel/configs/debug.config, if a bit crude.
> 
> Should have kept on reading. Will use KSFT_MACHINE_SLOW:
> 
> +declare -a optargs
> +if [[ "${KSFT_MACHINE_SLOW}" == "yes" ]]; then
> +       optargs+=('--tolerance_usecs=10000')
> +fi
> +
>   ktap_print_header
>   ktap_set_plan 2

I'm sorry for the late reply. FWIW, for mptcp pktdrill tests on slow 
machines (VMs over cloud) we use tolerance=100000 - put we have to be 
careful WRT fast retransmissions and timing in the script themself.

Cheers,

Paolo


