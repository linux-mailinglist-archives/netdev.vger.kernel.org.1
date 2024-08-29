Return-Path: <netdev+bounces-123306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2419647B9
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1EC1C2220B
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42431AC89F;
	Thu, 29 Aug 2024 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnhqYziX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C736190663
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940869; cv=none; b=CfOosnAZRwOfEfR+82dSFjlB59mFc4G1yG3JC1FGvbxuGMls4NJrZ2Vuua+mfMLK/MyrK4c5x177iI3OHPzCzLkbVxp15PN6EmY5ac5w0izo4ZvmYkV5I9xEWOaVyYvWunAaAvEo2aLkym2hW7Jb1eL1n+juGENXH8wbTpsApQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940869; c=relaxed/simple;
	bh=oV2GAEWEmmdZl4Sj3/4GVJef59YrtByFsnFhit/G1oU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rUd1RzdQbVIvvGNMUVYdM1F8mjaHUYjJL6PtvfWc0Au09Yrp+LJZ6UiKuHZNpfgZ21Jtt7VQPMSNd9kY7UCI2dv97pia7p3T3Gi+oeIOiUNjlWayCp/sfl+4dxU6P45So4P6hSWh7xjISroLQOPzWrzwiBtFMmut6Qsw6MntbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnhqYziX; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf784346b9so3827716d6.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724940867; x=1725545667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTapD99aZwnpmKbZc6bLPVj8wGel7vIgfREHnmDl1lI=;
        b=LnhqYziXzS0suteumbfUYYwtPLorMGK6CVDPNN0rdGraprxUtUeQKdakIs6FnREsSf
         L/Z6CE2xF6FbVXSn4RMkDHOs10BBwNddKt37RkVUIAYYCq4xsQLUqBnOkq5r5iC+Qu3s
         z51aoLjD7p/4y+Qf8rc6OdmcBB6y+SUbpFeLBM6foTiam/aMbpEd4QnpKr1Ay4UuXBvB
         JOTFe6Jx3ANlpycvEmvibHiu8bJes3I+aElx10uIAAt2B3OF5XpFSDAo0gzgPr5pRF3E
         0WqCfaInCnm3Ih8eDSGtzMlc7Lg1LzbynrJc3uhWujUBuE3LsezbsNr5hSoNP2RpKKAo
         ba3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724940867; x=1725545667;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QTapD99aZwnpmKbZc6bLPVj8wGel7vIgfREHnmDl1lI=;
        b=bINmo/QFhSsQ1iLVAPSxDH3Cbf0YxmuV+1lQq6/w8FyNTdirOBUQSnlvPldw2a+/sW
         KC/mkVeFAA4+L8MlfCzHFAzoRuw1p63wxTMWiFKKnFu2bmEgUOSNvqs+2gtwPqrYce3n
         BZnOtugu1nk1WeB7OOJ3T/XRu7eaFtFvC/3a3ieQWdJar9+FgDNHRUpXLtZBl10NUCOo
         V9cwKHTY2UXR8vFAuugH2V+k6bNwKv4DiCXBeujkvL5iGjUUGRnSJ7Mw11AM85ghuUwx
         Qinx4BJR0FRD+6Zq0cSUtPGEq4SxvWItIKI4p4r1S3koytunmX2CtkuQFDToCuh4Susg
         Akbg==
X-Gm-Message-State: AOJu0YyAx/jCHMrq5E1i1ZBhFkwZskl6UOFqGVvKRlaYSa+GxZeaVdQh
	d7XPs5XEKaE6cTjmghKyC7al2W2M7hMFsd1L36Dr6BlvzBgEAzn4
X-Google-Smtp-Source: AGHT+IEDIL8fs+ALa3mknt9vdOvisfZxawy3i24xaXxHhR4z74UHBWqI3ktcFr+ab4lALgFpyWLYJQ==
X-Received: by 2002:a05:6214:5b13:b0:6c1:5546:8acc with SMTP id 6a1803df08f44-6c33e60ffedmr39504546d6.1.1724940866792;
        Thu, 29 Aug 2024 07:14:26 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340db03f1sm5392676d6.138.2024.08.29.07.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:14:26 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:14:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com
Cc: netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d082422d85_3895fa29427@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240828160145.68805-1-kerneljasonxing@gmail.com>
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 0/2] timestamp: control
 SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Prior to this series, when one socket is set SOF_TIMESTAMPING_RX_SOFTWARE
> which measn the whole system turns on this button, other sockets that only
> have SOF_TIMESTAMPING_SOFTWARE will be affected and then print the rx
> timestamp information even without SOF_TIMESTAMPING_RX_SOFTWARE flag.
> In such a case, the rxtimestamp.c selftest surely fails, please see
> testcase 6.
> 
> In a normal case, if we only set SOF_TIMESTAMPING_SOFTWARE flag, we
> can't get the rx timestamp because there is no path leading to turn on
> netstamp_needed_key button in net_enable_timestamp(). That is to say, if
> the user only sets SOF_TIMESTAMPING_SOFTWARE, we don't expect we are
> able to fetch the timestamp from the skb.

I already happened to stumble upon a counterexample.

The below code requests software timestamps, but does not set the
generate flag. I suspect because they assume a PTP daemon (sfptpd)
running that has already enabled that.

https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onload/hwtimestamping/rx_timestamping.c

I suspect that there will be more of such examples in practice. In
which case we should scuttle this. Please do a search online for
SOF_TIMESTAMPING_SOFTWARE to scan for this pattern.
 
> More than this, we can find there are some other ways to turn on
> netstamp_needed_key, which will happenly allow users to get tstamp in
> the receive path. Please see net_enable_timestamp().
> 
> How to solve it?
> 
> setsockopt interface is used to control each socket separately but in
> this case it is affected by other sockets. For timestamp itself, it's
> not feasible to convert netstamp_needed_key into a per-socket button
> because when the receive stack just handling the skb from driver doesn't
> know which socket the skb belongs to.
> 
> According to the original design, we should not use both generation flag
> (SOF_TIMESTAMPING_RX_SOFTWARE) and report flag (SOF_TIMESTAMPING_SOFTWARE)
> together to test if the application is allowed to receive the timestamp
> report in the receive path. But it doesn't hold for receive timestamping
> case. We have to make an exception.
> 
> So we have to test the generation flag when the applications do recvmsg:
> if we set both of flags, it means we want the timestamp; if not, it means
> we don't expect to see the timestamp even the skb carries.
> 
> As we can see, this patch makes the SOF_TIMESTAMPING_RX_SOFTWARE under
> setsockopt control. And it's a per-socket fine-grained now.
> 
> v2
> Link: https://lore.kernel.org/all/20240825152440.93054-1-kerneljasonxing@gmail.com/
> Discussed with Willem
> 1. update the documentation accordingly
> 2. add more comments in each patch
> 3. remove the previous test statements in __sock_recv_timestamp()
> 
> Jason Xing (2):
>   tcp: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
>   net: make SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
> 
>  Documentation/networking/timestamping.rst |  7 +++++++
>  include/net/sock.h                        |  7 ++++---
>  net/bluetooth/hci_sock.c                  |  4 ++--
>  net/core/sock.c                           |  2 +-
>  net/ipv4/ip_sockglue.c                    |  2 +-
>  net/ipv4/ping.c                           |  2 +-
>  net/ipv4/tcp.c                            | 11 +++++++++--
>  net/ipv6/datagram.c                       |  4 ++--
>  net/l2tp/l2tp_ip.c                        |  2 +-
>  net/l2tp/l2tp_ip6.c                       |  2 +-
>  net/nfc/llcp_sock.c                       |  2 +-
>  net/rxrpc/recvmsg.c                       |  2 +-
>  net/socket.c                              | 11 ++++++++---
>  net/unix/af_unix.c                        |  2 +-
>  14 files changed, 40 insertions(+), 20 deletions(-)
> 
> -- 
> 2.37.3
> 



