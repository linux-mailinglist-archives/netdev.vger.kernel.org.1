Return-Path: <netdev+bounces-172494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D258A55052
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7A93B364B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ECE212FAA;
	Thu,  6 Mar 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SouHkH3u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56E212FA9
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277454; cv=none; b=I0VKFYRMSrnEYVYDHrsq24PGAQhJjwkAdlNiE3AR05BmwSRJ/ybTGPrf16tCWHg+HN1w9Cocl4c0bxQcIeByw/9iciBA5ELdxZvSTq7D/eDt4r3Ua06kWGgHem1IqQsPkUUbAxL+fi5i+NLR/O12wF+BRB1QJAKBubQ9FJmzjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277454; c=relaxed/simple;
	bh=0hhfLP3N8asA/s0wef0L8K3outHWOZC2tvRGZLxMAa8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RvHHXu3JZ2ZGZXcv9qk/JSrthYy+tIXETr8wT8D+s9SzaSvrtvXb1KqF+UvBn46pfXTrWmMQNWfrDdIBxZ3VdMUsx80/RTjcZqDRMiJKu8PelLDfXx5nTg3o9uD4lgwk7k0O3WooI713OC17ehgqfMD9XrmyBh7Etn751N2ERLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SouHkH3u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h9R6KO2tPUArbtew5KJP6KvYe+R1MIMLdE3yjt20XBE=;
	b=SouHkH3uE5IO75UWH8Bu3xDoCmLfpsiAdMcCjbbB5Pb+6yVrQR2RgPtO+2LjkyJ/agzt1W
	Pkl6p2vYIEWZ0taxspRhdbkrDpzgtFw6G4qgHhg0AdrHa/3aTMbTq2XTCOZiMaV41NOsZm
	7EMNaHNOzNo/jZurT31xbKyc/V0D1cI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-nhj_7MTAMc6WQI02k9FciA-1; Thu, 06 Mar 2025 11:10:33 -0500
X-MC-Unique: nhj_7MTAMc6WQI02k9FciA-1
X-Mimecast-MFC-AGG-ID: nhj_7MTAMc6WQI02k9FciA_1741277432
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390e62ef5f6so354610f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 08:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277432; x=1741882232;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9R6KO2tPUArbtew5KJP6KvYe+R1MIMLdE3yjt20XBE=;
        b=m7sM7kghJT60tOSPM+p6KI8Tp2J3rKyx5oFc4nZt2iOSItsXOR886UYJ4ycLWAuhai
         cjXHjkJEysF+x7JrUjPhxBxDQ3u98wW56jAoO6KGGLKJaoRTKX80n+Q+Sp4KWdo7zmSs
         VzyqAKdRZ8EGI9grYcSbOGBrCZdV5+gqikDXNj/EiRWx72MJfQU2l79PU219u4D0pY8e
         IHxfWCOlBcEfzfXFkz9TVoXluKVerSg0cL37MnMG0mBY6DK5fw90Os7KngfScolnZZVh
         ogLcSpWshVz9sACFIne5pHyjKXNT6DL+BL/vnWUYkkCSvJ0f1sEoCPOrZwQ3qf2dTEEw
         uhow==
X-Forwarded-Encrypted: i=1; AJvYcCUxxHNWJ8Q/FYzoquUQqHEHp+WiaRZOSHbFFgFO+AisUM0iMFxzZFvQxET4WrbKgTDQlbCLXNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xbeFEf5lMvXM6G6YRD70r/LoUEBjdNF/4zw8LHlYFA0Z58DR
	4OxZcXAS67Ki5JH2oyVqyZUPr+Mazkl5j40bvqXzZIhvRvNkwijgB/sC5LKlnzYdgiWoR9mftiV
	aZMtyI9rtrq/aRZ09WsrSLmiowC/EpmqZDfyWnC7fWvNDmghVT22kEg==
X-Gm-Gg: ASbGncuMHvt8PPXW4aE5Q6PLQiyNtgjCwqZJ9VQMIwMN5LCMAeB7kwKWXzFuG+AsP5/
	jUNq1doqv4YMIz8Teem5LAGYAinqm7uo1CpWjCOgjG6xb5mWAcrNWU/lm03XvmtDK6nZc7n0/r/
	BnvAj+DoncuFU4duOjWLGcp6onCsQZi1aHy+OMuy8FfNsZU571XuHQVoQ6PGku+g+DPSyUKgmBb
	4h7uJoB2CMBoFdaxSxIeogXvEc6kekrLErN5CYaUQzuCp6WFGSlFNffOVd7kLolsszUR55L0KkP
	d0P7XsA3s3RL9OYErLlUpaPJnLHKSWF+sRCCMUhaKrQ6
X-Received: by 2002:a05:6000:188d:b0:391:21e2:ec60 with SMTP id ffacd0b85a97d-39121e2f137mr6709171f8f.13.1741277431828;
        Thu, 06 Mar 2025 08:10:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5FYdKhrDKr9VvnLfqFE2SB8FkjwaLOL6xy8j1ciLMt8nkQQ/xfgfFd014KVDm0o+whtJTTg==
X-Received: by 2002:a05:6000:188d:b0:391:21e2:ec60 with SMTP id ffacd0b85a97d-39121e2f137mr6708970f8f.13.1741277429756;
        Thu, 06 Mar 2025 08:10:29 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd31sm2477950f8f.52.2025.03.06.08.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 08:10:29 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net-next 0/2] vsock/test: check for null-ptr-deref when
 transport changes
Date: Thu, 06 Mar 2025 17:09:31 +0100
Message-Id: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALvIyWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMz3ZLU4pL4suL85Gxd41Rz80TLZPNEIxNTJaCGgqLUtMwKsGHRSnm
 pJbp5qRUlSrG1tQDg1LkFZgAAAA==
X-Change-ID: 20250306-test_vsock-3e77a9c7a245
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

This series introduces a new test that checks for a null pointer 
dereference that may happen when there is a transport change[1]. This 
bug was fixed in [2]

First commit introduces a new utility function that checks whether a 
timeout has expired or not without exiting the test. This is required in 
the test because timeout expiration does not mean that the test failed.

Second commit is the test itself. Note that this test *cannot* fail, it 
hangs if it triggers a kernel oops. The intended use-case is to run it 
and then check if there is any oops in the dmesg.

This test is based on Michal's python reproducer[3].

[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
[3]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (2):
      vsock/test: Add new function to check for timeout
      vsock/test: Add test for null ptr deref when transport changes

 tools/testing/vsock/Makefile     |  1 +
 tools/testing/vsock/timeout.c    |  7 +++-
 tools/testing/vsock/timeout.h    |  3 ++
 tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletion(-)
---
base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
change-id: 20250306-test_vsock-3e77a9c7a245

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


