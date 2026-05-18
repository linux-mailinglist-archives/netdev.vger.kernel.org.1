Return-Path: <netdev+bounces-289121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPduA2xAC2p4FAUAu9opvQ
	(envelope-from <netdev+bounces-289121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:38:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFDE571080
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3914F3005585
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4106F48B394;
	Mon, 18 May 2026 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GTy5Vpzl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCDC48AE06
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122271; cv=none; b=d6oHrrMfvfuHG6Wbkr8exql3EzcnQYOHcc/JhdO1PqUeaDNDSGmnE2rdNZxixyIpgyyyhevhWyU4Ps7UV0rhHSnlZSIg4TdwlR3bEuEi4If9DNTR515oGclK3qVB13vltOodnGtkvZQCGJnaMvxw5AabJ7jzrhOn+MrDKW2VTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122271; c=relaxed/simple;
	bh=CaqRPTgKXyI2XV4PjCcbbusa6uw3fAD79fAQWeD1M6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDO/o2SPqYRFvWeC/j0Y9CPC3tFl6sLTD76F8J674IH2yaO9JKlxZ2HVXaEirFwA9d1gTFhivD7mQ6wYFoPHK0Qhl6aILcgAxhRk43lNjB8YSrKu+LOw8hKEIjv12hu7kbQiz103fFvlzi2/pRpXd6qMBUOXkOrOYjpX2JQGF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GTy5Vpzl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fe62837baso1390844f8f.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779122267; x=1779727067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWMCe3ghcYJBdMMLjkrfnvrFFAeOfYLES9EzhhtO5zQ=;
        b=GTy5VpzlP8Acq99bNuZNx4u0hzLo54Fz5DCJ0CCvKJOQm1PwwGA3kMSx78WU0wNyDA
         hvjm04HSG6vDQzDeUsCe5FluuTyu6kRqIjHGxdokpPqfjU1NMprli2kRNEiX80pvC5N6
         eSd1OKVrMXWivL0VA/ayYiPEM1oI9opLqZukGoSxX7rvgdakCkJJnYpC8P1KNtiFrdck
         tY/Y2vM1VZsUPzwRLGmaQjXTNu+79LHkjE1S7f2TQwezGfExijV2oEDGSh329kdXcqBK
         zQwqp81/umNLiMZrff3gGrnoofepXZmfJaE0QY7tYtgZ6PHUw8E7YltP26sDynj3tT2f
         anyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122267; x=1779727067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWMCe3ghcYJBdMMLjkrfnvrFFAeOfYLES9EzhhtO5zQ=;
        b=UUEHrDkefLntnfceDgQH+UCB5Eh8jWVIayTLamyJH3M1eUQovt6VriEFzrI/8QVjiC
         k82aAY5/hfkfDIPdMWqhkY138pIwigVod4mlQZHbbKX8YqZbaxLGOKaxNczBF45CRwr7
         NrPXcW+8rGNXiPIt04U1N3XhqV37K2YWdXWcGUc9D5ZXlkNW7+gaxSubYd8nJv9Fz/Tc
         iz5Lq9iioAHMnTbKL3rUiq5ABhvlQrc6SKtCy0eSQcgBAy74J1Ehgwd1pco1rvCbLqNo
         tIYpHnnSEGIdpV3RiYzw6SicCEo0isO4s7fABNW1N3gSL+Gklk43FpDfrdZ/HPtQfNVo
         oZyw==
X-Forwarded-Encrypted: i=1; AFNElJ/WLjI0Jwr6Yvp8+uiHJJNOrZAv44qCjldfU2LBo/22HOBFAuOaFgj+spOuzyeNZ0pzGCc5Kc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYXx/uVO3k4CdT2QRp2+MVaZCaKVJ1K23Pp8TV6u6lqFZhDAJa
	g0ZkJ8tVpcAAShqZ3OV17V8exx5yra+ZcJjNHjy0kel+ujd9rizcxWe7lTZBXOsr0A==
X-Gm-Gg: Acq92OF5nJ6z5+JAo8ssbl6Nae3FHjkIX0rnFsOaPSzpVuI1te/3EBBPdDoq4HH3u4T
	6OZcmziMDqTbZiu3asx8RoPLjNXabFLBMg8IJpAzKOxQGWKx/DwtBbGZY2mY5g74s9NBTMCFq0A
	+HBJlsfSsT9QKPfhvVb1I3fMNfd9ZZzeVgaO0we0J5TL8akxvXQK4rtmpXTLisgeuiED4Lo8qF9
	dfTT6qRVZW6xcZh02RywqgH4H1KEEF57kpCMKtnXLZ2E8h6c9yT6jS7y0eLPorUjFS/Ke80UfFP
	UQiiR0vvVipKpMTDINSM6+TkdlODpBqPVkuWhVmA8QvoD/yNr2790AsbZbhgn9lqnmb7v7mHDmj
	Mm7pokOLF+n9GtGswRbptiAB5oUhD81Y2POatefK9CBb1qNS3HRuQVCH7L35+bbV9OQ5MQJbkJq
	H05ZhdDnO3dcUJ3MyAF0oDyNA=
X-Received: by 2002:a5d:64e4:0:b0:43e:b0f8:66f1 with SMTP id ffacd0b85a97d-45e5c5aebdcmr26353139f8f.43.1779122267158;
        Mon, 18 May 2026 09:37:47 -0700 (PDT)
Received: from [10.83.43.186] ([159.134.255.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e6a135f0csm19940345f8f.27.2026.05.18.09.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 09:37:46 -0700 (PDT)
Message-ID: <df2ec565-c621-4894-826a-29c3a75785be@arista.com>
Date: Mon, 18 May 2026 17:37:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tg3: guard napi_disable and pci_disable_device calls
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: mchan@broadcom.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <CAPzpGcTtw+ou+8jid_qE9w96UWt+4KUZXN-aC=44Oqkk=qdERg@mail.gmail.com>
 <CALs4sv3XH1DEB+EXmSjKvPz8Av-53HOrJ+Dc_mjOv+3EnnuV9w@mail.gmail.com>
 <a120c9f5-5818-4335-ac2c-caaf4f6f4fc7@arista.com>
 <CALs4sv2bNZkBvqKwSMOM5CtJG+GM8P6D6PMHWFJUqtNS4xw34A@mail.gmail.com>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <CALs4sv2bNZkBvqKwSMOM5CtJG+GM8P6D6PMHWFJUqtNS4xw34A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arista.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289121-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurypm@arista.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,arista.com:mid,arista.com:dkim]
X-Rspamd-Queue-Id: 5DFDE571080
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It looks like your opinion is based on the fact that AER recovery 
failure is a critical issue after which the system should be considered 
unstable. But I disagree with that. AER error recovery failure can 
happen not only because of PCI_ERS_RESULT_NO_AER_DRIVER (arguably 
considered a buggy or unsupported PCIe bus configuration). There are 
other AER recovery failure reasons. And until the system is locked by 
tg3, it has a chance to be recovered, and tg3 should not be a blocker 
here. I would accept the case where, after AER recovery failure, the tg3 
device stops working. We can consider it as an unsupported case where 
manual intervention is required to recover tg3. But in this case, it 
blocks rtnl_lock.

For me, any AER error recovery failure is a legitimate condition in 
Linux. Maybe we can even consider that the whole bus is in an 
unexpected/unstable state. But we still should give the software a 
chance to recover the system. Especially when we are talking about the 
support of hot-pluggable devices. Insertion or removal of a new PCIe 
device (without AER recovery support) onto the same bus as the tg3 
device should not cause an rtnl_lock hang.

Sorry, maybe I'm wrong and AER recovery failure is really a critical and 
unexpected system error.

Theoretically, in this particular case, we can try to fix 
PCI_ERS_RESULT_NO_AER_DRIVER and avoid changes in tg3. But I'm sure that 
there are other cases where AER recovery can fail and there are many 
other hot-pluggable devices that can return PCI_ERS_RESULT_NO_AER_DRIVER 
or cause another type of AER recovery failure. As such, it looks like it 
is better to handle AER recovery failure in tg3.

Another long-term fix could be to add another AER error handler callback 
to signal drivers about AER recovery failure.

On 5/18/26 16:43, Pavan Chebbi wrote:
>> To do cleanup on device-stop or error handling is a common approach, and it is not a problem. The problem is that tg3 doesn't track the device status. If a cleanup was performed (napi_disable and pci_disable_device called), tg3 should know that the device is not in an initialized state. When we subsequently try to disable the device, tg3 should not try to cleanup again. That is the problem I'm trying to fix. Frankly speaking, I'm adding a flag which signals that device cleanup was completed during the handling of an AER error, so when tg3 stops/removes the device, it should not perform cleanup again.
> I understand this. But my view is that you are trying to fix a
> symptom. The real issue seems to be that you are having some devices
> in your bus/subtree that don't support AER.
> Looking at pcie_do_recovery(), the recovery aborts the moment
> NO_AER_DRIVER is received by the port driver. I would like to think
> that this is by design.
>
>> Maybe PCI_ERS_RESULT_NO_AER_DRIVER is a rare case in the PCIe world, but I think that in any case, the tg3 driver should correctly handle AER recovery failure. Recovery can fail not only because of the PCI_ERS_RESULT_NO_AER_DRIVER return code. The problem is that a double napi_disable call causes a soft lockup, and not just one driver/device stops functioning—the whole system is affected.
>>
> Like I said, the tg3 driver does handle the AER sequence correctly.
> The problem really is the tg3 remove() is facing issues because the
> PCIe devices' topology is not suitable for AER recovery.
> The issue a consequence of tg3 suffering a stall during AER because it
> never recvd slot_reset() and resume().
>
> I am not sure if we should allow this fix for what I think is a
> situation arising out of an unsupported topology..
> I will defer this to Michael or netdev maintainers for their feedback.

