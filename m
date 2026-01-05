Return-Path: <netdev+bounces-247085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DB2CF4617
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40C853008709
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C93090CA;
	Mon,  5 Jan 2026 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="C5cbtpCW"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2005f-snip4-4.eps.apple.com [57.103.89.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9B2C11EE
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626300; cv=none; b=bAHGhAV62k4p2WrHbtlo7Oqa+Sl7A+UTSGZQyQWfn7kU6vvyry7ODyNqCsea6FC+vb/3Qrkc/YibWZAOjv+i6K4dVSWeW5FId2fvAq7lD9QVVDEkPtubwI1cMAldWX3rvv8Cuh/EZCjfWAptjQRlYIoN+9PhnETlwx997eFWN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626300; c=relaxed/simple;
	bh=JzCs0jWEW0pYuqnBSWeriA+ITaAzlDRpPmhZSgq2b78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hfk95Pz0kfm89UPknMSSzCtMSN0D8CJxj+SjaeSCm4LrdPyMnHBkSJrsZ9zvml2/946NmIWpx+QdxpSXUzTDRL1B5pGJd6x/J4UG3SwoJazymhQcMC1Dr7fyd/+pW3qwjxQeOEx63MP1hoSyEL35Gvdskr47+S6lbaLmwn/lULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=C5cbtpCW reason="key not found in DNS"; arc=none smtp.client-ip=57.103.89.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id 170E41801A75;
	Mon,  5 Jan 2026 15:18:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=QpShK1c4dkolRjMh25jTYh5j2iiE9cxcjk95MxZSesI=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=C5cbtpCWPre+qC53yMvbqkVlrs2x9pD9+CQwzTMrDkf9wB/g3eklyCX7X1ZCplx148kxjB0JvL+lm8aUxZAI9M3AHkZmBaj4BPYaT0SsDqDiczdAhDRjumKk39fpygD466uBLstlsnW9L2hX4+sYfwj/1bBXjxMOyO/WU3AIMBQu0j/BQakMTbBT/dvaOKYbkVV+kyRwxx+ULDrE5kx11HqeUEjOKsthAZ8+pMcwqSzp/uKQeLHKaxOw9y51FN9D0qs9vfSk0TA9vt0lGuB1vOVzuN/Etflz1frjxxmmeV7JaJCFL5FWrPY8cTefeVhbViXFsrNCAS4uUceVUs58Vw==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id 7E2241802807;
	Mon,  5 Jan 2026 15:18:13 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 0/2] net: netdevsim: fix inconsistent carrier state after link/unlink
Date: Tue,  6 Jan 2026 00:17:31 +0900
Message-ID: <cover.1767624906.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzNCBTYWx0ZWRfX70xciToO+b1f
 QD84lGjRkGbgxmswZ2MinH5QVygy852XtEVvGpye7G6xownPbiG9RaoAlhsCbKv8dq4XPdio1zU
 3OyjTsga1WYD4Z76kZdtdtX4ytJekRnscWRKqxHHP9Dmydf9XONsBBdoWh9MAjwAm3eKTjuDLGk
 Lt/YhgcCUr/9g3ozgmEzBmBXAPqnQLL0TEjnvdYfk129D/Kmoo6U5Rsx6GggI6bKNaUK4PXzRcO
 6s0Iy6GcYcg/3o19pdl2how2ON9lfzS69QQelylHeaiQMU/VUHPgx9ZNLVOkobkoGm+kX5r0O84
 qhmARgMn2ZHAQni4Cil
X-Proofpoint-GUID: zuNL9t4IOEnhb_p7BcvfWE-LDT6r9eQj
X-Authority-Info: v=2.4 cv=ELwLElZC c=1 sm=1 tr=0 ts=695bd639 cx=c_apl:c_pps
 a=2G65uMN5HjSv0sBfM2Yj2w==:117 a=2G65uMN5HjSv0sBfM2Yj2w==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jnl5ZKOAAAAA:8
 a=Kqt5MdZNGhIV_AAfnTgA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: zuNL9t4IOEnhb_p7BcvfWE-LDT6r9eQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=784 adultscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601050134
X-JNJ: AAAAAAABk/uHvJ8pxrURK0vhQwrcCHH7lPMmEI6rEtv0aTvE4urmfH581lobVfUWsm2kG07SzMRv4qNOpSZYkdUTzcL8pYH8TULkPk+nnOUA9GzMZWiQmlNLCwbcGnCUR+w3BKh2sWgpK6afp7OoaBJcRRgHOCR6G33Yjpj1qjFxFN8NT/XD0u4Ow69tVzgMUFZuI/ZHg9fAV7eCXJW903xQ7T1i6DsS5/2aTH0fK4AeTXjH8/lLq5FR3X8mMGTisy2MFLPMFnXFAkeW2+FI6rf4P79aLvpkJnHZDiPctiQda0yU8XyVcPXGmLUmw/FKH4792qu8PhmSWLVfMxB3r3IXWV2rPNl/qdfzq0+FITMrIeczGDVLO7IFWxFcHckdJ42HYKZI0mqF0xU2GIILNewhtVDtHUPfJqf82dufjoKntSVOS76o9ACVc+zD9hba2F/1fqORNRKXYCJ/AdWhM8+CQUJKlLWf0Vr4MN6AzF6SaY38HsL4oj96LZb63ov0TchI+Y+2PasiZBJWIpx85LFnNV9C2I6te1IlxAPBs7LYRD47W5NJDvTFBXCwStQCkUNfjmOXt3gTq2Ugu9CFUNZOtCl8JrwVyHObmgN5ymTIHtdUeYcQGKW3tQO2cAw0pmEh26UkQBfuFLtCTFfvAAeOQTRvEqD1FCQTeAhiqn1VwJGFlLpEpODhNKgm0V5UDLqxZ05X2tvqs/UELmipNdRRK9afEkyOFc8fc5OzA2fffd4dEs0B3RynrDon6MRlvk/+FDkZMiPHFbk8Ig==

This series fixes netdevsim's inconsistent behavior between carrier
and link/unlink state.

More specifically, this fixes a bug that the carrier goes DOWN although
two netdevsim were peered, depending on the order of peering and ifup.
Especially in a NetworkManager-enabled environment, netdevsim test fails
because of this.

The first patch fixes the bug itself in netdevsim/bus.c by adding
netif_carrier_on() into a proper function. The second patch adds a
regression test for this bug.

Changelog
=========
v2 -> v3:
- Rebase to the latest net/main
- patch 1:
  - Add Reviewed-by tag from Breno Leitao
  - Address the review comments from Jakub Kicinski regarding the condition
    to call netif_carrier_on()
- patch 2:
  - Solve the shellcheck warning in the test
    - Line too long error is left as is for consistency with other test
      cases
- v2: https://lore.kernel.org/netdev/cover.1767108538.git.yk@y-koj.net/

v1 -> v2:
- Rebase to the latest net/main
- Separate TFO tests from this series
- Separate netdevsim test improvement from this series
- v1: https://lore.kernel.org/netdev/cover.1767032397.git.yk@y-koj.net/

Yohei Kojima (2):
  net: netdevsim: fix inconsistent carrier state after link/unlink
  selftests: netdevsim: add carrier state consistency test

 drivers/net/netdevsim/bus.c                   |  8 +++
 .../selftests/drivers/net/netdevsim/peer.sh   | 59 +++++++++++++++++++
 2 files changed, 67 insertions(+)

-- 
2.51.2


