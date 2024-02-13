Return-Path: <netdev+bounces-71394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B20085329A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D1E281793
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED02956764;
	Tue, 13 Feb 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKnb/Wb3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65F56762
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833164; cv=none; b=ki2C8SSoleyAk76YZtqIQizPpSdDu3Xojvf6oWjvY0FYh8Dgjj+KG3nvu2hRSVa7DQ4eDxhjgpmUDkwMF9fW1VuSz8kD6RuCHqAfZOd5RUr1xEaf/g27lrlMn8TJYuYNXB/Mad0rTWDLK/yvd8nbvPHie5yjeJUfGA6pB6bUkY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833164; c=relaxed/simple;
	bh=urVUkZRCC0SPsqQXyGBYCj1EVWQZzPHlfYClrS3iOMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qCT6ZtWIwwYijJK1Bt74vSZpMEuG32B06t28e2eKTk7sCKLeeZfwqc8zmK4nBTA5LPknjfQsSem8qrrTP0byFkTQtkbZQ9KTLBi/lU4yf37qFLumr6WelKWwIHFnvl7t9UVP5eRcG5olqpsEub4wtje+xlfxR7UqWnNEdr2iOew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKnb/Wb3; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-363fdf018c9so5281165ab.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833159; x=1708437959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAvflI/02UsFHSv+C+p1aXw4A6z2fuhkZ1kPs9WbyBs=;
        b=TKnb/Wb3lMBhbALwpNRc3aM7VS+6yjHUtY6n/Y3wGpxZl0aiCx/tg/hq1lMEIDotCR
         T07f9hQfkZI/DRsVrngDirvk02rz0IKHWTULpGBVdyePsGPr+d5Mj2XkJz+cV+wnZ8v1
         4OZu0/xOTncJU7uIGZe85PgCV7cHmGdISckZ+tapSok94jIh28e05XZW+Xz1379SUTLi
         HjHyWQsYOPe33X0Jt2kT28rW9Ddy8rabP6+lQRIOTqNwtdb+8TOX+rNWOyGaaR7FP1+1
         Vm4pyKSh5SScHEACp7AdBxK3Mh+/5flANO/wre9sMMaNx5WUkot//2NXMV/su6fCawP7
         7pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833159; x=1708437959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAvflI/02UsFHSv+C+p1aXw4A6z2fuhkZ1kPs9WbyBs=;
        b=vv3/a3fHHrEeBAqS3x2A2ncxCWmzGQwSQrBBii7cgIqvAgku/0zATCIUUuiFLrskaq
         iOhaylbKOYL14z8CfRWezXE1cy3LHFnm2oSPCWQZqxZOUmbV1xIZv6LYCAvzyXMJgiDk
         QbQxPcClihBH6ZQ9ATHTatv52AR383qjryFTxtXnU1mDZtr7VQlYfuuxnBwKF74A2AAc
         SFx6BuHzanCQMQWU+yJT9UOyHI65/0WyRuaD8cQZQm2dKM57YEy8oAnB81z+vakjiZax
         +spqPNMdwf7w6JJcbPf2E7i9PAt80Gcs2NoAJBP1Kp+xGJHWOWh8U9M9/HT73MH39pue
         VJwA==
X-Gm-Message-State: AOJu0YyaDFH8Wianl5afXyyNK06IxqI9wueF+cWNSa0vJLd31yMU6YFM
	ly3kyqw+1Kt5icwk7N7W44U7qVE65HX5Ufae8SENdtwkuQYuWzix
X-Google-Smtp-Source: AGHT+IEMs+Ar41eLY9pXixJDP2tn8IPuyIDJSzHat+XEI6JMI9gqr/3dvA3lB8kkzR8Jo2Ry/gAnrQ==
X-Received: by 2002:a92:c109:0:b0:364:145b:eb52 with SMTP id p9-20020a92c109000000b00364145beb52mr3710331ile.23.1707833159648;
        Tue, 13 Feb 2024 06:05:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDdj8oIeSY+mhk/Hcmed+OzafDgtomwTqV3/xu6dlAvlL3KqIemy0S/2eLz3AgsNacvtK2jOQbCuRwFoGNKKiPo8c8c3798Q1QU3ujd65BSbq1Zz1Nw1X7os87cCkJWx9woC3A0daP4AB3zDDJBECncxk0+EuVwLiTZPR8oOu/4MR3BruAXQAg5C6ulygrSnqJNfnIJ6bdEeXTobYlFWyo/vkl5YQzEbpPnAVpG5WYSO0IC9m7IQzvcC4D/di02Tjp
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id q19-20020a632a13000000b005dc8702f0a9sm1306247pgq.1.2024.02.13.06.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:05:59 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 0/6] introduce dropreasons in tcp receive path
Date: Tue, 13 Feb 2024 22:05:02 +0800
Message-Id: <20240213140508.10878-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As title said, we're going to refine the NOT_SPECIFIED reason in the
tcp v4/6 receive fast path.

This serie is another one of the v2 patchset[1] which are here split
into six patches. Besides, this patch is made on top of the previous
serie[2] I submitted some time ago.

[1]
Link: https://lore.kernel.org/all/20240209061213.72152-3-kerneljasonxing@gmail.com/
[2]
Link: https://lore.kernel.org/all/20240212052513.37914-1-kerneljasonxing@gmail.com/

v4:
Link: https://lore.kernel.org/netdev/CANn89iJar+H3XkQ8HpsirH7b-_sbFe9NBUdAAO3pNJK3CKr_bg@mail.gmail.com/
Link: https://lore.kernel.org/netdev/20240213131205.4309-1-kerneljasonxing@gmail.com/
Already got rid of @acceptable in tcp_rcv_state_process(), so I need to
remove *TCP_CONNREQNOTACCEPTABLE related codes which I wrote in the v3
series.

v3:
Link: https://lore.kernel.org/all/CANn89iK40SoyJ8fS2U5kp3pDruo=zfQNPL-ppOF+LYaS9z-MVA@mail.gmail.com/
1. Split that patch into some smaller ones as suggested by Eric.

v2:
Link: https://lore.kernel.org/all/20240204104601.55760-1-kerneljasonxing@gmail.com/
1. change the title of 2/2 patch.
2. fix some warnings checkpatch tool showed before.
3. use return value instead of adding more parameters suggested by Eric.
Jason Xing (6):
  tcp: introduce another three dropreasons in receive path
  tcp: add more specific possible drop reasons in
    tcp_rcv_synsent_state_process()
  tcp: add dropreasons in tcp_rcv_state_process()
  tcp: make the dropreason really work when calling
    tcp_rcv_state_process()
  tcp: make dropreason in tcp_child_process() work
  tcp: get rid of NOT_SEPCIFIED reason in tcp_v4/6_do_rcv

 include/net/dropreason-core.h | 15 ++++++++++++++-
 include/net/tcp.h             |  4 ++--
 net/ipv4/tcp_input.c          | 25 +++++++++++++++++--------
 net/ipv4/tcp_ipv4.c           | 20 ++++++++++++--------
 net/ipv4/tcp_minisocks.c      |  9 +++++----
 net/ipv6/tcp_ipv6.c           | 20 ++++++++++++--------
 6 files changed, 62 insertions(+), 31 deletions(-)

-- 
2.37.3


