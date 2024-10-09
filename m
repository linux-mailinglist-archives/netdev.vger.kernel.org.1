Return-Path: <netdev+bounces-133661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31FF9969EE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1F828632F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEA919340C;
	Wed,  9 Oct 2024 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EdeBS8s5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808BC193070
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476760; cv=none; b=Ci4v1NYwUmyfjf/XpmvWxDEuoSh1WU5uA7HNWKCEvbTm+artbQf9rBNbYmea+0roIDfA8KGk7kqHz/MfjJQmXCgydYi98EaYxTPlt3Vrjm6PZ1+kaEgEy8sDV+Bjin2BoSi+eZf6d1xzxMfTKZbw2HZsNs00NDdQk9CabqybewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476760; c=relaxed/simple;
	bh=H6fHTFaFuo/IKi3yp8p2tJ2vfDBR9b5BRCIsOP83MCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0HeW+BiIjdy8N/T3/3zQtx3jQPAr6cax995cvBy8ilT+cAG2G274Ut2hoYpaSFthQd5hUsfmQZAUJlCtagcDul6glPOb/+y6qwy0+hbE8AuqO0hucDbdtKF58i+slTLc6gaTVy5m/rQ1i4PyIAxoMl7Lwb0G3QzVQPz5kYij8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EdeBS8s5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d462c91a9so74692f8f.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728476757; x=1729081557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vaH6nZNMi9VVLcQcuTc/gpCg+1rwEhJkqw3BiWNXAKI=;
        b=EdeBS8s54mbvzjMuOrHlNhmDOIkDKgzIiyfIJVf/knjn5eYYKgTg8cSnvS1NNr3xzk
         0Os9dKTbydEtAyWS5dp9H9V1w50zQ7GFOxjQFq3OQh+YXixdHVPPlLGYOm6N3F3uP6ea
         9qu9/7mmN7hACrWeRudirsvQYLo+bfVHgWDd5vzvvB6M+Gep46dKw4Zw94+AkD9jSE+e
         MCqo/rYGDO9Z39qny9JtmxNr2jg2G50E87LNsVGq8JChb71l3jrAIz/9NanZ5B2m2J/S
         bC8/1nUYAEB5PiwwIFNDFqTPgOCg2eAq3dr2At5T7vdvIonQCFm/Gzk0SSgXRjTInEE0
         dtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476757; x=1729081557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaH6nZNMi9VVLcQcuTc/gpCg+1rwEhJkqw3BiWNXAKI=;
        b=vUNGHva518Pbfy73Tu1FJQ1r6Sivd3b/2LeO6USFDq7KeSdaLgNaC8wpMxv7AS40x4
         dijoq/nrKdXevbLaF/+TwBCU6LWuMyo2YW0YBcz3aV0nX7T6B8U0jXWXsulFXSwgAhX6
         OMDmCsi6hT7iwfnFQJq+k1txj+/wWJDx5EMYzGNfMw5GB7FFYzGixQCCAPG7Ssn80W3z
         6afrAk/xUJGDj6NC2rRh33UvW+GbViv1rzvoN2jqB+gp2SGulj2dl9ExU5XWJ2gVZ8gK
         cY1Tx5ADaVZ0YX8x88imKq79mmU/8JPfuiu6LAOdtsUO3a+QCD6PqJIC4QJZzbPru/Re
         deJQ==
X-Gm-Message-State: AOJu0YwtUqPm9Xlt3Fdozk2TAdVQSF8zvdgSmBuEzpPrBvlmOdCxr3NF
	tOf0nt3HO3OQaVEtbQFxPi4r4b9rfqbEQzaAw7aQ9TAUhmdKhJ3tQ/m0ibZGDHDiepyXoKz5Jt4
	KBM4=
X-Google-Smtp-Source: AGHT+IFQ98OgWykDm6jGQ8HG3GIkgdmgXlgNB2ymDGUTxDMHDLeboBXN1l9AH9o/5hGMFe8jCZMA+g==
X-Received: by 2002:adf:8b9b:0:b0:37c:ddab:a626 with SMTP id ffacd0b85a97d-37d3aa40a8cmr1516466f8f.7.1728476756485;
        Wed, 09 Oct 2024 05:25:56 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f767sm10280786f8f.20.2024.10.09.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:25:54 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com
Subject: [PATCH net-next 0/2] dpll: expose clock quality level
Date: Wed,  9 Oct 2024 14:25:45 +0200
Message-ID: <20241009122547.296829-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Some device driver might know the quality of the clock it is running.
In order to expose the information to the user, introduce new netlink
attribute and dpll device op. Implement the op in mlx5 driver.

Example:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --dump device-get
[{'clock-id': 540663412652420550,
  'clock-quality-level': 'eeec',      <<<<<<<<<<<<<<<<<<<<<<<<<<
  'id': 0,
  'lock-status': 'unlocked',
  'lock-status-error': 'none',
  'mode': 'manual',
  'mode-supported': ['manual'],
  'module-name': 'mlx5_dpll',
  'type': 'eec'}]

Jiri Pirko (2):
  dpll: add clock quality level attribute and op
  net/mlx5: DPLL, Add clock quality level op implementation

 Documentation/netlink/specs/dpll.yaml         | 28 +++++++
 drivers/dpll/dpll_netlink.c                   | 22 +++++
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 82 +++++++++++++++++++
 include/linux/dpll.h                          |  4 +
 include/uapi/linux/dpll.h                     | 21 +++++
 5 files changed, 157 insertions(+)

-- 
2.46.1


