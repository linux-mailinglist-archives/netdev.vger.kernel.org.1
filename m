Return-Path: <netdev+bounces-68982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E10478490A0
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286101C20E0B
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843CB286BC;
	Sun,  4 Feb 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EclhV4sG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88C32C6C
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081789; cv=none; b=OQh5O6N3NBygEAkq3qehOPyxPJC7S530aVyQxz5KrXCQC/CO/D+jN8FGAuC3Bj1D41HurE4sx4NsBpAxhChS70fNMYCg02Zp5oNOzxXLLx0/9K2oQHS+f787/9JDsZpg47HRRAKyI6yS0PJM1cNlOM2QnmsPK0TEOD0tewK3d3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081789; c=relaxed/simple;
	bh=4UYqTxp9akS1pkLIefnrLD54gBy4Vxt9REAPqFvkPGM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=KNXDHcumeZ8974FWE2zWF1JHgLmxNPc4NOgXI9waRXM7Kwnp7eNceK/T4m6bojuGjakLGoZO9hd4nRf5nKzNdEp2peFTCXdzrrYb2IYpPBeqrPzDMSQ6G3yzJXd/U8DWNcbZYhaJcw1zGJ50nMcAYm+D6qzhkDNJu8QCVdaW4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EclhV4sG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso1774119f8f.3
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 13:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707081786; x=1707686586; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to
         :reply-to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UYqTxp9akS1pkLIefnrLD54gBy4Vxt9REAPqFvkPGM=;
        b=EclhV4sGUHQ171fbfVew8rX9L8mTrGa3svAxdy5kEDzE3u1qmeV78znxBw6cCjxQHT
         QBY7VyILtSMp0no+Y9W2zLq4krBQiCmmvP7msjwA1EDb0LNeiae2XHtCKoYtK1Cl/cPO
         oTakDOCN06QWaxpfbwf4tNPPcjNiQdpVjcdBVg/qMs+BqFX/sJcKEMP2OPPAk7yQmpP3
         8D9C1Nj8N/BZKwMbD1eYvgo8npnIZz6LQ3rO8wOCHBTvzP+aYUcywjWFHkiNBkTWLg54
         609pOZ0zGhhhLTrJ8Psjxz4VPqDr04cDli4OrjDiiFXTf772NoHx4bQhIulm2jaZa6B+
         UxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707081786; x=1707686586;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to
         :reply-to:from:subject:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UYqTxp9akS1pkLIefnrLD54gBy4Vxt9REAPqFvkPGM=;
        b=Q6BoPhf0b68uw52vJhu4i91sU4tMiNn1vpOmwGG38FnjPHaq7vLaSMLLaPiMOJ0CkB
         TFFC9lvNDIWfg4PjblqTRFzu6bWFx79fHhSYLKdMXGYAk2tclczw4q5kLTNPiSBvvGBb
         D3q5qAl5m5yQFDYQpvK6ynJauLuQaM3wsrW6FA4ONTxC/n5i7uWYOCv9N19VmBaX1jZg
         kxaS/ypXZKlGgS95mg/cSSnN9461N7gYqE456M147U9NF6YafMmMG8FRA+JeitLsPkVj
         u2yWqR8c7OFKoZ7iOGZxzsvQlk1xttApOMv6znyW374yRuy9VhJ5D0k0QhAHZzrUYfpL
         fgJQ==
X-Gm-Message-State: AOJu0YxcdHeGM/XTRhElU0CRlXcFYzCQKAg7S4/y0zLGHDFAWBI+k8BX
	Mt41V31i/8FD0/qf25LzZTT3hksrxmlV2w2GoyzS2hgZfp4bGEYj
X-Google-Smtp-Source: AGHT+IGqCmup/mSuztaPfAe+aB4kb6LqRLkJK3OLqKtqt01CfirBR/w2nYZPwOIjvEC3tHHMdHOITQ==
X-Received: by 2002:a5d:6a0a:0:b0:33b:3c79:9182 with SMTP id m10-20020a5d6a0a000000b0033b3c799182mr1001964wru.3.1707081785709;
        Sun, 04 Feb 2024 13:23:05 -0800 (PST)
Received: from mars-2.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b0033af5716a7fsm6618626wrp.61.2024.02.04.13.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:23:05 -0800 (PST)
Message-ID: <75ea348da98cf329099b0abf1ef383cd63c70c40.camel@googlemail.com>
Subject: qca_spi: SPI_REG_SIGNATURE sometimes not recognized
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Stefan Wahren <wahrenst@gmx.net>
Cc: netdev <netdev@vger.kernel.org>
Date: Sun, 04 Feb 2024 22:23:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Stefan,

 working on a board with QCA7005, on probe() SPI_REG_SIGNATURE
sometimes fails (~1 out of 5 times) to be recognized correctly, even
after multiple reads and retries.

Any suggestions?

Thanks
 -- Christoph

