Return-Path: <netdev+bounces-146006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698149D1A95
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214C22822D4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06F61E5730;
	Mon, 18 Nov 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQBDn/7M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F7178395;
	Mon, 18 Nov 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965239; cv=none; b=dP7i1jq8q5uGFVsCCDjWvB7+Hhui1MeAEvwvIxfV2TAwi3JiVdpLgjKydS+QfSLISqUQQ8qD6/wDVA31jQ9Y3qtW6wmjNd3CXDuChjEHMMfayK18QXn2IBEVPXrnz+/6gwLI83qvThmkfltbpUgLAmmoBsYBwg1cAjIy9NFTvzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965239; c=relaxed/simple;
	bh=zfKorbfLTg80uK/1yhsHbfHfK26iiqFiUQdzeT8KWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arjBUPHs8JZ5K887kTqOYIt3BOUXxSwI7Tcaa/hZYd2TSEzWVX4HN/wJJW3KV+9qHcvpMZbJbjB2qmJbsvjOBsflxRt0qYoM995OAqhcca5G5UPML0aABksImU9Ri/03Hu03IoM/K+SS/mMJGR3gnZ0NnLpVUnrNnYft0dk44bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQBDn/7M; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2110a622d76so1411325ad.3;
        Mon, 18 Nov 2024 13:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731965237; x=1732570037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQcbLRCt/rMQ9iPFPCRullq+Lat4IaQX3afm1lqhHdY=;
        b=LQBDn/7MHHjY9lke5uQpHYA8Lzg+QsibTKd9oq+o4nWPOpHH0A9z9D4OmMKHzbvxVA
         5PcmxtlTrItZuGB83rMqom4Ioq0AxXDgb/p+fXxnZCIF0MPabXS00cc10scu8X3AqsO1
         70hOGkxXi2aEDTbx/ICXfz7HIgPmAxJqMVAGL6Y8AYfUC8RSaFqrvSljEw23JZ/uJhkN
         DwtJRVJgqXU82wfwwGu19xB2gTwi+G9L0l0bc+cwZUV6LCANoSxv+pPb4C37GW51Gk81
         nAzRvxSqMyRNHzSrnugDKl7PvxkvNCxPBH2eoK+oMG+WP4V9zb6VhxT4LnV30qZqfxCI
         Uzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965237; x=1732570037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQcbLRCt/rMQ9iPFPCRullq+Lat4IaQX3afm1lqhHdY=;
        b=mNKKLRFHSTFeBG+kXUM07wVkeP1DQxesyyfSGXq/+XmDX8QASVx53SUDkTJsI5UNt8
         bhGzNBneDlYtxQdzI8dNrxexfRHNUpbFC/40crqgcM+9E1ztWOhEZZxngKMlJqKEi0My
         Ihlm4GrggHZnT9zmE2LAfK2gwBrGS9DKcMjxztuqcBIHXC3us5LThVbw0KpQkDtYQ/PV
         zdZh5fGto91qRVry0a8ShC9E3N1dxtOa2WLlOhRqALA/pmvknKHICUOeFtztheOMSuXB
         3sFOp8Ehmhgm2806HsV1fCbCXQ9NosFDJiQCIwy7oT9vXZNsjhHKdj7PC6eqE7JO8GDY
         QOCg==
X-Forwarded-Encrypted: i=1; AJvYcCXa9JA1bBqumLdaYbIiUp3+UVKjJMAlrPz13ukTH+sHynInMa53TLR07i/GTwRv+x0hnGq/Q276FF/oFC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SshbnVcC8Oh0zaBClLCO4JHLglZkB7rG1L1FgM+yBzNdh23B
	qOb1AxGpuyoWmW9DFtNYO6idNx7d+CMFpBKls6wE41ZJylBSwhbUYM/8tyiW
X-Google-Smtp-Source: AGHT+IGxKw/q5XTChASp9HhI8qW3vZDiGHDXs14SWa3fypk6bIqeNO9a8qqYdQnlrVTjaz+SRvzo3A==
X-Received: by 2002:a17:902:ec84:b0:212:514:b31f with SMTP id d9443c01a7336-2120514b620mr94499495ad.18.1731965237533;
        Mon, 18 Nov 2024 13:27:17 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e4c48490sm50681455ad.38.2024.11.18.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:27:17 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	maxime.chevallier@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 0/6] gianfar cleanups
Date: Mon, 18 Nov 2024 13:27:09 -0800
Message-ID: <20241118212715.10808-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mostly devm adjustments and bugfixes along the way.

This was tested on a WatchGuard T10.

Rosen Penev (6):
  v2: remove request_irq change. Fix NULL pointer deref with ofdev.
  net: gianfar: use devm_alloc_etherdev_mqs
  net: gianfar: use devm for register_netdev
  net: gianfar: assign ofdev to priv struct
  net: gianfar: remove free_gfar_dev
  net: gianfar: alloc queues with devm
  net: gianfar: iomap with devm

 drivers/net/ethernet/freescale/gianfar.c | 93 +++++-------------------
 1 file changed, 19 insertions(+), 74 deletions(-)

-- 
2.47.0


