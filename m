Return-Path: <netdev+bounces-73180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1154385B43D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99926284421
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9CD5BAD2;
	Tue, 20 Feb 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BEN2Mfv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9FE5A4CE
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415572; cv=none; b=JkQDYEWOLlDgZGvSecrCc+bdI7OUS6O+sDDm62G/YiGAvoH8fC9oECw+CNZMzj2I21IorcFNA8Aglor8Sv9X4WRri+xWJWsqbCxOg6CarK09o/ggSv2/NS7WUR4/UNEwawyiNUSJBfwOWDsratcWJsyh3fUbDlZ66hEVIaygz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415572; c=relaxed/simple;
	bh=EhUdmAG2+uRv/nvyJQxfBOTiJMdMb+pIsF7h7RGoD80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jftPDGF6PfmjmslL6gWYLtalid94/6wKen8uIg2P08WI2QsngliH9djy1PCnQf79iMQgQbzTOpTzkqMZYeOrdiZtCFHP5HCxEvTYrCaEDxqZ3MbnV1M7aQ7pgad55Y/s+J7QJNcyTgj92NN69Z1LCWziumNqOYTCpQgzcHI5yZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BEN2Mfv1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3394b892691so2794583f8f.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 23:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708415569; x=1709020369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Na8+xfRYHv7a/Vq5NlGv9jubLXm4jSl6ydxMd/DV+kA=;
        b=BEN2Mfv11NtrH4jbFqDSnCRyCuGc7cUxOhFyru3pVab8PERXp3iDdPNKU/+r35jEZA
         MLT/cBrIBeSgiuGx1DEff/De3SUcX2DOwIzWRfxhaa4Cq5f/IFd408JPquhT3HQvpVc7
         FS7UiQkYezURcIz5/Vcmy2HArQEgvPIVMyd6ODwI9PjcbOaPti9BcHAaFQiYyaDiCKDP
         fm6d3zRSVQwdzWT0tCEHZypVXjeClmfN9am3GdzolTLE2rYj7Kov4Pffq/6i5StYjPcz
         Qdr34rErZAj+GDZ7JpW9S7Anxma30ZcFd9LbuyhdFlDEvSeX2M9siCMZYhQLsiUlY0H/
         ANHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708415569; x=1709020369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na8+xfRYHv7a/Vq5NlGv9jubLXm4jSl6ydxMd/DV+kA=;
        b=MdSL/jS5zyvKHcI9Ru7rs4Qfq0DEq3W99gJrXhr+I2rPzjmNJA5k5jC2lB8nDD6Few
         rDtJYnnNHZC/cctISa45+Gn+7GqaGw/F/tXsTy+QWjMNV14O9IZdprWrHvdnzsdhRs5h
         tSRYl2ud4arU6D2rZKqRtcLuIhTVVo7vffoBuvIX4lIVZgO4bJ0byEJ+YkP+U3Yhx+bY
         PSRXb51ptr8xpfWZLSN4Cq3srF6IOszT9ph/6KhC2ryYTjd1vCvS8jq9oDRhoj5kVNCP
         sZVPh8523yrTePRFsRQlpR3A+172719sVaP/Q5DeLNeL8XCv7g2gF2wfkNBDlPYhgs8Z
         76Lg==
X-Gm-Message-State: AOJu0YyQlronnBkYURLWxoVAeGjKKTupotScZa/GbxAN4AV5Cl4C72kr
	1CIU8mluDFXWB+UEKCXhby0f4DMnQXgdmfJv1eHoZLHBAjsYkxtAV5XWPWRdqNY4uN2qh3+C5xM
	h
X-Google-Smtp-Source: AGHT+IHGTZfsrGmyOMqWkQteTCPMWPZPnoE+IIrUbQ8nqnCPv3knk5sX0rk/73VzUzpDRQMCiwWT0Q==
X-Received: by 2002:a5d:588a:0:b0:33d:3b83:c08 with SMTP id n10-20020a5d588a000000b0033d3b830c08mr6599734wrf.23.1708415569116;
        Mon, 19 Feb 2024 23:52:49 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bj29-20020a0560001e1d00b0033d5c454f03sm3796040wrb.114.2024.02.19.23.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:52:48 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org
Subject: [patch net] devlink: fix port dump cmd type
Date: Tue, 20 Feb 2024 08:52:45 +0100
Message-ID: <20240220075245.75416-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Unlike other commands, due to a c&p error, port dump fills-up cmd with
wrong value, different from port-get request cmd, port-get doit reply
and port notification.

Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.

Skimmed through devlink userspace implementations, none of them cares
about this cmd value. Only ynl, for which, this is actually a fix, as it
expects doit and dumpit ops rsp_value to be the same.

Omit the fixes tag, even thought this is fix, better to target this for
next release.

Fixes: bfcd3a466172 ("Introduce devlink infrastructure")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1->v2:
- target net and add fixes tag
---
 net/devlink/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 78592912f657..4b2d46ccfe48 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -583,7 +583,7 @@ devlink_nl_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 
 	xa_for_each_start(&devlink->ports, port_index, devlink_port, state->idx) {
 		err = devlink_nl_port_fill(msg, devlink_port,
-					   DEVLINK_CMD_NEW,
+					   DEVLINK_CMD_PORT_NEW,
 					   NETLINK_CB(cb->skb).portid,
 					   cb->nlh->nlmsg_seq, flags,
 					   cb->extack);
-- 
2.43.2


