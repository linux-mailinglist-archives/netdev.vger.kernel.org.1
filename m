Return-Path: <netdev+bounces-173619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E44CA5A30F
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102AC18956FB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7A2376F9;
	Mon, 10 Mar 2025 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SVIfOR7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BB23643A
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631629; cv=none; b=O5Lguep0kR4c5A6R5JOAc7e1CW+wFcEFXAax+hofzler9z/T62xHWW/mCoNMXkxyRWtXd+/uiF1zkZtZsc8K6jFXmRSxah2MBKFiengn0/qL4Wp56uqLcBq9pY9IfyaE733RKGtmxVaJRKyjZ+jb6dxaoGwnNHddoFWU9nLh4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631629; c=relaxed/simple;
	bh=ZMpmMdzTvIZxoLPt0Mfn2Iwdh3Kdo00xZ724RYOMbOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioJijreU47ON3MIZZu20+7ijOaUBguPFWCbBGoRVqpxJSEq4ONT3uYVj5nViZ1Rc4I0eDjxEOjXE6swbmsdD8MAGj8cTep+L3xrroV8EhmiSOzY3U2Vh0yB+0dh7yW3wZn9BLd0UmZhmmE7QfppBEIwo2E7xO3YTRVXKij/awtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SVIfOR7O; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-601b6146b9cso444321eaf.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741631626; x=1742236426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stJnvPvDnDsHfZyihNbJ3SW7DryMBU68xuUWo/zHEig=;
        b=SVIfOR7OvBy6uzvi2lu6mX0N7hLNWRG+sRNfI434S9j1vRE5CmEnjAv2ntyB+CjE4Z
         6J0OJo9OpXQmRlMteTZ/JLEnAPYmVbJwDYzKMRm1/xzMNpJqf6ax9EQ5xduq+htm4zs9
         HEJNh+K7xdjyqChXPGv6nXE7IbMZEtoLDFwgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741631626; x=1742236426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stJnvPvDnDsHfZyihNbJ3SW7DryMBU68xuUWo/zHEig=;
        b=iiBUXHXgeb/yOWDQ87jdHW7+/D8Au0v1OURqLqQyPrFWLm2rJEcCQgqSUaM20IkMU3
         yNj7NGXZ8YPmSJbOTsLP7Vw91CI5XqXS7VL2f8UGoCgTL/qZk07p81serbvKTMlDKfwf
         YQ13ro/0bOLpLM88xmO33jUcJynysJCC7QsoNk0NyQimo4CXU5cqbytkJMJO8lQNL185
         Q34VQxQGeOlKjjey+ra0IfJfRt5Yc826o5yJyfoAT3bMbhnNsWZLdWDz5f6EYWf0imwD
         49e6w+aqLAy/8TWvwt75xDXR+DsfiC9rH7f+H+FVOHjI7YHezf/8todAviqTY+zVLwOA
         nqrQ==
X-Gm-Message-State: AOJu0YwqHORVMWtlh8D4rgzF2Qv1Sa1m2eEUmpLDalueeJGusTGSfz/M
	tNH87SfIyWjllVi1PrLGXIqcgdWBxdooi9Ik4YdS+n0LjcLddVgd+6d85WH4UA==
X-Gm-Gg: ASbGncs+moclJo59CdJnvOA36vpv8TOsLaAuRj1XDAzelDb3DBjR582o17NgNmn9zhu
	GBYi70RtbrNOqSB3nS7dChNCY4yOhw9HWj/WmQ5jyNauNyr8+nMLwpqqg9HbObJ0Pn5Ct1cWL2t
	phXzLIItbzUKuiEI6xtHD125xhoJddBtybHFqtIlk1deAoyOOst/E7sGbF9/zYHUPc8Fr2CUEAN
	ymZGU5XBo8Jq/MukwZ+uB75e4luDFe5acEkPTmraKBJfi9TuMou2TH6fM4arDoOkU/AKlDKqFJ6
	QBT15QDlOJ44zJ/ZcGieA0gjnqCP9MaUVFRSTUE+LsSINw04J2wPMfGRYng6B/Vlwlic85+etNf
	ETeNLPSqrhrND00i+CbeK
X-Google-Smtp-Source: AGHT+IG6Ak9tvivq4m0sgJU9YnvW49SiiS7LlAMfMtZZ55bRloN3HKEh3FUJYIBddpCuCJHUehcuKQ==
X-Received: by 2002:a05:6808:148a:b0:3f9:3c2a:e40 with SMTP id 5614622812f47-3f93c2a10b6mr2029132b6e.26.1741631626657;
        Mon, 10 Mar 2025 11:33:46 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fa33834905sm41814b6e.27.2025.03.10.11.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 11:33:45 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 0/7] bnxt_en: Driver update
Date: Mon, 10 Mar 2025 11:31:22 -0700
Message-ID: <20250310183129.3154117-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains these updates to the driver:

1. New ethtool coredump type for FW to include cached context for live dump.
2. Support ENABLE_ROCE devlink generic parameter.
3. Support capability change flag from FW.
4. FW interface update.
5. Support .set_module_eeprom_by_page().

Damodharam Ammepalli (1):
  bnxt_en: add .set_module_eeprom_by_page() support

Michael Chan (3):
  bnxt_en: Refactor bnxt_hwrm_nvm_req()
  bnxt_en: Update firmware interface to 1.10.3.97
  bnxt_en: Refactor bnxt_get_module_eeprom_by_page()

Pavan Chebbi (1):
  bnxt_en: Add devlink support for ENABLE_ROCE nvm parameter

Vasuthevan Maheswaran (1):
  bnxt_en: Add support for a new ethtool dump flag 3

shantiprasad shettar (1):
  bnxt_en: Query FW parameters when the CAPS_CHANGE bit is set

 Documentation/networking/devlink/bnxt.rst     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    |   9 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  95 ++++++++----
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.h |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  85 ++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 143 +++++++++++++++---
 8 files changed, 279 insertions(+), 66 deletions(-)

-- 
2.30.1


