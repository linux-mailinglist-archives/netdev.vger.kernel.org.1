Return-Path: <netdev+bounces-130769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138898B775
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F551C21C16
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE7619EEC7;
	Tue,  1 Oct 2024 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSAr4pJG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261619CC07
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772234; cv=none; b=dWKjv5LU0ox81Fo2W3zOBP1yviTiY2DLdwbLuHxtMX7ebDF4AA0buaw3yMeOSmCeZ1lkPPmhF3oPMGYHqyJksro0NI8bvdI95EMa0CGXQ6un6lHnvAPu/VoeNcYvgjPLGNlTyFb7+uFE51dLBrTm/yB/b1Zh2F8S4YkhikYe/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772234; c=relaxed/simple;
	bh=YCn6CJz9wNslbDQYWuofALMOKvPHR03VTNXlkXTETJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLt6gPItFbF7kxTvlcLFrKkamckKYVw51+wHSvCizxyr142YdKXdPSGCKo1W2fnsBbKCCWDf1ORIuaZ/13uunygTRIFDMmZpWqBLwqYx8R8Px6bxQOmqtDYDf/BbZnWPEJ/D1SKrUa90mzwU8JELeQ27HlLLamQ0STdQY5lgA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSAr4pJG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727772231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBZwAi+LoFPSmQZhpxhVR3gQFHxasx7Vn9+lxQ2ezrc=;
	b=QSAr4pJGGPTO99hFSgmCg7W1HsYFzPtzQ3Kj92HVcQY1sHfRWWZ796SqjSsy543JZCBQ0L
	VD3bm4bhnHFN8g4q9BpPAHInZosBcEfxqXP1nIsgyfLgewNF52d03o67433wAozuNA9Jow
	l8xget6RnP057HknqFcJR9xnqjy8NbI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-MwZkbHiLMcaSICOwW7hwFQ-1; Tue, 01 Oct 2024 04:43:50 -0400
X-MC-Unique: MwZkbHiLMcaSICOwW7hwFQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cd1fb9497so2511305f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 01:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727772229; x=1728377029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBZwAi+LoFPSmQZhpxhVR3gQFHxasx7Vn9+lxQ2ezrc=;
        b=s2nIaVBWIQSWXHqxMeuyOqZt8jQTnwghWwMRlH58hUnWwsxMi1Ym2WCKpvL90nekqo
         ZJLsROUnMZBD8wTtfBN93ZXSpB+pbyrVPZjPxcmKr7Uc+T51rvOVx8MMjdADSCvAjM2A
         ZRhMN4x1nXjwwZulVpmnW5+QiByKxVSg55iWUnofNQueK+R6qKE9C9yq9jorf5OsNtSb
         HHsOwa1+LLEJv7Kcksg9WH54jbXwyJJqmT5AqH73srN+vJ3vi1Ks7IS29//v0jXBlnZT
         Eq7OTxP+CUCXOeUmBbi1CYxod0xJMzEVQ/FNzu7V0KQ/0jPzASVSbv9Mj7iESTOFS2dq
         amgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvEIQL9tfCAQiwSwNpNEZM2xKc2zcUZt668eCzVez7UkKk9FQ0Ki6qZ3EKESir00Jjk+LSF5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5PlrOiaF8eyXtLK1K2mUHsMwldDF22unidQtG5fVmQmCH2Bx
	w05giDvV/IWNw+gXqqV1+SJxguYEkkpnvGQfnFdMsnFq2KgZTn2b7S/gjv+qTjvvjJ1ROMkNKKa
	SXBhd+sZ8Zqy9C+KN8PwTYHzoyOTjaLEy2iMZrarvvCVjY1bMdC8v7A==
X-Received: by 2002:adf:e904:0:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37cf28b204fmr1083011f8f.29.1727772229315;
        Tue, 01 Oct 2024 01:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtw9vrE5plQVkEv0YpSWAr170pGXokEzLZGD5H1sbnowfqnNJalSwfsB+aJIY1/QbpbtPzBw==
X-Received: by 2002:adf:e904:0:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37cf28b204fmr1082993f8f.29.1727772228922;
        Tue, 01 Oct 2024 01:43:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575e322sm11249429f8f.110.2024.10.01.01.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 01:43:48 -0700 (PDT)
Message-ID: <7485182b-797d-4476-b65c-7b1311d99442@redhat.com>
Date: Tue, 1 Oct 2024 10:43:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: dwmac-tegra: Fix link bring-up sequence
To: Jon Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Paritosh Dixit <paritoshd@nvidia.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Bhadram Varka <vbhadram@nvidia.com>,
 Revanth Kumar Uppala <ruppala@nvidia.com>, netdev@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20240923134410.2111640-1-paritoshd@nvidia.com>
 <qcdec6h776mb5vms54wksqmkoterxj4vt7tndtfppck2ao733t@nlhyy7yhwfgf>
 <6fdc8e96-0535-460f-a2da-cd698cff8324@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6fdc8e96-0535-460f-a2da-cd698cff8324@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/24 17:28, Jon Hunter wrote:
> On 25/09/2024 14:40, Thierry Reding wrote:
>> All in all, I wonder if we wouldn't be better off increasing these
>> delays to the point where we can use usleep_range(). That will make
>> the overall lane bringup slightly longer (though it should still be well
>> below 1ms, so hardly noticeable from a user's perspective) but has the
>> benefit of not blocking the CPU during this time.
> 
> Yes we can certainly increase the delay and use usleep_range() as you
> prefer. Let us know what you would recommend here.

Use of usleep_range() would be definitely preferrable.

Additionally, please replace c99 comments '// ...' with ansi ones:
'/* ... */'

Thanks,

Paolo


