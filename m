Return-Path: <netdev+bounces-37520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F57B5C46
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 57EFD281429
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6568200D9;
	Mon,  2 Oct 2023 20:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BEF1D539;
	Mon,  2 Oct 2023 20:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5905AC433C8;
	Mon,  2 Oct 2023 20:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696280148;
	bh=t4+IE1MpYk7ZH0O/BglLFmWzX8a+Sq8oLP+hPz5YdNk=;
	h=From:Subject:Date:To:Cc:From;
	b=mxtX8eOumjYl2VOI4NHMAoRbtGlcIskbqAwOjEvBcznMJJjAupnWDCMvZfLUsMpvE
	 66YqyaOT1kstxZ3VhWbae8fw8Q8wB+jeDDlM3f8oLZABYzsGsr0c+SAsKxNGJqbZKO
	 K11IBXfI3lE9hE9SZ6TK/G6yytmKFE6xAEiU1HZLIDZU9piFLz/bmUzrin29FLUxhc
	 YY2d7HoDXovsEEQ3/jXbPjoAIGbWRftpNBklJLXtKSoFkLtyEZia1NyYHAKDocYJOI
	 jwJzWzSDa3hTdkLodHWrG86QFD0LJk6lfPAYR+0pPG/RQqWDWX2YvRkqIIkz58fPdJ
	 Ov/oIHgoAIhiA==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] Fix a couple recent instances of
 -Wincompatible-function-pointer-types-strict from ->mode_get()
 implementations
Date: Mon, 02 Oct 2023 13:55:19 -0700
Message-Id: <20231002-net-wifpts-dpll_mode_get-v1-0-a356a16413cf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcuG2UC/x2M7QpAMBRAX0X3t9U+SngVSWN33GLWJpS8u5uf5
 9Q5D2RMhBna4oGEJ2XaA4MqC5gWG2YU5JhBS22UlFoEPMRFPh5ZuLiuw7Y7HGaWuqrRW+O8akb
 gPCb0dP/rrn/fD0kGTvtqAAAA
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, vadfed@fb.com
Cc: arkadiusz.kubalewski@intel.com, jiri@resnulli.us, 
 netdev@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>, richardcochran@gmail.com, 
 jonathan.lemon@gmail.com, saeedm@nvidia.com, leon@kernel.org, 
 linux-rdma@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=nathan@kernel.org;
 h=from:subject:message-id; bh=t4+IE1MpYk7ZH0O/BglLFmWzX8a+Sq8oLP+hPz5YdNk=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKnSekH5UvIHjqx4mvOA6dOdOLne7kxO36lhB/N9/NOem
 NseXfmxo5SFQYyDQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEwkQZvhn3FFw96NGQ+ui3Js
 36JmUXP/t9qyBq2Nmm95nDN/V8yeK8jw32dhdGzHx7lR6lOCmA8bVZ/ZdEX9Y1bX/0gGxoY5JmV
 7GQE=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

This series fixes a couple of instances of
-Wincompatible-function-pointer-types-strict that were introduced by a
recent series that added a new type of ops, struct dpll_device_ops,
along with implementations of the callback ->mode_get() that had a
mismatched mode type.

This warning is not currently enabled for any build but I am planning on
submitting a patch to add it to W=1 to prevent new instances of the
warning from popping up while we try and fix the existing instances in
other drivers.

This series is based on current net-next but if they need to go into
individual maintainer trees, please feel free to take the patches
individually.

Cheers,
Nathan

---
Nathan Chancellor (2):
      ptp: Fix type of mode parameter in ptp_ocp_dpll_mode_get()
      mlx5: Fix type of mode parameter in mlx5_dpll_device_mode_get()

 drivers/net/ethernet/mellanox/mlx5/core/dpll.c | 4 ++--
 drivers/ptp/ptp_ocp.c                          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 35766690d675f63c111afa0a2f5286b74a5b5cc2
change-id: 20231002-net-wifpts-dpll_mode_get-268efa3df19b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


