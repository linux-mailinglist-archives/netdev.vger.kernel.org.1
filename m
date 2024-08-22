Return-Path: <netdev+bounces-121031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4283395B6F6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5AF1F219A7
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CE61CB305;
	Thu, 22 Aug 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="au7VCRew"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DBD1C9440
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333835; cv=none; b=Ze+Daki0iUHitgMearOuJyM+mF/JhF1099bKh+qginEFCYlxpaFs9sF/bCKEsN6R4LZrvPspjuejSNqp1alDb4n6utyqK7W5WwGF7cYnLLqfc0y2ps3k7ZFPzIfAjNy8Udr9H++Yf5eYOs5hfvhFhvUydoFnnX6e+C+FsotsUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333835; c=relaxed/simple;
	bh=JTcnPH8h/y86OxqQ8tp1tuFGbkmPCjuZ1se8KSv8hUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2emo4bmD2QPXOQae8NHWQT84PMgixO+A8z7Nj3hhN2zugGKAHNRd0OI2xF4BLxkaDY0BmygEoTLWlHCknyYpMka7wjvqs4CaW0S/cZkOXQowo9sjYssdvBXISqoLT7WH13nSg7pFBlBClt7wa1W4hcLN8w6N94vrlbderDhNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=au7VCRew; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724333832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mHZh7szVej/hsK5F5p5xTaLifBsrzkDP5jrqsan0ro=;
	b=au7VCRewEWWQYMDRzbuHhhtYVD901RyXmvNeBZ1ldSwJeYIKqoVITMt7/dLxxf4RkCvfCC
	GbNDYPyjpJpKGl2PWh3qScvR7kRCPUfmIC03yN0ilDJE6dZ6TmA4xRbjgOxaC9ay8ikoRt
	J66h5Nur5TYUew2YjEEkix8TEhkwd4E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-wVn52d75P3eEjwhy_tAHqQ-1; Thu, 22 Aug 2024 09:37:11 -0400
X-MC-Unique: wVn52d75P3eEjwhy_tAHqQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-371b28fc739so430879f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 06:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333829; x=1724938629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mHZh7szVej/hsK5F5p5xTaLifBsrzkDP5jrqsan0ro=;
        b=ORexTs1Q6kAoTs6lOOWn8pAqluA3xeakY1EDawIhFVtXm1rI//0sRFqYy/g+Pl31ha
         yB7+1SSr4a2aI4gUdk0vRSGtwwgaK3KS3Ck1wbpt18W7e0DU/EJdxQ5rhAEZLxZZQN+6
         d32gMl09nl+FU4HetCkFk61tIPz+an3Z/YyylAZodo2fLHP75kzL2j8qcQgg2jv9qGU5
         tE8N835xoI/YTmmRLidE1Hbr8Mi/EC/6N9uGKsE6rWTCJGXv62JVvG2OstjDfx+uX55O
         pnA3P6DuEr5iECZZW34fN8Yc1qqEWKJ8XH2w1EJCY+IFSv+z0Ll1bTYby9iEezQimCk+
         72sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5GGhtZyZiEe5cXWdRLCNZCdjOhxMG0pYzqVGMFuu1OG9bWsR5T9rEhDEO5q0goNjoXRcVltw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6uVSTgPwsscfkovVh2AmcluVRQixULGtHUdmBYIdEHABZDck
	tVaxNta9sUJJbYejSBIftArA2bEau7hCtD/qU/gcTj9XaLuOF7c/buIQa20NF5kJrjIneuG5EJP
	xbApDhg+PAt41SXxoOcLregBhg6q08a/yURIoInIWsfPM+dBsqVGjmA==
X-Received: by 2002:adf:e7cd:0:b0:371:8451:5a82 with SMTP id ffacd0b85a97d-37305269526mr2039497f8f.15.1724333829272;
        Thu, 22 Aug 2024 06:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhIxKzuKPTTYg2n56kKrmgvykfM06se91O06WD423OCxSFA50ut0ca7cwPXhlgqIT5XZA3fg==
X-Received: by 2002:adf:e7cd:0:b0:371:8451:5a82 with SMTP id ffacd0b85a97d-37305269526mr2039477f8f.15.1724333828797;
        Thu, 22 Aug 2024 06:37:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10::f71? ([2a0d:3344:1b51:3b10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308161042sm1724244f8f.59.2024.08.22.06.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 06:37:08 -0700 (PDT)
Message-ID: <5ecac29d-251a-4db8-abf4-e73c4e1eca55@redhat.com>
Date: Thu, 22 Aug 2024 15:37:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/5] MAINTAINERS: Add limited globs for Networking
 headers
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
References: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
 <20240821-net-mnt-v2-3-59a5af38e69d@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240821-net-mnt-v2-3-59a5af38e69d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 10:46, Simon Horman wrote:
> This aims to add limited globs to improve the coverage of header files
> in the NETWORKING DRIVERS and NETWORKING [GENERAL] sections.
> 
> It is done so in a minimal way to exclude overlap with other sections.
> And so as not to require "X" entries to exclude files otherwise
> matched by these new globs.
> 
> While imperfect, due to it's limited nature, this does extend coverage
> of header files by these sections. And aims to automatically cover
> new files that seem very likely belong to these sections.
> 
> The include/linux/netdev* glob (both sections)
> + Subsumes the entries for:
>    - include/linux/netdevice.h
> + Extends the sections to cover
>    - include/linux/netdevice_xmit.h
>    - include/linux/netdev_features.h
> 
> The include/uapi/linux/netdev* globs: (both sections)
> + Subsumes the entries for:
>    - include/linux/netdevice.h
> + Extends the sections to cover
>    - include/linux/netdev.h
> 
> The include/linux/skbuff* glob (NETWORKING [GENERAL] section only):
> + Subsumes the entry for:
>    - include/linux/skbuff.h
> + Extends the section to cover
>    - include/linux/skbuff_ref.h
> 
> A include/uapi/linux/net_* glob was not added to the NETWORKING [GENERAL]
> section. Although it would subsume the entry for
> include/uapi/linux/net_namespace.h, which is fine, it would also extend
> coverage to:
> - include/uapi/linux/net_dropmon.h, which belongs to the
>     NETWORK DROP MONITOR section
> - include/uapi/linux/net_tstamp.h which, as per an earlier patch in this
>    series, belongs to the SOCKET TIMESTAMPING section

I think both the above files should belong also to the generic 
networking section. If there is agreement, I think can be adjusted with 
an incremental patch, instead of re-spinning the whole series - that I'm 
applying now.

Thanks,

Paolo


