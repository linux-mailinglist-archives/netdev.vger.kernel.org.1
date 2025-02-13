Return-Path: <netdev+bounces-165723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3932A33407
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD3A167A2D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE65535961;
	Thu, 13 Feb 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbTuRFtk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C62C181
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406900; cv=none; b=d73r927k0a1iffCkCEYGWPYDYnjkRv/+x69TXOK7WJ6QYmry0rKT04Sb+7ioLeicLkWotft3fmbhmzLEMNxh6upyjEK9BJOXCg/AW4MXZO3U6TL0Uls0W3icPhbdNse4egtokMZUMf1aiDUM2C3SFHo6MCw1jvjbNXbnHoMCi04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406900; c=relaxed/simple;
	bh=CxTjlhqydgov5Uroo5F0rS8EjIHuJorlfFH/qcMB9RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAxnVWIu26hiqUWz6ZTeFhcVABm4y5d/EFCQ5DfmJ283aA1Ph/6OI9ec6Wi1YJG4m3rhPAMGrQayA/Xj6v7AAIQACR4wD4nYIqC+KgzngaQqS9CQd49cXe65WJKDfwoKnP6arsgJuh7H9t83K+gK6DiWtv5LtMB+faIeCZRGyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbTuRFtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCB9C4CEDF;
	Thu, 13 Feb 2025 00:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739406900;
	bh=CxTjlhqydgov5Uroo5F0rS8EjIHuJorlfFH/qcMB9RM=;
	h=From:To:Cc:Subject:Date:From;
	b=GbTuRFtkcTKNiZQfmGVzNivu/FCdI/FIkayJOijzbIRdgWtJnfoRXk53h+mAIsfUH
	 D4YzMMQql5ATy/tVo1i7EMThRFcZdZ40ZlmejHxSTXS1mpm5+gi0dmcrsax3RHHMP8
	 5R1Lu8lARBHI24Jw8xeuzfr4KrlBOOtS1cWOPIDvgbenCQGyrIDAvgfNYosKAt+u91
	 K+kHblmZbA9pdQ2n2ytNOeW0zyehtaa+tYkfuE59J6ZHD7x9cyYPpEsWphaKzImcDo
	 NmEtuY4UlLWIlPJPBmJ+gnRuweQe/yi3KbvvBumrIFPUNO7E4JuAE6aCCQV9UntXkZ
	 zaysIDy+MsrMQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] selftests: drv-net: add a simple TSO test
Date: Wed, 12 Feb 2025 16:34:51 -0800
Message-ID: <20250213003454.1333711-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test for exercising TSO over tunnels.

Jakub Kicinski (3):
  selftests: drv-net: resolve remote interface name
  selftests: drv-net: get detailed interface info
  selftests: drv-net: add a simple TSO test

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/tso.py | 226 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |  17 +-
 3 files changed, 242 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/tso.py

-- 
2.48.1


