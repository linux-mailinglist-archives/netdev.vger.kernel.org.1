Return-Path: <netdev+bounces-152797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFA9F5CE6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60FA1892C6F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 02:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4F3594D;
	Wed, 18 Dec 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bguxtehq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936915695;
	Wed, 18 Dec 2024 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489142; cv=none; b=g5p2kK0rjgzJFFqlMzPwYG1kCy8i+DgQEQtmvO1nLpROsscN/sGiink/CjUZUb7bqAtOg/LO6ShH3tLaCAZkNJYQUF6qzRm5EotMdFU2DAJkn553sy8zRvGP7I8FmWmP6Q2Tz+OCpWpPKEco8qNawP1RuhxxE4izGQYyC5jiMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489142; c=relaxed/simple;
	bh=mi6OX5/5XV7YpUmNND/cHCqDPIuMkirhCKEh+GcVF1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlAwBlRCLy8Yxv7jBoltTOAygL2Zz+jc2Bk4mOEevyC40AN/GagtxBmd/jayG8BsBbwIDZRsllJ9EVNnKMyShFKa0HYwmrOPYu+Bw6IoAXSAibUSkPMmlVnTMMaV7eY+ZvezP8J85/qhN+aOqeXO7/BkiCoPqPgI/3/8R52rSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bguxtehq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725e71a11f7so222570b3a.1;
        Tue, 17 Dec 2024 18:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734489141; x=1735093941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi6OX5/5XV7YpUmNND/cHCqDPIuMkirhCKEh+GcVF1I=;
        b=bguxtehqL3DxHF75SqQOsPejliRHghzzZ7wQhgbggDCRtaPNl0YBctGWC+hJQWROPF
         c5zyv4fZmgLNObeQV3WthXgYpli5BoN0iGe8Hu3Lj9T7KTHHLPeC7bJp6fS1cQeEwm1r
         GOUQlk3HVTrm0P+6M09GH9wC/3WK80C0Fty0MD+xn0sY6EzPTnjYvwjRqeQDdphGq72/
         W+G3iqZ78TjFu/tVkta3aIoy03Wh2AvjJMDqO2GZ6x3sVzVCcDLKJtDXh25sN3BeRit4
         fw4C0zTWkc6RWM1JJcnepLsHb1V5+VaegsZ6a9VYdi+qovmym0j1QcGTdR+XkOmJDEDD
         qjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734489141; x=1735093941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi6OX5/5XV7YpUmNND/cHCqDPIuMkirhCKEh+GcVF1I=;
        b=DhWn2uPlpTnsWxwvmcsDbvyWUzjXjlWwnH5MNM6SnVrQ7hnYSbFz0G0Mxn/1wOC1sS
         yZCBe7V2Ipi/5K3i5n03+TktQgsETS2HnbwBdp2PWeqdh+duNOfhAxZjHrA7jn3cjZ++
         F0gaW2IiS2SNh3p6wwvBx0NrrGjxBNimn5nrQhJ6GrY6CKyGnu6LAQv3HssE3hogxYWn
         XZ9nFm5wOKUgQqdUvIvJqTtHWmqvy3dWZq/7bD0j8KBp5stPON7ZMLbl5VBjwyHxoLnd
         qxdeICNAcqBQjLwKdGXdOr2BjSRqYHD1B3jLCUcxFvxuk5KM3oaidQnYn7vWMmhAewCA
         F0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVuG5AXKbbB5wieXv2tRSqNICvX84BBLG2/ZNf5cjHRyoD/jsCr/6aPCIKWkcWfu08Jf1ehaPSwdWkQz6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlKWdK4zqZSGmr8iQdjnz/A19yujkTxV7X4szjxOGNaHaD+ms8
	hWIqORg1pdYoRpmC2HIbUSUN42QqL3gATr5zhLi20LeLYk11nunp
X-Gm-Gg: ASbGncuqOzoR+E4+p7Pj/oVdxZbMDHhC4cGexX1BQSQN0ZBM0+VwjKNvs9hSzygOaw0
	fRfNMFSg7W/CBWguHY3yVkr6TnuDyvjaclERcB1KxY3ZxUod/mxpp93nuO4EtQPLPjp2s/DW9XK
	Qm16uFrIIWL92NBNN/0EgAvO3y+Fos0qV6bRfXcaXbiEBtxz2hNbIMjDfWiSTdS7bdxyiAzyEld
	rqTStBdZJLiSTbtodlcNBN+HOjErB2W+o3awnxU6Mel/owN06IiCg==
X-Google-Smtp-Source: AGHT+IGOi/F5l1GM4Se3SaVQy/qnJilh4hLpQ88FZFsSLJ+TwRZhiHnC+Sn+xH74+w/kACljDGykiA==
X-Received: by 2002:a05:6a20:3948:b0:1e1:b1b4:59b0 with SMTP id adf61e73a8af0-1e4e7993bb5mr7315774637.18.1734489140791;
        Tue, 17 Dec 2024 18:32:20 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c38011sm6345778a12.74.2024.12.17.18.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 18:32:20 -0800 (PST)
Date: Wed, 18 Dec 2024 10:32:10 +0800
From: Furong Xu <0x1207@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net v1] net: stmmac: Drop useless code related to
 ethtool rx-copybreak
Message-ID: <20241218103210.00000dc4@gmail.com>
In-Reply-To: <20241217163538.GU780307@kernel.org>
References: <20241217091712.383911-1-0x1207@gmail.com>
	<20241217163538.GU780307@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 16:35:38 +0000, Simon Horman <horms@kernel.org> wrote:

> Based on your description this feels more like an enhancement
> for net-next, without a Fixes tag, than a fix for net.

Thanks, I will send to net-next.

pw-bot: changes-requested

