Return-Path: <netdev+bounces-298029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3JEtA7KAKmo7rQMAu9opvQ
	(envelope-from <netdev+bounces-298029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:32:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA346706F5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:32:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Mfb+N8WT;
	dkim=pass header.d=redhat.com header.s=google header.b=UdvfcPzN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298029-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298029-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279EC32B20BA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36553B0ACB;
	Thu, 11 Jun 2026 09:28:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468C3BB122
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:28:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170136; cv=none; b=lHawm0B9XKEDUXyL/JHrh2CnvpFGVBoHCL8kVqQGKiw/vYSdNzGAyt2GBXfWkYBV4hGs0EOl97BgCniyiaR0qJVEiR0p6Z5ysPoGze9D7PNwLYgVo3VsXn3plNzdJgSxH76rJC8B1z6Fn+Hy9FIVs8h2q+Vp+raNS+JL14zhAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170136; c=relaxed/simple;
	bh=9O9rAbCp6LhGpKp/O/bpx6Kd7dSvDjEqDrMSqpiXYSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1wP4exhpadG8W1A7buTYt4f8HCDWhkFbErKvpSJANl0O+sfNUtYznFhNRe14/t6sy61DeI23/QBF0fzc55tQLebzoBDTKfC9bnBd/IWDIHes1B/4Lt3V/9EnFwUkdke7bu9s9XQG2MmSYWEQ17Cd5+xa7x+TE/c5Uu1teBVfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mfb+N8WT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdvfcPzN; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781170134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3uwOwtcNS5mjb7Xnt9p/AnzVERIGWIFYdvxM1P9+a4=;
	b=Mfb+N8WT5qN0JX26DvPN8/T6SXn6ZrHlj4fUc0vVH1iSifHAK/BSQGqF8uMlJIkTrnSMn7
	d+SAJnz09cgtmC4L/Vz5+8hB6eIKQIuX9o6OC/GLRq8F5nKAf/sqkVXValIdzg+2fdlDdq
	LgkaamDT4eZy4cnd1IXFw8jf0alLeeo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-Q8XFlrqgPnuZ76JIBIPUog-1; Thu, 11 Jun 2026 05:28:51 -0400
X-MC-Unique: Q8XFlrqgPnuZ76JIBIPUog-1
X-Mimecast-MFC-AGG-ID: Q8XFlrqgPnuZ76JIBIPUog_1781170130
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef6417092so6517576f8f.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781170130; x=1781774930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3uwOwtcNS5mjb7Xnt9p/AnzVERIGWIFYdvxM1P9+a4=;
        b=UdvfcPzNPivwmdPmfFZeQ1wHGlC3QhLDOpCyi1dmQ2YXXdLhs+AgYzNDBlCUGQpHEe
         aXnHhvp0/HthClsiL2KgGYQUuWgZpVbZaLKIYLpTQFE9KfhzIEHdQcIrSm8tXK7RxMUr
         MKD0+Y6gxqmtXHx+5/zW9r5VPVbjQIsAdBddv7zF4k/Vm25HDPCOgI3Ekt/C/9ohyeEH
         TURNTSuIXTJtAZB38vh/ACi3hYMaZJSIG9dkNfm4C8jRyiJOJLiy0LfXH8fOjX50XtsL
         jCFuh9a1nY7MrERsjfKe4NyH00Ww35lv84HxHQe3E8upL0vf/dxtmFFrxymQKA1w7IAv
         utOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170130; x=1781774930;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3uwOwtcNS5mjb7Xnt9p/AnzVERIGWIFYdvxM1P9+a4=;
        b=DB731ydZ/rlQbSHISCQIMRyfeZS96DN6tN3onysxVwaiCzuPHZiMAz2MMieNnU01wQ
         9VoBziINdPzLCl0fUbf/Pe0DXvNCeDVEdcA9/vJC2OZu8+tqb7+i2qbnkg4Nztm3MuCl
         5UW44pC/Ps5OYI4tw8XGAMjmvtbbZICi+1z77pV2sbdlrJiEKz/strREBaYNXEGg8gme
         NgK2Lz7IeBK+CgRNlTHmctS8GVQ2xTaAw5zgkndJhem6fG5+FwJBolaVUW+hlVkE2y3P
         UhW11FpKRyn/CUmt7km464xhMFTMp9UX3xuGgym2HjFnF8pVwF5ooxoaOvIzg/ES0lAt
         7wAg==
X-Gm-Message-State: AOJu0YyKioJar1NVzL6S11g8dIgHezniEB80sSkUB5vYp9Rm0vxOT4TC
	rTqcaN3g+XWI3Kf+UqETI7DhMoo+/xazfgc0+xNG2rb+TE+/EzwK99H/SlzZgGxCyEVaUXzmGC3
	2FsRSL0c0JyaNNVMeYY6/S7DatJgZDgyoxnXbXsBQp2zSo0PR+362Bboa6A==
X-Gm-Gg: Acq92OGoTcaWeSvnwDjbr4xUM45SB9CWmRmtRg//Q852KzaDw2XTo329wmWrEG4YiPF
	vnYx8nqukExWPw7Eh3FekETXG9HhUVMIct9TQbf+olFIXkDdWegKXHQ6In4SETuO5dJ9GLWWpn3
	UflXK4+64oCBa4F2AowF8cXGt8Irg3n3gNQRhoHrBc9JV7DM7x4Xs2tnJzZAcc6wsX/gXfwjTIT
	NW3MVQLlNwQvU65vN2MY3b7uD+GZsxXlGviRcmYPSmXLdEf3r7E0XnZdzZNSMUPjE5UJ70IYnY6
	YKCqlKo8VFg9HPIe8kLQsU+diSqc/eHI72ECRE0gIVWCqmQ0cPcqPcJVtr69JRhoX2n5l2zDTyg
	q08ttFb8/R2wTAg2x9XvEp73zUuKhquAqJWRKujBCDFEoXuai8a37Oa3jLdfV/KniBA==
X-Received: by 2002:a05:6000:4289:b0:453:e3a1:6580 with SMTP id ffacd0b85a97d-460677c089fmr3386200f8f.25.1781170130038;
        Thu, 11 Jun 2026 02:28:50 -0700 (PDT)
X-Received: by 2002:a05:6000:4289:b0:453:e3a1:6580 with SMTP id ffacd0b85a97d-460677c089fmr3386136f8f.25.1781170129620;
        Thu, 11 Jun 2026 02:28:49 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcb13sm80443345f8f.2.2026.06.11.02.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 02:28:49 -0700 (PDT)
Message-ID: <850ba1ab-78fd-45b3-9411-97d50bb02ed9@redhat.com>
Date: Thu, 11 Jun 2026 11:28:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: qcom: ipq5018: Add GEPHY RX and TX clocks
To: george.moussalem@outlook.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
 <20260605-ipq5018-gephy-clocks-v3-3-f232d9ca0966@outlook.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260605-ipq5018-gephy-clocks-v3-3-f232d9ca0966@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298029-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:f.fainelli@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:konrad.dybcio@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,outlook.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CA346706F5

On 6/5/26 2:41 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Add RX and TX clocks for the IPQ5018 GEPHY to enable the datapath.
> 
> Fixes: f5f2b835e316 ("arm64: dts: qcom: ipq5018: Add GE PHY to internal mdio bus")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

I think here we need an explicit ack from arm people to take this patch
(and the whole series).

/P


