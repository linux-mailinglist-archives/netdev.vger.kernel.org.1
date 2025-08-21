Return-Path: <netdev+bounces-215578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8BBB2F571
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578833AAB6E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783DD305E2D;
	Thu, 21 Aug 2025 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIa/hYA7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3129CEB
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772568; cv=none; b=e/BnV5G6jE+PEymjZoWkx/XqtV47CvfN3BqbBFFWekZPQWI+qmX/PDUM2Ws+I5zAnCNl7nOxIv/DJr9YWdo7Vh8jtYaYiyDVmlvSgFaCqkFk5XrliAaWrAc185p5dFJNs4yQ/Rvou/DZ8ZynfzzsvYDrE8yu0euNVa0s71DkLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772568; c=relaxed/simple;
	bh=qKer6YT3Q76olAg17x+x08/F9ma42lVqHrtAeHU3o18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je+ah4udTi+oJuIZ5pPjJsHH2WN/9cRgZYWOxxQSVqjAc+k9tTwTlW9hzrVvdNWQL+DmFK11+ycnKtQoxaZve3rWVByu3fAGNsCs+kRX7hme1S4C4HOj8AztlmVO/emuNh6uwTLEKzK8LD0cMVTz9eIecWTFWZLwNXYMU3gHKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIa/hYA7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755772561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6semH6t3oIdm7MpbEFkvxssbKDEQ5+MwdBZngJ3rCfY=;
	b=dIa/hYA71TU9IhwHhP3Cs97N4CukgzTjXevHAnqGm3EJxKYretcJZqgVOaoxHDtUeZddWk
	F2w+gdt6JxM7AcAGN3CMQwgsNH4gUyY+bIBtbTgXRZ3DnZIRfqF1s/dcpVzmIzy8ZBkmlA
	cAHQV3j6SFWLPjqQVi/CBCjoX0ufgeo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-a6CCr_hHM7el8PKbCJJ5Zg-1; Thu, 21 Aug 2025 06:35:59 -0400
X-MC-Unique: a6CCr_hHM7el8PKbCJJ5Zg-1
X-Mimecast-MFC-AGG-ID: a6CCr_hHM7el8PKbCJJ5Zg_1755772558
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso5538315e9.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 03:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755772558; x=1756377358;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6semH6t3oIdm7MpbEFkvxssbKDEQ5+MwdBZngJ3rCfY=;
        b=D0RigBZPM5JqYipPAWYUyjfbwq+rotc9VXvDc+o+bWMCrF3XSkBNNnfUhXqRWLfso/
         R7+uoEVXR/Yj0Q3WpxIrIlTpDftnhzTHVHi924sZ26IztuO8cgz1bzSiDdc2hgmA6Lir
         a8V2rdX3yyj1qSB9eVTDxHdR0RiC3pNvj/6hFwRb8+tRcjoIDP3n0Bg1WW+1GJJuquC5
         kxJRX6r8SBZEY/rtwk4dQp969FO17rmHrdkeb4o7kjHFmWl548/6bWmVph/krecUvLlR
         vuUS+nSxK1ChsPSaFtdDd37Q9mfeyVQCfN68LmLxDV0qjzctoP3ayvfbEIjXzpVVjFEP
         GvIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIv0y5ONFB5ABZFs60rfKXxZIDeYi3+ZWQT5U+jXjuT62bU4LaohrFtrcZ0vGRMZ7JJm96+fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKPsvZLXD48tBOR7p342D9ddzLF6OCkPivuyxaoWFsOdogwwHx
	rGjnBI95z34xmx7ORD38S+8dPHP+i/5sQlL1XsjgOqJyjhgAUbBFZC7a038rQMQLTZrm3tfuLQA
	6G0uAqSflTP6rS9IOpnA7vyRAaJmBP9BYSlnxnHoDaVxI2/gC8JnLkDggtg==
X-Gm-Gg: ASbGncujq7u5GdUvrTZ6hwFsI98O2M0T1VcapWlDtnz0RvG43OfQBMmiz99qTj/wUUQ
	YB/0f/RzxXWF3crBbS7XWjKdm6d9QXC3Aq9Lu94spRHN4SeBPfXxDytzFS2os0/zg9+SL/pCVeB
	l73E036NdBS2rseBT8unuVx0F6n2+zV1pzlSbBg2QOhAgpABCWijIX7vclpqr5RHpF3qw9T0Ilt
	1Bw+Nxa9Kj43MhBGYSct1OHUFrUPnXOe79BVh0CQtNJssgSIWP42QxzhPy8EzEvzb/Rp80hWfim
	hnyO1MgyE3NxXxCsdtyajDC1pAzh0QRJDo1AtNfZZV4BHBztdVk=
X-Received: by 2002:a05:600c:46d1:b0:458:bfb1:1fb6 with SMTP id 5b1f17b1804b1-45b4d7d0f9cmr16418395e9.2.1755772558411;
        Thu, 21 Aug 2025 03:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvDu6Q5YQBHUvDCyaZLIpZafdy6VIAftUNzMrhEs/AM4N8Gk1HXbWN+HSKj1dGaR8OfHL5ig==
X-Received: by 2002:a05:600c:46d1:b0:458:bfb1:1fb6 with SMTP id 5b1f17b1804b1-45b4d7d0f9cmr16418065e9.2.1755772557947;
        Thu, 21 Aug 2025 03:35:57 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e88bbe0sm9102895e9.4.2025.08.21.03.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:35:57 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:35:55 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Paul Wayper <pwayper@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 paulway@redhat.com, jbainbri@redhat.com
Subject: Re: [PATCH iproute2] ss: Don't pad the last (enabled) column
Message-ID: <20250821123555.67ed31d1@elisabeth>
In-Reply-To: <20250821054547.473917-1-paulway@redhat.com>
References: <20250821054547.473917-1-paulway@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Paul,

On Thu, 21 Aug 2025 15:45:47 +1000
Paul Wayper <pwayper@redhat.com> wrote:

> ss will emit spaces on the right hand side of a left-justified, enabled
> column even if it's the last column.  In situations where one or more
> lines are very long - e.g. because of a large PROCESS field value - this
> causes a lot of excess output.

I guess I understand the issue, but having an example would help,
because I'm not quite sure how to reproduce this.

There's a problem with this change though, which I didn't really
investigate. It turns something like this (105 columns):

$ ss -tunl
Netid   State    Recv-Q   Send-Q                           Local Address:Port        Peer Address:Port   
udp     UNCONN   0        0                                 10.45.242.29:49047            0.0.0.0:*      
udp     UNCONN   0        0                                192.168.122.1:53               0.0.0.0:*      
udp     UNCONN   0        0                               0.0.0.0%virbr0:67               0.0.0.0:*      
udp     UNCONN   0        0                                      0.0.0.0:111              0.0.0.0:*      
udp     UNCONN   0        0                                      0.0.0.0:33335            0.0.0.0:*      
udp     UNCONN   0        0                                192.168.1.185:60797            0.0.0.0:*      
udp     UNCONN   0        0                                      0.0.0.0:5154             0.0.0.0:*      
udp     UNCONN   0        0                                  224.0.0.251:5353             0.0.0.0:*      
udp     UNCONN   0        0                                  224.0.0.251:5353             0.0.0.0:*      
udp     UNCONN   0        0                                  224.0.0.251:5353             0.0.0.0:*      
udp     UNCONN   0        0                                  224.0.0.251:5353             0.0.0.0:*      
udp     UNCONN   0        0                                      0.0.0.0:5353             0.0.0.0:*      
udp     UNCONN   0        0                                         [::]:111                 [::]:*      
udp     UNCONN   0        0           [fe80::1839:8c7e:5e64:76a4]%wlp4s0:546                 [::]:*      
udp     UNCONN   0        0                                         [::]:5353                [::]:*      
udp     UNCONN   0        0                                         [::]:39164               [::]:*      
tcp     LISTEN   0        128                                    0.0.0.0:22               0.0.0.0:*      
tcp     LISTEN   0        4096                                   0.0.0.0:111              0.0.0.0:*      
tcp     LISTEN   0        1024                                   0.0.0.0:80               0.0.0.0:*      
tcp     LISTEN   0        5                                      0.0.0.0:5154             0.0.0.0:*      
tcp     LISTEN   0        4096                                 127.0.0.1:631              0.0.0.0:*      
tcp     LISTEN   0        4096                                 127.0.0.1:41001            0.0.0.0:*      
tcp     LISTEN   0        20                                   127.0.0.1:25               0.0.0.0:*      
tcp     LISTEN   0        32                               192.168.122.1:53               0.0.0.0:*      
tcp     LISTEN   0        128                                       [::]:22                  [::]:*      
tcp     LISTEN   0        4096                                      [::]:111                 [::]:*      
tcp     LISTEN   0        1024                                      [::]:80                  [::]:*      
tcp     LISTEN   0        4096                                     [::1]:631                 [::]:*      
tcp     LISTEN   0        1024                                         *:12865                  *:*      
tcp     LISTEN   0        20                                       [::1]:25                  [::]:*      

into this:

$ ./ss -tunl
Netid   State    Recv-Q   Send-Q                           Local Address:Port        Peer Address:Port
        udp      UNCONN   0                                        0     192.168.122.1:               530.0.0.0:
*                udp      UNCONN                                   0     0         0.0.0.0%virbr0:67
0.0.0.0: *                 udp                                      UNCONN0                  0     0.0.0.0:
111     0.0.0.0: *                                                    udpUNCONN             0     0     
0.0.0.0: 33335    0.0.0.0: *                                              udp                UNCONN0     
0       0.0.0.0: 5154     0.0.0.0:                                      *                      udpUNCONN
0       0        224.0.0.251: 5353                                   0.0.0.0:*                        udp
UNCONN  0        0        224.0.0.251:                                   53530.0.0.0:                *
udp     UNCONN   0        0                                  224.0.0.251:5353             0.0.0.0:*
        udp      UNCONN   0                                        0     224.0.0.251:             53530.0.0.0:
*                udp      UNCONN                                   0     0                0.0.0.0:5353
0.0.0.0: *                 udp                                      UNCONN0                  0     [::]:
111     [::]:    *                                                    udpUNCONN             0     0     
[fe80::1839:8c7e:5e64:76a4]%wlp4s0: 546      [::]:    *                                              udp                UNCONN0     
0       [::]:    5353     [::]:                                         *                      udpUNCONN
0       0        [::]:    39164                                     [::]:*                        tcp
LISTEN  0        128      0.0.0.0:                                     220.0.0.0:                *
tcp     LISTEN   0        4096                                   0.0.0.0:111              0.0.0.0:*
        tcp      LISTEN   0                                        1024  0.0.0.0:               800.0.0.0:
*                tcp      LISTEN                                   0     5                0.0.0.0:5154
0.0.0.0: *                 tcp                                      LISTEN0                  4096  127.0.0.1:
631     0.0.0.0: *                                                    tcpLISTEN             0     4096  
127.0.0.1: 41001    0.0.0.0: *                                              tcp                LISTEN0     
20      127.0.0.1: 25       0.0.0.0:                                      *                      tcpLISTEN
0       32       192.168.122.1: 53                                     0.0.0.0:*                        tcp
LISTEN  0        128      [::]:                                        22[::]:                   *
tcp     LISTEN   0        4096                                      [::]:111                 [::]:*
        tcp      LISTEN   0                                        1024  [::]:                  80[::]:
*                tcp      LISTEN                                   0     4096               [::1]:631
[::]:   *                 tcp                                      LISTEN0                  1024  *:
12865   *:       *                                                    tcpLISTEN             0     20    
[::1]:  25       [::]:    *                                              

> Firstly, calculate the last enabled column.  Then use this in the check
> for whether to emit trailing spaces on the last column.
> 
> Also remove the 'EXT' column which does not seem to be used.

It's not referenced explicitly but it's definitely used, see also commits:

8740ca9dcd3c ss: add support for BPF socket-local storage
84c45b8acb30 Reapply "ss: prevent "Process" column from being printed unless requested"
f22c49730c36 Revert "ss: prevent "Process" column from being printed unless requested"
1607bf531fd2 ss: prevent "Process" column from being printed unless requested

Now, while 5883c6eba517 ("ss: show header for --processes/-p") and consequently
f22c49730c36 are obviously broken (sorry, I didn't review those, nobody Cc'ed
me), they clearly show that COL_EXT is used. It's for stuff like TCP extensions
(say, 'ss -tei') which have no own / specific column header.

-- 
Stefano


