Return-Path: <netdev+bounces-212625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D429B217B2
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C832A65BC
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F942E4252;
	Mon, 11 Aug 2025 21:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1DBmvASQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C3A2E3B17
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949282; cv=none; b=csIuBlGAyFkmeJNfycT34rNcu0E4ZQck43t3GKeaiv0ihSwDBOcBQD1Y10XojqE9QahdFlHafjfyVzzCouAB9Qm/dXUY7vHcxIaqCca15cFMIX/CTdEXZpEtkZ1Fpy9BrC3EqcwYQ7UEPsWp+2ohC+cFP7lmN/3vBOkGd6zMyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949282; c=relaxed/simple;
	bh=9E7WH4oojX5gCg5QWwxNhHMWr12V678CQ1mYgNvxBo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aKkQqAXO9njfZwlNA/yn6eUllCY1qiuULn0gyfA4VyoRmrh1m3l0CF08JpNoDhPFvuxq/YkjhryExgzqlTLpZIA4F8tsaCWovLN69KJqeNklBO9JwScNyPAXxzR423J7Wg+tCCwy36V14WMkzm2YqiBODJxoV41Pxiy+U7RpSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1DBmvASQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso4876350b3a.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754949280; x=1755554080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmHAHJMf+EAk9F2bHc4tYoVCFG4R/bvljNAft/e60iU=;
        b=1DBmvASQDZClQZ76Ku4eN2Fc21JIPFkTISKb7zUdd38zf1j79lzHnrB+5kDcghC/ha
         mua70eRBIWHRCIBoNEURhi98elPo79AsVW/yqkyngskLFFOV+h46/veH2CteXmfUVNie
         3pS5a7u1OwiCS1LnSTKQls6aUhvAof63g9XqXPjpbPrYTAbMRgesSwoBjBPvUFLCTUKZ
         OlcnlcjP2R/PWm/6zt7Q7+A81S8D9zRj8hB5bp40HxdmN0wI9CvUSy8C51tUi6ldFubA
         C1LnORLN+TA+P7mJirwwvIa0JVTK5xaAYQ5OBpiJXfEU44AmSerunnJRqpSi59w2tddR
         miiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949280; x=1755554080;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UmHAHJMf+EAk9F2bHc4tYoVCFG4R/bvljNAft/e60iU=;
        b=PY4ZOTZY6oc1XE2w/9u+f8ngTpSvg/5RxEim0ZYJMKiiUFTVBkaUDG1U2ld5Okd7hK
         8NE8G87IDacNXPPZOQ9wQ23FGwBHb1TTZcSwhqSU1yMTfiAsBAJLO6lw9iiOeqmlf9iL
         UXmpuBoE9IBe4VIERZhLTGg+d47d/45eQTakEpk3Mf9gE6rPYw8Vhqo/faZLEtkakr2H
         B7cFu+2tAvVviFfcIGpJE31OTj/XhbJDBcQxCUcbx8ZxV59+X0KhUG+psgOXVla1S+so
         jOSo80eYCKDm4lt1G8I+QwwN6tuL+XbICttrtDMypI0Xj7WaZwT171XRfEAdEIfNfI8Z
         ueyw==
X-Forwarded-Encrypted: i=1; AJvYcCVEasoRcOqmD38PecwjwmSowDjeNBXvibgklHifXn5TvM+WxkugbJ/Sestc+dXj+FwrHa9GQsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yT2qUS1l3k+Wfk8HuyZJsstkIUz7VDGLq8l+M0soOIQ/79IK
	FLNdE6oC6XELh43WF2JPeeYfMjuRYZcJgVhvOg7qAMgg9y5Y05JJrmGoH7kyFEcEJGPpDJTbF/g
	FimL0bA==
X-Google-Smtp-Source: AGHT+IEkvlYxSba976NsPTCDPQaa9gAIBOXAKfonBBbCzpedkHNOPT9W/mN4FfFlP/jZkGSODmgP877KJTo=
X-Received: from pftb26.prod.google.com ([2002:a05:6a00:2da:b0:746:18ec:d11a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f87:b0:76b:f8bc:a3a9
 with SMTP id d2e1a72fcca58-76c460fe7d3mr19825467b3a.9.1754949279896; Mon, 11
 Aug 2025 14:54:39 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:53:06 +0000
In-Reply-To: <20250811215432.3379570-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811215432.3379570-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811215432.3379570-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/4] selftest: af_unix: Silence
 -Wflex-array-member-not-at-end warning for scm_rights.c.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

scm_rights.c has no problem in functionality, but when compiled with
-Wflex-array-member-not-at-end, it shows this warning:

scm_rights.c: In function =E2=80=98__send_fd=E2=80=99:
scm_rights.c:275:32: warning: structure containing a flexible array member =
is not at the end of another structure [-Wflex-array-member-not-at-end]
  275 |                 struct cmsghdr cmsghdr;
      |                                ^~~~~~~

Let's silence it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../selftests/net/af_unix/scm_rights.c        | 28 +++++++++----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testi=
ng/selftests/net/af_unix/scm_rights.c
index 8b015f16c03d..914f99d153ce 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -271,20 +271,11 @@ void __send_fd(struct __test_metadata *_metadata,
 {
 #define MSG "x"
 #define MSGLEN 1
-	struct {
-		struct cmsghdr cmsghdr;
-		int fd[2];
-	} cmsg =3D {
-		.cmsghdr =3D {
-			.cmsg_len =3D CMSG_LEN(sizeof(cmsg.fd)),
-			.cmsg_level =3D SOL_SOCKET,
-			.cmsg_type =3D SCM_RIGHTS,
-		},
-		.fd =3D {
-			self->fd[inflight * 2],
-			self->fd[inflight * 2],
-		},
+	int fds[2] =3D {
+		self->fd[inflight * 2],
+		self->fd[inflight * 2],
 	};
+	char cmsg_buf[CMSG_SPACE(sizeof(fds))];
 	struct iovec iov =3D {
 		.iov_base =3D MSG,
 		.iov_len =3D MSGLEN,
@@ -294,11 +285,18 @@ void __send_fd(struct __test_metadata *_metadata,
 		.msg_namelen =3D 0,
 		.msg_iov =3D &iov,
 		.msg_iovlen =3D 1,
-		.msg_control =3D &cmsg,
-		.msg_controllen =3D CMSG_SPACE(sizeof(cmsg.fd)),
+		.msg_control =3D cmsg_buf,
+		.msg_controllen =3D sizeof(cmsg_buf),
 	};
+	struct cmsghdr *cmsg;
 	int ret;
=20
+	cmsg =3D CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level =3D SOL_SOCKET;
+	cmsg->cmsg_type =3D SCM_RIGHTS;
+	cmsg->cmsg_len =3D CMSG_LEN(sizeof(fds));
+	memcpy(CMSG_DATA(cmsg), fds, sizeof(fds));
+
 	ret =3D sendmsg(self->fd[receiver * 2 + 1], &msg, variant->flags);
=20
 	if (variant->disabled) {
--=20
2.51.0.rc0.155.g4a0f42376b-goog


