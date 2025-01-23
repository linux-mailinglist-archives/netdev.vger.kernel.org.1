Return-Path: <netdev+bounces-160511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB4AA1A01C
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0391016D510
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C62C20C47B;
	Thu, 23 Jan 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFC9VKgg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08D20C03A
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621832; cv=none; b=OaFEAi3gipz+gXH1MkOGpuUk5ZteKe6wBYI/YToqYL3yM4TpISMasYDgFBHdrsHJASFClty4cFBe7F974vLhmTbqIWSMFdKaFii/Id4yKw1PQMj4s3rDrRzOJrcRblghqvij0b293pf9pDwJVB2EH8BVUfGh6++tv+ghy9JOUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621832; c=relaxed/simple;
	bh=ha6b9ok5quAYeRP2tfX+AMmeuXgHarjxTmNfEbxLHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns9XENCHebfb8CPA2gSVaGvVknQXrLFaIh2zXTuWwa3t1GOvKhicECRy0EHL9X+O7e2n/mR9paH0L5E/MwNNoRPlF+2KvssvUfyXNLvOU7BWnehvI+vZJeB3nra7BvvFU8LkCLjQcIUcmVfHZK02WSh1peujXZHzSlZJh7tnLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFC9VKgg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737621829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpWDV/ai6Ur+w1Blpv0i6Vc7rkxchZcIx8yap87Tpz8=;
	b=jFC9VKggGxMXJZ/XO5bxgLU5g6tb7xLQ4tAl4oF5qU4ARlEz54lWKdURMTJfUrO+sB/XWu
	+h15Rr0zxR/5rMsnEVN76TSYQp5B3Oa0WjDzxm4VKBO5nZln86PMB3ONcm+TUmGV21fgk0
	a2EZOCN+5Ekcptg01B4KPQ3jbwnIBaE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-8C35_tsSNlaYLoDfh47WFw-1; Thu, 23 Jan 2025 03:43:47 -0500
X-MC-Unique: 8C35_tsSNlaYLoDfh47WFw-1
X-Mimecast-MFC-AGG-ID: 8C35_tsSNlaYLoDfh47WFw
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216728b170cso13971865ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 00:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737621826; x=1738226626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpWDV/ai6Ur+w1Blpv0i6Vc7rkxchZcIx8yap87Tpz8=;
        b=vsD60oMYWCoSsnlTFeQ4T8ItZLKBAm9j/Jr+WdOIl16z3S4dETahK7Hnu8g2YUnIlT
         /R+SDmWPUCP5R2ieooHgKOKyqagTfIC9VqrZaxJXycDrJ9s8JM2WjIjELtm0Jz5gX8Df
         J1BCHgEWFfK3wQ8Bvq6HPzTEvfJHBK+o3IYD7DwIWMTR5c6fEFhckzdRan5vpsUj1Rb7
         gl/nFRz4kwhsgKEMXcscjl7uilqGTEHQDMtMuIadeijD/LYcxVV5TIE1LIOug3KQDG+3
         njLs1liliGyP/th8OQqFg+pDe/yQ7JXQbXSmj4goVnvZGTLd3ksMSExU5HvIWfCuCggp
         KNKw==
X-Forwarded-Encrypted: i=1; AJvYcCXt9i0r+hfGkHkRX7Vh/paInvTI7FSr7C8SpDNY9CEg/ccL/J1Gyi2wH9Mtl9zxoscwDrEjgGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUhkATAotyQLNR3h6ZQ/IZWKJUjI4usd/u+Nk1ilXGFpWoCiH
	HcLhmasyyrMZjLPD4Cbp4vtTkLgID0i6Wsw9vureeIoXYntjO0CLlqm/7G/YAjUkbRCmJJHPFlr
	KP6CjLLPLzcR7tV2gi5f+dvf1kh2bqq1tW9WsAFOWxLfJ6HmZeOQ6
X-Gm-Gg: ASbGncsKyYCwVJc/3anZqsFFYVNb+Yz6TcIGEKGpPIsRZdBt8+tBB57zGr5Pkda4jBm
	RwfGQCE4vIFqeML+HkYl3XgZgrNwe4n31g5yshTEAoVuSuQAI1ls4UsN9yOxtyZ7jV4fgS8aTrH
	9HgjCCTlL6H39XyIawn7seo8hJWDvDOxdDJqdnD9S+JTzcfZ6HuKlGubBWX9dTP9OzoKhsyhrPG
	/XFMl7qV4zPo78d8zM/TQWYK3Duzhyu9zwdRaNWeyzG2EKG8M6fN/YhZW9wMyJoALh6
X-Received: by 2002:a17:902:f68e:b0:211:fcad:d6ea with SMTP id d9443c01a7336-21c355f040emr334907775ad.45.1737621826288;
        Thu, 23 Jan 2025 00:43:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoFyp8mUveTmi4te0YtMoaGtmQKXDYru3r0i2y43Wp7szaIptDNAzb2cDV4fRUJni9KmOC+Q==
X-Received: by 2002:a17:902:f68e:b0:211:fcad:d6ea with SMTP id d9443c01a7336-21c355f040emr334907475ad.45.1737621825978;
        Thu, 23 Jan 2025 00:43:45 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceba9a4sm107223715ad.69.2025.01.23.00.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 00:43:45 -0800 (PST)
Date: Thu, 23 Jan 2025 08:43:40 +0000
From: Hangbin Liu <haliu@redhat.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: matttbe@kernel.org, martineau@kernel.org, eliang@kernel.org,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: mptcp: extend CFLAGS to keep options from
 environment
Message-ID: <Z5IBPOGvfPozjrl5@fedora>
References: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
 <Z5IAU4X1084EFrEd@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5IAU4X1084EFrEd@fedora>

On Thu, Jan 23, 2025 at 08:39:53AM +0000, Hangbin Liu wrote:
> On Thu, Jan 23, 2025 at 09:35:42AM +0100, Jan Stancek wrote:
> > Package build environments like Fedora rpmbuild introduced hardening
> > options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
> > and LDFLAGS.
> > 
> > mptcp Makefile currently overrides CFLAGS but not LDFLAGS, which leads
> > to a mismatch and build failure, for example:
> >   make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/mptcp/mptcp_sockopt] Error 1
> >   /usr/bin/ld: /tmp/ccqyMVdb.o: relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a PIE object; recompile with -fPIE
> >   /usr/bin/ld: failed to set dynamic section sizes: bad value
> >   collect2: error: ld returned 1 exit status
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  tools/testing/selftests/net/mptcp/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> > index 8e3fc05a5397..9706bc73809f 100644
> > --- a/tools/testing/selftests/net/mptcp/Makefile
> > +++ b/tools/testing/selftests/net/mptcp/Makefile
> > @@ -2,7 +2,7 @@
> >  
> >  top_srcdir = ../../../../..
> >  
> > -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> > +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> >  
> >  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
> >  	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
> > -- 
> > 2.43.0
> > 
> 
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Hmm, net-next is closed. Not sure if we can target this to net since it fixes
the build errors.

Thanks
Hangbin


