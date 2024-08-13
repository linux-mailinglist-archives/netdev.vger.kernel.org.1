Return-Path: <netdev+bounces-117968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB719501CC
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB2B2858FF
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9E186E5C;
	Tue, 13 Aug 2024 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avG9XBW6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E00153BF6
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543074; cv=none; b=fJHsE360jka6IFFX3tk+jHRFRit03q5FJ28pvY66GgyeOTVvhqm7jzwcoWrtBXUGJiHHEj0YvdWR+R7HB9CmT4hpfG6oCmzaw5D+s70s2mhCoGvLAMEFhzSezkMuWgR4d3cDSD76KOUV8VFCh9npGVqr2GdwZ9o/qoWGjQc2mEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543074; c=relaxed/simple;
	bh=Zj1rImno7dsl5cuukxiX8vkmQkWJpsfOjDCQMTjGVbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2CMxM5XRg4tDB5nIZVaxoAydgpjtdtDQeoUmaCWSilfNWVRtV/JktkPb3x3hdiaNP/9Ef/DoOJGACgIvCGrrxr0rPs46hDVXFhjAx+91fvoE6vK8rrCxR2qwFMp9m8tU7avynUxPGDKFvglMRYpR3W0WOdvOT5REXpNKVDGAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avG9XBW6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso4199190b3a.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 02:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723543072; x=1724147872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBKAJ2QRs7836gtgDQCS1z9pmNUF7ouozt8SI82IwuA=;
        b=avG9XBW6QCaQtwH/DHDjjeK8dGij2XE7m/h16BHaxsgo5z35XsGspHQ/HPI9m1w/OQ
         ZgqXWMi5yznRi1T3RK/XNVvogQatgaYsQsaxHTZ7m/nQYFEosMwl4nEGDEH0S1SQa5QA
         prnKQmR6c3XJhAuRY8lha0AflD9Fo34kXD1pLUVbblV3k+FQa+bP/D02u3CU32OhjFR1
         XlUyvMKMBL2uzOfFwJvnSsnL8mqKRycZpeLfabwsGONR6HkJu7TdLJ/AUgfLU1tsCJS8
         1woAZWEuv+bBhBdWNXRLvE61BU+0DqrvRLh2uyfkQgMTv/ZZPtE96FPbDaA2+tFoLAx4
         uGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543072; x=1724147872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBKAJ2QRs7836gtgDQCS1z9pmNUF7ouozt8SI82IwuA=;
        b=ez3g3Lsr7kJR4tXiFqxEiz02u4TWDsEi0r4xbi7jrn1uFUI096WSthNIGrR8TRUOdv
         P++5E+7Fg9eigI9VSA580y2U2F0QkpTHszuphXU0SY2ZpJQxwQr7I58YbO8RqlJnaegH
         6e5zWFw0ph34Wli/JN4H8/bSDtFRtlOphjVwxj4+I8lmkeJ0dnKXRJrWBgNCdropT6YA
         8O9AOJiDdBC7SPav2hoIRxIBh+onZduF5oRePAkGmXd2tOOBn08iLPbQSi86nE4FUUnx
         08GuzMmAc/6jxGJ1MjRURIAusuzaGq0+e8x74nxgCC4yFkjki4So1MAsWaekD091Q589
         7DFw==
X-Gm-Message-State: AOJu0Yxak8YCJaHJebM8lI5ziEjaCJ4dn3mcKNaN3nlccw6P8oxDL5g8
	KknEttBYziL0wMOUvOiz/8pkaxzut1jGvhoGKc74tVLpJ6XGlVF/vj4WYTEGOl8=
X-Google-Smtp-Source: AGHT+IF34xu2rfVWIsJPeInWevpf7WFDX5IHvPPp7OeVQWkEGxumGmpnX51XUBYPbfN4H38/7kH5gw==
X-Received: by 2002:a05:6a21:7108:b0:1c8:d4d4:4131 with SMTP id adf61e73a8af0-1c8d7586bc0mr3324911637.40.1723543072168;
        Tue, 13 Aug 2024 02:57:52 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58729aasm5533962b3a.14.2024.08.13.02.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 02:57:51 -0700 (PDT)
Date: Tue, 13 Aug 2024 17:57:47 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [selftest] udpgro test report fail but passed
Message-ID: <ZrsuG2KK9jkQOd9e@Laptop-X1>
References: <ZrrTFI4QBZvXoXP6@Laptop-X1>
 <6517ad52-e0c6-4f68-aa7a-8420a84c8c23@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6517ad52-e0c6-4f68-aa7a-8420a84c8c23@redhat.com>

On Tue, Aug 13, 2024 at 10:24:34AM +0200, Paolo Abeni wrote:
> It's just pour integration between the script and the selftests harness.
> 
> The script should capture the pid of the background UDP receiver, wait poll
> for a bit for such process termination after that the sender completes, then
> send a termination signal, capture the receiver exit code and use it to emit
> the success/fail message and update the script return code.

If that's the case, we shouldn't echo the result as the return value will
always be 0. Is the following change you want? e.g.

@@ -115,16 +113,14 @@ run_one_2sock() {
 	cfg_veth
 
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 1000 -R 10 ${rx_args} -p 12345 &
-	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} && \
-		echo "ok" || \
-		echo "failed" &
+	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -C 2000 -R 10 ${rx_args} &
 
 	wait_local_port_listen "${PEER_NS}" 12345 udp
 	./udpgso_bench_tx ${tx_args} -p 12345
 	wait_local_port_listen "${PEER_NS}" 8000 udp
 	./udpgso_bench_tx ${tx_args}
-	ret=$?
 	wait $(jobs -p)
+	ret=$?
 	return $ret
 }

> 
> Could you please have a shot at the above?
> 
> BTW I sometimes observed similar failures in the past when the bpf program
> failed to load.

From my log I didn't see bpf load failure..

Thanks
Hangbin

