Return-Path: <netdev+bounces-202569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E42AEE4BA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F196117B88D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070D428F514;
	Mon, 30 Jun 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApYPHPZz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184842857F8
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301196; cv=none; b=HSrZP9rzLgS1zrXRUYM6VS45pbeKrnQGEnewZnki3B0xdEb3VRANzkPJW4UMTtLQaA81tovgBK2WGtgG4cF1fQ55bPAMv37KuLqAT9iy2PQpMtoA/i5bTqW115gMPkz4rlve69IxMC3/FdX9yu4m4tD6Ezld9d668RnCniby/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301196; c=relaxed/simple;
	bh=TlBBWhjw66vU0WVncgBo0ciJaAdFdenxkE0NF7pgGLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P5XYsJCXtfLDtNc3EQ9xe2STP1x401xm8lZwXdvNwy6f4QmaUQejA4dBu5/pf/k8kyPdfMMdvQvCtbXApMoyd65ywtzTNMOHTxUpQ9FyoMLP++6z6cFKuoV7+u/NVQNLjLIShfN9MPbolyFu60fRXDWd1E0ArXuaY2/HKqRCjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ApYPHPZz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751301193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PCXz84xtjif+9AQOmzcJZnqlDzRDa6bAl/lnTU35pOE=;
	b=ApYPHPZze4CWGUk2cNGvw32uP8Rk7MhR8tH9Y8Bkd5cCP3ml1/GRgReKWd72jUqqi/Li55
	rnKbMobahY/3hs5PMyITgkoDGAGnfOaueYnouGau9BDAhbBIuYUExmJHO3KacmGTVVG4sF
	E+8l+cy9fRRSlP/+pJlcxjSrTKhbmto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-NVZQR-UDMg2fS9DHGwPmtw-1; Mon, 30 Jun 2025 12:33:12 -0400
X-MC-Unique: NVZQR-UDMg2fS9DHGwPmtw-1
X-Mimecast-MFC-AGG-ID: NVZQR-UDMg2fS9DHGwPmtw_1751301191
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450de98b28eso26312765e9.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301191; x=1751905991;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCXz84xtjif+9AQOmzcJZnqlDzRDa6bAl/lnTU35pOE=;
        b=MXuVEnHMb5s+56XP6wNB+Yli4R0xjYt2FQXLb/rcxD/8vQV8IfBdIH5L7YLmzpBG/L
         AJHCOhgyrosfs/mO++0LpvDq98BpeBmzBIiVz9yWmM/IcmDj3NbdIMAumfY4XME4kgtl
         G91IJKL2Fqxm6chja/sApH27mbMTJOlC3PvgrVSZQrvOxPXoLQoIDtbwmfbpQ0D0xQ+K
         zdLdolIXtWhP4kNht3bzm4XDP0/ZrpJcmmC4H+piquaD0/JDNgdlN/KdlTuFeBE/WWpt
         9jC4FssVSgd6Hw4a0VP/FUz2EsAqbk2BhE+5p0pOi2id3bO7lO9B6MnTlBpE13w8KnkM
         ntZg==
X-Forwarded-Encrypted: i=1; AJvYcCUXswk1oQNco9tIE9rlxJkkPZzss5YdNRgP+Clj5Yhr+NKN2RYMcnfkszKZfohx60tsoNI4dIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5axcezSu7msEeOfGUnFO52PSXAXep23b8iS0F9REMnfKRtYiW
	XJsDIYim7QyG4mDwyubIwsxJZZGH8+YOZ1U6zlQ4sqQtFMG9C09KlLAIvytYWm2NAD1Pfrbe7gV
	Op280du22YK7ecYMAGtiCsWayVv1IiiJaY9t+CWWhZQdUEJxLXogrt8XTPc7F9FSs+Yz6ZUHf3I
	EpHw7VQWdMglVrbczlbPj8G1yuuQ2dCM/uKQy7xctEvTd7
X-Gm-Gg: ASbGncsYuqQfLwtk1O1z/NiDfskVFWOLoIcvbPBQD7yxHDjdenAcGqXIkypoOJXxS/W
	MuMaLupQ/d/q1cDX4lQftWgv4ziXkofJpBASW6kEJZAZBbODbOyf+LyTNS9F3IIiaxb5i8mp9TP
	WrJu81+QFCjMMQkVabPH+Mr+DltbGzz06Z/xTDkfR0u7PJUe6TbzRixGh3eA9LNmmyJMf/T8zLo
	wcXldO1RldAONsUHcQgS24R8+Zcp9LWTsmIb0RgIfRSXX36qRbo71OhlWxUAN3R4iLaNmbfgPhy
	kEpNRH3gAP3kd7Y/nIEya60d5S4RLVNzN32KGPjec9tEUiMbPUHFmg==
X-Received: by 2002:a05:600c:548a:b0:442:f904:1305 with SMTP id 5b1f17b1804b1-453a7912cabmr2232295e9.6.1751301190620;
        Mon, 30 Jun 2025 09:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSfXHhHLnv7HHQ+5LMg0eJpi2fcwuM4hIgZV34bWufMI5k6opX1s+0mXAanNIxjpTh6gD5WQ==
X-Received: by 2002:a05:600c:548a:b0:442:f904:1305 with SMTP id 5b1f17b1804b1-453a7912cabmr2231815e9.6.1751301190105;
        Mon, 30 Jun 2025 09:33:10 -0700 (PDT)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a406ab6sm142554375e9.30.2025.06.30.09.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:33:09 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net-next v5 0/2] vsock/test: check for null-ptr-deref when
 transport changes
Date: Mon, 30 Jun 2025 18:33:02 +0200
Message-Id: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD68YmgC/23NwWrEIBQF0F8ZXNeiT42mq/5HGcrr86WR0qSoy
 AxD/r2STSdMl5fLufcmCufERbycbiJzSyWtSw/u6SRoxuWTZYo9C1DglFGDrFzqeysrfUnD3uN
 IHsE60cFP5ild9rE3sXCVC1+qOPdmTqWu+bq/NL33/w02LZVUBtSHQ6JphNfMccb6TOv3vtPgz
 mp7sCC1NKRQx+ADDvHBmj87aH2wpttgtUWINk7D46+9s3D8td2q4GmkwODwaLdt+wVA6J2CYwE
 AAA==
X-Change-ID: 20250306-test_vsock-3e77a9c7a245
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luigi Leonardi <leonardi@redhat.com>, 
 Hyunwoo Kim <v4bel@theori.io>
X-Mailer: b4 0.14.2

This series introduces a new test that checks for a null pointer 
dereference that may happen when there is a transport change[1]. This 
bug was fixed in [2].

Note that this test *cannot* fail, it hangs if it triggers a kernel
oops. The intended use-case is to run it and then check if there is any 
oops in the dmesg.

This test is based on Hyunwoo Kim's[3] and Michal's python 
reproducers[4].

[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
[3]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/#t
[4]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v5:
- Addressed Stefano's comments:
    - Use a macro for G2H transport detection
    - Improved commits and comments text
    - Rebased on latest net-next
- Link to v4: 
https://lore.kernel.org/r/20250624-test_vsock-v4-1-087c9c8e25a2@redhat.com

Changes in v4:
- Addressed Stefano's comments:
    - Minor style changes
    - Use `get_transports()` to print a warning when a G2H transport is 
    loaded
    - Removed check on second connect: Because the first connect is 
    interrupted, the socket is in an unspecified state (see man connect) 
    . This can cause strange and unexpected behaviors (connect returning 
    success on a non-existing CID).

- Link to v3: 
https://lore.kernel.org/r/20250611-test_vsock-v3-1-8414a2d4df62@redhat.com

Sorry, this took waaay longer than expected.

Changes in v3:
Addressed Stefano's and Michal's comments:
    - Added the splat text to the commit commessage.
    - Introduced commit hash that fixes the bug.
    - Not using perror anymore on pthread_* functions.
    - Listener is just created once.

- Link to v2:
https://lore.kernel.org/r/20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com

Changes in v2:
- Addressed Stefano's comments:
    - Timeout is now using current_nsec()
    - Check for return values
    - Style issues
- Added Hyunwoo Kim to Suggested-by
- Link to v1: 
https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com

---
Luigi Leonardi (2):
      vsock/test: Add macros to identify transports
      vsock/test: Add test for null ptr deref when transport changes

 tools/testing/vsock/Makefile     |   1 +
 tools/testing/vsock/util.h       |   4 +
 tools/testing/vsock/vsock_test.c | 170 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
---
base-commit: 647496422ba9d2784fb8e15b3fda7fe801b1f2ff
change-id: 20250306-test_vsock-3e77a9c7a245

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


