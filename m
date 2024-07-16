Return-Path: <netdev+bounces-111702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F031932234
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AF92817B7
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1779195F17;
	Tue, 16 Jul 2024 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3cWsbsw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FC19580A
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119654; cv=none; b=eNS7XmXKnzowtqZS+AygKRQ7dt1pOAokB8JCkOlSmC/fs3pv+RILLlirNQftbZCDjRKkvHO9tRMEn+YeZMOD3CEHDXb11PxM02j1WmcoiNdMPaHCxTOFrgvnSbREvadKhK9KOvR9zXqxX8Pe8GEOxKlgrxE1xpBsX7KKK7ae2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119654; c=relaxed/simple;
	bh=c4erRTdFplUVeHe4jpoOM8K/0mISg3+RT23JsUTBU+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHPbg4r5giN6yATcurDBuPtB0sJbITzbUcEL3yfnVSbFkVTH7swDDgO0iAJlxDOhbjm7CCpMWjd8prQ/dAyhf5XBs6+OSsJHe0SjeJoAv/Azm3xjG1gWWJwk0pGydEC0uNIS52u5KLM/f7DOwLGTIHjsL/R4pBy2ClV0FqGswbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3cWsbsw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721119652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crDBCxIFGRc2BYULIH2EJGJ3gLrx1/8/kRZTfiMWf7c=;
	b=a3cWsbsw7sYgPQTfWRpPA4SlHjKdER8AqKa0FLvh79sh+jgV2yLers0bcBR9/ULB4AG+Hv
	i6enyOSCyTjiSmSsXld6BsrXFjdQefSiDchJv+hOMR7e8rL69dmbYQ4spFSuacV6JicWpX
	waEf/jC52b699KilJ++PqV/zoC5C5rQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-cPo_nbozPuqvKw5_Io8xUw-1; Tue, 16 Jul 2024 04:47:27 -0400
X-MC-Unique: cPo_nbozPuqvKw5_Io8xUw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367916e42d1so57880f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721119646; x=1721724446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crDBCxIFGRc2BYULIH2EJGJ3gLrx1/8/kRZTfiMWf7c=;
        b=ORMN+dholh0nD9SZNqT7tXh+jl9MMRhpaPKm6OzTpup5Kec4eVnVRdilyVSEVsnNu9
         eldlOt9zcv5EhwXDbVnanpuor7skQE8O+/hAgNfqpw7YamrKuJrTIjq98mUsxTS9aKgo
         TUZTAYA+dB6a4kU0BiB3lhm29iuT7GQfSOudEODLocUUuDx1706+4shs+CVxT4u3VMXM
         FTayDiVEV6WnNvoDUnYzI3YnUNIA73pi+KlOqq9TrLYe80HHmlpmZvUCt80NKHeqogmr
         l0GfRldaIY+dA6s65pgR9dsFVx00CfVuqTcqDspN+KR9j39E82AlXsJhZmBkrERk/sab
         +z5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIitJsW8jeWQDsb9HNsYGoHtrBIf7jUDIfRO8C8wb+RC4E9urS4eY/0xwcW0xrs1DyUhJ5Q6Dq55ytISCSFv+8cMebU6xl
X-Gm-Message-State: AOJu0YzLmFbRnEmiMfd1Y0joO0IpDAj/AJ4/ZTJa8OXNsUZZay3ko4cz
	1TcsP1E1mypcvLakC3r1CECvGqKgaEI4w/qmtU+6zYAsp80AV08vNWG8LoAnjdH/LKGYtUTALwZ
	2EMCPcA5xnGR2rialajV3BAhYOOtHW/m8gSZl9tJgL+mVSyO9JVgNdw==
X-Received: by 2002:a05:600c:3ba4:b0:426:4920:2846 with SMTP id 5b1f17b1804b1-427b88ce8edmr9293475e9.3.1721119646680;
        Tue, 16 Jul 2024 01:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6rQx1hBFnFYexTWpYbB/AkzYaZwA7flJDCAawbmUGBdGsvrkFQkbKmHEDzaXLz7ure/UvMA==
X-Received: by 2002:a05:600c:3ba4:b0:426:4920:2846 with SMTP id 5b1f17b1804b1-427b88ce8edmr9293335e9.3.1721119646270;
        Tue, 16 Jul 2024 01:47:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3? ([2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e93c92sm117370435e9.22.2024.07.16.01.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 01:47:25 -0700 (PDT)
Message-ID: <489bff95-5b5a-447f-82c0-9d724bc9d1b1@redhat.com>
Date: Tue, 16 Jul 2024 10:47:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] net: jme: Convert tasklet API to new bottom half
 workqueue mechanism
To: Allen <allen.lkml@gmail.com>
Cc: kuba@kernel.org, Guo-Fu Tseng <cooldavid@cooldavid.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 jes@trained-monkey.org, kda@linux-powerpc.org, cai.huoqing@linux.dev,
 dougmill@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
 tlfalcon@linux.ibm.com, marcin.s.wojtas@gmail.com, mlindner@marvell.com,
 stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, borisp@nvidia.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 louis.peens@corigine.com, richardcochran@gmail.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acenic@sunsite.dk, linux-net-drivers@amd.com, netdev@vger.kernel.org
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
 <20240621050525.3720069-14-allen.lkml@gmail.com>
 <ba3b8f5907c071e40be68758f2a11662008713e8.camel@redhat.com>
 <CAOMdWSKKyqaJB2Psgcy9piUv3LTDBHhbo_g404fSmqQrVSyr7Q@mail.gmail.com>
 <7348f2c9f594dd494732c481c0e35638ae064988.camel@redhat.com>
 <CAOMdWSKU_Ezk-15whDnNQKK_is2UtBOY59_4fPfKZE0-K+cB6w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAOMdWSKU_Ezk-15whDnNQKK_is2UtBOY59_4fPfKZE0-K+cB6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/24 19:50, Allen wrote:
> Thank you very much. Will send out v3 later today with these changes.
> Note, it will be as follows, enable_work() does not have workqueue type.
> 
> +  if (jme->rxempty_bh_work_queued)
> +                 enable_and_queue_work(system_bh_wq, &jme->rxempty_bh_work);
> +         else
> -                 enable_work(system_bh_wq, &jme->rxempty_bh_work);
> +                enable_work(&jme->rxempty_bh_work);

Yup, sorry I was very hasty.

More important topic: net-next is currently closed for the merge window, 
You will have to wait to post the new revision of this series until we 
re-open net-next in ~2w.

Thanks,

Paolo


