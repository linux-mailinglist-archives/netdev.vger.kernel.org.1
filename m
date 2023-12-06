Return-Path: <netdev+bounces-54250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42F8065D2
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A04A1C210FD
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FECD30E;
	Wed,  6 Dec 2023 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5BxsSOl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2680188
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 19:48:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-286e05d9408so366873a91.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 19:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701834481; x=1702439281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DzsWET8Scppfs92Z5/clqjXM49WbCHPlk7cu3yoBBw=;
        b=j5BxsSOlTsAtwQtoLiq0tb4wdKt136wqLbY6NgiJihx+ZLysbwlyCmw9+4pa6XlW8y
         /2LkFTk+tXucs7euo+zgfo6qV6R9jmixT8t9eNK7CZiAJ0gAasB5dShWWVHBD4+Gigxs
         XccLyM2GE/HLgsw31DZfFr7ZjTioxtzs2ySbdWTGZt6USKWfJBK+SAHBfaURLjVy8gbt
         PErx3qpkOQTihUmHLm5uG4cbig8eAr0PVveYNWn5JT+myyrHkhtwIup711tn331RdEwh
         Zp0Wa+4RXgUyPDUA5iDsfFsjxbbP5bAk84KqPF1vkRznZXXHoRqnsOg6sy6Cg2fyiNjI
         HHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701834481; x=1702439281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DzsWET8Scppfs92Z5/clqjXM49WbCHPlk7cu3yoBBw=;
        b=tBK6/g+b2+fwwX6i6G0ftLSJY8G0gLBSegx6/2nFbXx4Z4warxrtZQ/FfQl/HY08cS
         mjqCmc3/dlaFDUehDBuZsegCKTzdm5h99L63rmcYNKVxzupfFP+4A83qkYYY60drw4eN
         ii+gtugMo6y4yI2u1T94jVCmD0XsSCmzC07RxEo/8N2fFwW4DrWfH78hGpFl+1Al6eVg
         XHrctOkzb5KBlmD6rezq8DWAk0+JRr0Q2z92/anyXJo9JBrSREwO0sGSFdcKfJuwEvTY
         xm8948zG7JV6nzV6X7ghtXKNrTQCBMDIu/YdonWnZRes6CZV6IWOnZglO9M9xYHl3OGv
         GB6w==
X-Gm-Message-State: AOJu0YzYJT/x0rxOg1f49sKAQWuZKuPqZypQnj74NC9w0WhO5AdnKeHB
	TAHaUFt9MXIgTRwcy6CFL8oVcMe9jKC0Pdan
X-Google-Smtp-Source: AGHT+IHzfZd/grr0aVCC+BIaPiOtVaXk/dCR2B6FYwTzjZU5Dv3ZU2XKX/9aMV/Z8L1QwrKeUmVnSA==
X-Received: by 2002:a17:90b:33d1:b0:286:74ba:a1d7 with SMTP id lk17-20020a17090b33d100b0028674baa1d7mr347086pjb.26.1701834481339;
        Tue, 05 Dec 2023 19:48:01 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 13-20020a17090a030d00b002609cadc56esm5597868pje.11.2023.12.05.19.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:48:00 -0800 (PST)
Date: Wed, 6 Dec 2023 11:47:57 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: selftest fib_nexthop_multiprefix failed due to route mismatch
Message-ID: <ZW_u7VWTpWAuub4L@Laptop-X1>
References: <ZVxQ42hk1dC4qffy@Laptop-X1>
 <01240884-fcc9-46d5-ae98-305151112ebc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01240884-fcc9-46d5-ae98-305151112ebc@kernel.org>

On Tue, Nov 21, 2023 at 09:40:02AM -0800, David Ahern wrote:
> On 11/20/23 10:40 PM, Hangbin Liu wrote:
> > Hi David,
> > 
> > Recently when run fib_nexthop_multiprefix test I saw all IPv6 test failed.
> > e.g.
> > 
> > # ./fib_nexthop_multiprefix.sh
> > TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
> > TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
> > 
> > With -v it shows
> > 
> > COMMAND: ip netns exec h0 /usr/sbin/ping6 -s 1350 -c5 -w5 2001:db8:101::1
> > PING 2001:db8:101::1(2001:db8:101::1) 1350 data bytes
> > From 2001:db8:100::64 icmp_seq=1 Packet too big: mtu=1300
> > 
> > --- 2001:db8:101::1 ping statistics ---
> > 1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms
> > 
> > Route get
> > 2001:db8:101::1 via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 metric 1024 expires 599sec mtu 1300 pref medium
> > Searching for:
> >     2001:db8:101::1 from :: via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 .* mtu 1300
> > 
> > TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]
> > 
> > So we can get the Packet too big from 2001:db8:100::64 successfully. There
> > is no "from ::" anymore. I plan to fix this issue. But I can't find which
> > commit changed the behavior and the client could receive Packet too big
> > message with correct src address.
> > 
> > Do you have any hints?
> > 
> > Thanks
> > Hangbin
> 
> v6.3.12:
> 
> $ sudo /mnt/hostshare/fib_nexthop_multiprefix.sh
> TEST: IPv4: host 0 to host 1, mtu 1300                          [ OK ]
> TEST: IPv6: host 0 to host 1, mtu 1300                          [ OK ]
> 
> v6.4.13 all passed as well, so it is something recent. I do not have a
> 6.5 or 6.6 kernels compiled at the moment.

Hi David,

I re-test this on 6.4.0 and it also failed. So this looks like an env issue
on your side?

# uname -r
6.4.0
# ./fib_nexthop_multiprefix.sh
TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]

And from the test result, it looks we should receive the Packet too big message
from r1. So look the current checking is incorrect and the "from ::" checking
should be removed.

Please fix me if I missed anything?

Thanks
Hangbin

