Return-Path: <netdev+bounces-147690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A59DB35D
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E32B219FB
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C91494A7;
	Thu, 28 Nov 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3ITMr6e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C68146018
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732781314; cv=none; b=Rtg2fzXk2cqFTOP3DYuzv/8eBVEwKLI5Mh1/2M8CatmrRUxxy+6ywAFbSYYauSmlYMGxCx6xYJxi93kIGDOa2r9on18WHM+FUG6Yd+eHiEkYhqLpD4pzTcwMZMU2BX9cg8vdF7KM1Sh2h4bDNUndcT6PkQ4sRnOFP/7NBG8dP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732781314; c=relaxed/simple;
	bh=LqKrHC5XDSttnyGGxHHcASvJVoryjRYX4TBifEno7Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQ6HU+9B4qnNl41kE5qm1r/nAo5L+YdCDwnR4AVkEe86Ij9g99aV6byYLrqnFwuF1eiozLyr13Kt6cGl2Mc/2q2ZGu5jlVlUAapUzQnAKwWSUYlehFdHcYDiKky0l2NzVysVl8tmrs1HMf1j+C9ms4l7Jkvb0JRxRJjoASP/dSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3ITMr6e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732781312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iB3fddQT4tuu1zwH8z5Ad5r52CJZWD+J8s/aw6uP5ZM=;
	b=E3ITMr6eA6eg/SXZ6wJu7j/dGGTMRV+WKbtiSPhTfV2WRf6aaeFfMa0oX/dkVlusF3x06G
	1p3kVmJ4wkVmp7dc0I8Wg6tRQRRvWtwOqO9r7tKEYH2rDWdqm+EA6YLUzXKS2f4zXE5cI/
	JSJRPuSmiu40tDVDaggiL+B+djXSMZw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-iBJxKaWbPX6h-qF2fIudOw-1; Thu, 28 Nov 2024 03:08:30 -0500
X-MC-Unique: iBJxKaWbPX6h-qF2fIudOw-1
X-Mimecast-MFC-AGG-ID: iBJxKaWbPX6h-qF2fIudOw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a90febb8so2532075e9.1
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 00:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732781309; x=1733386109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB3fddQT4tuu1zwH8z5Ad5r52CJZWD+J8s/aw6uP5ZM=;
        b=jvLPmr259+jvRYvRwZAJIesan9rkprip+zuei/5s4GFOeLPnkIlwHlqpvzc71v/9bj
         l6Fr+YuOXLEnzR3rO5Ybha3KI5ZMbVu0CaopoLvk02ZuL4ysezIwn7Dr8+UlqzbkQO4h
         o6wHBcLVjdUAAjoYQ/9QmSRzk2JgMm8lUU9b0sDwCJiaDkvkEaN4uOry26cDragGQY83
         WBe76mieSY3B3gmdhsAnxKDXQaKr0WS50H/idJxxdL5TeEMqub1wRI1nqqE5lxZVMLh4
         Hd+lh9s8iaK7RNJwES+6fCVyMQ/IrHQuy/1SAMBmXX1PS/One4TvRNYnQIVNnFem8+3Z
         o6iQ==
X-Gm-Message-State: AOJu0YyGNRS3h61wFRIF6MAuN0S9afwt8PGeTtvcdJf/+uDmTPhYqH98
	9QbyuVpswYQbkqan3TtsahcBwX3d9It6ZzWkCa2e9gOtSNuckWWT6zYos3ypE7fRmx6jWidYvr1
	yCABgEHanbfApZr5KexpqwfiL3Z6XEqZIRRkOf4gr1ebAi0dWrvoo+g==
X-Gm-Gg: ASbGncuJS3loaemz8zYnCog7A/IT4z9np7org7XL0tK4eOKxIIPJn2QAgUb8NTZVKK5
	Ktj7S8zE8RUwUTqxKAnLxDAempX+IMeygVLoOnpqM0njtP23JmRLNQb8OSKkzUutQg4wdJPeFQX
	6+os8iHc54b3mvL09lKLhJaOGfWBANcvKnTELfkbrOMcgh+psyZFY7DO/fOL1i0KP8aCG93Txz5
	qizuIiyuLzQDiOF0eoNUV4YkGyGEfyr1P3QTMg2GX2hVDKMDEcarXDiwdP+Umg9cvF7mUMKZ6hV
X-Received: by 2002:a05:600c:3ba6:b0:42c:ae30:fc4d with SMTP id 5b1f17b1804b1-434a9dbba7dmr54215005e9.7.1732781308917;
        Thu, 28 Nov 2024 00:08:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk+Ev0FiGTZ+5npTOH3uvSEBKkeXq267aYhyzXY/a73ITNd54dI3/rjALeAZ3U75RkmBZRsg==
X-Received: by 2002:a05:600c:3ba6:b0:42c:ae30:fc4d with SMTP id 5b1f17b1804b1-434a9dbba7dmr54214665e9.7.1732781308551;
        Thu, 28 Nov 2024 00:08:28 -0800 (PST)
Received: from [192.168.88.24] (146-241-60-32.dyn.eolo.it. [146.241.60.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bee2sm13761925e9.1.2024.11.28.00.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 00:08:27 -0800 (PST)
Message-ID: <fc0bb8a7-8c6e-49db-83ba-f56616ebc580@redhat.com>
Date: Thu, 28 Nov 2024 09:08:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fix spelling mistake
To: Vyshnav Ajith <puthen1977@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241121221852.10754-1-puthen1977@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241121221852.10754-1-puthen1977@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 23:18, Vyshnav Ajith wrote:
> Changed from reequires to require. A minute typo.
> 
> Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new drivers,
features, code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


