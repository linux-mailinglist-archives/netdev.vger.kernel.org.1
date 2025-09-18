Return-Path: <netdev+bounces-224367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82426B84316
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4469D1C83A64
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01102F361C;
	Thu, 18 Sep 2025 10:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E926FA60
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192138; cv=none; b=XgC3LXOVy9gToxe/9tHSF6a04WK54M3V/I0OFTAEAj2pr6n+TYSPHzQldPKUrd0hQtRADbhgVEdMtv0QsROoo6vbzto/ulqgtn4JtIwe/aius2puzvSjgfXyyxOxr6r7B62mcM3ENxXxXCLlhz6T/UKN314t1W+CSRR1K+rfeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192138; c=relaxed/simple;
	bh=kmRZY8w5k0zkpK6hrl5VtFf84jTuGxFx4DLf6XrQZNo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BEKGlGa8gvl68876KIOFo0Sw64WkB+sWP+MaX1eujrqN9K4NrI0VqYWmdbl3TXqMRpq8kG5LiiAWz4jfy6E2agR1Ei6yoVET9ODjZ1umWtC5ddyYK6u9tXWHmIN8Q5xgA0pS0D0aI/CFCm17XJKcOHgaVThRNBnObPwv0n+RNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2350899a40so30168466b.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192134; x=1758796934;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxYxoWnyh3CIAHNSBMBX+856QflQb2Xo+2DXZq8kCNM=;
        b=Jy8l/LDmsjskJeIHZpzdgkGR5LOYBW16WQTQ17WFiWTdwDaav0b8LdNCTimHuUOUw5
         xeagAO2hvopzlB36dPygAMQF+wOe0bbw82JcsqPxbPQ1ynTQrF6QJydwxT6zmKDjkPlW
         f5kBDHakCVElNFhgDfvtTkYQoc7qjmxXFNynq6VzYkRoJzs81Pv2xCy4y6Jf/yyEAg4q
         nrhBoZmcYH+S+1q485GKbwSakBhkSc8r4nQG8c5pukg+8uIAijpd+I8s9xSpzhKl+K9Z
         pxtxai5eAqoNmke+NSBpzUhQG8zCJvfP7nvrLX8M5MQA1aQ33ge94RhlR+GLHcZunBKz
         WO6w==
X-Forwarded-Encrypted: i=1; AJvYcCVwriCRNTbs0stwyLZSJhmFxqrvaEimG7ZHFY7mdCLdvmcWbzVMPd8Ivpew0bYlwT3t25ol3Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybVJGg/LGAcSeeVqm9oQDnBj8fDcCAFoTnK5FSZescHDRlzyCg
	4FoGSR1I3lSSr+hGh7oE6Lunh2kGsPJj2MF+VpD66Qx6KRObWa/MTd3D/HrXcQ==
X-Gm-Gg: ASbGncsvDpjKWX+j8j2RhSJaGx3r3D3PdQHcMbavrUt1YovOEfcs9WWXImPtBAgRACR
	ALPxsoW3RXIko6wTQRV8im6tep1BmGe23o+67rNFYvrbTjoCld0xDfU8ItIfoy8kOIGTmt6d2un
	RaJUpvraPXTwU1wCO5x8eiSYJ9k86KpMiIcBABmGawuDdHgqo08zSlFXRK2qrCPaA3mvKqwLtsl
	aZ7neAbj8HCxtTTw/h3oVA6vcb9p3PkNMCWG1111pyyjWs2XKNtE0JPEfvKFAwyygWSrhM/fNXq
	kIDPsYO+QuYjFnS5AEvJiUftf0Eq92RPTtfAGg9oqphICxkJnZ1RA1I8YvxLN6oPZQh26ntX9Vq
	P2qVydpvrRYoJjmrpmzi00hfCQrPb3gW6
X-Google-Smtp-Source: AGHT+IFPlnj0GWz3JtOomOSOaIy/h3xVJRcQvzsL6J7IalJov4TbRyxQPOXC8EJWvJr+zn6eCnYukA==
X-Received: by 2002:a17:907:2d2b:b0:b04:b435:fc6b with SMTP id a640c23a62f3a-b1bc02f6656mr572679066b.60.1758192133735;
        Thu, 18 Sep 2025 03:42:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2816ebcsm167488966b.109.2025.09.18.03.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:42:13 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v5 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Date: Thu, 18 Sep 2025 03:42:04 -0700
Message-Id: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP3hy2gC/33NTWrDMBBA4auIWXvKSLLkn1XvEUqRpVEiKFKQX
 ZMSfPeCVy4xXT/43hNmrolnGMUTKq9pTiXDKEwjwN9cvjKmAKMARcrQQAozL77kuXzx51Lq8l0
 Z++iVjuS8GwZoBNwrx/TY0QtkXuCjEXBL81Lqzz5a5Z7+M1eJEkl7S9aaoefhPfCUXH4r9bp7q
 zoa7amhkNB0neFggtfWvhj6aJhTQyNh3xnfRZ6Clq9GezBkd2q0SEjOTHrqYy89/zG2bfsFI1l
 L8oYBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2394; i=leitao@debian.org;
 h=from:subject:message-id; bh=kmRZY8w5k0zkpK6hrl5VtFf84jTuGxFx4DLf6XrQZNo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy+IEayY0wOB0N6LcgVg/3eZnL0c4YjWUJMcW8
 aPTGC82+PuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMviBAAKCRA1o5Of/Hh3
 bWhHD/4g2xJTXx8UGq9wQva+IfMIUCFKahYqNTlZGbrgrrHqDoyoDJuL5MEuOUZtuc8W6i0TZFQ
 Apm3fPKwpCpKcTJ+BHkdTy35yIZLWzdozLuLMwvu/QfkimJMa7r4FgvZLaj9bUj6gi/Fr1fjZe6
 OlyLtzaus7QfQg56wRJ4k1andr/l2C9cXqHxbp09qMeTPSM+IZ8fmcobzc4wqAffmSsSS/quD+1
 TYyhl0O3Ts57gZxub9BkNzmAklAJnI/YvtTrIbCkySxV5nDbslCQYff8kB6OK4FJyFVI/mQYmmt
 YY5ntWdZpMbIt3HrZid8VCc2L49Z9W7eH7H08t9xD2fwwnkT9K29Aa5pu0cwA+9bKQUfJ/Yy1Vz
 iTEiLVEqiyvbs5LprfO2/m+4pOdjKnbpIcFzPwfepdlPiUnCAQMwiAQ6jZlGNTYD5+4ni82svNv
 +0MGZU8NIo6o3Kt1/Y/rdfRJxuQibP+fLYjzJNNB9JLvTbhhiP/pGOkpdEhwjlx/TBpggCTygFe
 AiVWfMQu9wU3jYV7313QoNZJVmeqd9lDr8JsV6SuH9GVK8sR4qVEB87A95GUK9o3W8H5I3l+n6c
 X3kSs1jU8Ow8tz3evtIuKKtuSdCbWdf7Y5Z5OR9BNBOgEcbdTyEaqar607jCRGhPJy0/jVKGEJ/
 kYx6smXqwTftCMg==
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
 tools/testing/selftests/drivers/net/Makefile       |   2 +
 tools/testing/selftests/drivers/net/config         |   1 +
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 197 ++++++++++++++++++---
 .../selftests/drivers/net/netcons_over_bonding.sh  |  76 ++++++++
 .../selftests/drivers/net/netcons_torture.sh       | 127 +++++++++++++
 6 files changed, 385 insertions(+), 25 deletions(-)
---
base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
change-id: 20250902-netconsole_torture-8fc23f0aca99

Best regards,
--  
Breno Leitao <leitao@debian.org>


