Return-Path: <netdev+bounces-127262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFAE974C87
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BC81F27444
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697014A097;
	Wed, 11 Sep 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gGS5jHFR"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161FE3FB1B;
	Wed, 11 Sep 2024 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043038; cv=none; b=fO4s06KqVaDhPKLr9EwbdGxSKY9ebF3v20PxfOggLt58TdNZ5xwH6ZdTGK2L6QbcH912KtDqDQ5p/nZozd1G3W7qDzD93jn4tFOFEkCCUBSJU9FPyQItzhN2zBLR1Pu2FlLBlhUVCN11S+HE5zOJNaumsU1vnKpqt3j2ejT/Wpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043038; c=relaxed/simple;
	bh=FX1zoym/pjQIdYCm8aeNVCsWYaCKVoq/b3xPwgHB/sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9rcsCVRIameEM4h7WGXnoIS9TE7LKokN+3yF9/4H61ZsCb1Kq4TtqEqIEabDUk+U7uQLxVizePnuHp1m9gjp+4K0VU+L/dGm4BG6S5lgwCXuG4o54o4jWxBB2d1EIH8rts9PoznljOBe+WbTEEgdE7zsbgikVEpKZAxbYHzmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gGS5jHFR; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ru2TcSPWA0BcVbo4Hl8RA4ZrfGCzwt+n3CO/nf4Xh9U=;
	b=gGS5jHFRvmm8xnqfdJzb0c3obKo9VBfg/QF0b9GcbQKrEC/OvwZSbunk9WtAvq
	ClD73AVoBQT7UkJMhyXrTvVWyA73KQys1WkzdP6PLjHhqTbv1iW2MhluAAIvM7+I
	gI04zcCqrvQwnGysC7hDM8ChThRM5f6HRXQFDizNFFnoY=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDXz2WBU+FmS6F2FQ--.13162S2;
	Wed, 11 Sep 2024 16:23:30 +0800 (CST)
Date: Wed, 11 Sep 2024 16:23:29 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Eric Dumazet <edumazet@google.com>
Cc: xiyou.wangcong@gmail.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
Message-ID: <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
References: <20240911050435.53156-1-qianqiang.liu@163.com>
 <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
X-CM-TRANSID:_____wDXz2WBU+FmS6F2FQ--.13162S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-oGQUUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQJXamXAo163vwAAsq

> I do not think it matters, because the copy is performed later, with
> all the needed checks.

No, there is no checks at all.

-- 
Best,
Qianqiang Liu


