Return-Path: <netdev+bounces-118215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BE950F89
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 00:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378A51C21DC7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 22:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589D1AAE10;
	Tue, 13 Aug 2024 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W57qoIUL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EF26AFB;
	Tue, 13 Aug 2024 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587243; cv=none; b=t1GkALh0aPsD++y6bEVBLbZz47AvjJLAu8eNyWSHSESoKM4fDZAK6/1H/Cja/53kei3DSDBOkPMW2TZMwjOPjHoXL/5LQMy03Z1SzWQBbyAEVs6cXsLgMlfYq3udunOKlHkOC+sOq4RznN9BNgNTeHWIEF9QY1dSnCHPomETWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587243; c=relaxed/simple;
	bh=Wfd+NoNOY6S54NJAiFTLX6WnTIUN38Ya2ZXlRx3OWLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TVZEcwBVBOKF4hEJe/Zkl/UFx+x9+VbyYwkxzGHkb+UsWWEGWVvoVEl+FEHOpS/l1lKJZ2MJAmTQf19DmWHp4y5QGaarxHBYTdSTnPBIHa23TduzVYMoqqL/zPxOAUaW7AoARbxFCtl3c6op3k+aeOLGKxNBxbQKV7C/28zm+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W57qoIUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57750C32782;
	Tue, 13 Aug 2024 22:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723587242;
	bh=Wfd+NoNOY6S54NJAiFTLX6WnTIUN38Ya2ZXlRx3OWLI=;
	h=Date:From:To:Cc:Subject:From;
	b=W57qoIULUCOmIUSExooMbDOEMTNXyHuNg9jIk6Nf5haURqo+p4bzGaGHskg0nJgHT
	 6PfELsT0KrR3qFKCdEc8zAkSpg6IUG3tAyRvVzt69I905K7ujFfey41N3E7cqFDnhv
	 oxlM+wilbEAV3IQn8xg4ypDUT0/XP+dxBUryXpd63RhkG83zpnVnW2IUIekbDcbk6M
	 NzTtQL/HICG2aZkQDTAguWFQ4OtQm3shLrCZoxV0cRWLWorfRoCNd+pLZDMn9rfMLb
	 KBri4WoeqRGeNLN3ssp5FdmkzoQ2ZlH02M06J89mcqKU2Pnhx+JmDlE8932TisIzbk
	 /411jOcmBQuPA==
Date: Tue, 13 Aug 2024 16:13:58 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] UAPI: net/sched - cxgb4: Fix
 -Wflex-array-member-not-at-end warning
Message-ID: <cover.1723586870.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Small patch series aimed at fixing a -Wflex-array-member-not-at-end
warning by creating a new tagged struct within a flexible structure.
We then use this new struct type to fix a problematic middle-flex-array
declaration in a composite struct.

Gustavo A. R. Silva (2):
  UAPI: net/sched: Use __struct_group() in flex struct tc_u32_sel
  cxgb4: Avoid -Wflex-array-member-not-at-end warning

 .../chelsio/cxgb4/cxgb4_tc_u32_parse.h        |  2 +-
 include/uapi/linux/pkt_cls.h                  | 23 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.34.1


