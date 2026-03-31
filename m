Return-Path: <netdev+bounces-273786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NIeCaVVzGn/SQYAu9opvQ
	(envelope-from <netdev+bounces-273786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:15:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9178D372A60
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 857E7301300A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB99D45BD5F;
	Tue, 31 Mar 2026 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EhFY386O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B02D877B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998946; cv=none; b=r5M5q8vfeeXvZ0vNJB2ofTBUUXItUme9BvjopmVd3dOfPZJK87wRAPp60zqe5iKtl9pCJsM77GSZ7fzEcC5XnFvMCzQml5jBPXlzAaA6y1dYssOT2ieU+ZsSKNKpfAnumFY2JW1FQ3kUQeZfP2B5IU4qiD8RHCdvAAitWwC6wvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998946; c=relaxed/simple;
	bh=UdFSg+9OLBF7JW5ztBTvWY89CYBaqRXqvANYuljPNus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIaErEntLzI9YoHSWmsPWdKaWGQyah71Y9wlHrHhhh/mWaikKhDrqjiLk47z30cOgZE52zjj0UUMV7G0uCJqSmRrZ/sd6DwcxC6u0/KooHzQCtmjgAF8v6JgfP3t2tuMs6GvG2/yQxMvo63TF4dAIWoIR6jTfsDD1W+gmXWjOys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EhFY386O; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-67bb3fe55a5so2077863eaf.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998944; x=1775603744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ecKbIFdB4IMJhfX2+O9VjSoDFPb0JSVEZEHdrHRvIo=;
        b=AdMz7bP81NlSuLaAGoSb2IJKunZ4HWpyiTyO0lgroKVk6DKc7iyjCDVRAFVPLD7LGV
         35kNqPwsh8ntKyDw/pLXvaqOJgG/2ZfpfQk1YGPpc6BPigVfXmgIF9YAe1BlmlF5Kujl
         zsObUeQbk6BrRzbT7HTTlvM1wBMnwsO0HpV0rh5WCivm3Wt/v/cnI2vxBeorwKdGU5l/
         gc1ggPUOoQEsngLxH4zrkJ+nZ0pZ75F6vIH0ek0EjpaccJgw3O+2uh0bRQYj13aHVxAI
         +n8ER/P6JN2pkR2v4y4DgUXcIWaHtm3lweQWWr+FYG2eraqDMKjkW6GaiWd7CgO1ORkl
         ivUw==
X-Gm-Message-State: AOJu0YzQwIg7/0oecu6hUrtg34+mXFmvgnlON9FqnVNzckiz+cVhYz91
	6wNGDXuO1jF+p/m2106yVMrMe+3MgdXqB+Q14StPOrS7a3vCbVTCFtYRDFjGpuKjbO/DgXLwYMO
	zgtJ45bU0p428pyzB/e8xELACOORX5wQicjrWOQz0UID6TxBU9zacaws6m8mHwXZE4QBGw6/YS5
	CWM2nnsJnCkHtFIJ4Z8wzkAtuvpsjPVTuhBJ/QqJJQs1+njHDuUVML3swTujewHdL+OLsa/xPxS
	7NhQr0xuw==
X-Gm-Gg: ATEYQzx98KXlt8tRQxObJi5NhpylIeGG3BcNjSfkKzkZfvP+q1Y+2liUh7Qj3WWEipM
	OXakHhIwk6aITlrlwX9QCKlXXCGdQGbOspCKaU+6JymiYX0CMvq3NRsJsxyq6SX1wJ+flaGNRRa
	UuHTHha34Q36CC5RiE+ww+xZmWyQRZy38KZOWW2YyPj1QKEEUvJcIMAm4QysUSgxmwv+c9e1+bg
	QkB46Sepfuyxd4iSHM89Vbn6A+uKY0x6nO5PNc4QAwRylcVz5c8ysNKb+wopH4bV4GplNlt5km4
	XEMLTXZDgXOpvgskICsrossTB3PvmAydQX3AA0Z1cUwG1An9TV1rN6PAD16G0W1qzue/L+RMKZa
	CM5GxuXSEpZIeyaERTPVUMm6addjA+MsWUZ+BmdjPHNTXLRgo3lcESoLjqcOAhApayrrbgPmcdF
	4z/IAeXwW/I7SihtgM0nFWsPMppOKiBIbRzdE9m0wanOrq5qN4v1MEtFE=
X-Received: by 2002:a05:6820:4df9:b0:67e:1a5d:a88a with SMTP id 006d021491bc7-67fabca212amr686143eaf.42.1774998944273;
        Tue, 31 Mar 2026 16:15:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41d04e0787dsm1917631fac.13.2026.03.31.16.15.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:15:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89cd8b56114so86943886d6.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774998943; x=1775603743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ecKbIFdB4IMJhfX2+O9VjSoDFPb0JSVEZEHdrHRvIo=;
        b=EhFY386O72J5p8yUcV3hnTlXzBHu3fR6QDLedpLPvv0BcKVIlKtinEiXg+P6EglYBt
         4c29S6j69wL++RUxZnhngKRrRfPO6Q0OqThGeFcbuhQY6o7e4U/Zp7PpEZELVuMyysmV
         Z2p7nI58aFqF1N1WtG7bfaBeS1A56EXCaJhp0=
X-Received: by 2002:a05:6214:478a:b0:89c:449c:5378 with SMTP id 6a1803df08f44-8a43a272853mr23042716d6.34.1774998942989;
        Tue, 31 Mar 2026 16:15:42 -0700 (PDT)
X-Received: by 2002:a05:6214:478a:b0:89c:449c:5378 with SMTP id 6a1803df08f44-8a43a272853mr23042406d6.34.1774998942599;
        Tue, 31 Mar 2026 16:15:42 -0700 (PDT)
Received: from [10.14.5.163] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a33a2bd024sm26393716d6.18.2026.03.31.16.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:15:41 -0700 (PDT)
Message-ID: <3550c9fb-2774-42ad-876c-cd6649fe0bc8@broadcom.com>
Date: Tue, 31 Mar 2026 16:15:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: bcmgenet: fix racing timeout handler
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com, nb@tipi-net.de
References: <20260326184529.1393438-1-justin.chen@brodcom.com>
 <20260326184529.1393438-3-justin.chen@brodcom.com>
 <20260327211331.78476a99@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260327211331.78476a99@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,google.com,davemloft.net,lunn.ch,broadcom.com,gmail.com,tipi-net.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-273786-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9178D372A60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/27/26 9:13 PM, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 11:45:29 -0700 justin.chen@broadcom.com wrote:
>> The bcmgenet_timeout handler tries to take down all tx queues when
>> a single queue times out. This is over zealous and causes many race
>> conditions with queues that are still chugging along. Instead lets
>> only restart the timed out queue.
> 
> FWIW AI seems to suggest we should also stop NAPI and the DMA in this
> case, just to make sure that the queue in question doesn't suddenly
> wake up either. Which seems fair but probably as a follow up and only
> if not too hard in itself..

Yea this crossed my mind. I was thinking we might need to grab the ring 
lock here in case we race on the napi tx relcaim. But in my testing, I 
wasn't able to reproduce the lock up with these changes as is. But might 
be worth throwing a lock in there anyways. I don't think we need to halt 
the DMA, since we clean up everything, worst outcome is a packet gets 
sent out when we tag it as being dropped.

Thanks,
Justin

