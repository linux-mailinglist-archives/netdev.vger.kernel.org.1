Return-Path: <netdev+bounces-151118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92909ECDDA
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A03616733E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F89A23694A;
	Wed, 11 Dec 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVaSzB3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702E236942;
	Wed, 11 Dec 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925621; cv=none; b=CRhhPl/NrXCMLJCUwignE9UeRKJVzlrlu5GFA43lHFIRJi0+2MWfnReitgflKSQudZSnDgLeO9E9IEB1EuWDPV9xGdIkz7rNnhH5U/W0+vxuQCVyksdepsfx9w7patdhdr2gOurnB35cMcyG/AmgV9ycv28wEfck3apgCjkl3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925621; c=relaxed/simple;
	bh=nIlzAcfl9O6eXzIAlla0bKYL1nk3/WO3361TA6pxwh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/6zR9bip0t9qP1xN0I0XadE0yNQxhjpv6+dyDFjyhh0Fzn1K3ODuB2VxBdB4Z+3jgIB0ATsmgOyTnSGjhKXB9b7GjOnPsSlbg5z9TftyriKWG2XkKh74odFbwgMJfP3s+Q+23exP1K31+qU4flzOuHr7Wl6rrhmUV5oofcwTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVaSzB3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB11C4CED7;
	Wed, 11 Dec 2024 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733925620;
	bh=nIlzAcfl9O6eXzIAlla0bKYL1nk3/WO3361TA6pxwh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iVaSzB3DeyJn/Hhm3UR/vVi85MAoBHQShaTEkGDH2fWlLYw1Esxiqg85/uIoXgqDW
	 uENolEfgmR/rX/v0KsyYc1iAYCGTy2xiB848uFqcKznKXwhdqgZaSFPgB3y5icN6c4
	 gDjwVHt7MrDBLEMKVRDGmIfcFD+Y5O54iM1bTk8VLuXo49z63owHLzsWciGPzB71zx
	 B9ATjVFXO7UbPaQqoTtctNBdA+PWPLnKv+4g8rKWATd/ZWdxfzrvuzd6HtWAQt4Qng
	 34JHWftD6lSoW4gs9L/jzrddCmnXLcUvDhUUiCZ9oIi0CEx2cKFiVkmA7z4sM6oPh/
	 FMruKcoRyLYxA==
Date: Wed, 11 Dec 2024 06:00:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <gregkh@linuxfoundation.org>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hkelam@marvell.com>
Subject: Re: [PATCH V6 net-next 1/7] net: hibmcge: Add debugfs supported in
 this module
Message-ID: <20241211060018.14f56635@kernel.org>
In-Reply-To: <20241210134855.2864577-2-shaojijie@huawei.com>
References: <20241210134855.2864577-1-shaojijie@huawei.com>
	<20241210134855.2864577-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 21:48:49 +0800 Jijie Shao wrote:
> +		debugfs_create_devm_seqfile(dev, hbg_dbg_infos[i].name,
> +					    root, hbg_dbg_infos[i].read);

Like I said last time, if you devm_ the entire folder you don't have to
devm_ each individual file. debugfs_remove_recursive() removes all files
under specified directory.

