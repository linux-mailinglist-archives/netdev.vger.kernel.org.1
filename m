Return-Path: <netdev+bounces-217090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED1B3757D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 01:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26C83A5F94
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104C2D641A;
	Tue, 26 Aug 2025 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idpODijk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90083275865
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250540; cv=none; b=b/r3ChjRSwsw1a/novuQj4LEdZusmREVw7utFl02gFV8W7Qwo82C5O8CWPDDN8/4apihNAASgjy10fhAsmPA+C7FLuCzPtyWsn96GVPAyv1FBzJ/WzesWS2uRAReLDlRC781a2XiOJpehBtjG442KmlpoV9TYc4949e+zxgKd4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250540; c=relaxed/simple;
	bh=kLuNpZTf46mYWvgd/TjZEiF3QXO1PKZW1Khx4/zMsR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cG6+GudmpchOUYCWbbkORoGkUtEOq+OXnRXvU2g9bUqBm4mp4VCALdlHfyJGPMfXJ95VjIU478xa/tzLTEM4kvsFBTGu3O1ModFk0cQeoG7uhsJzbkb5ua6bmPDIa3PLJoJauO2eYebg/0d0kdAWIiUdWYC8pA0hseIhuelf8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idpODijk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756250537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYbakeNqXDvZoIn4OrleNk1f2o8M/7Bkg7fdHjTtrHI=;
	b=idpODijkuiKjGj84GK0bLzZcyyZXBS70PmzcN+2Hq65u+az3g34sDq2Udg7kZUEpOytzF2
	fIWJJwkF6kk01BdfJ+jISapefOLn8eL2xt+fE4hNyjs1zvENHZld0QccUoqyPmRH4du7H5
	hcK+QWKN+WwiPKAAzz5WAp1cVriy2tk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-g8PBBMNyP1Kdb3QirdDLEQ-1; Tue, 26 Aug 2025 19:22:14 -0400
X-MC-Unique: g8PBBMNyP1Kdb3QirdDLEQ-1
X-Mimecast-MFC-AGG-ID: g8PBBMNyP1Kdb3QirdDLEQ_1756250533
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3cccba2f06bso1175f8f.3
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756250533; x=1756855333;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYbakeNqXDvZoIn4OrleNk1f2o8M/7Bkg7fdHjTtrHI=;
        b=FSZ/J7pj5+y2BEHA+IJuKexk+Eaku4blDhJRPMkCMhq7l5S36wwxU4F53LBpuy9PXQ
         u9T4CcdHCLnSqT6tGryjZDjua53ws5P8vaedUrre7GvzpLSZh1WOu7d802w+siKInWXu
         PiaD6VuoF/2mQgsf0CLQkarPm5JiNV2MpYV/IAyC6K08mFnwbc+9mnFYKr0/WutGdBGG
         EJA4SPSeabLrXh/CxSbrZx5tN/5Fxc9bnbrwT1v/QjpykUf+4HMY1F5HUZ7dCO1BfcYM
         nwE70WgN2gLKvI/yAhv0Rd3ZZrxU0Ahsyr28ydU8JsZtxWMT5JjkL9tBppklNH/2trW+
         +J8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDqRiXRPgXmRpRBl8T6g9eHfxWjyRrqhMqa6xo7zX0viCf1YBKG66a6RdkBUyISLztk9y9Sk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBObe4MNQuoHNB5OrajtbIAXyqz5HODplQaD0YfNZuuY056yh
	D/9Wj7E8Ox2JHWXjW1wez4HFhRzU3QNjsCEQOLJNOJ5PjDlkCsB9qFr0DoSTzQdBUDdp8Y02l38
	O7SvGUiXdxSPcN2M0OYkmvS7SxGhoa8IOdGSeDJQZ9MavLoEgJe2xrEV/ng==
X-Gm-Gg: ASbGnctg7Wbst9jQY2EWstAWcv5uJHCrnypx9EOv+72ziDMTTFV08wSFf1qRAED31z9
	eJVG0iUiWF8jShQ06nsbn5qhrjKbc8EmwlRpKLzu+Jkvhl6FNB0FToibuYuTVom1ys38B9enmdj
	XzV7axaaGMhKZbjNn+I4dTpRQJ1yOhzmcioFmD0hQ3R953hUIK5rqVDnS5IBYEAwog0AKttOGLg
	YVxTSGq7CWBdCZsPtWObhQvTyVtLjNEsLjux0NoqEtREVC8paGYgKh33W4RnTBzWEKHPZ0+B8oq
	9RDsN6V6VB9Zod0wzmxjbF3yZTde9XswUhWHTnrPdr2Ap5mtZ6M=
X-Received: by 2002:a05:6000:40d9:b0:3ca:5a3f:4182 with SMTP id ffacd0b85a97d-3ca5a3f47cbmr6703654f8f.63.1756250533300;
        Tue, 26 Aug 2025 16:22:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSv80SBs35oyrWhSBvG6oanFOd6tB77q9w/Dh954PGqTPAYxrndJWTK8rehhzt9sQDeSeV0A==
X-Received: by 2002:a05:6000:40d9:b0:3ca:5a3f:4182 with SMTP id ffacd0b85a97d-3ca5a3f47cbmr6703643f8f.63.1756250532810;
        Tue, 26 Aug 2025 16:22:12 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cbc6a5da6dsm3591561f8f.63.2025.08.26.16.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 16:22:12 -0700 (PDT)
Date: Wed, 27 Aug 2025 01:22:10 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Paul Wayper <pwayper@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 paulway@redhat.com, jbainbri@redhat.com
Subject: Re: [PATCH iproute2] ss: Don't pad the last (enabled) column
Message-ID: <20250827012210.399aae3d@elisabeth>
In-Reply-To: <20250826002237.19995-1-paulway@redhat.com>
References: <20250826002237.19995-1-paulway@redhat.com>
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

On Tue, 26 Aug 2025 10:22:37 +1000
Paul Wayper <pwayper@redhat.com> wrote:

> ss will emit spaces on the right hand side of a left-justified, enabled
> column even if it's the last column.  In situations where one or more
> lines are very long - e.g. because of a large PROCESS field value - this
> causes a lot of excess output.
> 
> Firstly, calculate the last enabled column.  Then use this in the check
> for whether to emit trailing spaces on the last column.
> 
> Also name the 'EXT' column as 'Details' and mark it as disabled by
> default, enabled when the -e or --extended options are supplied.
> 
> Fixes: 59f46b7b5be86 ("ss: Introduce columns lightweight abstraction")
> Signed-off-by: Paul Wayper <paulway@redhat.com>
> ---
>  misc/ss.c | 42 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)

For some reason I didn't investigate yet, this still breaks ss -tunl as
well as ss -tunap for me. With 115 columns, before:

$ ss -tunl
Netid    State     Recv-Q     Send-Q                              Local Address:Port          Peer Address:Port    
udp      UNCONN    0          0                                   192.168.122.1:53                 0.0.0.0:*       
udp      UNCONN    0          0                                  0.0.0.0%virbr0:67                 0.0.0.0:*       
udp      UNCONN    0          0                                         0.0.0.0:111                0.0.0.0:*       
udp      UNCONN    0          0                                         0.0.0.0:33335              0.0.0.0:*
...

$ ss -tunap
Netid  State     Recv-Q   Send-Q                          Local Address:Port                    Peer Address:Port  Process                                                                                                            
udp    UNCONN    0        0                               192.168.122.1:53                           0.0.0.0:*                                                                                                                        
udp    UNCONN    0        0                              0.0.0.0%virbr0:67                           0.0.0.0:*                                                                                                                        
udp    ESTAB     0        0                        192.168.1.185%wlp4s0:68                       192.168.1.1:67                                                                                                                       
...

and after:

$ ./ss -tunl
Netid    State     Recv-Q     Send-Q                              Local Address:Port          Peer Address:Port
         udp       UNCONN     0                                           0     192.168.122.1:                530.0.0.0:
*                  udp        UNCONN                                      0     0           0.0.0.0%virbr0:67
0.0.0.0: *                    udp                                         UNCONN0                    0     0.0.0.0:
111      0.0.0.0:  *                                                         udpUNCONN               0     0     
0.0.0.0: 33335     0.0.0.0:   *                                                 udp                  UNCONN0     
0        0.0.0.0:  5154       0.0.0.0:                                         *                        udpUNCONN
...

$ ./ss -tunap
Netid   State      Recv-Q   Send-Q                          Local Address:Port                  Peer Address:Port   Process
        udp        UNCONN   0                                       0     192.168.122.1:                          530.0.0.0: *
                   udp      UNCONN                                  0     0                   0.0.0.0%virbr0:67     0.0.0.0:
*                           udp                                      ESTAB0                            0     192.168.1.185%wlp4s0: 68
192.168.1.1: 67                                                             udpUNCONN                       0     0      0.0.0.0:
111     0.0.0.0:   *                                                      udp                          UNCONN0      0     
0.0.0.0: 33335      0.0.0.0: *                                                                             udpUNCONN 0     
...

I'll look into this soon, give me a couple of days. I still have to
answer some points from 137a3493-bbda-490f-8ad4-fa3a511c2742@redhat.com
as well.

-- 
Stefano


