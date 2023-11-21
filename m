Return-Path: <netdev+bounces-49551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA57F25D8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 07:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05CD8B21497
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 06:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6233746A1;
	Tue, 21 Nov 2023 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlSUib0M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60710C8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 22:40:40 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b3f6dd612cso3226787b6e.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 22:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700548839; x=1701153639; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eL4jCQeFQIYZYErtx4yG+Kj0J/IpnUxPNL3amNjq+0k=;
        b=LlSUib0MwDRhM3vZ3nyib6id8B0P4QGLs6utn3B9U2xV0o4UlOz0FQrEIKQqhNHu/K
         QrR/y2UvsxKdtpcIZwRGrN9B1sfzpGz8bP0ucQvO8eifDUyWWYQKqUrFHvSni/fQJJ8X
         sAw4/BJ4RRE+tbKfMPncV04esVoZ/nlvn6I471FypMUpVdahCw4QKjTYypkDSMCES3Cf
         kHlANFh+824ssxeHs7zZRRc7WfetZRNuJdGksfdFN9Hb/YTcNpepiztHkyF9Mw7GZ95W
         Ah5+ze+KlpuZAR2l83/a9kIEF7cMjUHyN14DYBCEXXIjiXhurnAJeYeGhIFGb0/3GwFe
         dKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700548839; x=1701153639;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eL4jCQeFQIYZYErtx4yG+Kj0J/IpnUxPNL3amNjq+0k=;
        b=kQNsMZhYe065onYEry9k/l/TFbKylMgdwR029ust3Zsq3d7t3sZgCMjI8qxD633CSr
         UysoomCiwXTU1c/p8DUY5Fah4eRwh9TUo7yWynr9aBe/JOl+UOfzfSoMuqWS0KF21/C+
         i1uzvBIQF4zDkyt6ASGfdIDkFzSrtcrogyUpTLaJzTLzFmDN/7Pol0AHAiYCAXa6JgtN
         QCE8h0HTc2Bx227QGtnVmGrX7ZFHM4I8NBCNbV8Z8ILjf8eryPlO9jQ92iRT0rnV7Ka9
         SuG6h67+AZhGlvfH7wMUVHTd8f0HlsUAZWxnbd1AXA0RRX0otvin5Xj85kCZbxAVHc6k
         3rVw==
X-Gm-Message-State: AOJu0Yx+FWcwSmbWyeRADfIFpNrUjnaVRH6hN69vaBa2gqkZIJlwmELy
	S/L9KmDAtwB5Zs+RD8Ko1rSiJWaH1I2EYBRm
X-Google-Smtp-Source: AGHT+IFR28x8RDScHvGCe6ir5WNJ9ojr4T5O7gyShm5f/P+BeNfNgzn29FzwME8VITm72vOnAEgi0g==
X-Received: by 2002:a05:6808:159e:b0:3b2:ea7c:c402 with SMTP id t30-20020a056808159e00b003b2ea7cc402mr14402857oiw.25.1700548839646;
        Mon, 20 Nov 2023 22:40:39 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fn19-20020a056a002fd300b006c5da6411b9sm7198022pfb.101.2023.11.20.22.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 22:40:38 -0800 (PST)
Date: Tue, 21 Nov 2023 14:40:35 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Subject: selftest fib_nexthop_multiprefix failed due to route mismatch
Message-ID: <ZVxQ42hk1dC4qffy@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

Recently when run fib_nexthop_multiprefix test I saw all IPv6 test failed.
e.g.

# ./fib_nexthop_multiprefix.sh
TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]

With -v it shows

COMMAND: ip netns exec h0 /usr/sbin/ping6 -s 1350 -c5 -w5 2001:db8:101::1
PING 2001:db8:101::1(2001:db8:101::1) 1350 data bytes
From 2001:db8:100::64 icmp_seq=1 Packet too big: mtu=1300

--- 2001:db8:101::1 ping statistics ---
1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

Route get
2001:db8:101::1 via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 metric 1024 expires 599sec mtu 1300 pref medium
Searching for:
    2001:db8:101::1 from :: via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 .* mtu 1300

TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]

So we can get the Packet too big from 2001:db8:100::64 successfully. There
is no "from ::" anymore. I plan to fix this issue. But I can't find which
commit changed the behavior and the client could receive Packet too big
message with correct src address.

Do you have any hints?

Thanks
Hangbin

