Return-Path: <netdev+bounces-224956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CBBB8BE6B
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 05:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2597A06E1D
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 03:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F24214A97;
	Sat, 20 Sep 2025 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cSkPCHnj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF97081A
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758340309; cv=none; b=st+S6Gz0noLTR7actNyGdXAqSxu4pLZizZmOS+X+69iVNkXlMWDhszi+eVLwIW13r3tmnGYo06F0g6OcFSumKYJqZdZS4/VlEb2PweKK3DKFyStJxs9IKaMqUOJx5DRaDqb4saHTPg1U7zLCGM9TG3vRwUh0EChUs7idhXBFyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758340309; c=relaxed/simple;
	bh=4nyax13VUWR5a5t0mPW0ffDF7ObllscDnqllciX7WU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SG13yXiWde3kyr8Pd5EosDadAfzLWH9IN5hsiJtOZD6gtewlQ2CDdOCAsVLPYooo5mrA/FIfIaZOFwgAwYLZRWinZvPCI4QdMpgypdLDmG9zOFoBHtiltL6qpqwrr6Po/Pn2TiQ8eenSLsw+8R9qffu7heR8XLDVVhUyg4H7PDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cSkPCHnj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so2566808a91.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758340308; x=1758945108; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpEOj5LSM2D4OpUTxa8SKWTebNuWvFU+5fQLpVHxJlM=;
        b=cSkPCHnjl24X4A4YLQJG4lU8WmWhITSpFUiWyWGqVPmR5352NiMa/3r32lN5fyLMcy
         rijwqkTFuFmhTB555IeY5QJMwc90rY0b1GC6ZP9Di692OUqYXqIlR8ryz3CPnJ/bEnv0
         HMiXwIQqPCdxLaJ8lLxCSOr3lR7H7MdDGOcKQLD25JlRfO4p9puHyVg1Ncy51QLl4cAF
         CXwx5RgHADOMlSuZjRyjVnJk2EjKLWp8TDbrtNwBV/n1xTjqzaT+NQtfI34Kfse0LklO
         mGgFZeo527G520gzPYak5MM1UZ0qc6v86Vs5PL1qEIlBcp4rfMpXsO+8srLFCzw1Alk4
         wCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758340308; x=1758945108;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpEOj5LSM2D4OpUTxa8SKWTebNuWvFU+5fQLpVHxJlM=;
        b=FIicWsx4UWXnWQGwfwXy58EO0nXptyWTFXLosCmvkioJoVE4fT2X4AVyZLOa4dta7E
         BHdMyVKuEGUkY2U9L/6J640Qy+DwGCU1jvOz9PYjiEhGLO9mH5DRJ3fec5QOqkjFvPAf
         DKYqZLUL5PAGBf/FSqFWWzx8n951/2rhfzdSg29IM48CPx3C3UKS8gBDaoJfMabs1zOP
         WtJKRmdtRn9tQELS+xR0e5QZ6kMoEknBYWzID+iDghQVOchXFsDPa5pUIdSHumWLNhLu
         4Nu7NM97/E6uh1BvuuayzwHfAEjTRR7pp3tpwEDgY7fAKIfFr4ALZP4CNlT+jjtoJO8s
         HXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Lf2w2ySvNIzYRJu76oKD2b0SFokoZuGHL/zyTY0raUe7ud3F5GeDWbsmoPOPypg7eHfGyD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSAl1VeTMFhWsB1whtkGbOTO70c7SHQfTu0vC1R2wzIZgdsh8
	Cww01kA/1gynxUMRQpZlBE7SbDj27xiKBgLMzUTmJniT1TPQpn5ILe++HYe4M+KqBeK/oy7QYvP
	Skh0I2w==
X-Google-Smtp-Source: AGHT+IGDEsmJS0RWHAZl4i+dA/zrRM6jZJwlfPLgPe6OetInXPKDxFrf8pBdb+Fr9jhrRctW5rKl2lRcuTw=
X-Received: from pjbta12.prod.google.com ([2002:a17:90b:4ecc:b0:329:ccdd:e725])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3146:b0:330:604a:1009
 with SMTP id 98e67ed59e1d1-3309834c31fmr7114857a91.23.1758340307754; Fri, 19
 Sep 2025 20:51:47 -0700 (PDT)
Date: Sat, 20 Sep 2025 03:50:43 +0000
In-Reply-To: <caa08e5b15bc35b9f3c24f679c62ded1e8e58925.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <caa08e5b15bc35b9f3c24f679c62ded1e8e58925.camel@gmail.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250920035146.2149127-1-kuniyu@google.com>
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
From: Kuniyuki Iwashima <kuniyu@google.com>
To: brian.scott.sampson@gmail.com
Cc: christian@heusel.eu, davem@davemloft.net, difrost.kernel@gmail.com, 
	dnaim@cachyos.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	kuni1840@gmail.com, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	mario.limonciello@amd.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: brian.scott.sampson@gmail.com
Date: Wed, 17 Sep 2025 15:25:07 -0500
> > Thanks for testing the painful scenario.
> > 
> > Could you apply this on top of the previous diff and give it
> > another shot ?
> > 
> > I think the application hit a race similar to one in 43fb2b30eea7.
> Just tested again with latest mainline, but no change. Once suspended,
> keyboard becomes inactive and no longer accepts any input, so no way to
> switch to tty to view dmesg. The only way to move forward after
> suspending is holding down power to hard shutdown, then power back on.
> I tried enabling persistence in the systemd journal, then checking
> journalctl -k -b -1, but nothing is recorded from dmesg after the
> suspend.

Thank you for your patience.

I assumed SO_PASSCRED was the problem, but I missed
SO_PASSCRED was also inherited durint accept().

Could you apply this on top of the previous changes ?

Also, could you tell what desktop manager and distro
you are using ?  If this attempt fails, I'll try to
reproduce with the same version on my desktop.

---8<---
diff --git a/include/net/sock.h b/include/net/sock.h
index 211084602e01..b61d4fdb7fc4 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -541,7 +541,8 @@ struct sock {
 				sk_scm_rights : 1,
 				sk_scm_embryo_cred: 1,
 				sk_scm_parent_cred: 1,
-				sk_scm_unused : 2;
+				sk_scm_parent_sec: 1,
+				sk_scm_unused : 1;
 		};
 	};
 	u8			sk_clockid;
diff --git a/net/core/scm.c b/net/core/scm.c
index e603bf5400e0..359d56d454b4 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -435,7 +435,8 @@ static void scm_passec(struct sock *sk, struct msghdr *msg, struct scm_cookie *s
 	struct lsm_context ctx;
 	int err;
 
-	if (sk->sk_scm_security) {
+	if (sk->sk_scm_security || sk->sk_scm_parent_sec) {
+		WARN_ON_ONCE(!sk->sk_scm_security);
 		err = security_secid_to_secctx(scm->secid, &ctx);
 
 		if (err >= 0) {
@@ -449,7 +450,7 @@ static void scm_passec(struct sock *sk, struct msghdr *msg, struct scm_cookie *s
 
 static bool scm_has_secdata(struct sock *sk)
 {
-	return sk->sk_scm_security;
+	return sk->sk_scm_security || sk->sk_scm_parent_sec;
 }
 #else
 static void scm_passec(struct sock *sk, struct msghdr *msg, struct scm_cookie *scm)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b6ff7ad0443a..a35082269990 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1899,6 +1899,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	unix_update_edges(unix_sk(tsk));
 	newsock->state = SS_CONNECTED;
 	tsk->sk_scm_parent_cred = sk->sk_scm_credentials;
+	tsk->sk_scm_parent_sec = sk->sk_scm_security;
 	sock_graft(tsk, newsock);
 	unix_state_unlock(tsk);
 	return 0;
---8<---

