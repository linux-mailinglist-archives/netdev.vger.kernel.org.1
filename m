Return-Path: <netdev+bounces-212626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A65B217B4
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD81F7AE312
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997D2E3AFD;
	Mon, 11 Aug 2025 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ywb88EWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C4B2E36EA
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949286; cv=none; b=b7z8nST2DPE+3E4wob94xGOJFjjzA3rgVQ4WAtW7NONlY/KYArkokOy+n5BnJRGMt5xRxMfkRoydy/nfhE0uvbj1EhipJfeUSy6ZiAT1B1cUpEuyKqI/khqEiQ76+7XmgLyyyiJvtNoniCVLlaEzyJk8WCxCjumefXYogvsfJRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949286; c=relaxed/simple;
	bh=TuT+2qEKz1Cv8EXUMxTj7zo0pfC6fxgBLJTYZ9+mgzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZhiTJaqyfUE0WrgWDFlU/aphLE+2OS2Ft9LDqNLM9qX5wJfdYgf3qCkKFzCRZMw08Urb5EuvK6oWaV51x8hEtxvZKNYnnUicvLXJAMTBHwGmltjavdmeaWbSr9cZLefgVm77k7rgGykm03LMWJWZULXCGpv8+hzO3f8YHYqvro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ywb88EWm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76be6f0bbfdso6284520b3a.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754949281; x=1755554081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2fr+iOfDUfHKxqt1JpwkIFepcMxHdmK9q7G+99tG3o=;
        b=Ywb88EWmJ5GwN8nGWHzMaPXCOIPQ6GE+GQwMcYqGs9u5+d7/Y4Xy2QCN4t0p+27Rwv
         ljZpMy8/+XixQC9+WvQQw94rMZ6ospmiVP3Ohc2KxLsRz6hcWwwsjK3MwZ2JW8b+5c+E
         Rl+HF6eisee1xIJWuNjVV95MnS2cbUrzNT047EXTBPYtGVMQIA/x/I38DXHNYA/klcVn
         w4JjMYGNg9dqT4y2snRLhIB+u1U/3A6HWxpVTjsRdzOCHAVnjDQVUEKKt7nIKB0j+zLx
         NxrCHBQM6m1ScQC93hfABc41/iUfEWf4xJe8SgFT+Bxx3STgi6VtahUJoP7ePkaKilv4
         +ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949281; x=1755554081;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p2fr+iOfDUfHKxqt1JpwkIFepcMxHdmK9q7G+99tG3o=;
        b=AqOrykXDmdeNikI3oE9DJkxt3xCilcBohLK8iN2GK0MRuAYQ81M61GOHufOEu5u89e
         RT5thipkU5imwYGFLQQ0rdz7ocf91yrXIbYOhslkFGbSWlLHWKOv6cbKPNSWrujULXi1
         jMH/5s6WGgwgksaU2Br9oJ1cgCyDUYboDIGgJALbPicTOJC99R4YvmI9Jsf7Juh+c+BG
         sKRCoZ8xEA4bhO4aGv20B8WspQFAmtxwyh2nQR+jzwudvUYZMTri0Ub0QJ243501L3X2
         m3m/38VkV8Tcar1kLk1fLPchiRiHDarEAEvJGPktdbRsF3V77Lk0DXcI7fvn5bXgpqad
         KFnA==
X-Forwarded-Encrypted: i=1; AJvYcCXR9H7w3xA4BHFyxLBDJ28zoKtDbx9L5rsBlhqPhVyR6wfKqarN0qORkjlcBKGXyA9aEM0EVZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/v3J1LCqpH0LhpXNE7tXKESiqWTT59tY1HEQKL8lpZDAEwsG
	h9lKLhr7LUS9Lp5dxm6QMaR5Lx51j5RTOvHb8y6fmEZ+rcbfN2tMdWSm0+hDXQZjO2hzWGlBnrj
	VOo3hmA==
X-Google-Smtp-Source: AGHT+IHhJV42pBtWXzmKE8/xiwjINNmhN2pDrn+bnosCpVg+rjPui96/dZj1lfjZaH26UaoaoJlhaGbG+WY=
X-Received: from pfbbx20.prod.google.com ([2002:a05:6a00:4294:b0:76b:eae7:95e8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4922:b0:240:9126:2bde
 with SMTP id adf61e73a8af0-24091262c4emr4426967637.46.1754949281488; Mon, 11
 Aug 2025 14:54:41 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:53:07 +0000
In-Reply-To: <20250811215432.3379570-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811215432.3379570-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811215432.3379570-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 4/4] selftest: af_unix: Silence -Wall warning for scm_pid.c.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

-Wall found 2 unused variables in scm_pid.c:

scm_pidfd.c: In function =E2=80=98parse_cmsg=E2=80=99:
scm_pidfd.c:140:13: warning: unused variable =E2=80=98data=E2=80=99 [-Wunus=
ed-variable]
  140 |         int data =3D 0;
      |             ^~~~
scm_pidfd.c: In function =E2=80=98cmsg_check_dead=E2=80=99:
scm_pidfd.c:246:15: warning: unused variable =E2=80=98client_pid=E2=80=99 [=
-Wunused-variable]
  246 |         pid_t client_pid;
      |               ^~~~~~~~~~

Let's remove these variables.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testin=
g/selftests/net/af_unix/scm_pidfd.c
index 37e034874034..ef2921988e5f 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -137,7 +137,6 @@ struct cmsg_data {
 static int parse_cmsg(struct msghdr *msg, struct cmsg_data *res)
 {
 	struct cmsghdr *cmsg;
-	int data =3D 0;
=20
 	if (msg->msg_flags & (MSG_TRUNC | MSG_CTRUNC)) {
 		log_err("recvmsg: truncated");
@@ -243,7 +242,6 @@ static int cmsg_check_dead(int fd, int expected_pid)
 	int data =3D 0;
 	char control[CMSG_SPACE(sizeof(struct ucred)) +
 		     CMSG_SPACE(sizeof(int))] =3D { 0 };
-	pid_t client_pid;
 	struct pidfd_info info =3D {
 		.mask =3D PIDFD_INFO_EXIT,
 	};
--=20
2.51.0.rc0.155.g4a0f42376b-goog


