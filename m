Return-Path: <netdev+bounces-295819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qO4gAg3CImoxdQEAu9opvQ
	(envelope-from <netdev+bounces-295819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:33:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A7648309
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:33:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.s=20251104 header.b=nBOVrQT4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295819-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=riscstar.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F225D30241A8
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E17130568D;
	Fri,  5 Jun 2026 12:31:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9582D2496
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 12:31:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662673; cv=none; b=c6RRgMKipPr3iYsQXZFdQRAN4G1T+/GXEqTn74NWUPm8Oy9QJgm6pFghOUEZplzF44aOaAFkSrKzRVYJPi50JDVUSd/qug8RKfYjshrpquRij+7RJrmgFEw/gdhwZTXB1iPsAL1/U3lXriJR+FZUBKW/xUCUGWoKFLP7jAhDjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662673; c=relaxed/simple;
	bh=Cco+vFiWz8nH8jHJl25YPtjf0AjyxuJKLseQuLXyV6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1faAtIRfH8rLV5Jr+52zc5TyKsOMRqjiHkbEvYVE1Hc77HCpTFlrP9oR5HaY2vOF2qP5nJL94AOEJzUOC3JpcQjlnfNkvoC5w/33DPOyMpNyYFm5Pllg7LaDgdWXDBAov0xCTEYTraCM/OGrkkEQVqC9lwNYODrlz/qsmvwmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=nBOVrQT4; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-915906a4becso220282185a.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780662671; x=1781267471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOWy2W3C8F0epU9cKoqDrCPhuhX/iOel8Vt4x+uvwak=;
        b=nBOVrQT4YuSrnvW4GHgMPILRAtsDd3zeSyGZP68L6OViiwFPurfZmgiMEDG0GjF/75
         HU/XE8oHyiV8w9m0djX27oMSyCKIvcoaptEoafCXz+fjWI22opoRTEbc6BfQpRi2fn1W
         3oE3fS3JLczE5L/mNu5q27BlsuOTsgP+3KQLXJAWCa5aEZLtpmsEeA3KbTlCv/Z7ZZYb
         4vvLqFYruB0eztoNQK+WU3P+E36W7Mm3JN+mA+ADJjE/uslvAxcYeK0ibk5/SuHoQuEc
         VWs5zZEQd61hsXCM3thBKpD3gpcyHIQAYbN9MRoNmqCMOqJHVoxBHNUpSneWNmCP1LqQ
         c8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780662671; x=1781267471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOWy2W3C8F0epU9cKoqDrCPhuhX/iOel8Vt4x+uvwak=;
        b=ShYldECh6e2dPW6GrcMOjzc0u+TA9kFARaKSodmFN7hyztH1Z9jSm5nm5XtpV2fk5X
         2eFSd125YRcKhfiEAu2wD3r1ByzL1/aTH6yv0SiaYE0vEPiSftpX/zu8LP/B4kZsTMa4
         SjPPpjRW+GdszztWf2tmWt/Z9D7YfppA5EsWmiUFVMi8Evv9+NAZ9WIDJrzOkJpumGQW
         fd3JfEkY73YA0RCbB45PtE2LLnMIv0G0Uj9m9xYp+5ltlpJnrXhoPkU5O6/TATsDB0pH
         iMIFmilRtX/xlD3DKPNlVd1tAH0tUHFXEKcImTf6zcuSwH/+JuW6eEMAUTn90Zn/Hc9q
         oLFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xfbSz+K/tLxlWVY1K4IqivDzDP6dMMrbobp4KTzoPE3ItwWFBu7zdFiUe9utEmTD6qGUFF/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQIOHIQblfu4ZN+g9Lt0b8Ecz+nbnL3SVXCvJhNmrCdKWrAN7
	J9rGFpQiSglQWea7KQeui4H5RgM464NcY/LeTy5UIJreKZvPrLv5C+DIDWb3mFFdRNQ=
X-Gm-Gg: Acq92OF/enAgEWYkP1sv2W9Bnq4MKNIqoxcCmW8pLoSCcgGZD/Mvo0M1GeLSw2rk036
	aPXVWawkx9P4WhXgoYM+yQLSJ+hfk4tpFRVP49RXroK4o81kZNcOfWd+RJOnz6N1puvG53QhtQd
	Ft1f49GuwLX1GqcldzXNzcEWMRYrp6n4F45VK+WnwepmG2DGpbY/pbPAIH5uq5+RX698qTTtEew
	3ABhed2dA5IaL9cpHVImWBFZ2huK3DlB0GWlbRrl9UQvKmmTy5utPN3eHc682sAtKxg4c6AMPwQ
	sMuhtae8gXhsXIR1rgoXtwc5HgkqDoZyrs0QF4z13iJYC+qZJyLpxPMYZtysc+ok/6gs8U6awmN
	dBr7cRtnxQc5C2krCjNyzs0WRET9iOMDv+ArGOft0I2dHNkBIuZmz4t9oUMbKYRZljqO1PuBj7S
	IIMQGCzau/0dI71ao0li8uXtjOVH4/7itndC8=
X-Received: by 2002:a05:6830:6685:b0:7e6:deb1:484d with SMTP id 46e09a7af769-7e70c7b1386mr1725355a34.13.1780662284484;
        Fri, 05 Jun 2026 05:24:44 -0700 (PDT)
Received: from [172.22.22.234] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7974f22sm5817653a34.25.2026.06.05.05.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 05:24:44 -0700 (PDT)
Message-ID: <bd2c09d4-462d-4392-bb3f-ca91b2f08bd7@riscstar.com>
Date: Fri, 5 Jun 2026 07:24:40 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/14] dt-bindings: net: toshiba,tc9654-dwmac:
 add TC9564 Ethernet bridge
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: weishangjuan@eswincomputing.com, linux-gpio@vger.kernel.org,
 inochiama@gmail.com, davem@davemloft.net, devicetree@vger.kernel.org,
 kuba@kernel.org, me@ziyao.cc, hawk@kernel.org, arnd@arndb.de,
 konradybcio@kernel.org, mohd.anwar@oss.qualcomm.com, hkallweit1@gmail.com,
 pabeni@redhat.com, ast@kernel.org, maxime.chevallier@bootlin.com,
 bpf@vger.kernel.org, boon.khai.ng@altera.com, linusw@kernel.org,
 andersson@kernel.org, sdf@fomichev.me, linux-kernel@vger.kernel.org,
 livelycarpet87@gmail.com, a0987203069@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, daniel@iogearbox.net,
 john.fastabend@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org,
 conor+dt@kernel.org, rohan.g.thomas@altera.com, gregkh@linuxfoundation.org,
 Daniel Thompson <daniel@riscstar.com>, chenchuangyu@xiaomi.com,
 andrew+netdev@lunn.ch, mcoquelin.stm32@gmail.com, edumazet@google.com,
 siyanteng@cqsoftware.com.cn, wens@kernel.org, brgl@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 julianbraha@gmail.com, netdev@vger.kernel.org, chenhuacai@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com
References: <20260605010022.968612-1-elder@riscstar.com>
 <20260605010022.968612-11-elder@riscstar.com>
 <178062720108.1744752.12164392208085928081.robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <178062720108.1744752.12164392208085928081.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:weishangjuan@eswincomputing.com,m:linux-gpio@vger.kernel.org,m:inochiama@gmail.com,m:davem@davemloft.net,m:devicetree@vger.kernel.org,m:kuba@kernel.org,m:me@ziyao.cc,m:hawk@kernel.org,m:arnd@arndb.de,m:konradybcio@kernel.org,m:mohd.anwar@oss.qualcomm.com,m:hkallweit1@gmail.com,m:pabeni@redhat.com,m:ast@kernel.org,m:maxime.chevallier@bootlin.com,m:bpf@vger.kernel.org,m:boon.khai.ng@altera.com,m:linusw@kernel.org,m:andersson@kernel.org,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:livelycarpet87@gmail.com,m:a0987203069@gmail.com,m:linux-stm32@st-md-mailman.stormreply.com,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:alexandre.torgue@foss.st.com,m:richardcochran@gmail.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:rohan.g.thomas@altera.com,m:gregkh@linuxfoundation.org,m:daniel@riscstar.com,m:chenchuangyu@xiaomi.com,m:andrew+netdev@lunn.ch,m:mcoquelin.stm32@gmail.com,m:edumazet@google.com,m:siyanteng@c
 qsoftware.com.cn,m:wens@kernel.org,m:brgl@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:julianbraha@gmail.com,m:netdev@vger.kernel.org,m:chenhuacai@kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:johnfastabend@gmail.com,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	FORGED_SENDER(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[eswincomputing.com,vger.kernel.org,gmail.com,davemloft.net,kernel.org,ziyao.cc,arndb.de,oss.qualcomm.com,redhat.com,bootlin.com,altera.com,fomichev.me,st-md-mailman.stormreply.com,iogearbox.net,foss.st.com,armlinux.org.uk,linuxfoundation.org,riscstar.com,xiaomi.com,lunn.ch,google.com,cqsoftware.com.cn,lists.infradead.org,bp.renesas.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,riscstar-com.20251104.gappssmtp.com:dkim,riscstar.com:mid,riscstar.com:from_mime,riscstar.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E71A7648309

On 6/4/26 9:40 PM, Rob Herring (Arm) wrote:
> 
> On Thu, 04 Jun 2026 20:00:17 -0500, Alex Elder wrote:
>> From: Daniel Thompson <daniel@riscstar.com>
>>
>> Add devicetree bindings for the Toshiba TC956x family of Ethernet-AVB/TSN
>> bridges.
>>
>> The TC9564 contains a PCIe switch with one upstream and three downstream
>> PCIe ports.  The third PCIe downstream port has an attached embedded PCIe
>> endpoint, and that endpoint implements two PCIe functions.  Each internal
>> PCIe function has a Synopsys XGMAC Ethernet interface capable of 10 Gbps
>> operation.
>>
>> The TC9564 also implements an embedded GPIO controller, which exposes
>> 10 lines externally.  Some platforms use these GPIO lines, so this
>> GPIO controller is managed by a separate driver.  Other embedded
>> peripherals (like a microcontroller, SRAM, and UART) are currently
>> unused.
>>
>> The GPIO controller is managed by registers accessed via MMIO on an
>> internal PCIe function's registers.
>>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/net/toshiba,tc9564-dwmac.yaml    | 120 ++++++++++++++++++
>>   MAINTAINERS                                   |   6 +
>>   2 files changed, 126 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:

Thank you for this report.  After upgrading the "dtschema" package I
also see these errors.  The "gpio" and "ethernet" properties will
have an "unevaluatedProperties: false" constraint added in the next
version of this series.  The name of the binding file will also be
correct in the MAINTAINERS file.

					-Alex

> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml: gpio: Missing additionalProperties/unevaluatedProperties constraint
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml: ethernet: Missing additionalProperties/unevaluatedProperties constraint
> 
> doc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> MAINTAINERS: Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260605010022.968612-11-elder@riscstar.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 


