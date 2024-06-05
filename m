Return-Path: <netdev+bounces-101075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8AE8FD278
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAADE1F29173
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16DB450EE;
	Wed,  5 Jun 2024 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZmiLwpPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145F14D2BA
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603599; cv=none; b=qz+ZUXnLbgcY2TYuClFLTSk6gQuxB8/TFsplmox0vsGlYexKQzLj9Bd5Fr/T1bFtI9uTEzaN1LWLpzJQIu6M5U2ar4WtTwFU1fz8n7/3QqUOkBT17by7KNcI3YoFCvplcXYTXPgDqurHxIKy4kEYeovcIUcxQnwuvINrj7O3cSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603599; c=relaxed/simple;
	bh=6NbYLgWcTtU3CI4DcPLvmB6SHHpfgJG/Ajggkj/Z52w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BcYEVXElA7AKaxTGf4Sus02ytOHgDUufIGcg2cFj3Sd4MIsxlJJXPSzMFkIkDwAkshCBcWLdp4tmVAXrX+EZwf4xybczaWmOkTdD0gPhzafDh9FgqJLko/KMFawDCx6hs+0xZSMbUanvg0+N1sOltyS5MEqD+DWOsoetcKiY1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ZmiLwpPj; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c1b9152848so50720a91.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1717603597; x=1718208397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn3HECsiNUCRmj6abAuKfGBfaL2n+loUIjHaTcWGJ4Y=;
        b=ZmiLwpPj34RyJ8TzCLbxqnymj8a42ewmKaFVCxlmBDmEgWbzxazT0n9Dpzou+929PL
         F8cOGxV3Fy1oVEGFUvNiy864W2MHYdAe54RSShRn9VW50pU1DQXGu6KqFWOX4M+BBDI6
         ULPmCWrqNbc/yYOA151e4KdbLyLErjYl9M7crSuCtsKTOS1M/m6p94JBlLtAdvjSaRA0
         G3rQ4lkchtvAtLp5e8HJg6r2DAYq5zxA5N09j/8GKe16MsGnr5OqUaV5h5N0+vWsoP5d
         wi6UG7gmjSRxZciGVpoaLxdvicL6ORqgwV1vdX9oCuPFa3JcJlYc7hdSnumAKXrneoXc
         PHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717603597; x=1718208397;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn3HECsiNUCRmj6abAuKfGBfaL2n+loUIjHaTcWGJ4Y=;
        b=PpNSBjQU/XpGCoH0hbdDa7fy6IuDwAyR+REi3/WQgR+khvzRFDN6TGVkjE7nRa1x4A
         d/j7Rysmnzt7HEgkFcvS4de4xzAxYAKs/xKdSXWWqG/4Ukm0GDfKO4CXv8phXpESDwnH
         dnwu25/2ZorLF9f08SDdnfoJVeL7+7MuZ76bWd73o5SEttge7iLh79XpeG4rcx0lcz/S
         2F/1d5+1CB6UWd1iUouDPYpY/Tfh/Gpc+Q8Ye3vINh3FS1JLtSzXpnOgyU2LHNzji7lC
         Wftni5Sz62HdrSIgesRh+wu5OBQpXDcdqtJE8yyiorbUhP6wbNYZeJAI2qpWTL8UoBJs
         r3jQ==
X-Gm-Message-State: AOJu0Yxpk/k2Eu1IKcol+srxc2B+Ng1KI/a9fZOOnlFgj5NvrKUXxjtx
	Qz3uXaseqIm1Ldpp39nleAbycNVxsgnu2SvCiLCGkgHD/iI8uua9iC6r245/hvaKYE8mcTrgthQ
	QcG8ydQ==
X-Google-Smtp-Source: AGHT+IE1JA/wSJqUe0o5b4d2QAXthg/wt7/QxQLs0CpD5NN3IW89Vr3ZO6GTQV+Bws9jCKAxUQksAQ==
X-Received: by 2002:a17:90a:a615:b0:2bd:839f:7f36 with SMTP id 98e67ed59e1d1-2c27db002f8mr2772555a91.10.1717603596918;
        Wed, 05 Jun 2024 09:06:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806946adsm1656915a91.25.2024.06.05.09.06.36
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:06:36 -0700 (PDT)
Date: Wed, 5 Jun 2024 09:06:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218937] New: TCP connection frozen on sender and receiver.
 No retries beyond 1.
Message-ID: <20240605090635.30c22c8b@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Wed, 05 Jun 2024 06:26:40 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218937] New: TCP connection frozen on sender and receiver. No retries beyond 1.


https://bugzilla.kernel.org/show_bug.cgi?id=218937

            Bug ID: 218937
           Summary: TCP connection frozen on sender and receiver. No
                    retries beyond 1.
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: joysonanuit@gmail.com
        Regression: No

Created attachment 306413
  --> https://bugzilla.kernel.org/attachment.cgi?id=306413&action=edit  
sender pcap screenshot

Hi,

i am facing an issue in TCP. At a random point in packet transfer,  sender
stops retrying and receiver stops acking. our previous kernel was 2.6 and
current kernel is 5.4. the sequence of events are as below. 

sender:
sends few packets of data.
misses a few ACKs.
retries again. 
does not get an ack. 
stops

receiver:
receives the packets.
sends ack to only few packets. 
does not retry ack for the remaining packets. 

for this FIN, the sender sends RST. 

there is a timeout at receiver end which forces the socket to be closed.
this erroneous socket reaches the end of timeout and sends a FIN with ACK of
all the data that it has received(including the ones that it did not ack and
the sender was waiting for)

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

