Return-Path: <netdev+bounces-245845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E049FCD9257
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE53930173A8
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF962D7810;
	Tue, 23 Dec 2025 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMnZuqin";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eujFDi3Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E32C0F6E
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766490300; cv=none; b=CC0mhV5LVCQHBJhunT/ZbnpXfoCDNHRqBb/5UFq3BT3qn3O+6dV51aOMNjbRi6vFLjjpKBzbyVJ5sYBaYXe5n4zgX3g34swFKcsYogjODq3sxyeAGyacpjWF1K242j+bP3JO7JuiWyRCyVRv7tutqpyZhrc0QyopQp1iP9ZbXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766490300; c=relaxed/simple;
	bh=PoWhOw+nfc/VpWAeGXyfBJ/eaqYMCIHlPZCe+FiDD0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2kv1CCvZWFdBbWSqesiyY/4AT6btfIi5meSr8QMQz6DYymeJtxOfbKe/i3DuTAt5f/148NLqtgUWWRdP/WIb1rH432iUdLKVhgQoNYNcnh3CfsTIKK/gbWzqHIk2+JORXkE1cODcMpeHOgt7jxWDM3GF7CUeNV5fCy4H3ratIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMnZuqin; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eujFDi3Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766490297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fa4EFzzfETnupi6k1YGjJDaAIRvY+onKMclFgCyO/0k=;
	b=bMnZuqin3Qesh4gd8I9zg8M3EX/Q0KvSs/9Cnwiqhdx02zopJcsgx2kxnZAU4Wus4ANGKf
	x9RHgYyl3+yzotnht1odveHRstZjJ63ajTI9hnEskFb62dAkLz285/Djgy9oOHpA9hrVuf
	yUMlfeAjc+F3VjN7bUop5H26qC9AR6M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-a6cDoht2MO2g_NNQmlpoAg-1; Tue, 23 Dec 2025 06:44:56 -0500
X-MC-Unique: a6cDoht2MO2g_NNQmlpoAg-1
X-Mimecast-MFC-AGG-ID: a6cDoht2MO2g_NNQmlpoAg_1766490295
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fd96b440so2565499f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 03:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766490295; x=1767095095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fa4EFzzfETnupi6k1YGjJDaAIRvY+onKMclFgCyO/0k=;
        b=eujFDi3Q+WFpsK1XAkFbaAW6TpvUbygS9175wIQUyG24OYoFJ30ftwVD7EH2SyefLX
         sywDItJOl2lriHR9/bkcYSmjna3YLuDOJSTQVhK7rZB+RA9Bt47z/i/fqR+xyLb0qACy
         j9qm4SXZGVB91vSJQSp629SJ5s/SxaJkBnmGxcSrqeF7mMWgZzix5gdXlyyOk9p+O5qg
         wUTpe1DSyxSlf4l/11M+O/NY4ygiql6YUW8AiIYXjzDXzT9OXJp0dJg55c8NTJORvkgg
         baq7O5eyMLY9GDRs/yVNqyCWcdfSUAIqP/oYAwGFRo/DfqAUPk2HqwTvm9jfWAroqsgr
         LBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766490295; x=1767095095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fa4EFzzfETnupi6k1YGjJDaAIRvY+onKMclFgCyO/0k=;
        b=fv6BrB0m+ks14zqUngf2NLMs4lAfy48rI9SmxYpIb/nKlNjlslqcYbu7DQXJHfDAxF
         ZuiqJu/fyUXmWq7a5gHnxTt/8zqRhj9/KG4529FGD/8VeGn1fDPb2MGX6q+x+ewjN3UA
         QXPMtcDKf1jyiQktWN04mXGoPDCi+Rd1P3xpmgTZB5WCyqIcG7cHf8fthNJzD6F52/Zu
         jedWDE/flsd5Jr5PpVqImdlILBfsnrl9oEvV6YoDKqKn9meHs/BwiENTw7e5eArUUtq+
         TUciwwh5c1nSgaTxB/xe/H5K6arp9gLoE/0nhAwqttaKJ/+aKBqUA0EuLq3X+1VNUmd2
         ppnw==
X-Gm-Message-State: AOJu0YyTjHrDeG+qEAd6Gr6EJTvr6+lH4fg1Nf0wufLJTbPz+RVcaIS5
	OJBSheqPa+WZjkH6Jrc2xtO7QTIq+YngzDSyZTMJsEHd2hprQZGDZOWTZubEauQ4x56EVTI1n74
	RBuz91KEPubDvCesxzE7TLPfzUHl06Fa8aLNaMttLnDrmG/J7HspfvbwQWg==
X-Gm-Gg: AY/fxX4ITguaHqEzupUhF2z8Ie3yK1m64eN/OSVFPMxAMGU3eK3og1PW7Cn9cCDqRnI
	N+8ufsQ34F8ARPGEszulx4s4rMGjLcZ9uG6nqrgvsRLdGuA/9ojnXY3gwfcU/RP3gcF3EeppU0D
	qyhcjrNmvsYhyPHdiJ4ph7vV8L3I/cSB/IKxMTKJ3XRXhzWs4afV5fyU3Szouc5Nojr10oUzr8F
	SL/aZdJsLp9Zvec77cKRsFtNnLxox52g8LM7Ljk0SCVmEMAGF3/b6jQpKsVMIijKrUkkfZMmY0T
	HQU+0Mmi4ze/8JBkms8EhHix/qS/x7HXH7kWdhVJq/P3xU/E6ceB6t9bwScDrkYwzWYN/HDAzQu
	mj4JlFTifgq3+
X-Received: by 2002:a5d:52ce:0:b0:432:5c43:5f with SMTP id ffacd0b85a97d-4325c43025bmr7159554f8f.40.1766490295048;
        Tue, 23 Dec 2025 03:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQLxIehr4SCLFNV0ruVkupY8XPaxEnUF7XQz2DeO9bUzCELq8u2WuAs2F67yAtiU4rUvK1zQ==
X-Received: by 2002:a5d:52ce:0:b0:432:5c43:5f with SMTP id ffacd0b85a97d-4325c43025bmr7159541f8f.40.1766490294625;
        Tue, 23 Dec 2025 03:44:54 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea8311fsm27300084f8f.28.2025.12.23.03.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 03:44:54 -0800 (PST)
Message-ID: <b3d2a2fa-35cb-48ad-ad2e-de997e9b2395@redhat.com>
Date: Tue, 23 Dec 2025 12:44:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb()
 failure
To: Petko Manolov <petko.manolov@konsulko.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, kuba@kernel.org, stable@vger.kernel.org
References: <20251216184113.197439-1-petko.manolov@konsulko.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216184113.197439-1-petko.manolov@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 7:41 PM, Petko Manolov wrote:
> In update_eth_regs_async() neither the URB nor the request structure are being
> freed if usb_submit_urb() fails.  The patch fixes this long lurking bug in the
> error path.
> 
> Signed-off-by: Petko Manolov <petko.manolov@konsulko.com>

Please:
- include the targed tree in the subj prefix ('net' in this case)
- include a suitable Fixes tag

Thanks,

Paolo


