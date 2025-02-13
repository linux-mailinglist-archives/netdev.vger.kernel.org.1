Return-Path: <netdev+bounces-166101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD22CA3484E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55A41886167
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABE415A856;
	Thu, 13 Feb 2025 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxCtGmVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2E14F9FB
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461173; cv=none; b=l4JTe9nSbth+pzCE9sxy02Siq5GhpqSio1CR+OZ8DDgeZaj5ol7mVPdAMHugqdJAyithns/1zaibMYOtF4VSJ7vofEcFwpLcykMHqdaCoEidIJJAKjy/xgkYbN4OSTKXbj3nrzvZCX+HHlRfq2bSVG8BpEFXOQZ5TKeD81Icy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461173; c=relaxed/simple;
	bh=uLQ+6gBnByKOpSjHFYmMnrrzCusoPXYgBQtXLa3OKL0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tJV6MVCh96MMxi5lF5Ynka/aGLpEqCatb0+VdYsO6KSBhKfUniXCxUD+De2emilIYpcNXrm4KWPenoXS1fgavan8NFOAxmQLm+BvRxuDRSxSWrO65BAVUYpUXJkB4+t26gHMR+NwrHzFHsYuJfwFrcTI7G3fLd15C6PenPrKQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxCtGmVm; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7be8f281714so96526985a.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 07:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739461171; x=1740065971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udxSQnsofsOOLvjBUrcTda8O+2WRk+wnl9ns6irPrRw=;
        b=fxCtGmVmRESUHqJcqtua/ceGfssc3Yw8DK4WRQBYBJrILdw6AYs9oaEorKiTobMXcR
         JWHsurYJ0Ajh2qPaprrDORktqyIO8oztLyLfWHzOUFu0L7X5w438C+pz0w3nvKvtBDlJ
         5RMm1bro4Hsr6ZBDewefkvMQRxyAgRCeKfhxcCelldry1CFAdOHBZ80PN7iE3Ljrj0I7
         EN1/j0AGshZLmHhNDgfNag6j0KVNXXFh/Vnp1IlvODgMgYM8LsS3TSh1gA7AxWqXA2t8
         bW8QVibxo+A8cWyeNxrxdgnWyA8k5g8iCT+fq5TeYzXQLxioXFJf9s/A2a/QIa51lUsd
         tCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739461171; x=1740065971;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=udxSQnsofsOOLvjBUrcTda8O+2WRk+wnl9ns6irPrRw=;
        b=H3Mv1TjY4br11lk9onQOrRcm8sHKjtfOENofrgtD3zZP3VnN1G9//5DxnKDVuDyRiT
         ygccSLr1BvNdKFW1lxoomwHdfHNu8pVoDrkTlN/Q/j5thZNNCkhYT8rrEKyBUyvmhd8u
         fO9TpE0ezNiei8Zeq62l298Nk/8lxDzEchnsnbJIUJa7mXInKUDQQV2L/gCFmpZDPLgA
         H18vx5sK1m0QBcBlIipcUV+bKQ4Tx/LXYqzxMNP2WyJeCij6EMcqUyJG50p//AFg+D4P
         J4zO+0MKtECEeHi63YoP0HfOjrgspLhBfUKdBQhNZq5qZBXKeUTC/LSQiEoNKM4ayLyN
         OOBQ==
X-Gm-Message-State: AOJu0Yz2NTkUGRUG7PwhTW8aSTX0B9ywAkFLFDWCIrUO6mcTWKnLrHk8
	K2grhAEkvLCfi92GLwCz8z+qXhFoDhDuNIjEXJABK/3jfqHp9Ky9
X-Gm-Gg: ASbGncsPiLg45xMG88uPy0O1BRliQU8aixdtqQA3ppclBbkDtD5Zb9krIZz/CeFushH
	kVQAMRZNoJT+8Q8CBQ+M1ZZyj0obmmx3UYRm6G40zkPddgYREXbtkKmGoMoonjogAXZQj/EA/IF
	Ohj9ysuT6SSTasAaigQ3Y+VvR4mYzYEJY+1HiENIvv8KPj6JwcZoK3l77cNZ+GwJZHresYUl93D
	V+2byY6eW0zjyjbYCls8kHx2CxKIgLAa9BMRrnx149g3SLM8Oet4XmZYh4Q7geySYIs16TkQt6L
	iPnF7KXgqLORSCbJWMbiwknVFIOwotr/xIk7Okmk3PpHZ501mDbb+RN4hSrVhJQ=
X-Google-Smtp-Source: AGHT+IG7ET35I051nGXBw8muZ+jT1VxdlURg0SdujsQCFC+b6ZMARenkQHiu11fmmnu4FosYeNW8Jw==
X-Received: by 2002:a05:620a:628e:b0:7c0:6188:9023 with SMTP id af79cd13be357-7c07a12a8e5mr459489985a.19.1739461170859;
        Thu, 13 Feb 2025 07:39:30 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c87412fsm101210985a.101.2025.02.13.07.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 07:39:30 -0800 (PST)
Date: Thu, 13 Feb 2025 10:39:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 willemb@google.com, 
 ecree.xilinx@gmail.com, 
 neescoba@cisco.com
Message-ID: <67ae123210650_24be45294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250213010457.1351376-1-kuba@kernel.org>
References: <20250213010457.1351376-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] netdev: clarify GSO vs csum in qstats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Could be just me, but I had to pause and double check that the Tx csum
> counter in qstat should include GSO'd packets. GSO pretty much implies
> csum so one could possibly interpret the csum counter as pure csum offload.
> 
> But the counters are based on virtio:
> 
>   [tx_needs_csum]
>       The number of packets which require checksum calculation by the device.
> 
>   [rx_needs_csum]
>       The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> 
> and VIRTIO_NET_HDR_F_NEEDS_CSUM gets set on GSO packets virtio sends.
> 
> Clarify this in the spec to avoid any confusion.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: willemb@google.com
> CC: ecree.xilinx@gmail.com
> CC: neescoba@cisco.com
> ---
>  Documentation/netlink/specs/netdev.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 288923e965ae..0b311dc49691 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -457,6 +457,8 @@ name: netdev
>          name: tx-needs-csum
>          doc: |
>            Number of packets that required the device to calculate the checksum.
> +          This counter includes the number of GSO wire packets for which device

Good to call out wire packets, as opposed to the GSO packet itself. That is
sometimes left ambiguous in GSO counting.

> +          calculated the L4 checksum (which means pretty much all of them).

Can we clarify what pretty much here means?

TSO requires checksum offload. USO with zero checksum is the only exception that
I can think of right now.

>          type: uint
>        -
>          name: tx-hw-gso-packets
> -- 
> 2.48.1
> 



