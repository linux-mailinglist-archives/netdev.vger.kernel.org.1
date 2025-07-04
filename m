Return-Path: <netdev+bounces-203973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE6AF86F0
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FE51C43FF9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2C1EF375;
	Fri,  4 Jul 2025 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gryt6deV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA4F1E990E
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604909; cv=none; b=H56noCtDLLQVwt4WUG8DpTv14ZyWIQCp5VICImBRmquw+48C923zEfNXlx01Lmoeur/LIe5/9qIdyCbFb24u4mO1Ou1yU47P/mqpSW8GSGbEjH6MOJQcKbfqDlg/qZub5vKfkDk3YSLCVBVRrRT/ckt1+mMuZxez8YjJDIoLElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604909; c=relaxed/simple;
	bh=FNjkNS5Hrz1bMAOT84skeF9UP/hQKndPdeq2uR8AlxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JN1iI1PGtD5eEMjoNTuPloDHVea1s+MeTkgBhZqylBb/LKc7L/FqX9Bx9m0T14Xf+QowGXdn3iE+NiqXnfmTuo9mYAmZwTwELx0byFAIEQiuwYdmJYQa55v7fT7aeLYqGkcRG2zjArswakZldDnDNJoBKmQq1AssUHp3Ryf+QjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gryt6deV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E90C4CEE3;
	Fri,  4 Jul 2025 04:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751604908;
	bh=FNjkNS5Hrz1bMAOT84skeF9UP/hQKndPdeq2uR8AlxM=;
	h=From:To:Cc:Subject:Date:From;
	b=Gryt6deVftVaFWdv/Lamxlox1JWDJnI123p7L5u/5/MEDKzQjkAYpGYIgthteEd4b
	 1o2zDUuHWgpFN8hZuXR4DXc5jbjqHvdi1shtVDBXNpGOQ+mOs7qroPJdj5By6XWk0U
	 ffNxJQiUjqxe4T7arK2LnL1FkMp9e0JUa/miVNWojFrnFBnQ9kKMrrDm7wCDwnsORg
	 1hlzUlauX5p9qf45vECypm5Jiw1u/yqC6YWSmm23i8xMVkg5Rm34/P0aAWhCRLmdXJ
	 USv5qoTWlq4dbXU37rcyfDEaDrR84D9aPzsBktHS40VkLZWE027VPTbLuioeCfDr6t
	 q7l7MunxygV8g==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 V2 0/9] devlink params nested multi-attribute values
Date: Thu,  3 Jul 2025 21:54:18 -0700
Message-ID: <20250704045427.1558605-1-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v1->v2:
  - Rebased on latest devlink kernel API.
  - Use var attributes enum instead of dynamic attributes enum.

This patch series reworks devlink parameters and introduces support for nested
multi attributes values. It also adds support for showing and setting port
parameters with multi-attribute value data.

example:
     $ devlink dev param show pci/... name multi-value-param
        name multi-value-param type driver-specific
        values:
          cmode permanent value: 0,1,2,3,4,5,6,7

     $ devlink dev param set pci/... name multi-value-param \
            value 4,5,6,7,0,1,2,3 cmode permanent

Please look out for the downstream kernel patches that will be posted
immediately after this series.

Title: "[PATCH net-next V4 00/13] devlink, mlx5: Add new parameters for link management and SRIOV/eSwitch configurations"

Thanks,
Saeed


Jiri Pirko (1):
  devlink: use var attributes enum

Saeed Mahameed (8):
  devlink: param show: handle multi-attribute values
  devlink: param set: reuse cmd_dev_param_set_cb for port params set
  devlink: rename param_ctx to dl_param
  devlink: helper function to read user param input into dl_param
  devlink: helper function to compare dl_params
  devlink: helper function to put param value mnl attributes from
    dl_params
  devlink: helper function to parse param vlaue attributes into dl_param
  devlink: params set: add support for nested attributes values

 devlink/devlink.c            | 689 ++++++++++++++++++++---------------
 include/uapi/linux/devlink.h |   1 +
 2 files changed, 405 insertions(+), 285 deletions(-)

-- 
2.50.0


