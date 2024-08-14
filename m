Return-Path: <netdev+bounces-118485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC2951BFC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D72288697
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CD1B1505;
	Wed, 14 Aug 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw2j8wAl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC241B1439
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642587; cv=none; b=p/iEvOnbn1l/KGi4A2kOmUUBEOiJ6wsGnZKdtU2w9Fj4/T1NB+UuevVI1RHP+L2oFyerglLQisZf7ZpK1z3hdsh3/4xPWQKOhPEluBlM7MxLE+DWi+0v1Ey29j8O7keBCMs/ajOXPiWznbqoU+7I3ujH5OSXwRQzzdg8dGO36I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642587; c=relaxed/simple;
	bh=VZupSk4sxKMpLAdgordBv4RG0EDtzQgp6RbCdSY74GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay/KIp/AORd3ohSZ+ki78v0puQc89tWo57NuUtc5trxj2p5UYY8PgXLXPkRpEIR+MEA1Qu23avMh8z1Htp6bqrXlWfxowE0rBTa+1XnQuo04ntu17xUwqrxS8UAsJFbG1y/nSHnbBakBWO+sZ6p1xDGQ37n16XOn9QT123nAQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zw2j8wAl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723642584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VZupSk4sxKMpLAdgordBv4RG0EDtzQgp6RbCdSY74GI=;
	b=Zw2j8wAlve/ue92sW3VV6H/LHcgEpFTJmvr5f8unq22yKxALVhIfjUOBoV0ks2NfLuJIi+
	k2YQYcYqFH9YDOBYxw2ZeUz71s8djxWA0JUlbCRfnug1LRW8+9xq4hmMmA+hjRsfGwnoMB
	NY1okDuy3ISRlAJcO4vS79cb1HSqxNQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-ehF6iOKsMQSEEH0E0c080g-1; Wed, 14 Aug 2024 09:36:23 -0400
X-MC-Unique: ehF6iOKsMQSEEH0E0c080g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3717cc80ce1so211317f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723642582; x=1724247382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZupSk4sxKMpLAdgordBv4RG0EDtzQgp6RbCdSY74GI=;
        b=ldsB7O+E2VPLIoMhKMNAYlfWJbGzebtQETk32HXncOV0FMZOrM0PxXChB8GMQ++rRd
         /A00NuaoR9lMdhG58W/AuD086FeiKYqvAAPJX6vbBdRga894owMDu1kcUdU0WGFMrZdX
         s/rd091I9iIoYG5aYPUa0RKGlAAtqYPMQTK8LYL0mawZhVzlH52x5lbl2rG+w+jDVgvt
         bKhsOCCH+nU6ARPoxvx0jbaEnJTg3D7E8vEcRZzqHRwiyq7goQsyYzyR177af9rL75Zc
         gpOfHrIMXxNBrHtjDPUGgM9kE8nQrGx/yAyBhPNE2a3v4e4CeLq+Ql+pq+EPLtpKlPON
         BCjw==
X-Gm-Message-State: AOJu0YzklM/Ua4TZaJ561dWT7T+9NoWmexkyRxwHhcE11vo1autV0PUu
	ilnHhOM63KMzFJ7Ntk7ZTKaS2fJv6P7HLtrIIhoTqmz4FWX5dLV/T9AqB8VXK+yN5j3yaRzCSPj
	qA5G/e9/qUCSxMCuilMaeN4PK1WGeGL5lNGcamyINc0v2m8PcR9iGvg==
X-Received: by 2002:adf:b350:0:b0:366:e89c:342e with SMTP id ffacd0b85a97d-371778091e9mr1996784f8f.53.1723642581969;
        Wed, 14 Aug 2024 06:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt3HMQ/Qa2E+4THPS3lYFr/As/KTDUwtd6B1IFDJ4smFL2ezjwNeRkWkKIxjBpSzNt949ptA==
X-Received: by 2002:adf:b350:0:b0:366:e89c:342e with SMTP id ffacd0b85a97d-371778091e9mr1996754f8f.53.1723642581029;
        Wed, 14 Aug 2024 06:36:21 -0700 (PDT)
Received: from debian (2a01cb058918ce00537dacc92215c427.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:537d:acc9:2215:c427])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeeb09sm12894856f8f.51.2024.08.14.06.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:36:20 -0700 (PDT)
Date: Wed, 14 Aug 2024 15:36:18 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de
Subject: Re: [PATCH net-next v2 0/3] Preparations for FIB rule DSCP selector
Message-ID: <Zryy0jQ0adJU+L7s@debian>
References: <20240814125224.972815-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814125224.972815-1-idosch@nvidia.com>

On Wed, Aug 14, 2024 at 03:52:21PM +0300, Ido Schimmel wrote:
> This patchset moves the masking of the upper DSCP bits in 'flowi4_tos'
> to the core instead of relying on callers of the FIB lookup API to do
> it.

FWIW, I plan to review this patch set next week (I'm mostly offline
this week).


