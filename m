Return-Path: <netdev+bounces-70013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B48784D583
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E38F1C21E07
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0412FF9C;
	Wed,  7 Feb 2024 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOnqtUTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8813172D
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342202; cv=none; b=N15lGlHARQta3m6jvzvgjvZTdClhQ14EIaZPLenWd6e/KIukzskLWScEpXasbY7Y0bz9H6WtJ75hFufhxGB1odo3zYoBRMrLP7hzZBujuAgoc4c5EGlBMoQjuY7morqbk10ID0GFtoBPmp61RMYzp/s9ThRRYNfSgtb1fcnRexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342202; c=relaxed/simple;
	bh=/LtftDNrltaXBANH8MYDW7w9tiWF30BQOjeE5W0i2Go=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VD/o6YHoY9w/u6HO5xmTqajFZ6EMi2YRNnBl/w6BpnidUdf7oFHJiL5ABWXq6BOSvMz2le8XJGlYVq0R+vdiyEzv/HYgoiR5+h4N4RKioeKlmQ1gnVQ1IYsRqMcBflcWPI7AZOcF4sUS0VGzGoU9gd/zptAr6q5cvqiTJYqvsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOnqtUTi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51032e62171so2052329e87.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707342199; x=1707946999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xut+aZyf7YNmDhKro77ZkL0YvXMOaLotNu6Q4JGn6jw=;
        b=VOnqtUTiNbTcVXRayEtZADHZGuzb8P7RGf/LxQZUj6+0sH7YoztgydghDErXx8MPup
         i1RUSIZDVTrFFien2pbtmuaYt/yVk4pfC0CCG+iVPhHi2q8uPRph/yXFHWV+TKq2ZFp8
         r1OjkmjkRt3Wbcn0QCakmCQ5oS7uXO0vzhSjPFer/Te5nzLCERJT4vOMyTRP0dz/KlvD
         WHUoOrZ7HFMwYkiAbAka8/QDhgbtmCKNL9deDMI7irt4mW7kNo45FNgnnoNWTsi6yT8L
         TVRqKzipG/07omKr21eXP4tUIXs1Up4wmv1zuX8Is9vmA/35dRJ/oThCAVSKHny9djm5
         9UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707342199; x=1707946999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xut+aZyf7YNmDhKro77ZkL0YvXMOaLotNu6Q4JGn6jw=;
        b=VjuuleBLedEMkd6kT9CtDGEdBo24LfKZ1QU2hqrk65TQO5XZwJZv+JexWwTUbWqX+b
         bUV2EZ6xmq7Fhz20rm/I/JrhLFn8v78uuZnNpDofOXSl34XBAfNKWMBXQPxdZJbQjqO4
         1zqi1ROSV6catoJhwDewtQSLi8pPhbootlhZwAMTxscWaWH8daZx0qzvcMD9RPQwLrDJ
         5yPalIu4W/S9RaXNOcEPVOWTfz+3AZnUdW+8g4Mw7+cfCE6BC9c+zwenjqhvdpjwBGr+
         r3DD+8/Bl8FAg45JlGAEKrhJstnbniagpot7mCqMP2JMluaTBTfUkY/4GLVdeMRP7xMt
         eZ7w==
X-Gm-Message-State: AOJu0Yw1eWbgmQpWnfar02jI/KAZRLrK08QQYvhAc+zJxmuzwmv27Oei
	L/8PnBRmw7N6C5U3OeDhw/VrE34QjyrTNScfXAHGiX34d5EAfr8P
X-Google-Smtp-Source: AGHT+IHM4i32IbHpWfzWrcqDIvkjvyMCeugOIYfvOXbTqLzd1Zx5LB9qSwKMzAhO/Kqq22P00rUtkw==
X-Received: by 2002:a05:6512:104e:b0:511:674d:88c9 with SMTP id c14-20020a056512104e00b00511674d88c9mr2435266lfb.14.1707342198939;
        Wed, 07 Feb 2024 13:43:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyU+GiWKlm6jBbJAKxTiVyWb1XP1hLu5uoAjHdCb7H7hVcaczehFf55hmNO288bT9e35fYnhsEVvTIoKWifH6lp+7YAW1u
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0051156788aa7sm327333lfe.133.2024.02.07.13.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:43:18 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] m_pedit: Fix descriptor leak in get_pedit_kind()
Date: Thu,  8 Feb 2024 00:42:24 +0300
Message-Id: <20240207214224.19088-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by RASU JSC

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/m_pedit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tc/m_pedit.c b/tc/m_pedit.c
index 32f03415..b5965250 100644
--- a/tc/m_pedit.c
+++ b/tc/m_pedit.c
@@ -95,6 +95,9 @@ static struct m_pedit_util *get_pedit_kind(const char *str)
 
 	snprintf(buf, sizeof(buf), "p_pedit_%s", str);
 	p = dlsym(dlh, buf);
+	if (dlh != NULL)
+		dlclose(dlh);
+
 	if (p == NULL)
 		goto noexist;
 
-- 
2.30.2


