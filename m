Return-Path: <netdev+bounces-224011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C48B7EA83
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3D41895F40
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F84B328983;
	Wed, 17 Sep 2025 12:52:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2229B76F
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113537; cv=none; b=CnW+1FCocylqRuq19pyDQAZ3SX9i5PXeinrJcRvJsfl+BsMKDgmycKK4TMTz0fcA5IbBMiVwn3jsNGgwTVWkh9Ru4upTatpXN15uI0n39Z4j82cE76/aSdDB0ZnNbczFYQvb6oiIIJYUq1P+Rv7yA5/CAfl0NmA0KP/HF6230pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113537; c=relaxed/simple;
	bh=z0CqdaKtG3FXMT+SGr/8fspurJp6wIxXOOHn9NBLkew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KOZ4n4u8uZ9kHJO4/+Z4mMKUSPS6iyHnnpSx71O2gt9Gr21QcsiSEnRscqUvy8wVquQ1iwmkNunkIoz2AiM3nYLVzR8e/XPWbM4T6BpRDIA/vtyq5O7g5yxuFyxQFZu8DT1tmaiPDy8y3Mea2FVDLLoSPou0LLn11GssbkrMsVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07dac96d1eso136515966b.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 05:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113533; x=1758718333;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Fwe6Jox9lvYBGadLqyIGGqu9khZAUVhT2PK4Qt0Hm8=;
        b=lwL++kCuMuzKJQH1Hglz8hX5D4wfqir0THLAcFD3VLpkiL+q2pKdOnkiwhHTEKk14c
         rTDWZ4AsuRIKgQaj2SjZwG4F+xLC3v5HrKwv89GzDInoDMb3QHFXE83AV2iiDZq+agLV
         M8TeKnAvQEkirLhu0XhVKyEpUptexHFdug464ahXWtPTeEsoqA+AjtdbOfKUOjkCKxfD
         1a44HQ08xdoje+upwcJ0sQmr5C1dte25UBm3iDkM61i2tbnjVnJ0v31bX4tdHq4noTNP
         BS3FAVMeWUUmwevXE/biyuO66E27PCXMWh0rkYg2vPoJibtgTwoa5xAUNAOTZ3B6DlDS
         mZKA==
X-Forwarded-Encrypted: i=1; AJvYcCU1UhNgJT5+xmWKKhQA9tQehTmTCA6caA/NBDEgl2ClDAmgocHAnbhWu29zy05+25bRaPRuePU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwISSk9jDlqRxhFxIlDQeoMWrJVuynCbJrfImYsKOz8t4Cap0H2
	HMLuq/xalFKlW9Ft2hLC5FtKn9+johfJ7ANIl+blBN5CG3ejBc7Ml5bm
X-Gm-Gg: ASbGncvG6jiogMYQEgQe/0dNho64Ey96BVHi3/cclgQVM0Xg4qCB1kDhouryvMg+7O7
	R+VgJ8PnxUlcA8BZPKQWanC8tP6Etm69bdNLs9G1SPXrqbMZy3C4A1ZrMstW1h4F8bChKqbJfhf
	TlEQAM2ifo4Zdww6Mkom79gKz+SWj5arbKCHXjx++dQ6/Xogufn1yzqoBVMImRJLpmGrinS/rQI
	1atj73MBWiSc94BaXee7LCJVJKtikfMGFWLZ3ZMORkY/FXo2rkS3PMA+so+PJ0Jm2vzsZh5J1LG
	2kOHSXK3TbZlOeRtIfHoMDmUJNlrmRJ+sVib+NKVJMZtV2O5eEZkvkrLWhQE14pzwbUqbB+KLEV
	602rdi/MBlAOlmseMcujXEdS7
X-Google-Smtp-Source: AGHT+IEapc8hSIjb349hAjbQsB4lVpp+5A+aiu4G8+6KZFoS/VpkK60FcM7fDOTphXJBAbk8gn9SUg==
X-Received: by 2002:a17:907:d78a:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-b1bedda96f0mr250991266b.30.1758113533179;
        Wed, 17 Sep 2025 05:52:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b19a4c2d3cfsm210880766b.26.2025.09.17.05.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:52:12 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v4 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Wed, 17 Sep 2025 05:51:41 -0700
Message-Id: <20250917-netconsole_torture-v4-0-0a5b3b8f81ce@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN2uymgC/33N0QrCIBSA4VeRc70TTtPNXfUeEbHpWQmhoTaKs
 XcPdlU0uv7h+2fIlDxl6NgMiSaffQzQsX3FwF77cCH0DjoGggvFDRcYqNgYcrzRucRUHomwHa2
 QI+9tbwxUDO6JRv9c0SMEKnCqGFx9LjG91tFUr+mfOdVYI5dWc62VackcHA2+D7uYLqs3iU9jv
 2kI5KiaRpFTzkqtfwz5aahNQyLHtlG2GWlwsv42lmV5A2ng6BRCAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=leitao@debian.org;
 h=from:subject:message-id; bh=z0CqdaKtG3FXMT+SGr/8fspurJp6wIxXOOHn9NBLkew=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyq77SqEFfQYQIeE0oilLdana10QcJmXq1NYfh
 0NII2YzuHGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqu+wAKCRA1o5Of/Hh3
 bTiXD/99+CjULWfW0x5zaGcailnXvJJh/yLySYqlL+wAw/wRoxS0kGxDVpTJjxwcJpQjyyO47fI
 tikEHJ8t6RewkSEHO4UCDvZM5+ex6aCY8zzi1Gg2hjP/pUX+cD4djQAiEFLKkB7bJKpJpiqTtwv
 oSsUQTC9D1F2fWZ8zwnPVEXw4v6w3H2+CHfQCv1kqYkzm7rT3Xyxrjs7DuKEKbnk8r4zBCsUu28
 HfmJQMfDrvUhaC3fvZKCznwvE/0Vg8RqMEXCrYHxib08YVm1LZRGN0cLhW2E1YJLxxiZJQAMiqs
 2XMXGTs0/AbUqLvViHtBNWoIcW5PXMH3gpzQbJLaSIc8vdKZCdxOOzKZS8eYnF8Sy7HF90QECcv
 LJ2tuQGPREaU7FRKOUeTlveuJv/+7fZtJw4ACW9CbS4fUim2y5M4bjN221I1/rI4Z8e+VPwRAha
 ou20Y29IymiHjqBM2MrxKcNafaVjL8d9cZnU7c0EBUAaMfp0OJedlZpRsyD6sywjKjsPy0cRLFh
 Tn7A1VEls/sqj6GKwhhgjJsb/+uytRprX6fU9MRg3hM7ZZCoDtPvgCfkzHc4p3W/4Ecn1Sy2I9O
 qa5nhL9CuxeLakwRKjaB67gF+UH4F0tfIQPxWIvM3GNeevYfYjSZ/tnXHnzRr/CFsY0hRa5+Px0
 vOPvPH/y11fEKYA==
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
 tools/testing/selftests/drivers/net/Makefile       |   2 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 197 ++++++++++++++++++---
 .../selftests/drivers/net/netcons_over_bonding.sh  |  76 ++++++++
 .../selftests/drivers/net/netcons_torture.sh       | 127 +++++++++++++
 5 files changed, 384 insertions(+), 25 deletions(-)
---
base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


