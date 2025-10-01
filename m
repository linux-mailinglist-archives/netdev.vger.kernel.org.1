Return-Path: <netdev+bounces-227499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7381FBB1498
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 18:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A9687A971B
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F232836A0;
	Wed,  1 Oct 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKxqrrap"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D725D536
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337192; cv=none; b=DPZzUS6SeNg8jPJKwERyqsQNwdNCZfGFxC/TV09DPbc66E75YZClxHmnDoLw5YsCVDAav2rFg8ATAGQ3cppPjVSu7ALffxdk2l6KxI+52XN6eJdwO+uyPTuJlF6fiFgw8mAQGzvSFQk6ZGc6pmMh/G61+0neKbLbqQZb+X71ecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337192; c=relaxed/simple;
	bh=D7l1FT8Y5r0gjZ+0kIRsw9Sz3C6w2GlqHyEO1NNLUWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1TeAzNKyJU6ScRsmE7+h3mO76Bi2oIEyEGxpW4FQSR1z2bCDGXED5Tkc5mR4TBMekkJorhRHjU3rnVNjhVBv12YIL5G7q/fgFqw/h6/RhtZtn5ghixjQI9XXMrm8drZtz9fxfHbsGCbf2IAOH68tWymghtNGVUMwxARJ/KRYlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKxqrrap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759337189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeHOzXQ10M/iQ5oL/r7F2bxKtNTB63lsGFz4yEHuQ6M=;
	b=UKxqrrapJYFyc5YgpgGqK3btPmxXjnWvnkVRPMQZLYj6CNGOxP2sYjDwC6dx+F1Qe61YfX
	FvVq6zq+j3ZFqBlHOgwOrofhu13Z5XBFawm56YbpLar41cXEAmSxVtHFAPTT3OW03/ckRb
	D96CddUVND5tbmNaZbHF9qQh6CzNmfE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-oncrNBT5M4iUyCYNVyyFow-1; Wed, 01 Oct 2025 12:46:20 -0400
X-MC-Unique: oncrNBT5M4iUyCYNVyyFow-1
X-Mimecast-MFC-AGG-ID: oncrNBT5M4iUyCYNVyyFow_1759337179
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee888281c3so10245f8f.3
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 09:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759337179; x=1759941979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeHOzXQ10M/iQ5oL/r7F2bxKtNTB63lsGFz4yEHuQ6M=;
        b=BHm+7IoU/gPhmUi5ZxUs0aj9sZWVEBWBHsTQ/RP0ejaKjSH2Gl2DvMhp2OKbAR1+yU
         agLSh7fN7vRb1GgKob+wwNqhqbWaMI+TCARJywP+Tu26Q6a67LYKm4X6wJ/6VPirCnG3
         ZxGc1FSIiVY60d5LU5ZiOASXtT8GwYfPQz1o14WFACvgwNgtJMwshiH+5kjeVyo6+bHV
         W5G81q3aHZwzZw6V3qjJvKsdL6QfvZ0oxxb2ffVS5bn/MvK+WTdIzSC541whhguJ1Uiw
         u04DXAb+ipxdL6TeyDpkFfc1JCO+zd4hcfcMAywxjy1yRWtDRLUh65ODOByNoMuARym2
         dRFg==
X-Gm-Message-State: AOJu0Yx39E6Iil1rdYlhCPUQSfI+CF5xrjG/rkKsWWsDHkTJv6q4mLZa
	DptGkGcadorkFXGEaveP44amL665CZ4C/CXERlmwIANTm4lt9ovO4zLJadtXKkd6U3EeQ6mV5Vr
	4Yg4JPPMvEWONApZPizXaVuq8PayeFATHt3SuCiZT3D4tps/7tr73dx0jog==
X-Gm-Gg: ASbGncsVt4ofZNa07atg/3OhqxZzNknlMEavoXMU+EN4cf+JwvQM2JJOKOyetPr2Ans
	Hx19eUmKVlZorRG4VRf0h4xmky261u4nz8mpRDTHeY/fEmwB9NrwHIpdjSyrkF/zRW5rYW8m0dN
	Qu5Vae8SGanYdgEScppoQmuuEWjRm6EwoxDsnvkqVG62UnNzGIFdv1xEv0UhWgaFDmQUMXsoDjG
	nhgJiVwdnC+Nlakiq6oMedtZPhHGzRM+CF9YpmJMNrzpOCE/1a7h9fMTxm1cEo02Fl/9g/Bm/Aj
	VcUphd8IJbiW8L9eaaTSo6G5S6QsNXd5GaNVVTirgBiojLGIvZ4NV0nhA1JAlwaUt8V5ZlWADMe
	uwjivyCdh07OiWsI7Ag==
X-Received: by 2002:a05:6000:26ca:b0:3fb:9950:b9eb with SMTP id ffacd0b85a97d-425577f77b0mr3194781f8f.28.1759337178885;
        Wed, 01 Oct 2025 09:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVmgbQGnoRKGUm551gaCfODMdA2f0xn6Pl8ztOAd/2mHpntC9FCTZPPdwxqoewUttiiW/ing==
X-Received: by 2002:a05:6000:26ca:b0:3fb:9950:b9eb with SMTP id ffacd0b85a97d-425577f77b0mr3194761f8f.28.1759337178414;
        Wed, 01 Oct 2025 09:46:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b5f3015sm41193195e9.1.2025.10.01.09.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:46:17 -0700 (PDT)
Message-ID: <3a8ba87f-a6ab-4523-b0ce-8e9dbd5a923b@redhat.com>
Date: Wed, 1 Oct 2025 18:46:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: deadlocks on pernet_ops_rwsem
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Westphal <fw@strlen.de>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org
References: <20251001082036.0fc51440@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251001082036.0fc51440@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/25 5:20 PM, Jakub Kicinski wrote:
> We started hitting a deadlock on pernet_ops_rwsem, not very often,
> these are the CI branches were we saw it:
> 
>  2025-09-18--03-00
>  2025-09-18--15-00
>  2025-09-18--18-00
>  2025-09-19--21-00
>  2025-09-21--15-00
>  2025-09-21--18-00
>  2025-09-22--00-00
>  2025-09-22--09-00
>  2025-09-23--06-00
>  2025-09-24--21-00
>  2025-09-27--21-00
>  2025-09-28--09-00
>  2025-10-01--00-00
>  2025-10-01--06-00
> 
> First hit seems to be:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/302741/65-l2tp-sh/stderr
> Two most recent:
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/321640/110-ip-local-port-range-sh/stderr
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/321281/63-fdb-notify-sh/stderr
> 
> The stack traces aren't very helpful, they mostly show the victim not
> who caused the deadlock :(
> 
> Any ideas?

Not many here. The above are debug builds, so we should get a lockdep
splat on deadlock, the logs lack it. I guess the request_module() breaks
the lockdep checks?

IIRC syzkaller uses config with most/all builtins, so I guess it should
not be able to replicate this scenario (to possibly help creating a
repro), unless there is an allmodconfig instance?

Adding Willem, just in case he knows more about possible syzkaller usage
here.

/P


