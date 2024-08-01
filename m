Return-Path: <netdev+bounces-114905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EE944A71
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F455B2150B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABE118B488;
	Thu,  1 Aug 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftF+TcbU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409347406D
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 11:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511984; cv=none; b=G7a4CeJHy21h/Kaj4XgmYqxCLp5HW6y3PzrTjudT85fA5gsM3JKNxu74jIIe9c2TT4sJ5huWAWPo0ETSjE9v9pdkP2m0QCqotiHKlFjJsf28cCAb44B2wKmVlGNXW70GDFErsyuvzWQd0HTkGaFSxI0Bs/Kb8ldmlbJtiDEOvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511984; c=relaxed/simple;
	bh=NVxKZacR4ggHfi0ekvokgMJaA4xRHfmBd06PwTrJArQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Py2KJDqzK5yUUWWYVDGEGQDgdZIG4HCxx+HIo6cIGikNuiqzb8iK7G/1kq5XrJw50glw1pvKeTX2IfEmYkWdPzWwqy2FbZSk3wJpFQaTim7T8K/DHmRzCRv+oa+wLqVYh9DTiCpcJWnII7xV0mb0xyzZpPMgpvEz2JFnhorN694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftF+TcbU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722511982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xv12PaIAcB7S658aZzUFkbFfY6hrinTiCq72hw+tJtA=;
	b=ftF+TcbUnD/8zRwaueZFkjMAo3QW3e8vEaHWYBM3hpdc7crwWQfnI0GOkuV3GAxSrx4Jm8
	W+W5CRi+ms0EMAxMhmYdhlSkkGnV9Y6eWr87SiJW5MUXcGNQV1k9ND7NLgDk1G4arhiqxP
	O6IRDbEVQF+Dd6Tc0wjRd4ga3jfp4Qs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-39RBHYHONVO7y34WXicPOg-1; Thu, 01 Aug 2024 07:33:00 -0400
X-MC-Unique: 39RBHYHONVO7y34WXicPOg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428087d1ddfso10637895e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 04:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722511980; x=1723116780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv12PaIAcB7S658aZzUFkbFfY6hrinTiCq72hw+tJtA=;
        b=pYfR1/M3lWWZFhv4d2HXnM2fOqHUdsqeaCIbUcMwv5Z/d5AVHxsAnVID2WmLDpTwul
         F/Yl+byhwmYxwqYnfpZAzHeYGLiy+yzLxxymGw9nXvRy07GZSgfRkchnew8JUIzBTMlb
         6YUNa2T0HXGGeKa3wqDaiSXvp/4v4smLIQ3FcnOyum/0qQQx6kMu41+cRGyZtxIvgaEw
         fHOJnkuuv6FeC0IDiVNsHgJU4AlIXASgFxZY9vAimzr8bHgPwpyivxHZit9rNpfRp4lL
         Loa3I14e0AguW69DTBqzzkXMGGxOvWSGxl0fKBHOJ/55ATZoly5oMHNPVm5Qh4KhUlve
         YUiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBy5V7YIiFMEPEln0RazAMnFjc6c7/6CcFM6t9D+mPWVwM8YQ77lGsHlYgVgR95MZ1isR9tLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jxO0EDw9WMJXN6OpYCGquu1Q2EgppnSwnWZF7GAVwfBVHLeG
	97buyM9aHc/7hAEyV2FJQMI/LA/5rSVeqykRQgaOop8rQGR9ROITkdR4cHWRwd3QbQbUaE5f5RX
	SzutY5TUvJgyOLTRhWgjQkwwRC93rbRp5dt2mIP4axRGyLl0pl6swXw==
X-Received: by 2002:a05:600c:3b06:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428b4ac4421mr11236885e9.3.1722511979577;
        Thu, 01 Aug 2024 04:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ4N/kWiL4s9PL+F6UGt7Qjqleu5cLIhxdrLUM/UKEq3FAUi044rArg5KgwbbitMspVzOfCA==
X-Received: by 2002:a05:600c:3b06:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428b4ac4421mr11236805e9.3.1722511979104;
        Thu, 01 Aug 2024 04:32:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bac5ff2sm52723685e9.25.2024.08.01.04.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 04:32:58 -0700 (PDT)
Message-ID: <eb3ad0da-9ed3-42e3-9a96-7be81841fc93@redhat.com>
Date: Thu, 1 Aug 2024 13:32:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
To: Yanteng Si <siyanteng@loongson.cn>, fancer.lancer@gmail.com
Cc: Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 si.yanteng@linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
 peppe.cavallaro@st.com, andrew@lunn.ch, hkallweit1@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, diasyzhang@tencent.com
References: <cover.1722253726.git.siyanteng@loongson.cn>
 <359b2c226e7b18d4af8bb827ca26a2e7869d5f85.1722253726.git.siyanteng@loongson.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <359b2c226e7b18d4af8bb827ca26a2e7869d5f85.1722253726.git.siyanteng@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 14:23, Yanteng Si wrote:
> The Loongson GMAC driver currently supports the network controllers
> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
> devices are required to be defined in the platform device tree source.
> But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
> (implies FDT) as the system bootloaders. In order to have both system
> configurations support let's extend the driver functionality with the
> case of having the Loongson GMAC probed on the PCI bus with no device
> tree node defined for it. That requires to make the device DT-node
> optional, to rely on the IRQ line detected by the PCI core and to
> have the MDIO bus ID calculated using the PCIe Domain+BDF numbers.
> 
> In order to have the device probe() and remove() methods less
> complicated let's move the DT- and ACPI-specific code to the
> respective sub-functions.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

@Serge: I think this addresses your comment on the previous iteration, 
but it would be great if you could have a look!

Thanks,

Paolo


