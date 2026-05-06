Return-Path: <netdev+bounces-285020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDutCkKh+2lcegMAu9opvQ
	(envelope-from <netdev+bounces-285020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:14:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA44E0181
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7EA3008A56
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 20:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908434CFD6;
	Wed,  6 May 2026 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5JY+fsr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7633AD85
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098495; cv=none; b=ZXMGTbJ8Ql4J1utLd/k8sfBtcul9v9jk0/acgCNXdNUhmUYiq48rCOxi1NVRzHdBzVwpeG8uNVr+nIk2GcDHIbt0xlH3zy/UMaNzNs/wBzfJUQU/1IJ4ibhTAjcyobArSR/48qXGd+xDdbqxBAuW1/Eztfwpd0WPuJqQFdZKsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098495; c=relaxed/simple;
	bh=lzl+ZCEbJXomun7iKlXawoVQwcFcM6XChlqH0vheII4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GelBjiaja5AxJ4bIMSfqfjFtomFj/nl8jgGS4FIrdIrSQWFTe4SKZopUCouYtYTAA4VuewpBBSERmSTT/A5av+N0mo54JSIVR9JJZd6Nn5g/tc8i72flRASVu4Gcf7jo5DKEio2hacwzcJPUnYrwIJ+25KeE8+w0qQvYQme7RJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5JY+fsr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ee62a19730so11657785a.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778098493; x=1778703293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fe4us+YTOYlScKAXCfvhTi11WxXFiyS0yMbl0trik1I=;
        b=U5JY+fsrQi01HxwP5cFFgVT4ldcUJeT6TgrBhXH89xHM39aRGAOI/LWVCu1DL9304E
         0HvC/9rPN92nvrdKK+88TnTBOzr9WRfvc40YTLoZD4LUkrZfb0s/dwSg73Hfb2jNmkVO
         D/p+CrKoQkvpglmi0CUq3RBm9w+1IfrH8U0OtzUM2mvyGOzPieFxn9aIXaQibr3YghB0
         2hOJHQwUv6QjAsU1f7o5J+/dM4WuGjSPLlO0AJtc6LZwsF6CLchBTMOjH/BzStCqdCZt
         Rw38bsLFQBqAGc7Q5ED2zJOgEJ6iVQmTtw1cJR8UZbd+6yJGyPMGWqXBagBHMorNvOeb
         Y0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778098493; x=1778703293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe4us+YTOYlScKAXCfvhTi11WxXFiyS0yMbl0trik1I=;
        b=LKxkSTtykDqgnFaabEPBOoEIxCHkXj4+SZk2uR1SMGRHJ0+MEVDolOQwohXxlXLmFq
         HPcmRwKQue6tddd0h6MqKiYUpa2/mXjLwZlVG33lhmoKnczLUtYwyyIgxsW5gM94476s
         Lcj/Rk1ZijTdLbq2lhOkt5xl+N9R+mdg4XDTXG+GoDzvkqEeimnjz1BktK4hlyBJ3U69
         8ZgdNKidDZAy3hxNkA2ez2iZs071qRDmFcAr4FylGRzSvXAthWYutwjyzg0Uy/3v4YRp
         bJopILfN8gLgoOQFMdCtXxpG697vItZkoTR/Sp5/yEil6G4MnAlaP2/7mwh73QPHMC9D
         eTXg==
X-Gm-Message-State: AOJu0YylCTwDsPnpNL5Ir7Gopzy7njv4by8CEZ04zV1fNSmSVsSUrtmE
	OTnImzMx5r+9c7Xo3CbA8Yq+VDxHtgHhddh88clYurHNsy6cdKqlRzwv
X-Gm-Gg: AeBDieuf6qD6CuXmwrA+35BmUkmOjneJ3I8/U5K2FmsQ45YtNALeQgoQuSYb+9uaRK6
	tVbbLYmf8k62wTYj6DLip1vRi929cx2JNqZK6ci3IA9D0MBPeY7xGUDHYIscCUfWdeBtKQeDtv3
	zdlvZF+2QNLh+7CFCeIoMvvsiCl0Cmsko1ba8b0Llq/qDfoqzXkgUbuY8boZdRxfB5CFwbsUpDp
	t+g3hxVBwZ8XE48Ym7AuwI7nvR17ApRglRIAOmNVyUbo7zGi9TAtn/57xiflCka8IBK53+eR96j
	Xgj0yrekR2jG6RS8L6sV0ggZ/RAtbVLmGtUF5rcpsGNeG9q8IEprJ6x9A/MfEEyhDBV0HaNk439
	ksTk25IxAHD2I2lrD/Jyu5qSh/Rl53lDY4u9iF5nlDhIDEAwCMg+QHxOOfVtAplhxSMOJagh5n2
	k1wltvu9mCa1dkTMo7z3NioemaMg3vDl1YTcAsXzD36JvrQtueZSGo5pNuEGeITJ9AYH0AD51Me
	qcg7VzjecVxuLsx2X/zoHw9Vo0GDU9q6V568McTn/7x9YKR
X-Received: by 2002:a05:620a:4512:b0:8c6:ff8f:58af with SMTP id af79cd13be357-904d69d8ee6mr757125085a.51.1778098492535;
        Wed, 06 May 2026 13:14:52 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b4:e600:a22c:878f:7c1a:1976? ([2600:4040:93b4:e600:a22c:878f:7c1a:1976])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91b976sm1768658185a.39.2026.05.06.13.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 13:14:52 -0700 (PDT)
Message-ID: <9e691c63-ef7d-4e35-8cc4-77f83a16c970@gmail.com>
Date: Wed, 6 May 2026 16:14:51 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] netdevsim: psp: rcu protect psp_dev reference
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
 <20260505-psd-rcu-v1-3-a8f69ec1ab96@gmail.com>
 <willemdebruijn.kernel.173236793ca@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <willemdebruijn.kernel.173236793ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 77AA44E0181
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285020-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On 5/6/26 3:34 PM, Willem de Bruijn wrote:
> Daniel Zahka wrote
>>   static ssize_t
>> @@ -228,16 +237,23 @@ nsim_psp_rereg_write(struct file *file, const char __user *data, size_t count,
>>   		     loff_t *ppos)
>>   {
>>   	struct netdevsim *ns = file->private_data;
>> -	int err;
>> +	struct psp_dev *psd;
>> +	ssize_t ret;
>>   
>>   	mutex_lock(&ns->psp.rereg_lock);
>> -	__nsim_psp_uninit(ns);
>> +	__nsim_psp_uninit(ns, false);
>> +
>> +	psd = psp_dev_create(ns->netdev, &nsim_psp_ops, &nsim_psp_caps, ns);
>> +	if (IS_ERR(psd)) {
>> +		ret = PTR_ERR(psd);
>> +		goto out;
>> +	}
> Do you want to create the new device first and only delete the old
> state if that succeeds? To avoid a netdevsim in state without dev.
>
>>   
>> -	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
>> -				     &nsim_psp_caps, ns);
>> -	err = PTR_ERR_OR_ZERO(ns->psp.dev);
>> +	rcu_assign_pointer(ns->psp.dev, psd);
>> +	ret = count;
>> +out:
>>   	mutex_unlock(&ns->psp.rereg_lock);
>> -	return err ?: count;
>> +	return ret;
>>   }
>>   

Unfortunately, the way we have psp_dev_unregister() written, it would 
clear out the main_netdev->psp_dev field from the second 
psp_dev_create() call. I don't believe there is use case to do this in a 
real driver, so I'm not sure we need to change how the create/unregister 
paths work.



