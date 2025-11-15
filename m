Return-Path: <netdev+bounces-238857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E35C6051E
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 13:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A39DA35E0E8
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26929B20D;
	Sat, 15 Nov 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Aw9az22K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAF3208
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763210041; cv=none; b=KOYvC2h2OiKVk36WG6qXwkxN121B7FKt2kKQ9TttuA+bKw7s2jbBX1nsVxAHM8rtNUvVn9xnalJWGBqdPn380315q8WE4+tXWkvXK57b+A3QxAsGMZCCACB0PUWuwriIlmgvBTONll5wWEPI6Gc2p7eJReQ0JYmcVkBrGHyTMbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763210041; c=relaxed/simple;
	bh=ZRDa7X2qOhicNkRilum7iyXjYeDr0de0UFoOarn43C4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=Q4/I7myY1iyOjCnwPVgx7IxRnRke1cA3iea12uxpZWk1QEJNJUegHLR9dpvs1Bgcy+zGJ3Es0q9X73/9lCXbmOAi6hNFpoGxqLNwn+LWu3ZPnHUWbZQ+PP+iXQi+/Nk9FmHnKZzdPSjgpSZudoeHbIoR7I/n4T6OQ+aThRIWvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Aw9az22K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42bb288c1bfso488183f8f.2
        for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 04:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763210036; x=1763814836; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtqnf19rAxKhCMnKuxFk3VQ746Xnyg0osYpHgquPOsc=;
        b=Aw9az22KkHe7C9tQxGS4SOET8ahdp9wxEWBgTx0JdXC1ZmJP+MCWkC10NdqxyJkYaT
         o1F1d4cqCpP6q0LEgBBb6kuhzpB1t4QwlhvVRAnB+qAkBDeWPwm7Iruu1a0rn33OJUNN
         LxzbTvrfX8ulm76Vdyi3/RQH1fCmZxaHiAS/y7U7ukCLe4AX7iirW44FUfC8MMJ1/jOI
         qGPaAm8/VjXzaM3Nx4Nf1nzm7Essl/1DU6OLT6T6osbvbqxvV421rExJ5Jax/HRonruh
         BRVw4OWxmzvBov3WjSvk+EA+BIulxyMa2+9zoIxY3g7niZBeu91dohhCO8GVAt0Au53f
         Wx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763210036; x=1763814836;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtqnf19rAxKhCMnKuxFk3VQ746Xnyg0osYpHgquPOsc=;
        b=C6VaunVaEl7noVuyrG9A6yyUZWCpAgY3R6b2fanG6F16Bi1xyQZp9a56cw7fngXt+m
         OTtmSWuCYHDJbHWo1lchKKqznm/iiviS+PP5IlO1csz+KnIU2Tclme/CqyIJr5RzP8BZ
         67EhqrTSf7wK2NvoUvf2xvX4ILmkE7SS908Uj/sVDtpkCb/3vH3zfUz9hVjSp4HaTrtG
         Z2Y3WlnfIzVtrgVMjm4tN8oiP4/kqOX/629/2VMFQLwSqyiP6oZD3s0n7SR88TIGjw+T
         VR/2FvY8ndnxk7Rs4gFOq/ZorQYOlOCN4s8Btl/Th4O4f6mfmwfYy0Eo/y1ZljVIWt0r
         Ih6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtSruydUVEYMZGusFHkkkyzy4+Y6NDkf4IIILWFJPHyoSMLs8XuEjFsdTPTfgpLESVQVXIOFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySy90rNmIu3Q6Fxh6Zn3Xg4kQ5PD+ZWjS10/VeO5smBu9hNJbW
	oR74XEunqchS/wwZANHam+91uaCpqXkejg1EI+IotYXQxn5YNkzloP32IZh4CF41e4c=
X-Gm-Gg: ASbGnctl2b32XVYp1+I5lB0s4BffAPyd0ZEgT5vLmXMKOjDmEZtw7MUPzIVb+uJ/e3b
	0UOsLlcUfNdHfB9WsNsY+185C/4vH+Ye+MnJX3N9jAzysrvT648fZQbfl4Q96PDHds8eGbHVnov
	eVTj09ndrnx4B3KZdep0lULbgBIbrp9KWwVUE1zv7GObbj4Ts0DUqzFf4HIVmngBDCMue0NkxEl
	9o9PWuj/P+/hdBjYRO27KkgPG989TXMuNbzcgVRPFeoIN2GPZMcEATzz4G2DuF2TELtZSF3IQZS
	HmR6TIPuZ8blD2TuJq314HRjUrWwDt5DKxNm8tx7jJY391Ch49m//aidW5l6V/GazXr9mXT0NVn
	2K3ByWUR+9Qaz31zGu6MC+66TfM+lXXH20RFt51R7kJ9cJKfEQIy3bs0SuvZ123oa/F7yeJtt+8
	edobJssa3wEI6qLgwFE9rp6fmLtJN9YEbIb984+sQ27gVaDh9oAyXubw==
X-Google-Smtp-Source: AGHT+IH68hNngwZhYpd9vquoCIPlgcJ1vPhNd3/4WnrvDBsF+8EDaoeM+ZvmKTzsA5mzG3phFO2Aaw==
X-Received: by 2002:a5d:64e3:0:b0:42b:3878:beb7 with SMTP id ffacd0b85a97d-42b5939896amr6087952f8f.43.1763210036197;
        Sat, 15 Nov 2025 04:33:56 -0800 (PST)
Received: from ?IPV6:2001:a61:134c:8401:9dee:c6d3:2820:beac? ([2001:a61:134c:8401:9dee:c6d3:2820:beac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm16011805f8f.18.2025.11.15.04.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Nov 2025 04:33:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------nHX7CPgwLi0J9jNmBXoWSU3W"
Message-ID: <701e5678-a992-45be-9be3-df68dfe14705@suse.com>
Date: Sat, 15 Nov 2025 13:33:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cdc_ncm doesn't detect link unless ethtool is run (ASIX AX88179B)
To: WGH <da-wgh@ya.ru>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1c3f0582-4c92-41b3-a3db-5158661d4e1a@ya.ru>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <1c3f0582-4c92-41b3-a3db-5158661d4e1a@ya.ru>

This is a multi-part message in MIME format.
--------------nHX7CPgwLi0J9jNmBXoWSU3W
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.11.25 09:58, WGH wrote:
> Hello.
> 
> I'm running Linux 6.17.7, and recently obtained a UGREEN 6 in 1 hub containing an AX88179B chip.
> 
> By default, it uses the generic cdc_ncm driver, and it works mostly okay.
> 
> The annoying problem I have is that most of the time the kernel doesn't notice that the link is up. ip link reports NO-CARRIER, network management daemon doesn't configure the interface, and so on.

Hi,

that strongly points to a race condition.
Could you try the attached diagnostic patch?

	Regards
		Oliver

--------------nHX7CPgwLi0J9jNmBXoWSU3W
Content-Type: text/x-patch; charset=UTF-8; name="ncm_bind_uncond.patch"
Content-Disposition: attachment; filename="ncm_bind_uncond.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi91c2JuZXQuYyBiL2RyaXZlcnMvbmV0L3Vz
Yi91c2JuZXQuYwppbmRleCAxZDlmYWE3MGJhM2IuLmQwNDJiYTU3NDIxNyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9uZXQvdXNiL3VzYm5ldC5jCisrKyBiL2RyaXZlcnMvbmV0L3VzYi91c2Ju
ZXQuYwpAQCAtMTg5Miw3ICsxODkyLDcgQEAgdXNibmV0X3Byb2JlKHN0cnVjdCB1c2JfaW50
ZXJmYWNlICp1ZGV2LCBjb25zdCBzdHJ1Y3QgdXNiX2RldmljZV9pZCAqcHJvZCkKIAogCW5l
dGlmX2RldmljZV9hdHRhY2gobmV0KTsKIAotCWlmIChkZXYtPmRyaXZlcl9pbmZvLT5mbGFn
cyAmIEZMQUdfTElOS19JTlRSKQorCS8vaWYgKGRldi0+ZHJpdmVyX2luZm8tPmZsYWdzICYg
RkxBR19MSU5LX0lOVFIpCiAJCXVzYm5ldF9saW5rX2NoYW5nZShkZXYsIDAsIDApOwogCiAJ
cmV0dXJuIDA7Cg==

--------------nHX7CPgwLi0J9jNmBXoWSU3W--

