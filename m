Return-Path: <netdev+bounces-225834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D2EB98C38
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E46A3A992C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440C25A34F;
	Wed, 24 Sep 2025 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUNCyk4z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7E44C63
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701374; cv=none; b=LQ61J1oh+GGh5hxQYKt1V+gaFwlWIP0ePxb/D3yZDK8DGITkS08/wekCCr4ZU6m53TlEEPz/fi86BY915+669VNluvwpAilzEdsQaQRb0f9dBRIYxa5zeerW8LMsASEf2mBKjygmLXrySRSBNGQxpPn0xXN0ztA9kv6TJwiHU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701374; c=relaxed/simple;
	bh=yN34D4nr65Wsoor8Z2EGUyFDYdddHI/hBPfDx61xFec=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=E7FJbHEwCdLlHlJOkLphZQlPtguRRo33UMvakQtGEU6X7/iQ57NMaM1eImH4j8GNVD3bfuZrPkZnQMhKGW1iB3cgfPtC3iBMu5UI3BryMi0Lhk1DJog820Dutb8TQJgQW/ucZlOf4VHouyxai95ylu1VEehp4fD4ZNaGzumzo/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUNCyk4z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758701372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vNgC/M6uvqNIEnG9INC7NWaeFcSnTnmtWsE6hRFwiXI=;
	b=IUNCyk4zp4Ln6VYKBsMVyrsaiarKC6nNJySGJ3Yl+/+gfuwasNXAY95lvJnpWGjKYv0jPJ
	EZjADTeLhtWxtQv5CKM5HSUnqEi4Cjjcz8kE33tsedqxIboJkzgunJI94sGdvbW+rokab3
	vkBvtU6GJa+YION2GBylIesMQjieI8k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-mJks0JTLPGCJ_AGM3LMxbw-1; Wed, 24 Sep 2025 04:09:30 -0400
X-MC-Unique: mJks0JTLPGCJ_AGM3LMxbw-1
X-Mimecast-MFC-AGG-ID: mJks0JTLPGCJ_AGM3LMxbw_1758701369
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e1a2a28f4so15554785e9.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758701369; x=1759306169;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vNgC/M6uvqNIEnG9INC7NWaeFcSnTnmtWsE6hRFwiXI=;
        b=iX8TNideCD/lP6S1MDoEm5os30rHdPw+6AEEnPMEhTAtQAsKzZ9UXTysXeqQb/FmqH
         0Iuqx/F6If6hjHKWLwnO920CXQkWtBrPZHC2NcgRAFKRbwJeYx2B0tPkg+DLA4Beon8A
         KHJkmzzk/czqr0mwpLdujLt2kbNjN2+nlNG8rNyajqNj6LaEAJf+n4cKl6W5gpxUsSB+
         dH2VL/0zARhybmQ0eNI12ef1z0QnadvxYf65o8TtFFiXjH3JFqCv5S/THUPeVWyU2q7O
         8QSTzzaFoteo8bWVcsB3CSr7DfEkgizEwsv9ro5BYr5dFlTTac8iuWfevnPnhoPqWyYq
         /Nqw==
X-Gm-Message-State: AOJu0Yw/166JPCQG3tYmKbzqKyVO6a4GXI5VKMjT8tymq/YtxUx23MDk
	Tw7a5Ze6DZOfHEv18quRIb+nEjfJZb1aBL+t8Vjy14qnNy7j+BA8BTs5gGTp/ZsTZ15NJ1YiBrf
	GwK+woCrcWjTirEQDHzFPhzwUQe5YMu0tDLdZEjCOovCO/0psLLdkmOc07m9El7yxjHEW4Qcgvq
	0EXQga6F7YZN7Q0sXbTaEobK5rb+aHWNmLMozGDgM=
X-Gm-Gg: ASbGncv+yaVohLPRcifmIx15GzZurdnGv1mNiyWiV0udrViMxTcpZv9d2bQUviz/YEG
	Ez1+g03LqdNADgwinHY1OwIG1OjVBv6v5oLD9g3Z/IrN6Ep7xOjH8xn93mvakwXEreJ0DvWYtXw
	0AwSqf3T1yX3Z0Jn1RjUOimy+Cwhj98RbFc9T//IPmKRssEraNh7cO/KW7+xPuHYa4qDMO7tbr2
	EV3fqLR+Ye01isW07NfIpDqpd/FMgPOHZ2zW2e6ofs5NtMgbhA+frJZj8mCnQGOLsXF24fuDVRA
	puszG18ttCbac9nmsGPb7cUGWGkkdBJpAyc7monknV+PjMLTaFSU9ZKzoG+3g0Ig1DDiClnE2/h
	js8CEsgW8tMsf
X-Received: by 2002:a05:600c:350e:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-46e1dace46amr56584695e9.31.1758701368851;
        Wed, 24 Sep 2025 01:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxS6LYGK2a0zGOdPPut+9kW/pN4G6cXH3ZiQbAoAWjqi8GdlcAZGzrD2/aomA8z9TuxOnV5Q==
X-Received: by 2002:a05:600c:350e:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-46e1dace46amr56584275e9.31.1758701368298;
        Wed, 24 Sep 2025 01:09:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1dc3c53dsm28116705e9.7.2025.09.24.01.09.27
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 01:09:27 -0700 (PDT)
Message-ID: <537d0492-c2ad-4189-bb87-5d2d4b47bc29@redhat.com>
Date: Wed, 24 Sep 2025 10:09:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: [ANN] LPC 2025: Networking track CFP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

We are pleased to announce the (belated) Call for Proposals (CFP) for
the Networking track at the 2025 edition of the Linux Plumbers
Conference (LPC) which is taking place in Tokyo, Japan,
on December 11th - 13th, 2025.

LPC Networking track is an in-person (and virtual) manifestation of the
netdev mailing list, bringing together developers, users and vendors to
discuss topics related to Linux networking.
Relevant topics span from proposals for kernel changes, through user
space tooling, to presenting interesting use cases, new protocols or
new, interesting problems waiting for a solution.

The goal is to allow gathering early feedback on proposals, reach
consensus on long running mailing list discussions and raise awareness
of interesting work or use cases. We are seeking proposals of 30 min in
length (including Q&A discussion). Presenting in person is preferred,
however, exceptions could be given for remotely presenting if attending
in person is challenging.

Please submit your proposals through the official LPC website at:

 	https://lpc.events/event/19/abstracts/

Like last year, we have separate tracks for BPF and networking, please
submit to the track which feels suitable, the committee will transfer
submissions between tracks as it deems necessary.

In case of visa related concerns, please reach (privately) for us, so
that we could evaluate earlier approval.

 - netdev maintainers


