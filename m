Return-Path: <netdev+bounces-51152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C37F957F
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 22:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505421C202F1
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 21:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6C512E7F;
	Sun, 26 Nov 2023 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qTkKo0yF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958FE8
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 13:24:38 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cbb71c3020so3092878b3a.1
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 13:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701033878; x=1701638678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiZK0ZeDX/jm0inqwpwlSA5UKrZUOBjNnGqnYMa1U3c=;
        b=qTkKo0yFpIXy2RWmDcK9MDS/qg4CI87hqj3TeRkL6ArF6INKfjiJkWfakH8mU7MOiP
         KKVWQq1HRwoEsQ51DfKawTxYZ9Sp6VLxPfadF/hPfzcs8pwY8MEsJV6h2w465jJHicse
         kELEd44n5i/qSDIEBGnFNGODaOz6wjD0IhJezz74u6KvPJ2Z2YSm8om08tAFamciA01X
         j0KPwbgSHGmDGbwc8iYrwOZYwPFXOiYe/cpoVINr7+y3mZyzRex2UYs519bGrW8Dkbie
         ZxCK+4N/P9tP2KCkZ/lmTW5VtK0K1dNId013Ve6vA27lC4Q63Re/mv31Nn3zaXwRsd0C
         nAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701033878; x=1701638678;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiZK0ZeDX/jm0inqwpwlSA5UKrZUOBjNnGqnYMa1U3c=;
        b=WVnt+bZNl9t+0ZGCf7HknkkhEeIHYirAPm+oT0QZgEv2/ZuEl4dEvRtV7dk8bpoF4E
         7N8wqbIElJSUGXsh9zeY3GMxwB5CHn1eK5ml9ZyhJqQXuw4qaLlH5ZaX6m5p/m6stxw3
         hzHziMdqn5TVvEq+0IC4QpHswXMqcGPGhMaqTKfVBgBc7fCchwZJmIr/aNZb6QhxxaYx
         yFgyr8/+hi2qnRdEGcs0BynecQEZ66uaOPegbaMmBQnEN+5OfVt6WYFlGV8L1mC3eQ8P
         03MfHnFjvwIlyRbOZUJyMP5N+Mc6kpzCkKtNIsmqh481qSIVR+Q7UcCkgwou8F3xwFsK
         tFvQ==
X-Gm-Message-State: AOJu0YwZN6aM7L0Q9ynVUHLJx14g1rkKH2dt6E0wXnhX8+9zkArtMfn1
	Ls8oaMltUU8Dra3vB9gYB8NQ++Pqks+1GjsBycg=
X-Google-Smtp-Source: AGHT+IHIjMnzZAMC0f/HCcgn1I28BZOjOc3K6y5nUz9K+wVGlJLhvpgyTttNloQPtNQkt8YKVMjG1w==
X-Received: by 2002:a17:90b:4a09:b0:27d:433e:e69c with SMTP id kk9-20020a17090b4a0900b0027d433ee69cmr14031789pjb.18.1701033877773;
        Sun, 26 Nov 2023 13:24:37 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001c9ba6c7287sm4425140plg.143.2023.11.26.13.24.36
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 13:24:37 -0800 (PST)
Date: Sun, 26 Nov 2023 13:24:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218187] New: r8169: no carrier with RTL8125
Message-ID: <20231126132435.37a15b21@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Fri, 24 Nov 2023 22:22:16 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218187] New: r8169: no carrier with RTL8125


https://bugzilla.kernel.org/show_bug.cgi?id=218187

            Bug ID: 218187
           Summary: r8169: no carrier with RTL8125
           Product: Networking
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: alex@thinglab.org
        Regression: No

After updating from Linux kernel 6.1.62 to 6.1.63 the 2.5G RTL8125 Ethernet
adapter on my MSI MAG X570 tomahawk motherboard stopped working reporting "NO
CARRIER" from "ip a".  Nothing else appeared out of the ordinary.

I bisected the problem to commit aa0a050c656981521f513fca0a45c8f74141e536
(upstream commit 621735f590643e3048ca2060c285b80551660601).  I patched my
kernel to revert commit aa0a050c656981521f513fca0a45c8f74141e536 and the
network adapter works.

This is my first time reporting a bug to the Linux kernel, sorry if I missed
anything important.  Please let me know if I can provide any additional
information.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

