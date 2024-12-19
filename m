Return-Path: <netdev+bounces-153308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F69F7938
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD68189564B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2251A222562;
	Thu, 19 Dec 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVOeWAZe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87233433A4
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602945; cv=none; b=b3lCTpEmiYQ3IinUlp9mV8uZfIeU23abIj/NBWRoTykKsnIXA+NR/FWZLqH/ay8A4fktFCcmxEJQ6SYcO6eZmGjoP/Qbp0IG6FFeOUD1G3uNDr241sQd4u8cLErmDkiynZCrdK9qC8UwRHvaSpc1/15Ja0HtnProH8IAO9Am3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602945; c=relaxed/simple;
	bh=2gDH687Y+RbAzf35eofEUfdXtMWrVfNMD6crZe1I8Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyD6XEN9IIuSjdvaS3ePWUavOhYFW4EnduvniG8NdamXkZ/RA1npkA4C9SBVbka8G0FGL0ytqOP+sCK+QMMMpBEm8rEPKP9A+cpEUZAj2Gt/O20lOwMfLqYmV3fKTJfJnTA3dkY46k/aKZF7NqMGb//E8kuxfVA9aIQMYsGK6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVOeWAZe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734602942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T98mqp2bW2iDbPQ1pjYih/rvPbjnw2C5T7MaMia1oug=;
	b=XVOeWAZeQDZvLOGUIZg8gP+LaHl4CCmLozl2WoL98OmOKp19QoWX1frVh+Qb9Tp8rIwNc8
	lmiIhIjEKHXbZnUArbokYHnhc09kuHObMWr5/zLJIx+AycgDh0k/e56Olze7GYIwh+eDbr
	tMXX+ABD5OK4lxN5uIs4CS/mZKiM3OI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-TPy1bX0GOvCFfKHBuxE49Q-1; Thu, 19 Dec 2024 05:09:01 -0500
X-MC-Unique: TPy1bX0GOvCFfKHBuxE49Q-1
X-Mimecast-MFC-AGG-ID: TPy1bX0GOvCFfKHBuxE49Q
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43624b08181so3527885e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 02:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734602940; x=1735207740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T98mqp2bW2iDbPQ1pjYih/rvPbjnw2C5T7MaMia1oug=;
        b=oncX4qLESvWmdww9Mljc7sznK7efhlyF0QfJxlK8ZUnz+wh7vQZ1dstfql4TVzpAF/
         d5QHXdvab60t3OnYdev9fGCfy/I0v7JQmAnAqF4nBrSoS4mc/08GzjANbO7i2Y5HLcqk
         xE4MATlU9tse0INc+1sTthFd/N9XWUp/Aw1EHUz/7t9BPFXwO76Ptyq0Xc0Utokz0+42
         uQm0X416MCjqS3kpkuZb+OwThqOoDM4pL+2hxhOwVE1TiC9AT0QFU70Dkcab+0Pn92w4
         OxJo5FZzgx+ZR/ao4mBgNnprLLoLV1EiYsDbYOA8PkhVVeLYx2QKW3a7muto4oysLqtz
         F2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDQmkYJAoG3VuztUzLZgq/adfQKwiJqVhrhnmxuAEIOMdwvgm1qD9wlPOG5MTlZ2+WFHaqozA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztjRyW4zJ9lSBemdRaJjQGRDV3GrKiCqgy0c6sTweTsJAOmViq
	JT4OvYhTcOJA0ONydWImXRqiHyGLX1RR+7jl3uuH9TQbZi8uYrJ7W/vTCrC4hCKxiubqnhiRyaS
	tlzNPQyAk/F6MPMciHPvFikzkKDgo1ZooS+Z3FY2RVyrKmXujiZkYdA==
X-Gm-Gg: ASbGnctoeetrKEZmoZhFG3VI/RUD6MAe/T0TlVSvrshICd58bO6gk276dlJTbcQAuqg
	3E+9Xn9/fM17QHcBVLZEnPJJhEV8TTMWOO1K1HcxBVW78V9D4W1vMqC/8wGyxZKmGDC/Vh8C7d+
	iNUEx2ZDQLtsHmLbqtHP8MuxR58qdOXprMALk1LfQhgIINJL7s4ctBnBts81eat0Ev/ethcQ02g
	RW0XBR0DTdLgn9orO4WApNnoeLxY/9msMSptFlfWtVF1CRXcfcZvuRf0kN1FSvf7klpgalKILJU
	iC6ipawRhQ==
X-Received: by 2002:a05:600c:6b6d:b0:436:51ff:25de with SMTP id 5b1f17b1804b1-4365c77510bmr22352175e9.7.1734602940184;
        Thu, 19 Dec 2024 02:09:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGirXoXRQE0r5vB0TfkeqRe7MfB/RkGpoRNVbjNqtlwjyADuUYTSVPC9u5W6B0bBw1vsjY5kg==
X-Received: by 2002:a05:600c:6b6d:b0:436:51ff:25de with SMTP id 5b1f17b1804b1-4365c77510bmr22351795e9.7.1734602939835;
        Thu, 19 Dec 2024 02:08:59 -0800 (PST)
Received: from [192.168.88.24] (146-241-54-197.dyn.eolo.it. [146.241.54.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2d2sm1189392f8f.71.2024.12.19.02.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 02:08:59 -0800 (PST)
Message-ID: <badf281c-cccd-41be-9cd7-bf6637c981f0@redhat.com>
Date: Thu, 19 Dec 2024 11:08:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: core: Convert inet_addr_is_any() to
 sockaddr_storage
To: Kees Cook <kees@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Simon Horman <horms@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Mike Christie
 <michael.christie@oracle.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Maurizio Lombardi <mlombard@redhat.com>,
 Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, netdev@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241217203447.it.588-kees@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241217203447.it.588-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 21:34, Kees Cook wrote:
> All the callers of inet_addr_is_any() have a sockaddr_storage-backed
> sockaddr. Avoid casts and switch prototype to the actual object being
> used.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>

It looks like the target tree is the networking one. If so, could you
please re-submit including 'net-next' into the subj, so this goes trough
our CI?

Thanks!

Paolo


