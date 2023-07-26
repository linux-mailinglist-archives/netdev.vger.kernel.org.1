Return-Path: <netdev+bounces-21478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152B763AF4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE0C281268
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E7E253BF;
	Wed, 26 Jul 2023 15:25:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8ACA63
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:25:20 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B1BF
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:25:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8ad356f03so37070705ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690385118; x=1690989918;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HwU83KyfYL52e0A7otI8rEo2LNATPQ6ucSmAXXbEsfc=;
        b=AWDFuBazCEQvIE0oPByTTdcBP9oy0WSAmmnMD4KWYXDyxkt9t1NSFpkHYQ3KR06S53
         7B3eewVtHo92veGq7fhKjWSfPKl4RbE3fK9F7ytpNE1jbKhZDRW+64BL/qCGzQeTLka0
         lt2zBEw62z5cTEZmoxT9XCPT1FKmdWBPwAwrGPN8Jt8/vfSPiS//rmrTC/TkXavmzJSt
         AXG/JVjZZIlXO6QE96UPoSIVO/rbemZDiMTRoJppxYFBtSXUKwBgLmSLP44tUHHerg1P
         DAinAs4kgrVx/c2jZWlpy/AZG7o91WZsbO6akeQgjYAkTqWz8+dSp8OaH60JFh68arhI
         ETlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385118; x=1690989918;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwU83KyfYL52e0A7otI8rEo2LNATPQ6ucSmAXXbEsfc=;
        b=YyTPCZVWnV1KE35AwczbNWg0S2os8VErBQPAbvFtGkeeRNjJ+gG8IDJxjbb5o+7BI4
         gpwAc9NeoCS1kSVZVAY/pn5BYiBwtjvLiqWirI8i0ZXVejUF984tVxkLVnUye1qKY6dk
         nGwb2+BGi6dz+rle72/f/rcbNIdHJJqb/Ma4ghws0Nm9XYXoyeA12NhP3P6Z+DOzBjEs
         ln0ydNnlWd9vbu5olgeUnpufCXwn1N7QRo5fs0i8WmwH88fGMD09m1+TDYc36W4qAm3c
         R5tjbLCSiELZbZAfU0DdQng5rb1WlKW6uNHpQQytoVMgjZMoBDZDSiy3xrOXhpefT8fQ
         /7Og==
X-Gm-Message-State: ABy/qLb4wJR7brIvPvDCfZGU0Xx+wQ5gUMSpu5v1Y9F/2zLgD3tylvpk
	JgfkGaRVHQOGXcMvCuYItNxhAHNnTpt1Jy/UFprwpQ==
X-Google-Smtp-Source: APBJJlFS9yCc/h0zL7+huCnV2QL8zaZp1MTjzQ+5K2H/qmliF1MlNWima4e6bQbrGdyP9PdKUZmeFw==
X-Received: by 2002:a17:902:e314:b0:1bb:8cb6:2403 with SMTP id q20-20020a170902e31400b001bb8cb62403mr1850698plc.20.1690385117905;
        Wed, 26 Jul 2023 08:25:17 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id jw22-20020a170903279600b001b9da42cd7dsm13295972plb.279.2023.07.26.08.25.17
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:25:17 -0700 (PDT)
Date: Wed, 26 Jul 2023 08:25:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 217712] New: AF-XDP program in
 multi-process/multi-threaded configuration IO_PAGEFAULT
Message-ID: <20230726082515.709b87eb@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Begin forwarded message:

Date: Wed, 26 Jul 2023 13:00:28 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 217712] New: AF-XDP program in multi-process/multi-threaded configuration IO_PAGEFAULT


https://bugzilla.kernel.org/show_bug.cgi?id=217712

            Bug ID: 217712
           Summary: AF-XDP program in multi-process/multi-threaded
                    configuration IO_PAGEFAULT
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: joseph.reilly@uga.edu
        Regression: No

Created attachment 304701
  --> https://bugzilla.kernel.org/attachment.cgi?id=304701&action=edit  
code to reproduce bug

Hello,

I am currently doing research on AF_XDP and I encountered a bug that is present
in multi-process and multi-threaded configurations of AF_XDP programs. I
believe there is a race condition that causes an IO_PAGEFAULT and the entire OS
to crash when it is encountered. This bug can be reproduced using Suricata
release 7.0.0-rc1, or another program where multiple user space processes each
with an AF_XDP socket are created.

I have attached some sample code that has should be able to reproduce the bug.
This code creates n processes where n is the number of RX queues specified by
the user. In my experience the higher the number of processes/RX queues used,
the higher the likelihood of triggering the crash. 

To change the number of RX queues, use Ethtool to set the number of combined RX
queues, this may vary depending on network card:
sudo ethtool -L <interface> combined <number of RX queues>

Compile the code using make and run the code as such:
sudo -E ./xdp_main.o <interface> <number of child processes> consec

To get the crash to show up, lots of traffic needs to be sent to the network
interface. In our experimental setup, a machine using Pktgen is sending traffic
to the machine running the AF_XDP code at max line rate. Using Pktgen, vary the
IP/MAC addresses of each packet to make sure the packets are somewhat evenly
distributed across each RX queue. This may help with reproducing the bug. Also
be sure the interface is set to promiscuous mode.

While sending traffic at max line rate, send a SIGINT to the AF_XDP program
receiving the traffic to terminate the program. Sometimes an IO_PAGEFAULT will
occur. This is more common than not. Also attached are some screen shots of the
terminal and of the output our server gives.

The bug occurs because each process has the same STDIN file descriptor and as a
result each child process gets the same SIGINT signal at the same time causing
them all to terminate at once. During this, I believe a race condition is
reached where the AF_XDP program is still receiving packets and is trying to
write them to a UMEM that no longer exists. The order of operations to cause
this would be:
1. XDP program looks up AF_XDP socket in XSKS_MAP 
2. User space program deletes UMEM and/or AF_XDP socket 
3. XDP program tries to write packet to UMEM

This can also be reproduced with Suricata as stated earlier with a similar
traffic load as described for my personal program.

If more clarification is needed, please reach out to me. I would also like to
know if this is an intended design or the cause of this bug. I look forward to
hearing from you!

Best,
Joseph Reilly

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

