Return-Path: <netdev+bounces-178877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1771DA79521
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321333A6550
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF9719005D;
	Wed,  2 Apr 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hmVc3pR0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321F2E3374
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618712; cv=none; b=ei4jgawn2ERFrqwsIcriA+alcovkVKbtgBi3jbo6IvpsRWjzLwHDkS4i0SzKBfHDd+s6RpXiacQh65PrlidlaXEvKcEriZGKpcU72WU/dTu+BUNkxvi4lvK51o6dU58QPuBqZ0+ejab//zS/MgBibo48gRhtP8TOcOYEQjgbEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618712; c=relaxed/simple;
	bh=C9itw4oy3nvbljH9jiihMcRQn18h6PsXSKIU3YRewlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kbtVM4ThrFgpYUwuBYiG9UKeWHccWlPNyG4Ee/4hOazzUL3iYHNlXTpKgCU6iR5cVcs2BPaMcxuXC1B2r0gzlQLAl4nO3A+fs+erKx38iG6kqkvbq1dG5ZUKc6t13e3KSQ5HM1Dig8woi4yqo2jdhp4FqFv0aBnABtUmJLm49/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hmVc3pR0; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2b8e26063e4so14083fac.3
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743618710; x=1744223510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfAFI8van7cmv2697Vnk5Y4fLnZhDxXjx5S1SZQm0+E=;
        b=hmVc3pR037l1uWt1njO+oPk5T1VI+jmi+SQRf9hQKQoEZlrvRq7Sp5179rp3tdc1+C
         Ivi+iYBBIi04z9oaSeFybFF//4D3la6FNg1+e+4dI0OgzRgwWSqMq02VbBlXo10DuP4R
         QtwdF5edY+trO5zLJFcgwquCBi3WoVizoQdqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618710; x=1744223510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfAFI8van7cmv2697Vnk5Y4fLnZhDxXjx5S1SZQm0+E=;
        b=eVNYb7HBPCdUgD/cvoP13wapw/anVHzRKeAVpyb2wU6ERgCtdJORYX5SI97tZpb6i5
         maE2/A3luomCfWZxmE7TJV4WIrsZBNp47+rL3fyTmZFoiC7fnlGAQgUOiM1WGxuONorf
         ANuyL/ZF4r1lfbE4aEq8IUJU4n4QL9l+KXx/bHWrkOKnpIdTlFGZrXhtbgoAIV8PxJgK
         X9Z+txLQ0pqiuAUAAdba9MzGQRB6Y3Sobgmt3ZcDhAp3OrLzrFyPUzDU4sk6NtZTgYKU
         lagcEt1YAyNvx6fhRjqvc16JPqhXLwjjPYNpERVlU3R7y3PYsn+3l3r9vNL8zIMi1l7c
         mOTg==
X-Gm-Message-State: AOJu0YwcuB4k2rpbrZldvVMEtUlL3T6x5/QOy7ewuN+cWai9vres7tvD
	geptL6rY7KCJht7lgloYGSE9CCul4qCd7uD55QPfGKa84lfN1dus+BCpTOHEzQ==
X-Gm-Gg: ASbGncvXYSfEPFO6qB6dhyAy3IaxKFPPQvgIyRUgN6du9bDhgkIZz3O45YxDcIz7Ei7
	pF0SSqGIgqIcZOCqnr8QLo5UMv6drE8vUVjgMXmyVy0EZj8/9L+TTIQNWXFJFq7jADE5oVlYWIg
	xkbPurueOZ2lkjoQxDF2xL2hNOk8CosOJmeCmSlceY0aerI/6P8pYPR4Rxd/uSCAODCDXrY8TMn
	gehktdCOA7UjjutAcU+1UN1/RqruBgt7kVI6FfBw73bxJrH3pBNijbbr16AWG2vzTIr66XZK0xm
	GPEqxv1kCwSEhlMr3me7AFAL+uPjBBrqImzwOx6t8AsohMFVI1EwChMJhVcMIk7Ix3Ifb8dB30V
	l3Hfd38R532hUFd2nMVia
X-Google-Smtp-Source: AGHT+IFXG8XULOteyAFXqKkZ1WJeZs460lteecrTHHmEW5cOZVuEBlpb2qAQkm+HoOMuOG7lgxxsCg==
X-Received: by 2002:a05:6871:a106:b0:2c2:519e:d9a9 with SMTP id 586e51a60fabf-2cc60d5c4c3mr1699118fac.24.1743618710109;
        Wed, 02 Apr 2025 11:31:50 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a856de7sm2917135fac.39.2025.04.02.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:31:49 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	horms@kernel.org,
	danieller@nvidia.com,
	damodharam.ammepalli@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/2] ethtool: cmis fixes
Date: Wed,  2 Apr 2025 11:31:21 -0700
Message-ID: <20250402183123.321036-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bug fixes from Damodharam Ammepalli to fix ethtool cmis module
firmware flashing.

Damodharam Ammepalli (2):
  ethtool: cmis_cdb: use correct rpl size in ethtool_cmis_module_poll()
  ethtool: cmis: use u16 for calculated read_write_len_ext

 net/ethtool/cmis.h     |  7 ++++---
 net/ethtool/cmis_cdb.c | 10 +++++-----
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.30.1


