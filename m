Return-Path: <netdev+bounces-136178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDD9A0D00
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD3B285D6
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD0920C492;
	Wed, 16 Oct 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6VnULHa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974820C00D
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089713; cv=none; b=ExkhbigEoDE18Ra/8tcfnYwHvIzF5ct23FdzAj67sKJHzNHrsOcfDuDND+O51SWCNmEshQiFTappXsTsn3o4mS/IsTnmKCjOoFc+B2qPHtGyZ7kqXgJeI6YImsS/Y4S1TlhiPXwpotFnfvQfR4LPAT0GEvjfedXLHdy4Xbbyvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089713; c=relaxed/simple;
	bh=Xm89ZQTxOiruJJc2c626as0TSbAz4qE0b9K3bd8RCaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o1fM74H7JZxaAsWa2rgdKEDNhdHpX9xKoItGXZ6zT08tMzVlpzicO5Fycqld00Kjg7wjbTTaMD8b5L3p66am7lByOXhovbTFyg1uugRoYUtTblgv4x2PShDjOgXlyBRoCpBvOWwnXgIA/1aa/bzYP+M/sAomnlZpBPHpAzTmnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o6VnULHa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so4343328e87.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729089709; x=1729694509; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZJgMAiThnKM9DCESXpeGrJ3grxtNNbWoomMwPV4xGU=;
        b=o6VnULHanMtG7+dCzRcGgocskm9o/gmsp+galBAsKkrCr5Gy1gY9wqefvB6+/wIyX3
         7cJ8alqUKZW0TxWhDdzqee+HklgqkawQ8IysYinTiWnrvgYpdKiBXLAN9ounWmTdO/28
         dEBvFrZ2C3OWisam3IQuA3ojln+9G/oUU6xFS+f/8Khts32Lu2AVayP9GG3VzE93m058
         j3H0hJfT0zG5G3iX9tN3qWEPCq3NuidhRHkbCgociedQgil+JFA5s7sWWFaxDQQh6MSv
         bZVJScVhmQz/pQ39jekVzabRjeG2gZA8fmLkTFVCW70rhx1dBgBUTeciIli14J5WfOFS
         cEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729089709; x=1729694509;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZJgMAiThnKM9DCESXpeGrJ3grxtNNbWoomMwPV4xGU=;
        b=VjWGlo8Bkrj04CBBCAJZsAyvn5cQYQ7p1oRp+mMduJT6AFBObvGENyqevBCcWHAVMz
         Vj0mvmFEK2xGjjWHH1rvnFHp+wTQs16rQx4CjLekKrWPblF01wOB4YfvFkaZiJtCwT7E
         KwPr+PvdooEnSi5o0G7W5s3dF7lGtBl7cjSfQolvTmDc0e3I/qhKB3dby2UYbzmHyYsB
         GzqGXL+6CMnIxCN8gXZ5XqAmuGRB2WxwQiiB9KZ3mDGGHDh0V6JRXzEDcjwdhIXUsjKE
         vhdkvxpt0SYWE+IGAqN5KvxOco2LRELTnVIBVB2pmKs6U/h37uxG0zUhVYBALL+yhBAy
         B/HA==
X-Forwarded-Encrypted: i=1; AJvYcCUv6/EIKUFtLsOCBnaBeNu1/FfuGPC2KCLQu4/vsComhI1BCG1KQhcsGia9sqf6QFZ/eFTMAW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+SPX0eGtKq5wJ1efKelPtm81X50haIoS9lB4hWmEL0wFQr2Vf
	iuK1HJCTAeXD7K+mWvyVMWHGUfRicABY6WTzurfq5sDNMfZdbwEDyefochpXNk8=
X-Google-Smtp-Source: AGHT+IEO8z3y3HtXlHNDMzb5tA37caZtOPrnQTurgO1vgyFjMMIuObM//raNXXBa8cL3Rrh3e6nZ6Q==
X-Received: by 2002:a05:6512:e85:b0:539:ec29:1cc3 with SMTP id 2adb3069b0e04-53a03f2da18mr2766237e87.30.1729089708648;
        Wed, 16 Oct 2024 07:41:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2987c700sm190328866b.189.2024.10.16.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:41:48 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:41:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roger Quadros <rogerq@kernel.org>,
	Julien Panis <jpanis@baylibre.com>,
	Chintan Vankar <c-vankar@ti.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: ti: am65-cpsw: Fix uninitialized
 variable
Message-ID: <b168d5c7-704b-4452-84f9-1c1762b1f4ce@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The *ndev pointer needs to be set or it leads to an uninitialized variable
bug in the caller.

Fixes: 4a7b2ba94a59 ("net: ethernet: ti: am65-cpsw: Use tstats instead of open coded version")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 1 +
 1 files changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index cda7ddfe6845..fe1f2fa0ff9c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1341,6 +1341,7 @@ am65_cpsw_nuss_tx_compl_packet_xdp(struct am65_cpsw_common *common,
 
 	port = am65_common_get_port(common, port_id);
 	dev_sw_netstats_tx_add(port->ndev, 1, xdpf->len);
+	*ndev = port->ndev;
 
 	return xdpf;
 }

