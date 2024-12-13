Return-Path: <netdev+bounces-151725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A39F0BC2
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5339D282403
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9D1DEFF1;
	Fri, 13 Dec 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4r1aj66"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2F1DE3C4
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091118; cv=none; b=h80tBwOY2bYxKqBYsgyJ4Kx26aDPppUA6044PDUJdWbE5N47M9Vf5LDamnrk96svnAktsvCvKkC8K9k2Df1W0Xx2lrQc2iesOifpEYD6cynGU3RbmTqWrrgKlIL6KhwPJtc03c4MKDpj+84e8aCOfoetNa83PnLLgGdyqcV6PcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091118; c=relaxed/simple;
	bh=sCG5E7FW1ZgY1kKoORF7VpoTCU6o28RF2sWeFhRJLac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnbVrGeKhty11Rn9e7ZD7lO+rece98z7udfNIQaTXFK3A7MYWGDC7T4ZWnoYKWOlosP7uoVlDJ33z4lMnCAFOQlwKCuyb/0UfDJ1nSHBOFi+f496pz90mZ48JMr2kEmSFJQcTwcF78PMnP06dwXcZ8K7a5cJF1ky+TaDQj1nlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4r1aj66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734091115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ci3xJi2dOS/loX9I22lX9KjU316ZL5ln/MZc8J0hqZ4=;
	b=M4r1aj66XMMopn+8xY6Fpb5Qw22dPMKQaUcG5uu+Ia+WlBgDBjkvCKPmOdcUECIYdctPml
	ia2qN0yqiT8BdiN8a2e1nU6RDjqOmqG0HJVzVQ0gxqbl097bl52tn0v+jWu/8jiKsBit7w
	Lh4+iMR2GmpOine+UO0ruGUaGDhM35U=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-VSUOROIQPWubN5LTZrU46Q-1; Fri, 13 Dec 2024 06:58:34 -0500
X-MC-Unique: VSUOROIQPWubN5LTZrU46Q-1
X-Mimecast-MFC-AGG-ID: VSUOROIQPWubN5LTZrU46Q
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f8f69fb5so58040996d6.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734091114; x=1734695914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci3xJi2dOS/loX9I22lX9KjU316ZL5ln/MZc8J0hqZ4=;
        b=ptVrS1Qw3D5K7eCXC8YSN3nJPM4+9u8OMCLgRbBv3hNhbg5sqHG8VuvG2eloqqGHOi
         cVWU6OOMqWDqaUoM1P5DEdoMoQh8kPDl6k9Sbd15V+jwYrR+MqLnNcTfK/4cFvBQFduA
         yVS4Sk9DcPM95OIo9sTHLz0mpe7Q3ExlAc0bqknkkOch0Mjy8csG0XV52XmwFHnDZAQ+
         GzbP6gSAOKqiC8RtGnt60CM/v4PXjrikR8UxUusbVkoW+OPlckDRkW75pCwcjOHxzTbn
         MtdXWt1v7JAAZnQsCEPHo/oJ5nB4EqZiHCyGdNLetwWMPQ8DgbQLrHrBsaasCBe2Z/52
         ax6A==
X-Gm-Message-State: AOJu0YyJcQZprtVz5e8FxNbBK/AZma7zDzfMZJkq6CIfd9DIGMGsDbWA
	ij5rfBH/ir77r9/TEibZ4v9Dr/2Jcly69/FkfFph0Gj648vLoKUqvNDKCnwkcu2G1rPVmSDw4FB
	FDpNKyhln0bJY6UCjNoyfoIiUx65B8vFzzzppezcnXfvrALQapSrNUMncg5OGQwWY
X-Gm-Gg: ASbGncv4cgE6nWHdJ6jEWKkwHmXS6zizRSL08fykFoTB7id/1QuybGBnSO/5Iws6hi/
	F0n+toe9a+mOnNvlP1ORtfizj7z+FMsHnVyTQLvuVCwWarfcQvOOuXqEuPE+MJCb68EFBk4fWEW
	mmgtiDlgb+neZgsU7kV0kAW2ljJ0Ao5t6ymmvZL8OOm5zYIb4PdCGGf9AMn5FPl/5Ggs8twSjQY
	cpMTGGvb38whryC38Yys4MLHL3itnIdLJ4NLDZzHX4xKUALsfNArUfMPMPVY53fSpKhKG3i1i+R
	7ReL67kF4eQJdvtdmDhxT3GkCLEl+uGp
X-Received: by 2002:ad4:5761:0:b0:6d9:318:824b with SMTP id 6a1803df08f44-6db0f3ae30emr58407046d6.3.1734091113889;
        Fri, 13 Dec 2024 03:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECb0zWJRhZnSP5zSJ+cnrm0bFRRch7r5XWAb+TMGdI4klcHgHiDtg/JDqNFWumePoZhfWm5A==
X-Received: by 2002:ad4:5761:0:b0:6d9:318:824b with SMTP id 6a1803df08f44-6db0f3ae30emr58406796d6.3.1734091113535;
        Fri, 13 Dec 2024 03:58:33 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm91215226d6.88.2024.12.13.03.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:58:33 -0800 (PST)
Date: Fri, 13 Dec 2024 12:58:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] vsock/test: Tests for memory leaks
Message-ID: <352s5hjotedb3lfgy5hajbljjjzbsksr7tvuid6b6fes5s7wqg@nan3d5n64tgv>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <gm7qmwewqroqjyengpluw5xdr2mkv5u4fgjrwvly24pc5k2fl7@qelrw3hzq33h>
 <f3bce5dd-1cfb-4094-b80d-584bd00333d5@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f3bce5dd-1cfb-4094-b80d-584bd00333d5@rbox.co>

On Fri, Dec 13, 2024 at 01:41:56AM +0100, Michal Luczaj wrote:
>On 12/10/24 17:25, Stefano Garzarella wrote:
>>> [...]
>>> I initially considered triggering (and parsing) a kmemleak scan after each
>>> test, but ultimately concluded that the slowdown and the required
>>> privileges would be too much.
>>
>> Yeah, what about adding something in the README to suggest using
>> kmemleak and how to check that everything is okay after a run?
>
>Something like this?
>
>diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
>index 84ee217ba8ee..0d6e73ecbf4d 100644
>--- a/tools/testing/vsock/README
>+++ b/tools/testing/vsock/README
>@@ -36,6 +36,21 @@ Invoke test binaries in both directions as follows:
>                        --control-port=1234 \
>                        --peer-cid=3
>
>+Some tests are designed to produce kernel memory leaks. Leaks detection,
>+however, is deferred to Kernel Memory Leak Detector. It is recommended to enable
>+kmemleak (CONFIG_DEBUG_KMEMLEAK=y) and explicitly trigger a scan after each test
>+run, e.g.
>+
>+  # echo clear > /sys/kernel/debug/kmemleak
>+  # $TEST_BINARY ...
>+  # echo "wait for any grace periods" && sleep 2
>+  # echo scan > /sys/kernel/debug/kmemleak
>+  # echo "wait for kmemleak" && sleep 5
>+  # echo scan > /sys/kernel/debug/kmemleak
>+  # cat /sys/kernel/debug/kmemleak
>+
>+For more information see Documentation/dev-tools/kmemleak.rst.
>+

Yep, this would be great!

> vsock_perf utility
> -------------------
> 'vsock_perf' is a simple tool to measure vsock performance. It works in
>
>> I'd suggest also to add something about that in each patch that
>> introduce tests where we expects the user to check kmemleak,
>> at least with a comment on top of the test functions, and maybe
>> also in the commit description.
>
>Sure, will do.

Thanks,
Stefano


