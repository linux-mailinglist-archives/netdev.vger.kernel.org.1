Return-Path: <netdev+bounces-268563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAdEMS83uWnVvQEAu9opvQ
	(envelope-from <netdev+bounces-268563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:12:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ACC2A88AF
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE1A4300D0D7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F4B3A9D90;
	Tue, 17 Mar 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be9Pvtb+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB435B642
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745895; cv=none; b=ogIdRjlUNLh/HSIp9vDNRrcGabTiFo4mhQREaDiuAFAh+x9MJrpVPaDIU3XALHIarkttVLoVP2XBijsw1NoH3gzeVmVzRjlX90FKVA18pavAPEJ9zZyqGZAvuTztbwDUts0SMQXfKlNmM0gntgrHylc831MBc/tf8pNWEtDFXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745895; c=relaxed/simple;
	bh=5alW7+qgou7pul86/4V82SNCh6k+laug1V9GPoTTr3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltQIqsmvlhTN2SWmTheGdaBS5jempcaoUYq3gbSkJcvX11JuoZI9TqDkC6J2u8nPUeAMgF8y/LDtf1Ek995tIEPAiAc+QmHQctdnNV3QC9R0XroqD6t0m9iJ80RMZkiRrv+6soBVhreskBHsuxj34rJH9YqyAWSIGP4gSSbM4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be9Pvtb+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a1d7cc7f0so41759126d6.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773745893; x=1774350693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5alW7+qgou7pul86/4V82SNCh6k+laug1V9GPoTTr3k=;
        b=Be9Pvtb+CettW/cb1WYLyQJs+Ve4vLJyB6q5Y0bPwC8KBNsHN5vPodK1xv3jMgRnWz
         uMNnJORX4P7LYSkRsZppsnRBjOYid0zhdGad4YLX7b+qlsmrCJ5EOzEjksvvicOAoS0H
         sl88G4dvA9ENPwG8agEDpMTTBQDbNVserVUh5Adzki96mv/JcdJ///Nse7g6JKUyVllV
         eQmJK1I6oGF4hBb0RAmouqX+Aj9qZ/xpIHnTK4FiTOTasGfrBBVF2LZ8GxyrFmQB4thl
         iQLk7+6yK18VhFRKmR7Xw4gYjMDIN6H/RUs0SxBcpHDI7JcIBACwT4GMoQUyNj4QpTri
         X3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773745893; x=1774350693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5alW7+qgou7pul86/4V82SNCh6k+laug1V9GPoTTr3k=;
        b=ixs+twOC83wgyEBWmYClp+brAhmNBWe44OV6+UyPrWK7aQMfCR3DBgW7EmIdLafOhZ
         JS0EEnHfw5n14GO5FL3OmPZc2sw5N8M2NjewYrrwl/0Me49djDuDPdmviyPdz6hyEkMT
         2nunCFjiHBK3Ff6EQ+1g6QB3HvHyD7KdomNkFW7ZmuY0BJyKUB5GI1BeQDKAFm7KVOJ1
         EwuEHOKThyajvUf7/OCLdTR0Fcdb2gbQ6TQbBd3CFZrJTaM0JBAW0YwtJi7lSpNMdR1D
         P8xfmOYJpBOm8TJ+9PVYNT3z3O9V0PxRI3oRJZtZorZXQ6tFqnL4Uy2+kMjwt6YNISfq
         4IvA==
X-Forwarded-Encrypted: i=1; AJvYcCVoGfaCXYDRVjiHGSFANFieJLMtP4El1RWkDg2uFNFDfjNZYHs+yvrRSFXWE1AHkeXtSMY0C+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwL1TUq1wRfJtkwwIiIv9RnZhjKlRfOkqPK9HV0aekfZYgal4l
	c2PPNJZ+EnCV8A0knd6hoDKvMbzTcSB6Wrt9XedpCJiICn01snv8fcj6
X-Gm-Gg: ATEYQzyn4hwvdXTT8qWdD4yOjLmUre0VuJkvtPD5Pd8DrkNryrCg1linKhnBU0nbW9R
	8DCRJGjju3sSa/H4D1/hQZVUi2bifgz95cuVh6OX1EbTLyjtEVYgnOQfkhRyH7QCvFRpHzAO7h3
	S2begw/jgW6C6gnXQXw5NK0UOBj244RlxU+VzUA4q4sv/Q59IJR+orzyEYoQgNK0HdDVo0aBiku
	Sa3we+ThMI2yZhbRPj1i4C6kJ1BSUjpTRilZDGgNqodpSxXybxuc6HQ0GjYyG2GsRcBlJw1T7bs
	oIGthSJJEn5ZP68jjK3CiAUzTZZIXWYCJ0A5n1t2W/yencpqK/hfeZ5+gutkoEScIIzph8wqJiV
	J7aeVLIJO3RKwWNB3v7BW9cAUcwUYJrv9cO/8kmeA/yN2nnncVmDRhm0I+KDwHoPWnzDTR+Vno7
	uEjx/z/WWV434sNpsf9wEJdpTfPGcTuGrya5jlTUw7acYzsOlOIgSQyzZd2IQsnGTmiCCsY+2jF
	tvXQrIZJbMiqGpxWalDcHXE6I4m7J2P4A==
X-Received: by 2002:a05:6214:c6f:b0:89c:5385:3476 with SMTP id 6a1803df08f44-89c53853f1cmr92575836d6.39.1773745892996;
        Tue, 17 Mar 2026 04:11:32 -0700 (PDT)
Received: from ?IPV6:2600:4040:93b4:e600:74c6:7732:e56:f73a? ([2600:4040:93b4:e600:74c6:7732:e56:f73a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d1579asm143603506d6.47.2026.03.17.04.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 04:11:32 -0700 (PDT)
Message-ID: <ddedbd86-923d-47fd-8c3b-70d1fed03e36@gmail.com>
Date: Tue, 17 Mar 2026 07:11:31 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netdevsim: drop PSP ext ref on forward failure
To: Wesley Atwell <atwellwea@gmail.com>, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Cc: willemb@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260317061431.1482716-1-atwellwea@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260317061431.1482716-1-atwellwea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268563-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06ACC2A88AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/17/26 02:14, Wesley Atwell wrote:
> nsim_do_psp() takes an extra reference to the PSP skb extension so the
> extension survives __dev_forward_skb(). That forward path scrubs the skb
> and drops attached skb extensions before nsim_psp_handle_ext() can
> reattach the PSP metadata.
>
> If __dev_forward_skb() fails in nsim_forward_skb(), the function returns
> before nsim_psp_handle_ext() can attach that extension to the skb, leaving
> the extra reference leaked.
>
> Drop the saved PSP extension reference before returning from the
> forward-failure path. Guard the put because plain or non-decapsulated
> traffic can also fail forwarding without ever taking the extra PSP
> reference.
>
> Fixes: f857478d6206 ("netdevsim: a basic test PSP implementation")
> Signed-off-by: Wesley Atwell <atwellwea@gmail.com>


Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>


