Return-Path: <netdev+bounces-68189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2498460A1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 20:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D76628491D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE7585264;
	Thu,  1 Feb 2024 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgTKd26j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890E84FD3
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814447; cv=none; b=MDgDnhK9/C7GlVwzhRTNWM3q5fOE+tEyYiqHe6XIQxj8eNoFJeYjn2hmxjYHL8zr8McfhdfDhHjycYE32V2tO/cvus3myLfzNW/v/nZgbImGGJHSwZDqAubeb9Sg8WpOLDbJd7z/IkqCbJQrRDXYyEQxDDpaQ/BSWTCitSfaidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814447; c=relaxed/simple;
	bh=nd1xNacpJ7edmbB4vw12t/6SqODjNijtIQ+qQJkAn2I=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8gFaE7o6z33C3k3CE7dnDl7ZEZ2KuZ9HR6WUaNsC7EqpTT6r4UpCu9Yxq1uHpvCBD1MoIxKjxNOENGPMcdqObg1F2LndCmapOfB2IH4GyrKmWZABp47jDFYYrkFBeYstoPXxaPwqjgvGaGtqROmf08ygIDNujM/WzzSNcDQuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgTKd26j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706814445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx+1abgolFRi+4nasT0owtFSb2ulTA5ZS8PvE2Kg9TU=;
	b=hgTKd26jS62eIgX5Lxx4SraivxvpuWv+XOZBay2b4mwdcsPgKPGoOQE27KhbcYslPExEwx
	67sXqH9zeHkT5ExFggGoIX63C8h8TzTf3ljBGHcTZHxFsmyS3+EqiAnXlHR7btC6mDGagG
	qCAmCV4vlNErliFag2wCu0KjhAF10b0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-octvpEWGMV20YnaP9dBeyA-1; Thu, 01 Feb 2024 14:07:23 -0500
X-MC-Unique: octvpEWGMV20YnaP9dBeyA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55d71ec6ef3so786315a12.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 11:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814442; x=1707419242;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx+1abgolFRi+4nasT0owtFSb2ulTA5ZS8PvE2Kg9TU=;
        b=VaYTLqhuQUT8D2dBJXn+jXWYRlxiYih+yT+F7WlArZFfRVmYETwHxqzVvbgnshOklL
         UC5gywGv2L+XlVU7hKyIzuFDKDzL1zfKSd0IKj7zpFpj2VrnAT5c5OmX68i0dPuTD0Nf
         hk8oCmwTNNeQSIz5QVDVeNJF3+oUt402F8j/+9qDrFURxA2U4j9UGawddYVE7kBK+NSV
         IX1J8AYQOhsUCpaUlMn9ttPJeH3QnC02BN8w6Ir3I7hHXq5ewaErQeoq+tOXKdbeSG3Q
         yEWkx6AmJzcZlRW7NsW4apEWvAWpcmaoyZ0jPnb+jL0vVh3F0V70zZBQmppXcQxG1Z9E
         VmHw==
X-Gm-Message-State: AOJu0YxzxO+nXNI/YDGWcmCZCY0OHRBLANdVVRlOgqtLJyjRANjiH2yo
	c5byRdCNenhtZa+W1P7qbRAIWI+kdPksz8peowc6MzZ1AvCtVIhqc5tqn1j36EBVvEDtUcczPFp
	jnI/NEn0urTskjGeU4+qvbcTyCU9vPunYiIkgM9r5AR6fyIQLBmbF5nis5WioG07Ftp4hprb5ET
	Kft0YrF7jpKeJvgic0wPUAKXszLw/7
X-Received: by 2002:a05:6402:3402:b0:55e:ef54:a4dc with SMTP id k2-20020a056402340200b0055eef54a4dcmr4269494edc.23.1706814442621;
        Thu, 01 Feb 2024 11:07:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ8wz1J4znsp54tQfcT1PW1YBWiXRCYfSoLa5g1fFEFNKhu84EYm4M0xhWlmFnpH5WWH25rUVHhle4WSqoF7E=
X-Received: by 2002:a05:6402:3402:b0:55e:ef54:a4dc with SMTP id
 k2-20020a056402340200b0055eef54a4dcmr4269471edc.23.1706814442328; Thu, 01 Feb
 2024 11:07:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 1 Feb 2024 11:07:21 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-6-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-6-jhs@mojatatu.com>
Date: Thu, 1 Feb 2024 11:07:21 -0800
Message-ID: <CALnP8ZYtVXHbnvESkZpcVwpJAVJWe9NP1EtPQOzTKD3WUnqO3g@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 05/15] net: sched: act_api: Add support for
 preallocated P4 action instances
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:51PM -0500, Jamal Hadi Salim wrote:
> $ tc -j actions ls action myprog/send_nh | jq .
>
> [
>   {
>     "total acts": 1
...
>         "not_in_hw": true

For a moment I was like "hmm, this is going to get tricky. Some times
space, sometimes _", but this is not introduced by this patch.


Reviewd-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


