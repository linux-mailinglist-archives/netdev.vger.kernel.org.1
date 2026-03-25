Return-Path: <netdev+bounces-271341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIpVHCczw2noowQAu9opvQ
	(envelope-from <netdev+bounces-271341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:58:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1551331E25C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 01:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56BB6304FE6F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75EC219301;
	Wed, 25 Mar 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRK5SE0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B877202F70
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774400292; cv=none; b=TPpEXrpwbz8EXE0GllbDdvrXwwZy+xEfid0wu+cQ/L0Sxt5ppXE+VBtSOvthpXSdoidL8vSHFW4boAE6aolorwcybwWxSJc5HcC8bpzNBBh8F/xuhh9Ijxo5Iua1mqIbO7Lcx+UWMpfZZgQ4NDjbIpT4pvd/P5UG8mFmGqjQm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774400292; c=relaxed/simple;
	bh=UTDogLNHogE7cfjZSHoMNnD+BLTQMeQb5+NAp5XBQZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DX/HsnbXLkqGOgkxexP3dbPeiaLkgjy2Qn49zihr2LDmznLecRngCSZB+p2nFsHpHCK6e65DEEmMxFPzyVBaNuPa09Ui0X5GW0Jjz1F69jaClBFvsDFRcokfyNh4fzPDxc0WRdqxyCh/fL/UddB/hxVfraNQuVASckFWPCBdJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRK5SE0I; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so48225415e9.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774400290; x=1775005090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Tly9w4A+N0QcLinlCbKHfCsDAe0Evr1aZjCEzn4JGc=;
        b=iRK5SE0IZ3pG7kZanN3ZgCPX5dGpXWMO6r5g5W2Ov74IgeGvLAqB0MeNx57CZpCRXN
         tBMN+RUV7p6LnnwGQWWZMJ4wSEuOqP3OeQMyfvKb2pSfDOoCM7HMoiS/cXBLmeHZ5g7G
         JuJFrY+BvhT0gfxUoM51IIvkMLiSwzUch88fTjvdw8i1SRWmmiwswLfA7n4wvuFnEeq/
         3+imUejEJmbIt+8/UJz+Zgms657m8I0WZfToMEc3jE+ZQ9a9lF087SAR0UZD2rNHqPhE
         Giu4s8RtLbkfdu5hckk1t4IkZnNcz+Jew9Y49eqe6EWKrqxhvd9hDzV4KnQVZEdz8czJ
         AP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774400290; x=1775005090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Tly9w4A+N0QcLinlCbKHfCsDAe0Evr1aZjCEzn4JGc=;
        b=lm3Ju21p0XgVbbY363T8aJDieFsfwKXawN/1gXb2KdVQFpTgrVbuBDilnHZSyD+uzE
         RpAMya7G0+nuCjbIl6Ymaq++S0fx5Y10S9lHPKckGaxOgLn9eM9sHwRMkRMzYxIFQ3RN
         ydSz6JonJ504XnN0vkcUA+9pPNPiaCf8mjaWENq/BYgieJRiIUrAP9ndOuzOafwqIIiG
         0A7U1dAAhWLloWQcMBZPERqDg1aqM24zZvKPEaVWHMPtjlis2S/ZOykMbn5GfJNQWKal
         cSkq3JJtsgC6Z7Vo9OkY4ibvXwNNyp+yCMoxg79Nfpv+3lZcuQKAu2b4F2IJ5w2dMZtv
         YiGw==
X-Gm-Message-State: AOJu0YwyQCRNWR7k11/aGl+kGMy3anMzGGbp1ET0OnyXnNUyr8fj/cKC
	Quukf0uT1RieTCCpUbSHTaTnnHKDfoM54mUoyEILjI0IOnJrn+nDLiey
X-Gm-Gg: ATEYQzy2fgHKusikcxwYREYOlx8HrOVtGIOV4ykbvbe7EU0AWsfkyFkWYTheHrYc6Ke
	WfhAWncDHLSRTq1btaWcWBBe0fefr0lDi5ChTBz2VcteJ2dwXAUfgVx0vYQMe7gqmi6lWSMg9Rs
	nCm2RiNqZQAtBUZ0Lfjk4IJ3Xm/SDN7dQ8OXXHGlO7t9I+hn3511CObOJAU5zhN4JMspw4QNyFy
	OQ8BJcE1EOXVSfHMT3aGxYFWxJBbg/1xlAO5SMH9CplCp60+FVI+z+xwAEEKyjD3CoLPRaillPl
	im6QdkYYjFSujJ/AGboHxvOezrhHFNE4h5RWclcUPegEhCoAd1L7uu92n2QYn2dEvbSliJR8DFP
	vprQo8L0lUCPwchjDHkC4yvqkFhwYrVz+CDu960YgRNF7tyYKamm8JuMo+HZynYYxuHMtgGmHXM
	Hob5uQMLNiwmMf7X79qL4rA66XWo+WB9OLvG02yMWgE7sRMQKznaqGV9Fkd6Dfgq0mWwEjQk0be
	Zpz9aI572qBfeWwAhPL02JX
X-Received: by 2002:a05:600c:8b51:b0:485:3f41:e113 with SMTP id 5b1f17b1804b1-48715fc37a1mr22612445e9.1.1774400289654;
        Tue, 24 Mar 2026 17:58:09 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bdaf8sm48055464f8f.13.2026.03.24.17.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 17:58:08 -0700 (PDT)
Message-ID: <fb270a64-74ec-4ffa-b7c9-c29f3d9d25dc@gmail.com>
Date: Wed, 25 Mar 2026 00:58:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sfc: add transmit timestamping support
To: Izabela Bakollari <ibakolla@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20260324160823.151472-1-ibakolla@redhat.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260324160823.151472-1-ibakolla@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271341-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 1551331E25C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 24/03/2026 16:08, Izabela Bakollari wrote:
> Enable software TX Timestamping. The out of tree driver 
> also implements this.
> 
> Signed-off-by: Izabela Bakollari <ibakolla@redhat.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

