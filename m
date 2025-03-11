Return-Path: <netdev+bounces-173918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E9CA5C384
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3180A3B28E6
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB87F25D205;
	Tue, 11 Mar 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="m99I97CQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9025BACF;
	Tue, 11 Mar 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702420; cv=none; b=M3WqcNnvxbS1bSFae8rX723UU+nZQSquv8tv1dZVnxF7k+Lg158IsQNq1gMYoufOIrD5UdhsuTVB3k4XN49nlOqjX8OqusHW6EG5jK+kuHkcznxL+VEMPz2/i3c3s9puLNLpWgCrLh8tp57lllpHuUMVNcewBei7G78CWwjxm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702420; c=relaxed/simple;
	bh=eenrShXhfPIycrSr6eNRep7S19xwLWHdK0YFVj7ZRF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u6OWSQc5OR6L4q0Ww4SzNRB/Kk13DvwR8XnOaWsZDKWSzJkk3cLjDol/ZpbFxZOEaQWdbZnwcftd/1JW+b9Kn41csvtJ8MFzBiVOtoAieeL3TJuqsPyDnkMcwnhZ3dRCZsEUyQPVyq5DQffT5bXOw53EMc+LI2jNuaZ2Hk+r5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=m99I97CQ; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741702248;
	bh=sEsZLpdCMahCUi5IK5l4rziDa0+gWtRAY+XlQEkoR3g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=m99I97CQNckwMeMk84JdJLCAwYuWf8fztv6kATSAPHYN9uamLiUYfp5GFs7gMztwg
	 EVS9LTmJuyrrH3tGt/4qAsH8nf3TLXfoe3NN2B1UrgTcdwYtN4mvSnMjWGjqNLN0Ok
	 ddLpwXa5NQ7acYVMMJoUXopaOHgw/b5W6RvEMTSE=
X-QQ-mid: bizesmtpip2t1741702235tz686eo
X-QQ-Originating-IP: 4vdOKIQ/CIsDlNMxzhhyEtJ8F7RmOxQVnVgkfPQnFeA=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 22:10:33 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7323364665953301856
From: WangYuli <wangyuli@uniontech.com>
To: idosch@nvidia.com,
	petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	czj2441@163.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	chenlinxuan@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH net 0/2] mlxsw: spectrum_acl_bloom_filter: Fix compilation warning on s390x
Date: Tue, 11 Mar 2025 22:10:25 +0800
Message-ID: <484364B641C901CD+20250311141025.1624528-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MfVCm2vBFdjBLRnCTcOVQ9ujpk5OwPKYYwvcX/+ZvWAs1FNRPtFq8+Rp
	rkqI3RgbvzcPo71gKNx01sFfM2j8ar1M1zA/5Vhhh463rjiXVVGiY5JGpuHnrJjkJTVXVj/
	oK+gvHSKmPtpDFS8XfaDzMpyWpbzehGJlMTWLq+2Ap4frkhfWig+mtct/vAqCEdaduB6oZB
	hQsJtiw9+IVFYYvOcKWV4g563BQwUr1rgeP8AQ4G4D+Zi8g67dI+/3BQilOfuWTXB4/g3fH
	XqnBkEVmx6wH8zBXO5fDy6Yt30iL/4RvREfOR5vhIrVfQRdoX7P6cuDZLDZxNvx605Zkfus
	5TKJMWRiwtq6rDvxeS/reM2kDJKWZp8aE4AOazoWARposDphnZwWd7SBdgP5Bwh5FvuVC6G
	7/P71SZ3R2S5JBhT2vINggziaxGYQMhg60fWg+KjkiSO9CJE0QKAokoO23m/FG9f9nLy7wJ
	7t57gTayPNVn7t/ZGmu3J7cAtyqzEh9J3UykB6wftJpAWHhi6AUiNxEyVk1g61sE/IyWits
	1aFI6veBmu9vRWq3+4rlxqr9i2LNX9JvDOR+cWkTtKgBLeDp1VjXlcBkS63kNG5PipyHJIu
	SEyO6dWEd62hzwsirB8btpvt9aCoD0EA9vQ4coatt5XuMNEANzZB01Ls61hMdC15/xYdaRw
	I5cP0G4HOw13qLAXpNUtDX+Qes5jPiHAZo1nxEZcV5fDG8Q5sHkPhj+MoLnR6tijFkgoyhL
	ae/0lmZU+lhYG9tio47yxNP11+uAuoWL46OaH1D2xwZBKOu3gvw/u9ZsIKRL4JR0U5M/+pY
	tlz6Xi/y5W4LA3TfwBaQrX44za0wsoCqC6Vq4vtGj0xrATsJGntKQbuLxav3UEKuMDUhaMK
	uFYyRnpNqRMed/LH4xAfWyd9avg+xTOn/SnFvPdJD/ywHUkqIQrCmUYODA8zRxfwcMfRaM+
	WZ/moTf3saARuqlAiCEF9tNeWUGluBh6gKIj4KjEjzPPSD9RUiIeWdBMafb1mmY0nwFvNWD
	y0IW7LiJRlR2UEmt2eACRycncLiC4+0bTEEAi0ryF0gzgM4yZI
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Solely when using clang to compile the mlxsw driver for the s390
architecture does this rather perplexing __write_overflow_field warning
manifest.

The seemingly underlying cause points to a possible anomaly within the
LLVM toolchain targeting this architecture.

Nevertheless, the kernel, being a software endeavor predicated on
robustness, should not normally countenance build failures stemming from
toolchain and compilation setups that are implicitly project-approved.

Implementing the workaround, as elucidated in PATCH 1/2, remediates the
issue.

WangYuli (2):
  mlxsw: spectrum_acl_bloom_filter: Expand
    chunk_key_offsets[chunk_index]
  mlxsw: spectrum_acl_bloom_filter: Type block_count to u32

 .../mlxsw/spectrum_acl_bloom_filter.c         | 42 ++++++++++++-------
 1 file changed, 27 insertions(+), 15 deletions(-)

-- 
2.47.2


