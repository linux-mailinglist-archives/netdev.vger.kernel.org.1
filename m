Return-Path: <netdev+bounces-169130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B40A42A50
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852BC17179A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EB325B667;
	Mon, 24 Feb 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXX48o7v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5713B298
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419392; cv=none; b=LqVYo3uWkX8gZer+wSXJTfrcjBgnduzZVgPZDdqnvJPVQRhSAz9Z+EnAsyWH9jU3iTU15MOZZfdhdZg3cz48z+uddDM9DH7HCIIKCg4yKDc6IdEDC6qeuIPG5vpdcBTJ2NSbg7Vc+I40FAuhVEvyIsPI9zwKgXkyni86gWyetDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419392; c=relaxed/simple;
	bh=GB1IhONeKR4syl6c0o1osF2NhlaAdl+Sqob8s88LdDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btSRWJPQeyATSS/mvYRqdgH96eKqwfsXNCyIAgJEbApguhkydikF9etGTrrz4RR5FFwDB3TlHZX/HGQVDy1/C39aNSl2x/b7yrWiu+338X9iqvwvZbbOSyCBJIwEVnrZhpmdq6TjKu+dlPDCb0QXd/UVzhWsSg1sDl9zfztz448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXX48o7v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740419389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0HtjuCc448nfsO3TqmBzP4Az8dPXtOK2W5dQj7pab48=;
	b=PXX48o7v3jbYnYGgV0eb4VFeeRS/U/VJMrUXHVisW8ypJ5QJNZ4NonTahDB/Kg+zlkkuqw
	TfwFGOGOu9NibHGHxkh+7JvfJArBgQ/FEKVUNQ+NSap+DyFQf/mn+igLKOLFdZMl02TdnD
	UBCJczv77Y324ddo5i8OH6XjglBTvd4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-JhKDN2X0OkSRGeuF4w7Ftw-1; Mon, 24 Feb 2025 12:49:48 -0500
X-MC-Unique: JhKDN2X0OkSRGeuF4w7Ftw-1
X-Mimecast-MFC-AGG-ID: JhKDN2X0OkSRGeuF4w7Ftw_1740419387
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f31e96292so3090959f8f.3
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419387; x=1741024187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HtjuCc448nfsO3TqmBzP4Az8dPXtOK2W5dQj7pab48=;
        b=DsHwcQJSw7ocA46Qe904hlv/u395I+qvzrxQffaRjFx4Y4+ML6QgugAxVrZ8R9SIN1
         5I3pZZKgx8h1lOJht/2xqD6xaR0OvGJzoIgHDu/wS65d6X3t2B/ziVJs0TH6U+UNmEQm
         PGh3U8DC8vQuuHGrvPLZhOGJRtRNlwVRW3nL3LogpIvuIeM1RX/n2L3b5sZAOedD/faL
         H1PliwLjtT+9btzNJMBPqhZ4LoLpx4nOdRKlk5wJvYJX2dhWbdiDDhiNiV5JrinCUOoS
         oJz+NhTVAVXm8dnAXW/JD/lYAsrbmGZzOG/lbKPhpxmWJc8/OXH5i7TsPbfWC3o4BDAt
         /2cg==
X-Forwarded-Encrypted: i=1; AJvYcCUlcQ+W7KjJim7b9N4UHweo9ozt3dH3fbGMlX/xgOTLmkrTMpxegjnBo3Q7K1vb0/YD60XYBEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNb9m5NsgAoADLVGxC9MnzV8yeLelhrJY8GDiWzcOfBHruoA3b
	UQraRtX7hTMJ4Ur9tlToQfpQ0XFYyZe7WWOdzgqybwRZehNmJJ19d4AOBKZXwXVbcSCCpmhHUG8
	G4PE3K0rVJg1b6qM/zEV1VP0S+B6qLZ0gegPirtj5SfECVz99miW38A==
X-Gm-Gg: ASbGncuUZfGA9Q/M391oEHjSNRo3s89ikSStfCnZjW9hccFRI6t1BkgAfEM9zG6vGIo
	w3Rg5A5zp7N/wIfUEzjor2RJOW2Ko1pZiCIGdwEGE5S/U60n0NipWiZxWRnVrhaDsCfT19TIvU7
	tH/EsGoxKGBVCgH2jizK4znhtiC8dUNl4mE8ZMIhZ6tKO/gFmDh/Fq1X8VYaL6aVUHlZoyoSgGd
	7OzqCTTDAMt7NrmEQfuEtes2adZE2I++yw/fjYNIACj9yV3Mciey+xpsVJDaqB/IW8eUXepk3qK
	RO8=
X-Received: by 2002:adf:f889:0:b0:38a:8ec6:f46f with SMTP id ffacd0b85a97d-38f6f0d540fmr11039294f8f.53.1740419386873;
        Mon, 24 Feb 2025 09:49:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3kEEAF2Ft0BUqbiG2kHcWQ0Y8SKztf5bPzMA6yvnwfDLuqLbiz9E6nJJUVOQTr6tM+U2Xew==
X-Received: by 2002:adf:f889:0:b0:38a:8ec6:f46f with SMTP id ffacd0b85a97d-38f6f0d540fmr11039268f8f.53.1740419386540;
        Mon, 24 Feb 2025 09:49:46 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7979sm31859506f8f.83.2025.02.24.09.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:49:46 -0800 (PST)
Date: Mon, 24 Feb 2025 18:49:43 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: Re: [PATCH net v2 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
Message-ID: <Z7yxN/S1BI4xwy+M@debian>
References: <cover.1740129498.git.gnault@redhat.com>
 <5c40747f9c67a54f8ceba9478924a75755c42b07.1740129498.git.gnault@redhat.com>
 <Z7sw1PPY48pkEMxB@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7sw1PPY48pkEMxB@shredder>

On Sun, Feb 23, 2025 at 04:29:40PM +0200, Ido Schimmel wrote:
> On Fri, Feb 21, 2025 at 10:24:10AM +0100, Guillaume Nault wrote:
> > GRE devices have their special code for IPv6 link-local address
> > generation that has been the source of several regressions in the past.
> > 
> > Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
> > IPv6 link-link local address in accordance with the
> > net.ipv6.conf.<dev>.addr_gen_mode sysctl.
> > 
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> 
> There are some helpers from lib.sh that could have been used,

Yes, I reused a personnal template that predates lib.sh. Given how
simple is the setup of this selftest, I'm not sure if it's worth
including lib.sh. But I might consider doing that in v2.

> but the test is very clean and easy to follow, so:
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Ido Schimmel <idosch@nvidia.com>
> 
> Thanks!
> 


