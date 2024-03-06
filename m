Return-Path: <netdev+bounces-77890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D5873610
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350561C2093E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7F7F7E6;
	Wed,  6 Mar 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bzUTgSNe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EC79DC8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726867; cv=none; b=KlXV5qDlph+USBO1BB0Ev5N03/NqKSJe/qQrD8zgZfc7zPkSat6C1RO3P2U7EemYekxPwhTs14Xun6PySgxtnetP6sw0GNBOSLOizzEARNf1+Oc+2dLdCo66oZ38lZRmV9jWD0M72mLpuzj9bJXMUbS0LUMYN+CAJ0IEeW/luBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726867; c=relaxed/simple;
	bh=gKIy+OnKR8wE5coT1dXcI7cYuJmShXMrEA3TIP5Qwy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aei3B/1R8IyDoqx+6tLscjrh3jURByTjTtqkDWjSOTyvQZOASqyw15Lo6HecByIxJmBKjUUUEBgtbXHwOpzl8pBfyKnBL19rybY1tS1QjXw9ctBiiYmkqabVc5b9rSngyW10fvMqL5kl6hkcdZ2iyQDtujh71vY+/8SWLzbpWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bzUTgSNe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e4d36f288so501899f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 04:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709726863; x=1710331663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wka276o41+zeKtHHUUyi26yDDzMh3zSIUNoSRmIt6Zk=;
        b=bzUTgSNeb32JeK5pXiAi+GK/34aXK30l+Sdc1sOIIHgK63kJaOSPP4Mk4oH74iFULl
         GRmDnGxZQ26CZOINQykw/NlkfYOuhosBrvRGwUSDEPZQ01Hz7syTTw348LVDjuEzICJ9
         /eNq370Q0g6jnepIhWFLGPNEx7EqKPoiC4vKzhu/sldyavki08iX5pFepNvywCpH4gjq
         ONx8BgjCr/kZ0vXLFJetvu4hlmzNEBwHSqW3eM0Ql5brkctMyVisxZSjzdnOwU3ZeQRc
         6l5Sarw+3wokU26UdQUszpkyL6NflGPqX4Bynw58sOoX4ZJ+g/B0EK8vwRs2jXP0xiyX
         ibRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709726863; x=1710331663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wka276o41+zeKtHHUUyi26yDDzMh3zSIUNoSRmIt6Zk=;
        b=bdLSxT33ah4CWWcWd7H5W1kyJPACYucyEmXB90QUMO0yCzw3EFtSs5AZ8V025ycg2f
         JIA2mf1jNUnNzZftfo1+4H6TLuVYnglOYEyewYPBwzjrpeAcYdrr/+Pafwn1beGj9yCw
         nvuI3MDl+J6s7oNRLw9gBVx0Shvhi02M9XWVRNY2+IzLPnAE08MKn/BY9oMKa0Ho3Tq4
         WFnVluz/TcKrDQOHNOYJRGSWAypT5G744E22e7opmhrQPRgNLMWvfFwFJkVkxxPzL1cI
         LyoU1a12Hd43vVa5t4D4WKsfysde8OoFVbFa4mT8QQLUNTYChre1nzW026cBWIqdPQl/
         gFuA==
X-Gm-Message-State: AOJu0YyL7tLpThAqftl5EGPpUJS4rT7NDxTjsS8PzYVYxm8hWRsX4DYh
	rToZufEZ9pTqrqr4rqzFnB/y3eW7gyEI3JgJly9w90QuqgiFLk3M9ww2hzFtu67l8H5iUA//jAt
	B
X-Google-Smtp-Source: AGHT+IGZMbcrPHPkY6yKWlQtIjnSuKGP6Lf4tP5yG2MlajrGSbD8AUI3dCPyILWH0b87L7Fw76VAUQ==
X-Received: by 2002:a05:6000:1e11:b0:33e:47fa:912a with SMTP id bj17-20020a0560001e1100b0033e47fa912amr7750359wrb.27.1709726863042;
        Wed, 06 Mar 2024 04:07:43 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b004128f41a13fsm20950929wmq.38.2024.03.06.04.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:07:42 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev
Subject: [patch net-next] dpll: spec: use proper enum for pin capabilities attribute
Date: Wed,  6 Mar 2024 13:07:39 +0100
Message-ID: <20240306120739.1447621-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

The enum is defined, however the pin capabilities attribute does
refer to it. Add this missing enum field.

This fixes ynl cli output:

Example current output:
$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-get --json '{"id": 0}'
{'capabilities': 4,
 ...
Example new output:
$ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --do pin-get --json '{"id": 0}'
{'capabilities': {'state-can-change'},
 ...

Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/dpll.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 8dc1df5cfae7..95b0eb1486bf 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -312,6 +312,7 @@ attribute-sets:
       -
         name: capabilities
         type: u32
+        enum: pin-capabilities
       -
         name: parent-device
         type: nest
-- 
2.43.2


