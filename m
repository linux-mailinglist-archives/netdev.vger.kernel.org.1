Return-Path: <netdev+bounces-224163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B5CB8160D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130BC467F01
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E98301472;
	Wed, 17 Sep 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGYvRdc+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7C3009ED
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134590; cv=none; b=P0cg2H3ZYUVxeVrxnbSKCkCj1ucHh7xY7NCTryWTnyGystCp2KTXw2XtoQqqcK9K+ZoDeJjkR7TGHcxptPS8yQ5cGss2ChK7tUZd7MZNX5QEnTCDVL7se45gxZh+WMzGNczsttnkPXUjBdYqSUMBxvpACZj/cGP3O/8wLlOFmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134590; c=relaxed/simple;
	bh=CO4Z2qhPiwjLUf9m3lqbizWU30ePe61aVaBOg25eiMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BgZ2oE8EvVTjdmfR52GVU0Rb6HKmQUWd9tAsGI3NqlzvyP/b1L6gwkFd/ZZSWYZQgfCA7544nqBoCm7jsgPugV3zNv3nV+97X/st+zo7oqrLz1h8WQ889Yt+3uIlH/3TmezDmFZWSrFWJkugdiXmcklzJg2hw2pcTziiY9STpkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGYvRdc+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso75511a91.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758134588; x=1758739388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnn/1bPiYFjxxZYlOzXb5RYuvwtgWrVEsfiGmhllIQo=;
        b=sGYvRdc+YWl84CmgSZrFAC3hS4eT0Hty11FN90X+i3gwgs50vKoUjw5yzIQt2XEp8M
         eZ/PCl/LC/0L4P5jFiD4DzXs6pIvDb9i7yrqLTCqyhUO3TzFhUTZIgBqUQwlqYsn23Z8
         eIXrFm3CuILGZW1gEDte9DGdq+wPYz4L8o3pfgTkUZpWT+4p4FLngM34P/FIS2vF1QQg
         ZhE2TZ4XvZTDA7i5V5tmjb4mScsB4SIplKw3+EhURzQOLniiPK57TGqmjJGvcE1xYwdU
         Sc4SHbQvq48cJ1/4GXWRQh2Xzr/gRNsn2/oyMT7Lza4Qk5Yr7cc6hi/qJ8y4XHcCv0oR
         uG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758134588; x=1758739388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnn/1bPiYFjxxZYlOzXb5RYuvwtgWrVEsfiGmhllIQo=;
        b=wWKISdxff3sETQHCoLg1GpLzAjwfXgGRHXSefSXTDBxk0Hwu5nDRVFimcIUM9x0SS6
         VqIKNjxPC9Ss4u66L6bJjW/wG1bUPAEhMQNjBDipQC0Zh5eQ5YhctxvtO1CFpu6auuoh
         9pyg7f5jT6PT3/1sSb9NhPNsAovfKWakpPeEUd0gpnc1DSZ/fzK9vX8DN08jC/hAATZ7
         cNt3BcNjzh2E3DK9izypfGSB3MN7KnC3OWcaqT89kUkiN5/VenJY9tLHA4T9gkDR2qsW
         pivf9hu9IY3jGlBjWdY4hwue/0UrWLMF3GvPhvBY2DrZSgXJcclOwMmuaOxWL58MNvDi
         gfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvlZJv1s5KFk3T0BNhadx76DA+G/YLkSrT6g6G0eTxeVT0b9o1i60XPP4IdESgE1h88ACNBfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFiZOVdeOMCTswwvU9OHKPV2Wpg7b4XSaFQTuwkOVerNbSHPP
	n+1E6jGI6xAbfXG5YRedOu0q9RsRNo3v76gyt/CrcZGOuDR7HvfFtDUKt6DA8g8v8h8F/H0Goak
	d0rYX2Q==
X-Google-Smtp-Source: AGHT+IEhGNWjJW1GJ5MpbhHOgHkB45XQY9aZPy3HjmU7BORBjFIa87Gpe9fvclpNk85p/3LCUAJSkOe2WNw=
X-Received: from pjbpb7.prod.google.com ([2002:a17:90b:3c07:b0:32e:8c6a:e6fd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3902:b0:32d:ea1c:a4e5
 with SMTP id 98e67ed59e1d1-32ee3eee5a0mr3788820a91.1.1758134588448; Wed, 17
 Sep 2025 11:43:08 -0700 (PDT)
Date: Wed, 17 Sep 2025 18:42:58 +0000
In-Reply-To: <d994dd8855c3977190b23acbe643c536deb3af71.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <d994dd8855c3977190b23acbe643c536deb3af71.camel@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917184307.999737-1-kuniyu@google.com>
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
Date: Wed, 17 Sep 2025 09:40:22 -0500
> > Could you test it with this diff and see if 2 or 3 splats are logged
> > in dmesg ?  and in that case, please share the stack traces.
> > 
> > I expect this won't trigger the black screen and you can check dmesg
> > after resume.
> > 
> > Thanks!
> > 
> > 
> Good morning/afternoon. Applied this patch to the latest mainline, but
> still see the black screen upon trying to resume after suspend. The
> keyboard looks to be unresponsive, as trying to switch to a tty
> terminal or back doesn't result in anything happening(as well as
> numlock/caps not being responsive either). I also tried using the power
> button, as well as closing/reopening the laptop lid to see if I could
> trigger resume. 
> 
> Checked the systemd journal just in case, but no splats or anything
> else is recorded after the suspend. Finally, attempted following dmesg
> with -Wh to a text file before suspending, but that also doesn't record
> any new input after the suspend.

Thanks for testing the painful scenario.

Could you apply this on top of the previous diff and give it
another shot ?

I think the application hit a race similar to one in 43fb2b30eea7.

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6d7c110814ff..b6ff7ad0443a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -815,7 +815,8 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 static bool unix_may_passcred(const struct sock *sk)
 {
-	return sk->sk_scm_credentials || sk->sk_scm_pidfd;
+	WARN_ON_ONCE(!sk->sk_scm_credentials && sk->sk_scm_parent_cred);
+	return sk->sk_scm_credentials || sk->sk_scm_pidfd || sk->sk_scm_parent_cred;
 }
 
 static int unix_listen(struct socket *sock, int backlog)
---8<---

