Return-Path: <netdev+bounces-64806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBACB837259
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AED1C2AD70
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61DD3D99D;
	Mon, 22 Jan 2024 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5aLk0XU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCDB3E497
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951157; cv=none; b=lYgWXcCyWf9XWuPUbDUkOeTW+1RVcGI76IwUk74DKVJ+ZndueZdiMwyeNDh2s9XLdMDbkBDInrYiJPgZhyuv/RQVbD5OaC0JOijqP8cY54Yc4/3qSq9s/l6ITkUsbFgnMbgRJDKpmaOsFTGC4hjG77tnYyn5dhsTIecrAAVQB+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951157; c=relaxed/simple;
	bh=x8NPH1S7ULd4Idd1WJ1rSX7ESzGQXy4OpkYM3fAuoH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idQT4sV1SdtTOeAFQFue493eZb5oxNL3Ze5fIsR13jneIIAykAKdrru0YCxJ0Cua37qc6+EH39emfveqgDGZ21uBZtGqoq98mcGUclnwS7KfKaS3zjdJo2bFtwojnEnI1+UktJ8XIePo5praVpaYT39iFWGH9sbs9NShucJCbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5aLk0XU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e8801221cso35136855e9.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705951154; x=1706555954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCn8ZnWzJtFPz9cQe8qkKAREOwut4nhShUJbW+CGkIo=;
        b=V5aLk0XU+y4OYOHFOHitW8U0qKrFS2mSazmibADJjydugLkHPyv7M/5+lEyj21Toih
         9dvJdRvLSmFCE82+Kcpp3QCybJlKI+ouaGHA7r/glJj4uXcxCG0fpZdCwIIl0vMjjngG
         UtX55NFPWrgWudVZCN2lXuq3vxwmvx3c8u8voC3H9SrhSXUB6crPFc8MoS4YJU8gax2K
         NT2s82OfhRihWcE4Bb83KBSBxA2kBEliEeECfq75Fh8k8mVt57QFwqA8+O820Plcq3qN
         vVFpmevb+dlxs44mCswSrzn1XWH6v3aK/JZbxj3IdayAqHx2zG+p1bTA4sAXHvOcxuqu
         y0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705951154; x=1706555954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCn8ZnWzJtFPz9cQe8qkKAREOwut4nhShUJbW+CGkIo=;
        b=GasZpnctr3Qrvs/dhXHTSd0Kcctgi7bxVFN1kWbJ0HiqfMbBWtcn32A/iXJTUhrryD
         EyjJnOeFgq1i8OAHfbuc8+QMtfyFR+dGp+I4urklX5Q88f89YhdMJnvRfK9pnd6zakG3
         qh8cPpJgIsI3jJV+FprM6DdaSEA+eR2MC0Ik5mCusDJaDNKcM50Rt4YAkFjg1In3/Ykk
         r6DUHCvgnwwXrgccxZZOcQdmx9PB0E4dJV8BGtEAE7sRyrAzGdad/YtCQsbNCr33bIzM
         ZXztoTWly68IdZR3JTDF9VxYF3GQWT8UTbbHCmKBpY+ta+YA/NWdjaLVM9DLesIAdwPM
         +FMQ==
X-Gm-Message-State: AOJu0Yzr2U2je4JZPfBxCuO0mX4n13u9Kzb65LiRbfWBpqPVPSwpZCp/
	gfRchzRJOLbPwJTUoo2TEM4EmTv8eHpDRt/D8GD+Ps0i631PLvet
X-Google-Smtp-Source: AGHT+IGPd9VvbSqpQ2MCni93yvZMr1P50GLWQ4mibtczlLo9PujAP6SN9xI8umfRPBTKWBXgU7RKbQ==
X-Received: by 2002:a05:6000:1f8b:b0:337:c553:50e2 with SMTP id bw11-20020a0560001f8b00b00337c55350e2mr3326930wrb.3.1705951154335;
        Mon, 22 Jan 2024 11:19:14 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b003392ba296b3sm6211104wry.56.2024.01.22.11.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:19:14 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH net-next 2/3] doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
Date: Mon, 22 Jan 2024 20:19:40 +0100
Message-ID: <068dee6ab2c16a539b67ea04751aac8d096da95a.1705950652.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705950652.git.alessandromarcolini99@gmail.com>
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add multi-attr attribute to tc-taprio-sched-entry to specify multiple
entries.
Also remove the TODO that will be fixed by the next commit.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 Documentation/netlink/specs/tc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 4346fa402fc9..5e520d3125b6 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -1573,6 +1573,7 @@ attribute-sets:
         name: entry
         type: nest
         nested-attributes: tc-taprio-sched-entry
+        multi-attr: true
   -
     name: tc-taprio-sched-entry
     attributes:
@@ -1667,7 +1668,7 @@ attribute-sets:
         type: binary
       -
         name: app
-        type: binary # TODO sub-message needs 2+ level deep lookup
+        type: binary
         sub-message: tca-stats-app-msg
         selector: kind
       -
-- 
2.43.0


