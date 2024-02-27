Return-Path: <netdev+bounces-75459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F909869FE0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 20:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FC61C22775
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C134E1DC;
	Tue, 27 Feb 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bmnxO5Ob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066C3D988
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060865; cv=none; b=GeXNTpeKRWE7YgnPn//DZ2PWw2wg/xwuf0s/aroIwVbgYXs+uyvKKqYqVjprIwXxKqkVQIXGBKeHFpwb507coLf7MiyCPXaoR4vcj7/IjIPavksKr+LroJ4dHnzD4CX59NM08OkS6wa0rLwZGAflBef3fWrQbc401ar7fbXNV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060865; c=relaxed/simple;
	bh=8J5T/RCy12XyZUi7KtW8D6AQEm+IHJwaIE9IIco6gng=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=C57pF7Jw8cNGkXtywp+AoiqI3D/XRuj2sny0SjbW1hrieehst2GmNo6Zp7hEvL4E1P26o1zt6HJDjA6zSXliGIzq962jyLjc9belwAwdAYx3jVR5jQQIbf+v37Dkj7GO2Xpl6n/TB579gKAh6twi7T7FmCxX/X0dFALin99aOeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bmnxO5Ob; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e508725b64so1187796b3a.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709060863; x=1709665663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RC4cLOrzOlsDyKwjIVeyujamqewjmClEiupakdCMz1c=;
        b=bmnxO5ObrLmCWlRjyagwACJivk2qJb01PBkF/RpKjJP4FErFa4zMGG7+8bkwxu12+T
         N8/gfAWm70f/FnUUyJCUd2w3QsSUxWym5bwx1k9bbbjQET86Qn0w81hYDSsr1u53uncH
         jCoeUTbUy9fwPeW7VlWODsurmcgNZlEeOTfeX7PisbsgUoKMPsBs0JGXB9OV1mzSISZK
         j37kuKl+QxsaedfJXjKIh/xay66Jjy5oTsbzqnVprM2VLFm29wbRI9ldITV5idRs9X8x
         JEpvfYoqLdlg6R0MRIuwPGh3dLT919XxuxnuDevoYkbtxiGxg3V2wJY986FrNCvwCETK
         WItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060863; x=1709665663;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RC4cLOrzOlsDyKwjIVeyujamqewjmClEiupakdCMz1c=;
        b=XvB7epAJlONe1/bwyAwOJNbt1BQSzLunbo6H3AB/59uKZIHMocEGikukGy4PmMnvmW
         5GsAlhF2HXcjy5MplwcEhkyhDyffEmyMk0mW0cjP2oL36ARunEYOBMjFkZQ1mSjhqClz
         jbbuGRWsSh40JJCzobXZSLSyC4aJvSF9LKShMvhtiamEajs8lx2UaOy6my5J5KhCqw2v
         6Gk7cGxpnEpPK/tCX3gB17dXQ1YkdIQY9/g3I8ebyBds1snYgFOfSclzM8vybJkfH14B
         qZ10WSkQ84YG8TsUhEFNNv/sLTA2g/jbuJrU3Wf/FrSQZC1zW3iHMXS1VwCvCahD6QnQ
         FJ4g==
X-Gm-Message-State: AOJu0YwL552FCGclv52axEtL1iW7wQCE17QF2dhcMH1Yko3tQsrnilLK
	hE1jpK4qD4sIXrcRxe72qpP28S5OLz9fGyiQfRAdK3RRrupMToY5Z59uP9tXaZQumqjak/6ART3
	P
X-Google-Smtp-Source: AGHT+IHZTDw+NERddhJCBJnf50sG6cOv2L8HM9DodsrEU4MTbMR0V/ZjOYn0mo5W7WhFR9soMc+UBw==
X-Received: by 2002:aa7:871a:0:b0:6e4:6625:5aef with SMTP id b26-20020aa7871a000000b006e466255aefmr8226927pfo.16.1709060862733;
        Tue, 27 Feb 2024 11:07:42 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ey11-20020a056a0038cb00b006e319d8c752sm6345016pfb.150.2024.02.27.11.07.42
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:07:42 -0800 (PST)
Date: Tue, 27 Feb 2024 11:07:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218536] New: divide error in tcp_rcv_space_adjust
Message-ID: <20240227110740.0f657fbe@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Tue, 27 Feb 2024 18:16:35 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218536] New: divide error in tcp_rcv_space_adjust


https://bugzilla.kernel.org/show_bug.cgi?id=218536

            Bug ID: 218536
           Summary: divide error in tcp_rcv_space_adjust
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: adam@mizerski.pl
        Regression: No

Created attachment 305916
  --> https://bugzilla.kernel.org/attachment.cgi?id=305916&action=edit  
dmesg

Kernel: 6.7.6 from openSUSE Tumbleweed (but I noticed it happening earlier as
well, not sure since when)

Network card:
Bus 002 Device 005: ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit
Ethernet

Reproducible: Happens maybe once a day or few days. Don't know how and why.

Symptoms: Firefox stops being able to make any network connections. I need to
kill it, because it's stuck even when closing. Everything else seems to be
working fine (including stuff like https://github.com/debauchee/barrier).

Call Trace:
 <TASK>
 ? die+0x36/0x90
 ? do_trap+0xda/0x100
 ? tcp_rcv_space_adjust+0xbe/0x160
 ? do_error_trap+0x6a/0x90
 ? tcp_rcv_space_adjust+0xbe/0x160
 ? exc_divide_error+0x38/0x50
 ? tcp_rcv_space_adjust+0xbe/0x160
 ? asm_exc_divide_error+0x1a/0x20
 ? tcp_rcv_space_adjust+0xbe/0x160
 ? tcp_rcv_space_adjust+0x1a/0x160
 tcp_recvmsg_locked+0x2c3/0x950
 tcp_recvmsg+0x73/0x1f0
 ? __pfx_pollwake+0x10/0x10
 inet_recvmsg+0x56/0x130
 ? security_socket_recvmsg+0x41/0x70
 sock_recvmsg+0xa6/0xd0
 __sys_recvfrom+0xaa/0x120
 ? switch_fpu_return+0x50/0xe0
 ? syscall_exit_to_user_mode+0x2b/0x40
 ? do_syscall_64+0x70/0xe0
 ? do_syscall_64+0x70/0xe0
 ? syscall_exit_to_user_mode+0x2b/0x40
 __x64_sys_recvfrom+0x24/0x30
 do_syscall_64+0x61/0xe0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

