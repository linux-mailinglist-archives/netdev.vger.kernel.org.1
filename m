Return-Path: <netdev+bounces-228100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F1BBC1688
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 14:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB4919A2207
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 12:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165152DF3D1;
	Tue,  7 Oct 2025 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcxSSoxn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625121FF48
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841379; cv=none; b=WeIvjO88ebbon1Ziy7dyjqfoqCwfR9iO8hIA4C9qg6ZZ02VG0sBzRh/ImERdHSW67jOfnJNqSITvlXhLNuuPchxF84FWBnWIEI+3vPIUpKlOR2w357gkENV93sDEWwNn8PN9t3zMVic8wFdKYaoCReDVt/lH3muDxSnlhXRxCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841379; c=relaxed/simple;
	bh=c/WLFYIFjnh2k/ZgBeBCvK2ZBmSP55ivwUxj5/6hNpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSyuz8olHBFxYcDkrPeI7W+/0oDxsOXpe+T2bRmkS2Vr4hcgcXnSoVryRCuv2o5KE+gtfrFCb468u7Yg/kR4JJL2bEvuVK/SzZjGclW7DEw5Apy20b45+APFMxXq6ZPIv1vpYaz6JAYGKiCKyzjd4hiix5D1tNGY+3a4Sy2u4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcxSSoxn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759841376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJ2c6ZhPNn3NTb/ZXUe3uUgmdMJ2RmrHeu2BLMk0710=;
	b=BcxSSoxncTvd1rIQqWUp8PmAYceFuweXd6PJvxqOoMOMN+2Zm5dgPa2BxQ6QHxP6Fp/8Ue
	4vjn4Ywk4JDR0dZ3gQTlAi1A2ASpriUVOQynmrx5MsbD6tW6kyxMU+E6G0RnP3gBEFP++h
	GRJC1WhKfSvBhwlaVnrp+DkuGdrpuzk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-pKbXoudWNEi3RX34TR25Eg-1; Tue, 07 Oct 2025 08:49:34 -0400
X-MC-Unique: pKbXoudWNEi3RX34TR25Eg-1
X-Mimecast-MFC-AGG-ID: pKbXoudWNEi3RX34TR25Eg_1759841373
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f93db57449so3146965f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 05:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841373; x=1760446173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJ2c6ZhPNn3NTb/ZXUe3uUgmdMJ2RmrHeu2BLMk0710=;
        b=ejFr6HmGlmOGIUEAQcNC0YspMtuWsG8zNko3bvtcv7WpqlSBom0WtUqvE08Xtow0fJ
         qBLUS+P6lSNyds+x+KJMVEov5LVgrrpFF+lEPh7WRVf745zMWJHYinytAQRm06pesHxl
         0h9ZvZuxUdzklz5CKDKWdnVaBULMs5NlHS05HHOdRxHtG8lNjkieUyZT0Ez3udvZyhav
         /+uwfIBi4uuFodoMhnHXwCGF1/whJc1u91LtFMojozBzF4YpdEZ9DIdFF/FFMtjHyjix
         BvZHmO2yl2vDZSX/WTnw5fcnEsC0SBzs6UK/lK94VwxfnNK6j70DWK074oaXuLq96dXC
         PqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyqc2OtOfCgRou13O4F8A/K3HwJ6HaXSLYawddPxaxqCR0vmrvuKPtyc4ulGARGPTT/Du4Q44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwliRsxAFFlgKcAYfiJ0tkPp9xppueLNH0AfXSOnwdp5rEi5CXw
	5vSWQIrtsBwBHdgmGzRrsRzcwFS2rLlTDrH6G+u7gfCgs7S9h3sISBpMQ9D8CQiA7pDEn7aFVGG
	eqgvtNOuRotRlN2Dmp8t3ptKltjf0uerbC2pfqCOlm6c42tmbAjBGI12KtA==
X-Gm-Gg: ASbGncuo070/C6Pf19CPiGLDw2PBVIRa+AqiC+yc8sLfEgch4F0yLjQLnTy+CCCPQ47
	oW/6gWJ/NSVIAbyzIuAhGprxfKwplOQ92eFVrI60spdLi26Z+QSkr4iYAXSA/mROg7fn89yDZfF
	fTeJD6MVT3BEz8o13hPaZC/eNeZJLKI9R0po0qe+RyRZClXV1wBfQbJdzlZchnbHqmMbNFbUka+
	Sdz7sj1EsnzwZ7zKA11F1wot83Ws+K1C6zX1a2W+WLlqWQSHD4NHqJcqk+2+EtSOT7fnvsfl9ix
	L8yqcSI98teSL2u78Tc3jXBFqjESFyjj/0NLLevtAkrVa+tp9OHDSvrg/vxvs/h95ytNkq+H0jD
	Qp+ET80czuqppTDLLTw==
X-Received: by 2002:a05:600c:680a:b0:46e:42cb:d93f with SMTP id 5b1f17b1804b1-46fa26df6f0mr24052535e9.15.1759841372940;
        Tue, 07 Oct 2025 05:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmEdkYp9kyJChoEBmC1Wayd07hjE4hNEA+dlV58UpIwkkn9LSiHaGwwKX8eGfaTODnJZOzSA==
X-Received: by 2002:a05:600c:680a:b0:46e:42cb:d93f with SMTP id 5b1f17b1804b1-46fa26df6f0mr24052335e9.15.1759841372567;
        Tue, 07 Oct 2025 05:49:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723432c9sm204340025e9.1.2025.10.07.05.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 05:49:32 -0700 (PDT)
Message-ID: <2bca842a-0a94-4798-b215-128809956018@redhat.com>
Date: Tue, 7 Oct 2025 14:49:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 nf] bridge: br_vlan_fill_forward_path_pvid: use
 br_vlan_group_rcu()
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: Eric Woudstra <ericwouds@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
References: <20251007081501.6358-1-ericwouds@gmail.com>
 <aOTm6AUL8qeOw0Sp@strlen.de> <aOT0jTumQq39V7p2@calendula>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aOT0jTumQq39V7p2@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 1:07 PM, Pablo Neira Ayuso wrote:
> On Tue, Oct 07, 2025 at 12:09:51PM +0200, Florian Westphal wrote:
>> Eric Woudstra <ericwouds@gmail.com> wrote:
>>> Bug: br_vlan_fill_forward_path_pvid uses br_vlan_group() instead of
>>> br_vlan_group_rcu(). Correct this bug.
>>
>> @netdev maintainers:
>>
>> In case you wish to take this via net tree:
>>
>> Reviewed-by: Florian Westphal <fw@strlen.de>
>>
>> Else I will apply this to nf.git and will pass it to -net
>> in next PR.
> 
> There are more fixes cooking, probably we can prepare a batch.

FWIW, I think it makes sense to wait for a NF PR.

Thanks,

Paolo


