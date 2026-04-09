Return-Path: <netdev+bounces-276872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN9bF2NZ12lqMwgAu9opvQ
	(envelope-from <netdev+bounces-276872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:46:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B53C735F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB1873012CBF
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419F3859D0;
	Thu,  9 Apr 2026 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3K5vVVf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnOxYRZ+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2FF37F730
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720798; cv=none; b=Qu7P5GWB3qOxvgd1Iqh+kLhc/x0ywHvdk1yuVM2ASTu8plpnO+JTwCrwpVD7DWeDIFp5jJgyVQnyT7DSVG+9V3edmgb0KfVi8uTTj/bYkCB8O0p0Z/GXuATTUKenXkvcDtg0+kod1DH8oCih5UieQjc43l5cotGCbFvFVm6Zt6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720798; c=relaxed/simple;
	bh=BP2KcMnRF0zVH5NvOgOE63eTVnN+q88HxTx49+dIyR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqZTqG4tzcpVcFzzCdo2FHbyZ4O8PCKoDdpzkDVvbxyubFwGGyEpO38vYssrs4t3z21lx8JXLU7uTxvDqnf6HDDisht5Xb4XVjsRjONhpT/D933vqcDPlHRBG209o3DFmdnf6nijkgC2YGr3+XOxBBkT6zSxjT+4IxU6IqjuaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3K5vVVf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnOxYRZ+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775720796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzq2GXPPGMC+IRIbq9cbXuo6a7PNhvIxJFbGIOX7fT4=;
	b=Q3K5vVVft4/c4bNW4s3mMgTwYUuwLw+i0o0fcJEARyhx+fZXeFSJavg7LEtMclQVC6BHXs
	bGC2In8MqTKkhbzl4/bkmjaS+89R+QCIPGj+VhpXCjvc/X6/dvTSeQbDKbgI/YvhiDsChk
	BHTpKGNtxy2D1D+OG9kaDqT5zvWAm/8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-XiPkIfivMy6QkbBqUhNNOA-1; Thu, 09 Apr 2026 03:46:35 -0400
X-MC-Unique: XiPkIfivMy6QkbBqUhNNOA-1
X-Mimecast-MFC-AGG-ID: XiPkIfivMy6QkbBqUhNNOA_1775720794
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d0de4bfb7so662188f8f.3
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775720794; x=1776325594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzq2GXPPGMC+IRIbq9cbXuo6a7PNhvIxJFbGIOX7fT4=;
        b=hnOxYRZ+m6YxaRY0rSfneJ36lhvq6tpIm463nFzQcI+9YWfpqQuFKk0A7ZoQ2owB0X
         FPPkE0OizlwYbxzCqvz0A5ad++fU10ZRVRWEM+NdSmeVZW9OByBnw9sFab02rD5Os6fT
         9oOjuY/0Umh005Q5vZ5e5sGMgwvGb05rwDZHtYgLMwtPwO1NK8flFlr6q1JRWPXFnaas
         RiJs7lasAsoMFJ0c9S/jBXl4RmACXjGOdCBI5GDYSvHaHnDfP0FWR12H6uh/PkLKOgB3
         Zc7hAalI9OKIhh4q1Bh3szDPonqpZsHQtGVz194KcZfak71IaR5pzCAoOzMqoQAo4gUj
         Ul0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775720794; x=1776325594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzq2GXPPGMC+IRIbq9cbXuo6a7PNhvIxJFbGIOX7fT4=;
        b=BZ3nBBe+lo8CaOFq2muog7VPGB+ApPFWWRa4sZ1S6EdnGnRz1hk/6HDecxIl2apGkU
         MOToDSxkesuanIQFXzClQEQUkf550ky+Fyuud2YqxP26GlTUXwhSp5nnsUHVb0ipfJ/Z
         YQ2+svfb68Tw9fGyqQ1HdxnIaHlRTcb64TXqJrqfYXEZ0oOKFpliCmfaONlefQpbtN1w
         rtWwo2Hif9FgoyM5TVROCfEAnNl0D5jm3DROMOTexD808qGqxAAYme4yXJIpJc9OsQ4A
         OuLkkzQ9CMiO40QucHgu5KpZj+jscFEcmZS169cMayCPvqXYyLldI3lpy5LN9jtDDR1v
         8eug==
X-Forwarded-Encrypted: i=1; AJvYcCWRcQhNalYYZBhCSlqmH//13VeM0/52wdA+I416jkG5/ZWNZN0gw+veVJUC8bT28zyJHrnnsUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDS+xTMuBwCyHGfoclQ8n3TJMY+NJdxHGemKv04JzOp6mlQoFv
	PCPD/txuAwDb4f7AfHfbRI5RfEB0ZkWBB/odJ1xexdZPV2812AW5oBeHT+/Zt0RFvVXijFagfVM
	odbW7NqnuhfJmmQ6BRpX74qrFFzS8AGtWrbebCojgo2P1mILQSuKouoDfeQ==
X-Gm-Gg: AeBDievoiN35yBgSgNQmqwYbDCe0TlbBCn1Bw4/Ovrf4nly0HxFReS6Pt9Z+PoRcKCx
	8gsGi1jRxA9inl+h7JJHuy4BUZDVLoZmWX9Q8LBxbsckOoYElY2CPRd3BB2YYSJ1TICKrWk33th
	wqyyMgaH4koO2Ofm5rN0qdb73FY5KVOdaJ+Y0QTIi44PulGykOR+54DXYszQiTi/Z5hXdteClW9
	oJUf96zqzFGjgog+tvQEzoEoNIJGETxw9grBpNwdzR1EAc73KjHol+LPM/p4B90WN0FiEPaTlpE
	3SeCvDN4xGY5zEMGp+te0q9c95rUKD/pDYfR0Wms0iZ0EhlZuLApko5Ls46iG+ceP8CEr8FVZzU
	2XVtw1xcRF9l3vDgteGSnJtXWsSfN40CcYfmjnbA93yQtd9MXCiImaOC0
X-Received: by 2002:a05:600c:3b23:b0:488:869c:edaf with SMTP id 5b1f17b1804b1-488996df052mr297307755e9.8.1775720793997;
        Thu, 09 Apr 2026 00:46:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3b23:b0:488:869c:edaf with SMTP id 5b1f17b1804b1-488996df052mr297307315e9.8.1775720793542;
        Thu, 09 Apr 2026 00:46:33 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd2181f7sm58355485e9.9.2026.04.09.00.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 00:46:33 -0700 (PDT)
Message-ID: <48464d44-1fac-47a2-839a-c963e9421615@redhat.com>
Date: Thu, 9 Apr 2026 09:46:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] IPA v5.2 support for Milos and Fairphone (Gen. 6)
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276872-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D37B53C735F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 6:43 PM, Luca Weiss wrote:
> First, two fixes that unbreak IPA v5.0+, which can be applied
> independently.
> 
> Then add support for IPA v5.2 which can be found in the Milos SoC. And
> finally enable it on Fairphone (Gen. 6) so that mobile data (4G/5G/..)
> starts working.

You should have probably split the series in 2, with patches 1 & 2
targeting net and the following ones targeting net-next. It looks like
patch 5 needs some adjustment. I'm applying the first 2.

/P


