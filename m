Return-Path: <netdev+bounces-147352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D7E9D93D1
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBBC2B21856
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079BB1B0F26;
	Tue, 26 Nov 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bczEdLco"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF81B415C
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612127; cv=none; b=Ym9LjAkJZpkBjpqgA9uOY197DOMBy6AFO9/pQCUuCTVL5QebUaCS/e4CAdEYSAxYuK7J6gN1Oy/zFNZGWbvvKsGXkh/1CRl+vSVgSNdAg9hQs0zRe3ioR6gm07fLjAzl57xouTuSUym3ykq4q+lrWHQst5PYM0dgaX0LefqHBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612127; c=relaxed/simple;
	bh=sc+2ipuBlnI0+rAVlSLBGAGaPcNXDV7AgqigyNVrb8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDHuhNwvjpamElJ+ju2JEQ3X3kz8l/wvUwM4XeJLBDDRjTmGAG58/aK5yaBxRgvVslSjIBVrrWZXgVJcK9FRworgNpVj0mWifLCiFvfikNViO73IDkFaXhsEOKmChSZH/D5hf4yXI3VK/xODSDAKCXMv4kVHR4xy4FJjIIzTzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bczEdLco; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so15476195e9.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 01:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1732612125; x=1733216925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFd1ebhZpjAtZnnNiukccHu4xLx7w3A+9Qv4klrtJrs=;
        b=bczEdLcoeLy/Jt7b8phBCxwOdM+vaq7IwmlJSt2CU9q+8AaZI+ob3vXXqebSjK3Wu3
         ScDq49SsiFQPAZxKaCGajSq4XbVpmD9kLwHIICnE93MbaJ/+r8cxbjbaFKlLHDX13Ad6
         ykt2bCHOt/QXOjb3Br0DrMySVSKHH76ypwS92TaWic7wiey2PG130zrUIADHyeWf1oLZ
         jPMOsUNKfHEtLCHXjanZnPlZ7ltT6yCbhQN3+5mH/gS0sV/ayLzW5t2gvJgBMWnAkbr4
         qPMZm7/rPqpTJ6gP3uPvsF33Qk61BfGbxtok96gbnHViMvpU3dyzqeoe/x5R6E570rrb
         efaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612125; x=1733216925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFd1ebhZpjAtZnnNiukccHu4xLx7w3A+9Qv4klrtJrs=;
        b=t3VwuRX8uiEP6mV+gjPga5oXG4Bh0V/XBjeriubk183XtKzJwKqdaBoiVAQbsr8RpY
         g/yMPVLpG4Aj6SeUr1Ch38xeHQwr6LDdFPBj1gC7FcImbeBArU7yjt9LDmwHmLI22Etj
         B5wr2Tk92+pNYodJfu5rqBM8OcgOFZ6kYXQ4vl2/fj30RshPcIusUOcTo9U6HaKEOYu5
         kZg4sY+vERCJ0bcTWgGheh+1WUjtlpdU1OC5waqSqjvXFTYgZoFhNtZ+ZKmwOw4RA9by
         NbixYX7esFPaagJzRvibm7tfbcHKWMSrYq+yHqQiP3sx5sc6tNjsgegdeOLh1uRd2XIX
         4DkA==
X-Gm-Message-State: AOJu0Yzsphu2fMy6NEQIa+5lyyHTYhRbok6PiPrKxIHe1SitECcAy9oi
	/OXM72L3Vd05bzejJL00SYxd6HDDVSdyqR4GJ8GKjZxT5Xq87zpzrDdEfHZbpOaNh+xYG3hRY3v
	I
X-Gm-Gg: ASbGncvfK85ptB/GEDgaJFbw3ranA9JusHqs2jpnGxcxvmboudKoovnAVl3zCGXVfK+
	hzOvIEBVzp9fprv0QfUD3xgNXrrIMavrliYy3XovI/JN64pTkS1t3Pa81+BrEpVg6u3COWuw/j3
	/vn0/8mDg9vv0qYe4HmY/biVet6cg5yg79KV4Ux+fMANgAPa7UN6uTv99vZiNeylxLiRC1/2sBF
	cdL81OQZmhMAwDWFJw+6gUOx3rbJAkOVlIyJfYHx5A=
X-Google-Smtp-Source: AGHT+IGseQ1ow5XF1iaXqYGyFaoKW09qOoxSQ1fJL0wFafyQG80Dr/OFZ1KD4rfu5+4vBQ5VZYZ8ew==
X-Received: by 2002:a05:600c:548d:b0:433:c463:62dd with SMTP id 5b1f17b1804b1-433ce4e73camr137249625e9.27.1732612124756;
        Tue, 26 Nov 2024 01:08:44 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a4d41fb4sm23577815e9.14.2024.11.26.01.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:08:44 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	saeedm@nvidia.com
Subject: [PATCH iproute2 2/2] devlink: use the correct handle flag for port param show
Date: Tue, 26 Nov 2024 10:08:28 +0100
Message-ID: <20241126090828.3185365-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126090828.3185365-1-jiri@resnulli.us>
References: <20241126090828.3185365-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Port param show command arg parser used the devlink dev flag
instead of the port, which caused to not identify the port device
argument, causing the following error:

$ devlink port param show eth0 name link_type
Wrong identification string format.
Devlink identification ("bus_name/dev_name") expected

Use the correct the devlink handle flag.

Fixes: 70faecdca8f5 ("devlink: implement dump selector for devlink objects show commands")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index f4e90b804fb6..5711974f2cb0 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -5088,7 +5088,7 @@ static int cmd_port_param_show(struct dl *dl)
 
 	err = dl_argv_parse_with_selector(dl, &flags,
 					  DEVLINK_CMD_PORT_PARAM_GET,
-					  DL_OPT_HANDLE | DL_OPT_PARAM_NAME, 0,
+					  DL_OPT_HANDLEP | DL_OPT_PARAM_NAME, 0,
 					  DL_OPT_HANDLE | DL_OPT_HANDLEP, 0);
 	if (err)
 		return err;
-- 
2.47.0


