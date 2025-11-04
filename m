Return-Path: <netdev+bounces-235556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7CC32619
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F380188FC8B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E224DCE2;
	Tue,  4 Nov 2025 17:37:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C0B33B96B
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277838; cv=none; b=ldZW4HTZ6YUh27FF8Am4ZttfrkZf1ZqidHFpAqjtNoucMbDsERo5QAJub3xZ1ppEFgoDTHHPCjoPUkeSqHyWXzzQUgoTl8SFViPg5G6MOO5CTd9V1AG4dapkUwORw6rctZOjHXF4DJLrmMKeuBb7LziECembQY5wYMNo84+/Vus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277838; c=relaxed/simple;
	bh=UlY1KhZtrDOuDHrLgI0Oei5J42LFvFBO4Qi6hX0Z3x8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WUwaJIu79/mvVoofBiJ1/m18FerslIVR6prseEejhjOs4DwJwy9v6visj4qiN54sxkV4DqPHT8lRtcEkExZ01Xr/CGvmwn5GOVhlrpUM1YYJSN2XayTcvNFoZ69TVFYsGfrpmNruSlPCZ3MzmGPJpo5sVGQipNXofSALMhEpCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640f627d01dso1134585a12.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277833; x=1762882633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6eTNxxLcNy7wO3MDtB0SYsnP0RhlnRRYoZuaanYAto=;
        b=ugN/lT6QK4U6zeWHtQyrX0GrxSEyb031usrx+a/kuOx4fGl9Fi7ShAp2QZhz0mh8ml
         nD5J42syNXLzFSt85sQDnHYa22xeaa9gLVs2PQyOiKtFdgAwAyXkSNSaaikwBhyaY1+h
         BL76uuiuB0ixRHDDETgjjdqUcRsAi23iDv5fnm+Sh3rwR6d1FSZzr+2VIgbyf4NIQEp0
         YuidL2DR0WhiFowJXGY4cwh86biasb3dqgm7Fi+vGGqgOWPncKamS0XbXTfowtpJ2kuA
         Z2y/vQBb8IhiVaZPuMRkv756JS0FqvvZL40jvbLiSZRXA+buhvN2GLcliwTotnCEL665
         HLug==
X-Forwarded-Encrypted: i=1; AJvYcCWOlPZfktuI7zfLEyhsX7cN9hsb3rTH+sIYptP7vKkITpyr4Z3SgUcJr7fbn58mUn1HdP/+phw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3bPS8V5NPmuraAW47XW2hWNPydIs8GGsVQljmF8lmLihbQVgX
	NDDEpzqyoh4zJhexOAbIOtfNexsd+LvNmEMWx94qyzHxRNU/IBmLN1k/
X-Gm-Gg: ASbGncux4L00X3lGTs2sza9AsevR7TJgMZj8bxnhgsyK6AMzZSEq/x4+gb3JU7seQO5
	E0X1xXruryem5jXp9oZjOrtlE+3usb8b/ebhzvp+vBsaKapUO1KLibrorLVmImwfrhASPtTKc+D
	wKxa1163FVHgGGBLwT7tBU7z+Y4MRY16rpxOZoQpm9nHQTmSEQlFozmkA/1vDhEu4X1Qo7xGf0a
	VYZjmk+hCZhednlAe84i1XeEDxsxoeDmkkasEhPw9KNld+VFeGRpciutu1devaS5SI0PDfD+Kuv
	H3+vyqJb4vlVAIEK1bsNrh1D46BzJM3mksKmRPRAWZoN2mE5GnU9ik0QUVSVODDbJGx0CptL3Jw
	hB4cDh7rEYAHltAxK9vMwQFpwGb1JF/Kn9VVp9RVMgAOM/UmkJJvow4rqhcKxk04f7xY=
X-Google-Smtp-Source: AGHT+IHWSXVh6r30EyaybF/0e+aAYqu1Y9TDDbQ35hp7jqzz7Df4/+jTMzfaV7yDvOLad/iZEhrkXQ==
X-Received: by 2002:a17:906:c110:b0:b72:52c2:b8e0 with SMTP id a640c23a62f3a-b7252c2bab8mr319087766b.37.1762277832949;
        Tue, 04 Nov 2025 09:37:12 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4c::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fb05a02sm263381666b.58.2025.11.04.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:37:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v8 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Tue, 04 Nov 2025 09:37:00 -0800
Message-Id: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALw5CmkC/33RzUrFMBAF4FcpWd+RSdL8deV7iEiSTu4NSCJpL
 cql7y52IZVW1wPfOZy5s4lapokN3Z01WvKUa2FDZy8dizdfrgR5ZEPHBAqFDgUUmmMtU32ll7m
 2+b0R2BSFTOijd45dOvbWKOWPDX1ihWb2fOnYLU9zbZ9b0MK303/mwoEDyqhRa+UsuceRQvblo
 bbr5i1ib/SnhgAEZYyiUY1Ran0w5N5Qp4YEBGtUNInCKPnR6HcGN6dGDwjoVZDBJssjHQy1N+y
 poQDBGBKK0PcUjj30j8Hxj0319x69DEmJpEN/NMzekKeGAQTvnUgxkhb+91/Wdf0C7LI7ZFICA
 AA=
X-Change-ID: 20250902-netconsole_torture-8fc23f0aca99
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3161; i=leitao@debian.org;
 h=from:subject:message-id; bh=UlY1KhZtrDOuDHrLgI0Oei5J42LFvFBO4Qi6hX0Z3x8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpCjnHohoqvWbz8kYRzn7u0s4LvlcnsfvBLouic
 OGTvhTZzn6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQo5xwAKCRA1o5Of/Hh3
 bTpJD/sHUcthl6rQSEzswJz0c/Tug+XnrZg0tQVOD+ixxkKTb0iopJqsqmkPnjYc39A6GUPDmTV
 j8DAAlxS4ZIWQho7FCZ/A60mp53x6EQRJnDUv61QVaLB+z3xlbBoCzKzA/FCKxaJesfW99rUJoH
 LgyUAej8ylj5IAbg+Wo0fQQ4GP+qcxBUQb7hPnlwzeurilGb+SKt13c40dq1Dd1zcFQrpSDUBYP
 1OhTlSY8hpoWP5JNPxjTvp1qP5A9hCxcOn5QL0/9OnTJqqelisk9QHg4Ppi6c3JIg6m++2Ak/wu
 umCvolphBYxVv4PkSvtMpwxAFH54ppFbFkM1U5p3MoVa3Ik7D1HtyGhqblRGfqWAmbq+NBPB0Mt
 x8usOipwky+54NO5CIGtl14BWHZu//k5Uf9K5bRrQe+jT+/kTSZfJPLYau2fiW2LmG3VRSoapSK
 hYSjoVU/wJfV9Y1S82WX3c58hOw4NxES7fYmPylnebtpLJjBmZRK4bCk3hy1OUk87pO/8t2zEfT
 /BkTVMOuHxJN4M3ToZ4txs8oSIEMyruc/hojdWRJPVtIC6XJv2dOKP/q7Aizda1pBYjGck1CunK
 Lm8xMvUxfjBIx6J9kIC0FS6c6ON2vCHqZjzpGgLJe2VlaGp2x2n/PhGgX9rtPZZgt0EFAXvPIPY
 BA/c6KkGYIvfh2A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Fix a memory leak in netpoll and introduce netconsole selftests that
expose the issue when running with kmemleak detection enabled.

This patchset includes a selftest for netpoll with multiple concurrent
users (netconsole + bonding), which simulates the scenario from test[1]
that originally demonstrated the issue allegedly fixed by commit
efa95b01da18 ("netpoll: fix use after free") - a commit that is now
being reverted.

Sending this to "net" branch because this is a fix, and the selftest
might help with the backports validation.

Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [1]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v8:
- Sending it again, now that commit 1a8fed52f7be1 ("netdevsim: set the
  carrier when the device goes up") has landed in net
- Created one namespace for TX and one for RX (Paolo)
- Used additional helpers to create and delete netdevsim (Paolo)
- Link to v7: https://lore.kernel.org/r/20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org

Changes in v7:
- Rebased on top of `net`
- Link to v6: https://lore.kernel.org/r/20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org

Changes in v6:
- Expand the tests even more and some small fixups
- Moved the test to bonding selftests
- Link to v5: https://lore.kernel.org/r/20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org

Changes in v5:
- Set CONFIG_BONDING=m in selftests/drivers/net/config.
- Link to v4: https://lore.kernel.org/r/20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org

Changes in v4:
- Added an additional selftest to test multiple netpoll users in
  parallel
- Link to v3: https://lore.kernel.org/r/20250905-netconsole_torture-v3-0-875c7febd316@debian.org

Changes in v3:
- This patchset is a merge of the fix and the selftest together as
  recommended by Jakub.

Changes in v2:
- Reuse the netconsole creation from lib_netcons.sh. Thus, refactoring
  the create_dynamic_target() (Jakub)
- Move the "wait" to after all the messages has been sent.
- Link to v1: https://lore.kernel.org/r/20250902-netconsole_torture-v1-1-03c6066598e9@debian.org

---
Breno Leitao (4):
      net: netpoll: fix incorrect refcount handling causing incorrect cleanup
      selftest: netcons: refactor target creation
      selftest: netcons: create a torture test
      selftest: netcons: add test for netconsole over bonded interfaces

 net/core/netpoll.c                                 |   7 +-
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/bonding/Makefile |   2 +
 tools/testing/selftests/drivers/net/bonding/config |   4 +
 .../drivers/net/bonding/netcons_over_bonding.sh    | 361 +++++++++++++++++++++
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |  82 ++++-
 .../selftests/drivers/net/netcons_torture.sh       | 130 ++++++++
 7 files changed, 569 insertions(+), 18 deletions(-)
---
base-commit: e120f46768d98151ece8756ebd688b0e43dc8b29
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


