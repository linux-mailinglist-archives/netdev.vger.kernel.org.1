Return-Path: <netdev+bounces-124257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8A6968B34
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C9D1C2217C
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667C19C563;
	Mon,  2 Sep 2024 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qqggW+dA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C661CB51D
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291820; cv=none; b=dsA6Ixar6gcJCgyO+nLJjDOC9oaGsqX71lu+RaQWgxkL8ZGATotjMwNWWTAI6zcVOWLHY96iqM6/3dIj/n1osJyXNpdUkVw1oub/+qs0sqlWLJmnu4Z+x2mJurJxf6ToGYXSGwkQJNKUUjp4VquaVVTJ3oHE3IBCO7y1eR6pCuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291820; c=relaxed/simple;
	bh=IHnuoGZNJr5zWToilmgXr9M5nFRSDqy3gutoNShHU6s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=KVtv8rXaHlBf9mb4hNYxW/KPVrHtvxSuUWNlQdy0zFbKtDllj1nTUGHFXejWPswLZifvXV2yzmw2bGKETfngtBLv4NunGxfzvOzRger5oonF9orFB3IvPmQi8GsD/VKIIH4CcBkG5V6P6L/nNXVZMLCq+cAlDYPxVoU7BeUe9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qqggW+dA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7142e002aceso3432557b3a.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1725291818; x=1725896618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i36ovGiN9fWknFZkeWoc+3DQG3wGUN8FsAcn1qHd8G0=;
        b=qqggW+dA8kyrfVzqyHxqujy3ySONsbozz12NN8t4krgN6iB50qmbDW3z+9oUbqwGz1
         rKIY8c4iUKK5eRELgi5wYkWrotQj0i9gAZPncyUghDXW9BjHHjZQDqOQmUDxPYNILqFU
         Zz/mrH6w1ovGlGjct+Jh9tDcXRyhIBZDokDXsBJgWX8POSuKOybZlKYKnfBlWBXkHXH9
         HJ+3HyTd94BdjYQ5yyD5O9poPy3VgNRAvOGoH29RAhE6xkDxcdPLIn4G7oUhU10NXrrO
         RxMpK3QxYYiObd/qslsjBGgq40lRCy+tjWUpGxTKQdweG+gfsJfHzIs0nCVxupdkNRML
         R5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725291818; x=1725896618;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i36ovGiN9fWknFZkeWoc+3DQG3wGUN8FsAcn1qHd8G0=;
        b=pJUVdiJbIIzqpbXmSftuhSWqR3V/7/7s/jvMZpbVg4j/o7HwwElfeG6uGZr2dOnZb8
         C0DdFNjJxFJ+4zSLEIgJu9qDheDNm+wvGvsFKvodkGXa0mRrALAfk3JXCjxpDNn1soe1
         iCBCJG80A+ynRyQa59u/CmDO0AzuQPxq3d3uYtKhbEYCGknNzEAAv4pXKgoGcPc6ELey
         9/3OteYY4hbgqZybLoW+jqkGsyRv2lR9o4ZrMp7XntMkpsKDi/uM+44EZcpBYiMJ1wzE
         LRjA1DqQb7wqvRYSAGmqt+wEeCSqRw7S9BUo9VP5YefIC/D84Fecevxw8Wpqz+jWk34y
         /ZmQ==
X-Gm-Message-State: AOJu0YxHi0ghjB2l5Sljp8N3YxjML5tyo7cxz/Oi+dLKvB0FC+mgXpUc
	eZjwS2dzNIrUFN5NN/Pa677MHBpykonrEWwPtWPOQGYVyYZYS3CCREwEsqX4fcUeSWBR06wpI3h
	r1XKYfQ==
X-Google-Smtp-Source: AGHT+IHU9UvxLxLrxiB7tkRBtwVyrRtY/wTZTa7DDT2MfPRJYnlNjVhf0LDnrSyj5ShK5TAPqu4/EA==
X-Received: by 2002:a05:6a00:b01:b0:717:6760:9c15 with SMTP id d2e1a72fcca58-7176760a74bmr892830b3a.20.1725291817723;
        Mon, 02 Sep 2024 08:43:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e66d8f4sm7701159a12.0.2024.09.02.08.43.36
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:43:37 -0700 (PDT)
Date: Mon, 2 Sep 2024 08:43:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 219221] New: TCP connection/socket gets stuck and the
 handshaking is delayed
Message-ID: <20240902084335.1e048358@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Mon, 02 Sep 2024 14:25:13 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 219221] New: TCP connection/socket gets stuck and the handshaking is delayed


https://bugzilla.kernel.org/show_bug.cgi?id=219221

            Bug ID: 219221
           Summary: TCP connection/socket gets stuck and the handshaking
                    is delayed
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: zbal1977@gmail.com
        Regression: No

Created attachment 306806
  --> https://bugzilla.kernel.org/attachment.cgi?id=306806&action=edit  
working TCP connection PCAP file

Hi,

We have a client/server application which is developed a long time ago. It has
been running in production for more than 10 years. The client is a Windows
application written in C++, and the server-side component is written in Java8. 

This client/server software has been working fine for a long time on Linux
servers. Currently, we use AlmaLinux 9. It was working on AlmaLinux 9 until
updating the kernel. 

So, when we update the Linux kernel from "5.14.0-362.13.1.el9_3.x86_64" to
"kernel-5.14.0-427.31.1.el9_4.x86_64" the application gets unstable: The client
drops the connection based due to not receiving messages in the proper time. We
notice delays, the client just waiting for the response from the server. The
issue is always reproducible with the new kernel. And if we go back to the old
kernel, the problem is gone. We kept running the test for hours in both cases.

I attach the PCAP file created on the working system running with the old
kernel (5.14.0-362). Additionally, I attach another PCAP file created on the
non-working system. The difference is the kernel (5.14.0-427). All other
components are the same.

Please analyze it and let us know how to fix it. Whether it is a general issue
in the Linux kernel, or only AlmaLinux distro suffers from that.

Thanks a lot!

Regards,
Zoltan Balogh

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

