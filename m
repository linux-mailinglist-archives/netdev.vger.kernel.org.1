Return-Path: <netdev+bounces-65149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B598839614
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E5CB2F960
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC9823BF;
	Tue, 23 Jan 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="NFt3i87m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE060DC6
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028866; cv=none; b=EHvRkDKfwRhMfpYxGsoPTLGt4TecHvDeLt1fJTNRpeukNND4KFYj4FR82n5WmEdKrpBXbsWLMD/DA7IreVywOlJ4dmYuto/+ijWnyfus4FyAX9qrXURu0g/SjZn0pKdqjAWUDLBLRlU0Oxpebx0VjRkWm5NkIBsvQaQLZZ23Q9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028866; c=relaxed/simple;
	bh=v49wOdFkfGDvBsTCyx7TNUbNzYJCSnCOkZ/2XyK2RwY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=lEf+FRJNnU8VK9+UpOwaZVAjtxFsYc+XNOPrt1iQDPOtKihQx2h3UMByN9vBfJzHspwtI7kW3kSeWUGoSGTnxbtw6xwTfjeSZm0TUqpkT2x5aGJTrig7fTIbCx41YUK+CC/owT0ETV6Y+TPjBtXNWwCZaXJwkcqrDPUI59HO2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=NFt3i87m; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6dd839abbf7so518766b3a.2
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706028864; x=1706633664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F47I+XOkhgK9YHBtIL1KEe71K05jCHMYIJPLuW5w0j8=;
        b=NFt3i87mgVAqajk5KqMITewCfK9tkOoZjmnOWBWoMnL2Q+acDzjl/JzK9XEIj9vDXK
         Sb0+kkHcVdu2V+rRvHW8+brH6lHp/ZPgAzTwAseJ03bzWctB4IsoXSTykL+2BTaczOS7
         ce2D4FPDsS7FbMfjSSFMCi6sfUMa+oJ0+UPiPe18q63HuUr23QVJcF9eZz9xvgYDVhIT
         ybyLuHcxVD5lRKJocX+eSJXj6+Ld3NGQJCtwoqPc+2x8mT44GuJfL8ESL47cqbBeQ+Cu
         6ce7pARIRJB244C/pZoJ/JKq4Fb/77/0WKG36SIaq5qcV6VfU0cWsDgZS1Wb1q83oF4A
         cERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028864; x=1706633664;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F47I+XOkhgK9YHBtIL1KEe71K05jCHMYIJPLuW5w0j8=;
        b=LS1mfu5xmPl8cdI18CussWes8hbPJtNNuB9kHjrNGmF7qcLPeqLv+ytU/W4Yp06NqL
         vcZSij35YTDX8VPd8FQyB0KEK5xf14REViRR1b4JcJdjZbBzGZNpOlrQwQ+be55SXNyG
         oJ9rlw634ROSiTqwD/mwv+GRe8xdYHhGtd+G+l/Ay+lZRqvYWfd+V4DAdanzbJd3yX04
         6VD2cBATWx0LzKU4Sa3Hi7fDQs0j3xcpn0c0onngVgvTDjCz7Ko6dPv8YL/PHiYZnL/c
         HDmjq2TH2v7p1/5wqfYNL50C5LIaf6KauFY8zDHaaK2XBsXrlVpV07ALHH21DpX86gUF
         ifmw==
X-Gm-Message-State: AOJu0YxxN+GQxovGPcs7IfEPK/ix6GWGgWTs7L8K/rrdrDmRdiJcw4kr
	ayoQmPcHO/+rm8NiN4o1n+srABXwGOqYEIIQ8SYt4KnUp2KZ5nBFyNZXG/5j8i6LZg/g/fW+c1F
	abtY=
X-Google-Smtp-Source: AGHT+IGuZyGwHmNeb8P/NMYwYZo+Q2JhEme+lKPHWayj+n79t9gTMCn5Hi1pvaRtoVNhYX1WHuDS1A==
X-Received: by 2002:a05:6a00:290f:b0:6d9:cb27:e47 with SMTP id cg15-20020a056a00290f00b006d9cb270e47mr7958207pfb.18.1706028863737;
        Tue, 23 Jan 2024 08:54:23 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g2-20020aa79dc2000000b006d9b35b2602sm11776459pfq.3.2024.01.23.08.54.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 08:54:23 -0800 (PST)
Date: Tue, 23 Jan 2024 08:54:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218412] New: Low throughput in WireGuard VPN
Message-ID: <20240123085422.1061aca6@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Tue, 23 Jan 2024 15:07:14 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218412] New: Low throughput in WireGuard VPN


https://bugzilla.kernel.org/show_bug.cgi?id=218412

            Bug ID: 218412
           Summary: Low throughput in WireGuard VPN
           Product: Networking
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: wads31566@gmail.com
        Regression: No

Created attachment 305758
  --> https://bugzilla.kernel.org/attachment.cgi?id=305758&action=edit  
kernel config

Issue: iperf3 shows low throughput using WireGuard VPN
Host hardware: Intel(R) Xeon(R) Gold 6226R (64 cores), 700GB RAM.
VM configurations: OpenWRT latest stable release, 2 cores from Intel(R) Xeon(R)
Gold 6226R, 128MB RAM.
Network config: Two physical host (same hardware on both, configs in
attachment) connected via Ethernet switch. On host A (IP ends with 33.101)I run
few VMs via libvirt, every VM is endpoint of one of VPN tunnels. On host B (IP
ends with 33.102) I run VPN server, 1 interface with many VPN endpoint peers.
Throughput between A & B is 10Gb/s, the same between VMs and host B (non-VPN
connection).
Detail description: I run different test configurations, for better
understanding I attached all configs and simple  network graph. 
Test 1: I run "iperf3 -s" on host B and run one iperf3 client on VM using as
address destination VPN server IP address "iperf3 -c 10.10.10.56 -b 0 -t 0".
Result: about 3Gb/s.
Test 2: I run two iperf3 servers with different ports "iperf3 -s -p *port
number*" on host B and two iperf3 clients on VM using as address destination
VPN server IP address, but for every client is different port "iperf3 -c
10.10.10.56 -b 0 -t 0 -p *port number*". Result: summary throughput about 3Gb/s
and about 1.5Gb/s
Other tests: Same as Test 2, but with 3,4 and 5 clients. Result: summary
throughput about 3Gb/s and throughput for every client is evenly dividing by
clients' amount.
On B host I use kernel version 6.8.0-1rc compiled from scratch by myself
(kernel config is also attached), on host A is usual Debian 12. Before updating
kernel on host B there also was Debian 12 and here's Debian bug report link for
the same config: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1060912

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

